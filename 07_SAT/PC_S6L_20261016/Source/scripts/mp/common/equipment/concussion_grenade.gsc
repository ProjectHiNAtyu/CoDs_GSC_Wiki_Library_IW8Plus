// scripts\mp\common\equipment\concussion_grenade.gsc  (hash_6bc35f11e905835a.gscc) (size: 10585 Bytes / 0x2959 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x668c86a2 (1720485538)
// size ...... 10585 (0x2959)
// includes .. 29  (offset: 0x26c9)
// strings ... 24  (offset: 0x27b1)
// dev strs .. 1   (offset: 0x294d)
// exports ... 17  (offset: 0x19b1)
// cseg ...... 0x1f4 + 0x17bd (0x19b1)
// imports ... 89  (offset: 0x1c59)
// animtree1 . 0   (offset: 0x2959)
// animtree2 . 0   (offset: 0x2959)
#using script_16ea1b94f0f381b3;
#using script_74b851b7aa1ef32d;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\status_effects\status_tracking;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\claymore;
#using scripts\mp\common\perks\perkfunctions;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\events;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace concussion_grenade;

// Namespace concussion_grenade
// Params 0, eflags: 0x1
// Checksum 0x3244fc6b, Offset: 0x212
// Size: 0x96
function autoexec concussion_init()
{
    utility::flag_wait( "equipment_initialized" );
    perkfunctions::function_deeb2f40153920c7( "concussion_grenade" );
    callback::add( #"player_laststand", &onplayerlaststand );
    callback::add( #"hash_244314ef9125e636", &onplayerdeath );
    callback::add( #"hash_2efd4eae7229b871", &onagentdeath );
    weapons::registerusedcallback( "concussion_grenade", &concussionused );
    equipment_mp::registercallback( "equip_concussion", "onPlayerDamaged", &onplayerdamaged );
    equipment_mp::registercallback( "equip_concussion", "onFired", &onfired );
}

// Namespace concussion_grenade
// Params 3
// Checksum 0xca8cf6f3, Offset: 0x2b0
// Size: 0x44
function onfired( equipmentref, slot, objweapon )
{
    challenges::function_3d7a169dbae062fb( "equip_concussion", self, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
}

// Namespace concussion_grenade
// Params 2
// Checksum 0x6470434b, Offset: 0x2fc
// Size: 0xf2
function concussionused( grenade, isgl )
{
    bundle = level.equipment.table[ "equip_concussion" ].bundle;
    
    if ( !isdefined( level.equipment.table[ "equip_concussion" ].effect_duration ) )
    {
        level.equipment.table[ "equip_concussion" ].effect_duration = bundle.stun_dur_base;
    }
    
    grenade.var_8cd831a3c0cc9bdc = level status_tracking::function_25399da4af77eea1();
    grenade thread script::notifyafterframeend( "death", "end_explode" );
    grenade endon( #"end_explode" );
    grenade waittill( #"explode", position );
    grenade thread onexplode( self, position );
}

// Namespace concussion_grenade
// Params 2
// Checksum 0x77306106, Offset: 0x3f6
// Size: 0x304
function onexplode( owner, position )
{
    if ( !( isdefined( owner ) && isdefined( position ) ) )
    {
        return;
    }
    
    allmines = weapon::function_3aafcaf7ff6dea9e();
    
    foreach ( mine in allmines )
    {
        if ( mine.equipmentref != "equip_claymore" )
        {
            continue;
        }
        
        if ( !player_utility::playersareenemies( owner, mine.owner ) )
        {
            continue;
        }
        
        if ( isdefined( mine.bundle ) && mine.bundle.var_22b86c8d081740dd )
        {
            mine thread claymore::claymore_explode( owner );
        }
        
        if ( distancesquared( position, mine.origin ) < 262144 )
        {
            if ( isdefined( mine.bundle ) && mine.bundle.var_22b86c8d081740dd )
            {
                mine thread claymore::claymore_explode( owner );
                continue;
            }
            
            mine thread claymore::claymore_stunned( owner );
        }
    }
    
    gametypexhash = getxhash( game_utility::getgametype() );
    entities = getentarrayinradius( undefined, undefined, position, 512 );
    explosiontime = gettime();
    
    foreach ( guy in entities )
    {
        if ( !isagent( guy ) )
        {
            continue;
        }
        
        guy notify( #"flashbang", guy.origin, 1, 1, owner, "axis" );
        
        if ( guy.unittype == "zombie" )
        {
            guy.var_a8e9ab5fba96d982 = 1;
            
            if ( game_utility::function_c446c60d2979dbfe() )
            {
                guy utility::callsharedfunc( #"zombie", #"stunZombie", 5, "stunned_on" );
                guy callback::callback( "on_ai_stunned", { #duration:5 } );
            }
            else if ( gametypexhash == #"koth_horde" || gametypexhash == #"br" )
            {
                guy utility::callsharedfunc( #"zombie", #"stunZombie", 5 );
            }
            
            continue;
        }
        
        if ( guy.unittype )
        {
            guy utility::function_bd0b9675b52892fd( owner getentitynumber(), explosiontime, self.weapon_object );
            guy thread weapon_utility::function_3044cc8c7b9a712a( 5, explosiontime );
        }
    }
}

// Namespace concussion_grenade
// Params 1
// Checksum 0x52f958e7, Offset: 0x702
// Size: 0x25c, Type: bool
function onplayerdamaged( data )
{
    victim = data.victim;
    attacker = data.attacker;
    point = data.point;
    
    if ( data.meansofdeath == "MOD_IMPACT" )
    {
        return true;
    }
    
    if ( attacker == victim && distancesquared( point, victim.origin ) > 65536 )
    {
        return false;
    }
    
    if ( !isdefined( data.inflictor ) )
    {
        return false;
    }
    
    if ( isdefined( victim.perks[ "specialty_stun_resistance" ] ) && attacker != victim )
    {
        if ( isdefined( victim.perks[ "specialty_tac_mask" ] ) )
        {
            if ( level.gamemodebundle.var_7aa3d55e72a5c0d1 == #"right" )
            {
                victim perks::function_142df1226093bce0( "specialty_tac_mask" );
            }
            else
            {
                victim perks::activateperk( "specialty_tac_mask" );
            }
        }
        else
        {
            victim perks::activateperk( "specialty_stun_resistance" );
        }
    }
    
    data.inflictor.bundle = equipment_mp::getEquipmentBundleFromWeaponName( data.inflictor.weapon_name );
    victim thread applyconcussion( data.inflictor, attacker );
    
    if ( isplayer( attacker ) )
    {
        attacker damage::combatrecordtacticalstat( "equip_concussion" );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
        {
            if ( isdefined( attacker.leaderboarddata[ "stunHits" ] ) )
            {
                attacker.leaderboarddata[ "stunHits" ] = attacker.leaderboarddata[ "stunHits" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "stunHits" ] ) )
            {
                [[ level.leaderboardfunc[ "stunHits" ] ]]( attacker, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
            
            if ( isdefined( attacker.pers[ "stunHits" ] ) )
            {
                attacker.pers[ "stunHits" ] = attacker.pers[ "stunHits" ] + 1;
            }
        }
    }
    
    return true;
}

// Namespace concussion_grenade
// Params 3
// Checksum 0x46728743, Offset: 0x967
// Size: 0x6f0
function applyconcussion( einflictor, eattacker, var_6aeb925d3115f6ba )
{
    if ( utility::isusingremote() )
    {
        return;
    }
    
    if ( self.concussionimmune )
    {
        return 0;
    }
    
    if ( !val::get( "stunned" ) )
    {
        return 0;
    }
    
    var_b5c4256fbbab368 = getxhash( game_utility::getgametype() ) == #"arena" || isbrgamemode() && eattacker br_public::isplayeringulag();
    
    if ( var_b5c4256fbbab368 )
    {
        var_d739e243ed2da400 = level.tacticaltimemod;
        var_a5a1c7d568976287 = level.tacticaltimemod;
    }
    else
    {
        if ( einflictor.bundle.var_c7709714d768097c && einflictor.weapon_object && einflictor.weapon_object hasattachmenthash( einflictor.bundle.var_c7709714d768097c ) )
        {
            var_d739e243ed2da400 = einflictor.bundle.var_67cf762f0a8cec6b;
        }
        
        if ( !isdefined( var_d739e243ed2da400 ) )
        {
            var_d739e243ed2da400 = einflictor.bundle.stun_dur_base ?? 1.5;
        }
        
        var_a5a1c7d568976287 = einflictor.bundle.stun_dur_scaled ?? 1.5;
    }
    
    var_b660048a0793257a = self == eattacker;
    
    /#
        if ( getdvarint( @"hash_6c7fd12a611ca1e8", 0 ) == 1 )
        {
            var_b660048a0793257a = 0;
        }
    #/
    
    if ( var_b660048a0793257a )
    {
        if ( var_b5c4256fbbab368 )
        {
            var_d739e243ed2da400 = max( level.tacticaltimemod - 1, 0.5 );
            var_a5a1c7d568976287 = max( level.tacticaltimemod - 1, 0.5 );
        }
        else
        {
            if ( einflictor.bundle.var_c7709714d768097c && einflictor.weapon_object && einflictor.weapon_object hasattachmenthash( einflictor.bundle.var_c7709714d768097c ) )
            {
                var_d739e243ed2da400 = einflictor.bundle.var_d7639d06a45ebb16;
            }
            
            if ( !isdefined( var_d739e243ed2da400 ) )
            {
                var_d739e243ed2da400 = einflictor.bundle.var_9f1aee3ef2c48ade ?? 2;
            }
            
            var_a5a1c7d568976287 = einflictor.bundle.var_ee8f61dcb3b772a1 ?? 2;
        }
    }
    
    scale = 1 - distance( self.origin, einflictor.origin ) / 512;
    
    if ( scale < 0 )
    {
        scale = 0;
    }
    
    if ( var_6aeb925d3115f6ba )
    {
        scale = 1;
    }
    
    if ( getxhash( game_utility::getgametype() ) == #"arena" )
    {
        time = var_d739e243ed2da400;
    }
    else
    {
        time = var_d739e243ed2da400 + var_a5a1c7d568976287 * scale;
    }
    
    time = utility::callsharedfunc( #"specialty_stun_resistance", #"applystunresistence", eattacker, self, time ) ?? time;
    challenges::function_3d7a169dbae062fb( "equip_concussion", eattacker, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" ) );
    thread gamescore::trackdebuffassistfortime( eattacker, self, "concussion_grenade_mp", time );
    eattacker notify( #"hash_aa2e1a1aa18246db" );
    self notify( #"concussed", eattacker );
    utility::setplayerstunned();
    statusguid = status_tracking::applystatus( self, eattacker, einflictor.var_8cd831a3c0cc9bdc, #"hash_6e6954baba713035" );
    thread status_tracking::function_97d762c26d26677b( self, eattacker, einflictor.var_8cd831a3c0cc9bdc, statusguid, time );
    thread weapon_utility::cleanupconcussionstun( time );
    
    if ( level.equipment.var_aeff9a3b25965912 )
    {
        callback::callback( #"hash_5bfa36b3dc1a524b", { #duration:time, #ref:"stunned", #attacker:eattacker, #victim:self, #equipment:"equip_concussion" } );
    }
    
    if ( self != eattacker )
    {
        utility::function_bd0b9675b52892fd( eattacker getentitynumber(), einflictor.birthtime, einflictor.weapon_object );
        thread weapon_utility::function_3044cc8c7b9a712a( time, einflictor.birthtime );
    }
    
    if ( isdefined( self.perks[ "specialty_tac_mask" ] ) )
    {
        var_e5e335cb1e34e530 = einflictor.bundle.var_4fc227db6624bca5 ?? %"concussion_grenade_tac_mask_mp";
        var_30958034a40139bc = einflictor.bundle.var_f12ecc51f97d8590 ? einflictor.bundle.var_f12ecc51f97d8590 * 1000 : undefined;
        shellshock_utility_cpmp::_shellshock( var_e5e335cb1e34e530, #"stun", time, 1, var_30958034a40139bc );
    }
    else if ( utility::callsharedfunc( #"gametype", #"hash_eac27f8466f4fff2", self, eattacker ) )
    {
        shellshock_utility_cpmp::_shellshock( %"concussion_grenade_flashed_mp", #"stun", time, 1 );
    }
    else if ( einflictor.bundle.var_f241fd2bd782d988 )
    {
        if ( einflictor.bundle.var_e36b84555e7df1d3 && einflictor.weapon_object && einflictor.weapon_object hasattachmenthash( einflictor.bundle.var_e36b84555e7df1d3 ) )
        {
            var_aeec9f8a3b02c8f4 = einflictor.bundle.var_6c9a158e3b6952a9;
        }
        
        if ( !isdefined( var_aeec9f8a3b02c8f4 ) )
        {
            var_aeec9f8a3b02c8f4 = einflictor.bundle.var_f241fd2bd782d988;
        }
        
        interruptdelayms = einflictor.bundle.var_f12ecc51f97d8590 * 1000;
        shellshock_utility_cpmp::_shellshock( var_aeec9f8a3b02c8f4, #"stun", time, 1, interruptdelayms );
    }
    else
    {
        thread shellshock_utility_cpmp::_shellshock( %"concussion_grenade_mp", #"stun", time, 1 );
    }
    
    player::codcastersetplayerstatuseffect( "stun", time );
    
    if ( !var_b660048a0793257a && player_utility::isenemy( eattacker ) && !isdefined( self.perks[ "specialty_tac_mask" ] ) )
    {
        eattacker namespace_5f4bb62dbf67ff87::doonactionscoreevent( 0, "concussionGrenadeHit", 0, { #objweapon:einflictor.weapon_object } );
    }
    
    if ( isplayer( self ) || isagent( self ) )
    {
        thread grantassists( eattacker, time, einflictor.weapon_object, einflictor.birthtime );
    }
    
    challengeparams = { #effectref:"stunned", #duration:time, #equipmentref:"equip_concussion", #equipmentent:einflictor, #victim:self, #attacker:eattacker };
    callback::callback( #"hash_10e686549630fd9f", challengeparams );
    return 1;
}

// Namespace concussion_grenade
// Params 4
// Checksum 0xd2aa1ea7, Offset: 0x1060
// Size: 0x152
function grantassists( owner, time, var_b268abe7525563a5, var_3856ee15d8279ef2 )
{
    utility::waittill_notify_or_timeout( "death", time );
    fromdeath = !player::isreallyalive( self );
    fromdown = player::isinlaststand( self );
    
    if ( fromdeath )
    {
        waitframe();
        
        if ( !( isdefined( self ) && isdefined( owner ) ) )
        {
            return;
        }
        else if ( isdefined( self.attackers ) )
        {
            foreach ( attacker in self.attackers )
            {
                if ( function_982377484b77a52( attacker, self, owner, var_b268abe7525563a5 ) )
                {
                    break;
                }
            }
        }
        
        if ( self.lastkilledby == owner )
        {
            owner thread gamelogic_mp::threadedsetweaponstatbyname( var_b268abe7525563a5, 1, "debuff_kills" );
            owner telemetry_mp::function_89a5d8fb8ed3a4fe( undefined, owner, var_3856ee15d8279ef2, var_b268abe7525563a5 );
        }
        else
        {
            owner thread gamelogic_mp::threadedsetweaponstatbyname( var_b268abe7525563a5, 1, "debuff_assists" );
        }
        
        return;
    }
    
    if ( fromdown )
    {
        thread waitforfinish( owner, time, var_b268abe7525563a5 );
    }
}

// Namespace concussion_grenade
// Params 3
// Checksum 0xc4048e52, Offset: 0x11ba
// Size: 0x125
function waitforfinish( owner, time, var_b268abe7525563a5 )
{
    self endon( #"disconnect" );
    self endon( #"laststand_revived" );
    self waittill( #"death" );
    waitframe();
    
    if ( !( isdefined( self ) && isdefined( owner ) ) )
    {
        return;
    }
    else if ( isdefined( self.attackers ) )
    {
        foreach ( attacker in self.attackers )
        {
            if ( function_982377484b77a52( attacker, self, owner, var_b268abe7525563a5 ) )
            {
                break;
            }
        }
    }
    
    if ( self.lastkilledby == owner )
    {
        owner thread gamelogic_mp::threadedsetweaponstatbyname( var_b268abe7525563a5, 1, "debuff_kills" );
        owner telemetry_mp::function_89a5d8fb8ed3a4fe( undefined, owner, time, var_b268abe7525563a5 );
        return;
    }
    
    owner thread gamelogic_mp::threadedsetweaponstatbyname( var_b268abe7525563a5, 1, "debuff_assists" );
}

// Namespace concussion_grenade
// Params 4
// Checksum 0x1022df20, Offset: 0x12e7
// Size: 0x7f
function function_982377484b77a52( attacker, victim, owner, var_b268abe7525563a5 )
{
    if ( !isdefined( damage::_validateattacker( attacker ) ) )
    {
        return 0;
    }
    
    if ( attacker == owner )
    {
        return 0;
    }
    
    if ( !player_utility::playersareenemies( attacker, victim ) )
    {
        return 0;
    }
    
    if ( owner.team == attacker.team )
    {
        owner thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"hash_eb6998462ad17865", var_b268abe7525563a5 );
        return 1;
    }
}

// Namespace concussion_grenade
// Params 1, eflags: 0xc
// Checksum 0x71e45513, Offset: 0x136e
// Size: 0x73
function private cleankillcount( var_4d6be7f39ac22259 )
{
    self notify( #"hash_226b84dc74a75ea6" );
    self endon( #"hash_226b84dc74a75ea6" );
    self endon( #"death_or_disconnect" );
    wait 2;
    
    if ( isdefined( self.var_f1635d8bcf7aba9b ) )
    {
        self.var_f1635d8bcf7aba9b[ var_4d6be7f39ac22259 ] = undefined;
        function_5713d46873b29625( self.var_f1635d8bcf7aba9b );
        
        if ( self.var_f1635d8bcf7aba9b.size <= 0 )
        {
            self.var_f1635d8bcf7aba9b = undefined;
        }
    }
}

// Namespace concussion_grenade
// Params 1
// Checksum 0xb3b8c62c, Offset: 0x13e9
// Size: 0x12b
function onplayerlaststand( data )
{
    attacker = data.attacker;
    victim = data.victim;
    
    if ( !function_44a1a9a0bf6b46b2( attacker, victim ) )
    {
        return;
    }
    
    function_a7e25c172287a9d5( victim, attacker );
    var_4d6be7f39ac22259 = function_92a37b88af0ef7( attacker, victim );
    
    if ( !isdefined( var_4d6be7f39ac22259 ) )
    {
        return;
    }
    
    concussionstruct = {};
    
    if ( !isdefined( data.callbackeventdata ) )
    {
        data.callbackeventdata = [];
    }
    
    data.callbackeventdata[ "concussion_grenade_mp" ] = concussionstruct;
    
    if ( attacker.var_f1635d8bcf7aba9b[ var_4d6be7f39ac22259 ] == 2 )
    {
        concussionstruct.var_daecf876616d5a3f = 1;
    }
    
    if ( attacker.var_f1635d8bcf7aba9b[ var_4d6be7f39ac22259 ] == 3 )
    {
        concussionstruct.var_7c38a4a823630f6 = 1;
    }
    
    attacker.var_7576e5f315dd11f5 = 1;
    lootid = loot::getlootidfromref( "equip_concussion" );
    attacker thread points::function_f8a0deb1a12da52e( #"stun_finished", undefined, lootid );
    attacker thread cleankillcount( var_4d6be7f39ac22259 );
}

// Namespace concussion_grenade
// Params 1, eflags: 0x4
// Checksum 0x59923201, Offset: 0x151c
// Size: 0x6f
function private onagentdeath( data )
{
    attacker = data.eattacker;
    victim = data.victim;
    
    if ( !function_44a1a9a0bf6b46b2( attacker, victim ) )
    {
        return;
    }
    
    var_4d6be7f39ac22259 = function_92a37b88af0ef7( attacker, victim );
    
    if ( !isdefined( var_4d6be7f39ac22259 ) )
    {
        return;
    }
    
    attacker.var_7576e5f315dd11f5 = 1;
}

// Namespace concussion_grenade
// Params 1
// Checksum 0x57b19159, Offset: 0x1593
// Size: 0x238
function onplayerdeath( data )
{
    attacker = data.attacker;
    victim = data.victim;
    
    if ( data.iskillstreakweapon && !weapon::function_1344ad15d2d7bd21( data.objweapon ) )
    {
        return;
    }
    
    lootid = loot::getlootidfromref( "equip_concussion" );
    
    if ( victim.inlaststand )
    {
        laststanddowneddata = victim.laststanddowneddata;
        concussionstruct = laststanddowneddata.callbackeventdata[ "concussion_grenade_mp" ];
        
        if ( !isdefined( concussionstruct ) )
        {
            return;
        }
        
        laststanddowneddata.attacker events::function_1df78f8cb7d682d0( victim.laststanddowneddata.objweapon );
        
        if ( concussionstruct.var_daecf876616d5a3f )
        {
            laststanddowneddata.attacker thread points::function_f8a0deb1a12da52e( #"double_stun", victim.laststanddowneddata.objweapon, lootid );
        }
        
        if ( concussionstruct.var_7c38a4a823630f6 )
        {
            laststanddowneddata.attacker thread points::doscoreevent( #"triple_tactical_kill", victim.laststanddowneddata.objweapon );
        }
        
        return;
    }
    
    if ( !function_44a1a9a0bf6b46b2( attacker, victim ) )
    {
        return;
    }
    
    function_a7e25c172287a9d5( victim, attacker );
    var_4d6be7f39ac22259 = function_92a37b88af0ef7( attacker, victim );
    
    if ( !isdefined( var_4d6be7f39ac22259 ) )
    {
        return;
    }
    
    attacker events::function_1df78f8cb7d682d0( data.objweapon );
    
    if ( attacker.var_f1635d8bcf7aba9b[ var_4d6be7f39ac22259 ] == 2 )
    {
        attacker thread points::function_f8a0deb1a12da52e( #"double_stun", data.objweapon, lootid );
    }
    
    if ( attacker.var_f1635d8bcf7aba9b[ var_4d6be7f39ac22259 ] == 3 )
    {
        attacker thread points::doscoreevent( #"triple_tactical_kill", data.objweapon );
    }
    
    attacker.var_7576e5f315dd11f5 = 1;
    attacker thread points::function_f8a0deb1a12da52e( #"stun_finished", undefined, lootid );
    attacker thread cleankillcount( var_4d6be7f39ac22259 );
}

// Namespace concussion_grenade
// Params 2, eflags: 0x4
// Checksum 0x127937d3, Offset: 0x17d3
// Size: 0x44, Type: bool
function private function_44a1a9a0bf6b46b2( attacker, victim )
{
    if ( !player_utility::playersareenemies( attacker, victim ) )
    {
        return false;
    }
    
    if ( !( victim.var_ce186c9e315d6ed3.attackers.size > 0 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace concussion_grenade
// Params 2, eflags: 0x4
// Checksum 0xbc1b43a, Offset: 0x1820
// Size: 0x6b
function private function_a7e25c172287a9d5( victim, attacker )
{
    if ( isdefined( victim.var_ce186c9e315d6ed3.objweapon ) )
    {
        victim thread gamelogic_mp::threadedsetweaponstatbyname( victim.var_ce186c9e315d6ed3.objweapon, 1, "killed_while_debuffed_by", undefined, attacker );
        victim.var_ce186c9e315d6ed3.objweapon = undefined;
    }
}

// Namespace concussion_grenade
// Params 2, eflags: 0x4
// Checksum 0x6f18b3d0, Offset: 0x1893
// Size: 0x11d
function private function_92a37b88af0ef7( attacker, victim )
{
    var_4d6be7f39ac22259 = undefined;
    
    foreach ( grenadeid, attackerid in victim.var_ce186c9e315d6ed3.attackers )
    {
        owner = getentbynum( attackerid );
        
        if ( !player_utility::playersareenemies( owner, victim ) )
        {
            return;
        }
        
        if ( attacker == owner )
        {
            var_4d6be7f39ac22259 = grenadeid;
            break;
        }
    }
    
    if ( !isdefined( var_4d6be7f39ac22259 ) )
    {
        return;
    }
    
    if ( !isdefined( attacker.var_f1635d8bcf7aba9b ) )
    {
        attacker.var_f1635d8bcf7aba9b = [];
    }
    
    if ( !isdefined( attacker.var_f1635d8bcf7aba9b[ var_4d6be7f39ac22259 ] ) )
    {
        attacker.var_f1635d8bcf7aba9b[ var_4d6be7f39ac22259 ] = 0;
    }
    
    attacker.var_f1635d8bcf7aba9b[ var_4d6be7f39ac22259 ]++;
    return var_4d6be7f39ac22259;
}

