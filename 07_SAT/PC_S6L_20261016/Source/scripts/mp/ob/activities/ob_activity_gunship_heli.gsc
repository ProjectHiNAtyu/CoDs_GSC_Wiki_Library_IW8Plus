// scripts\mp\ob\activities\ob_activity_gunship_heli.gsc  (hash_05f4167d72f7173b.gscc) (size: 17220 Bytes / 0x4344 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa468f4d0 (2758341840)
// size ...... 17220 (0x4344)
// includes .. 19  (offset: 0x4010)
// strings ... 36  (offset: 0x40a8)
// dev strs .. 3   (offset: 0x431c)
// exports ... 58  (offset: 0x27f4)
// cseg ...... 0x2de + 0x2516 (0x27f4)
// imports ... 125 (offset: 0x3104)
// animtree1 . 0   (offset: 0x4344)
// animtree2 . 0   (offset: 0x4344)
#using script_3ec57c71b0b61f00;
#using script_60cd1c57e94be8d7;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\trace;
#using scripts\common\vehicle;
#using scripts\mp\common\killstreaks\chopper_support;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;
#using scripts\mp\poi;
#using scripts\mp\supers;
#using scripts\mp\vehicles\damage;
#using scripts\mp\weapons;

#namespace ob_activity_gunship_heli;

// Namespace ob_activity_gunship_heli
// Params 1
// Checksum 0x8458d2d7, Offset: 0x2fc
// Size: 0x22e
function chopper_init( bossdetails )
{
    level.var_db391e86c6c1bbc2 = getdvarint( @"hash_2e1a1ee4432ba896", 4000 );
    level.var_adaaa86b7b5a18b6 = getdvarint( @"hash_6e84d26c89e579da", 12000 );
    level.var_c582f0f1f598788e = getdvarint( @"hash_29c7a74c7b9dd1b2", 3 );
    level.var_da9d0112ff45d16b = getdvarint( @"hash_4e73bb68df397fbf", 8 );
    level.var_2f16bd070318a5fc = getdvarfloat( @"hash_a37dfea1fa39ddb0", 0.5 );
    level.var_9afedb2928bda858 = getdvarfloat( @"hash_23628860cca0a09c", 1 );
    level.var_1c413c0f520b77a1 = getdvarint( @"hash_995dd383d134e9ed", 10000 );
    level.var_ef819189ba3c6250 = getdvarint( @"hash_7926da00afdcd474", 4500 );
    level.var_1b807c86f79fc8d6 = getdvarint( @"hash_369e173b0e8d08ba", 12 );
    level.var_c15d0d0ad1e767fb = getdvarint( @"hash_8b1842e92794c807", 7 );
    level.var_3375c4f7793b4ccb = getdvarint( @"hash_cc7feb01eae01a3f", 1 );
    level.var_be17f6f2696e1d1a = getdvarint( @"hash_45da2e0688e80016", 5000 );
    level.var_1be27c807e9e9d09 = getdvarint( @"hash_dd6e4061977972e5", 4 );
    level.var_9275920438b54a87 = getdvarfloat( @"hash_f8eecd7b1f022fa3", 6 );
    level.var_9298800438db6aa9 = getdvarfloat( @"hash_f911c37b1f28615d", 7 );
    level.var_c915f7191eab3985 = getdvarint( @"hash_2b111045e5d27399", 20 );
    level.var_c915f4191eab32ec = getdvarint( @"hash_2b110d45e5d26d00", 10 );
    level.var_c915f5191eab351f = getdvarint( @"hash_2b110e45e5d26f33", 5 );
    level.averagealliesz = 0;
    level.killstreakweaponmap[ "sat_vtol_warship_proj_ob" ] = "chopper_gunner";
    level.var_e05429687d6711be = getdvarint( @"hash_31f0a801b6bc5215", 1 ) == 1;
    level.var_9b32f3255542d1f7 = getdvarint( @"hash_f03824c32a6e9662", 12000 );
    level.var_99cc0ae0a9c90f54 = getdvarint( @"hash_7658b59ac07ecef8", 0 );
}

// Namespace ob_activity_gunship_heli
// Params 1
// Checksum 0xe7a43b3, Offset: 0x532
// Size: 0x59
function chopper_getcurrentstate( chopper )
{
    if ( isalive( chopper ) && isstring( chopper.currentstate ) )
    {
        state = chopper.currentstate;
        
        if ( state == "idle" )
        {
            state = "patrol";
        }
        
        return state;
    }
    
    return "death";
}

// Namespace ob_activity_gunship_heli
// Params 1
// Checksum 0xd8a0ecfb, Offset: 0x594
// Size: 0x9a
function chopper_getcurrenttargetplayer( chopper )
{
    if ( isdefined( chopper ) && isdefined( chopper.currenttarget ) && isdefined( chopper.threatlist[ chopper.currenttarget ] ) && isarray( chopper.threatlist ) && isplayer( chopper.threatlist[ chopper.currenttarget ].player ) )
    {
        return chopper.threatlist[ chopper.currenttarget ].player;
    }
}

// Namespace ob_activity_gunship_heli
// Params 1
// Checksum 0x6b66d63, Offset: 0x637
// Size: 0x48
function function_c8ebfbad18c07ee3( chopper )
{
    targetplayer = chopper_getcurrenttargetplayer( chopper );
    
    if ( isplayer( targetplayer ) && isstring( targetplayer.team ) )
    {
        return targetplayer.team;
    }
}

