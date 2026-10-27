// scripts\mp\common\equipment\temp_v.gsc  (hash_62a52ff6ad67ce4c.gscc) (size: 8106 Bytes / 0x1faa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1651fd7b (374472059)
// size ...... 8106 (0x1faa)
// includes .. 11  (offset: 0x1c46)
// strings ... 55  (offset: 0x1c9e)
// dev strs .. 0   (offset: 0x1faa)
// exports ... 27  (offset: 0x110a)
// cseg ...... 0x494 + 0xc76 (0x110a)
// imports ... 59  (offset: 0x1542)
// animtree1 . 0   (offset: 0x1faa)
// animtree2 . 0   (offset: 0x1faa)
#using script_75ec3104e260fc21;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\equipment\temp_v_melee_superpower;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\hud_message;
#using scripts\mp\supers;
#using scripts\mp\talking_gun;

#namespace temp_v;

// Namespace temp_v
// Params 0, eflags: 0x1
// Checksum 0x57f1911c, Offset: 0x4b2
// Size: 0x9
function autoexec main()
{
    init();
}

// Namespace temp_v
// Params 0
// Checksum 0x5c1550a3, Offset: 0x4c3
// Size: 0xdb
function init()
{
    utility::flag_wait( "supers_initialized" );
    level.tempvdata = spawnstruct();
    level.tempvdata.powers = [];
    level.tempvdata.perks = [ "specialty_super_strength", "specialty_durability", "specialty_super_speed" ];
    level.tempvcount = 0;
    temp_v_melee_superpower::function_752f0d0ab9b1a9c3();
    level._effect[ "superPower_teleportOut" ] = loadfxasset( "vfx_iw9_gameplay_theboys_teleport_out" );
    game[ "dialog" ][ "supe_spotted" ] = "game_ovld_spes";
    game[ "dialog" ][ "supe_lost" ] = "game_ovld_spec";
    game[ "dialog" ][ "supe_killed" ] = "game_ovld_sprk";
    audio_utility::snd_transient_load( "mp_gamemode_temp_v" );
    utility::flag_set( "temp_v_initialized" );
}

// Namespace temp_v
// Params 0
// Checksum 0x6b56ee56, Offset: 0x5a6
// Size: 0x1b
function tempv_ongive()
{
    thread hud_message::showsplash( "super_temp_v" + "_pickup", undefined, self, undefined, undefined, undefined, 1 );
}

