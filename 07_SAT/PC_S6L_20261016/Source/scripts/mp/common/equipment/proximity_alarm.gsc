// scripts\mp\common\equipment\proximity_alarm.gsc  (hash_7e08b74a0a0053c0.gscc) (size: 17671 Bytes / 0x4507 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf5c0129d (4123005597)
// size ...... 17671 (0x4507)
// includes .. 26  (offset: 0x42df)
// strings ... 22  (offset: 0x43af)
// dev strs .. 1   (offset: 0x44fb)
// exports ... 36  (offset: 0x2b87)
// cseg ...... 0x21b + 0x296c (0x2b87)
// imports ... 149 (offset: 0x3127)
// animtree1 . 0   (offset: 0x4507)
// animtree2 . 0   (offset: 0x4507)
#using script_16ea1b94f0f381b3;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\equipment_interact;
#using scripts\mp\gamelogic;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rank;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace proximity_alarm;

// Namespace proximity_alarm
// Params 0, eflags: 0x1
// Checksum 0xba6bd3f8, Offset: 0x239
// Size: 0xd9
function autoexec main()
{
    utility::flag_wait( "equipment_initialized" );
    level callback::add( #"player_spawned", &proximity_alarm_on_player_spawned );
    level callback::add( #"player_laststand", &proximity_alarm_on_player_laststand );
    level callback::add( #"hash_244314ef9125e636", &proximity_alarm_on_player_death );
    weapons::function_345fed126ca0b41d( "proximity_alarm", &proximity_alarm_destroy );
    weapons::registerusedcallback( "proximity_alarm", &proximity_alarm_used );
    equipment_mp::registercallback( "equip_proximity_alarm", "onOwnerChanged", &proximity_alarm_onownerchanged );
    thread utility::callsharedfunc( #"analytics", #"hash_eb9d0dae8f38111f", { #customhit:1, #equipref:"equip_proximity_alarm" } );
    utility::registersharedfunc( #"prox_alarm", #"hack", &hack );
}

// Namespace proximity_alarm
// Params 2, eflags: 0x4
// Checksum 0x1d887842, Offset: 0x31a
// Size: 0x74
function private hack( hackeffect, attacker )
{
    if ( !hackeffect.var_30e7de3d76d5a085 )
    {
        return;
    }
    
    self.owner thread equipment_utility::function_364a1a0e0c018518( self.equipmentref, #"stolen_hacked" );
    equipment_mp::hackequipment( attacker, hackeffect.var_fe6111ff085b2063 );
    self setscriptablepartstate( #"hacked", #"active", 0 );
}

// Namespace proximity_alarm
// Params 1
// Checksum 0xa623c679, Offset: 0x396
// Size: 0x2ac
function proximity_alarm_used( grenade )
{
    grenade endon( #"death" );
    
    if ( !isdefined( self.var_ea6cbc6058faff89 ) )
    {
        self.var_ea6cbc6058faff89 = [];
    }
    
    if ( !isdefined( self.var_3d621f40a39d8966 ) )
    {
        self.var_3d621f40a39d8966 = [];
    }
    
    for ( i = 0; i < 3 ; i++ )
    {
        status = self getclientomnvar( "ui_proximity_alarm_status_" + i );
        
        if ( status == 0 )
        {
            self setclientomnvar( "ui_proximity_alarm_status_" + i, 1 );
            self.var_ea6cbc6058faff89[ grenade getentitynumber() ] = i;
            break;
        }
    }
    
    ref = equipment_mp::function_fdc4a655fbde0dec( grenade.weapon_name );
    grenade.tableinfo = weapon::getequipmenttableinfo( ref );
    weapons::onequipmentplanted( grenade, "equip_proximity_alarm", &proximity_alarm_destroy );
    
    if ( !isdefined( grenade.tableinfo.bundle ) )
    {
        assertmsg( "<dev string:x24>" );
    }
    
    if ( utility::issharedfuncdefined( #"jamming_system", #"hash_ca0042e3cac99672" ) )
    {
        grenade [[ utility::getsharedfunc( #"jamming_system", #"hash_ca0042e3cac99672" ) ]]( grenade );
    }
    
    if ( !isdefined( self.proximity_alarms ) )
    {
        self.proximity_alarms = [];
        callback::add( "onPlayerSpawn_destroyEquipment", &function_d3982679953cfd53 );
    }
    
    if ( !isdefined( grenade.usedcount ) )
    {
        grenade.usedcount = 0;
    }
    
    self.proximity_alarms[ self.proximity_alarms.size ] = grenade;
    grenade thread function_8831b35693d001cb( 0.05 );
    stuckdata = grenade function_e32823b6349a2dd6();
    wait grenade.tableinfo.bundle.var_78d8c2c1c9d8d6c0;
    
    if ( !isdefined( self ) )
    {
        grenade thread proximity_alarm_destroy();
        return;
    }
    
    grenade sentientpoolmanager::registersentient( "Tactical_Static", grenade.owner );
    grenade namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( grenade, &proximity_alarm_emp_applied );
    grenade.var_30656af96b2ac2a4 = [];
    grenade.add_buff = &add_buff;
    grenade.remove_buff = &remove_buff;
    grenade thread equipment_interact::remoteinteractsetup( &proximity_alarm_destroy, 0, 1 );
    grenade thread damage::monitordamage( 1, "hitequip", &proximity_alarm_handlefataldamage, undefined );
    grenade thread function_958d0cd541bd27c0();
    grenade thread function_b001f085d1f9c59();
    grenade thread function_93b885ae5bf2baef();
    grenade.headiconid = entityheadicons::setheadicon_equipment( grenade );
    utility::function_969f9f5596dba07a( grenade, &proximity_alarm_destroy );
}

// Namespace proximity_alarm
// Params 1
// Checksum 0xc6a651ac, Offset: 0x64a
// Size: 0x35
function function_8831b35693d001cb( delaytime )
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

// Namespace proximity_alarm
// Params 2
// Checksum 0x281a472d, Offset: 0x687
// Size: 0x13f
function function_381468fbd43c5b0c( minimapicon, alarmradius )
{
    objectid = objidpoolmanager::requestobjectiveid( 1 );
    objidpoolmanager::objective_add_objective( objectid, "invisible", self.origin, minimapicon );
    objidpoolmanager::function_e4d6a71507372662( objectid, 0 );
    objective_setminimapiconsize( objectid, "icon_medium" );
    objidpoolmanager::objective_mask_showtoplayerteam( objectid, self.owner );
    objective_setbackground( objectid, 1 );
    objective_setplayintro( objectid, 0 );
    objective_onentity( objectid, self );
    objective_settint( objectid, 255, 230, 7 );
    function_ac9886e0e2860e18( objectid, 20000, 15000 );
    function_3759e26b1b750f5( objectid, function_1e200dd4c96f2c6b() );
    objective_disableping( objectid, 1 );
    
    if ( !isdefined( self.ownercircle ) )
    {
        self.ownercircle = {};
    }
    
    if ( !isdefined( self.allycircle ) )
    {
        self.allycircle = {};
    }
    
    self.allycircle game_utility::questcircle_create( "ProximityAlarmFriendly", self.origin, alarmradius );
    self.allycircle game_utility::questcircle_hidefromall();
    self.ownercircle game_utility::questcircle_create( "ProximityAlarmEnemy", self.origin, alarmradius );
    self.ownercircle game_utility::questcircle_hidefromall();
    return objectid;
}

// Namespace proximity_alarm
// Params 2
// Checksum 0x7b65a787, Offset: 0x7cf
// Size: 0x2f
function function_40f4d21225eb8b6( player, triggeringent )
{
    if ( isai( player ) )
    {
        player getenemyinfo( triggeringent, self.origin );
    }
}

// Namespace proximity_alarm
// Params 0
// Checksum 0x23d55b8c, Offset: 0x806
// Size: 0x614
function function_958d0cd541bd27c0()
{
    self endon( #"death" );
    bundle = self.tableinfo.bundle;
    alarmradius = bundle.proximity_alarm_radius ?? 50;
    alarmheight = bundle.proximity_alarm_height ?? 100;
    var_985ce8f3061dd18f = bundle.proximity_alarm_angle ?? 100;
    var_7448894cd4470a0 = bundle.var_cbba862ad55c4ed4 ?? 45;
    var_2318f1c8d1611fab = math::degrees_to_radians( var_7448894cd4470a0 );
    var_b986e26ad42ed40 = bundle.var_cbb8a188a47ae2f2 ?? 0;
    upvector = anglestoup( self.angles );
    forwardvector = anglestoforward( self.angles );
    minimapicon = bundle.minimapicon ?? "ui_icon_minimap_alarm";
    self.uiobjid = function_381468fbd43c5b0c( minimapicon, alarmradius );
    
    while ( true )
    {
        loopstarttime = gettime();
        
        if ( self.isjammed )
        {
            alarmduration = 0;
            self.pingduration = bundle.var_1ea00ea513e012f7 ?? 2;
            var_5ae39c2d019fa267 = undefined;
        }
        else
        {
            alarmduration = bundle.proximity_alarm_min_duration ?? 2;
            self.pingduration = bundle.var_887be2abc03da656 ?? 2;
            var_5ae39c2d019fa267 = function_cb89a40b21fa60a( alarmheight, alarmradius, var_985ce8f3061dd18f, forwardvector, upvector, var_2318f1c8d1611fab, var_b986e26ad42ed40 );
        }
        
        if ( isdefined( var_5ae39c2d019fa267 ) )
        {
            if ( !self.var_bd7bd9a9984578a4 )
            {
                self.var_bd7bd9a9984578a4 = 1;
                
                if ( !isdefined( self.var_69497665d1a4dfd9 ) )
                {
                    if ( isdefined( var_5ae39c2d019fa267.var_1c34a1ae16f45161[ self getentitynumber() ] ) )
                    {
                        if ( loopstarttime - var_5ae39c2d019fa267.var_1c34a1ae16f45161[ self getentitynumber() ] >= 3000 )
                        {
                            var_5ae39c2d019fa267.var_1c34a1ae16f45161[ self getentitynumber() ] = undefined;
                        }
                    }
                    
                    if ( !isdefined( var_5ae39c2d019fa267.var_1c34a1ae16f45161[ self getentitynumber() ] ) )
                    {
                        if ( isdefined( self.owner ) && isdefined( self.owner.var_3d621f40a39d8966 ) && self.owner player::isreallyalive() )
                        {
                            if ( self.owner.var_3d621f40a39d8966[ var_5ae39c2d019fa267 getentitynumber() ] == loopstarttime )
                            {
                                basepoints = rank::getscoreinfovalue( #"hash_fcebac49c58b0122" ) ?? 0;
                                finalpoints = self.var_d8d4ac6eb0fb08e7 ? self.var_d8d4ac6eb0fb08e7 * basepoints : basepoints;
                                self.owner thread points::doscoreevent( #"hash_fcebac49c58b0122", self.tableinfo.objweapon, finalpoints );
                                self.var_69497665d1a4dfd9 = 3000;
                                var_5ae39c2d019fa267.var_1c34a1ae16f45161[ self getentitynumber() ] = loopstarttime;
                                self.owner.var_3d621f40a39d8966[ var_5ae39c2d019fa267 getentitynumber() ] -= 1;
                                self.usedcount++;
                                challenges::function_3d7a169dbae062fb( "equip_proximity_alarm", self.owner, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" ) );
                            }
                        }
                    }
                }
            }
            
            self.alarmstarttime = loopstarttime;
            objective_state( self.uiobjid, "current" );
            function_e665541370a8d1ef( 1, var_5ae39c2d019fa267 );
            self setscriptablepartstate( #"alarm", #"active" );
            
            if ( isdefined( self.owner ) && isdefined( self.owner.var_ea6cbc6058faff89 ) && self.owner player::isreallyalive() )
            {
                index = self.owner.var_ea6cbc6058faff89[ self getentitynumber() ];
                
                if ( isdefined( index ) )
                {
                    self.owner setclientomnvar( "ui_proximity_alarm_status_" + index, 2 );
                }
            }
        }
        else
        {
            self.var_bd7bd9a9984578a4 = undefined;
            
            if ( isdefined( self.owner ) && !self.fadeout && utility::time_has_passed( self.alarmstarttime, self.pingduration ) )
            {
                fadetime = bundle.proximity_alarm_fade_time ?? 0;
                self.ownercircle game_utility::questcircle_fadeout( fadetime );
                self.fadeout = 1;
            }
            
            if ( self.fadeout && utility::time_has_passed( self.alarmstarttime, self.pingduration + fadetime ) )
            {
                objective_state( self.uiobjid, "invisible" );
                
                if ( isdefined( self.owner ) && self.owner player::isreallyalive() )
                {
                    self.ownercircle game_utility::function_12b83090e6a63b86();
                    self.ownercircle game_utility::questcircle_hidefromplayer( self.owner );
                    self.fadeout = 0;
                }
                
                function_e665541370a8d1ef( 0 );
            }
            
            if ( utility::time_has_passed( self.alarmstarttime, alarmduration ) )
            {
                self setscriptablepartstate( #"alarm", #"idle" );
                index = self.owner.var_ea6cbc6058faff89[ self getentitynumber() ];
                
                if ( isdefined( index ) && isdefined( self.owner ) )
                {
                    self.owner setclientomnvar( "ui_proximity_alarm_status_" + index, 1 );
                }
            }
        }
        
        waitframe();
        
        if ( isdefined( self.var_69497665d1a4dfd9 ) )
        {
            timedelta = gettime() - loopstarttime;
            self.var_69497665d1a4dfd9 -= timedelta;
            
            if ( self.var_69497665d1a4dfd9 <= 0 )
            {
                self.var_69497665d1a4dfd9 = undefined;
            }
        }
    }
}

// Namespace proximity_alarm
// Params 7
// Checksum 0xcfa4257, Offset: 0xe22
// Size: 0x54e
function function_cb89a40b21fa60a( alarmheight, alarmradius, var_985ce8f3061dd18f, forwardvector, upvector, var_2318f1c8d1611fab, var_b986e26ad42ed40 )
{
    var_daff95c6fc25deec = vectordot( upvector, ( 0, 0, 1 ) );
    isonfloor = abs( var_daff95c6fc25deec ) > var_2318f1c8d1611fab;
    anglecheck = !isonfloor && !var_b986e26ad42ed40;
    var_6511a540416498df = level.sharedfuncs[ #"perceptive" ][ #"incrementcount" ];
    var_7ac4550afe2c353 = level.sharedfuncs[ #"perceptive" ][ #"decrementcount" ];
    var_e27d32ef47f1c9ea = undefined;
    currtime = gettime();
    alarmentnum = self.entnum ?? utility::get_entity_number( self );
    
    if ( !isdefined( self.enemies_detected ) )
    {
        self.enemies_detected = [];
    }
    
    var_98affc41adf7e943 = arraycopy( self.enemies_detected );
    ents = utility::function_f754506ecfae9afb( self.origin, alarmradius, self.owner ?? undefined, alarmheight );
    
    foreach ( ent in ents )
    {
        var_eee3e9c4c75199be = 1;
        
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        if ( player_utility::isfriendly( self.team, ent ) )
        {
            continue;
        }
        
        if ( isdefined( ent.perks[ "specialty_lightfoot" ] ) )
        {
            continue;
        }
        
        if ( isdefined( ent.perks[ "specialty_ghost" ] ) )
        {
            var_eee3e9c4c75199be = 0;
            ent utility::callsharedfunc( #"perk", #"activatePerk", "specialty_ghost" );
        }
        
        if ( ent.var_ff102e941e8065c )
        {
            delayapplied = equipment_mp::function_84f2f5566ba29655( ent, ent.var_ff102e941e8065c, alarmradius, &function_48a1fba2880097f8 );
            
            if ( delayapplied )
            {
                continue;
            }
        }
        
        if ( ent ismeatshieldvictim() )
        {
            var_eee3e9c4c75199be = 0;
        }
        
        if ( ent.spawnprotection )
        {
            continue;
        }
        
        entposition = ent utility::function_f02ebab438642e16();
        var_b500af9bdb1cade8 = ent getentitynumber();
        
        if ( var_eee3e9c4c75199be && function_bccdf60ac2d583af( entposition, self.origin, alarmheight, alarmradius, upvector, forwardvector, anglecheck, var_985ce8f3061dd18f ) && proximity_alarm_canseetarget( ent ) )
        {
            if ( !self.enemies_detected[ var_b500af9bdb1cade8 ] )
            {
                thread utility::callsharedfunc( #"analytics", #"hash_c7076e2f7f3569a0", { #victim:ent, #attacker:self.owner, #grenade:self } );
            }
            
            self.enemies_detected[ var_b500af9bdb1cade8 ] = ent;
            
            if ( !isdefined( var_e27d32ef47f1c9ea ) )
            {
                var_e27d32ef47f1c9ea = ent;
            }
            
            ent.var_1a28d2aca55547f9[ self.owner.team ] = gettime();
            
            if ( isdefined( var_98affc41adf7e943[ var_b500af9bdb1cade8 ] ) )
            {
                var_98affc41adf7e943[ var_b500af9bdb1cade8 ] = undefined;
            }
            
            if ( self.bundle.var_e000a9bf54d9e5aa )
            {
                function_5fcbc8e502e5e6e9( ent );
            }
            
            if ( isdefined( self.owner ) && isdefined( self.owner.var_3d621f40a39d8966 ) )
            {
                if ( !isdefined( self.owner.var_3d621f40a39d8966[ var_b500af9bdb1cade8 ] ) )
                {
                    self.owner.var_3d621f40a39d8966[ var_b500af9bdb1cade8 ] = currtime;
                }
            }
            
            if ( !isdefined( ent.var_31d3aa921f75646d[ alarmentnum ] ) )
            {
                ent.var_31d3aa921f75646d[ alarmentnum ] = self;
                ent notify( #"proximity_alarm_triggered" );
                
                if ( isdefined( var_6511a540416498df ) )
                {
                    ent [[ var_6511a540416498df ]]( alarmentnum );
                }
            }
        }
    }
    
    foreach ( entnum, ent in var_98affc41adf7e943 )
    {
        if ( isdefined( self.enemies_detected[ entnum ] ) )
        {
            if ( self.bundle.var_e000a9bf54d9e5aa )
            {
                function_3c80fa3b48b4c1dc( ent );
            }
            
            self.enemies_detected[ entnum ] = undefined;
        }
        
        if ( isdefined( ent.var_31d3aa921f75646d[ alarmentnum ] ) )
        {
            ent.var_31d3aa921f75646d[ alarmentnum ] = undefined;
            ent notify( #"hash_109a6ce8719e9377" );
            
            if ( isdefined( var_7ac4550afe2c353 ) && isdefined( self ) )
            {
                ent [[ var_7ac4550afe2c353 ]]( alarmentnum );
            }
        }
        
        if ( isdefined( self.owner ) && isdefined( self.owner.var_3d621f40a39d8966[ entnum ] ) )
        {
            self.owner.var_3d621f40a39d8966[ entnum ] = undefined;
        }
    }
    
    return var_e27d32ef47f1c9ea;
}

// Namespace proximity_alarm
// Params 2
// Checksum 0xc03b9130, Offset: 0x1379
// Size: 0xf6
function function_e665541370a8d1ef( showtoplayers, var_b075bf5fecbc413 )
{
    foreach ( player in teams::getfriendlyplayers( self.team ) )
    {
        if ( !isdefined( player ) || !player player::isreallyalive() )
        {
            continue;
        }
        
        circle = player === self.owner ? self.ownercircle : self.allycircle;
        
        if ( showtoplayers )
        {
            circle game_utility::questcircle_showtoplayer( player );
            function_40f4d21225eb8b6( player, var_b075bf5fecbc413 );
            continue;
        }
        
        circle game_utility::questcircle_hidefromplayer( player );
    }
}

// Namespace proximity_alarm
// Params 1
// Checksum 0x403471bc, Offset: 0x1477
// Size: 0x5a
function proximity_alarm_emp_applied( data )
{
    if ( player_utility::playersareenemies( self.owner, data.attacker ) )
    {
        data.attacker equipment_mp::function_ada7da3083a6c593( self );
    }
    
    self notify( #"enemy_destroyed_equipment", data.attacker );
    thread proximity_alarm_destroy();
}

// Namespace proximity_alarm
// Params 1
// Checksum 0x146b38c, Offset: 0x14d9
// Size: 0x1f2
function add_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        self.var_30656af96b2ac2a4[ self.var_30656af96b2ac2a4.size ] = params.combatlink;
        
        if ( !self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] )
        {
            basepoints = rank::getscoreinfovalue( #"hash_7b3268716b13eeec" ) ?? 0;
            params.combatlink.owner thread points::doscoreevent( #"hash_7b3268716b13eeec", params.combatlink.weapon_object, basepoints * params.combatlink.var_352099d9d2836866 );
            
            if ( !isdefined( self.var_2695e71ddf32816c ) )
            {
                self.var_2695e71ddf32816c = [];
            }
            
            self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] = 1;
        }
        
        if ( params.combatlink.owner != self.owner && !self.var_2b2f786d6b12c032 )
        {
            self.owner thread points::doscoreevent( #"hash_25e1629f3588e56f", params.combatlink.weapon_object );
            self.var_2b2f786d6b12c032 = 1;
        }
        
        if ( self.var_30656af96b2ac2a4.size == 1 )
        {
            if ( isdefined( self.headiconid ) && isdefined( self.bundle.buffedheadicon ) )
            {
                setheadiconimage( self.headiconid, self.bundle.buffedheadicon, 1 );
            }
            
            self.var_d8d4ac6eb0fb08e7 = params.bundle.var_d8d4ac6eb0fb08e7 ?? undefined;
        }
    }
}

// Namespace proximity_alarm
// Params 1
// Checksum 0x38ec6891, Offset: 0x16d3
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
                if ( isdefined( self.headiconid ) && isdefined( level.gamemodebundle.var_b96d2dfbabc4742d ) )
                {
                    setheadiconimage( self.headiconid, level.gamemodebundle.var_b96d2dfbabc4742d, 1 );
                }
                
                self.var_d8d4ac6eb0fb08e7 = undefined;
            }
        }
    }
}

// Namespace proximity_alarm
// Params 1
// Checksum 0xf0f1873d, Offset: 0x1793
// Size: 0xc1
function function_d3982679953cfd53( params )
{
    if ( isdefined( self.proximity_alarms ) )
    {
        foreach ( proximity_alarm in self.proximity_alarms )
        {
            if ( isdefined( proximity_alarm.team ) && player_utility::isfriendly( proximity_alarm.team, self ) )
            {
                proximity_alarm thread proximity_alarm_destroy();
            }
        }
        
        self.proximity_alarms = [];
    }
}

// Namespace proximity_alarm
// Params 0
// Checksum 0xb343e574, Offset: 0x185c
// Size: 0x2a
function function_93b885ae5bf2baef()
{
    self endon( #"death" );
    self.owner waittill( #"disconnect" );
    thread proximity_alarm_destroy();
}

// Namespace proximity_alarm
// Params 0
// Checksum 0x33104271, Offset: 0x188e
// Size: 0x27
function function_b001f085d1f9c59()
{
    self endon( #"death" );
    level utility::waittill_any( "game_ended", "bro_shot_start" );
    thread proximity_alarm_destroy();
}

// Namespace proximity_alarm
// Params 0
// Checksum 0xe88a68fc, Offset: 0x18bd
// Size: 0x4d2
function proximity_alarm_destroy()
{
    if ( self.destroyed )
    {
        return;
    }
    
    equipment_interact::function_d5794740325fbfd4();
    self.destroyed = 1;
    self setscriptablepartstate( #"destroy", #"active", 0 );
    self notify( #"death" );
    var_98affc41adf7e943 = [];
    
    if ( isdefined( self.owner ) && isdefined( self.owner.var_3d621f40a39d8966 ) )
    {
        foreach ( key, value in self.owner.var_3d621f40a39d8966 )
        {
            ent = getentbynum( key );
            
            if ( !isdefined( ent.var_31d3aa921f75646d ) )
            {
                continue;
            }
            
            var_ed9c434c776d7b8a = 0;
            
            foreach ( alarm in ent.var_31d3aa921f75646d )
            {
                if ( alarm == self || alarm.owner != self.owner )
                {
                    continue;
                }
                
                var_ed9c434c776d7b8a = 1;
                break;
            }
            
            if ( !var_ed9c434c776d7b8a )
            {
                var_98affc41adf7e943[ var_98affc41adf7e943.size ] = key;
            }
        }
        
        foreach ( num in var_98affc41adf7e943 )
        {
            self.owner.var_3d621f40a39d8966[ num ] = undefined;
        }
    }
    
    if ( isdefined( self.enemies_detected ) )
    {
        var_7ac4550afe2c353 = level.sharedfuncs[ #"perceptive" ][ #"decrementcount" ];
        
        foreach ( enemy in self.enemies_detected )
        {
            if ( isdefined( enemy ) )
            {
                enemy.var_31d3aa921f75646d[ self getentitynumber() ] = undefined;
                enemy notify( #"hash_109a6ce8719e9377" );
                
                if ( isdefined( var_7ac4550afe2c353 ) && isdefined( self ) )
                {
                    enemy [[ var_7ac4550afe2c353 ]]( self.entnum ?? utility::get_entity_number( self ) );
                }
            }
        }
    }
    
    if ( utility::issharedfuncdefined( #"jamming_system", #"hash_c33ceb91d0ca7a9d" ) )
    {
        self [[ utility::getsharedfunc( #"jamming_system", #"hash_c33ceb91d0ca7a9d" ) ]]( self );
    }
    
    challenges::function_3d7a169dbae062fb( "equip_proximity_alarm", self.owner, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ), self.usedcount );
    namespace_9d8e359c3b1041e5::emp_debuff_deregister_sharedfunc( self );
    index = self.owner.var_ea6cbc6058faff89[ self getentitynumber() ];
    
    if ( isdefined( self.owner ) && isdefined( index ) )
    {
        self.owner setclientomnvar( "ui_proximity_alarm_status_" + index, 0 );
        self.owner.var_ea6cbc6058faff89[ self getentitynumber() ] = undefined;
        
        if ( self.owner.var_ea6cbc6058faff89.size == 0 )
        {
            self.owner.var_ea6cbc6058faff89 = undefined;
        }
    }
    
    endtimems = ( self.alarmstarttime ?? 0 ) + ( self.pingduration ?? 0 ) * 1000;
    icondelaytimesec = max( endtimems - gettime(), 0 ) * 0.001;
    thread function_7adc36ca8aa2620b( icondelaytimesec, self.uiobjid );
    entityheadicons::setheadicon_deleteicon( self.headiconid );
    
    if ( self.bundle.var_e000a9bf54d9e5aa )
    {
        thread function_9d70f22beeb2e308( self.enemies_detected );
    }
    
    wait 0.1;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace proximity_alarm
// Params 2
// Checksum 0x4efe9e80, Offset: 0x1d97
// Size: 0x6d
function function_7adc36ca8aa2620b( delaytimesec, id )
{
    allycircle = self.allycircle;
    ownercircle = self.ownercircle;
    wait delaytimesec;
    
    if ( isdefined( id ) )
    {
        objidpoolmanager::returnobjectiveid( id );
    }
    
    if ( isdefined( allycircle ) )
    {
        allycircle game_utility::questcircle_delete();
    }
    
    if ( isdefined( ownercircle ) )
    {
        ownercircle game_utility::questcircle_delete();
    }
}

// Namespace proximity_alarm
// Params 1
// Checksum 0xe62cec29, Offset: 0x1e0c
// Size: 0x47
function proximity_alarm_handlefataldamage( data )
{
    self notify( #"enemy_destroyed_equipment", data.attacker );
    function_81b50fe1aad905f7( data.attacker, data.objweapon );
    thread proximity_alarm_destroy();
}

// Namespace proximity_alarm
// Params 2
// Checksum 0xa9a96eb2, Offset: 0x1e5b
// Size: 0x3b
function function_81b50fe1aad905f7( attacker, objweapon )
{
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker thread points::doscoreevent( #"proximity_alarm_destroyed" );
    }
}

// Namespace proximity_alarm
// Params 0
// Checksum 0x63585125, Offset: 0x1e9e
// Size: 0x56
function function_e32823b6349a2dd6()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    stuckdata = spawnstruct();
    childthread function_5335dc7e5a14e1a1( stuckdata );
    self waittill( #"missile_impact" );
    return stuckdata;
}

// Namespace proximity_alarm
// Params 1
// Checksum 0x9949e5c, Offset: 0x1efd
// Size: 0x51
function function_5335dc7e5a14e1a1( stuckdata )
{
    self endon( #"missile_impact" );
    self waittill( #"missile_stuck", stuckto );
    
    if ( isdefined( stuckto ) )
    {
        stuckdata.stuckto = stuckto;
    }
    
    self notify( #"missile_impact" );
}

// Namespace proximity_alarm
// Params 1
// Checksum 0x46ac6131, Offset: 0x1f56
// Size: 0x141, Type: bool
function proximity_alarm_canseetarget( target )
{
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    tracecontents = trace::create_contents( 0, 1, 0, 1, 1, 1, 0, 1 );
    defaultorigin = target.origin;
    tracepoints = [ defaultorigin ];
    
    if ( isplayer( target ) )
    {
        headpos = ( 0, 0, 0 );
        
        if ( player::isreallyalive( target ) )
        {
            headpos = target utility::function_f02ebab438642e16();
        }
        
        centerpos = ( 0, 0, 0 );
        
        if ( player::isreallyalive( target ) )
        {
            centerpos = target utility::function_68061c3d21a6d57a();
        }
        
        tracepoints = [ headpos, centerpos, defaultorigin ];
    }
    else if ( isagent( target ) )
    {
        tracepoints = [ defaultorigin + ( 0, 0, 1 ) ];
    }
    
    ignorelist = [ self, target ];
    
    for ( i = 0; i < tracepoints.size ; i++ )
    {
        if ( !trace::ray_trace_passed( self.origin, tracepoints[ i ], ignorelist, tracecontents ) )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace proximity_alarm
// Params 1, eflags: 0x4
// Checksum 0x97b15592, Offset: 0x20a0
// Size: 0x16
function private proximity_alarm_on_player_spawned( params )
{
    self.var_31d3aa921f75646d = undefined;
}

// Namespace proximity_alarm
// Params 1, eflags: 0x4
// Checksum 0xa5044201, Offset: 0x20be
// Size: 0x288
function private proximity_alarm_on_player_laststand( deathdata )
{
    victim = deathdata.victim;
    attacker = deathdata.attacker;
    
    if ( !function_b11036677b44984( victim, attacker ) )
    {
        return;
    }
    
    if ( !isdefined( deathdata.var_fbe5b36f4b7287d3 ) )
    {
        deathdata.var_fbe5b36f4b7287d3 = [];
    }
    
    var_ec16c6fd83592a02 = [];
    
    foreach ( enemyalarm in victim.var_31d3aa921f75646d )
    {
        if ( !isdefined( proximityweapon ) )
        {
            proximityweapon = enemyalarm.weapon_object;
        }
        
        owner = enemyalarm.owner;
        
        if ( !isdefined( owner ) )
        {
            continue;
        }
        
        var_13891b5c5f700edc = owner getentitynumber();
        var_a53e8970c410606d = {};
        var_ec16c6fd83592a02[ var_13891b5c5f700edc ] = var_a53e8970c410606d;
        var_a53e8970c410606d.owner = owner;
        var_a53e8970c410606d.weaponobj = enemyalarm.weapon_object;
        deathdata.var_fbe5b36f4b7287d3[ var_13891b5c5f700edc ] = owner;
        
        if ( attacker == owner )
        {
            owner thread gamelogic_mp::threadedsetweaponstatbyname( enemyalarm.weapon_object, 1, "debuff_kills" );
            owner telemetry_mp::function_89a5d8fb8ed3a4fe( deathdata, owner, enemyalarm.birthtime, enemyalarm.weapon_object );
            owner.var_45726d48cb2933af = 1;
        }
        else
        {
            var_a53e8970c410606d.var_c09dde49284b36fb = 1;
            owner thread gamelogic_mp::threadedsetweaponstatbyname( enemyalarm.weapon_object, 1, "debuff_assists" );
        }
        
        if ( victim != attacker.var_a1d9cdbc40bf0afc )
        {
            function_7c85bd4742cf0192( attacker, victim );
            
            if ( attacker.var_82691d97f38848f8 > 1 && attacker.var_82691d97f38848f8 % 2 == 0 )
            {
                var_a53e8970c410606d.var_e1fe8abb37a5cc23 = 1;
            }
        }
    }
    
    if ( !isdefined( deathdata.callbackeventdata ) )
    {
        deathdata.callbackeventdata = [];
    }
    
    deathdata.callbackeventdata[ "proximity_alarm" ] = var_ec16c6fd83592a02;
    
    if ( isdefined( proximityweapon ) )
    {
        victim thread gamelogic_mp::threadedsetweaponstatbyname( proximityweapon, 1, "killed_while_debuffed_by", undefined, attacker );
    }
    
    attacker thread cleankillcount();
}

// Namespace proximity_alarm
// Params 1, eflags: 0x4
// Checksum 0x8cec6ddc, Offset: 0x234e
// Size: 0x3c1
function private proximity_alarm_on_player_death( deathdata )
{
    victim = deathdata.victim;
    attacker = deathdata.attacker;
    
    if ( victim.inlaststand )
    {
        laststandattacker = victim.laststanddowneddata.attacker;
        var_ec16c6fd83592a02 = victim.laststanddowneddata.callbackeventdata[ "proximity_alarm" ];
        
        if ( isdefined( var_ec16c6fd83592a02 ) )
        {
            foreach ( var_a53e8970c410606d in var_ec16c6fd83592a02 )
            {
                if ( var_a53e8970c410606d.var_c09dde49284b36fb )
                {
                    var_a53e8970c410606d.owner thread points::doscoreevent( #"proximity_alarm_assist", var_a53e8970c410606d.weaponobj );
                }
                
                if ( var_a53e8970c410606d.var_e1fe8abb37a5cc23 )
                {
                    laststandattacker thread points::doscoreevent( #"double_prox_alarm", var_a53e8970c410606d.weaponobj );
                }
            }
        }
    }
    else if ( !function_b11036677b44984( victim, attacker ) )
    {
        return;
    }
    
    if ( !isdefined( deathdata.var_fbe5b36f4b7287d3 ) )
    {
        deathdata.var_fbe5b36f4b7287d3 = [];
    }
    
    proximityweapon = undefined;
    
    foreach ( enemyalarm in victim.var_31d3aa921f75646d )
    {
        if ( !isdefined( proximityweapon ) )
        {
            proximityweapon = enemyalarm.weapon_object;
        }
        
        owner = enemyalarm.owner;
        
        if ( !isdefined( owner ) )
        {
            continue;
        }
        
        var_13891b5c5f700edc = owner getentitynumber();
        deathdata.var_fbe5b36f4b7287d3[ var_13891b5c5f700edc ] = owner;
        
        if ( attacker == owner )
        {
            basepoints = rank::getscoreinfovalue( #"hash_4149d820a2bb5048" ) ?? 0;
            finalpoints = enemyalarm.var_d8d4ac6eb0fb08e7 ? enemyalarm.var_d8d4ac6eb0fb08e7 * basepoints : basepoints;
            owner thread points::doscoreevent( #"hash_4149d820a2bb5048", enemyalarm.weapon_object, finalpoints );
            owner thread gamelogic_mp::threadedsetweaponstatbyname( enemyalarm.weapon_object, 1, "debuff_kills" );
            owner telemetry_mp::function_89a5d8fb8ed3a4fe( deathdata, owner, enemyalarm.birthtime, enemyalarm.weapon_object );
            owner.var_45726d48cb2933af = 1;
        }
        else
        {
            owner thread points::doscoreevent( #"proximity_alarm_assist", enemyalarm.weapon_object );
            owner thread gamelogic_mp::threadedsetweaponstatbyname( enemyalarm.weapon_object, 1, "debuff_assists" );
        }
        
        if ( victim != attacker.var_a1d9cdbc40bf0afc )
        {
            function_7c85bd4742cf0192( attacker, victim );
            
            if ( attacker.var_82691d97f38848f8 > 1 && attacker.var_82691d97f38848f8 % 2 == 0 )
            {
                attacker thread points::doscoreevent( #"double_prox_alarm", enemyalarm.weapon_object );
            }
        }
    }
    
    if ( isdefined( proximityweapon ) )
    {
        victim thread gamelogic_mp::threadedsetweaponstatbyname( proximityweapon, 1, "killed_while_debuffed_by", undefined, attacker );
    }
    
    attacker thread cleankillcount();
}

// Namespace proximity_alarm
// Params 2, eflags: 0x4
// Checksum 0x5eaa1e68, Offset: 0x2717
// Size: 0x43, Type: bool
function private function_b11036677b44984( victim, attacker )
{
    if ( !( victim.var_31d3aa921f75646d.size > 0 ) )
    {
        return false;
    }
    
    if ( !isdefined( attacker ) )
    {
        return false;
    }
    
    if ( !player_utility::playersareenemies( attacker, victim ) )
    {
        return false;
    }
    
    return true;
}

// Namespace proximity_alarm
// Params 2, eflags: 0x4
// Checksum 0x4feebd7e, Offset: 0x2763
// Size: 0x4a
function private function_7c85bd4742cf0192( attacker, victim )
{
    attacker.var_a1d9cdbc40bf0afc = victim;
    
    if ( !isdefined( attacker.var_82691d97f38848f8 ) )
    {
        attacker.var_82691d97f38848f8 = 0;
    }
    
    attacker.var_82691d97f38848f8++;
}

// Namespace proximity_alarm
// Params 0, eflags: 0xc
// Checksum 0x6e32023b, Offset: 0x27b5
// Size: 0x3d
function private cleankillcount()
{
    self notify( #"hash_6ebe725df83cb1bf" );
    self endon( #"hash_6ebe725df83cb1bf" );
    self endon( #"death_or_disconnect" );
    wait 2;
    self.var_82691d97f38848f8 = undefined;
    self.var_a1d9cdbc40bf0afc = undefined;
}

// Namespace proximity_alarm
// Params 1
// Checksum 0xbf178071, Offset: 0x27fa
// Size: 0xf9
function proximity_alarm_onownerchanged( oldowner )
{
    if ( isdefined( self.ownercircle.mapcircle ) )
    {
        self.ownercircle game_utility::questcircle_hidefromplayer( oldowner );
    }
    
    if ( isdefined( self.allycircle.mapcircle ) )
    {
        foreach ( player in teams::getfriendlyplayers( oldowner.team ) )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            self.allycircle game_utility::questcircle_hidefromplayer( player );
        }
    }
    
    objidpoolmanager::objective_mask_showtoplayerteam( self.uiobjid, self.owner );
}

// Namespace proximity_alarm
// Params 1
// Checksum 0x6919c728, Offset: 0x28fb
// Size: 0xcc
function function_5fcbc8e502e5e6e9( victiment )
{
    if ( !isdefined( victiment.var_58308f67640961fe ) )
    {
        if ( squad_utility::shouldmodesetsquads() )
        {
            victiment.var_58308f67640961fe = outline::outlineenableforsquad( victiment, self.owner.team, self.owner.sessionsquadid, self.bundle.var_b646234b318f60cc, "equipment_lesser" );
            return;
        }
        
        victiment.var_58308f67640961fe = outline::outlineenableforteam( victiment, self.owner.team, self.owner.sessionsquadid, self.bundle.var_b646234b318f60cc, "equipment_lesser" );
    }
}

// Namespace proximity_alarm
// Params 1
// Checksum 0x12834a33, Offset: 0x29cf
// Size: 0x3a
function function_3c80fa3b48b4c1dc( victiment )
{
    if ( isdefined( victiment.var_58308f67640961fe ) )
    {
        outline::outlinedisable( victiment.var_58308f67640961fe, victiment );
    }
    
    victiment.var_58308f67640961fe = undefined;
}

// Namespace proximity_alarm
// Params 1
// Checksum 0xe034ad0f, Offset: 0x2a11
// Size: 0x86
function function_9d70f22beeb2e308( enemies_detected )
{
    if ( !isdefined( enemies_detected ) )
    {
        return;
    }
    
    foreach ( ent in enemies_detected )
    {
        function_3c80fa3b48b4c1dc( ent );
    }
}

// Namespace proximity_alarm
// Params 3, eflags: 0x4
// Checksum 0xf049ebe7, Offset: 0x2a9f
// Size: 0x54
function private function_48a1fba2880097f8( ent, delay, alarmradius )
{
    self endon( #"death" );
    equipment_mp::function_d1d291c51aa6d760( ent );
    thread function_10515716580363c1( ent, alarmradius );
    wait delay;
    
    if ( equipment_mp::function_d84c6f0cac9c8a7( ent ) )
    {
        equipment_mp::function_40ac4616989324cf( ent );
    }
}

// Namespace proximity_alarm
// Params 2, eflags: 0x4
// Checksum 0x261b3a61, Offset: 0x2afb
// Size: 0x51
function private function_10515716580363c1( ent, alarmradius )
{
    self endon( #"death" );
    
    while ( true )
    {
        wait 0.1;
        
        if ( function_b3f76427672a25a3( ent, alarmradius ) && equipment_mp::function_543aba88a2550fe7( ent ) )
        {
            equipment_mp::function_1a58b9ed0d786c51( ent );
            return;
        }
    }
}

// Namespace proximity_alarm
// Params 2, eflags: 0x4
// Checksum 0xaa50ef2b, Offset: 0x2b54
// Size: 0x32, Type: bool
function private function_b3f76427672a25a3( ent, radius )
{
    return distance2dsquared( self.origin, ent.origin ) > radius * radius;
}