// Namespace ob_activity_gunship_heli
// Params 0
// Checksum 0x44f8ea1, Offset: 0x688
// Size: 0xa5
function chopper_initscriptable()
{
    self endon( #"death" );
    self endon( #"leaving" );
    level endon( #"game_ended" );
    wait 1;
    self setscriptablepartstate( "blinking_lights", "on", 0 );
    self setscriptablepartstate( "interior_light", "on", 0 );
    self setscriptablepartstate( "pilot_cockpit_light", "on", 0 );
    self setscriptablepartstate( "co_pilot_cockpit_light", "on", 0 );
    self setscriptablepartstate( "engine", "on_all", 0 );
    self setscriptablepartstate( "thrusters", "horizontal", 1 );
    wait 1;
    self setscriptablepartstate( "thrusters", "dynamic", 1 );
}

// Namespace ob_activity_gunship_heli
// Params 0
// Checksum 0xfe1210b5, Offset: 0x735
// Size: 0x5f
function function_d86fce71643ba979()
{
    self setscriptablepartstate( "blinking_lights", "off", 0 );
    self setscriptablepartstate( "interior_light", "off", 0 );
    self setscriptablepartstate( "pilot_cockpit_light", "off", 0 );
    self setscriptablepartstate( "co_pilot_cockpit_light", "off", 0 );
    self setscriptablepartstate( "engine", "off", 0 );
    thread function_b71ee8a9ad29e3ea( self );
}

// Namespace ob_activity_gunship_heli
// Params 0
// Checksum 0x594c551a, Offset: 0x79c
// Size: 0x7f
function chopper_spawn()
{
    self.spawnloc += ( 0, 0, namespace_7161222aac9ca916::function_8910c2ed5165b312() );
    chopper = chopper_spawnheli( self.spawnloc );
    chopper.bossinstance = self;
    self.spawned = 1;
    self.boss = chopper;
    game_utility::questcircle_delete();
    weapons::function_ef0cb557b1a93af9( chopper );
    chopper forcenetfieldhighlod( 1 );
    waitframe();
    chopper thread chopper_initscriptable();
}

// Namespace ob_activity_gunship_heli
// Params 1
// Checksum 0x9115e678, Offset: 0x823
// Size: 0x2de
function chopper_spawnheli( pos )
{
    if ( isdefined( level.var_cdffdbdd11aaff0e ) )
    {
        self.var_8c78435105a9f582 = level.var_cdffdbdd11aaff0e;
    }
    
    choppervehicle = getdvar( @"hash_85e8885fce5027e7", "veh_sat_mil_vtol_ob_gunship" );
    
    if ( isdefined( self.var_cb5c81589a3b29d2 ) )
    {
        choppervehicle = self.var_cb5c81589a3b29d2;
    }
    
    chopperspeed = getdvarfloat( @"hash_15433ba1e04d0628", 45 );
    chopperaccel = getdvarfloat( @"hash_5504c05bf3ec3c8b", 50 );
    chopper = namespace_7161222aac9ca916::function_99bd6dec05f43457( pos, choppervehicle, undefined, self.patrolpath, "ob_boss_vtol", self.var_ec517b09275f391, self.var_330cc8c49ebc685a, chopperspeed, chopperaccel );
    chopper.activityinstance = self;
    
    if ( self.var_3574b7a060d661f5 && self.customsettings.var_604624b4907944f4 )
    {
        chopper [[ self.customsettings.var_604624b4907944f4 ]]( self );
    }
    
    chopper function_d2b8ee2e1275daaf( 1 );
    chopper function_6cdf8871636b9d21();
    
    if ( chopper function_a6228eba3fb738e() )
    {
        chopper.lootfunc = &ob_activity_utility::drop_loot;
    }
    
    chopper.var_5e0911aa2163e517 = [];
    chopper.combatstate = 0;
    chopper.shouldshoot = 1;
    chopper.var_7d1f6ca04002be2c = 0;
    chopper.postmodifydamage = &chopper_postmodifydamage;
    chopper.var_197abd6744fcd8bf = &function_5a265f407e5fb6d7;
    chopper.attackfunc = &chopper_attack;
    chopper.strafefunc = &function_6aa47de61eee9a3b;
    chopper.gunattacks = 0;
    chopper.missileweapon = makeweapon( "sat_vtol_warship_proj_ob" );
    healthbarsettingsid = function_43b5ed5a14a56573( #"scriptbundle_healthbarsettings", %"hash_6ed4fde0ed0bcf9b" );
    chopper.healthbarsettingsid = healthbarsettingsid;
    
    if ( !level.var_ac384fdf4664f6cc && ( !chopper.var_3574b7a060d661f5 || !chopper.customsettings.var_ac384fdf4664f6cc ) )
    {
        chopper.var_24954f14e27b448d = 1;
    }
    
    self.chopper = chopper;
    
    if ( !level.var_d7bd181cee9a3089 )
    {
        chopper_createobjective();
    }
    
    damage::set_death_callback( self.chopper vehicle::get_ref(), &chopper_handledeathdamage );
    thread chopper_ondeath();
    
    if ( chopper function_6a7b512902819c0() )
    {
        thread function_f5cffe409e6a3b2a();
        thread function_2a8ff58c5841764a();
    }
    
    /#
        self.chopper thread chopper_leavetest();
    #/
    
    if ( isdefined( level.var_7b6fcaa8e75ec93e ) )
    {
        [[ level.var_7b6fcaa8e75ec93e ]]( self );
    }
    
    return chopper;
}

// Namespace ob_activity_gunship_heli
// Params 0
// Checksum 0xcaab2e8c, Offset: 0xb0a
// Size: 0x47
function chopper_ondeath()
{
    self.chopper endon( #"flyaway" );
    self.chopper waittill( #"death" );
    waitframe();
    
    if ( function_698adbc83b83698() )
    {
        activity_instance_common::endactivity( self.activity, 1 );
    }
}

// Namespace ob_activity_gunship_heli
// Params 1
// Checksum 0x1e9ef1f9, Offset: 0xb59
// Size: 0x49, Type: bool
function function_5a265f407e5fb6d7( player )
{
    if ( isdefined( player.team ) && player::isreallyalive( player ) && !level.var_a9f499aba9fe4113 && !player.extracted )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_activity_gunship_heli
// Params 1
// Checksum 0xa1d00532, Offset: 0xbab
// Size: 0xf2, Type: bool
function chopper_postmodifydamage( data )
{
    if ( isdefined( self.var_e694506ff0ca92bd ) )
    {
        self [[ self.var_e694506ff0ca92bd ]]( data );
    }
    
    if ( !self.var_5bd401eaeb8e3e5e && function_dda29d646f236cac() )
    {
        switch ( self.damagestate )
        {
            case 0:
                self.damagestate = 1;
                function_70f622e37173a9b3( self, 1 );
                break;
            case 1:
                self.damagestate = 2;
                function_d5f8d6a043f4d38c( self, 1 );
                break;
            case 2:
                self.damagestate = 3;
                self setscriptablepartstate( "body_damage_heavy", "on", 0 );
                break;
            case 3:
            default:
                break;
        }
    }
    
    damage_utility::function_723dcec170ec23be( data.attacker );
    return true;
}

// Namespace ob_activity_gunship_heli
// Params 0
// Checksum 0x124b3cf3, Offset: 0xca6
// Size: 0x7f, Type: bool
function function_dda29d646f236cac()
{
    damagethresholds = [ 0.65, 0.25, 0.05 ];
    
    if ( isdefined( self.var_359ce29c63efe084 ) )
    {
        damagethresholds = self.var_359ce29c63efe084;
    }
    
    if ( self.damagestate >= damagethresholds.size )
    {
        return false;
    }
    
    nextthreshold = damagethresholds[ self.damagestate ];
    return self.currenthealth <= self.maxhealth * nextthreshold;
}

// Namespace ob_activity_gunship_heli
// Params 1
// Checksum 0xe3e7089, Offset: 0xd2e
// Size: 0xb0, Type: bool
function chopper_handledeathdamage( data )
{
    instance = self.bossinstance;
    
    if ( isdefined( instance ) )
    {
        instance notify( #"boss_death" );
        instance.killed = 1;
        instance.killer = data.attacker;
    }
    
    thread chopper_support::choppersupport_handledeathdamage( data );
    
    if ( instance && !instance function_960088d2cd406ad7() )
    {
        thread function_4310b0f912543a7f( data.attacker.team );
    }
    
    thread function_d86fce71643ba979();
    self notify( #"death", data.attacker );
    return true;
}

// Namespace ob_activity_gunship_heli
// Params 1
// Checksum 0xebd8c090, Offset: 0xde7
// Size: 0xf6
function function_4310b0f912543a7f( team )
{
    chopper = self;
    
    if ( !isstring( team ) )
    {
        return;
    }
    
    while ( isdefined( chopper ) )
    {
        waitframe();
    }
    
    delaytime = 5;
    overlord::function_be2d6dc71f97faa6( "boss_chopper_eliminated", team, delaytime );
    xpoverride = getdvarint( @"hash_dfcad66b7ba8da13", 500 );
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        player thread points::doscoreevent( #"kill", undefined, undefined, xpoverride, self, undefined, undefined, 1, undefined, 1 );
    }
}

// Namespace ob_activity_gunship_heli
// Params 1
// Checksum 0x9bf4ba3a, Offset: 0xee5
// Size: 0x1f0
function chopper_attack( target )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    
    if ( !isdefined( target ) )
    {
        return;
    }
    
    var_aab48ad601a760ab = target.origin;
    targetpoi = poi::poi_findpoioriginisin( target.origin );
    allowstraferun = 1;
    
    if ( isdefined( level.var_133306b83991da02 ) && isdefined( targetpoi ) )
    {
        allowstraferun = !arraycontains( level.var_133306b83991da02, targetpoi );
    }
    
    self.shouldshoot = 1;
    self.var_7d1f6ca04002be2c = 0;
    
    if ( !function_159e7dd3ce7dcab9() )
    {
        thread function_63db57408d939fda( target );
    }
    
    if ( !function_b5fffe4bbdbd93f4() )
    {
        thread function_2598a647394a5f74();
    }
    
    var_be3882be7289a754 = function_fb8d63bc792c7798();
    var_978fe09f18db5fba = function_1e5372e8f524bac6();
    
    while ( true )
    {
        target = namespace_7161222aac9ca916::function_46e55b7fc7a1f265();
        
        if ( isdefined( target ) )
        {
            self setturrettargetvec( target.origin );
            self setturretscriptcontrolled( 1, 0 );
            
            if ( chopper_turretlookingattarget( target ) )
            {
                if ( allowstraferun && function_80305c22b7235693() )
                {
                    self.gunattacks = 0;
                    
                    if ( !namespace_7161222aac9ca916::function_b7c8e62904e632c( target, 4000, 8, randomint( 360 ), 1000 ) )
                    {
                        if ( self.strafing )
                        {
                            self notify( #"strafe_end" );
                            self vehicle_setspeed( self.originalspeed, self.accel );
                            self.strafing = 0;
                        }
                    }
                }
                else
                {
                    function_86c1334ea4ea9021( target, randomfloatrange( var_be3882be7289a754, var_978fe09f18db5fba ) );
                }
            }
        }
        
        if ( namespace_7161222aac9ca916::function_15ef53278f060bfe( target ) )
        {
            namespace_7161222aac9ca916::function_5593697f8fdd7ac6( "idle" );
            return;
        }
        
        if ( !function_545445c911873fee( target ) )
        {
            namespace_7161222aac9ca916::function_c585f17cc1fba955( target, -800 );
            namespace_7161222aac9ca916::function_5593697f8fdd7ac6( "idle" );
            return;
        }
        
        wait 3;
    }
}

// Namespace ob_activity_gunship_heli
// Params 0
// Checksum 0x7aecf83c, Offset: 0x10dd
// Size: 0x64, Type: bool
function function_80305c22b7235693()
{
    canstrafe = 1;
    
    if ( self.var_99b1fba9fe682ecd )
    {
        canstrafe = self [[ self.var_99b1fba9fe682ecd ]]();
    }
    
    var_92dc6df4dc2e67be = function_6361ec3d72c397b4();
    var_f4db23ff43361e97 = function_ba813b96428035a6();
    return canstrafe && var_92dc6df4dc2e67be > 0 && self.gunattacks >= var_f4db23ff43361e97;
}

// Namespace ob_activity_gunship_heli
// Params 1
// Checksum 0x485dd451, Offset: 0x114a
// Size: 0x1b9
function function_6aa47de61eee9a3b( target )
{
    self.gunattacks = 0;
    missiletags = [ "tag_fx_missiles_right", "tag_fx_rockets_right", "tag_fx_missiles_left", "tag_fx_rockets_left" ];
    missilestates = [ "fire_missile_4", "fire_missile_4", "fire_missile_1", "fire_missile_1" ];
    missilestarttime = function_23766c2caf915340();
    wait missilestarttime;
    shots = 0;
    var_bb38677f731d7a35 = function_6361ec3d72c397b4();
    var_7806d13806b18a5c = function_744180e516a4a4fd();
    
    while ( shots < var_bb38677f731d7a35 )
    {
        pitchangles = self.angles + ( 25, 0, 0 );
        var_614260aaf8f69a08 = self gettagorigin( missiletags[ 1 ] ) + anglestoforward( pitchangles ) * 200;
        var_5d88509d1ece9b99 = self gettagorigin( missiletags[ 1 ] ) + anglestoforward( pitchangles ) * 1000;
        missileright = weapon_utility::_magicbullet( self.missileweapon, var_614260aaf8f69a08, var_5d88509d1ece9b99, self );
        var_baece2beb8c3f959 = self gettagorigin( missiletags[ 3 ] ) + anglestoforward( pitchangles ) * 200;
        var_8cac471c45ae8448 = self gettagorigin( missiletags[ 3 ] ) + anglestoforward( pitchangles ) * 1000;
        missileleft = weapon_utility::_magicbullet( self.missileweapon, var_baece2beb8c3f959, var_8cac471c45ae8448, self );
        self setscriptablepartstate( missilestates[ 1 ], "on", 0 );
        self setscriptablepartstate( missilestates[ 3 ], "on", 0 );
        shots += 2;
        wait var_7806d13806b18a5c;
    }
}

// Namespace ob_activity_gunship_heli
// Params 1
// Checksum 0xf3d85811, Offset: 0x130b
// Size: 0x22f
function function_63db57408d939fda( target )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    target endon( #"death_or_disconnect" );
    self setlookatent( target );
    var_bf12ea1737d9ff1 = 0;
    timer = 0;
    var_202715674ba5855b = function_9467bd8902ea0fcf();
    var_5e798dc42df87947 = function_51744da7ca1d365f();
    var_524b407d18547602 = function_ffe460127af451be();
    var_745d403df399ee97 = function_32084a7804559548();
    var_191e2d3ae4f1bf15 = function_d5843cccdefcc686();
    repositiontime = function_3ccf77400c7ffb41();
    
    while ( true )
    {
        if ( !self.strafing )
        {
            if ( !( isdefined( target ) && isdefined( target.origin ) ) )
            {
                namespace_7161222aac9ca916::function_5593697f8fdd7ac6( "idle" );
            }
            
            contentsoverride = trace::create_contents( 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0 );
            canseetarget = trace::ray_trace_passed( target.origin, self.origin, self.ignorelist, contentsoverride );
            
            if ( timer > repositiontime || !canseetarget || distance2dsquared( target.origin, self.origin ) > var_745d403df399ee97 || distance2dsquared( target.origin, self.origin ) < var_191e2d3ae4f1bf15 )
            {
                timer = 0;
                
                if ( !namespace_7161222aac9ca916::function_d8d365ee7036c02d( target, 3000, 8, randomint( 360 ) ) )
                {
                    var_bf12ea1737d9ff1++;
                    
                    if ( var_bf12ea1737d9ff1 > var_202715674ba5855b )
                    {
                        self.var_7d1f6ca04002be2c = 1;
                    }
                    
                    if ( var_bf12ea1737d9ff1 > var_5e798dc42df87947 )
                    {
                        self.shouldshoot = 0;
                    }
                    
                    if ( var_bf12ea1737d9ff1 > var_524b407d18547602 )
                    {
                        namespace_7161222aac9ca916::function_c585f17cc1fba955( target, -500 );
                        namespace_7161222aac9ca916::function_5593697f8fdd7ac6( "idle" );
                    }
                }
                else
                {
                    self.var_7d1f6ca04002be2c = 0;
                    self.shouldshoot = 1;
                }
            }
            else
            {
                self.var_7d1f6ca04002be2c = 0;
                self.shouldshoot = 1;
            }
        }
        
        timer += 0.5;
        wait 0.5;
    }
}

// Namespace ob_activity_gunship_heli
// Params 1
// Checksum 0xdb8985d9, Offset: 0x1542
// Size: 0xb1, Type: bool
function chopper_canshoottarget( target )
{
    guid = target.guid;
    
    if ( self.health <= 0 )
    {
        return false;
    }
    
    if ( !isdefined( target ) )
    {
        namespace_7161222aac9ca916::function_b461f760b09b955b( guid );
        namespace_7161222aac9ca916::function_5593697f8fdd7ac6( "idle" );
        return false;
    }
    
    if ( player::isreallyalive( target ) && target.inlaststand )
    {
        namespace_7161222aac9ca916::function_c585f17cc1fba955( target, -2000 );
        namespace_7161222aac9ca916::function_5593697f8fdd7ac6( "idle" );
        return false;
    }
    
    if ( !isdefined( target ) || target supers_mp::function_60dbd7e2f1b02c22() )
    {
        namespace_7161222aac9ca916::function_b461f760b09b955b( guid );
        namespace_7161222aac9ca916::function_5593697f8fdd7ac6( "idle" );
        return false;
    }
    
    return true;
}

// Namespace ob_activity_gunship_heli
// Params 2
// Checksum 0xe3aa5983, Offset: 0x15fc
// Size: 0x6c
function function_86c1334ea4ea9021( target, time )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    
    if ( chopper_canshoottarget( target ) )
    {
        self.gunattacks++;
        thread function_86421a1de7657b6b( target );
        wait time;
        self notify( #"stop_shooting" );
        return;
    }
    
    wait 1;
}

// Namespace ob_activity_gunship_heli
// Params 1
// Checksum 0x7fc1c7f2, Offset: 0x1670
// Size: 0x1dd
function function_86421a1de7657b6b( target )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    self endon( #"stop_shooting" );
    attackradius = function_3087df9a9466ffd0( 1 );
    var_2c5451aab99e9240 = 0;
    dir = anglestoforward( target.angles );
    dir2d = vectornormalize( ( dir[ 0 ], dir[ 1 ], 0 ) );
    shotcount = 0;
    var_21805719718bfdae = function_a6d41fd61952cfd6();
    var_21805819718bffe1 = function_a6d420d61952d209();
    
    while ( true )
    {
        if ( !chopper_canshoottarget( target ) )
        {
            return;
        }
        
        if ( shotcount >= var_21805819718bffe1 )
        {
            attackradius = function_3087df9a9466ffd0( 3 );
        }
        else if ( shotcount >= var_21805719718bfdae )
        {
            attackradius = function_3087df9a9466ffd0( 2 );
        }
        
        if ( !self.shouldshoot )
        {
            wait 0.1;
            continue;
        }
        
        centerpoint = target gettagorigin( "j_spineupper", 1 );
        
        if ( !isdefined( centerpoint ) )
        {
            centerpoint = target.origin;
        }
        
        randdist = randomint( attackradius ) + var_2c5451aab99e9240;
        randangle = randomint( 360 );
        x = centerpoint[ 0 ] + randdist * cos( randangle );
        y = centerpoint[ 1 ] + randdist * sin( randangle );
        z = centerpoint[ 2 ];
        point = ( x, y, z );
        offset = point - target.origin;
        self setturrettargetent( target, offset );
        
        while ( self function_7cc4e445cca9566f( 0 ) != 1 )
        {
            waitframe();
        }
        
        self requestfireweapon( 0 );
        shotcount++;
        waitframe();
    }
}

// Namespace ob_activity_gunship_heli
// Params 1
// Checksum 0x34e7dbcb, Offset: 0x1855
// Size: 0x6e, Type: bool
function chopper_turretlookingattarget( target )
{
    var_f9c5d56a87a91cf0 = 0.8;
    turretforward = anglestoforward( self gettagangles( "tag_flash" ) );
    targetdisplace = vectornormalize( target.origin - self gettagorigin( "tag_flash" ) );
    var_48d3b195ec36a36b = vectordot( turretforward, targetdisplace );
    return var_48d3b195ec36a36b >= var_f9c5d56a87a91cf0;
}

// Namespace ob_activity_gunship_heli
// Params 1
// Checksum 0x95045bf4, Offset: 0x18cc
// Size: 0x8e
function chopper_clearcurrenttarget( turret )
{
    if ( self.currenttarget == turret.attackingtarget )
    {
        self.currenttarget.var_9def822b39ed9d4e = gettime();
        self.currenttarget = undefined;
    }
    
    if ( turret.targetbrokelos )
    {
        turret.targetbrokelos = undefined;
    }
    
    turret.attackingtarget = undefined;
    turret cleartargetentity();
    turret.groundtargetent unlink();
    turret notify( #"lost_target" );
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0xf5932dad, Offset: 0x1962
// Size: 0xc4
function private chopper_createobjective()
{
    activity = self.activity;
    chopper = self.chopper;
    
    if ( !isdefined( self.customobjectivemarker ) )
    {
        self.customobjectivemarker = "ob_gunship_commander_marker";
    }
    
    chopper.objidnum = activity namespace_d7fa4530141146a5::function_de87bf7072515cd3( self.customobjectivemarker, 0, 0 );
    
    if ( self.var_9d9ce002531e526a && chopper.objidnum && chopper.objidnum != -1 )
    {
        function_3f1a6a0ae5901866( chopper.objidnum, self.var_9d9ce002531e526a );
    }
    
    objidpoolmanager::update_objective_onentity( chopper.objidnum, self.chopper );
}

// Namespace ob_activity_gunship_heli
// Params 0
// Checksum 0x9536b3db, Offset: 0x1a2e
// Size: 0x63
function function_f5cffe409e6a3b2a()
{
    self.chopper endon( #"death" );
    self.chopper waittill( #"flyaway" );
    self.chopper setscriptablepartstate( "thrusters", "horizontal", 1 );
    
    if ( !level.var_59e1d7f72751378 )
    {
        activity_instance_common::endactivity( self.activity, 0 );
    }
}

// Namespace ob_activity_gunship_heli
// Params 0
// Checksum 0x8443b6f5, Offset: 0x1a99
// Size: 0x47
function function_2a8ff58c5841764a()
{
    self.chopper endon( #"death" );
    self.chopper endon( #"leaving" );
    level waittill( #"ob_pvp_enabled" );
    self.chopper thread namespace_7161222aac9ca916::chopper_flyaway();
}

/#

    // Namespace ob_activity_gunship_heli
    // Params 0
    // Checksum 0x949d3027, Offset: 0x1ae8
    // Size: 0x53, Type: dev
    function chopper_leavetest()
    {
        self endon( #"death" );
        self endon( #"leaving" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_da85d43fb0eff7f8", 0 ) == 1 )
            {
                setdvar( @"hash_da85d43fb0eff7f8", 0 );
                thread namespace_7161222aac9ca916::chopper_flyaway();
                return;
            }
            
            wait 1;
        }
    }

#/

// Namespace ob_activity_gunship_heli
// Params 1
// Checksum 0x39cf97ab, Offset: 0x1b43
// Size: 0xa9
function function_2598a647394a5f74( setlights = 0 )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    self endon( #"state_change" );
    
    while ( true )
    {
        self waittill( #"strafe_init" );
        
        if ( level.var_679b2cb4aec6cf81 )
        {
            wait level.var_679b2cb4aec6cf81;
        }
        
        thread function_7337edb76b4495ea( self );
        
        if ( setlights )
        {
            function_9cde1a77d22afe7f( self, 0 );
        }
        
        self waittill( #"strafe_start" );
        thread function_b71ee8a9ad29e3ea( self );
        
        if ( setlights )
        {
            function_9cde1a77d22afe7f( self, 1 );
        }
    }
}

// Namespace ob_activity_gunship_heli
// Params 1
// Checksum 0x53594bed, Offset: 0x1bf4
// Size: 0x11b
function function_7337edb76b4495ea( gunship )
{
    if ( gunship.is_camo_activated )
    {
        return;
    }
    
    gunship.is_camo_activated = 1;
    gunship.var_4efa4e2adc37ef3[ #"hash_ca344db7b532fcf0" ] = 1;
    
    if ( isdefined( gunship getscriptablepartstate( "vehicle_active_camo_fx", 0 ) ) )
    {
        gunship setscriptablepartstate( "vehicle_active_camo_fx", "camo_fx_on", 0 );
        gunship setscriptablepartstate( "engine", "off" );
        gunship setscriptablepartstate( "blinking_lights", "off" );
        
        if ( !level.var_ac384fdf4664f6cc && ( !gunship.var_3574b7a060d661f5 || !gunship.customsettings.var_ac384fdf4664f6cc ) )
        {
            gunship.var_24954f14e27b448d = 0;
        }
        
        if ( isdefined( gunship.activityinstance.objidnum ) )
        {
            objidpoolmanager::objective_playermask_hidefromall( gunship.activityinstance.objidnum );
        }
        
        gunship notify( #"camo_on" );
        return;
    }
    
    assertmsg( "<dev string:x24>" );
}

// Namespace ob_activity_gunship_heli
// Params 1
// Checksum 0xe76cd79e, Offset: 0x1d17
// Size: 0x10c
function function_b71ee8a9ad29e3ea( gunship )
{
    if ( !gunship.is_camo_activated )
    {
        return;
    }
    
    gunship.is_camo_activated = 0;
    gunship.var_4efa4e2adc37ef3[ #"hash_ca344db7b532fcf0" ] = undefined;
    
    if ( isdefined( gunship getscriptablepartstate( "vehicle_active_camo_fx", 0 ) ) )
    {
        gunship setscriptablepartstate( "vehicle_active_camo_fx", "camo_fx_deactivate", 0 );
        gunship setscriptablepartstate( "engine", "on_all" );
        gunship setscriptablepartstate( "blinking_lights", "on" );
        
        if ( !level.var_ac384fdf4664f6cc && ( !gunship.var_3574b7a060d661f5 || !gunship.customsettings.var_ac384fdf4664f6cc ) )
        {
            gunship.var_24954f14e27b448d = 1;
        }
        
        if ( isdefined( gunship.activityinstance.objidnum ) )
        {
            objidpoolmanager::objective_playermask_showtoall( gunship.activityinstance.objidnum );
        }
        
        return;
    }
    
    assertmsg( "<dev string:x24>" );
}

// Namespace ob_activity_gunship_heli
// Params 2
// Checksum 0xcbd67804, Offset: 0x1e2b
// Size: 0x8e
function function_9cde1a77d22afe7f( gunship, on )
{
    state = on ? "on" : "off";
    
    if ( gunship getscriptablehaspart( "spotlight" ) )
    {
        gunship setscriptablepartstate( "spotlight", state, 1 );
    }
    else
    {
        assertmsg( "<dev string:x66>" );
    }
    
    if ( gunship getscriptablehaspart( "blinking_lights" ) )
    {
        gunship setscriptablepartstate( "blinking_lights", state, 0 );
        return;
    }
    
    assertmsg( "<dev string:x9b>" );
}

// Namespace ob_activity_gunship_heli
// Params 2
// Checksum 0xb8e2a4d9, Offset: 0x1ec1
// Size: 0x42
function function_70f622e37173a9b3( gunship, on )
{
    state = on ? "on" : "off";
    gunship setscriptablepartstate( "body_damage_light", state, 0 );
}

// Namespace ob_activity_gunship_heli
// Params 2
// Checksum 0x472fabac, Offset: 0x1f0b
// Size: 0x42
function function_d5f8d6a043f4d38c( gunship, on )
{
    state = on ? "on" : "off";
    gunship setscriptablepartstate( "body_damage_medium", state, 0 );
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0x56752ea6, Offset: 0x1f55
// Size: 0x44
function private function_698adbc83b83698()
{
    if ( self.var_3574b7a060d661f5 && isdefined( self.customsettings.var_d48f656b4c16b294 ) )
    {
        return self.customsettings.var_d48f656b4c16b294;
    }
    
    return !level.var_59e1d7f72751378;
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0x8fe90811, Offset: 0x1fa2
// Size: 0x52
function private function_6a7b512902819c0()
{
    var_8078fa021702e704 = !level.var_5507a818fc61c7ef;
    
    if ( self.var_3574b7a060d661f5 && self.customsettings.var_5d384f08300c7057 )
    {
        var_8078fa021702e704 = self.customsettings.var_5d384f08300c7057;
    }
    
    return var_8078fa021702e704;
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0xebdee4f5, Offset: 0x1ffd
// Size: 0x3b
function private function_a6228eba3fb738e()
{
    shoulddroploot = !level.var_68e7066ba5c126ca;
    
    if ( self.var_3574b7a060d661f5 )
    {
        shoulddroploot = self.customsettings.var_df788885d88bb8d2;
    }
    
    return shoulddroploot;
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0xcf281e84, Offset: 0x2041
// Size: 0x98
function private function_6cdf8871636b9d21()
{
    self.currenthealth = level.var_adaaa86b7b5a18b6;
    self.health = level.var_adaaa86b7b5a18b6;
    self.maxhealth = level.var_adaaa86b7b5a18b6;
    
    if ( self.var_3574b7a060d661f5 )
    {
        self.currenthealth = self.customsettings.var_71c157fd182f8458;
        self.health = self.customsettings.var_71c157fd182f8458;
        self.maxhealth = self.customsettings.var_adaaa86b7b5a18b6;
    }
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0xc1af4756, Offset: 0x20e1
// Size: 0x42
function private function_960088d2cd406ad7()
{
    if ( self.var_3574b7a060d661f5 && self.customsettings.var_7fd09c2690a2b64e )
    {
        return self.customsettings.var_7fd09c2690a2b64e;
    }
    
    return level.var_ca9e05610788e36e;
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0x60aef03f, Offset: 0x212c
// Size: 0x42
function private function_7f3b1bd137c03189()
{
    if ( self.var_3574b7a060d661f5 && self.customsettings.var_1c413c0f520b77a1 )
    {
        return self.customsettings.var_1c413c0f520b77a1;
    }
    
    return level.var_1c413c0f520b77a1;
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0x551df49c, Offset: 0x2177
// Size: 0x42
function private function_159e7dd3ce7dcab9()
{
    if ( self.var_3574b7a060d661f5 && self.customsettings.var_6aaa9c03e8db7b24 )
    {
        return self.customsettings.var_6aaa9c03e8db7b24;
    }
    
    return level.var_6aaa9c03e8db7b24;
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0x4c532bc7, Offset: 0x21c2
// Size: 0x42
function private function_b5fffe4bbdbd93f4()
{
    if ( self.var_3574b7a060d661f5 && self.customsettings.var_b1e200832fd554ae )
    {
        return self.customsettings.var_b1e200832fd554ae;
    }
    
    return level.var_b1e200832fd554ae;
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0x7da4886a, Offset: 0x220d
// Size: 0x42
function private function_ba813b96428035a6()
{
    if ( self.var_3574b7a060d661f5 && self.customsettings.var_c582f0f1f598788e )
    {
        return self.customsettings.var_c582f0f1f598788e;
    }
    
    return level.var_c582f0f1f598788e;
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0x10a01a23, Offset: 0x2258
// Size: 0x42
function private function_6361ec3d72c397b4()
{
    if ( self.var_3574b7a060d661f5 && self.customsettings.var_da9d0112ff45d16b )
    {
        return self.customsettings.var_da9d0112ff45d16b;
    }
    
    return level.var_da9d0112ff45d16b;
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0x7e8721d8, Offset: 0x22a3
// Size: 0x42
function private function_744180e516a4a4fd()
{
    if ( self.var_3574b7a060d661f5 && self.customsettings.var_2f16bd070318a5fc )
    {
        return self.customsettings.var_2f16bd070318a5fc;
    }
    
    return level.var_2f16bd070318a5fc;
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0xd0828ac0, Offset: 0x22ee
// Size: 0x42
function private function_23766c2caf915340()
{
    if ( self.var_3574b7a060d661f5 && self.customsettings.var_9afedb2928bda858 )
    {
        return self.customsettings.var_9afedb2928bda858;
    }
    
    return level.var_9afedb2928bda858;
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0x815b8ae6, Offset: 0x2339
// Size: 0x42
function private function_fb8d63bc792c7798()
{
    if ( self.var_3574b7a060d661f5 && self.customsettings.var_9275920438b54a87 )
    {
        return self.customsettings.var_9275920438b54a87;
    }
    
    return level.var_9275920438b54a87;
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0x2d25a555, Offset: 0x2384
// Size: 0x42
function private function_1e5372e8f524bac6()
{
    if ( self.var_3574b7a060d661f5 && self.customsettings.var_9298800438db6aa9 )
    {
        return self.customsettings.var_9298800438db6aa9;
    }
    
    return level.var_9298800438db6aa9;
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0x524cc700, Offset: 0x23cf
// Size: 0x42
function private function_9467bd8902ea0fcf()
{
    if ( self.var_3574b7a060d661f5 && self.customsettings.var_3375c4f7793b4ccb )
    {
        return self.customsettings.var_3375c4f7793b4ccb;
    }
    
    return level.var_3375c4f7793b4ccb;
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0x3afc109, Offset: 0x241a
// Size: 0x42
function private function_51744da7ca1d365f()
{
    if ( self.var_3574b7a060d661f5 && self.customsettings.var_c15d0d0ad1e767fb )
    {
        return self.customsettings.var_c15d0d0ad1e767fb;
    }
    
    return level.var_c15d0d0ad1e767fb;
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0xfcfa6225, Offset: 0x2465
// Size: 0x42
function private function_ffe460127af451be()
{
    if ( self.var_3574b7a060d661f5 && self.customsettings.var_1b807c86f79fc8d6 )
    {
        return self.customsettings.var_1b807c86f79fc8d6;
    }
    
    return level.var_1b807c86f79fc8d6;
}

// Namespace ob_activity_gunship_heli
// Params 1, eflags: 0x4
// Checksum 0xafc97e75, Offset: 0x24b0
// Size: 0x131
function private function_3087df9a9466ffd0( stage )
{
    if ( self.var_3574b7a060d661f5 )
    {
        switch ( stage )
        {
            case 2:
                if ( self.customsettings.var_c915f4191eab32ec )
                {
                    return self.customsettings.var_c915f4191eab32ec;
                }
                
                break;
            case 3:
                if ( self.customsettings.var_c915f5191eab351f )
                {
                    return self.customsettings.var_c915f5191eab351f;
                }
                
                break;
            case 1:
            default:
                if ( self.customsettings.var_c915f7191eab3985 )
                {
                    return self.customsettings.var_c915f7191eab3985;
                }
                
                break;
        }
    }
    
    switch ( stage )
    {
        case 2:
            return level.var_c915f4191eab32ec;
        case 3:
            return level.var_c915f5191eab351f;
        case 1:
        default:
            return level.var_c915f7191eab3985;
    }
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0x8e3e50df, Offset: 0x25e9
// Size: 0x3b
function private function_a6d41fd61952cfd6()
{
    if ( self.var_3574b7a060d661f5 && self.customsettings.var_cb4eb8c06cf8f81a )
    {
        return self.customsettings.var_cb4eb8c06cf8f81a;
    }
    
    return 5;
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0xf9396046, Offset: 0x262d
// Size: 0x3b
function private function_a6d420d61952d209()
{
    if ( self.var_3574b7a060d661f5 && self.customsettings.var_cb4eb9c06cf8fa4d )
    {
        return self.customsettings.var_cb4eb9c06cf8fa4d;
    }
    
    return 10;
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0xee1365b4, Offset: 0x2671
// Size: 0x3e
function private function_32084a7804559548()
{
    if ( self.var_3574b7a060d661f5 && self.customsettings.var_29782ffdc8e14c0a )
    {
        return self.customsettings.var_29782ffdc8e14c0a;
    }
    
    return 2250000;
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0xc67b302c, Offset: 0x26b8
// Size: 0x3e
function private function_d5843cccdefcc686()
{
    if ( self.var_3574b7a060d661f5 && self.customsettings.var_c056e49b6917e6a8 )
    {
        return self.customsettings.var_c056e49b6917e6a8;
    }
    
    return 20250000;
}

// Namespace ob_activity_gunship_heli
// Params 0, eflags: 0x4
// Checksum 0x1b956dc8, Offset: 0x26ff
// Size: 0x42
function private function_3ccf77400c7ffb41()
{
    if ( self.var_3574b7a060d661f5 && self.customsettings.var_1be27c807e9e9d09 )
    {
        return self.customsettings.var_1be27c807e9e9d09;
    }
    
    return level.var_1be27c807e9e9d09;
}

// Namespace ob_activity_gunship_heli
// Params 1
// Checksum 0xa7fba83c, Offset: 0x274a
// Size: 0xaa
function function_545445c911873fee( player )
{
    if ( self.var_3574b7a060d661f5 )
    {
        chopperinstance = self.activityinstance;
        
        if ( chopperinstance && chopperinstance.var_3574b7a060d661f5 && chopperinstance.customsettings.var_35b35d059b17b988 )
        {
            if ( distance2dsquared( chopperinstance.spawnloc, player.origin ) < chopperinstance.var_2ce8baa3c076d66c )
            {
                return 1;
            }
        }
    }
    
    if ( distance2dsquared( self.origin, player.origin ) < 100000000 )
    {
        return 1;
    }
}

