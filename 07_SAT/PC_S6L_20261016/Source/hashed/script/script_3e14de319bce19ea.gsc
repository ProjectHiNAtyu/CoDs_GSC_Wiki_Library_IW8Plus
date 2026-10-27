// script_3e14de319bce19ea  (hash_3e14de319bce19ea.gscc) (size: 18379 Bytes / 0x47cb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x76b38efc (1991479036)
// size ...... 18379 (0x47cb)
// includes .. 7   (offset: 0x401f)
// strings ... 151 (offset: 0x4057)
// dev strs .. 0   (offset: 0x47cb)
// exports ... 19  (offset: 0x37a3)
// cseg ...... 0x10a3 + 0x2700 (0x37a3)
// imports ... 43  (offset: 0x3a9b)
// animtree1 . 0   (offset: 0x47cb)
// animtree2 . 0   (offset: 0x47cb)
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\flags;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\matchdata;
#using scripts\mp\telemetry_mp;

#namespace namespace_4c6ef5221f3fa284;

// Namespace namespace_4c6ef5221f3fa284
// Params 4
// Checksum 0x359e41ff, Offset: 0x10c1
// Size: 0x5f
function function_bd587d9af34aadfc( victim, shitloc, idamage, weapon )
{
    victimid = function_b4fb1a163d5fd3f( victim );
    
    if ( !victimid || self.combatinstances[ victimid ] )
    {
        return;
    }
    
    function_788c4ebdd65b5c58( victim, shitloc, idamage, weapon );
}

// Namespace namespace_4c6ef5221f3fa284
// Params 4
// Checksum 0xab298a5a, Offset: 0x1128
// Size: 0x54
function function_788c4ebdd65b5c58( victim, shitloc, idamage, weapon )
{
    if ( isbrgamemode() )
    {
        function_bd7f1ef327c16d49( victim, shitloc, idamage, weapon );
    }
    else
    {
        function_c7bf56be6712bef9( victim, shitloc, idamage, weapon );
    }
    
    thread function_ec0651c7bb124004( victim );
}

// Namespace namespace_4c6ef5221f3fa284
// Params 4, eflags: 0x4
// Checksum 0xc34e5c5c, Offset: 0x1184
// Size: 0xda
function private function_c7bf56be6712bef9( victim, shitloc, idamage, weapon )
{
    var_d6f5e63e4265bbd8 = function_b4fb1a163d5fd3f( victim );
    
    if ( !isdefined( var_d6f5e63e4265bbd8 ) )
    {
        return;
    }
    
    currenttimems = gettime();
    combatinstance = self.combatinstances[ var_d6f5e63e4265bbd8 ];
    var_8f599911ce2e518a = isdefined( combatinstance.var_233212b92591f939 ) && combatinstance.var_233212b92591f939 + 10000 > currenttimems;
    
    if ( !var_8f599911ce2e518a )
    {
        function_cff740337c433ad1( victim, shitloc, idamage, weapon );
        combatinstance = self.combatinstances[ var_d6f5e63e4265bbd8 ];
    }
    else
    {
        combatinstance.var_233212b92591f939 = currenttimems;
    }
    
    function_abc3e4d2902cbb01( combatinstance, self.currentweapon, weapon, shitloc );
}

// Namespace namespace_4c6ef5221f3fa284
// Params 4, eflags: 0x4
// Checksum 0x71e28c16, Offset: 0x1266
// Size: 0x15a
function private function_bd7f1ef327c16d49( victim, shitloc, idamage, weapon )
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    var_d6f5e63e4265bbd8 = function_b4fb1a163d5fd3f( victim );
    
    if ( isagent( victim ) || !isdefined( var_d6f5e63e4265bbd8 ) )
    {
        return;
    }
    
    currenttimems = gettime();
    combatinstance = self.combatinstances[ var_d6f5e63e4265bbd8 ];
    var_8f599911ce2e518a = isdefined( combatinstance.var_233212b92591f939 ) && combatinstance.var_233212b92591f939 + 10000 > currenttimems;
    
    if ( !var_8f599911ce2e518a )
    {
        function_cff740337c433ad1( victim, shitloc, idamage, weapon );
        combatinstance = self.combatinstances[ var_d6f5e63e4265bbd8 ];
    }
    else
    {
        combatinstance.var_233212b92591f939 = currenttimems;
    }
    
    currentdistance = function_f0ecea0900ef765e( self, victim );
    combatinstance.mindistance = min( combatinstance.mindistance, currentdistance );
    combatinstance.maxdistance = max( combatinstance.maxdistance, currentdistance );
    combatinstance.totaldamage += idamage;
    function_97276ef1695aec71( combatinstance, self.currentweapon, shitloc );
}

