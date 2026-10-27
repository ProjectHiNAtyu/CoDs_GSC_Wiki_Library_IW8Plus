// script_5ad920020447a9f3  (hash_5ad920020447a9f3.gscc) (size: 18334 Bytes / 0x479e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x133abdb2 (322616754)
// size ...... 18334 (0x479e)
// includes .. 23  (offset: 0x4326)
// strings ... 46  (offset: 0x43de)
// dev strs .. 22  (offset: 0x464e)
// exports ... 45  (offset: 0x2ce2)
// cseg ...... 0x325 + 0x29bd (0x2ce2)
// imports ... 128 (offset: 0x33ea)
// animtree1 . 0   (offset: 0x479e)
// animtree2 . 0   (offset: 0x479e)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br_dev;
#using scripts\mp\br\gametypes\br_gametype_zxp_powers;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\mutant_injection_shared;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\common\weapons\weap_manglercannon;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;

#namespace mutant_injection;

// Namespace mutant_injection
// Params 0, eflags: 0x1
// Checksum 0xf61752e, Offset: 0x343
// Size: 0x20
function autoexec main()
{
    utility::registersharedfunc( #"mutant_injection", #"init", &init );
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0xf0abcc01, Offset: 0x36b
// Size: 0x3d2
function private init()
{
    utility::registersharedfunc( #"mutant_injection", #"getconfig", &getconfig );
    utility::registersharedfunc( #"mutant_injection", #"setcontext", &setcontext );
    utility::registersharedfunc( #"mutant_injection", #"removemutantinjection", &removemutantinjection );
    utility::registersharedfunc( #"mutant_injection", #"starttransformation", &starttransformation );
    utility::registersharedfunc( #"mutant_injection", #"completetransformation", &completetransformation );
    utility::registersharedfunc( #"mutant_injection", #"overridetimeout", &function_9206f8c7dfe7c4b );
    utility::registersharedfunc( #"mutant_injection", #"jumpwatcher", &jumpwatcher );
    utility::registersharedfunc( #"mutant_injection", #"hash_2f590838fdf8226f", &updatehudoutline );
    
    if ( !level callback::exists( #"player_weapon_change", &weap_manglercannon::on_weapon_change ) )
    {
        level callback::add( #"player_weapon_change", &weap_manglercannon::on_weapon_change );
    }
    
    level.brgametype.var_3edcefa9b411aca5 = getdvarint( @"hash_fb9480083bc086fa", -1 );
    damage::function_3232791951a34daf( &onplayerdamaged );
    loadconfigs();
    
    /#
        helptext = "<dev string:x24>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"zxp" ][ #"hash_85a22f6b187c113d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( #"mutantgive", &function_a2bf54b198b90549, helptext, "<dev string:x50>" );
        }
        
        helptext = "<dev string:x57>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"zxp" ][ #"hash_85a22f6b187c113d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( #"hash_5fe875204e011420", &function_6a8687b17d5c8c56, helptext, "<dev string:x50>" );
        }
        
        helptext = "<dev string:x73>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"zxp" ][ #"hash_85a22f6b187c113d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( #"mutantforever", &function_a50223a0fdd2c1f6, helptext, "<dev string:x50>" );
        }
        
        helptext = "<dev string:x9a>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"zxp" ][ #"hash_85a22f6b187c113d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( #"mutantexit", &function_91e3b73b7c896246, helptext, "<dev string:x50>" );
        }
        
        helptext = "<dev string:xbf>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"zxp" ][ #"hash_85a22f6b187c113d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( #"hash_111207f1c56dd7b0", &function_e6c366b2febd1047, helptext, "<dev string:x50>" );
        }
        
        helptext = "<dev string:x117>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"zxp" ][ #"hash_85a22f6b187c113d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( #"hash_1dfd3cd61af66a01", &function_63c3d60c2b8a757f, helptext, "<dev string:x50>", [ "<dev string:x158>" ] );
        }
        
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"zxp" ][ #"hash_85a22f6b187c113d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( #"hash_c3db76eec1505b5b", &function_63c3d60c2b8a757f, helptext, "<dev string:x50>", [ "<dev string:x15a>" ] );
        }
        
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"zxp" ][ #"hash_85a22f6b187c113d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( #"hash_74f395c5c29d9da4", &function_63c3d60c2b8a757f, helptext, "<dev string:x50>", [ "<dev string:x15c>" ] );
        }
        
        utility::registersharedfunc( #"mutant_injection_br", #"hash_78f06b4988f69987", &function_6a8687b17d5c8c56 );
    #/
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0x3820dcd4, Offset: 0x745
// Size: 0x825
function private loadconfigs()
{
    level.brgametype.var_5789e2de3b2699ad = [];
    level.brgametype.var_8be96e9ed683d02e = 0;
    bundle = level.streakglobals.streakbundles[ "zm_minj" ];
    
    foreach ( entry in bundle.var_16b860c18d654108 )
    {
        pre_allows = [];
        pre_allows[ "crouch" ] = entry.preallowcrouch ?? 0;
        pre_allows[ "prone" ] = entry.preallowprone ?? 0;
        pre_allows[ "swimming_underwater" ] = entry.var_6a8ac652661034c8 ?? 0;
        pre_allows[ "weapon_switch" ] = entry.var_9b67077af8ed55e0 ?? 0;
        pre_allows[ "equipment_primary" ] = entry.var_f28158ffe2fc32a6 ?? 0;
        pre_allows[ "equipment_secondary" ] = entry.var_d940f68d3aae401a ?? 0;
        pre_allows[ "offhand_weapons" ] = entry.var_9a1b61eeb92774d4 ?? 0;
        pre_allows[ "mantle" ] = entry.preallowmantle ?? 0;
        pre_allows[ "dtp" ] = entry.var_700208a950b3508 ?? 0;
        pre_allows[ "slide" ] = entry.var_37b5ca286c99c535 ?? 0;
        pre_allows[ "ladder" ] = entry.preallowladder ?? 0;
        allows = [];
        allows[ "flashed" ] = entry.var_622ed88f98743467 ?? 0;
        allows[ "stunned" ] = entry.allowstun ?? 0;
        allows[ "shellshock" ] = entry.allowshellshock ?? 0;
        perks = [];
        
        foreach ( p in entry.var_8549c9d6bc6da53e )
        {
            perks[ p.name ] = 1;
        }
        
        var_1fc832d23ede3075 = hashcat( @"hash_57c8c22a462cdd49", entry.name );
        weight = getdvarfloat( var_1fc832d23ede3075, entry.var_c7e86a012cd0f126 ?? 1 );
        level.brgametype.var_8be96e9ed683d02e += weight;
        var_e08c7c1d2912a1e0 = hashcat( @"hash_36b35f2e0f3d0ed5", entry.name );
        var_5db0370f0b5fbb13 = hashcat( @"hash_d1f019f50d3c3475", entry.name );
        var_9d4b16fed2270bde = hashcat( @"hash_cdda7e1cad92b3df", entry.name );
        var_a729b01e07049266 = hashcat( @"hash_f7e790fb5821988b", entry.name );
        var_417a2b1dce593955 = hashcat( @"hash_d89ef90025ef1ee4", entry.name );
        config = { #manglercannondropweapon:bundle.mutantinjectiondata.manglercannonname ?? %"hash_7286df266856bf8", #var_60b7d5100598c47a:1000 * ( entry.var_c6c40e6e77956bb7 ?? 1.5 ), #slamradius:entry.slamradius ?? 256, #var_1e5aa7617920dcf0:entry.var_1e5aa7617920dcf0 ?? 2, #var_863bc85dae5feec3:entry.earthquakeintensity ?? 0.75, #var_9651a76dafbb86cc:entry.var_9651a76dafbb86cc ?? 1, #var_330548fdd9f02b06:entry.var_330548fdd9f02b06 ?? 1, #var_9164cddc7374290:entry.var_9164cddc7374290 ?? 1, #var_ed3bb00f13efb11e:entry.var_ed3bb00f13efb11e ?? 1, #var_745e83c4f751f4c1:entry.var_745e83c4f751f4c1 ?? 0, #var_81d5c5d515accbdf:entry.var_81d5c5d515accbdf ?? 0, #var_1caf34b6bf5f2f2c:entry.var_1caf34b6bf5f2f2c ?? 0, #slamenabled:entry.slamenabled ?? 1, #var_a7ee32896287d2fc:entry.var_a7ee32896287d2fc ?? 1, #var_1e55f971e442ed7e:entry.var_945e8b2b00407027 ?? 0, #var_e83b41245ff9aca1:entry.var_8d4c408cb2435b10 ?? 0, #var_6a168be0e4faa066:entry.var_6a168be0e4faa066 ?? 0, #var_7fad5fc3b9a96735:entry.var_7fad5fc3b9a96735, #var_c547153026652d56:entry.var_c547153026652d56 ?? 0, #var_58bcf9d6158779a5:entry.var_58bcf9d6158779a5, #var_11c7412d6ca58160:entry.var_11c7412d6ca58160 ?? -1, #var_713f9d5e379bc549:entry.var_713f9d5e379bc549, #perks:perks, #pre_allows:pre_allows, #powerconfig:getscriptbundle( entry.var_126f554790ce724e ), #operatorskin:entry.operatorskin ?? %"t10_mstr_mangler_skin", #operator:entry.operator ?? "t10_mstr_mangler", #suit:entry.suit ?? "t10_mstr_mangler_suit_mp", #var_4e6be50debfc4460:entry.var_2c3b60eac65b1646 ?? 0, #var_ced1b3d352bf76d:entry.var_27e1c837b8c3cce, #transformsound:entry.transformationsound, #speedmodifier:entry.speedmodifier ?? 1, #durationseconds:entry.durationseconds ?? 45, #var_e0f1942b94a596f2:entry.var_146009b4c047bca6 ?? 1, #var_faca7f3a94867df4:getdvarint( var_5db0370f0b5fbb13, entry.var_faca7f3a94867df4 ?? 1 ), #var_2cef2126a3f54ca9:getdvarfloat( var_e08c7c1d2912a1e0, entry.var_2cef2126a3f54ca9 ?? 100 ), #startinghealth:bundle.mutantinjectiondata.manglerhealth ?? 800, #maxhealth:bundle.mutantinjectiondata.manglerhealth ?? 800, #var_573b7ef5186ac8c6:getdvarint( var_417a2b1dce593955, entry.var_573b7ef5186ac8c6 ?? 0 ), #var_bf95338539967227:getdvarint( var_a729b01e07049266, entry.var_bf95338539967227 ?? 0 ), #var_d275b9f0df73d46f:getdvarint( var_9d4b16fed2270bde, entry.var_d275b9f0df73d46f ?? 0 ), #var_c7e86a012cd0f126:weight };
        level.brgametype.var_5789e2de3b2699ad[ level.brgametype.var_5789e2de3b2699ad.size ] = config;
    }
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0xe832c1d2, Offset: 0xf72
// Size: 0x16
function private getconfig()
{
    activeconfig = function_734c54b13b07d993();
    return activeconfig;
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0xe8375553, Offset: 0xf91
// Size: 0x156
function private function_734c54b13b07d993()
{
    if ( level.brgametype.var_3edcefa9b411aca5 >= 0 )
    {
        return level.brgametype.var_5789e2de3b2699ad[ level.brgametype.var_3edcefa9b411aca5 ];
    }
    
    if ( !isdefined( level.brgametype.var_5789e2de3b2699ad[ 0 ] ) )
    {
        assertmsg( "<dev string:x15e>" );
        return;
    }
    
    targettotal = randomfloat( level.brgametype.var_8be96e9ed683d02e );
    currenttotal = 0;
    selectedkey = 0;
    
    foreach ( key, config in level.brgametype.var_5789e2de3b2699ad )
    {
        currenttotal += config.var_c7e86a012cd0f126;
        
        if ( targettotal > currenttotal )
        {
            continue;
        }
        
        selectedkey = key;
        break;
    }
    
    return level.brgametype.var_5789e2de3b2699ad[ selectedkey ];
}

// Namespace mutant_injection
// Params 2, eflags: 0x4
// Checksum 0x36b4183b, Offset: 0x10f0
// Size: 0xfd
function private setcontext( config, streakinfo )
{
    bundle = self.micontext.bundle;
    
    if ( bundle.mutantinjectiondata.var_a75ca531128dbabf )
    {
        self.micontext.partshealth = [];
        self.micontext.partshealth[ "j_gun" ] = bundle.mutantinjectiondata.manglercannonhealth ?? 100;
    }
    
    if ( bundle.mutantinjectiondata.var_a788fb2aed1e877e )
    {
        self.micontext.removeondeath = 1;
    }
    
    self.micontext.prevhealth = self.health;
    self.micontext.prevmaxhealth = self.maxhealth;
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0xed1bf2a4, Offset: 0x11f5
// Size: 0x118
function private starttransformation()
{
    self.var_a84311e2c57646de = &function_2517d13792310bd8;
    namespace_e44a6ef6a87579b7::function_c4ee1afc2d60e20c();
    self.damagemanglercannon = &damagemanglercannon;
    self function_dcc9ada6d1887187( 1 );
    
    if ( self.micontext.removeondeath )
    {
        self.var_53fc5e1e26ae990f = &mutant_injection_shared::function_2b562b60a3d69e6f;
    }
    
    if ( self.micontext.miconfig.var_bf95338539967227 )
    {
        utility::function_32b24db3127bff40( "zm_minj_transform_in", "off" );
        waitframe();
        utility::function_32b24db3127bff40( "zm_minj_transform_in", "vfx_quick_on" );
        waitframe();
    }
    
    if ( self.micontext.miconfig.transformsound )
    {
        self playsound( self.micontext.miconfig.transformsound, undefined, self );
    }
    
    if ( self.micontext.miconfig.var_4e6be50debfc4460 )
    {
        self setscriptablepartstate( "powerBerserkVfx", "vfx_on", 0 );
    }
    
    self setclientomnvar( "ui_br_inventory_disabled", 1 );
}

// Namespace mutant_injection
// Params 2, eflags: 0x4
// Checksum 0x8a25b16e, Offset: 0x1315
// Size: 0x148
function private removemutantinjection( istimeout, skipanimation )
{
    self.var_a84311e2c57646de = undefined;
    self.damagemanglercannon = undefined;
    namespace_e44a6ef6a87579b7::function_ebc015e029431d71();
    removespeedup();
    self.var_9b3945b5e61e4c23 = undefined;
    
    if ( self.micontext.removeondeath )
    {
        self.micontext.removeondeath = undefined;
    }
    
    if ( player::isreallyalive( self ) )
    {
        resetplayerhealth();
    }
    
    if ( self.micontext.miconfig.var_573b7ef5186ac8c6 )
    {
        utility::function_32b24db3127bff40( "zm_minj_transform_out", "off" );
        waitframe();
        utility::function_32b24db3127bff40( "zm_minj_transform_out", "vfx_quick_on" );
        waitframe();
    }
    
    if ( self.micontext.miconfig.var_ced1b3d352bf76d )
    {
        self playsound( self.micontext.miconfig.var_ced1b3d352bf76d, undefined, self );
    }
    
    if ( self.micontext.miconfig.var_4e6be50debfc4460 )
    {
        self setscriptablepartstate( "powerBerserkVfx", "off", 0 );
    }
    
    self function_dcc9ada6d1887187( 0 );
    self setclientomnvar( "ui_br_inventory_disabled", 0 );
}

// Namespace mutant_injection
// Params 1, eflags: 0x4
// Checksum 0x1c612f51, Offset: 0x1465
// Size: 0x119
function private function_2517d13792310bd8( params )
{
    if ( !self.ismutantinjection || !isdefined( self.micontext.starttimems ) || function_28e74c0b0fc95636() <= 0 )
    {
        return;
    }
    
    if ( params.eattacker != self && isplayer( params.eattacker ) && player_utility::function_51a0c300008ab56b( params.eattacker, self ) )
    {
        return;
    }
    
    if ( params.smeansofdeath == "MOD_FALLING" && self.falldamageprotection )
    {
        return;
    }
    
    function_9ab95c76c268ea7c( params.idamage );
    
    if ( isplayer( params.eattacker ) && !player_utility::function_51a0c300008ab56b( params.eattacker, self ) )
    {
        damagefeedback = { #victimentity:self, #var_f561a4dd442b0d91:1 };
        params.eattacker thread damagefeedback::updatehitmarker( "standard", 0, 0, 0, undefined, 0, undefined, damagefeedback, 1 );
    }
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0x78237797, Offset: 0x1586
// Size: 0xad
function private completetransformation()
{
    self.maxhealth = self.micontext.miconfig.maxhealth;
    self.health = self.micontext.miconfig.startinghealth;
    namespace_e44a6ef6a87579b7::playerstartpowers( self.micontext.miconfig.powerconfig );
    applyspeedup();
    self.var_9b3945b5e61e4c23 = self.micontext.miconfig.var_e0f1942b94a596f2;
    thread watchforgameend();
    thread function_ec0cd0893c714743();
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0xf6c00cc2, Offset: 0x163b
// Size: 0x41
function private resetplayerhealth()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.maxhealth = self.micontext.prevmaxhealth;
    self.health = self.micontext.prevhealth;
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0x560689d7, Offset: 0x1684
// Size: 0x3e
function private watchforgameend()
{
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    level waittill( #"game_ended" );
    
    if ( isdefined( self.micontext ) )
    {
        thread mutant_injection_shared::function_2b562b60a3d69e6f( 0, 1 );
    }
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0x3e56b1f1, Offset: 0x16ca
// Size: 0x3e
function private function_ec0cd0893c714743()
{
    level endon( #"game_ended" );
    self endon( #"mutantinjection_end" );
    self waittill( #"death_or_disconnect" );
    
    if ( isdefined( self.micontext ) )
    {
        thread mutant_injection_shared::function_2b562b60a3d69e6f( 0, 1 );
    }
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0xe14058e3, Offset: 0x1710
// Size: 0x35
function private applyspeedup()
{
    common::function_a0f5c85d465c5f0a( "minjSpeed", self.micontext.miconfig.speedmodifier - 1 );
    weapons::updatemovespeedscale();
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0x861ebd5e, Offset: 0x174d
// Size: 0x23
function private removespeedup()
{
    if ( common::function_8ff835bf23198a0( "minjSpeed" ) )
    {
        common::function_d85a92c557ea5a52( "minjSpeed" );
    }
    
    weapons::updatemovespeedscale();
}

// Namespace mutant_injection
// Params 4, eflags: 0x4
// Checksum 0x29a8f5f2, Offset: 0x1778
// Size: 0x4f
function private damagemanglercannon( damage, hitloc, smeansofdeath, attacker )
{
    var_e628984c7b8aa67f = function_94b2f980f884bac3( hitloc, smeansofdeath, attacker );
    
    if ( !isdefined( var_e628984c7b8aa67f ) )
    {
        return;
    }
    
    function_cec743f91935a6e6( var_e628984c7b8aa67f, damage );
}

// Namespace mutant_injection
// Params 3, eflags: 0x4
// Checksum 0x8cc1aa77, Offset: 0x17cf
// Size: 0x6f
function private function_94b2f980f884bac3( hitloc, smeansofdeath, attacker )
{
    var_e628984c7b8aa67f = undefined;
    
    if ( damage_utility::istorsoshot( hitloc, smeansofdeath, attacker ) )
    {
        var_e628984c7b8aa67f = "j_gun";
    }
    
    /#
        if ( isdefined( hitloc ) && hitloc != "<dev string:x1c9>" && isplayer( attacker ) )
        {
            attacker iprintlnbold( "<dev string:x1ce>" + hitloc );
        }
    #/
    
    return var_e628984c7b8aa67f;
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0xb53d9368, Offset: 0x1847
// Size: 0x12b
function private function_5cdda63f595bfcbc()
{
    self endon( #"death_or_disconnect" );
    micontext = self.micontext;
    miconfig = micontext.miconfig;
    
    if ( miconfig.infiniteammo )
    {
        weapon::stopinfiniteammothread();
    }
    
    var_a441f49e346e0bd7 = miconfig.manglercannondropweapon;
    manglercannonweapon = weapon_utility::function_d2c8356dc369d9ce( var_a441f49e346e0bd7 );
    assert( isdefined( manglercannonweapon ), "<dev string:x1eb>" );
    self giveweapon( manglercannonweapon );
    droppedgun = self dropitem( manglercannonweapon );
    
    if ( !isdefined( droppedgun ) )
    {
        self takeallweapons();
        return;
    }
    
    droppedgun.objweapon = manglercannonweapon;
    droppedgun.targetname = "dropped_weapon";
    waitframe();
    self takeallweapons();
    inventory_utility::_giveweapon( level.defaultfist );
    inventory_utility::_switchtoweaponimmediate( level.defaultfist );
    weapon::fixupplayerweapons( self, level.defaultfist );
    self.micontext.partshealth[ "j_gun" ] = undefined;
    self setscriptablepartstate( "j_gun", "destroyed_loot" );
}

// Namespace mutant_injection
// Params 2, eflags: 0x4
// Checksum 0x2c97e32b, Offset: 0x197a
// Size: 0xb7
function private function_cec743f91935a6e6( part, damage )
{
    if ( isdefined( self.micontext.partshealth[ part ] ) )
    {
        self.micontext.partshealth[ part ] -= damage;
        self setscriptablepartstate( "cannon_weakpoint", "hit" );
        self setscriptablepartstate( "cannon_weakpoint", "default" );
        
        if ( self.micontext.partshealth[ part ] <= 0 )
        {
            self.micontext.partshealth[ part ] = undefined;
            thread function_5cdda63f595bfcbc();
        }
    }
}

// Namespace mutant_injection
// Params 1, eflags: 0x4
// Checksum 0xbda04ff, Offset: 0x1a39
// Size: 0x146
function private function_9206f8c7dfe7c4b( endnotes )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( isarray( endnotes ) )
    {
        foreach ( note in endnotes )
        {
            self endon( note );
        }
    }
    
    function_971d711388a0ecdc();
    self setclientomnvar( "ui_zm_zm_minj_progress", 1 );
    
    while ( true )
    {
        /#
            self.var_6259a5d0b6afaac2 = ( self.var_6259a5d0b6afaac2 ?? 0 ) % 25;
            
            if ( self.var_6259a5d0b6afaac2 == 0 )
            {
                self iprintlnbold( "<dev string:x212>" + int( function_28e74c0b0fc95636() * 0.001 ) );
            }
            
            self.var_6259a5d0b6afaac2 += 1;
        #/
        
        percentremaining = function_f90a3262a25d11a9();
        self setclientomnvar( "ui_zm_zm_minj_progress", percentremaining );
        
        if ( percentremaining <= 0 )
        {
            break;
        }
        
        waitframe();
    }
    
    endinjection( self );
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0x21975314, Offset: 0x1b87
// Size: 0xbd
function private function_971d711388a0ecdc()
{
    streakinfo = self.micontext.streakinfo;
    bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
    durationseconds = self.micontext.miconfig.durationseconds;
    durationms = durationseconds * 1000;
    starttimems = gettime();
    self.micontext.starttimems = starttimems;
    self.micontext.endtimems = starttimems + durationms;
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0xd117bf66, Offset: 0x1c4c
// Size: 0x3d
function private function_28e74c0b0fc95636()
{
    currenttimems = gettime();
    durationremainingms = max( 0, self.micontext.endtimems - currenttimems );
    return durationremainingms;
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0x94f7c2bd, Offset: 0x1c92
// Size: 0x8e
function private function_f90a3262a25d11a9()
{
    currenttimems = gettime();
    var_90507cb02dbcacfd = max( 1, self.micontext.endtimems - self.micontext.starttimems );
    durationremainingms = max( 0, self.micontext.endtimems - currenttimems );
    percentremaining = max( 0, durationremainingms / var_90507cb02dbcacfd );
    return percentremaining;
}

// Namespace mutant_injection
// Params 1, eflags: 0x4
// Checksum 0xb92a04e1, Offset: 0x1d29
// Size: 0x66
function private function_9ab95c76c268ea7c( damage )
{
    penaltyms = self.micontext.miconfig.var_2cef2126a3f54ca9 * int( damage );
    self.micontext.endtimems -= penaltyms;
}

// Namespace mutant_injection
// Params 11, eflags: 0x4
// Checksum 0x4b30b36d, Offset: 0x1d97
// Size: 0x172
function private onplayerdamaged( eattacker, einflictor, victim, idamage, objweapon, smeansofdeath, shitloc, idflags, var_cdd29ad5d1362c2, partname, unmodifieddamage )
{
    if ( victim.ismutantinjection || victim.mutantinjectiontransformed )
    {
        if ( isdefined( victim.micontext.starttimems ) && function_28e74c0b0fc95636() > 0 )
        {
            function_9ab95c76c268ea7c( idamage );
            
            if ( isplayer( eattacker ) && !player_utility::function_51a0c300008ab56b( eattacker, victim ) )
            {
                damagefeedback = { #victimentity:victim, #var_f561a4dd442b0d91:1 };
                eattacker thread damagefeedback::updatehitmarker( "standard", 0, 0, 0, undefined, 0, undefined, damagefeedback, 1 );
            }
            
            return 0;
        }
        else if ( self.micontext.miconfig.var_faca7f3a94867df4 )
        {
            if ( isplayer( eattacker ) )
            {
                damagefeedback = { #victimentity:victim, #var_f561a4dd442b0d91:1 };
                eattacker thread damagefeedback::updatehitmarker( "standard", 0, 0, 0, "hitspawnprotect", 0, undefined, damagefeedback, 1 );
            }
            
            return 0;
        }
    }
    
    return idamage;
}

// Namespace mutant_injection
// Params 1, eflags: 0x4
// Checksum 0x9853dc6, Offset: 0x1f12
// Size: 0x36
function private endinjection( player )
{
    if ( !player )
    {
        return;
    }
    
    player.mutant_injection_end_time = undefined;
    player.mutant_injection_start_time = undefined;
    player notify( #"mutant_injection_time_out" );
}

// Namespace mutant_injection
// Params 1
// Checksum 0x88ef26eb, Offset: 0x1f50
// Size: 0x20, Type: bool
function function_d6b9b1acf8eafa70( player )
{
    if ( !isdefined( player.micontext ) )
    {
        return false;
    }
    
    return true;
}

// Namespace mutant_injection
// Params 1
// Checksum 0x586b8be6, Offset: 0x1f79
// Size: 0x46
function function_bb20ab4f940b2b90( player )
{
    if ( player.micontext.miconfig )
    {
        player.micontext.miconfig.disablerefund = 1;
    }
}

// Namespace mutant_injection
// Params 1, eflags: 0x4
// Checksum 0xd8a289d3, Offset: 0x1fc7
// Size: 0x9c
function private getfriendlyplayers( targetplayer )
{
    friends = [];
    
    foreach ( player in level.players )
    {
        if ( player_utility::function_51a0c300008ab56b( targetplayer, player ) )
        {
            friends[ friends.size ] = player;
        }
    }
    
    return friends;
}

// Namespace mutant_injection
// Params 0, eflags: 0xc
// Checksum 0x292165ad, Offset: 0x206c
// Size: 0x227
function private updatehudoutline()
{
    self notify( #"hash_5c95b012ba922bee" );
    self endon( #"hash_5c95b012ba922bee" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    var_e1f95f48d2da4441 = self.micontext.miconfig.var_20e51f41bdcbc7d;
    var_1a6852d016b6599a = self.micontext.miconfig.var_1e55f971e442ed7e;
    var_39c56ebd8e7993d9 = self.micontext.miconfig.var_a7ee32896287d2fc;
    
    if ( !var_1a6852d016b6599a && !var_e1f95f48d2da4441 )
    {
        return;
    }
    
    hudoutlineplayers = [];
    
    while ( self.ismutantinjection )
    {
        foreach ( player in level.players )
        {
            if ( !var_1a6852d016b6599a && player_utility::function_51a0c300008ab56b( self, player ) )
            {
                continue;
            }
            
            if ( isbot( player ) )
            {
                continue;
            }
            
            if ( !isalive( player ) )
            {
                hudoutlineplayers = disable_hudoutline( player, hudoutlineplayers );
                continue;
            }
            
            if ( self == player )
            {
                continue;
            }
            
            need_outline = 0;
            var_f163a397f7bb2a05 = var_39c56ebd8e7993d9 && player br_public::playeriszombie();
            
            if ( !var_f163a397f7bb2a05 )
            {
                distancesq = distancesquared( self.origin, player.origin );
                
                if ( distancesq >= 10000 && distancesq <= 1000000 )
                {
                    need_outline = 1;
                }
            }
            
            if ( need_outline )
            {
                hudoutlineplayers = enable_hudoutline( player, "outlinefill_enemy_hvt", hudoutlineplayers );
                continue;
            }
            
            hudoutlineplayers = disable_hudoutline( player, hudoutlineplayers );
        }
        
        wait 0.5;
    }
    
    hudoutlineplayers = function_5713d46873b29625( hudoutlineplayers );
    
    if ( hudoutlineplayers.size )
    {
        self hudoutlinedisableforclients( hudoutlineplayers );
    }
}

// Namespace mutant_injection
// Params 3, eflags: 0x4
// Checksum 0xeae121a4, Offset: 0x229b
// Size: 0x53
function private enable_hudoutline( other_player, var_49974990b105362e, hudoutlineplayers )
{
    hudoutlineplayers = function_5713d46873b29625( hudoutlineplayers );
    
    if ( !hudoutlineplayers.size || !arraycontains( hudoutlineplayers, other_player ) )
    {
        self hudoutlineenableforclient( other_player, var_49974990b105362e );
        hudoutlineplayers = arraycombineunique( hudoutlineplayers, [ other_player ] );
    }
    
    return hudoutlineplayers;
}

// Namespace mutant_injection
// Params 2, eflags: 0x4
// Checksum 0xbcf3d388, Offset: 0x22f7
// Size: 0x41
function private disable_hudoutline( other_player, hudoutlineplayers )
{
    hudoutlineplayers = function_5713d46873b29625( hudoutlineplayers );
    
    if ( hudoutlineplayers.size && arraycontains( hudoutlineplayers, other_player ) )
    {
        self hudoutlinedisableforclient( other_player );
        hudoutlineplayers = arrayremove( hudoutlineplayers, other_player );
    }
    
    return hudoutlineplayers;
}

// Namespace mutant_injection
// Params 0, eflags: 0xc
// Checksum 0x87cac73a, Offset: 0x2341
// Size: 0x141
function private jumpwatcher()
{
    self notify( #"hash_8e1c17c23791fc10" );
    self endon( #"hash_8e1c17c23791fc10" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    miconfig = self.micontext.miconfig;
    
    if ( !miconfig.slamenabled )
    {
        return;
    }
    
    if ( miconfig.var_330548fdd9f02b06 )
    {
        thread superjumpwatcher();
    }
    
    while ( true )
    {
        utility::waittill_any( "jump_begin", "player_in_air_begin" );
        var_87592add1a00281b = gettime();
        utility::waittill_any( "jump_end", "player_in_air_end" );
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        var_e79c5a301bbbe7e7 = gettime() - var_87592add1a00281b;
        var_7d73a6ba68ea69e4 = !miconfig.var_9651a76dafbb86cc || var_e79c5a301bbbe7e7 >= miconfig.var_60b7d5100598c47a;
        var_6e6631dddd9af216 = !miconfig.var_330548fdd9f02b06 || self.var_f6ca7d6d33ebfd1a;
        var_83192cf8be275de8 = var_7d73a6ba68ea69e4 && var_6e6631dddd9af216;
        function_7b8b1313bc81ff41( self.origin, var_83192cf8be275de8 );
    }
}

// Namespace mutant_injection
// Params 0, eflags: 0xc
// Checksum 0x5363825d, Offset: 0x248a
// Size: 0x88
function private superjumpwatcher()
{
    self notify( #"hash_df281fb0f498ef96" );
    self endon( #"hash_df281fb0f498ef96" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    
    while ( true )
    {
        self waittill( #"zombie_jump_started" );
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self.var_f6ca7d6d33ebfd1a = 1;
        utility::waittill_any( "jump_end", "player_in_air_end" );
        waittillframeend();
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self.var_f6ca7d6d33ebfd1a = 0;
    }
}

// Namespace mutant_injection
// Params 2, eflags: 0x4
// Checksum 0xbd784a14, Offset: 0x251a
// Size: 0x2d6
function private function_7b8b1313bc81ff41( slamorigin, var_83192cf8be275de8 )
{
    miconfig = self.micontext.miconfig;
    vfxsize = var_83192cf8be275de8 ? "lrg_vfx_on" : "sml_vfx_on";
    damageradius = var_83192cf8be275de8 ? miconfig.slamradius : miconfig.slamradius / 2;
    rumbleintensity = var_83192cf8be275de8 ? "heavy_1s" : "light_1s";
    earthquakeintensity = var_83192cf8be275de8 ? miconfig.var_863bc85dae5feec3 : miconfig.var_863bc85dae5feec3 * 0.66;
    
    /#
        if ( level.brgametype.powersdebugenabled )
        {
            level thread debug_utility::drawsphere( slamorigin, damageradius, 4, ( 1, 1, 0 ) );
        }
    #/
    
    utility::function_32b24db3127bff40( "land_vfx", vfxsize );
    potentialvictims = getplayersinradius( slamorigin, damageradius );
    
    foreach ( victim in potentialvictims )
    {
        /#
            if ( level.brgametype.powersdebugenabled )
            {
                level thread debug_utility::drawsphere( victim.origin, 25, 4, ( 1, 1, 0 ) );
            }
        #/
        
        isenemy = player_utility::isenemy( victim );
        iszombie = victim br_public::playeriszombie();
        var_966eedd80f28b5a7 = miconfig.var_1caf34b6bf5f2f2c && victim == self;
        var_40bda88dd657863d = miconfig.var_81d5c5d515accbdf && !isenemy;
        var_a469e2db89a7812f = miconfig.var_745e83c4f751f4c1 && iszombie;
        var_46031450ba88723 = var_966eedd80f28b5a7 || var_40bda88dd657863d || var_a469e2db89a7812f;
        
        if ( !var_46031450ba88723 )
        {
            function_f476338d27dc8fdc( victim, slamorigin, damageradius, earthquakeintensity, rumbleintensity );
        }
        
        var_60b56ca088ffb40e = !var_83192cf8be275de8;
        var_e69aecb9edaa0dbc = miconfig.var_ed3bb00f13efb11e && !isenemy;
        var_210d831906f3ec8e = miconfig.var_9164cddc7374290 && iszombie;
        var_333323fbc8bcb21e = var_60b56ca088ffb40e || var_e69aecb9edaa0dbc || var_210d831906f3ec8e;
        
        if ( !var_333323fbc8bcb21e )
        {
            function_4f44ee91a9f062a7( victim, self, slamorigin );
        }
    }
}

// Namespace mutant_injection
// Params 5, eflags: 0x4
// Checksum 0x80d1007e, Offset: 0x27f8
// Size: 0x4b
function private function_f476338d27dc8fdc( victim, origin, damageradius, earthquakeintensity, rumbleintensity )
{
    victim playrumbleonentity( rumbleintensity );
    victim earthquakeforplayer( earthquakeintensity, earthquakeintensity, origin, damageradius * 1.25 );
}

// Namespace mutant_injection
// Params 3, eflags: 0x4
// Checksum 0xa23739e9, Offset: 0x284b
// Size: 0x122
function private function_4f44ee91a9f062a7( victim, attacker, origin )
{
    if ( victim utility::isusingremote() )
    {
        return;
    }
    
    if ( victim.concussionimmune )
    {
        return;
    }
    
    var_7356959689932100 = self.micontext.miconfig.var_1e5aa7617920dcf0;
    
    if ( var_7356959689932100 <= 0 )
    {
        return;
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"specialty_stun_resistance" ][ #"applystunresistence" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        var_f6e201cde855a82 = victim [[ var_32dbca3143d9c4a5 ]]( attacker, victim, var_7356959689932100 );
    }
    else
    {
        var_f6e201cde855a82 = var_7356959689932100;
    }
    
    victim notify( #"concussed", attacker );
    victim notify( #"flashbang", origin, 1, 1, attacker, attacker.team );
    victim utility::setplayerstunned();
    victim thread weapon_utility::cleanupconcussionstun( var_f6e201cde855a82 );
    victim shellshock_utility_cpmp::_shellshock( %"hash_6a0f96eeec41b5b6", #"stun", var_f6e201cde855a82, 1 );
    victim player::codcastersetplayerstatuseffect( "stun", var_f6e201cde855a82 );
}

/#

    // Namespace mutant_injection
    // Params 1, eflags: 0xc
    // Checksum 0x526c5b50, Offset: 0x2975
    // Size: 0x69, Type: dev
    function private function_c3e4e10df8e8f54a( player )
    {
        self notify( #"hash_c86cb918e1293ae1" );
        self endon( #"hash_c86cb918e1293ae1" );
        
        if ( isdefined( player.var_3dce82ddbd72f441.miconfig ) )
        {
            return;
        }
        
        player.micontext = { #miconfig:getconfig() };
        waittillframeend();
        player.micontext = undefined;
    }

    // Namespace mutant_injection
    // Params 2, eflags: 0x4
    // Checksum 0x8c9d17, Offset: 0x29e6
    // Size: 0x69, Type: dev
    function private function_e6c366b2febd1047( host, args )
    {
        player = host br_dev::function_d660450ac1c6adde();
        
        if ( !isdefined( player ) )
        {
            player = host;
        }
        
        level thread function_c3e4e10df8e8f54a( player );
        var_83192cf8be275de8 = args[ 1 ] != "<dev string:x21d>";
        player function_7b8b1313bc81ff41( player.origin, var_83192cf8be275de8 );
    }

    // Namespace mutant_injection
    // Params 2, eflags: 0x4
    // Checksum 0xa789ca2d, Offset: 0x2a57
    // Size: 0x6e, Type: dev
    function private function_63c3d60c2b8a757f( host, args )
    {
        maxtype = level.brgametype.var_5789e2de3b2699ad.size - 1;
        forcetype = clampint( int( args[ 1 ] ?? 0 ), 0, maxtype );
        level.brgametype.var_3edcefa9b411aca5 = forcetype;
    }

    // Namespace mutant_injection
    // Params 2, eflags: 0x4
    // Checksum 0x97d5d9ed, Offset: 0x2acd
    // Size: 0x21, Type: dev
    function private function_a2bf54b198b90549( host, args )
    {
        host mutant_injection_shared::function_50daa7ab3c558bab();
    }

    // Namespace mutant_injection
    // Params 2, eflags: 0x4
    // Checksum 0xde7bd7ec, Offset: 0x2af6
    // Size: 0x19a, Type: dev
    function private function_6a8687b17d5c8c56( host, args )
    {
        player = host br_dev::function_d660450ac1c6adde();
        
        if ( !isdefined( player ) )
        {
            player = host;
        }
        
        if ( isbot( player ) )
        {
            var_a00a4c3fbae28ec4 = player function_aaad5ae04c1e5224( "<dev string:x223>" );
            player utility::callsharedfunc( #"bots", #"hash_4ba43f63e842ff68", "<dev string:x223>", 0 );
            player.var_d0cbfedfe2b9906b = 1;
            player val::set( "<dev string:x238>", "<dev string:x243>", 1 );
            player val::set( "<dev string:x238>", "<dev string:x251>", 1 );
            player namespace_9d8e359c3b1041e5::awardkillstreaksharedfunc( "<dev string:x258>", "<dev string:x260>", undefined, undefined, undefined, 1 );
            streakitem = player killstreaks::getkillstreakinslot( 1 );
            usesuccess = player killstreaks::triggerkillstreak( streakitem, 1 );
            player utility::callsharedfunc( #"bots", #"hash_4ba43f63e842ff68", "<dev string:x223>", var_a00a4c3fbae28ec4 );
            player val::reset_all( "<dev string:x238>" );
        }
        else
        {
            player val::set( "<dev string:x238>", "<dev string:x243>", 1 );
            player val::set( "<dev string:x238>", "<dev string:x251>", 1 );
            player namespace_9d8e359c3b1041e5::awardkillstreaksharedfunc( "<dev string:x258>", "<dev string:x260>", undefined, undefined, undefined, 1 );
            streakitem = player killstreaks::getkillstreakinslot( 1 );
            usesuccess = player killstreaks::triggerkillstreak( streakitem, 1 );
            player val::reset_all( "<dev string:x238>" );
        }
        
        wait 5;
        player.var_d0cbfedfe2b9906b = undefined;
    }

    // Namespace mutant_injection
    // Params 2, eflags: 0x4
    // Checksum 0x8698484d, Offset: 0x2c98
    // Size: 0x21, Type: dev
    function private function_a50223a0fdd2c1f6( host, args )
    {
        host mutant_injection_shared::function_663e93cb28525637();
    }

    // Namespace mutant_injection
    // Params 2, eflags: 0x4
    // Checksum 0x799e8b23, Offset: 0x2cc1
    // Size: 0x21, Type: dev
    function private function_91e3b73b7c896246( host, args )
    {
        host mutant_injection_shared::function_30d6debfc33678ce();
    }

#/
