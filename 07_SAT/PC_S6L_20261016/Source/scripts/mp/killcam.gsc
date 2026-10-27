// scripts\mp\killcam.gsc  (hash_5732201def3a65c7.gscc) (size: 31295 Bytes / 0x7a3f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7d6eb27d (2104406653)
// size ...... 31295 (0x7a3f)
// includes .. 30  (offset: 0x7283)
// strings ... 96  (offset: 0x7373)
// dev strs .. 15  (offset: 0x794f)
// exports ... 54  (offset: 0x52c7)
// cseg ...... 0xd93 + 0x4534 (0x52c7)
// imports ... 184 (offset: 0x5b37)
// animtree1 . 0   (offset: 0x7a3f)
// animtree2 . 0   (offset: 0x7a3f)
#using script_607ef68f7eca6183;
#using scripts\common\callbacks;
#using scripts\common\game_utility;
#using scripts\common\math;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\common\weapon;
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\equipment;
#using scripts\mp\execution;
#using scripts\mp\final_killcam;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_editor;
#using scripts\mp\killcam_reaction;
#using scripts\mp\playerlogic;
#using scripts\mp\potg;
#using scripts\mp\spectating;
#using scripts\mp\supers;
#using scripts\mp\weaponrank;

#namespace killcam;

// Namespace killcam
// Params 0
// Checksum 0x99d9e7a4, Offset: 0xdb1
// Size: 0x133
function init()
{
    level.killcam = getmatchrulesdata( "commonOption", "showKillcam" );
    level.killcammiscitems = [];
    scriptbundle = getscriptbundle( level.projectbundle.misckillcam );
    
    for ( row = 0; true ; row++ )
    {
        id = scriptbundle.items[ row ].id;
        
        if ( !isdefined( id ) || id == "" )
        {
            break;
        }
        
        id = int( id );
        weapon = scriptbundle.items[ row ].weapon;
        
        if ( !isdefined( weapon ) || weapon == "" )
        {
            assertmsg( "<dev string:x24>" + id + "<dev string:x3e>" );
            break;
        }
        
        assert( !isdefined( level.killcammiscitems[ weapon ] ), "<dev string:x54>" + weapon + "<dev string:x68>" );
        level.killcammiscitems[ weapon ] = id;
    }
    
    if ( getcodegate( #"killcam_reaction" ) )
    {
        killcam_reaction::init();
    }
}

// Namespace killcam
// Params 1
// Checksum 0x40a110dc, Offset: 0xeec
// Size: 0x17
function setkillcamentity( killcamentity )
{
    self.killcament = killcamentity;
}

// Namespace killcam
// Params 4
// Checksum 0xf6a0b93, Offset: 0xf0b
// Size: 0x25a
function getkillcamentity( attacker, einflictor, objweapon, meansofdeath )
{
    if ( !( isdefined( attacker ) && isdefined( einflictor ) && isdefined( objweapon ) ) || attacker == einflictor && !isagent( attacker ) )
    {
        return;
    }
    
    if ( usesattackeraskillcamentity( attacker, einflictor, objweapon, meansofdeath ) )
    {
        return;
    }
    
    if ( usesvehiclekillcamentityrelay( attacker, einflictor, objweapon, meansofdeath ) )
    {
        return einflictor.killcament;
    }
    
    switch ( objweapon.basename )
    {
        case #"hash_1d6b88bde28b109a":
        case #"hash_1ed1da8a2c218aa7":
        case #"hash_2b2cfdf125b4764d":
        case #"hash_2cdebdb0a44e94e6":
        case #"hash_44ac662b86af3e18":
        case #"hash_4e86f50e99575707":
        case #"hash_55b3daf553a1271e":
        case #"hash_5e3fa526a48eaaa5":
        case #"hash_8c12df11df01f306":
        case #"hash_ad2fa1c82f49345d":
        case #"hash_badacfdae124cc01":
        case #"hash_d9cbc629e947d1b7":
        case #"hash_eec4a41906598dfc":
        case #"hash_f085b57dce639767":
        case #"hash_f89fb49cf58b70a5":
            return ( einflictor.killcament ?? einflictor );
        case #"hash_7273a0f3a411b112":
        case #"hash_91a48ebfd2d03a40":
        case #"hash_996849dc6e47c18f":
        case #"hash_aae52fc2913829d0":
        case #"hash_c124ad09158500e9":
        case #"hash_db653a4972b3c13b":
        case #"hash_e4dc94c459367249":
            if ( isnoneweaponinflictor( einflictor ) || isenvironmentalinflictor( einflictor ) )
            {
                return einflictor.killcament;
            }
            
            break;
    }
    
    if ( utility::isdestructibleweapon( objweapon.basename ) || weapon::isbombsiteweapon( objweapon.basename ) )
    {
        if ( isdefined( einflictor.killcament ) && !attacker killstreak::attackerinremotekillstreak() )
        {
            return einflictor.killcament;
        }
        else
        {
            return;
        }
    }
    
    if ( isbrgamemode() && getdvarint( @"hash_19f870e5ffafa391", 1 ) )
    {
        if ( function_7fc919a1c9f67107( attacker, einflictor, objweapon, meansofdeath ) )
        {
            return;
        }
    }
    
    return einflictor.killcament ?? einflictor;
}

// Namespace killcam
// Params 4
// Checksum 0xb9479227, Offset: 0x116e
// Size: 0x1fa, Type: bool
function usesattackeraskillcamentity( attacker, inflictor, objweapon, meansofdeath )
{
    switch ( objweapon.basename )
    {
        case #"hash_104394c101679f9e":
        case #"hash_1a9da8a4fac9fde4":
        case #"hash_1e6ad4ef0904a0f1":
        case #"hash_1eb643f396ea8577":
        case #"hash_1ee2bbd1bc80ea9a":
        case #"hash_20305144649233ed":
        case #"hash_284c201e9a29be96":
        case #"hash_3188799009d92bfe":
        case #"hash_45ceddfcaeac7e1f":
        case #"hash_4620e3fcaeed2ee7":
        case #"hash_4f9064f9a7a4b7d1":
        case #"hash_507c24a8f53354fe":
        case #"hash_62a9688b69906271":
        case #"hash_708fb6e22f87a3a4":
        case #"hash_762483ae7dc25761":
        case #"hash_80d39fa6a58bf503":
        case #"hash_83d55c8dbb9f72ba":
        case #"hash_85ea99fcbe4116a4":
        case #"hash_8d7aa4b158a0e9a9":
        case #"hash_96c95d40bbc6020d":
        case #"hash_9a70af630b5b1849":
        case #"hash_9b89ea95df7dfadb":
        case #"hash_a49fac234083ff01":
        case #"hash_a622e958420b92a0":
        case #"hash_b1091bccb52690e0":
        case #"hash_b8c7008e1d8543df":
        case #"hash_b8cade6c5881b1bf":
        case #"hash_bb463b7f255eafce":
        case #"hash_c5c19fe9ae40cd0c":
        case #"hash_c8c513d28ea4c65a":
        case #"hash_d30bcd7e470500f3":
        case #"hash_d4532f8e0fa86548":
        case #"hash_d78eda24c2fd8252":
        case #"hash_e1e4906cafc3af9d":
        case #"hash_fb16cb1874aef0ed":
        case #"hash_fd9c279f85990dad":
        case #"hash_fe08358bc8f9a34a":
            return true;
    }
    
    return false;
}

// Namespace killcam
// Params 4
// Checksum 0xd17de28f, Offset: 0x1371
// Size: 0x8f, Type: bool
function function_7fc919a1c9f67107( attacker, einflictor, objweapon, meansofdeath )
{
    if ( !isplayer( attacker ) )
    {
        return false;
    }
    
    if ( !isdefined( meansofdeath ) && meansofdeath != "MOD_CRUSH" )
    {
        return false;
    }
    
    if ( !isdefined( einflictor.killcament ) && isdefined( einflictor.classname ) && isdefined( einflictor.owner ) )
    {
        if ( einflictor.classname == "script_brushmodel" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace killcam
// Params 4
// Checksum 0x4fab6e4, Offset: 0x1409
// Size: 0x89
function usesvehiclekillcamentityrelay( attacker, inflictor, objweapon, meansofdeath )
{
    if ( !isdefined( inflictor ) )
    {
        return 0;
    }
    
    if ( !inflictor vehicle::is_vehicle() )
    {
        return 0;
    }
    
    switch ( meansofdeath )
    {
        case #"hash_3c20f39c73a1422b":
        case #"hash_571e46e17a3cf2e3":
        case #"hash_66cb246f3e55fbe2":
        case #"hash_c22b13f81bed11f0":
            return 1;
        default:
            return 0;
    }
}

// Namespace killcam
// Params 1
// Checksum 0xe4f315a4, Offset: 0x149a
// Size: 0x1a5
function prekillcamnotify( attacker )
{
    if ( isdefined( attacker ) && !isagent( attacker ) )
    {
        streamassets = [];
        
        if ( isdefined( self.class ) && isdefined( self.classstruct ) )
        {
            playerassets = playerlogic::getplayerassets( self.classstruct );
            streamassets[ streamassets.size ] = playerassets;
        }
        
        if ( isdefined( attacker.class ) && isdefined( attacker.classstruct ) )
        {
            attackerassets = attacker playerlogic::getplayerassets( attacker.classstruct );
            streamassets[ streamassets.size ] = attackerassets;
        }
        
        if ( streamassets.size > 0 )
        {
            playerlogic::loadplayerassets( streamassets, 1 );
        }
        
        if ( isdefined( attacker.damagetrigger ) && attacker.damagetrigger.code_classname == "trigger_hurt" )
        {
            if ( isdefined( attacker.team ) )
            {
                team = attacker.team;
            }
            else
            {
                team = "neutral";
            }
            
            attacker makeentitysentient( team );
            
            if ( !isdefined( level.var_5092ad40df5693fd ) || [[ level.var_5092ad40df5693fd ]]() )
            {
                self predictstreamposuntilcleared( attacker geteye() );
            }
            
            return;
        }
        
        if ( !isdefined( level.var_5092ad40df5693fd ) || [[ level.var_5092ad40df5693fd ]]() )
        {
            attackerpos = attacker.origin;
            
            if ( isalive( attacker ) )
            {
                attackerpos = attacker geteye();
            }
            
            self predictstreamposuntilcleared( attackerpos );
        }
        
        if ( isplayer( attacker ) )
        {
            self loadcustomizationplayerview( attacker );
        }
    }
}

// Namespace killcam
// Params 17
// Checksum 0x714f43a8, Offset: 0x1647
// Size: 0x271
function makekillcamdata( einflictor, inflictoragentinfo, attackernum, killcamentityindex, killcamentitystarttime, killcamlookatentityindex, killcamentstickstolookatent, objweapon, offsettime, maxtime, attacker, victim, smeansofdeath, attackerloadoutperks, skippable, doslowmo, var_c9f36c9b6da231a2 )
{
    killcamstruct = spawnstruct();
    killcamstruct.einflictor = einflictor;
    killcamstruct.inflictoragentinfo = inflictoragentinfo;
    killcamstruct.attackernum = attackernum;
    killcamstruct.killcamentityindex = killcamentityindex;
    killcamstruct.killcamentitystarttime = killcamentitystarttime;
    killcamstruct.killcamlookatentityindex = killcamlookatentityindex;
    killcamstruct.killcamentstickstolookatent = killcamentstickstolookatent;
    killcamstruct.objweapon = objweapon;
    killcamstruct.offsettime = offsettime;
    killcamstruct.maxtime = maxtime;
    killcamstruct.attacker = attacker;
    killcamstruct.victim = victim;
    killcamstruct.smeansofdeath = smeansofdeath;
    killcamstruct.attackerloadoutperks = attackerloadoutperks;
    killcamstruct.skippable = skippable;
    killcamstruct.doslowmo = doslowmo;
    killcamstruct.var_c9f36c9b6da231a2 = var_c9f36c9b6da231a2;
    
    if ( isdefined( attacker.health ) && attacker.maxhealth > 0 )
    {
        killcamstruct.attackerhealthratio = int( clamp( attacker.health / attacker.maxhealth * 127, 0, 127 ) );
    }
    else
    {
        killcamstruct.attackerhealthratio = 127;
    }
    
    if ( isdefined( attacker ) )
    {
        killcamstruct.streampos = attacker.origin;
        killcamstruct.attackerlastspawntime = attacker.lastspawntime;
    }
    else if ( isdefined( victim ) )
    {
        killcamstruct.streampos = victim.origin;
    }
    
    if ( smeansofdeath == "MOD_EXECUTION" )
    {
        killcamstruct.executionref = execution::execution_getrefbyplayer( attacker );
    }
    
    return killcamstruct;
}

// Namespace killcam
// Params 5
// Checksum 0xfbcc1678, Offset: 0x18c1
// Size: 0x110
function dokillcamfromstruct( killcamstruct, predelay, var_802f80bd23922f6b, isfinalkillcam, killcamwatcher )
{
    killcam( killcamstruct.einflictor, killcamstruct.inflictoragentinfo, killcamstruct.attackernum, killcamstruct.killcamentityindex, killcamstruct.killcamentitystarttime, killcamstruct.killcamlookatentityindex, killcamstruct.killcamentstickstolookatent, killcamstruct.objweapon, predelay, killcamstruct.offsettime, killcamstruct.attackerlastspawntime, var_802f80bd23922f6b, killcamstruct.maxtime, killcamstruct.attacker, killcamstruct.victim, killcamstruct.smeansofdeath, killcamstruct.attackerloadoutperks, killcamstruct.skippable, killcamstruct.doslowmo, killcamstruct.attackerhealthratio, isfinalkillcam, killcamstruct.var_c9f36c9b6da231a2, killcamwatcher );
}

// Namespace killcam
// Params 13
// Checksum 0xe531e87d, Offset: 0x19d9
// Size: 0x5a2
function calckillcamtimes( einflictor, inflictoragentinfo, attacker, attackernum, victim, maxtime, predelay, objweapon, var_802f80bd23922f6b, delayedtime, smeansofdeath, attackerlastspawntime, killcamentitystarttime )
{
    if ( getdvar( @"scr_killcam_time", "" ) == "" )
    {
        weaponrootname = getweaponrootstring( objweapon );
        var_685fdc1e78dd117a = namespace_2be4972bbff8c613::function_739f75dbc29564c4( objweapon.basename );
        
        if ( level.showingfinalkillcam )
        {
            if ( smeansofdeath == "MOD_EXECUTION" || smeansofdeath == "MOD_MELEE_TAKEDOWN" )
            {
                camtime = 4;
            }
            else if ( game_utility::getgametype() == "arena" || game_utility::getgametype() == "rogue" )
            {
                if ( attacker.recentkillcount > 1 )
                {
                    camtime = 4 + level.maxkillcamdelay - delayedtime;
                }
                else
                {
                    camtime = 1.5 + level.maxkillcamdelay - delayedtime;
                }
            }
            else
            {
                camtime = 4 + level.maxkillcamdelay - delayedtime;
            }
        }
        else if ( isdefined( var_685fdc1e78dd117a ) )
        {
            camtime = [[ var_685fdc1e78dd117a ]]( einflictor, attacker, victim );
        }
        else if ( objweapon.basename == "artillery_mp" )
        {
            camtime = 2.25;
        }
        else if ( objweapon.basename == "hover_jet_proj_mp" )
        {
            camtime = 3;
        }
        else if ( namespace_2be4972bbff8c613::function_ba84a9360f330de9( objweapon ) )
        {
            camtime = 1.5;
        }
        else if ( objweapon.basename == "toma_proj_mp" || objweapon.basename == "toma_proj_t10_mp" )
        {
            camtime = 2.5;
        }
        else if ( objweapon.basename == "cruise_proj_mp" )
        {
            camtime = 3;
        }
        else if ( objweapon.basename == "javelin_mp" )
        {
            camtime = 8;
        }
        else if ( issubstr( objweapon.basename, "remotemissile_" ) )
        {
            camtime = 5;
        }
        else if ( einflictor.sentrytype == "multiturret" )
        {
            camtime = 2;
        }
        else if ( objweapon.basename == "hellstorm_cluster_bomb_proj_mp" || objweapon.basename == "skewer_proj_mp" )
        {
            camtime = min( ( gettime() - killcamentitystarttime ) / 1000 - 2, 5 );
        }
        else if ( !var_802f80bd23922f6b || var_802f80bd23922f6b > 5 )
        {
            camtime = 5;
        }
        else if ( weaponrootname == "frag_grenade" || objweapon.basename == "frag_grenade_short_mp" || objweapon.basename == "semtex_mp" || objweapon.basename == "semtexproj_mp" || objweapon.basename == "mortar_shell__mp" || objweapon.basename == "cluster_grenade_mp" || objweapon.basename == "sticky_grenade_mp" )
        {
            camtime = 4.25;
        }
        else if ( objweapon.basename == "loitering_munition_proj_mp" )
        {
            camtime = 3;
        }
        else if ( objweapon.basename == "dna_nuke_mp" )
        {
            camtime = 3;
        }
        else
        {
            camtime = 2.5;
        }
    }
    else
    {
        camtime = getdvarfloat( @"scr_killcam_time" );
    }
    
    if ( camtime > maxtime )
    {
        camtime = maxtime;
    }
    
    var_88520675ebe63ade = einflictor.var_8b68b6fb97e62852 ?? attacker.var_8b68b6fb97e62852;
    
    if ( camtime > var_88520675ebe63ade )
    {
        camtime = var_88520675ebe63ade;
    }
    
    if ( camtime < level.framedurationseconds )
    {
        camtime = level.framedurationseconds;
    }
    
    if ( game_utility::getgametype() == "arena" || game_utility::getgametype() == "rogue" )
    {
        postdelay = 1;
        
        if ( smeansofdeath == "MOD_EXECUTION" || smeansofdeath == "MOD_MELEE_TAKEDOWN" )
        {
            postdelay = 3;
        }
    }
    else if ( objweapon.basename == "rcxd" )
    {
        rcxdbundle = level.streakglobals.streakbundles[ "rcxd" ];
        postdelay = rcxdbundle.explosioncamduration ?? 0;
    }
    else if ( getdvar( @"scr_killcam_posttime", "" ) == "" )
    {
        postdelay = 2;
    }
    else
    {
        postdelay = getdvarfloat( @"scr_killcam_posttime" );
        
        if ( postdelay < level.framedurationseconds )
        {
            postdelay = level.framedurationseconds;
        }
    }
    
    if ( attackernum < 0 || !isdefined( attacker ) )
    {
        return;
    }
    
    if ( !isdefined( attacker ) || isagent( attacker ) || isagent( einflictor ) )
    {
        attackernum = victim getentitynumber();
    }
    
    killcamtimes = namespace_2be4972bbff8c613::trimkillcamtime( inflictoragentinfo, attacker, camtime, postdelay, predelay, maxtime, attackerlastspawntime );
    
    if ( !isdefined( killcamtimes ) )
    {
        return;
    }
    
    assert( isdefined( killcamtimes.camtime ) );
    assert( isdefined( killcamtimes.postdelay ) );
    assert( isdefined( killcamtimes.killcamlength ) );
    assert( isdefined( killcamtimes.killcamoffset ) );
    return killcamtimes;
}

// Namespace killcam
// Params 1
// Checksum 0x28734d48, Offset: 0x1f84
// Size: 0x17
function function_915d4a211548b897( maxduration )
{
    self.var_8b68b6fb97e62852 = maxduration;
}

// Namespace killcam
// Params 1
// Checksum 0x756fe32f, Offset: 0x1fa3
// Size: 0x21
function setkilledbyuiomnvar( killedbyplayer )
{
    self setclientomnvar( o"ui_killcam_killedby_id", killedbyplayer getentitynumber() );
}

// Namespace killcam
// Params 1
// Checksum 0x99182628, Offset: 0x1fcc
// Size: 0xa4
function function_50cdb30e6c954395( attacker )
{
    if ( isdefined( attacker.equipment[ "primary" ] ) )
    {
        self setclientomnvar( o"ui_killcam_killedby_equipment_primary", attacker.equipment[ "primary" ] );
    }
    else
    {
        self setclientomnvar( o"ui_killcam_killedby_equipment_primary", "none" );
    }
    
    if ( isdefined( attacker.equipment[ "secondary" ] ) )
    {
        self setclientomnvar( o"ui_killcam_killedby_equipment_secondary", attacker.equipment[ "secondary" ] );
        return;
    }
    
    self setclientomnvar( o"ui_killcam_killedby_equipment_secondary", "none" );
}

// Namespace killcam
// Params 1
// Checksum 0xe053ce43, Offset: 0x2078
// Size: 0x7f
function function_53819d908304673c( attacker )
{
    super1 = attacker perkpackage::perkpackage_getfirstfieldupgrade();
    
    if ( super1 )
    {
        self setclientomnvar( o"hash_3c903a66a6aeed2f", super1 );
    }
    
    super2 = attacker perkpackage::perkpackage_getsecondfieldupgrade();
    
    if ( super2 )
    {
        self setclientomnvar( o"hash_3c903766a6aee4ec", super2 );
    }
    
    var_86996e2e310ad5dc = attacker function_d9033e72a0c972ab();
    self setclientomnvar( o"ui_killcam_killedby_using_spykit", var_86996e2e310ad5dc );
}

// Namespace killcam
// Params 6
// Checksum 0xa0ba9d85, Offset: 0x20ff
// Size: 0x1de
function setupkillcamui( attacker, victim, objweapon, killcamtimes, var_802f80bd23922f6b, attackerloadoutperks )
{
    if ( game_utility_common::isgameparticipant( attacker ) )
    {
        if ( isplayer( attacker ) )
        {
            setkilledbyuiomnvar( attacker );
            self setclientomnvar( o"ui_killcam_victim_id", victim getentitynumber() );
            self loadcustomizationplayerview( attacker );
            hud_editor::function_8618046cf533c449( attacker );
        }
        
        function_50cdb30e6c954395( attacker );
        function_53819d908304673c( attacker );
        
        if ( weapon::iskillstreakweapon( objweapon.basename ) && !weapon::function_ea0f95c57e71d5b4( objweapon.basename ) )
        {
            namespace_2be4972bbff8c613::setkillcamkillstreaktypeomnvars( objweapon );
        }
        else if ( level.allowperks && isdefined( attackerloadoutperks ) )
        {
            extraperksarray = attacker.pers[ "loadoutExtraPerks" ];
            
            if ( isdefined( attacker.perks[ level.var_d846c03ec30479ec ] ) )
            {
                attackerloadoutperks = [ "specialty_specialist" ];
            }
            
            perks::setomnvarsforperklist( "ui_killcam_killedby_perk", attackerloadoutperks, extraperksarray );
        }
    }
    
    forcerespawn = getmatchrulesdata( "commonOption", "forceRespawn" );
    
    if ( var_802f80bd23922f6b && !level.gameended || isdefined( self ) && !level.gameended || forcerespawn == 0 && !level.gameended )
    {
        self setclientomnvar( o"ui_killcam_text", "skip" );
    }
    else if ( !level.gameended )
    {
        self setclientomnvar( o"ui_killcam_text", "respawn" );
    }
    else
    {
        self setclientomnvar( o"ui_killcam_text", "none" );
    }
    
    namespace_2be4972bbff8c613::setkillcamuitimer( killcamtimes.killcamlength );
}

// Namespace killcam
// Params 0
// Checksum 0x78669900, Offset: 0x22e5
// Size: 0x96
function queueforkillcam()
{
    level.numplayerswaitingtoenterkillcam++;
    var_8609db8eeaf6c223 = 1;
    
    if ( level.showingfinalkillcam && isbrgamemode() )
    {
        var_8609db8eeaf6c223 = 5;
    }
    
    delayedtime = level.framedurationseconds * int( floor( ( level.numplayerswaitingtoenterkillcam - 1 ) / var_8609db8eeaf6c223 ) );
    level.maxkillcamdelay = delayedtime;
    
    if ( delayedtime > 0 )
    {
        println( "<dev string:x7a>" + level.numplayerswaitingtoenterkillcam );
        wait delayedtime;
    }
    
    waitframe();
    level.numplayerswaitingtoenterkillcam--;
    return delayedtime;
}

// Namespace killcam
// Params 0
// Checksum 0x86cd8256, Offset: 0x2384
// Size: 0x8d
function function_7c7e772e516e1c91()
{
    if ( isplayer( self ) )
    {
        isskipped = 0;
        var_82feadfa7fc87286 = math::round_float( self.killcamlength, 1, 1 );
        var_e699dd467a3731b0 = math::round_float( self.killcamwatchtime, 1, 1 );
        
        if ( var_e699dd467a3731b0 < var_82feadfa7fc87286 )
        {
            isskipped = 1;
        }
        
        self dlog_recordplayerevent( "dlog_event_match_killcam", [ "time_spent", self.killcamwatchtime, "is_skipped", isskipped ] );
    }
}

// Namespace killcam
// Params 23
// Checksum 0xec96b638, Offset: 0x2419
// Size: 0x7b0
function killcam( einflictor, inflictoragentinfo, attackernum, killcamentityindex, killcamentitystarttime, killcamlookatentityindex, killcamentstickstolookatent, objweapon, predelay, offsettime, attackerlastspawntime, var_802f80bd23922f6b, maxtime, attacker, victim, smeansofdeath, attackerloadoutperks, skippable, doslowmo, attackerhealthratio, isfinalkillcam, var_c9f36c9b6da231a2, killcamwatcher )
{
    self endon( #"disconnect" );
    self endon( #"spawned" );
    self endon( #"final_killcam_starting" );
    self.willshowkillcam = 1;
    self.killcamcancelled = 0;
    
    if ( !level.var_52ec0ab267f26a6e )
    {
        level endon( #"game_ended" );
    }
    
    utility::callsharedfunc( #"super_evg", #"hash_314641d812217c9", attacker );
    player::printspawnmessage( "killcam::killcam() START" );
    resetplayeromnvarsonkillcam();
    
    if ( attackernum < 0 || !isdefined( attacker ) )
    {
        self notify( #"killcam_canceled" );
        
        if ( isfinalkillcam )
        {
            self setclientomnvar( o"post_game_state", 1 );
        }
        
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( self ? self.name : "undefined" ) + "] " + "killcam - !IsDefined deathTime " );
        }
        
        self.killcamcancelled = 1;
        return;
    }
    
    delayedtime = queueforkillcam();
    killcamtimes = calckillcamtimes( einflictor, inflictoragentinfo, attacker, attackernum, victim, maxtime, predelay, objweapon, var_802f80bd23922f6b, delayedtime, smeansofdeath, attackerlastspawntime, killcamentitystarttime );
    
    if ( !( isdefined( killcamtimes ) && isdefined( killcamtimes.killcamoffset ) && isdefined( victim ) ) || level.var_a5ecc4fd7d64db7b )
    {
        self notify( #"killcam_canceled" );
        
        if ( isfinalkillcam )
        {
            self setclientomnvar( o"post_game_state", 1 );
        }
        
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( self ? self.name : "undefined" ) + "] " + "killcam - killcamTimes, killcamTimes.killcamoffset, victim" );
        }
        
        self.killcamcancelled = 1;
        return;
    }
    
    if ( killcamtimes.camtime < 0.1 )
    {
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( self ? self.name : "undefined" ) + "] " + "killcam - killcamTimes.camtime < MIN_KILLCAM_TIME_TO_PLAY" );
        }
        
        self.killcamcancelled = 1;
        return;
    }
    
    if ( isfinalkillcam )
    {
        self setclientomnvar( o"post_game_state", 3 );
        self setclientomnvar( o"ui_killcam_victim_or_attacker", 1 );
        
        if ( self iscodcaster() )
        {
            self setclientomnvar( o"ui_killcam_killedby_health_ratio", attackerhealthratio );
        }
        
        self playlocalsound( "final_killcam_in" );
        
        if ( isdefined( level.gamemodebundle.var_ea62e097837e641 ) )
        {
            self setsoundsubmix( level.gamemodebundle.var_ea62e097837e641 );
        }
        else
        {
            self setclienttriggeraudiozonepartial( "killcam", "mix" );
        }
    }
    
    setupkillcamui( attacker, victim, objweapon, killcamtimes, var_802f80bd23922f6b, attackerloadoutperks );
    
    if ( isplayer( attacker ) )
    {
        self loadcustomizationplayerview( attacker );
    }
    
    if ( isdefined( level.var_4c05236cc4daf4b1 ) && isdefined( einflictor.racecar ) )
    {
        self playlocalsound( level.var_4c05236cc4daf4b1 );
    }
    
    function_c76b2cee06b5ccec();
    namespace_2be4972bbff8c613::beginarchiveplayback( attackernum, killcamtimes.killcamoffset, killcamtimes.killcamlength, offsettime );
    var_cb565c2fef9ebb22 = namespace_2be4972bbff8c613::setkillcamerastyle( einflictor, inflictoragentinfo, attackernum, victim, killcamentityindex, killcamtimes, objweapon );
    
    if ( !var_cb565c2fef9ebb22 )
    {
        thread namespace_2be4972bbff8c613::setkillcamentity( killcamentityindex, killcamtimes.killcamoffset, killcamentitystarttime, killcamlookatentityindex, killcamentstickstolookatent, var_c9f36c9b6da231a2 );
    }
    
    if ( !level.var_52ec0ab267f26a6e )
    {
        thread endedkillcamcleanup( isfinalkillcam );
    }
    
    waitframe();
    
    if ( !isdefined( self ) )
    {
        self.killcamcancelled = 1;
        return;
    }
    
    namespace_2be4972bbff8c613::checkkillcamtruncation( killcamtimes.killcamoffset );
    killcamtimes.camtime = self.archivetime - level.framedurationseconds - predelay;
    killcamtimes.killcamlength = killcamtimes.camtime + killcamtimes.postdelay;
    self.killcamlength = killcamtimes.killcamlength;
    
    if ( killcamtimes.camtime <= 0 )
    {
        println( "<dev string:xa9>" );
        killcamcleanup( 1, undefined, isfinalkillcam );
        
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( self ? self.name : "undefined" ) + "] " + "killcam - killcamTimes.camtime <= 0" );
        }
        
        self.killcamcancelled = 1;
        return;
    }
    
    self.killcam = 1;
    
    if ( level.gametypebundle.var_49ce0ad53035f21d )
    {
        function_b4f62e3fd89ab149( victim, attacker, objweapon );
    }
    
    if ( level.projectbundle.var_495d0715d1913107 )
    {
        killcamwatcher = killcamwatcher ?? ( isfinalkillcam ? self : victim );
        function_aad7f77ecd7c12ef( killcamwatcher, attacker, objweapon );
    }
    
    thread spawnedkillcamcleanup( isfinalkillcam );
    
    if ( doslowmo )
    {
        thread namespace_2be4972bbff8c613::dokillcamslowmo( killcamtimes.camtime, isfinalkillcam );
    }
    
    if ( !isdefined( skippable ) || skippable )
    {
        thread waitskipkillcambutton( var_802f80bd23922f6b );
        
        if ( isdefined( self.setspawnpoint ) && utility::callsharedfunc( #"hash_ddfd165eca1acbee", #"hash_34e67067fbad9026" ) )
        {
            thread function_323adf1d2a49a4d5();
        }
        
        thread waitskipkillcamkbmortouch();
    }
    
    if ( getdvarint( @"hash_6a04bab2b440c5eb", 0 ) )
    {
        thread killstreaks::function_7205e0336ce572f3();
    }
    
    if ( isfinalkillcam )
    {
        thread final_killcam::finalkillcamplaybackbegin();
    }
    
    thread namespace_2be4972bbff8c613::endkillcamifnothingtoshow();
    
    if ( !isbot( self ) )
    {
        thread resetstreamerposhint();
    }
    
    self.killcamwatchtime = gettime();
    namespace_2be4972bbff8c613::waittillkillcamover();
    self.killcamwatchtime = ( gettime() - self.killcamwatchtime ) / 1000;
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "timeWatchingKillcams" ] ) )
        {
            self.leaderboarddata[ "timeWatchingKillcams" ] = self.leaderboarddata[ "timeWatchingKillcams" ] + self.killcamwatchtime;
        }
        
        if ( isdefined( level.leaderboardfunc[ "timeWatchingKillcams" ] ) )
        {
            [[ level.leaderboardfunc[ "timeWatchingKillcams" ] ]]( self, self.killcamwatchtime );
        }
        
        assert( isint( self.killcamwatchtime ) || isfloat( self.killcamwatchtime ), "<dev string:xfa>" );
        
        if ( isdefined( self.pers[ "timeWatchingKillcams" ] ) )
        {
            self.pers[ "timeWatchingKillcams" ] = self.pers[ "timeWatchingKillcams" ] + self.killcamwatchtime;
        }
    }
    
    if ( level.usespawnselection && level.gamemodebundle.var_d64395ce43bd0786 )
    {
        game_utility::fadetoblackforplayer( self, 1, 0 );
    }
    
    killcamcleanup( 1, undefined, isfinalkillcam );
    function_7c7e772e516e1c91();
    player::printspawnmessage( "killcam::killcam() COMPLETE" );
}

// Namespace killcam
// Params 0
// Checksum 0x9b670361, Offset: 0x2bd1
// Size: 0x24
function function_c76b2cee06b5ccec()
{
    waitframe();
    self setsoundsubmix( level.gamemodebundle.var_dcb1c4fe8b1c245c ?? "iw9_mp_core_killcam_mix" );
}

// Namespace killcam
// Params 0
// Checksum 0x4a351790, Offset: 0x2bfd
// Size: 0x5a
function resetstreamerposhint()
{
    self endon( #"disconnect" );
    utility::waittill_any_timeout( 0.15, "killcam_canceled", "spawned" );
    
    if ( !isdefined( level.var_5092ad40df5693fd ) || [[ level.var_5092ad40df5693fd ]]() )
    {
        self clearpredictedstreampos();
    }
    
    if ( level.showingfinalkillcam )
    {
        gamelogic_mp::predictandclearintermissionstreaming();
    }
}

// Namespace killcam
// Params 1
// Checksum 0x3ad9ec81, Offset: 0x2c5f
// Size: 0x268
function function_ba9ea462f1caede2( killedbyplayer )
{
    perksarray = [];
    
    if ( isdefined( killedbyplayer.perks ) )
    {
        foreach ( key, index in killedbyplayer.perks )
        {
            if ( !level.perkbundles[ key ].hideinkillcam )
            {
                perksarray[ perksarray.size ] = key;
            }
        }
    }
    else if ( isdefined( killedbyplayer.pers ) )
    {
        foreach ( perkarr in [ "loadoutStandardPerks", "loadoutExtraPerks" ] )
        {
            if ( isdefined( killedbyplayer.pers[ perkarr ] ) )
            {
                foreach ( perk in killedbyplayer.pers[ perkarr ] )
                {
                    if ( perk != "" && perk != "none" && perk != "specialty_null" && !arraycontains( perksarray, perk ) && !level.perkbundles[ perk ].hideinkillcam )
                    {
                        perksarray[ perksarray.size ] = perk;
                    }
                }
            }
        }
    }
    
    extraperksarray = killedbyplayer.pers[ "loadoutExtraPerks" ];
    
    if ( isdefined( killedbyplayer.perks[ level.var_d846c03ec30479ec ] ) )
    {
        perksarray = [ "specialty_specialist" ];
    }
    
    perks::setomnvarsforperklist( "ui_killcam_killedby_perk", perksarray, extraperksarray );
}

// Namespace killcam
// Params 3
// Checksum 0xabb2c608, Offset: 0x2ecf
// Size: 0x1af
function function_9d9ce324fbb14cae( spectateplayer, objweapon, smeansofdeath )
{
    equipmenttype = weapon::getequipmenttype( objweapon );
    
    if ( smeansofdeath == "MOD_EXECUTION" )
    {
        setkillcamexecutiontypeomnvars( execution::execution_getrefbyplayer( spectateplayer ) );
        return;
    }
    
    if ( !isdefined( objweapon ) )
    {
        namespace_2be4972bbff8c613::setkillcamkilledbyitemomnvars( -1, -1 );
        return;
    }
    
    if ( weapon::iskillstreakweapon( objweapon.basename ) && !weapon::function_ea0f95c57e71d5b4( objweapon.basename ) )
    {
        namespace_2be4972bbff8c613::setkillcamkillstreaktypeomnvars( objweapon );
        return;
    }
    
    if ( isdefined( supers_mp::getsuperrefforsuperweapon( objweapon ) ) )
    {
        setkillcamsupertypeomnvars( objweapon );
        return;
    }
    
    if ( equipmenttype == "lethal" || equipmenttype == "tactical" )
    {
        setkillcamequipmenttypeomnvars( objweapon );
        return;
    }
    
    if ( isdefined( level.killcammiscitems[ objweapon.basename ] ) )
    {
        setkillcammisctypeomnvars( level.killcammiscitems[ objweapon.basename ] );
        return;
    }
    
    rootweaponname = weapon::getweaponrootname( objweapon.basename );
    weaponscriptbundles = weapon::function_16ff7d597f441100();
    var_46dec494ffe4f795 = -1;
    
    if ( isdefined( weaponscriptbundles ) && arraycontains( weaponscriptbundles, rootweaponname ) )
    {
        var_46dec494ffe4f795 = function_f02c63b99c9614c9( weaponscriptbundles, rootweaponname ) + 1;
    }
    
    if ( !isdefined( var_46dec494ffe4f795 ) || var_46dec494ffe4f795 < 0 )
    {
        namespace_2be4972bbff8c613::setkillcamkilledbyitemomnvars( -1, -1 );
        return;
    }
    
    self setclientomnvar( o"ui_killcam_killedby_loot_variant_id", objweapon.variantid ?? -1 );
    namespace_2be4972bbff8c613::setkillcamkilledbyitemomnvars( 0, var_46dec494ffe4f795 );
    namespace_2be4972bbff8c613::function_9740a1c0ad1f3945( rootweaponname, objweapon );
}

// Namespace killcam
// Params 4
// Checksum 0xb1f9dab1, Offset: 0x3086
// Size: 0x72
function setuppotgui( spectateplayer, durationsec, objweapon, smeansofdeath )
{
    setkilledbyuiomnvar( spectateplayer );
    function_50cdb30e6c954395( spectateplayer );
    function_53819d908304673c( spectateplayer );
    hud_editor::function_8618046cf533c449( spectateplayer );
    function_ba9ea462f1caede2( spectateplayer );
    function_9d9ce324fbb14cae( spectateplayer, objweapon, smeansofdeath );
    function_439f86166bc0777f( spectateplayer, objweapon );
    namespace_2be4972bbff8c613::setkillcamuitimer( durationsec );
}

// Namespace killcam
// Params 1
// Checksum 0x79995ddd, Offset: 0x3100
// Size: 0x12b
function function_4ee45dfd828c326a( var_5df854f1f75793cf )
{
    self endon( #"disconnect" );
    bundle = level.gametypebundle;
    
    if ( !bundle.var_dbfef9e875cfe5cd || getdvarint( @"hash_e7de718c66439cdc" ) == 0 )
    {
        return;
    }
    
    timescale = bundle.var_6c5b6ac487dc538d;
    var_307eeeaa27455b9b = bundle.var_96d710fa131d8707;
    var_99314d52f73a4a5 = bundle.var_698177567b17f779 + var_307eeeaa27455b9b;
    var_9d68dfe2c0d0a70c = bundle.var_e07ff5865f3db440;
    
    if ( var_5df854f1f75793cf )
    {
        self setclientomnvar( o"potg_transition", 1 );
    }
    else
    {
        self setclientomnvar( o"potg_transition", 0 );
    }
    
    self playlocalsound( "uin_potg_sequence_enter" );
    wait bundle.var_1ab82ab5f11c9d35;
    setslowmotion( 1, timescale, var_307eeeaa27455b9b );
    wait var_99314d52f73a4a5;
    setslowmotion( timescale, 1, var_9d68dfe2c0d0a70c );
    wait var_9d68dfe2c0d0a70c;
    
    if ( var_5df854f1f75793cf )
    {
        self setclientomnvar( o"potg_transition", 0 );
        return;
    }
    
    self setclientomnvar( o"potg_transition", 1 );
}

// Namespace killcam
// Params 13
// Checksum 0x8563920d, Offset: 0x3233
// Size: 0x2d1
function potg_killcam( spectateentity, psoffsettime, starttimems, endtimems, var_436b3e70a30366ae, killcamentindex, var_b20557e718d46daf, killcamlookatentityindex, killcamentstickstolookatent, objweapon, killtimes, smeansofdeath, var_5df854f1f75793cf )
{
    self endon( #"disconnect" );
    prekillcamnotify( spectateentity );
    resetplayeromnvarsonkillcam();
    function_aad7f77ecd7c12ef( self, spectateentity, objweapon );
    var_a7446692f5fc38c2 = spectateentity getentitynumber();
    
    if ( isplayer( spectateentity ) )
    {
        self loadcustomizationplayerview( spectateentity );
    }
    
    archivestarttimems = getpotgstarttime();
    var_74f7df8e07c18fdd = starttimems < archivestarttimems ? archivestarttimems : starttimems;
    potgdurationms = getpotgduration();
    archiveendtimems = archivestarttimems + potgdurationms;
    var_ba3b32fb2c49af54 = endtimems > archiveendtimems ? archiveendtimems : endtimems;
    logstring( "^5[POTG] archiveStartTimeMS: " + archivestarttimems );
    logstring( "^5[POTG] startTimeMS: " + starttimems );
    logstring( "^5[POTG] archiveEndTimeMS: " + archiveendtimems );
    logstring( "^5[POTG] endTimeMS: " + endtimems );
    logstring( "^5[POTG] POTG duration: " + potgdurationms );
    potg::function_b81e83c33eb842b0( starttimems, endtimems, var_74f7df8e07c18fdd, var_ba3b32fb2c49af54 );
    curtimems = gettime();
    var_f2d46d25cefa163d = ( curtimems - var_74f7df8e07c18fdd ) / 1000;
    var_58d84236519ae1ea = ( curtimems - var_ba3b32fb2c49af54 ) / 1000;
    durationsec = ( var_ba3b32fb2c49af54 - var_74f7df8e07c18fdd ) / 1000;
    setuppotgui( spectateentity, durationsec, objweapon, smeansofdeath );
    self.archiveusepotg = 1;
    namespace_2be4972bbff8c613::beginarchiveplayback( var_a7446692f5fc38c2, var_f2d46d25cefa163d, durationsec, psoffsettime );
    waitframe();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    namespace_2be4972bbff8c613::checkkillcamtruncation( var_f2d46d25cefa163d );
    self.killcamlength = self.archivetime - var_58d84236519ae1ea;
    self.killcam = 1;
    thread function_4ee45dfd828c326a( var_5df854f1f75793cf );
    self notify( #"begin_killcam" );
    thread game_utility_mp::setuipostgamefade( 0 );
    
    if ( level.gametypebundle.var_c6dba97e65cd67ce )
    {
        level thread game_utility::fadetoblackforplayer( self, 0, 0.25 );
    }
    
    if ( level.gametypebundle.var_fb22f25b78f78dbc && function_4042d2fbe6237835( #"hash_d34e6c10fc9b9b7b" ) )
    {
        level.gametypebundle.var_fb22f25b78f78dbc = 0;
    }
    
    if ( level.gametypebundle.var_fb22f25b78f78dbc )
    {
        thread function_c6e71031ac2dbfc6( killtimes, var_74f7df8e07c18fdd );
    }
    else
    {
        thread function_59db08795e48429c( var_436b3e70a30366ae, var_74f7df8e07c18fdd );
    }
    
    thread function_a159020a08702913( var_74f7df8e07c18fdd, killcamentindex, var_b20557e718d46daf, killcamlookatentityindex, killcamentstickstolookatent );
    namespace_2be4972bbff8c613::waittillkillcamover();
    potgkillcamcleanup();
}

// Namespace killcam
// Params 2
// Checksum 0x792d8084, Offset: 0x350c
// Size: 0x113
function function_59db08795e48429c( var_436b3e70a30366ae, var_40d317b9f76c4fbc )
{
    self endon( #"disconnect" );
    bundle = level.gametypebundle;
    timescale = bundle.var_56a50532f16538ec ?? getdvarfloat( @"hash_d952d2e72a0e732c" );
    var_99314d52f73a4a5 = bundle.var_28be330fd112e79b ?? getdvarfloat( @"hash_fabdb68e639538db" );
    var_9c7aca1b018dde20 = bundle.var_f0931e376cffbeba ?? getdvarfloat( @"hash_c569e9f2a667d24f" );
    
    if ( !isdefined( var_99314d52f73a4a5 ) || var_99314d52f73a4a5 <= 0 )
    {
        return;
    }
    
    var_2333ef99d1390b63 = ( var_436b3e70a30366ae - var_40d317b9f76c4fbc ) / 1000;
    
    if ( var_2333ef99d1390b63 - var_9c7aca1b018dde20 > 0 )
    {
        wait var_2333ef99d1390b63 - var_9c7aca1b018dde20;
    }
    
    callback::callback( #"hash_2b0737f47cfada7e" );
    self function_c598d80eef0b4166( "uin_potg_slowmo_enter" );
    setslowmotion( 1, timescale, var_9c7aca1b018dde20 );
    wait var_99314d52f73a4a5;
    self function_c598d80eef0b4166( "uin_potg_slowmo_exit" );
    setslowmotion( timescale, 1, var_9c7aca1b018dde20 );
}

// Namespace killcam
// Params 5
// Checksum 0xc26e1844, Offset: 0x3627
// Size: 0x87
function function_a159020a08702913( var_40d317b9f76c4fbc, entindex, var_b20557e718d46daf, killcamlookatentityindex, killcamentstickstolookatent )
{
    if ( !isdefined( entindex ) )
    {
        return;
    }
    
    var_2418f5c44ff881f3 = ( var_b20557e718d46daf - var_40d317b9f76c4fbc ) / 1000;
    
    if ( var_2418f5c44ff881f3 > 0 )
    {
        wait var_2418f5c44ff881f3;
        
        if ( !isdefined( self ) )
        {
            return;
        }
    }
    
    self.killcamentity = entindex;
    
    if ( isdefined( killcamlookatentityindex ) )
    {
        self.killcamentitylookat = killcamlookatentityindex;
    }
    
    if ( isdefined( killcamentstickstolookatent ) )
    {
        self setkillcamentstickstolookatent( killcamentstickstolookatent );
    }
}

// Namespace killcam
// Params 2
// Checksum 0xc4e3db93, Offset: 0x36b6
// Size: 0x3cd
function function_ee110d2f6a737516( killtimes, var_40d317b9f76c4fbc )
{
    bundle = level.gametypebundle;
    timescale = bundle.var_2e5e027c4c38b88f ?? 0.25;
    var_99314d52f73a4a5 = bundle.var_c687467038208a3a ?? 0.25;
    var_9c7aca1b018dde20 = bundle.var_eb6c23600a97d58f ?? 0.25;
    var_17029c51a9845357 = bundle.var_ea6364589d4cd440 ?? 0.25;
    var_83a16af32fbafe3c = bundle.var_4b62384c760bb6ac ?? 3;
    var_81c76188d8e19e92 = bundle.var_e497c6fd2c261674 ?? 1.5;
    var_face63935f7c13d4 = bundle.var_56a50532f16538ec ?? getdvarfloat( @"hash_d952d2e72a0e732c" );
    var_d6a6e841d6ccb434 = bundle.var_28be330fd112e79b ?? getdvarfloat( @"hash_fabdb68e639538db" );
    var_3c1b7f91779d539d = bundle.var_f0931e376cffbeba ?? getdvarfloat( @"hash_c569e9f2a667d24f" );
    index = 0;
    timeline = [];
    var_fac9135c7d27504c = undefined;
    
    while ( index < killtimes.size )
    {
        var_7f443318de42990e = index == killtimes.size - 1;
        var_a2f138fa115c8e06 = killtimes[ index ];
        var_87e873e63debf265 = ( var_a2f138fa115c8e06 - var_40d317b9f76c4fbc ) / 1000;
        
        if ( !var_7f443318de42990e )
        {
            var_7fe10a0eddbf98be = killtimes[ index + 1 ];
            var_fac9135c7d27504c = ( var_7fe10a0eddbf98be - var_a2f138fa115c8e06 ) / 1000;
        }
        
        var_9a6f01d1a096a220 = undefined;
        
        if ( index != 0 )
        {
            var_9a6f01d1a096a220 = timeline[ timeline.size - 1 ];
        }
        
        entertimescale = var_7f443318de42990e ? var_face63935f7c13d4 : timescale;
        exittimescale = !var_7f443318de42990e && var_fac9135c7d27504c > var_83a16af32fbafe3c ? var_81c76188d8e19e92 : 1;
        lerpduration = var_7f443318de42990e ? var_3c1b7f91779d539d : var_9c7aca1b018dde20;
        var_a7cf0db07f6c1573 = var_17029c51a9845357 + lerpduration;
        shouldexit = !var_7f443318de42990e && var_fac9135c7d27504c > var_a7cf0db07f6c1573;
        var_6b17a8c228524df4 = 0;
        var_eefe9321877f0f5e = 0;
        
        if ( index == 0 )
        {
            var_6b17a8c228524df4 = 1;
        }
        else if ( var_9a6f01d1a096a220.enter )
        {
            if ( shouldexit )
            {
                var_eefe9321877f0f5e = 1;
            }
        }
        else if ( var_9a6f01d1a096a220.exit )
        {
            var_6b17a8c228524df4 = 1;
        }
        
        if ( var_6b17a8c228524df4 )
        {
            event = spawnstruct();
            event.enter = 1;
            event.eventtime = var_87e873e63debf265 - var_17029c51a9845357;
            event.timescale = entertimescale;
            event.lerpduration = lerpduration;
            timeline[ timeline.size ] = event;
            
            if ( shouldexit )
            {
                var_eefe9321877f0f5e = 1;
            }
        }
        
        if ( var_eefe9321877f0f5e )
        {
            eventtime = var_6b17a8c228524df4 ? var_87e873e63debf265 + var_99314d52f73a4a5 : var_87e873e63debf265;
            event = spawnstruct();
            event.exit = 1;
            event.eventtime = eventtime;
            event.timescale = exittimescale;
            event.lerpduration = lerpduration;
            timeline[ timeline.size ] = event;
        }
        
        index++;
    }
    
    if ( timeline.size > 0 )
    {
        var_9a6f01d1a096a220 = timeline[ timeline.size - 1 ];
        event = spawnstruct();
        event.exit = 1;
        event.eventtime = var_9a6f01d1a096a220.eventtime + var_d6a6e841d6ccb434;
        event.timescale = 1;
        event.lerpduration = var_3c1b7f91779d539d;
        timeline[ timeline.size ] = event;
    }
    
    return timeline;
}

// Namespace killcam
// Params 2
// Checksum 0xe8041749, Offset: 0x3a8c
// Size: 0x1d4
function function_c6e71031ac2dbfc6( killtimes, var_40d317b9f76c4fbc )
{
    timeline = function_ee110d2f6a737516( killtimes, var_40d317b9f76c4fbc );
    output = [];
    starttime = undefined;
    
    foreach ( event in timeline )
    {
        if ( !isdefined( starttime ) )
        {
            starttime = event.eventtime;
        }
        
        line = "[" + event.eventtime - starttime + "]" + ( event.enter ? " E-" : "" ) + ( event.exit ? " X-" : "" ) + "T= " + event.timescale;
        output[ output.size ] = line;
        logprint( line );
    }
    
    /#
        level thread function_8f20ef8445230bdc( output );
    #/
    
    currenttimescale = 1;
    index = 0;
    lasteventtime = 0;
    
    while ( index < timeline.size )
    {
        event = timeline[ index ];
        var_fde73ff5b4f1ae2b = event.eventtime - lasteventtime;
        lasteventtime = event.eventtime;
        
        if ( var_fde73ff5b4f1ae2b > 0 )
        {
            wait var_fde73ff5b4f1ae2b;
        }
        
        setslowmotion( currenttimescale, event.timescale, event.lerpduration );
        currenttimescale = event.timescale;
        index++;
    }
}

// Namespace killcam
// Params 2
// Checksum 0xb742c4aa, Offset: 0x3c68
// Size: 0x350
function function_5d0d2d13110b9d60( killtimes, var_40d317b9f76c4fbc )
{
    timescale = 0.33;
    var_99314d52f73a4a5 = 0.75;
    var_9c7aca1b018dde20 = 0.5;
    var_17029c51a9845357 = 0.75;
    bundle = level.gametypebundle;
    var_face63935f7c13d4 = bundle.var_56a50532f16538ec ?? getdvarfloat( @"hash_d952d2e72a0e732c" );
    var_d6a6e841d6ccb434 = bundle.var_28be330fd112e79b ?? getdvarfloat( @"hash_fabdb68e639538db" );
    var_3c1b7f91779d539d = bundle.var_f0931e376cffbeba ?? getdvarfloat( @"hash_c569e9f2a667d24f" );
    currenttimescale = 1;
    fasttimescale = 2;
    
    for ( index = 0; index < killtimes.size ; index++ )
    {
        var_7f443318de42990e = index == killtimes.size - 1;
        var_1365c76d0506406 = var_7f443318de42990e ? var_face63935f7c13d4 : timescale;
        duration = var_7f443318de42990e ? var_d6a6e841d6ccb434 : var_99314d52f73a4a5;
        lerpduration = var_7f443318de42990e ? var_3c1b7f91779d539d : var_9c7aca1b018dde20;
        finaltimescale = var_7f443318de42990e ? 1 : fasttimescale;
        var_939916a593321947 = var_7f443318de42990e ? 1 : var_17029c51a9845357;
        var_a2f138fa115c8e06 = killtimes[ index ];
        var_26724dc16ab5f25a = var_40d317b9f76c4fbc;
        
        if ( index > 0 )
        {
            var_26724dc16ab5f25a = killtimes[ index - 1 ];
        }
        
        var_87e873e63debf265 = ( var_a2f138fa115c8e06 - var_26724dc16ab5f25a ) / 1000;
        var_8c34ec865c83fade = 1;
        
        if ( !var_7f443318de42990e )
        {
            var_7fe10a0eddbf98be = killtimes[ index + 1 ];
            var_fac9135c7d27504c = ( var_7fe10a0eddbf98be - var_a2f138fa115c8e06 ) / 1000;
            finaltimescale = var_fac9135c7d27504c > 3 ? fasttimescale : 1;
            var_8c34ec865c83fade = var_fac9135c7d27504c > duration + var_939916a593321947 + lerpduration;
        }
        
        /#
            level thread function_8f20ef8445230bdc( "<dev string:x120>" + index + 1 + "<dev string:x127>" + var_87e873e63debf265 + "<dev string:x142>" + currenttimescale + "<dev string:x15d>" + var_8c34ec865c83fade + "<dev string:x178>" + var_7f443318de42990e );
        #/
        
        if ( var_87e873e63debf265 - var_939916a593321947 > 0 )
        {
            wait var_87e873e63debf265 - var_939916a593321947;
        }
        
        self playlocalsound( "uin_potg_slowmo_enter" );
        setslowmotion( currenttimescale, var_1365c76d0506406, lerpduration );
        currenttimescale = var_1365c76d0506406;
        
        /#
            level thread function_8f20ef8445230bdc( "<dev string:x120>" + index + 1 + "<dev string:x193>" + "<dev string:x142>" + currenttimescale + "<dev string:x15d>" + var_8c34ec865c83fade + "<dev string:x178>" + var_7f443318de42990e );
        #/
        
        if ( var_8c34ec865c83fade )
        {
            /#
                level thread function_8f20ef8445230bdc( "<dev string:x120>" + index + 1 + "<dev string:x1a1>" + duration + "<dev string:x142>" + currenttimescale + "<dev string:x15d>" + var_8c34ec865c83fade + "<dev string:x178>" + var_7f443318de42990e );
            #/
            
            wait duration;
            self playlocalsound( "uin_potg_slowmo_exit" );
            setslowmotion( currenttimescale, finaltimescale, lerpduration );
            currenttimescale = finaltimescale;
            
            /#
                level thread function_8f20ef8445230bdc( "<dev string:x120>" + index + 1 + "<dev string:x1bc>" + lerpduration + "<dev string:x142>" + currenttimescale + "<dev string:x15d>" + var_8c34ec865c83fade + "<dev string:x178>" + var_7f443318de42990e );
            #/
            
            wait lerpduration;
        }
    }
}

/#

    // Namespace killcam
    // Params 1
    // Checksum 0x9771a522, Offset: 0x3fc0
    // Size: 0xe6, Type: dev
    function function_8f20ef8445230bdc( output )
    {
        self notify( #"hash_a6312d3712c5df9f" );
        self endon( #"hash_a6312d3712c5df9f" );
        
        if ( !isarray( output ) )
        {
            output = [ output ];
        }
        
        starty = 750;
        stepy = 30;
        
        while ( true )
        {
            foreach ( index, line in output )
            {
                printtoscreen2d( 500, starty + stepy * index, line, ( 1, 1, 1 ), 3, 1 );
            }
            
            waitframe();
        }
    }

#/

// Namespace killcam
// Params 0
// Checksum 0x14e9e407, Offset: 0x40ae
// Size: 0x32
function potgkillcamcleanup()
{
    self.killcam = undefined;
    spectating::setspectatepermissions();
    player::updatesessionstate( "dead" );
    player::clearkillcamstate();
    self notify( #"killcam_ended" );
}

// Namespace killcam
// Params 5
// Checksum 0x869b3aa, Offset: 0x40e8
// Size: 0x15a
function setkillcamnormalweaponomnvars( objweapon, smeansofdeath, einflictor, executionref, attacker )
{
    if ( smeansofdeath == "MOD_EXECUTION" )
    {
        setkillcamexecutiontypeomnvars( executionref );
        return;
    }
    
    if ( !isdefined( objweapon ) || objweapon.basename == "none" )
    {
        namespace_2be4972bbff8c613::clearkillcamattachmentomnvars();
        return;
    }
    
    if ( isdefined( einflictor.glgrenadeparent ) )
    {
        equipmenttype = undefined;
        objweapon = einflictor.glgrenadeparent;
        einflictor = undefined;
    }
    else
    {
        equipmenttype = weapon::getequipmenttype( objweapon );
    }
    
    if ( isdefined( supers_mp::getsuperrefforsuperweapon( objweapon ) ) )
    {
        setkillcamsupertypeomnvars( objweapon );
        return;
    }
    
    if ( equipmenttype == "lethal" || equipmenttype == "tactical" )
    {
        setkillcamequipmenttypeomnvars( objweapon );
        return;
    }
    
    if ( level.gamemodebundle.var_b8686b90947d6097 && ( equipmenttype == "tertiary" || equipmenttype == "equipment_other" ) )
    {
        setkillcamequipmenttypeomnvars( objweapon );
        return;
    }
    
    if ( isdefined( level.killcammiscitems[ objweapon.basename ] ) )
    {
        setkillcammisctypeomnvars( level.killcammiscitems[ objweapon.basename ] );
        return;
    }
    
    setkillcamweapontypeomnvars( objweapon, einflictor, attacker );
}

// Namespace killcam
// Params 1, eflags: 0x4
// Checksum 0x6e64b938, Offset: 0x424a
// Size: 0x36
function private function_c2abdab2929339aa( value )
{
    player = getentbynum( value );
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player notify( #"kc_respawn" );
}

// Namespace killcam
// Params 1
// Checksum 0x3e3d67b8, Offset: 0x4288
// Size: 0x1a6
function waitskipkillcambutton( var_802f80bd23922f6b )
{
    self endon( #"disconnect" );
    self endon( #"killcam_ended" );
    
    if ( !isai( self ) )
    {
        self notifyonplayercommand( "kc_respawn", "+usereload" );
        self notifyonplayercommand( "kc_respawn", "+activate" );
        ui::lui_registercallback( "kc_respawn_lui", &function_c2abdab2929339aa );
        self waittill( #"kc_respawn" );
        
        if ( isdefined( level.var_4c05236cc4daf4b1 ) )
        {
            thread namespace_2be4972bbff8c613::function_520f48ae7cc39a2d();
        }
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "skippedKillcams" ] ) )
            {
                self.leaderboarddata[ "skippedKillcams" ] = self.leaderboarddata[ "skippedKillcams" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "skippedKillcams" ] ) )
            {
                [[ level.leaderboardfunc[ "skippedKillcams" ] ]]( self, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:xfa>" );
            
            if ( isdefined( self.pers[ "skippedKillcams" ] ) )
            {
                self.pers[ "skippedKillcams" ] = self.pers[ "skippedKillcams" ] + 1;
            }
        }
        
        player::printspawnmessage( "killcam::waitSkipKillcamButton() Killcam SKIPPED" );
        self notify( #"abort_killcam" );
        
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( self ? self.name : "undefined" ) + "] " + "waitSkipKillcamButton - abort_killcam" );
        }
    }
}

// Namespace killcam
// Params 0
// Checksum 0x6433315, Offset: 0x4436
// Size: 0x17b
function waitskipkillcamkbmortouch()
{
    self endon( #"disconnect" );
    self endon( #"killcam_ended" );
    self endon( #"abort_killcam" );
    
    if ( self usingtouch() )
    {
        while ( !self jumpbuttonpressed() )
        {
            waitframe();
        }
    }
    else
    {
        while ( self usinggamepad() || !self jumpbuttonpressed() )
        {
            waitframe();
        }
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "skippedKillcams" ] ) )
        {
            self.leaderboarddata[ "skippedKillcams" ] = self.leaderboarddata[ "skippedKillcams" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "skippedKillcams" ] ) )
        {
            [[ level.leaderboardfunc[ "skippedKillcams" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:xfa>" );
        
        if ( isdefined( self.pers[ "skippedKillcams" ] ) )
        {
            self.pers[ "skippedKillcams" ] = self.pers[ "skippedKillcams" ] + 1;
        }
    }
    
    player::printspawnmessage( "killcam::waitSkipKillcamKBMOrTouch() Killcam SKIPPED" );
    self notify( #"abort_killcam" );
    
    if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
    {
        logstring( "[KILLCAM DEBUG] [" + ( self ? self.name : "undefined" ) + "] " + "waitSkipKillcamKBMOrTouch - abort_killcam" );
    }
}

// Namespace killcam
// Params 0
// Checksum 0xd2d68005, Offset: 0x45b9
// Size: 0x196
function function_323adf1d2a49a4d5()
{
    self endon( #"disconnect" );
    self endon( #"killcam_ended" );
    
    if ( !isai( self ) )
    {
        self notifyonplayercommand( "kc_respawn_no_tac_insert", "+movedown" );
        self notifyonplayercommand( "kc_respawn_no_tac_insert", "+stance" );
        self waittill( #"kc_respawn_no_tac_insert" );
        self.skippedspawnpoint = 1;
        
        if ( isdefined( level.var_4c05236cc4daf4b1 ) )
        {
            thread namespace_2be4972bbff8c613::function_520f48ae7cc39a2d();
        }
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "skippedKillcams" ] ) )
            {
                self.leaderboarddata[ "skippedKillcams" ] = self.leaderboarddata[ "skippedKillcams" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "skippedKillcams" ] ) )
            {
                [[ level.leaderboardfunc[ "skippedKillcams" ] ]]( self, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:xfa>" );
            
            if ( isdefined( self.pers[ "skippedKillcams" ] ) )
            {
                self.pers[ "skippedKillcams" ] = self.pers[ "skippedKillcams" ] + 1;
            }
        }
        
        player::printspawnmessage( "killcam::waitSkipKillcamButton() Killcam SKIPPED" );
        self notify( #"abort_killcam" );
        
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( self ? self.name : "undefined" ) + "] " + "waitSkipTacInsertButton - abort_killcam" );
        }
    }
}

// Namespace killcam
// Params 1
// Checksum 0x9de5b535, Offset: 0x4757
// Size: 0x3c
function spawnedkillcamcleanup( isfinalkillcam )
{
    self endon( #"disconnect" );
    self endon( #"killcam_ended" );
    self waittill( #"spawned" );
    killcamcleanup( 0, undefined, isfinalkillcam );
}

// Namespace killcam
// Params 1
// Checksum 0x72eacf81, Offset: 0x479b
// Size: 0x3e
function endedkillcamcleanup( isfinalkillcam )
{
    self endon( #"disconnect" );
    self endon( #"killcam_ended" );
    level waittill( #"game_ended" );
    killcamcleanup( 1, 1, isfinalkillcam );
}

// Namespace killcam
// Params 3
// Checksum 0x8ffc0a7c, Offset: 0x47e1
// Size: 0x10c
function killcamcleanup( updatesession, gameended, isfinalkillcam )
{
    namespace_2be4972bbff8c613::clearkillcamomnvars();
    self.killcam = undefined;
    namespace_2be4972bbff8c613::setcinematiccamerastyle( "unknown", -1, -1 );
    spectating::setspectatepermissions( gameended );
    player::clearkillcamstate();
    
    if ( updatesession && !gameended )
    {
        player::updatesessionstate( "dead" );
    }
    
    self notify( #"killcam_ended" );
    
    if ( level.doingkillcamslowmo )
    {
        setslowmotion( 0.25, 1, 1 );
        level.doingkillcamslowmo = undefined;
    }
    
    self clearsoundsubmix( level.gamemodebundle.var_dcb1c4fe8b1c245c ?? "iw9_mp_core_killcam_mix" );
    
    if ( isdefined( level.gamemodebundle.var_ea62e097837e641 ) )
    {
        self clearsoundsubmix( level.gamemodebundle.var_ea62e097837e641 );
    }
    else
    {
        self clearsoundsubmix( "iw9_mp_killcam" );
    }
    
    if ( isfinalkillcam )
    {
        self setclientomnvar( o"post_game_state", 1 );
    }
}

// Namespace killcam
// Params 3
// Checksum 0x3df2b946, Offset: 0x48f5
// Size: 0xfd
function setkillcamweapontypeomnvars( objweapon, einflictor, attacker )
{
    objweapon = attacker weapon_utility::function_8097c50c526bd683( objweapon );
    objweapon = weapon::mapweapon( objweapon, einflictor );
    rootweaponname = weapon::function_170e300815e9c1a2( objweapon );
    weaponscriptbundles = weapon::function_16ff7d597f441100();
    var_46dec494ffe4f795 = -1;
    
    if ( isdefined( weaponscriptbundles ) && arraycontains( weaponscriptbundles, rootweaponname ) )
    {
        var_46dec494ffe4f795 = function_f02c63b99c9614c9( weaponscriptbundles, rootweaponname ) + 1;
    }
    
    self setclientomnvar( o"ui_weapon_pickup", 0 );
    
    if ( !isdefined( var_46dec494ffe4f795 ) || var_46dec494ffe4f795 < 0 )
    {
        namespace_2be4972bbff8c613::setkillcamkilledbyitemomnvars( -1, -1 );
        return;
    }
    
    if ( isdefined( objweapon.variantid ) )
    {
        self setclientomnvar( o"ui_killcam_killedby_loot_variant_id", objweapon.variantid );
    }
    else
    {
        self setclientomnvar( o"ui_killcam_killedby_loot_variant_id", -1 );
    }
    
    namespace_2be4972bbff8c613::setkillcamkilledbyitemomnvars( 0, var_46dec494ffe4f795 );
    namespace_2be4972bbff8c613::function_9740a1c0ad1f3945( rootweaponname, objweapon );
}

// Namespace killcam
// Params 1
// Checksum 0xb9b25eb7, Offset: 0x49fa
// Size: 0x4b
function setkillcamsupertypeomnvars( objweapon )
{
    ref = supers_mp::getsuperrefforsuperweapon( objweapon );
    id = supers_mp::getsuperid( ref );
    namespace_2be4972bbff8c613::setkillcamkilledbyitemomnvars( 2, id );
    namespace_2be4972bbff8c613::clearlootweaponomnvars();
    namespace_2be4972bbff8c613::clearkillcamattachmentomnvars();
}

// Namespace killcam
// Params 1
// Checksum 0x205330af, Offset: 0x4a4d
// Size: 0x5a
function setkillcamequipmenttypeomnvars( objweapon )
{
    equipmentref = equipment_mp::getequipmentreffromweapon( objweapon );
    equipmentinfo = equipment_mp::getequipmenttableinfo( equipmentref );
    
    if ( isdefined( equipmentinfo ) )
    {
        namespace_2be4972bbff8c613::setkillcamkilledbyitemomnvars( 3, equipmentinfo.id );
    }
    
    namespace_2be4972bbff8c613::clearlootweaponomnvars();
    namespace_2be4972bbff8c613::clearkillcamattachmentomnvars();
}

// Namespace killcam
// Params 1
// Checksum 0x5a3929c7, Offset: 0x4aaf
// Size: 0x46
function setkillcamexecutiontypeomnvars( ref )
{
    if ( !isdefined( ref ) )
    {
        id = 0;
    }
    else
    {
        id = execution::execution_getidbyref( ref );
    }
    
    namespace_2be4972bbff8c613::setkillcamkilledbyitemomnvars( 4, id );
    namespace_2be4972bbff8c613::clearlootweaponomnvars();
    namespace_2be4972bbff8c613::clearkillcamattachmentomnvars();
}

// Namespace killcam
// Params 1
// Checksum 0x807a3eee, Offset: 0x4afd
// Size: 0x25
function setkillcammisctypeomnvars( id )
{
    namespace_2be4972bbff8c613::setkillcamkilledbyitemomnvars( 5, id );
    namespace_2be4972bbff8c613::clearlootweaponomnvars();
    namespace_2be4972bbff8c613::clearkillcamattachmentomnvars();
}

// Namespace killcam
// Params 1
// Checksum 0x9412fbbe, Offset: 0x4b2a
// Size: 0xaa
function isnoneweaponinflictor( einflictor )
{
    isnoneweapon = 0;
    
    if ( isdefined( einflictor ) && isdefined( einflictor.targetname ) )
    {
        switch ( einflictor.targetname )
        {
            case #"hash_2b6c3cfd33ba8b3":
            case #"hash_2b6c4cfd33baa46":
            case #"hash_2b6c5cfd33babd9":
            case #"hash_2b6c6cfd33bad6c":
            case #"hash_2b6c7cfd33baeff":
            case #"hash_2b6c8cfd33bb092":
            case #"hash_3fd866e3da61a87":
            case #"hash_cf0ef5bef19a311b":
                isnoneweapon = 1;
                break;
        }
    }
    
    return isnoneweapon;
}

// Namespace killcam
// Params 1
// Checksum 0xd268da1a, Offset: 0x4bdd
// Size: 0x77
function isenvironmentalinflictor( einflictor )
{
    var_7d7042bb15db74e9 = 0;
    
    if ( isdefined( einflictor.killcament ) && isdefined( einflictor.classname ) )
    {
        switch ( einflictor.classname )
        {
            case #"hash_3872eb7d97592cac":
            case #"hash_6318af6067faf262":
            case #"hash_8040aa10d9cac1e8":
                var_7d7042bb15db74e9 = 1;
                break;
        }
    }
    
    return var_7d7042bb15db74e9;
}

// Namespace killcam
// Params 0
// Checksum 0x895b5a96, Offset: 0x4c5d
// Size: 0xa
function resetplayeromnvarsonkillcam()
{
    vehicle_omnvar::clear_all( self );
}

// Namespace killcam
// Params 1
// Checksum 0xb2e16a1d, Offset: 0x4c6f
// Size: 0x111
function function_98bc702d573f2159( time )
{
    if ( !level.killcam )
    {
        return;
    }
    
    starttime = time - 1000;
    endtime = time + 10000;
    
    while ( gettime() < starttime )
    {
        waitframe();
    }
    
    level.var_a5ecc4fd7d64db7b = 1;
    var_1a77e398e642757f = level.skipfinalkillcam;
    level.skipfinalkillcam = 1;
    
    foreach ( player in level.players )
    {
        player notify( #"abort_killcam" );
    }
    
    while ( gettime() < endtime )
    {
        waitframe();
    }
    
    level.var_a5ecc4fd7d64db7b = 0;
    level.skipfinalkillcam = var_1a77e398e642757f;
}

// Namespace killcam
// Params 3, eflags: 0x4
// Checksum 0x8644cf5e, Offset: 0x4d88
// Size: 0xc8
function private function_aad7f77ecd7c12ef( victim, attacker, objweapon )
{
    if ( isdefined( attacker ) && objweapon != level.weaponnone && weaponrank::weaponshouldgetxp( objweapon ) )
    {
        weaponrootname = weapon::getweaponrootname( objweapon );
        weaponrank = attacker weaponrank::getplayerweaponrank( weaponrootname );
        weaponprestige = attacker weaponrank::function_537a18f0105123c2( weaponrootname );
        victim setclientomnvar( o"ui_killcam_killedby_weapon_rank", weaponrank );
        victim setclientomnvar( o"ui_killcam_killedby_weapon_prestige", weaponprestige ?? 0 );
        return;
    }
    
    victim setclientomnvar( o"ui_killcam_killedby_weapon_rank", -1 );
    victim setclientomnvar( o"ui_killcam_killedby_weapon_prestige", 0 );
}

// Namespace killcam
// Params 4, eflags: 0x4
// Checksum 0xa2b2971f, Offset: 0x4e58
// Size: 0x1a0
function private function_2822e9647710e121( victim, attacker, loadoutitemtype, loadoutitemindex )
{
    if ( !( isdefined( loadoutitemtype ) && isdefined( loadoutitemindex ) ) )
    {
        victim setclientomnvar( o"ui_killcam_killedby_progress", -1 );
        victim setclientomnvar( o"ui_killcam_killedby_isdiamond", 0 );
        return;
    }
    
    if ( loadoutitemtype == 0 )
    {
        masteryprogress = attacker class::function_f1f2a5135fbe83f( loadoutitemindex );
        isdiamond = attacker class::function_a9a5ba5a2745dd58( loadoutitemindex );
        victim setclientomnvar( o"ui_killcam_killedby_progress", masteryprogress );
        victim setclientomnvar( o"ui_killcam_killedby_isdiamond", isdiamond );
        return;
    }
    
    if ( loadoutitemtype == 1 )
    {
        masteryprogress = attacker class::function_7ea65ab64d45951b( loadoutitemindex );
        isdiamond = attacker class::function_4fe1d5b1ce437c8c( loadoutitemindex );
        victim setclientomnvar( o"ui_killcam_killedby_progress", masteryprogress );
        victim setclientomnvar( o"ui_killcam_killedby_isdiamond", isdiamond );
        return;
    }
    
    if ( loadoutitemtype == 2 )
    {
        masteryprogress = attacker class::function_1e986bb80d3f2f3( loadoutitemindex );
        isdiamond = attacker class::function_2e6bde4694e5bc14( loadoutitemindex );
        victim setclientomnvar( o"ui_killcam_killedby_progress", masteryprogress );
        victim setclientomnvar( o"ui_killcam_killedby_isdiamond", isdiamond );
        return;
    }
    
    if ( loadoutitemtype == 3 )
    {
        masteryprogress = attacker class::function_f792e49976e43075( loadoutitemindex );
        isdiamond = attacker class::function_b906cc74d1c29a7e( loadoutitemindex );
        victim setclientomnvar( o"ui_killcam_killedby_progress", masteryprogress );
        victim setclientomnvar( o"ui_killcam_killedby_isdiamond", isdiamond );
        return;
    }
    
    victim setclientomnvar( o"ui_killcam_killedby_progress", -1 );
    victim setclientomnvar( o"ui_killcam_killedby_isdiamond", 0 );
}

// Namespace killcam
// Params 3, eflags: 0x4
// Checksum 0x83eef9, Offset: 0x5000
// Size: 0x289
function private function_b4f62e3fd89ab149( victim, attacker, objweapon )
{
    if ( isdefined( attacker ) )
    {
        loadoutitemtype = undefined;
        loadoutitemindex = undefined;
        classtype = class::loadout_getclasstype( attacker.class );
        
        if ( classtype == "custom" )
        {
            if ( objweapon.basename === attacker.primaryweaponobj.basename )
            {
                loadoutitemtype = 0;
                loadoutitemindex = 0;
            }
            else if ( objweapon.basename === attacker.secondaryweaponobj.basename )
            {
                loadoutitemtype = 0;
                loadoutitemindex = 1;
            }
            else if ( objweapon.basename === attacker.var_cc1262e66dbb1c79.basename )
            {
                loadoutitemtype = 0;
                loadoutitemindex = 2;
            }
            else if ( objweapon.basename === attacker.offhandinventory[ 0 ].basename )
            {
                loadoutitemtype = 1;
                loadoutitemindex = 0;
            }
            else if ( objweapon.basename === attacker.offhandinventory[ 1 ].basename )
            {
                loadoutitemtype = 1;
                loadoutitemindex = 1;
            }
            else if ( objweapon.basename === level.superglobals.staticsuperdata[ attacker.loadoutfieldupgrade1 ].weapon )
            {
                loadoutitemtype = 2;
                loadoutitemindex = 0;
            }
            else if ( objweapon.basename === level.superglobals.staticsuperdata[ attacker.loadoutfieldupgrade2 ].weapon )
            {
                loadoutitemtype = 2;
                loadoutitemindex = 1;
            }
            
            killstreakname = killstreak::getkillstreaknamefromweapon( objweapon );
            
            if ( isdefined( killstreakname ) )
            {
                if ( killstreakname === attacker.streakdata.streaks[ 1 ].streakname )
                {
                    loadoutitemtype = 3;
                    loadoutitemindex = 0;
                }
                else if ( killstreakname === attacker.streakdata.streaks[ 2 ].streakname )
                {
                    loadoutitemtype = 3;
                    loadoutitemindex = 1;
                }
                else if ( killstreakname === attacker.streakdata.streaks[ 3 ].streakname )
                {
                    loadoutitemtype = 3;
                    loadoutitemindex = 2;
                }
            }
            
            function_2822e9647710e121( victim, attacker, loadoutitemtype, loadoutitemindex );
        }
    }
}

// Namespace killcam
// Params 2, eflags: 0x4
// Checksum 0xaa18400b, Offset: 0x5291
// Size: 0x36
function private function_439f86166bc0777f( attacker, objweapon )
{
    if ( level.gametypebundle.var_49ce0ad53035f21d )
    {
        function_b4f62e3fd89ab149( self, attacker, objweapon );
    }
}