// Namespace namespace_4c6ef5221f3fa284
// Params 4, eflags: 0x4
// Checksum 0x7c8657ba, Offset: 0x13c8
// Size: 0x40c
function private function_cff740337c433ad1( victim, shitloc, idamage, weapon )
{
    currenttimems = gettime();
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"weapons" ][ #"hash_3095ace2af602519" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        primaryweaponobj = self [[ var_32dbca3143d9c4a5 ]]();
    }
    else
    {
        primaryweaponobj = undefined;
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"weapons" ][ #"hash_2331be816b77366d" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        secondaryweaponobj = self [[ var_32dbca3143d9c4a5 ]]();
    }
    else
    {
        secondaryweaponobj = undefined;
    }
    
    var_2ce81e4b0b8b1b47 = self.var_2bfcb32a8775e54.var_aa362a9ee89f24ce[ primaryweaponobj.basenamehash ] ?? 0;
    var_62ddce003d7293b7 = self.var_2bfcb32a8775e54.var_aa362a9ee89f24ce[ secondaryweaponobj.basenamehash ] ?? 0;
    var_a1b0b95ee6aea301 = victim utility::callsharedfunc( #"common_item_armor_upgrade", #"hash_10300f9a006a73f6" );
    var_258aa084444b0ae0 = utility::callsharedfunc( #"common_item_armor_upgrade", #"hash_10300f9a006a73f6" );
    struct = { #var_10164584f11c591c:var_258aa084444b0ae0.tier, #var_9bd0f521c3677736:secondaryweaponobj, #var_34a199b6a272d696:primaryweaponobj, #var_27369d7cf13cc247:0, #var_6e3f25d692cbaa97:0, #var_c2c0da55751ba2ed:int( clamp( victim.var_2dc2a207d323487a ?? -1, -2.68435e+08, 2.68435e+08 ) ), #victiminitialhealth:int( clamp( victim.health + idamage, -2.68435e+08, 2.68435e+08 ) ), #var_291a57e36661b69e:0, #var_3c1cce11f4240115:0, #var_8f8d9a39c46e1aae:var_62ddce003d7293b7, #var_29bd3f71f0c73225:var_2ce81e4b0b8b1b47, #distancestart:function_f0ecea0900ef765e( self, victim ), #var_b6981c5e3942147d:var_a1b0b95ee6aea301.tier, #var_28dddc2777a75305:victim.currentweapon.var_e4de3f79b4ac164f ?? victim.weapon.var_e4de3f79b4ac164f, #victimweapon:victim.currentweapon.basename ?? victim.weapon.basename, #islethal:1, #var_233212b92591f939:currenttimems, #combatstarttime:currenttimems, #victimdifficulty:victim.difficulty, #victimorigin:victim.origin ?? ( 0, 0, 0 ), #victimid:function_5a400f49db7a364e( victim ) };
    
    if ( isbrgamemode() )
    {
        struct.var_598147bafd5a1c2 = victim.origin[ 0 ];
        struct.var_598157bafd5a3f5 = victim.origin[ 1 ];
        struct.var_598127bafd59d5c = victim.origin[ 2 ];
        struct.var_2589aff0e4691a57 = self.origin[ 0 ];
        struct.var_2589aef0e4691824 = self.origin[ 1 ];
        struct.var_2589b1f0e4691ebd = self.origin[ 2 ];
        struct.totaldamage = 0;
        struct.mindistance = struct.distancestart;
        struct.maxdistance = struct.distancestart;
    }
    
    var_d6f5e63e4265bbd8 = function_b4fb1a163d5fd3f( victim );
    self.combatinstances[ var_d6f5e63e4265bbd8 ] = struct;
}

// Namespace namespace_4c6ef5221f3fa284
// Params 4, eflags: 0x4
// Checksum 0x133993f0, Offset: 0x17dc
// Size: 0x108
function private function_abc3e4d2902cbb01( var_6dd7e0bf8e231928, var_c4e327e64b27f7ee, overrideweapon, hitlocation )
{
    isprimaryweapon = var_c4e327e64b27f7ee.basenamehash == var_6dd7e0bf8e231928.var_34a199b6a272d696.basenamehash;
    var_b81e231624c116f4 = var_c4e327e64b27f7ee.basenamehash == var_6dd7e0bf8e231928.var_9bd0f521c3677736.basenamehash;
    var_13f20fb717677ece = !isprimaryweapon && !var_b81e231624c116f4 && overrideweapon && isweapon( overrideweapon ) && weapon_utility::isbulletweapon( overrideweapon );
    
    if ( isprimaryweapon || var_13f20fb717677ece )
    {
        var_6dd7e0bf8e231928.var_8f8d9a39c46e1aae++;
        
        if ( function_5d96d2a079feb03a( hitlocation ) )
        {
            var_6dd7e0bf8e231928.var_6e3f25d692cbaa97++;
        }
        
        return;
    }
    
    if ( var_b81e231624c116f4 )
    {
        var_6dd7e0bf8e231928.var_291a57e36661b69e++;
        
        if ( function_5d96d2a079feb03a( hitlocation ) )
        {
            var_6dd7e0bf8e231928.var_27369d7cf13cc247++;
        }
    }
}

// Namespace namespace_4c6ef5221f3fa284
// Params 1
// Checksum 0xd8dba376, Offset: 0x18ec
// Size: 0x1a3
function trylogcombatinstanceshot( attackerweaponobj )
{
    if ( isbrgamemode() && !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    var_6f6ed11809a609b4 = attackerweaponobj.basenamehash;
    
    foreach ( instance in self.combatinstances )
    {
        if ( var_6f6ed11809a609b4 == instance.var_34a199b6a272d696.basenamehash )
        {
            instance.var_29bd3f71f0c73225++;
            continue;
        }
        
        if ( var_6f6ed11809a609b4 == instance.var_9bd0f521c3677736.basenamehash )
        {
            instance.var_3c1cce11f4240115++;
        }
    }
    
    if ( !isdefined( self.var_2bfcb32a8775e54 ) )
    {
        self.var_2bfcb32a8775e54 = {};
    }
    
    if ( !isdefined( self.var_2bfcb32a8775e54.var_aa362a9ee89f24ce ) )
    {
        self.var_2bfcb32a8775e54.var_aa362a9ee89f24ce = [];
    }
    
    var_cf0f99cf3af93410 = self.var_2bfcb32a8775e54.var_aa362a9ee89f24ce;
    
    if ( !isdefined( var_cf0f99cf3af93410[ var_6f6ed11809a609b4 ] ) )
    {
        var_cf0f99cf3af93410[ var_6f6ed11809a609b4 ] = 0;
    }
    
    var_cf0f99cf3af93410[ var_6f6ed11809a609b4 ]++;
    notifystring = "tryLogCombatInstanceShot_" + var_6f6ed11809a609b4;
    self notify( notifystring );
    self endon( notifystring, #"disconnect" );
    wait 2;
    
    if ( !var_cf0f99cf3af93410[ var_6f6ed11809a609b4 ] )
    {
        return;
    }
    
    var_cf0f99cf3af93410[ var_6f6ed11809a609b4 ] = undefined;
}

// Namespace namespace_4c6ef5221f3fa284
// Params 3, eflags: 0x4
// Checksum 0xd8a150b9, Offset: 0x1a97
// Size: 0x470
function private function_97276ef1695aec71( combatinstance, currentweapon, shitloc )
{
    if ( currentweapon.basenamehash == combatinstance.var_34a199b6a272d696.basenamehash )
    {
        switch ( shitloc )
        {
            case #"hash_8a1772f5f912c880":
            case #"hash_b107b5547c755d23":
                if ( !isdefined( combatinstance.var_6e3f25d692cbaa97 ) )
                {
                    combatinstance.var_6e3f25d692cbaa97 = 0;
                }
                
                combatinstance.var_6e3f25d692cbaa97++;
                break;
            case #"hash_92bbfe494d03d772":
                if ( !isdefined( combatinstance.var_37d3648f58dbd330 ) )
                {
                    combatinstance.var_37d3648f58dbd330 = 0;
                }
                
                combatinstance.var_37d3648f58dbd330++;
                break;
            case #"hash_b275b50677dcf6cb":
                if ( !isdefined( combatinstance.var_88bd64adf95df98c ) )
                {
                    combatinstance.var_88bd64adf95df98c = 0;
                }
                
                combatinstance.var_88bd64adf95df98c++;
                break;
            case #"hash_fbb61fc356f3c75e":
                if ( !isdefined( combatinstance.var_283fc8d7417943d5 ) )
                {
                    combatinstance.var_283fc8d7417943d5 = 0;
                }
                
                combatinstance.var_283fc8d7417943d5++;
                break;
            case #"hash_1cbc508a2fe01b79":
            case #"hash_810a7426c8bac3ac":
                if ( !isdefined( combatinstance.var_821245b901f7c11 ) )
                {
                    combatinstance.var_821245b901f7c11 = 0;
                }
                
                combatinstance.var_821245b901f7c11++;
                break;
            case #"hash_7b36142458a6c2d5":
            case #"hash_a638fec9040cfcf4":
                if ( !isdefined( combatinstance.var_c6441b08cb2c13cc ) )
                {
                    combatinstance.var_c6441b08cb2c13cc = 0;
                }
                
                combatinstance.var_c6441b08cb2c13cc++;
                break;
            case #"hash_51d5d0b9add9cc5a":
            case #"hash_d42e71cd9f1e822f":
                if ( !isdefined( combatinstance.var_b4b6af92d80fde57 ) )
                {
                    combatinstance.var_b4b6af92d80fde57 = 0;
                }
                
                combatinstance.var_b4b6af92d80fde57++;
                break;
            case #"hash_5d5aac570f6fd382":
            case #"hash_a7980c387477e7bb":
                if ( !isdefined( combatinstance.var_1ebd3027679603c2 ) )
                {
                    combatinstance.var_1ebd3027679603c2 = 0;
                }
                
                combatinstance.var_1ebd3027679603c2++;
                break;
            default:
                if ( !isdefined( combatinstance.var_f3737518bf1344d5 ) )
                {
                    combatinstance.var_f3737518bf1344d5 = 0;
                }
                
                combatinstance.var_f3737518bf1344d5++;
                break;
        }
        
        combatinstance.var_8f8d9a39c46e1aae++;
        return;
    }
    
    if ( currentweapon.basenamehash == combatinstance.var_9bd0f521c3677736.basenamehash )
    {
        switch ( shitloc )
        {
            case #"hash_8a1772f5f912c880":
            case #"hash_b107b5547c755d23":
                if ( !isdefined( combatinstance.var_27369d7cf13cc247 ) )
                {
                    combatinstance.var_27369d7cf13cc247 = 0;
                }
                
                combatinstance.var_27369d7cf13cc247++;
                break;
            case #"hash_92bbfe494d03d772":
                if ( !isdefined( combatinstance.var_a87554aed9a53d60 ) )
                {
                    combatinstance.var_a87554aed9a53d60 = 0;
                }
                
                combatinstance.var_a87554aed9a53d60++;
                break;
            case #"hash_24df6c1a53c03c53":
                if ( !isdefined( combatinstance.var_e85bd1e472632a5c ) )
                {
                    combatinstance.var_e85bd1e472632a5c = 0;
                }
                
                combatinstance.var_e85bd1e472632a5c++;
                break;
            case #"hash_aa63b4eb30a83f7a":
                if ( !isdefined( combatinstance.var_6609bd71147c5025 ) )
                {
                    combatinstance.var_6609bd71147c5025 = 0;
                }
                
                combatinstance.var_6609bd71147c5025++;
                break;
            case #"hash_86d069a9bd083804":
                if ( !isdefined( combatinstance.var_46998dd2c425a01 ) )
                {
                    combatinstance.var_46998dd2c425a01 = 0;
                }
                
                combatinstance.var_46998dd2c425a01++;
                break;
            case #"hash_713cfc12ca4421d9":
                if ( !isdefined( combatinstance.var_c8ea16f168ca3c3c ) )
                {
                    combatinstance.var_c8ea16f168ca3c3c = 0;
                }
                
                combatinstance.var_c8ea16f168ca3c3c++;
                break;
            case #"hash_acfb90a9d1526a42":
                if ( !isdefined( combatinstance.var_b0bf4281649c3b27 ) )
                {
                    combatinstance.var_b0bf4281649c3b27 = 0;
                }
                
                combatinstance.var_b0bf4281649c3b27++;
                break;
            case #"hash_c12ea512f3bb658f":
                if ( !isdefined( combatinstance.var_6f37c28226fc7852 ) )
                {
                    combatinstance.var_6f37c28226fc7852 = 0;
                }
                
                combatinstance.var_6f37c28226fc7852++;
                break;
        }
        
        combatinstance.var_291a57e36661b69e++;
    }
}

// Namespace namespace_4c6ef5221f3fa284
// Params 1, eflags: 0x4
// Checksum 0x1b5da607, Offset: 0x1f0f
// Size: 0xd4
function private function_ec0651c7bb124004( victim )
{
    attacker = self;
    attacker endon( #"disconnect" );
    var_d6f5e63e4265bbd8 = function_b4fb1a163d5fd3f( victim );
    
    if ( !var_d6f5e63e4265bbd8 )
    {
        return;
    }
    
    combatinstance = attacker.combatinstances[ var_d6f5e63e4265bbd8 ];
    combatstarttime = combatinstance.combatstarttime;
    
    if ( combatstarttime != gettime() )
    {
        attacker notify( #"hash_74ebd63ef955d45a", string( var_d6f5e63e4265bbd8 ) );
    }
    
    attacker endon( #"hash_74ebd63ef955d45a", string( var_d6f5e63e4265bbd8 ) );
    wait 4;
    
    if ( !combatinstance )
    {
        return;
    }
    
    combatinstance.islethal = 0;
    
    if ( isbrgamemode() )
    {
        attacker thread function_31dbee8b223e11ce( victim );
        return;
    }
    
    attacker thread function_914a94e95f5cd13a( victim );
}

// Namespace namespace_4c6ef5221f3fa284
// Params 1, eflags: 0x4
// Checksum 0x85c2ba5e, Offset: 0x1feb
// Size: 0x95
function private function_cd76683003b58008( var_6dd7e0bf8e231928 )
{
    wait 0.5;
    
    if ( !isdefined( level.gametypebundle.var_a496cefd81aba25c ) )
    {
        level.gametypebundle.var_a496cefd81aba25c = #"nowait";
    }
    
    switch ( level.gametypebundle.var_a496cefd81aba25c )
    {
        case #"nowait":
            break;
        case #"slowprocessing":
        default:
            script::waittillslowprocessallowed( 1, 1 );
            break;
    }
}

// Namespace namespace_4c6ef5221f3fa284
// Params 2, eflags: 0x4
// Checksum 0x93fb6129, Offset: 0x2088
// Size: 0xc66
function private function_dceeb79e247a8caf( victim, combatinstance )
{
    if ( combatinstance.var_29bd3f71f0c73225 > 0 )
    {
        accuracyratio = combatinstance.var_8f8d9a39c46e1aae / combatinstance.var_29bd3f71f0c73225;
        var_39e132fd59a84f11 = int( clamp( accuracyratio * 100, 0, 100 ) );
    }
    else
    {
        var_39e132fd59a84f11 = 0;
    }
    
    if ( combatinstance.var_3c1cce11f4240115 > 0 )
    {
        accuracyratio = combatinstance.var_291a57e36661b69e / combatinstance.var_3c1cce11f4240115;
        var_60f10085339016e1 = int( clamp( accuracyratio * 100, 0, 100 ) );
    }
    else
    {
        var_60f10085339016e1 = 0;
    }
    
    curtime = gettime();
    combatduration = ( curtime - combatinstance.combatstarttime ) / 1000;
    primarytuning = telemetry_mp::function_fa62c051bd819627( combatinstance.var_34a199b6a272d696 );
    secondarytuning = telemetry_mp::function_fa62c051bd819627( combatinstance.var_9bd0f521c3677736 );
    var_6c2c150894af98a9 = self getplayermovementstate();
    victim.var_2dc2a207d323487a = undefined;
    distancefinal = function_f0ecea0900ef765e( self, victim );
    fields = [ "match_time_ms", matchdata::gettimefrommatchstart( gettime() ), "combat_duration", combatduration, "attacker_weapon_primary", combatinstance.var_34a199b6a272d696.basename ?? "", "attacker_accuracy_primary", var_39e132fd59a84f11, "victim_weapon", combatinstance.victimweapon, "distance_start", combatinstance.distancestart, "distance_final", distancefinal, "is_lethal", combatinstance.islethal, "attacker_is_ads", var_6c2c150894af98a9.isads, "attacker_is_meat_shield", var_6c2c150894af98a9.ismeatshield, "attacker_is_meat_shield_victim", var_6c2c150894af98a9.ismeatshieldvictim, "attacker_is_meat_shield_attacker", var_6c2c150894af98a9.ismeatshieldattacker, "attacker_is_supine", var_6c2c150894af98a9.issupine, "attacker_is_prone", var_6c2c150894af98a9.isprone, "attacker_is_crouch", var_6c2c150894af98a9.iscrouch, "attacker_is_mantle", var_6c2c150894af98a9.ismantle, "attacker_is_dtp", var_6c2c150894af98a9.isdivetoprone, "attacker_is_non_forward_dtp", var_6c2c150894af98a9.var_b30d6737b826b6d9, "attacker_is_walk", var_6c2c150894af98a9.iswalk, "attacker_is_sprint", var_6c2c150894af98a9.issprint, "attacker_is_non_forward_sprint", var_6c2c150894af98a9.var_50a5c93322d764b6, "attacker_is_slide", var_6c2c150894af98a9.isslide, "attacker_is_non_forward_slide", var_6c2c150894af98a9.var_b470e64cd4f4930f, "attacker_is_active_roll", var_6c2c150894af98a9.var_970e028f986ace43, "attacker_is_wall_run", var_6c2c150894af98a9.iswallrun, "attacker_is_in_air", var_6c2c150894af98a9.isinair, "attacker_is_jump", var_6c2c150894af98a9.isjump, "attacker_is_wall_jump", var_6c2c150894af98a9.iswalljump, "attacker_is_double_jump", var_6c2c150894af98a9.isdoublejump, "attacker_weapon_secondary", combatinstance.var_9bd0f521c3677736.basename ?? "", "attacker_accuracy_secondary", var_60f10085339016e1, "total_shots_primary", combatinstance.var_29bd3f71f0c73225, "total_shots_secondary", combatinstance.var_3c1cce11f4240115, "victim_initial_health", float( combatinstance.victiminitialhealth ) ?? -1, "victim_initial_armor", float( combatinstance.var_c2c0da55751ba2ed ) ?? -1, "attacker_headshots_primary", combatinstance.var_6e3f25d692cbaa97, "attacker_headshots_secondary", combatinstance.var_27369d7cf13cc247, "primary_weapon_receiver", primarytuning.weapon_receiver, "primary_weapon_front_piece", primarytuning.weapon_front_piece, "primary_weapon_back_piece", primarytuning.weapon_back_piece, "primary_weapon_magazine", primarytuning.weapon_magazine, "primary_weapon_optic", primarytuning.weapon_optic, "primary_weapon_underbarrel", primarytuning.weapon_underbarrel, "primary_weapon_modifier", primarytuning.weapon_modifier, "primary_weapon_muzzle", primarytuning.weapon_muzzle, "primary_weapon_rear_grip", primarytuning.weapon_rear_grip, "primary_weapon_trigger", primarytuning.weapon_trigger, "primary_weapon_extra", primarytuning.weapon_extra, "primary_lid_receiver", primarytuning.lid_receiver, "primary_lid_front_piece", primarytuning.lid_front_piece, "primary_lid_back_piece", primarytuning.lid_back_piece, "primary_lid_magazine", primarytuning.lid_magazine, "primary_lid_optic", primarytuning.lid_optic, "primary_lid_underbarrel", primarytuning.lid_underbarrel, "primary_lid_modifier", primarytuning.lid_modifier, "primary_lid_muzzle", primarytuning.lid_muzzle, "primary_lid_rear_grip", primarytuning.lid_rear_grip, "primary_lid_trigger", primarytuning.lid_trigger, "primary_lid_extra", primarytuning.lid_extra, "primary_tv_receiver", primarytuning.tv_receiver, "primary_tv_front_piece", primarytuning.tv_front_piece, "primary_tv_back_piece", primarytuning.tv_back_piece, "primary_tv_magazine", primarytuning.tv_magazine, "primary_tv_optic", primarytuning.tv_optic, "primary_tv_underbarrel", primarytuning.tv_underbarrel, "primary_tv_modifier", primarytuning.tv_modifier, "primary_tv_muzzle", primarytuning.tv_muzzle, "primary_tv_rear_grip", primarytuning.tv_rear_grip, "primary_tv_trigger", primarytuning.tv_trigger, "primary_tv_extra", primarytuning.tv_extra, "secondary_weapon_receiver", secondarytuning.weapon_receiver, "secondary_weapon_front_piece", secondarytuning.weapon_front_piece, "secondary_weapon_back_piece", secondarytuning.weapon_back_piece, "secondary_weapon_magazine", secondarytuning.weapon_magazine, "secondary_weapon_optic", secondarytuning.weapon_optic, "secondary_weapon_underbarrel", secondarytuning.weapon_underbarrel, "secondary_weapon_modifier", secondarytuning.weapon_modifier, "secondary_weapon_muzzle", secondarytuning.weapon_muzzle, "secondary_weapon_rear_grip", secondarytuning.weapon_rear_grip, "secondary_weapon_trigger", secondarytuning.weapon_trigger, "secondary_weapon_extra", secondarytuning.weapon_extra, "secondary_lid_receiver", secondarytuning.lid_receiver, "secondary_lid_front_piece", secondarytuning.lid_front_piece, "secondary_lid_back_piece", secondarytuning.lid_back_piece, "secondary_lid_magazine", secondarytuning.lid_magazine, "secondary_lid_optic", secondarytuning.lid_optic, "secondary_lid_underbarrel", secondarytuning.lid_underbarrel, "secondary_lid_modifier", secondarytuning.lid_modifier, "secondary_lid_muzzle", secondarytuning.lid_muzzle, "secondary_lid_rear_grip", secondarytuning.lid_rear_grip, "secondary_lid_trigger", secondarytuning.lid_trigger, "secondary_lid_extra", secondarytuning.lid_extra, "secondary_tv_receiver", secondarytuning.tv_receiver, "secondary_tv_front_piece", secondarytuning.tv_front_piece, "secondary_tv_back_piece", secondarytuning.tv_back_piece, "secondary_tv_magazine", secondarytuning.tv_magazine, "secondary_tv_optic", secondarytuning.tv_optic, "secondary_tv_underbarrel", secondarytuning.tv_underbarrel, "secondary_tv_modifier", secondarytuning.tv_modifier, "secondary_tv_muzzle", secondarytuning.tv_muzzle, "secondary_tv_rear_grip", secondarytuning.tv_rear_grip, "secondary_tv_trigger", secondarytuning.tv_trigger, "secondary_tv_extra", secondarytuning.tv_extra ];
    
    if ( isagent( victim ) )
    {
        attackerweaponobj = self getcurrentweapon();
        
        if ( isplayer( self ) && attackerweaponobj )
        {
            var_c3604786bac2c17c = item_weapon::function_92b8514cdacab7f9( attackerweaponobj );
        }
        
        if ( attackerweaponobj.basenamehash == combatinstance.var_34a199b6a272d696.basenamehash )
        {
            weaponselect = 1;
        }
        else if ( attackerweaponobj.basenamehash == combatinstance.var_9bd0f521c3677736.basenamehash )
        {
            weaponselect = 2;
        }
        else
        {
            weaponselect = 0;
        }
        
        fields[ fields.size ] = "victim";
        fields[ fields.size ] = victim.classname;
        fields[ fields.size ] = "victim_difficulty";
        fields[ fields.size ] = combatinstance.victimdifficulty ?? "";
        fields[ fields.size ] = "attacker_dmg_upgrade";
        fields[ fields.size ] = int( self.activeskills[ #"damage_upgrade" ] ?? -1 ) + 1;
        fields[ fields.size ] = "attacker_weapon_rarity";
        fields[ fields.size ] = int( var_c3604786bac2c17c.rarity ?? 0 );
        fields[ fields.size ] = "weapon_select";
        fields[ fields.size ] = weaponselect;
    }
    else
    {
        fields[ fields.size ] = "victim";
        fields[ fields.size ] = victim;
    }
    
    return fields;
}

// Namespace namespace_4c6ef5221f3fa284
// Params 1
// Checksum 0x82aa91d4, Offset: 0x2cf7
// Size: 0xa0
function function_914a94e95f5cd13a( victim )
{
    self endon( #"disconnect" );
    var_d6f5e63e4265bbd8 = function_b4fb1a163d5fd3f( victim );
    combatinstance = self.combatinstances[ var_d6f5e63e4265bbd8 ];
    function_cd76683003b58008( combatinstance );
    
    if ( !isdefined( combatinstance ) )
    {
        return;
    }
    
    if ( !isdefined( victim ) )
    {
        return;
    }
    
    fields = function_dceeb79e247a8caf( victim, combatinstance );
    
    if ( isagent( victim ) )
    {
        self dlog_recordplayerevent( "dlog_event_ai_combat_instance", fields );
    }
    else
    {
        self dlog_recordplayerevent( "dlog_event_mp_combat_instance", fields );
    }
    
    self.combatinstances[ var_d6f5e63e4265bbd8 ] = undefined;
}

// Namespace namespace_4c6ef5221f3fa284
// Params 1
// Checksum 0x50006c65, Offset: 0x2d9f
// Size: 0x78b
function function_31dbee8b223e11ce( victim )
{
    if ( isbrgamemode() && !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    if ( !isdefined( victim ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    distancefinal = function_f0ecea0900ef765e( self, victim );
    curtime = gettime();
    var_d6f5e63e4265bbd8 = function_b4fb1a163d5fd3f( victim );
    instance = self.combatinstances[ var_d6f5e63e4265bbd8 ];
    function_cd76683003b58008();
    
    if ( !instance )
    {
        return;
    }
    
    if ( !isdefined( victim ) )
    {
        return;
    }
    
    combatduration = ( curtime - instance.combatstarttime ) / 1000;
    
    if ( instance.var_29bd3f71f0c73225 > 0 )
    {
        accuracyratio = instance.var_8f8d9a39c46e1aae / instance.var_29bd3f71f0c73225;
        var_39e132fd59a84f11 = int( clamp( accuracyratio * 100, 0, 100 ) );
    }
    else
    {
        var_39e132fd59a84f11 = 0;
    }
    
    if ( instance.var_3c1cce11f4240115 > 0 )
    {
        accuracyratio = instance.var_291a57e36661b69e / instance.var_3c1cce11f4240115;
        var_60f10085339016e1 = int( clamp( accuracyratio * 100, 0, 100 ) );
    }
    else
    {
        var_60f10085339016e1 = 0;
    }
    
    self dlog_recordplayerevent( "dlog_event_br_combat_instance", [ "victim", victim, "match_time_ms", matchdata::gettimefrommatchstart( gettime() ), "combat_duration", combatduration, "attacker_weapon_primary", instance.var_34a199b6a272d696.basename ?? "", "attacker_accuracy_primary", var_39e132fd59a84f11, "attacker_weapon_secondary", instance.var_9bd0f521c3677736.basename ?? "", "attacker_accuracy_secondary", var_60f10085339016e1, "victim_weapon", instance.victimweapon, "distance_start", instance.distancestart, "distance_final", distancefinal ?? 0, "min_distance", instance.mindistance ?? 0, "max_distance", instance.maxdistance ?? 0, "is_lethal", instance.islethal, "total_shots_primary", instance.var_29bd3f71f0c73225, "total_shots_secondary", instance.var_3c1cce11f4240115, "victim_initial_health", int( instance.victiminitialhealth ) ?? -1, "victim_initial_armor", int( instance.var_c2c0da55751ba2ed ) ?? -1, "attacker_headshots_primary", instance.var_6e3f25d692cbaa97, "attacker_headshots_secondary", instance.var_27369d7cf13cc247, "attacker_neck_shots_primary", instance.var_37d3648f58dbd330 ?? 0, "attacker_neck_shots_secondary", instance.var_a87554aed9a53d60 ?? 0, "attacker_upper_torso_shots_primary", instance.var_88bd64adf95df98c ?? 0, "attacker_upper_torso_shots_secondary", instance.var_e85bd1e472632a5c ?? 0, "attacker_lower_torso_shots_primary", instance.var_283fc8d7417943d5 ?? 0, "attacker_lower_torso_shots_secondary", instance.var_6609bd71147c5025 ?? 0, "attacker_upper_arm_shots_primary", instance.var_b4b6af92d80fde57 ?? 0, "attacker_upper_arm_shots_secondary", instance.var_b0bf4281649c3b27 ?? 0, "attacker_lower_arm_shots_primary", instance.var_1ebd3027679603c2 ?? 0, "attacker_lower_arm_shots_secondary", instance.var_6f37c28226fc7852 ?? 0, "attacker_upper_leg_shots_primary", instance.var_821245b901f7c11 ?? 0, "attacker_upper_leg_shots_secondary", instance.var_46998dd2c425a01 ?? 0, "attacker_lower_leg_shots_primary", instance.var_c6441b08cb2c13cc ?? 0, "attacker_lower_leg_shots_secondary", instance.var_c8ea16f168ca3c3c ?? 0, "attacker_other_loc_shots_primary", instance.var_f3737518bf1344d5 ?? 0, "attacker_other_loc_shots_secondary", instance.var_b77c16dc0cd5bc85 ?? 0, "initial_victim_x", instance.var_598147bafd5a1c2 ?? 0, "initial_victim_y", instance.var_598157bafd5a3f5 ?? 0, "initial_victim_z", instance.var_598127bafd59d5c ?? 0, "initial_attacker_x", instance.var_2589aff0e4691a57 ?? 0, "initial_attacker_y", instance.var_2589aef0e4691824 ?? 0, "initial_attacker_z", instance.var_2589b1f0e4691ebd ?? 0, "final_victim_x", victim.origin[ 0 ] ?? 0, "final_victim_y", victim.origin[ 1 ] ?? 0, "final_victim_z", victim.origin[ 2 ] ?? 0, "final_attacker_x", self.origin[ 0 ] ?? 0, "final_attacker_y", self.origin[ 1 ] ?? 0, "final_attacker_z", self.origin[ 2 ] ?? 0, "total_damage", instance.totaldamage ?? 0, "attacker_primary_weapon_rarity", instance.var_34a199b6a272d696.var_e4de3f79b4ac164f ?? -1, "attacker_secondary_weapon_rarity", instance.var_9bd0f521c3677736.var_e4de3f79b4ac164f ?? -1, "victim_weapon_rarity", instance.var_28dddc2777a75305 ?? -1, "attacker_armor_upgrade_level", instance.var_10164584f11c591c ?? 0, "victim_armor_upgrade_level", instance.var_b6981c5e3942147d ?? 0 ] );
    
    if ( isdefined( var_d6f5e63e4265bbd8 ) && isdefined( self.combatinstances[ var_d6f5e63e4265bbd8 ] ) )
    {
        self.combatinstances[ var_d6f5e63e4265bbd8 ] = undefined;
    }
    
    if ( isdefined( victim ) && isdefined( victim.var_2dc2a207d323487a ) )
    {
        victim.var_2dc2a207d323487a = undefined;
    }
}

// Namespace namespace_4c6ef5221f3fa284
// Params 0
// Checksum 0x1067f23c, Offset: 0x3532
// Size: 0xf1
function function_44a00dc3f336bca6()
{
    currenttimems = gettime();
    
    if ( currenttimems < ( self.var_81da901bb4289e41 ?? 0 ) || !isarray( self.combatinstances ) )
    {
        return;
    }
    
    self.var_81da901bb4289e41 = currenttimems + 60000 + randomintrange( 1000, 5000 );
    
    foreach ( var_778ab967be99baad, instance in self.combatinstances )
    {
        var_b2d8966312c7d4bd = currenttimems - ( instance.var_233212b92591f939 ?? 0 );
        
        if ( var_b2d8966312c7d4bd >= 60000 )
        {
            self.combatinstances[ var_778ab967be99baad ] = undefined;
        }
    }
}

// Namespace namespace_4c6ef5221f3fa284
// Params 1
// Checksum 0x35bcc96, Offset: 0x362b
// Size: 0x46, Type: bool
function function_5d96d2a079feb03a( shitloc )
{
    if ( !shitloc )
    {
        return false;
    }
    
    switch ( shitloc )
    {
        case #"hash_8a1772f5f912c880":
        case #"hash_92bbfe494d03d772":
        case #"hash_b107b5547c755d23":
            return true;
    }
    
    return false;
}

// Namespace namespace_4c6ef5221f3fa284
// Params 2, eflags: 0x4
// Checksum 0xcf9e70df, Offset: 0x367a
// Size: 0x57
function private function_f0ecea0900ef765e( playera, playerb )
{
    if ( isdefined( playera.origin ) && isdefined( playerb.origin ) )
    {
        return distance( playera.origin, playerb.origin );
    }
    
    return -1;
}

// Namespace namespace_4c6ef5221f3fa284
// Params 1, eflags: 0x4
// Checksum 0x5c8da9ec, Offset: 0x36d9
// Size: 0x6b
function private function_b4fb1a163d5fd3f( victim )
{
    if ( level.var_36cf9f43f205635c && isagent( victim ) )
    {
        return victim getentitynumber();
    }
    
    if ( isplayer( victim ) )
    {
        lifeindex = victim.lifeid % 256;
        victimid = victim.clientid + ( lifeindex << 16 );
        return victimid;
    }
}

// Namespace namespace_4c6ef5221f3fa284
// Params 1, eflags: 0x4
// Checksum 0x6544f6bd, Offset: 0x374d
// Size: 0x55
function private function_5a400f49db7a364e( player )
{
    playerid = player.clientid;
    
    if ( level.var_36cf9f43f205635c && isagent( player ) )
    {
        playerid = player.classname + "_" + player getentitynumber();
    }
    
    return playerid;
}