// Namespace temp_v
// Params 0
// Checksum 0x2fa05a64, Offset: 0x5c9
// Size: 0x1c, Type: bool
function tempv_used()
{
    thread function_1e26a9b95b8458a6();
    talking_gun::talkinggun_event( self, #"self_apply" );
    return true;
}

// Namespace temp_v
// Params 0
// Checksum 0xbf470320, Offset: 0x5ee
// Size: 0xc3
function function_1e26a9b95b8458a6()
{
    while ( isdefined( self getheldoffhand() ) && self getheldoffhand().basename == "tempv_mp" )
    {
        waitframe();
    }
    
    if ( isbrgamemode() )
    {
        self setclientomnvar( "ui_super_warning", 1 );
    }
    
    if ( isdefined( level.tempvcount ) )
    {
        level.tempvcount--;
        
        if ( level.tempvcount < 0 )
        {
            level.tempvcount = 0;
        }
    }
    
    self setscriptablepartstate( "superpowers_aura", "on", 0 );
    self setscriptablepartstate( "superpowers_veins", "on", 0 );
    self.var_4d00f2f3e96b6b1f = 1;
    thread function_eea5515229ac2389();
    thread function_806a4686b8251802();
    function_693c667ca3a39a81( self );
    thread function_7225b4958acb015d();
    thread function_26ce816a73591e6c();
    thread function_e6fcac382ffb54d6();
}

// Namespace temp_v
// Params 0
// Checksum 0xae78bb0a, Offset: 0x6b9
// Size: 0x4, Type: bool
function tempv_end()
{
    return true;
}

// Namespace temp_v
// Params 1
// Checksum 0x211e12a, Offset: 0x6c6
// Size: 0x79
function function_3ace02579c729e18( mapname )
{
    powerlist = [ "super_teleport_deploy", "super_electric_discharge", "super_high_jump", "super_laser_charge" ];
    
    if ( level.mapname == "mp_bio_lab" || level.mapname == "mp_biobunker" )
    {
        powerlist = [ "super_electric_discharge", "super_laser_charge" ];
    }
    
    return powerlist;
}

// Namespace temp_v
// Params 0
// Checksum 0x647d08c7, Offset: 0x748
// Size: 0x14f
function function_7225b4958acb015d()
{
    powerlist = function_3ace02579c729e18( level.mapname );
    randint = randomint( powerlist.size );
    powerref = powerlist[ randint ];
    forcepower = getdvar( @"hash_18cc28f3820edbd6", "" );
    
    if ( forcepower != "" )
    {
        if ( forcepower == "teleport" )
        {
            powerref = "super_teleport_deploy";
        }
        else if ( forcepower == "electric" )
        {
            powerref = "super_electric_discharge";
        }
        else if ( forcepower == "jump" )
        {
            powerref = "super_high_jump";
        }
        else if ( forcepower == "laser" )
        {
            powerref = "super_laser_charge";
        }
    }
    
    equipname = "equip_";
    postfix = getsubstr( powerref, 6 );
    
    if ( isbrgamemode() )
    {
        supers_mp::function_1f9b6b3c1d1f1404( 0 );
        equipname += postfix;
        br_pickups::_givebrsuper( equipname, powerref, 1 );
    }
    else
    {
        perkpackage::perkpackage_giveoverridefieldupgrades( powerref );
        supers_mp::givesuperpoints( supers_mp::getsuperpointsneeded(), undefined, 0 );
    }
    
    superid = level.superglobals.staticsuperdata[ powerref ].id;
    self setclientomnvar( "ui_field_upgrade_use", superid );
    supers_mp::showsuperremindersplash();
}

// Namespace temp_v
// Params 0
// Checksum 0x6f78f10a, Offset: 0x89f
// Size: 0x11
function function_2df383dc27a62e8e()
{
    supers_mp::givesuper( "super_melee_jugg", 0, 1 );
}

// Namespace temp_v
// Params 0
// Checksum 0x76ec8b8, Offset: 0x8b8
// Size: 0xe
function function_ec9445bc9b257a61()
{
    perkpackage::perkpackage_giveoverridefieldupgrades( "super_teleport_deploy" );
}

// Namespace temp_v
// Params 0
// Checksum 0xaeeb38f5, Offset: 0x8ce
// Size: 0xe
function function_3d073d5ca1a1d52()
{
    perkpackage::perkpackage_giveoverridefieldupgrades( "super_electric_discharge" );
}

// Namespace temp_v
// Params 0
// Checksum 0xcbd5bee, Offset: 0x8e4
// Size: 0xe
function function_33b9d689a110effd()
{
    perkpackage::perkpackage_giveoverridefieldupgrades( "super_high_jump" );
}

// Namespace temp_v
// Params 0
// Checksum 0x63896339, Offset: 0x8fa
// Size: 0xe
function function_b6bc6293e5bcfc9a()
{
    perkpackage::perkpackage_giveoverridefieldupgrades( "super_laser_charge" );
}

// Namespace temp_v
// Params 4
// Checksum 0xcb26347c, Offset: 0x910
// Size: 0x175
function function_6fde086c9d1330d9( shouldfinish, dontclear, waitons, iskillstreak )
{
    if ( isdefined( waitons ) )
    {
        if ( isarray( waitons ) )
        {
            utility::waittill_any_in_array( waitons );
        }
        else
        {
            self waittill( waitons );
        }
    }
    
    if ( !iskillstreak )
    {
        if ( shouldfinish )
        {
            supers_mp::superusefinished();
        }
        
        hasswapped = 0;
        superinfo = self.super;
        
        if ( !isdefined( superinfo ) || !supers_mp::issuperpower( superinfo.staticdata.ref ) )
        {
            hasswapped = 1;
        }
        
        if ( !dontclear && !hasswapped )
        {
            supers_mp::clearsuper();
            
            if ( utility::issharedfuncdefined( #"br", #"superslotcleanup" ) )
            {
                self [[ utility::getsharedfunc( #"br", #"superslotcleanup" ) ]]();
            }
        }
        
        if ( isbrgamemode() )
        {
            self setclientomnvar( "ui_super_warning", 0 );
        }
    }
    
    self setscriptablepartstate( "superpowers", "off", 0 );
    self setscriptablepartstate( "superpowers_aura", "off", 0 );
    self setscriptablepartstate( "heroDiveVfx", "off", 0 );
    self.var_4d00f2f3e96b6b1f = 0;
    
    if ( getdvarint( @"hash_93804fe50a4ddeab", 0 ) && !iskillstreak )
    {
        utility::delaythread( 0.25, &function_267deb6777eaae09 );
    }
    
    self notify( #"temp_v_finished" );
}

// Namespace temp_v
// Params 0
// Checksum 0x5c1a771d, Offset: 0xa8d
// Size: 0x2b
function function_267deb6777eaae09()
{
    if ( isbrgamemode() )
    {
        br_pickups::_givebrsuper( "equip_temp_v", "super_temp_v", 1 );
        return;
    }
    
    perkpackage::perkpackage_giveimmediate( "super_temp_v" );
}

// Namespace temp_v
// Params 1
// Checksum 0x59c50510, Offset: 0xac0
// Size: 0x60
function function_b7343920dad0c81e( equipmentref )
{
    if ( !isdefined( equipmentref ) )
    {
        return 0;
    }
    
    switch ( equipmentref )
    {
        case #"hash_5b20a7c66514f7c":
        case #"hash_20be479cff1234e3":
        case #"hash_6cb9c4c2ee706f5d":
        case #"hash_fc0d3d954c29e3ec":
            return 1;
        default:
            return 0;
    }
}

// Namespace temp_v
// Params 1
// Checksum 0xc9c8ecfb, Offset: 0xb28
// Size: 0x13b
function function_be5cc04b5e1bf105( instance )
{
    if ( !level.tempv_enabled )
    {
        return;
    }
    
    tempvloot = undefined;
    dropchance = getdvarint( @"hash_f15bc465eb216c3e", 5 );
    
    switch ( instance.type )
    {
        case #"hash_19ba8d41970911ad":
            dropchance = getdvarint( @"hash_202437d366ab08bf", 50 );
            break;
        default:
            if ( issubstr( instance.type, "br_loot_cache" ) )
            {
                dropchance = getdvarint( @"hash_2f77de10bafc6229", 25 );
            }
            
            if ( getdvarint( @"hash_1c4ecb2e31a1b8e8", 0 ) )
            {
                dropchance = 0;
            }
            
            break;
    }
    
    forcedrop = getdvarint( @"hash_69e3493c0e7dc860", 0 );
    tempvloot = undefined;
    var_eeae197a9d1d6773 = getdvarint( @"hash_a0594edd74c2cd34", 100 );
    
    if ( level.tempvcount < var_eeae197a9d1d6773 )
    {
        droproll = randomintrange( 1, 100 );
        
        if ( forcedrop || dropchance > 0 && droproll <= dropchance )
        {
            level.tempvcount++;
            tempvloot = "brloot_super_temp_v";
        }
    }
    
    return tempvloot;
}

// Namespace temp_v
// Params 0, eflags: 0x4
// Checksum 0xdcc80997, Offset: 0xc6c
// Size: 0x3f
function private function_eea5515229ac2389()
{
    self endon( #"disconnect" );
    self visionsetnakedforplayer( "battlerage-low-health", 0.5 );
    utility::waittill_any_timeout( 0.2, "death" );
    self visionsetnakedforplayer( "", 0.5 );
}

// Namespace temp_v
// Params 0, eflags: 0x4
// Checksum 0x4a5471c6, Offset: 0xcb3
// Size: 0x30
function private function_806a4686b8251802()
{
    self endon( #"disconnect" );
    utility::waittill_any_timeout( 1, "death" );
    self setscriptablepartstate( "superpowers_veins", "off", 0 );
}

// Namespace temp_v
// Params 1, eflags: 0x4
// Checksum 0x82e89139, Offset: 0xceb
// Size: 0x119
function private function_693c667ca3a39a81( player )
{
    if ( !isbrgamemode() )
    {
        return;
    }
    
    if ( !getdvarint( @"scr_tempv_marker", 1 ) )
    {
        return;
    }
    
    bountysettings = spawnstruct();
    bountysettings.var_e73a01c81013d4fe = "NONE";
    bountysettings.var_bc30c84910a7bec5 = "QUEST_CIRCLE";
    bountysettings.inworld = 0;
    bountysettings.var_897dae3075ed501f = "TempV_Br";
    bountysettings.questcircleicon = "hud_icon_power_temp_v";
    bountysettings.circleradius = getdvarint( @"hash_e232615a13615b53", 1000 );
    bountysettings.circleupdatetime = getdvarint( @"hash_c3c506f46b023d34", 5 );
    bountysettings.var_af4505e4e9f04c8c = &function_c722ee2b299ce541;
    bountysettings.var_336e74ebcca5f960 = &function_77b9e7f4c9ad44c3;
    bountysettings.bountyendcondition = &function_6275b000dce0746b;
    bountysettings.bountytimeout = 0;
    bountysettings.priority = 1;
    namespace_46a68a2fbc49b599::function_53f805be5f836a5( player, bountysettings );
}

// Namespace temp_v
// Params 2
// Checksum 0x7de13518, Offset: 0xe0c
// Size: 0x72
function function_c722ee2b299ce541( bountysettings, playerentering )
{
    if ( !isdefined( playerentering.tempvmarkers ) )
    {
        playerentering.tempvmarkers = 0;
    }
    
    playerentering.tempvmarkers++;
    
    if ( !function_c90db7672de85369( playerentering, bountysettings ) )
    {
        return;
    }
    
    playerentering.lastdialogtimetempv = gettime();
    br_public::brleaderdialogplayer( "supe_spotted", playerentering, 1, 0, undefined, undefined, "dx_br_bds4_" );
}

// Namespace temp_v
// Params 2
// Checksum 0x65fa3ec7, Offset: 0xe86
// Size: 0xb6
function function_77b9e7f4c9ad44c3( bountysettings, playerexiting )
{
    playerexiting.tempvmarkers--;
    
    if ( playerexiting.tempvmarkers <= 0 )
    {
        playerexiting.tempvmarkers = 0;
    }
    
    if ( !function_c90db7672de85369( playerexiting, bountysettings, 1 ) )
    {
        return;
    }
    
    playerexiting.lastdialogtimetempv = gettime();
    
    if ( isdefined( bountysettings.player ) && !bountysettings.player player::isreallyalive() )
    {
        br_public::brleaderdialogplayer( "supe_killed", playerexiting, 1, 0, undefined, undefined, "dx_br_bds4_" );
        return;
    }
    
    br_public::brleaderdialogplayer( "supe_lost", playerexiting, 1, 0, undefined, undefined, "dx_br_bds4_" );
}

// Namespace temp_v
// Params 3
// Checksum 0x669ddf65, Offset: 0xf44
// Size: 0xde, Type: bool
function function_c90db7672de85369( var_4d117a6fe0f54f2c, bountysettings, var_deaac1950a9b8306 )
{
    if ( !getdvarint( @"hash_3f710c257c1c6fb2", 1 ) )
    {
        return false;
    }
    
    if ( !isdefined( var_4d117a6fe0f54f2c ) )
    {
        return false;
    }
    
    if ( isdefined( var_4d117a6fe0f54f2c ) && var_4d117a6fe0f54f2c.team == bountysettings.player.team )
    {
        return false;
    }
    
    if ( isdefined( var_4d117a6fe0f54f2c.lastdialogtimetempv ) )
    {
        timediff = ( gettime() - var_4d117a6fe0f54f2c.lastdialogtimetempv ) / 1000;
        
        if ( timediff <= getdvarint( @"hash_1b11c351d93c1126", 5 ) )
        {
            return false;
        }
    }
    
    if ( var_deaac1950a9b8306 )
    {
        if ( var_4d117a6fe0f54f2c.tempvmarkers > 0 )
        {
            return false;
        }
    }
    else if ( var_4d117a6fe0f54f2c.tempvmarkers > 1 )
    {
        return false;
    }
    
    return true;
}

// Namespace temp_v
// Params 1
// Checksum 0x2e3abe0c, Offset: 0x102b
// Size: 0x5d
function function_6275b000dce0746b( bountysettings )
{
    level endon( #"game_ended" );
    bountysettings endon( #"bounty_end" );
    bountysettings.player utility::waittill_any( "death_or_disconnect", "enter_live_ragdoll", "successful_exfil", "map_to_map_warp", "temp_v_finished" );
    namespace_46a68a2fbc49b599::bounty_endbounty( bountysettings, 1, 2 );
}

// Namespace temp_v
// Params 0
// Checksum 0xe1f720a8, Offset: 0x1090
// Size: 0x41
function function_26ce816a73591e6c()
{
    self endon( #"temp_v_finished" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    utility::waittill_any( "death", "unset_super" );
    thread function_6fde086c9d1330d9( 0, 1 );
}

// Namespace temp_v
// Params 0
// Checksum 0x46dbd7aa, Offset: 0x10d9
// Size: 0x31
function function_e6fcac382ffb54d6()
{
    self endon( #"temp_v_finished" );
    self endon( #"disconnect" );
    level waittill( #"game_ended" );
    thread function_6fde086c9d1330d9( 0, 1 );
}

