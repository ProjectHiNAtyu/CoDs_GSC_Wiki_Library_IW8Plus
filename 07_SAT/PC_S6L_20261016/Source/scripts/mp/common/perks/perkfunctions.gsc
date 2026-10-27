// scripts\mp\common\perks\perkfunctions.gsc  (hash_16703a7a81b5d957.gscc) (size: 127502 Bytes / 0x1f20e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd642c9c0 (3594701248)
// size ...... 127502 (0x1f20e)
// includes .. 63  (offset: 0x1dace)
// strings ... 331 (offset: 0x1dcc6)
// dev strs .. 8   (offset: 0x1f1a2)
// exports ... 642 (offset: 0x12156)
// cseg ...... 0x1be1 + 0x10575 (0x12156)
// imports ... 651 (offset: 0x185a6)
// animtree1 . 0   (offset: 0x1f20e)
// animtree2 . 0   (offset: 0x1f20e)
#using script_5adc0ee463b8a974;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\script;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_compass;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\archetypes\archassault;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\class;
#using scripts\mp\common\equipment\gas_grenade;
#using scripts\mp\common\equipment\snapshot_grenade;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perk_mark_targets;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damagefeedback;
#using scripts\mp\destructible;
#using scripts\mp\door;
#using scripts\mp\emp_debuff;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\laststand;
#using scripts\mp\lightarmor;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outline;
#using scripts\mp\overlord;
#using scripts\mp\playerhealth;
#using scripts\mp\rank;
#using scripts\mp\spawncamera;
#using scripts\mp\supers;
#using scripts\mp\talking_gun;
#using scripts\mp\teamrevive;
#using scripts\mp\uav_tower;
#using scripts\mp\weapons;

#namespace perkfunctions;

// Namespace perkfunctions
// Params 0
// Checksum 0x882c25a6, Offset: 0x1bff
// Size: 0x9
function sethealer()
{
    thread radialhealer();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x8ee12224, Offset: 0x1c10
// Size: 0x1c5
function radialhealer()
{
    self endon( #"unset_healer" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !level.teambased )
    {
        return;
    }
    
    self.teammateswithhealperk = [];
    
    while ( true )
    {
        if ( player::isreallyalive() )
        {
            players = player_utility::script_getplayersinradius( self.origin, 350, self.team, self );
            
            foreach ( player in players )
            {
                if ( isdefined( player.perks[ "specialty_healer" ] ) )
                {
                    continue;
                }
                
                if ( self.team == player.team && player player::isreallyalive() && !isdefined( player.healer ) )
                {
                    playerentitynum = player getentitynumber();
                    
                    if ( self.teammateswithhealperk.size == 0 )
                    {
                        hud_message::showmiscmessage( %"miscmessage:healing_players" );
                    }
                    
                    player.healer = self;
                    self.teammateswithhealperk[ playerentitynum ] = 1;
                    player perk::giveperk( "specialty_regenfaster" );
                    player perk::giveperk( "specialty_regen_delay_reduced" );
                    player hud_message::showmiscmessage( %"miscmessage:in_healing_range" );
                    givehealedoverlay( player );
                    thread healerperkteammatewatcher( player );
                    thread healerperkteammatedestructor( player );
                }
            }
        }
        
        wait 0.3;
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0xd95e272c, Offset: 0x1ddd
// Size: 0x15b
function healerperkteammatewatcher( player )
{
    level endon( #"game_ended" );
    self endon( #"unset_healer" );
    self endon( #"death_or_disconnect" );
    player endon( #"death_or_disconnect" );
    
    while ( true )
    {
        lim = 400;
        
        if ( distancesquared( self.origin, player.origin ) > lim * lim || player.team != self.team )
        {
            player notify( #"out_of_healing_range" );
            return;
        }
        
        if ( player.health < player.maxhealth && player.healedoverlay.alpha == player.healedoverlay.lowalpha )
        {
            player thread healedoverlayfade( player.healedoverlay, self, player.healedoverlay.highalpha );
        }
        else if ( player.health == player.maxhealth )
        {
            player thread healedoverlayfade( player.healedoverlay, self, player.healedoverlay.lowalpha );
        }
        
        wait 0.1;
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0xe5f5df8a, Offset: 0x1f40
// Size: 0xba
function healerperkteammatedestructor( player )
{
    level endon( #"game_ended" );
    playerentitynum = player getentitynumber();
    utility::waittill_any_ents( self, "unset_healer", self, "death_or_disconnect", player, "death_or_disconnect", player, "out_of_healing_range" );
    
    if ( isdefined( player ) )
    {
        player perk::removeperk( "specialty_regenfaster" );
        player perk::removeperk( "specialty_regen_delay_reduced" );
        player.healer = undefined;
        player hud_message::showmiscmessage( %"miscmessage:out_of_healing_range" );
    }
    
    if ( isdefined( self ) )
    {
        self.teammateswithhealperk[ playerentitynum ] = undefined;
        
        if ( self.teammateswithhealperk.size == 0 )
        {
            hud_message::showmiscmessage( %"miscmessage:no_healing_players" );
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb117ce20, Offset: 0x2002
// Size: 0xe
function unsethealer()
{
    self notify( #"unset_healer" );
}

// Namespace perkfunctions
// Params 1
// Checksum 0xe4503945, Offset: 0x2018
// Size: 0xe8
function givehealedoverlay( player )
{
    healedoverlay = newclienthudelem( player );
    healedoverlay.x = 0;
    healedoverlay.y = 0;
    healedoverlay setshader( "overlay_healer", 640, 480 );
    healedoverlay.alignx = "left";
    healedoverlay.aligny = "top";
    healedoverlay.horzalign = "fullscreen";
    healedoverlay.vertalign = "fullscreen";
    healedoverlay.alpha = 0;
    healedoverlay.lowalpha = 0;
    healedoverlay.highalpha = 0.75;
    player.healedoverlay = healedoverlay;
    player thread healedoverlayfade( healedoverlay, self, healedoverlay.lowalpha );
    player thread healedoverlaydestructor( healedoverlay, self );
}

// Namespace perkfunctions
// Params 3
// Checksum 0xa1647c32, Offset: 0x2108
// Size: 0x76
function healedoverlayfade( healedoverlay, healer, final )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"out_of_healing_range" );
    healer endon( #"death_or_disconnect" );
    healer endon( #"unset_healer" );
    healedoverlay fadeovertime( 0.5 );
    healedoverlay.alpha = final;
}

// Namespace perkfunctions
// Params 2
// Checksum 0x4f6a244e, Offset: 0x2186
// Size: 0x62
function healedoverlaydestructor( healedoverlay, healer )
{
    utility::waittill_any_ents( level, "game_ended", healer, "unset_healer", healer, "death_or_disconnect", self, "death_or_disconnect", self, "out_of_healing_range" );
    
    if ( isdefined( healedoverlay ) )
    {
        healedoverlay fadeovertime( 1 );
        healedoverlay.alpha = 0;
        wait 1;
        healedoverlay destroy();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x4c061732, Offset: 0x21f0
// Size: 0xc
function setbreacher()
{
    door::updatealldoorslockvisibilityforplayer( self, 1 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x4e4d90dc, Offset: 0x2204
// Size: 0xb
function unsetbreacher()
{
    door::updatealldoorslockvisibilityforplayer( self, 0 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x5caac54f, Offset: 0x2217
// Size: 0x9
function setoffhandprovider()
{
    thread offhandproviderthread();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x4993038c, Offset: 0x2228
// Size: 0x1d6
function offhandproviderthread()
{
    level endon( #"game_ended" );
    self endon( #"hash_7e4a80b9b28171f3" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        players = player_utility::script_getplayersinradius( self.origin, 144, self.team, self );
        
        foreach ( player in players )
        {
            if ( !isdefined( player.ohpequipmentrefills ) )
            {
                player.ohpequipmentrefills = [];
            }
            
            if ( player equipmentusedbyslot( "primary" ) == 0 && player equipmentusedbyslot( "secondary" ) == 0 )
            {
                continue;
            }
            
            if ( !isdefined( player.ohpequipmentrefills[ self getentitynumber() ] ) && player player::isreallyalive() )
            {
                player.ohpequipmentrefills[ self getentitynumber() ] = 1;
                equipmentfilled = player refillequipment();
                
                for ( i = 0; i < equipmentfilled[ "primary" ] ; i++ )
                {
                    player thread ohpequipmentfillednotification( self.name, player equipment_mp::getcurrentequipment( "primary" ) );
                }
                
                for ( i = 0; i < equipmentfilled[ "secondary" ] ; i++ )
                {
                    player thread ohpequipmentfillednotification( self.name, player equipment_mp::getcurrentequipment( "secondary" ) );
                }
                
                thread ohpallowuseonplayerdeath( player );
                player playsoundtoplayer( "scavenger_pack_pickup", player );
            }
        }
        
        wait 0.1;
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0x8cbe60f, Offset: 0x2406
// Size: 0x58
function ohpallowuseonplayerdeath( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    entnum = self getentitynumber();
    utility::waittill_any_ents_return( self, "disconnect", player, "death" );
    player.ohpequipmentrefills[ entnum ] = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x6723f854, Offset: 0x2466
// Size: 0xe
function unsetoffhandprovider()
{
    self notify( #"hash_7e4a80b9b28171f3" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x193c6120, Offset: 0x247c
// Size: 0x3b
function refillequipment()
{
    equipmentrefilled = [];
    equipmentrefilled[ "primary" ] = equipmentusedbyslot( "primary", 1 );
    equipmentrefilled[ "secondary" ] = equipmentusedbyslot( "secondary", 1 );
    return equipmentrefilled;
}

// Namespace perkfunctions
// Params 2
// Checksum 0x38492490, Offset: 0x24c0
// Size: 0x96
function equipmentusedbyslot( slot, refill )
{
    assert( slot == "<dev string:x24>" || slot == "<dev string:x2c>", "<dev string:x36>" );
    
    if ( !isdefined( refill ) )
    {
        refill = 0;
    }
    
    eq = equipment_mp::getcurrentequipment( slot );
    eqcap = getequipmentstartammo( slot );
    eqammo = equipment_mp::getequipmentammo( eq );
    
    if ( refill && eqcap - eqammo > 0 )
    {
        equipment_mp::incrementequipmentammo( eq, eqcap - eqammo );
    }
    
    return eqcap - eqammo;
}

// Namespace perkfunctions
// Params 1
// Checksum 0xf0de9757, Offset: 0x255f
// Size: 0x6a
function getequipmentstartammo( slot )
{
    assert( slot == "<dev string:x24>" || slot == "<dev string:x2c>", "<dev string:x36>" );
    eq = equipment_mp::getcurrentequipment( slot );
    eqcap = equipment_mp::getequipmentstartammo( eq );
    
    if ( equipment_mp::function_af93851266de71f3( slot ) )
    {
        eqcap = equipment_mp::getequipmentmaxammo( eq );
    }
    
    return eqcap;
}

// Namespace perkfunctions
// Params 2
// Checksum 0xbe529d1e, Offset: 0x25d2
// Size: 0x245
function ohpequipmentfillednotification( ohpname, equip )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( self.munitionsnotifications ) )
    {
        self.munitionsnotifications = [];
    }
    
    size = self.munitionsnotifications.size;
    
    for ( i = 0; i < size ; i++ )
    {
        if ( i < 2 )
        {
            thread movenotificationup( self.munitionsnotifications[ i ] );
            continue;
        }
        
        notif = self.munitionsnotifications[ i ];
        self.munitionsnotifications[ i ] = undefined;
        notif notify( #"delete_icon_elem" );
    }
    
    finalx = 620;
    finaly = 360;
    x = 352;
    y = 264;
    iconelem = newclienthudelem( self );
    iconelem.x = x;
    iconelem.y = y;
    iconelem.alignx = "right";
    iconelem.aligny = "top";
    iconelem.sort = 2;
    iconelem.alpha = 0;
    equipinfo = equipment_mp::getequipmenttableinfo( equip );
    
    if ( isdefined( equipinfo ) )
    {
        iconelem setshader( equipinfo.image, 25, 25 );
    }
    
    iconelem fadeovertime( 0.15 );
    iconelem moveovertime( 0.35 );
    iconelem.alpha = 1;
    iconelem.x = finalx;
    iconelem.y = finaly;
    arrayinsert( self.munitionsnotifications, iconelem, 0 );
    iconelem endon( #"delete_icon_elem" );
    thread ohpcleanupnotificationondeath( iconelem );
    iconelem.isanimating = 1;
    wait 0.35;
    iconelem.isanimating = 0;
    wait 3;
    iconelem fadeovertime( 0.5 );
    iconelem.alpha = 0;
    wait 0.5;
    iconelem notify( #"delete_icon_elem" );
}

// Namespace perkfunctions
// Params 1
// Checksum 0xff0fc07, Offset: 0x281f
// Size: 0x50
function ohpcleanupnotificationondeath( iconelem )
{
    level endon( #"game_ended" );
    utility::waittill_any_ents( self, "death_or_disconnect", iconelem, "delete_icon_elem" );
    
    if ( isdefined( self ) )
    {
        self.munitionsnotifications = arrayremove( self.munitionsnotifications, iconelem );
    }
    
    iconelem destroy();
}

// Namespace perkfunctions
// Params 1
// Checksum 0x5252495d, Offset: 0x2877
// Size: 0x6c
function movenotificationup( iconelem )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    iconelem endon( #"delete_icon_elem" );
    
    if ( !iconelem.isanimating )
    {
        iconelem moveovertime( 0.35 );
    }
    
    iconelem.y -= 25;
    wait 0.35;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x47f0b357, Offset: 0x28eb
// Size: 0x2
function setoverkillpro()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x7082b25c, Offset: 0x28f5
// Size: 0x2
function unsetoverkillpro()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb23e54bc, Offset: 0x28ff
// Size: 0x2
function setempimmune()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x8289e0d2, Offset: 0x2909
// Size: 0x2
function unsetempimmune()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x23dc5a1f, Offset: 0x2913
// Size: 0x1a
function setautospot()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    autospotadswatcher();
    autospotdeathwatcher();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xed702e89, Offset: 0x2935
// Size: 0x39
function autospotdeathwatcher()
{
    self waittill( #"death" );
    self endon( #"disconnect" );
    self endon( #"hash_ed9020c72eb52403" );
    level endon( #"game_ended" );
    self autospotoverlayoff();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xdadd2c87, Offset: 0x2976
// Size: 0x1e
function unsetautospot()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self notify( #"hash_ed9020c72eb52403" );
    self autospotoverlayoff();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xba42768, Offset: 0x299c
// Size: 0x99
function autospotadswatcher()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_ed9020c72eb52403" );
    level endon( #"game_ended" );
    spotter = 0;
    
    for ( ;; )
    {
        waitframe();
        
        if ( self isusingturret() )
        {
            self autospotoverlayoff();
            continue;
        }
        
        adslevel = self playerads();
        
        if ( adslevel < 1 && spotter )
        {
            spotter = 0;
            self autospotoverlayoff();
        }
        
        if ( adslevel < 1 && !spotter )
        {
            continue;
        }
        
        if ( adslevel == 1 && !spotter )
        {
            spotter = 1;
            self autospotoverlayon();
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xbb6a0d8b, Offset: 0x2a3d
// Size: 0x2
function setregenfaster()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x8c180c80, Offset: 0x2a47
// Size: 0x2
function unsetregenfaster()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa214b9a0, Offset: 0x2a51
// Size: 0x34
function timeoutregenfaster()
{
    self.hasregenfaster = undefined;
    perk::removeperk( "specialty_regenfaster" );
    self setclientdvar( @"ui_regen_faster_end_milliseconds", 0 );
    self notify( #"hash_5423319059d53488" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x162e98bb, Offset: 0x2a8d
// Size: 0x9
function setsharpfocus()
{
    thread monitorsharpfocus();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x6d6dbb59, Offset: 0x2a9e
// Size: 0x3d
function monitorsharpfocus()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"hash_f0b429cd62b2eaec" );
    
    for ( ;; )
    {
        updatesharpfocus();
        self waittill( #"weapon_change" );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x4103f5f5, Offset: 0x2ae3
// Size: 0x6e
function updatesharpfocus()
{
    newweapon = self.currentweapon;
    scale = undefined;
    flinchtype = weapon::weapongetflinchtype( newweapon );
    
    if ( flinchtype == 4 )
    {
        scale = 1;
    }
    else if ( flinchtype == 3 )
    {
        scale = 1;
    }
    else if ( flinchtype == 1 )
    {
        scale = 1;
    }
    else
    {
        scale = 1;
    }
    
    weapons::updateviewkickscale( scale );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x85c3f341, Offset: 0x2b59
// Size: 0x1a
function unsetsharpfocus()
{
    self notify( #"hash_f0b429cd62b2eaec" );
    weapons::updateviewkickscale( 1 );
}

// Namespace perkfunctions
// Params 3
// Checksum 0xb4ad7a01, Offset: 0x2b7b
// Size: 0x1e4
function ammodisabling_run( victim, isthrowstar, additionaltime )
{
    victim notify( #"disablingrun" );
    victim endon( #"disablingrun" );
    victim endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( victim.disabledspeedmod ) )
    {
        victim.disabledspeedmod = -0.05;
        
        if ( !victim common::function_8ff835bf23198a0( "disabledSpeedMod" ) )
        {
            victim common::function_ac4bf3256b2545e3( "disabledSpeedMod", -0.05 );
            victim common::function_11a0a06c67c80f4d( "disabledSpeedMod", 2 );
        }
        
        victim weapons::updatemovespeedscale();
        victim ammodisabling_impair();
    }
    
    if ( isthrowstar )
    {
        timer = 0.4;
    }
    else
    {
        timer = 0.2;
    }
    
    timer = utility::callsharedfunc( #"hash_63fcc6a20d91f33f", #"hash_5a93f6e77e6f2e69", timer ) ?? timer;
    
    if ( isdefined( additionaltime ) )
    {
        timer += additionaltime;
    }
    
    currtime = gettime();
    
    if ( !isdefined( victim.disabledshocktime ) || currtime - victim.disabledshocktime > 200 || isthrowstar )
    {
        if ( isthrowstar )
        {
            duration = 0.4;
        }
        else
        {
            duration = 0.2;
        }
        
        victim shellshock( "chargemode_mp", duration );
        victim.disabledshocktime = currtime;
    }
    
    while ( isalive( victim ) && timer > 0 )
    {
        timer -= level.framedurationseconds;
        waitframe();
    }
    
    victim ammodisabling_impairend();
    victim.disabledspeedmod = undefined;
    victim.disabledshocktime = undefined;
    
    if ( victim common::function_8ff835bf23198a0( "disabledSpeedMod" ) )
    {
        victim common::function_d85a92c557ea5a52( "disabledSpeedMod" );
    }
    
    victim weapons::updatemovespeedscale();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x89012cf6, Offset: 0x2d67
// Size: 0x4a
function ammodisabling_impair()
{
    val::set( "ammoDisabling", "jog", 0 );
    val::set( "ammoDisabling", "sprint", 0 );
    val::set( "ammoDisabling", "slide", 0 );
    val::set( "ammoDisabling", "allow_jump", 0 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x2c7dcad7, Offset: 0x2db9
// Size: 0xe
function ammodisabling_impairend()
{
    val::reset_all( "ammoDisabling" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x6fae5280, Offset: 0x2dcf
// Size: 0x75
function setviewkickoverride()
{
    self.overrideviewkickscale = getdvarfloat( @"hash_31381fbc6af88e90", 0.7 );
    self.overrideviewkickscaledmr = getdvarfloat( @"hash_d92f9fdbd9218170", 0.7 );
    self.overrideviewkickscalesniper = getdvarfloat( @"hash_7c78c2f583a1c0e", 0.7 );
    self.overrideviewkickscalepistol = getdvarfloat( @"hash_904eb284a2b8107e", 0.7 );
    weapons::updateviewkickscale();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x2eeb1b6e, Offset: 0x2e4c
// Size: 0x31
function unsetviewkickoverride()
{
    self.overrideviewkickscale = undefined;
    self.overrideviewkickscaledmr = undefined;
    self.overrideviewkickscalesniper = undefined;
    self.overrideviewkickscalepistol = undefined;
    weapons::updateviewkickscale();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa895d95, Offset: 0x2e85
// Size: 0x17
function setaffinityspeedboost()
{
    self.weaponaffinityspeedboost = 0.08;
    weapons::updatemovespeedscale();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x109f7e40, Offset: 0x2ea4
// Size: 0x13
function unsetaffinityspeedboost()
{
    self.weaponaffinityspeedboost = undefined;
    weapons::updatemovespeedscale();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xfe1a58f4, Offset: 0x2ebf
// Size: 0x14a
function setaffinityextralauncher()
{
    self.weaponaffinityextralauncher = 1;
    primary = weapon::buildweapon( self.loadoutprimary, self.loadoutprimaryattachments, self.loadoutprimarycamo, self.loadoutprimaryreticle, self.loadoutprimaryvariantid );
    secondary = weapon::buildweapon( self.loadoutsecondary, self.loadoutsecondaryattachments, self.loadoutsecondarycamo, self.loadoutsecondaryreticle, self.loadoutsecondaryvariantid );
    
    if ( weapon::getweapongroup( primary.basename ) == "weapon_projectile" )
    {
        self setweaponammoclip( primary, weaponclipsize( primary ) );
    }
    
    if ( weapon::getweapongroup( secondary.basename ) == "weapon_projectile" )
    {
        self setweaponammoclip( secondary, weaponclipsize( secondary ) );
    }
    
    if ( level.tertiaryweaponslotenabled )
    {
        tertiary = weapon::buildweapon( self.loadouttertiary, self.loadoutTertiaryAttachments, self.loadouttertiarycamo, self.loadouttertiaryreticle, self.loadouttertiaryvariantid );
        
        if ( weapon::getweapongroup( tertiary.basename ) == "weapon_projectile" )
        {
            self setweaponammoclip( tertiary, weaponclipsize( tertiary ) );
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x6c12408e, Offset: 0x3011
// Size: 0xc
function unsetaffinityextralauncher()
{
    self.weaponaffinityextralauncher = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x389c18f0, Offset: 0x3025
// Size: 0x151
function setdoubleload()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_e1205d903b23826f" );
    level endon( #"game_ended" );
    
    for ( ;; )
    {
        self waittill( #"reload_ammo_added" );
        weapons = self getweaponslist( "primary" );
        
        foreach ( weapon in weapons )
        {
            ammoinclip = self getweaponammoclip( weapon );
            clipsize = weaponclipsize( weapon );
            difference = clipsize - ammoinclip;
            ammoreserves = self getweaponammostock( weapon );
            
            if ( ammoinclip != clipsize && ammoreserves > 0 )
            {
                if ( ammoinclip + ammoreserves >= clipsize )
                {
                    self setweaponammoclip( weapon, clipsize );
                    self setweaponammostock( weapon, ammoreserves - difference );
                    continue;
                }
                
                self setweaponammoclip( weapon, ammoinclip + ammoreserves );
                
                if ( ammoreserves - difference > 0 )
                {
                    self setweaponammostock( weapon, ammoreserves - difference );
                    continue;
                }
                
                self setweaponammostock( weapon, 0 );
            }
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x54ac853a, Offset: 0x317e
// Size: 0xe
function unsetdoubleload()
{
    self notify( #"hash_e1205d903b23826f" );
}

// Namespace perkfunctions
// Params 1
// Checksum 0xe0b816f5, Offset: 0x3194
// Size: 0xc
function setmarksman( power )
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x72b54637, Offset: 0x31d6
// Size: 0x2
function unsetmarksman()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xc2157a34, Offset: 0x31f3
// Size: 0x29
function setfastcrouch()
{
    thread watchfastcrouch();
    common::function_983eeeeb432f3d8( "fastCrouchSpeedMod", 1, 1.2, 1.2, 1 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x23e0c9f, Offset: 0x3224
// Size: 0x95
function watchfastcrouch()
{
    self endon( #"death_or_disconnect" );
    self endon( #"fastcrouch_unset" );
    
    while ( true )
    {
        iscrouched = ( self getstance() == "crouch" || self getstance() == "prone" ) && !self issprintsliding();
        
        if ( !isdefined( self.fastcrouchspeedmod ) )
        {
            if ( iscrouched )
            {
                self.fastcrouchspeedmod = 0.2;
                weapons::updatemovespeedscale();
            }
        }
        else if ( !iscrouched )
        {
            self.fastcrouchspeedmod = undefined;
            weapons::updatemovespeedscale();
        }
        
        waitframe();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x90d34e2d, Offset: 0x32c1
// Size: 0x46
function unsetfastcrouch()
{
    self notify( #"fastcrouch_unset" );
    
    if ( isdefined( self.fastcrouchspeedmod ) )
    {
        self.fastcrouchspeedmod = undefined;
        weapons::updatemovespeedscale();
    }
    
    if ( common::function_8ff835bf23198a0( "fastCrouchSpeedMod" ) )
    {
        common::function_d85a92c557ea5a52( "fastCrouchSpeedMod" );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xf6294364, Offset: 0x330f
// Size: 0x21
function setrshieldradar()
{
    self endon( #"hash_6db20d2e1a0b1e47" );
    wait 0.75;
    self makeportableradar();
    thread setrshieldradar_cleanup();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x9dd3d45b, Offset: 0x3338
// Size: 0x27
function setrshieldradar_cleanup()
{
    self endon( #"hash_6db20d2e1a0b1e47" );
    self waittill( #"death_or_disconnect" );
    
    if ( isdefined( self ) )
    {
        unsetrshieldradar();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x8bc494dc, Offset: 0x3367
// Size: 0x14
function unsetrshieldradar()
{
    self clearportableradar();
    self notify( #"hash_6db20d2e1a0b1e47" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x527ccf84, Offset: 0x3383
// Size: 0xf
function setrshieldscrambler()
{
    self makescrambler();
    thread setrshieldscrambler_cleanup();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xaed3a861, Offset: 0x339a
// Size: 0x27
function setrshieldscrambler_cleanup()
{
    self endon( #"hash_a008e56f319aca0" );
    self waittill( #"death_or_disconnect" );
    
    if ( isdefined( self ) )
    {
        unsetrshieldscrambler();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa490f0c0, Offset: 0x33c9
// Size: 0x14
function unsetrshieldscrambler()
{
    self clearscrambler();
    self notify( #"hash_a008e56f319aca0" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xf590a822, Offset: 0x33e5
// Size: 0x24
function setweaponlaser()
{
    if ( isagent( self ) )
    {
        return;
    }
    
    self endon( #"hash_db39fb072a9455c9" );
    wait 0.5;
    thread setweaponlaser_internal();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x4c36597f, Offset: 0x3411
// Size: 0x43
function unsetweaponlaser()
{
    self notify( #"hash_db39fb072a9455c9" );
    
    if ( isdefined( self.perkweaponlaseron ) && self.perkweaponlaseron )
    {
        weapon::disableweaponlaser();
    }
    
    self.perkweaponlaseron = undefined;
    self.perkweaponlaseroffforswitchstart = undefined;
}

// Namespace perkfunctions
// Params 1
// Checksum 0xb0552ce2, Offset: 0x345c
// Size: 0x63
function setweaponlaser_waitforlaserweapon( weapon )
{
    for ( weapon = getweaponbasename( weapon ); true ; weapon = objweapon.basename )
    {
        if ( isdefined( weapon ) && ( weapon == "iw6_kac_mp" || weapon == "iw6_arx160_mp" ) )
        {
            break;
        }
        
        self waittill( #"weapon_change", objweapon );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x648d4bf8, Offset: 0x34c7
// Size: 0xb0
function setweaponlaser_internal()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_db39fb072a9455c9" );
    self.perkweaponlaseron = 0;
    weapon = self getcurrentweapon();
    
    while ( true )
    {
        setweaponlaser_waitforlaserweapon( weapon );
        
        if ( self.perkweaponlaseron == 0 )
        {
            self.perkweaponlaseron = 1;
            weapon::enableweaponlaser();
        }
        
        childthread setweaponlaser_monitorads();
        childthread setweaponlaser_monitorweaponswitchstart( 1 );
        self.perkweaponlaseroffforswitchstart = undefined;
        self waittill( #"weapon_change" );
        
        if ( self.perkweaponlaseron == 1 )
        {
            self.perkweaponlaseron = 0;
            weapon::disableweaponlaser();
        }
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0x1f018073, Offset: 0x357f
// Size: 0x36
function setweaponlaser_monitorweaponswitchstart( offtime )
{
    self endon( #"weapon_change" );
    
    while ( true )
    {
        self waittill( #"weapon_switch_started" );
        childthread setweaponlaser_onweaponswitchstart( offtime );
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0xca32aaf2, Offset: 0x35bd
// Size: 0x8b
function setweaponlaser_onweaponswitchstart( offtime )
{
    self notify( #"hash_6a358b9bad67f2be" );
    self endon( #"hash_6a358b9bad67f2be" );
    
    if ( self.perkweaponlaseron == 1 )
    {
        self.perkweaponlaseroffforswitchstart = 1;
        self.perkweaponlaseron = 0;
        weapon::disableweaponlaser();
    }
    
    wait offtime;
    self.perkweaponlaseroffforswitchstart = undefined;
    
    if ( self.perkweaponlaseron == 0 && self playerads() <= 0.6 )
    {
        self.perkweaponlaseron = 1;
        weapon::enableweaponlaser();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xfdabc42e, Offset: 0x3650
// Size: 0x85
function setweaponlaser_monitorads()
{
    self endon( #"weapon_change" );
    
    while ( true )
    {
        if ( !isdefined( self.perkweaponlaseroffforswitchstart ) || self.perkweaponlaseroffforswitchstart == 0 )
        {
            if ( self playerads() > 0.6 )
            {
                if ( self.perkweaponlaseron == 1 )
                {
                    self.perkweaponlaseron = 0;
                    weapon::disableweaponlaser();
                }
            }
            else if ( self.perkweaponlaseron == 0 )
            {
                self.perkweaponlaseron = 1;
                weapon::enableweaponlaser();
            }
        }
        
        waitframe();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xd33a2bd7, Offset: 0x36dd
// Size: 0xd
function setsteadyaimpro()
{
    self setaimspreadmovementscale( 0.5 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x3e45750b, Offset: 0x36f2
// Size: 0x19
function unsetsteadyaimpro()
{
    self notify( #"end_steadyaimpro" );
    self setaimspreadmovementscale( 1 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x24bbf79b, Offset: 0x3713
// Size: 0x25
function perkusedeathtracker()
{
    self endon( #"disconnect" );
    self waittill( #"death" );
    self._useperkenabled = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x19d9611d, Offset: 0x3740
// Size: 0x78
function setendgame()
{
    if ( isdefined( self.endgame ) )
    {
        return;
    }
    
    self.maxhealth = getmatchrulesdata( "commonOption", "maxHealth" ) * 4;
    self.health = self.maxhealth;
    self.endgame = 1;
    self.attackertable[ 0 ] = "";
    self visionsetnakedforplayer( "end_game", 5 );
    thread endgamedeath( 7 );
    gamelogic_mp::sethasdonecombat( self, 1 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xc242d886, Offset: 0x37c0
// Size: 0x50
function unsetendgame()
{
    self notify( #"stopendgame" );
    self.endgame = undefined;
    player::restorebasevisionset( 1 );
    
    if ( !isdefined( self.endgametimer ) )
    {
        return;
    }
    
    self.endgametimer hud_util::destroyelem();
    self.endgameicon hud_util::destroyelem();
}

// Namespace perkfunctions
// Params 1
// Checksum 0x99bfa21, Offset: 0x3818
// Size: 0x49
function endgamedeath( duration )
{
    self endon( #"death_or_disconnect" );
    self endon( #"joined_team" );
    level endon( #"game_ended" );
    self endon( #"stopendgame" );
    wait duration + 1;
    damage::_suicide();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x78842833, Offset: 0x3869
// Size: 0x10
function setsaboteur()
{
    self.objectivescaler = 1.2;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x4556364b, Offset: 0x3881
// Size: 0xd
function unsetsaboteur()
{
    self.objectivescaler = 1;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x1669a4c, Offset: 0x3896
// Size: 0xb4
function setcombatspeed()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_26a1b2931549d3b9" );
    self.incombatspeed = 0;
    unsetcombatspeedscalar();
    
    for ( ;; )
    {
        self waittill( #"damage", dmg, attacker );
        
        if ( !isdefined( attacker.team ) )
        {
            continue;
        }
        
        if ( level.teambased && attacker.team == self.team )
        {
            continue;
        }
        
        if ( self.incombatspeed )
        {
            continue;
        }
        
        setcombatspeedscalar();
        self.incombatspeed = 1;
        thread endofspeedwatcher();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x86413eb6, Offset: 0x3952
// Size: 0x44
function endofspeedwatcher()
{
    self notify( #"hash_7fa6353aa24827d6" );
    self endon( #"hash_7fa6353aa24827d6" );
    self endon( #"death_or_disconnect" );
    self waittill( #"healed" );
    unsetcombatspeedscalar();
    self.incombatspeed = 0;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x7967d4a6, Offset: 0x399e
// Size: 0xa5
function setcombatspeedscalar()
{
    if ( self.weaponspeed <= 0.8 )
    {
        self.combatspeedscalar = 1.4;
    }
    else if ( self.weaponspeed <= 0.9 )
    {
        self.combatspeedscalar = 1.3;
    }
    else
    {
        self.combatspeedscalar = 1.2;
    }
    
    if ( !common::function_8ff835bf23198a0( "combatSpeedScalar" ) )
    {
        common::function_ac4bf3256b2545e3( "combatSpeedScalar", self.combatspeedscalar - 1 );
    }
    else
    {
        common::function_a0f5c85d465c5f0a( "combatSpeedScalar", self.combatspeedscalar - 1 );
    }
    
    weapons::updatemovespeedscale();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x2cf7e7c5, Offset: 0x3a4b
// Size: 0x2e
function unsetcombatspeedscalar()
{
    self.combatspeedscalar = 1;
    
    if ( common::function_8ff835bf23198a0( "combatSpeedScalar" ) )
    {
        common::function_d85a92c557ea5a52( "combatSpeedScalar" );
    }
    
    weapons::updatemovespeedscale();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x241a4d1, Offset: 0x3a81
// Size: 0x15
function unsetcombatspeed()
{
    unsetcombatspeedscalar();
    self notify( #"hash_26a1b2931549d3b9" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xdaa35515, Offset: 0x3a9e
// Size: 0x2
function setblackbox()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xd8e8d2fa, Offset: 0x3aa8
// Size: 0x2
function unsetblackbox()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x8c625377, Offset: 0x3ab2
// Size: 0x1a
function setsteelnerves()
{
    perk::giveperk( "specialty_bulletaccuracy" );
    perk::giveperk( "specialty_holdbreath" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xbb10527c, Offset: 0x3ad4
// Size: 0x1a
function unsetsteelnerves()
{
    perk::removeperk( "specialty_bulletaccuracy" );
    perk::removeperk( "specialty_holdbreath" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x67b2fb3b, Offset: 0x3af6
// Size: 0x31
function setdelaymine()
{
    if ( isbrgamemode() )
    {
        self.var_c5bc305e9193319f = 1;
        self.var_358a13b001e2d054 = 1;
        self.minedelayseconds = level.delayminetime;
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x661dd126, Offset: 0x3b2f
// Size: 0x27
function unsetdelaymine()
{
    if ( isbrgamemode() )
    {
        self.var_c5bc305e9193319f = undefined;
        self.var_358a13b001e2d054 = undefined;
        self.minedelayseconds = undefined;
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x67fdad4c, Offset: 0x3b5e
// Size: 0x11
function setlocaljammer()
{
    if ( emp_debuff::is_empd() )
    {
        self makescrambler();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x8c608ae1, Offset: 0x3b77
// Size: 0x8
function unsetlocaljammer()
{
    self clearscrambler();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x45cebaa6, Offset: 0x3b87
// Size: 0x8
function setthermal()
{
    self thermalvisionon();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb925a75d, Offset: 0x3b97
// Size: 0x8
function unsetthermal()
{
    self thermalvisionoff();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x6ccfc422, Offset: 0x3ba7
// Size: 0x9
function setonemanarmy()
{
    thread onemanarmyweaponchangetracker();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x6915d1f2, Offset: 0x3bb8
// Size: 0xe
function unsetonemanarmy()
{
    self notify( #"hash_ee46ffa74e26a8a9" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x74ef24d2, Offset: 0x3bce
// Size: 0x60
function onemanarmyweaponchangetracker()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"hash_ee46ffa74e26a8a9" );
    
    for ( ;; )
    {
        self waittill( #"weapon_change", objweapon );
        
        if ( objweapon.basename != "onemanarmy_mp" )
        {
            continue;
        }
        
        thread selectonemanarmyclass();
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0x4fb0a464, Offset: 0x3c36
// Size: 0x3d, Type: bool
function isonemanarmymenu( menu )
{
    if ( menu == game[ "menu_onemanarmy" ] )
    {
        return true;
    }
    
    if ( menu == game[ "menu_onemanarmy_defaults_splitscreen" ] )
    {
        return true;
    }
    
    if ( menu == game[ "menu_onemanarmy_custom_splitscreen" ] )
    {
        return true;
    }
    
    return false;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x92cec415, Offset: 0x3c7c
// Size: 0x131
function selectonemanarmyclass()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    val::set( "one_man_army", "weapon_switch", 0 );
    val::set( "one_man_army", "offhand_weapons", 0 );
    val::set( "one_man_army", "usability", 0 );
    thread closeomamenuondeath();
    self waittill( #"menuresponse", menu, classname );
    val::reset_all( "one_man_army" );
    
    if ( classname == "back" || !isonemanarmymenu( menu ) || utility::isusingremote() )
    {
        currentweapon = self getcurrentweapon();
        
        if ( currentweapon.basename == "onemanarmy_mp" )
        {
            val::set( "one_man_army", "weapon_switch", 0 );
            val::set( "one_man_army", "offhand_weapons", 0 );
            val::set( "one_man_army", "usability", 0 );
            inventory_utility::_switchtoweapon( inventory::getlastweapon() );
            self waittill( #"weapon_change" );
            val::reset_all( "one_man_army" );
        }
        
        return;
    }
    
    thread giveonemanarmyclass( classname );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x39ba5bb5, Offset: 0x3db5
// Size: 0x3f
function closeomamenuondeath()
{
    self endon( #"menuresponse" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self waittill( #"death" );
    val::reset_all( "one_man_army" );
}

// Namespace perkfunctions
// Params 1
// Checksum 0x9e15d2d8, Offset: 0x3dfc
// Size: 0x11e
function giveonemanarmyclass( classname )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( isdefined( self.perks[ "specialty_omaquickchange" ] ) )
    {
        changeduration = 3;
        player_utility::function_2a104cfb275afa1b( self, "foly_onemanarmy_bag3_plr", "foly_onemanarmy_bag3_npc" );
    }
    else
    {
        changeduration = 6;
        player_utility::function_2a104cfb275afa1b( self, "foly_onemanarmy_bag6_plr", "foly_onemanarmy_bag6_npc" );
    }
    
    thread omausebar( changeduration );
    val::set( "one_man_army", "weapon_switch", 0 );
    val::set( "one_man_army", "offhand_weapons", 0 );
    val::set( "one_man_army", "usability", 0 );
    wait changeduration;
    val::reset_all( "one_man_army" );
    class::giveloadout( self.pers[ "team" ], classname );
    
    if ( isdefined( self.carryflag ) )
    {
        self attach( self.carryflag, "J_spine4", 1 );
    }
    
    self notify( #"changed_kit" );
    level notify( #"changed_kit" );
    rank::tryresetrankxp();
}

// Namespace perkfunctions
// Params 1
// Checksum 0x545a2bb7, Offset: 0x3f22
// Size: 0xa7
function omausebar( duration )
{
    self endon( #"disconnect" );
    usebar = hud_util::createprimaryprogressbar();
    var_b593d9f41a046171 = hud_util::createprimaryprogressbartext();
    var_b593d9f41a046171 settext( &"mpui_changing_kit" );
    usebar hud_util::updatebar( 0, 1 / duration );
    waitedtime = 0;
    
    while ( waitedtime < duration && isalive( self ) && !level.gameended )
    {
        wait 0.05;
        waitedtime += 0.05;
    }
    
    usebar hud_util::destroyelem();
    var_b593d9f41a046171 hud_util::destroyelem();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x5d7cf2, Offset: 0x3fd1
// Size: 0x34
function setafterburner()
{
    self energy_setrestorerate( 0, game_utility_mp::isanymlgmatch() ? 600 : 1000 );
    self energy_setresttimems( 0, game_utility_mp::isanymlgmatch() ? 750 : 750 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x372f7e5d, Offset: 0x400d
// Size: 0x16
function unsetafterburner()
{
    self energy_setrestorerate( 0, 400 );
    self energy_setresttimems( 0, 900 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x844fac10, Offset: 0x402b
// Size: 0x2
function setfreefall()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x86042bff, Offset: 0x4035
// Size: 0x2
function unsetfreefall()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xef4b1246, Offset: 0x403f
// Size: 0x13
function settacticalinsertion()
{
    equipment_mp::giveequipment( "equip_tac_insert", "secondary" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xc2ec8823, Offset: 0x405a
// Size: 0x2
function unsettacticalinsertion()
{
    
}

// Namespace perkfunctions
// Params 2
// Checksum 0xd8252598, Offset: 0x4064
// Size: 0x97
function setpainted( attacker, duration )
{
    if ( isplayer( self ) )
    {
        outlinetime = duration ?? 0.5;
        
        if ( !isdefined( self.perks[ "specialty_engineer" ] ) && !isdefined( self.perks[ "specialty_noscopeoutline" ] ) )
        {
            self.painted = 1;
            id = outline::outlineenableforplayer( self, attacker, "outline_nodepth_orange", "perk" );
            thread watchpainted( id, outlinetime );
            thread watchpaintedagain( id );
        }
    }
}

// Namespace perkfunctions
// Params 2
// Checksum 0x3d638b1d, Offset: 0x4103
// Size: 0x73
function watchpainted( id, timeout )
{
    self notify( #"painted_again" );
    self endon( #"painted_again" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    utility::waittill_any_timeout( timeout, "death" );
    self.painted = 0;
    outline::outlinedisable( id, self );
    self notify( #"painted_end" );
}

// Namespace perkfunctions
// Params 1
// Checksum 0xb62d7000, Offset: 0x417e
// Size: 0x3f
function watchpaintedagain( id )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    utility::waittill_any( "painted_again", "painted_end" );
    outline::outlinedisable( id, self );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xcf6ef755, Offset: 0x41c5
// Size: 0x19, Type: bool
function ispainted()
{
    return isdefined( self.painted ) && self.painted;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xd6177c6a, Offset: 0x41e7
// Size: 0x2
function setassists()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xf00399a9, Offset: 0x41f1
// Size: 0x2
function unsetassists()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x171f13f0, Offset: 0x41fb
// Size: 0x3a
function setrefillgrenades()
{
    if ( isdefined( self.primarygrenade ) )
    {
        self givemaxammo( self.primarygrenade );
    }
    
    if ( isdefined( self.secondarygrenade ) )
    {
        self givemaxammo( self.secondarygrenade );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xbc5add77, Offset: 0x423d
// Size: 0x2
function unsetrefillgrenades()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x4d811d1f, Offset: 0x4247
// Size: 0x3a
function setrefillammo()
{
    if ( isdefined( self.primaryweapon ) )
    {
        self givemaxammo( self.primaryweapon );
    }
    
    if ( isdefined( self.secondaryweapon ) )
    {
        self givemaxammo( self.secondaryweapon );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe7bbe6f4, Offset: 0x4289
// Size: 0x2
function unsetrefillammo()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x6028d37f, Offset: 0x4293
// Size: 0x2
function setcomexp()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xadfdbc4f, Offset: 0x429d
// Size: 0x2
function unsetcomexp()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x1870787c, Offset: 0x42a7
// Size: 0x9
function settagger()
{
    thread settaggerinternal();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xd36d39da, Offset: 0x42b8
// Size: 0x13b
function settaggerinternal()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_c2110f5fbb29eeb4" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"eyeson" );
        sightingplayers = self getplayerssightingme();
        
        foreach ( otherplayer in sightingplayers )
        {
            if ( level.teambased && otherplayer.team == self.team )
            {
                continue;
            }
            
            if ( isalive( otherplayer ) && otherplayer.sessionstate == "playing" )
            {
                if ( !isdefined( otherplayer.perkoutlined ) )
                {
                    otherplayer.perkoutlined = 0;
                }
                
                if ( !otherplayer.perkoutlined )
                {
                    otherplayer.perkoutlined = 1;
                }
                
                otherplayer thread outlinewatcher( self );
            }
        }
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0x6b61abc8, Offset: 0x43fb
// Size: 0xe6
function outlinewatcher( victim )
{
    self endon( #"death_or_disconnect" );
    self endon( #"eyesoff" );
    level endon( #"game_ended" );
    
    for ( ;; )
    {
        notwatching = 1;
        sightingplayers = victim getplayerssightingme();
        
        foreach ( otherplayer in sightingplayers )
        {
            if ( otherplayer == self )
            {
                notwatching = 0;
                break;
            }
        }
        
        if ( notwatching )
        {
            self.perkoutlined = 0;
            self notify( #"eyesoff" );
        }
        
        wait 0.5;
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xf221a187, Offset: 0x44e9
// Size: 0xe
function unsettagger()
{
    self notify( #"hash_c2110f5fbb29eeb4" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xd7bcf491, Offset: 0x44ff
// Size: 0x9
function setpitcher()
{
    thread setpitcherinternal();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe68177be, Offset: 0x4510
// Size: 0xa7
function setpitcherinternal()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_3d5a7b01ecc0dcdf" );
    level endon( #"game_ended" );
    
    for ( ;; )
    {
        self setgrenadethrowscale( function_9be554c4f2e99425() );
        self waittill( #"grenade_pullback", objweapon );
        grenadename = objweapon.basename;
        
        if ( grenadename == "airdrop_marker_mp" || grenadename == "deployable_vest_marker_mp" || grenadename == "deployable_weapon_crate_marker_mp" )
        {
            self setgrenadethrowscale( 1 );
        }
        
        self waittill( #"grenade_fire", grenade, objweapon );
    }
}

// Namespace perkfunctions
// Params 0, eflags: 0x4
// Checksum 0xb516702d, Offset: 0x45bf
// Size: 0x55
function private function_9be554c4f2e99425()
{
    throwscale = 1.25;
    
    if ( isdefined( self.var_432aeb35bfd9cf59.bundle.var_95cfcbf1b34f881c ) )
    {
        throwscale = self.var_432aeb35bfd9cf59.bundle.var_95cfcbf1b34f881c;
    }
    
    return throwscale;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x83ee6bbb, Offset: 0x461d
// Size: 0x1e
function unsetpitcher()
{
    self setgrenadecookscale( 1 );
    self setgrenadethrowscale( 1 );
    self notify( #"hash_3d5a7b01ecc0dcdf" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe204a347, Offset: 0x4643
// Size: 0x2
function setboom()
{
    
}

// Namespace perkfunctions
// Params 1
// Checksum 0xa446f4b7, Offset: 0x464d
// Size: 0x67
function setboominternal( attacker )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_313dbbd6e8b79f69" );
    level endon( #"game_ended" );
    attacker endon( #"death_or_disconnect" );
    waitframe();
    triggerportableradarping( self.origin, attacker, 800, 1500 );
    attacker boomtrackplayers( self.origin, self );
}

// Namespace perkfunctions
// Params 2
// Checksum 0x341de97d, Offset: 0x46bc
// Size: 0xc9
function boomtrackplayers( targetpos, victim )
{
    boomplayers = utility::playersinsphere( targetpos, 700 );
    
    foreach ( player in boomplayers )
    {
        if ( victim == player )
        {
            continue;
        }
        
        if ( player_utility::isenemy( player ) && isalive( player ) && !isdefined( player.perks[ "specialty_gpsjammer" ] ) )
        {
        }
    }
}

// Namespace perkfunctions
// Params 2
// Checksum 0x67f17295, Offset: 0x478d
// Size: 0x8c
function boomtrackplayerdeath( attacker, id )
{
    self endon( #"disconnect" );
    attacker endon( #"hash_1f2c4f17a1a95db4" );
    msg = utility::waittill_any_timeout( 7, "death" );
    
    if ( msg == "timeout" && isdefined( self.markedbyboomperk[ id ] ) )
    {
        self.markedbyboomperk[ id ] = undefined;
        return;
    }
    
    self waittill( #"spawned_player" );
    self.markedbyboomperk = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe83c309, Offset: 0x4821
// Size: 0xe
function unsetboom()
{
    self notify( #"hash_313dbbd6e8b79f69" );
}

// Namespace perkfunctions
// Params 1
// Checksum 0xee21b8fc, Offset: 0x4837
// Size: 0xea
function customjuiced( waittime )
{
    self endon( #"death_or_disconnect" );
    self endon( #"faux_spawn" );
    self endon( #"hash_387f408ddc37e54d" );
    level endon( #"game_ended" );
    self.isjuiced = 1;
    self.movespeedscaler = 1.1;
    
    if ( !common::function_8ff835bf23198a0( "moveSpeedScaler" ) )
    {
        common::function_983eeeeb432f3d8( "moveSpeedScaler", self.movespeedscaler - 1 );
    }
    
    weapons::updatemovespeedscale();
    perk::giveperk( "specialty_fastreload" );
    perk::giveperk( "specialty_quickdraw" );
    perk::giveperk( "specialty_stalker" );
    perk::giveperk( "specialty_fastoffhand" );
    perk::giveperk( "specialty_fastsprintrecovery" );
    perk::giveperk( "specialty_quickswap" );
    thread unsetcustomjuicedondeath();
    thread unsetcustomjuicedonride();
    thread unsetcustomjuicedonmatchend();
    wait waittime;
    unsetcustomjuiced();
}

// Namespace perkfunctions
// Params 1
// Checksum 0xae79a888, Offset: 0x4929
// Size: 0xe9
function unsetcustomjuiced( death )
{
    if ( !isdefined( death ) )
    {
        self.movespeedscaler = 1;
        
        if ( common::function_8ff835bf23198a0( "moveSpeedScaler" ) )
        {
            common::function_d85a92c557ea5a52( "moveSpeedScaler" );
        }
        
        if ( isdefined( self.perks[ "specialty_lightweight" ] ) )
        {
            self.movespeedscaler = perk::lightweightscalar();
            common::function_a0f5c85d465c5f0a( "moveSpeedScaler", self.movespeedscaler - 1 );
        }
        
        assert( isdefined( self.movespeedscaler ) );
        weapons::updatemovespeedscale();
    }
    
    perk::removeperk( "specialty_fastreload" );
    perk::removeperk( "specialty_quickdraw" );
    perk::removeperk( "specialty_stalker" );
    perk::removeperk( "specialty_fastoffhand" );
    perk::removeperk( "specialty_fastsprintrecovery" );
    perk::removeperk( "specialty_quickswap" );
    self.isjuiced = undefined;
    self notify( #"hash_387f408ddc37e54d" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa0f77d9c, Offset: 0x4a1a
// Size: 0x36
function unsetcustomjuicedonride()
{
    self endon( #"disconnect" );
    self endon( #"hash_387f408ddc37e54d" );
    
    while ( true )
    {
        waitframe();
        
        if ( utility::isusingremote() )
        {
            thread unsetcustomjuiced();
            break;
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x8398ac89, Offset: 0x4a58
// Size: 0x34
function unsetcustomjuicedondeath()
{
    self endon( #"disconnect" );
    self endon( #"hash_387f408ddc37e54d" );
    utility::waittill_any( "death", "faux_spawn" );
    thread unsetcustomjuiced( 1 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe7906c6e, Offset: 0x4a94
// Size: 0x33
function unsetcustomjuicedonmatchend()
{
    self endon( #"disconnect" );
    self endon( #"hash_387f408ddc37e54d" );
    level utility::waittill_any( "round_end_finished", "game_ended" );
    thread unsetcustomjuiced();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x97352847, Offset: 0x4acf
// Size: 0x2
function settriggerhappy()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x434d8477, Offset: 0x4ad9
// Size: 0xdb
function settriggerhappyinternal()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_db906a264fa67bac" );
    level endon( #"game_ended" );
    objweapon = self.lastdroppableweaponobj;
    var_74b5405c276f4686 = self getweaponammostock( objweapon );
    var_5e3353a9c76cf2de = self getweaponammoclip( objweapon );
    self givestartammo( objweapon );
    var_359d1da29e4d6ac6 = self getweaponammoclip( objweapon );
    clipdifference = var_359d1da29e4d6ac6 - var_5e3353a9c76cf2de;
    var_f9ca647e0944b7fb = var_74b5405c276f4686 - clipdifference;
    
    if ( clipdifference > var_74b5405c276f4686 )
    {
        self setweaponammoclip( objweapon, var_5e3353a9c76cf2de + var_74b5405c276f4686 );
        var_f9ca647e0944b7fb = 0;
    }
    
    self setweaponammostock( objweapon, var_f9ca647e0944b7fb );
    self playlocalsound( "ammo_crate_use" );
    self setclientomnvar( "ui_trigger_happy", 1 );
    wait 0.2;
    self setclientomnvar( "ui_trigger_happy", 0 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x18208c49, Offset: 0x4bbc
// Size: 0x1a
function unsettriggerhappy()
{
    self setclientomnvar( "ui_trigger_happy", 0 );
    self notify( #"hash_db906a264fa67bac" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xae8b3122, Offset: 0x4bde
// Size: 0x2
function setincog()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xace292d7, Offset: 0x4be8
// Size: 0x2
function unsetincog()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xd49f8af4, Offset: 0x4bf2
// Size: 0x2
function setblindeye()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xd6d40d1b, Offset: 0x4bfc
// Size: 0x2
function unsetblindeye()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x58b1309e, Offset: 0x4c06
// Size: 0x2
function setquickswap()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x680684f0, Offset: 0x4c10
// Size: 0x2
function unsetquickswap()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xccc34287, Offset: 0x4c1a
// Size: 0x21
function function_b171574387e7502e()
{
    var_7634e6877c7e7f5f = self function_ca1904a5dd87fd53();
    
    if ( var_7634e6877c7e7f5f )
    {
        weapons::function_937faff615744271( var_7634e6877c7e7f5f );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x391bcf44, Offset: 0x4c43
// Size: 0x2
function function_27bc83ee3dea9e27()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x72216800, Offset: 0x4c4d
// Size: 0x2
function setbattleslide()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x4553690b, Offset: 0x4c57
// Size: 0x2
function unsetbattleslide()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x41f651df, Offset: 0x4c61
// Size: 0x2
function setoverkill()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x43bdd630, Offset: 0x4c6b
// Size: 0x2
function unsetoverkill()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x2d47d405, Offset: 0x4c75
// Size: 0x2
function setactivereload()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xbaa27f8c, Offset: 0x4c7f
// Size: 0x2
function unsetactivereload()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x17f864b6, Offset: 0x4c89
// Size: 0x2a
function setlifepack()
{
    if ( !isdefined( level._effect[ "life_pack_pickup" ] ) )
    {
        level._effect[ "life_pack_pickup" ] = undefined;
    }
    
    thread watchlifepackkills();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x5e46e70d, Offset: 0x4cbb
// Size: 0x1c7
function watchlifepackkills()
{
    self endon( #"death_or_disconnect" );
    self notify( #"unset_lifepack" );
    self endon( #"unset_lifepack" );
    
    while ( true )
    {
        self waittill( #"got_a_kill", victim, weapon, meansofdeath );
        spawnloc = self.origin;
        triggerradius = 20;
        triggerheight = 20;
        lifepack = spawn( "script_model", self.origin + ( 0, 0, 10 ) );
        lifepack setmodel( "weapon_life_pack" );
        lifepack.owner = self;
        lifepack.team = self.team;
        lifepack hidefromplayer( self );
        lifepacktrigger = spawn( "trigger_radius", self.origin, 0, triggerradius, triggerheight );
        lifepacktrigger thread watchlifepackuse( lifepack );
        lifepacktrigger thread watchlifepackdeath( lifepack );
        lifepack thread hoverlifepack();
        lifepack rotateyaw( 1000, 30, 0.2, 0.2 );
        lifepack thread watchlifepacklifetime( 10, lifepacktrigger );
        lifepack thread watchlifepackowner();
        
        foreach ( player in level.players )
        {
            lifepack setlifepackvisualforplayer( player );
        }
    }
}

// Namespace perkfunctions
// Params 3
// Checksum 0x3f5a813a, Offset: 0x4e8a
// Size: 0x84
function activatelifepackboost( owner, duration, disableondeath )
{
    self.lifeboostactive = 1;
    
    if ( duration > 0 )
    {
        thread watchlifepackboostlifetime( duration );
    }
    
    if ( disableondeath )
    {
        thread watchlifepackuserdeath();
    }
    
    perk::giveperk( "specialty_regenfaster" );
    self setclientomnvar( "ui_life_link", 1 );
    self notify( #"enabled_life_pack_boost" );
    self.lifepackowner = owner;
    gamescore::trackbuffassist( owner, self, "medic_lifepack" );
}

// Namespace perkfunctions
// Params 1
// Checksum 0x34a0df11, Offset: 0x4f16
// Size: 0x2f
function watchlifepackboostlifetime( duration )
{
    self endon( #"death_or_disconnect" );
    wait duration;
    
    if ( isdefined( self.lifeboostactive ) )
    {
        disablelifepackboost();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xef005596, Offset: 0x4f4d
// Size: 0x62
function disablelifepackboost()
{
    if ( isdefined( self ) && isdefined( self.lifeboostactive ) )
    {
        self.lifeboostactive = undefined;
        self setclientomnvar( "ui_life_link", 0 );
        self notify( #"disabled_life_pack_boost" );
        perk::removeperk( "specialty_regenfaster" );
        gamescore::untrackbuffassist( self.lifepackowner, self, "medic_lifepack" );
        self.lifepackowner = undefined;
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0xf0617d46, Offset: 0x4fb7
// Size: 0x66
function setlifepackvisualforplayer( player )
{
    if ( level.teambased && player.team == self.team && player != self.owner )
    {
        setlifepackoutlinestate( player );
        self showtoplayer( player );
        thread watchlifepackoutlinestate( player );
        return;
    }
    
    self hidefromplayer( player );
}

// Namespace perkfunctions
// Params 1
// Checksum 0xaa0c56ea, Offset: 0x5025
// Size: 0x189
function setlifepackoutlinestate( player )
{
    if ( isdefined( player.lifeboostactive ) )
    {
        if ( isdefined( player.lifepackoutlines ) && player.lifepackoutlines.size > 0 )
        {
            foreach ( outline in player.lifepackoutlines )
            {
                if ( self == outline.pack )
                {
                    outline::outlinedisable( outline.id, outline.pack );
                    player.lifepackoutlines = arrayremove( player.lifepackoutlines, outline );
                    outline = undefined;
                }
            }
        }
        
        return;
    }
    
    if ( !isdefined( player.lifepackoutlines ) )
    {
        player.lifepackoutlines = [];
    }
    
    lifepackoutline = spawnstruct();
    lifepackoutline.id = outline::outlineenableforplayer( self, player, "outline_depth_cyan", "equipment" );
    lifepackoutline.pack = self;
    
    if ( !isdefined( player.lifepackoutlines ) )
    {
        player.lifepackoutlines = [];
    }
    
    player.lifepackoutlines[ player.lifepackoutlines.size ] = lifepackoutline;
}

// Namespace perkfunctions
// Params 1
// Checksum 0xc9ce6c16, Offset: 0x51b6
// Size: 0x3c
function watchlifepackoutlinestate( player )
{
    self endon( #"death" );
    
    while ( true )
    {
        player utility::waittill_any( "enabled_life_pack_boost", "disabled_life_pack_boost" );
        setlifepackoutlinestate( player );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x917e6c03, Offset: 0x51fa
// Size: 0x73
function hoverlifepack()
{
    self endon( #"death" );
    self endon( #"hash_c572d1fbe7da584a" );
    originalposition = self.origin;
    
    while ( true )
    {
        self moveto( originalposition + ( 0, 0, 15 ), 1, 0.2, 0.2 );
        wait 1;
        self moveto( originalposition, 1, 0.2, 0.2 );
        wait 1;
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0x6f2d85d8, Offset: 0x5275
// Size: 0x17b
function watchlifepackuse( lifepack )
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( player.team != lifepack.team )
        {
            continue;
        }
        
        if ( isdefined( player.lifeboostactive ) )
        {
            continue;
        }
        
        if ( player == lifepack.owner )
        {
            continue;
        }
        
        player activatelifepackboost( lifepack.owner, 5, 1 );
        player playlocalsound( "scavenger_pack_pickup" );
        pickupfxent = spawnfx( utility::getfx( "life_pack_pickup" ), self.origin );
        triggerfx( pickupfxent );
        pickupfxent thread script::delayentdelete( 2 );
        
        foreach ( otherplayer in level.players )
        {
            if ( otherplayer.team == player.team )
            {
                continue;
            }
            
            pickupfxent hidefromplayer( otherplayer );
        }
        
        lifepack delete();
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0x57cb4cb1, Offset: 0x53f8
// Size: 0x31
function watchlifepackdeath( lifepack )
{
    self endon( #"death" );
    lifepack waittill( #"death" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace perkfunctions
// Params 2
// Checksum 0x93b6f8af, Offset: 0x5431
// Size: 0x31
function watchlifepacklifetime( lifetime, lifepacktrigger )
{
    self endon( #"death" );
    wait lifetime;
    lifepacktrigger delete();
    self delete();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x74318ad7, Offset: 0x546a
// Size: 0x2e
function watchlifepackowner()
{
    self endon( #"death" );
    self.owner waittill( #"disconnect" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x118fafd6, Offset: 0x54a0
// Size: 0x22
function watchlifepackuserdeath()
{
    self endon( #"disconnect" );
    self waittill( #"death" );
    disablelifepackboost();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x19ce0927, Offset: 0x54ca
// Size: 0x15
function unsetlifepack()
{
    disablelifepackboost();
    self notify( #"unset_lifepack" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x833e4f6b, Offset: 0x54e7
// Size: 0x47
function settoughenup()
{
    if ( !isdefined( level._effect[ "toughen_up_screen" ] ) )
    {
        level._effect[ "toughen_up_screen" ] = loadfx( "vfx/iw7/_requests/mp/vfx_toughen_up_scrn" );
    }
    
    /#
        setdvarifuninitialized( @"scr_toughenup_version", 1 );
    #/
    
    thread watchtoughenup();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xcbb3a49e, Offset: 0x5536
// Size: 0x29d
function watchtoughenup()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_db774f1dceb32e73" );
    level endon( #"game_ended" );
    var_f3ac3a886ceda166 = 15;
    effectlifetime = 5;
    effecttype = 2;
    var_f1c8360f6ddf5f8 = [];
    
    if ( !isdefined( var_f1c8360f6ddf5f8 ) )
    {
        var_f1c8360f6ddf5f8 = [];
    }
    
    var_f1c8360f6ddf5f8[ var_f1c8360f6ddf5f8.size ] = ( 35, 0, 10 );
    
    if ( !isdefined( var_f1c8360f6ddf5f8 ) )
    {
        var_f1c8360f6ddf5f8 = [];
    }
    
    var_f1c8360f6ddf5f8[ var_f1c8360f6ddf5f8.size ] = ( 0, 35, 10 );
    
    if ( !isdefined( var_f1c8360f6ddf5f8 ) )
    {
        var_f1c8360f6ddf5f8 = [];
    }
    
    var_f1c8360f6ddf5f8[ var_f1c8360f6ddf5f8.size ] = ( -35, 0, 10 );
    
    if ( !isdefined( var_f1c8360f6ddf5f8 ) )
    {
        var_f1c8360f6ddf5f8 = [];
    }
    
    var_f1c8360f6ddf5f8[ var_f1c8360f6ddf5f8.size ] = ( 0, -35, 10 );
    self waittill( #"spawned_player" );
    
    while ( true )
    {
        self waittill( #"got_a_kill", victim, weapon, meansofdeath );
        
        if ( !isdefined( self.toughenedup ) )
        {
            self.toughenedup = 1;
            screenfx = spawnfxforclient( utility::getfx( "toughen_up_screen" ), self geteye(), self );
            triggerfx( screenfx );
            thread attachtoughenuparmor( "j_forehead", level.bulletstormshield[ "section" ].friendlymodel );
            thread attachtoughenuparmor( "tag_reflector_arm_le", level.bulletstormshield[ "section" ].friendlymodel );
            thread attachtoughenuparmor( "tag_reflector_arm_ri", level.bulletstormshield[ "section" ].friendlymodel );
            thread attachtoughenuparmor( "j_spineupper", level.bulletstormshield[ "section" ].friendlymodel );
            thread attachtoughenuparmor( "tag_shield_back", level.bulletstormshield[ "section" ].friendlymodel );
            thread attachtoughenuparmor( "j_hip_le", level.bulletstormshield[ "section" ].friendlymodel );
            thread attachtoughenuparmor( "j_hip_ri", level.bulletstormshield[ "section" ].friendlymodel );
            
            if ( effecttype == 1 )
            {
                damage::sethealthshield( var_f3ac3a886ceda166 );
                thread watchtoughenuplifetime( effectlifetime );
            }
            else
            {
                lightarmor::setlightarmorvalue( self, 100 );
                thread watchtoughenuplightarmorend();
            }
            
            screenfx thread watchtoughenupplayerend( self );
            continue;
        }
        
        if ( effecttype == 1 )
        {
            self notify( #"hash_f4e0d6f61ea1db9" );
            thread watchtoughenuplifetime( effectlifetime );
        }
    }
}

// Namespace perkfunctions
// Params 5
// Checksum 0xeea47779, Offset: 0x57db
// Size: 0xd8
function attachtoughenuparmor( tag, model, originoverride, angleoverride, teamversion )
{
    shieldorigin = self gettagorigin( tag );
    shieldmodel = spawn( "script_model", shieldorigin );
    shieldmodel setmodel( model );
    originoffset = ( 0, 0, 0 );
    anglesoffset = ( 0, 0, 0 );
    
    if ( isdefined( originoverride ) )
    {
        originoffset = originoverride;
    }
    
    if ( isdefined( angleoverride ) )
    {
        anglesoffset = angleoverride;
    }
    
    shieldmodel.angles = self.angles;
    shieldmodel linkto( self, tag, originoffset, anglesoffset );
    shieldmodel thread watchtoughenupplayerend( self );
    shieldmodel thread watchtoughenupgameend();
    return shieldmodel;
}

// Namespace perkfunctions
// Params 4
// Checksum 0x6d655535, Offset: 0x58bc
// Size: 0x10f
function settoughenupmodel( var_3e5a1909757c2fd8, shieldoffset, shieldnumber, teamversion )
{
    shieldmodel = spawn( "script_model", self.origin + ( 0, 0, 50 ) );
    shieldmodel.team = self.owner.team;
    
    if ( teamversion == "friendly" )
    {
        shieldmodel setmodel( level.bulletstormshield[ "section" ].friendlymodel );
    }
    else
    {
        shieldmodel setmodel( level.bulletstormshield[ "section" ].enemymodel );
    }
    
    shieldmodel linkto( self, "tag_origin", shieldoffset, ( 0, 90 * ( shieldnumber + 1 ), 0 ) );
    shieldmodel hide();
    shieldmodel thread watchtoughenupplayerend( self.owner );
    shieldmodel thread watchtoughenupgameend();
    shieldmodel thread settoughenupvisiblestate( teamversion, self.owner );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xd1a0ab2, Offset: 0x59d3
// Size: 0x1b
function watchtoughenuplightarmorend()
{
    self endon( #"disconnect" );
    self waittill( #"remove_light_armor" );
}

// Namespace perkfunctions
// Params 1
// Checksum 0x73349b46, Offset: 0x59f6
// Size: 0x56
function watchtoughenupplayerend( owner )
{
    self endon( #"death" );
    owner utility::waittill_any( "death_or_disconnect", "toughen_up_end" );
    owner.toughenedup = undefined;
    
    if ( owner lightarmor::haslightarmor( owner ) )
    {
        owner unsetlightarmor();
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb0abeec5, Offset: 0x5a54
// Size: 0x26
function watchtoughenupgameend()
{
    self endon( #"death" );
    level waittill( #"game_ended" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0x1c79e9d4, Offset: 0x5a82
// Size: 0x44
function watchtoughenuplifetime( lifetime )
{
    self endon( #"death" );
    self endon( #"hash_f4e0d6f61ea1db9" );
    
    while ( lifetime > 0 )
    {
        lifetime -= 1;
        wait 1;
    }
    
    self notify( #"toughen_up_end" );
}

// Namespace perkfunctions
// Params 2
// Checksum 0x2aa8897, Offset: 0x5ace
// Size: 0xb7
function settoughenupvisiblestate( teamversion, owner )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player == owner )
        {
            continue;
        }
        
        if ( canshowtoughenupshield( player, teamversion ) )
        {
            self showtoplayer( player );
        }
        
        thread watchtoughenupplayerbegin( player, teamversion );
    }
}

// Namespace perkfunctions
// Params 2
// Checksum 0xee6c2a8d, Offset: 0x5b8d
// Size: 0x6c
function watchtoughenupplayerbegin( player, teamversion )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        player waittill( #"spawned_player" );
        self hidefromplayer( player );
        
        if ( canshowtoughenupshield( player, teamversion ) )
        {
            self showtoplayer( player );
        }
    }
}

// Namespace perkfunctions
// Params 2
// Checksum 0x4dac98b8, Offset: 0x5c01
// Size: 0x71
function canshowtoughenupshield( player, teamversion )
{
    var_f186829ad13b5b58 = 0;
    
    if ( teamversion == "friendly" && player.team == self.team || teamversion == "enemy" && player.team != self.team )
    {
        var_f186829ad13b5b58 = 1;
    }
    
    return var_f186829ad13b5b58;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xbc1b2fe, Offset: 0x5c7b
// Size: 0x1c
function unsettoughenup()
{
    damage::clearhealthshield();
    unsetlightarmor();
    self notify( #"hash_db774f1dceb32e73" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa2e21975, Offset: 0x5c9f
// Size: 0x9
function setscoutping()
{
    thread updatescoutping();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xcd492d57, Offset: 0x5cb0
// Size: 0xbd
function updatescoutping()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_56bfee1979659734" );
    baseradius = 50;
    var_70bdd712e075bdd8 = 1200;
    
    while ( true )
    {
        pingradius = baseradius;
        var_9bcd355248029c73 = var_70bdd712e075bdd8;
        
        if ( isdefined( self.scoutpingradius ) )
        {
            pingradius = self.scoutpingradius;
        }
        
        if ( isdefined( self.scoutsweeptime ) )
        {
            var_9bcd355248029c73 = self.scoutsweeptime;
        }
        
        pingradius = int( pingradius );
        var_9bcd355248029c73 = int( var_9bcd355248029c73 );
        
        if ( pingradius != baseradius )
        {
            triggerportableradarpingteam( self.origin, self.team, pingradius, var_9bcd355248029c73 );
        }
        
        wait var_70bdd712e075bdd8 / 1200;
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0xbf4cfeaa, Offset: 0x5d75
// Size: 0x13d
function updatescoutpingvalues( momentumstage )
{
    modvalue = 0;
    pingradius = 150;
    sweeptime = 3000;
    
    if ( isdefined( self.scoutpingmod ) )
    {
        modvalue = self.scoutpingmod;
    }
    
    if ( isdefined( self.scoutpingpreviousstage ) )
    {
        if ( momentumstage > self.scoutpingpreviousstage )
        {
            change = momentumstage - self.scoutpingpreviousstage;
            modvalue += change / 10;
        }
        else if ( momentumstage < self.scoutpingpreviousstage )
        {
            change = self.scoutpingpreviousstage - momentumstage;
            modvalue -= change / 10;
        }
    }
    
    if ( isdefined( self.scoutpingmod ) )
    {
        if ( modvalue > self.scoutpingmod || modvalue < self.scoutpingmod )
        {
            pingradius += pingradius * modvalue * 1.5;
            sweeptime -= sweeptime * modvalue / 1.5;
            self.scoutpingradius = pingradius;
            self.scoutsweeptime = sweeptime;
        }
    }
    
    if ( momentumstage == 0 )
    {
        self.scoutpingradius = undefined;
        self.scoutsweeptime = undefined;
    }
    
    self.scoutpingmod = modvalue;
    self.scoutpingpreviousstage = momentumstage;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xf79fcbd9, Offset: 0x5eba
// Size: 0x36
function unsetscoutping()
{
    self.scoutpingradius = undefined;
    self.scoutsweeptime = undefined;
    self.scoutpingmod = undefined;
    self.scoutpingpreviousstage = undefined;
    self notify( #"hash_56bfee1979659734" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xc11561be, Offset: 0x5ef8
// Size: 0x10
function setphasespeed()
{
    thread watchphasespeedshift();
    thread watchphasespeedendshift();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x191dd8bd, Offset: 0x5f10
// Size: 0x38
function watchphasespeedshift()
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"hash_5405ce8f2af5e254" );
        self.phasespeedmod = 0.2;
        weapons::updatemovespeedscale();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x6c5e334e, Offset: 0x5f50
// Size: 0x34
function watchphasespeedendshift()
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"hash_6f8b21471c980bb1" );
        self.phasespeedmod = undefined;
        weapons::updatemovespeedscale();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x5c38a188, Offset: 0x5f8c
// Size: 0xc
function unsetphasespeed()
{
    self.phasespeedmod = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x3e8a9fd3, Offset: 0x5fa0
// Size: 0xa
function setdodge()
{
    self allowdodge( 1 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x3ce33c27, Offset: 0x5fb2
// Size: 0x9
function unsetdodge()
{
    self allowdodge( 0 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb03b2563, Offset: 0x5fc3
// Size: 0x16
function setextradodge()
{
    self energy_setmax( 1, 100 );
    self energy_setenergy( 1, 100 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x1a01de88, Offset: 0x5fe1
// Size: 0x16
function unsetextradodge()
{
    self energy_setmax( 1, 50 );
    self energy_setenergy( 1, 50 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x82301b0f, Offset: 0x5fff
// Size: 0x2
function setenhancedsixthsense()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa585efe7, Offset: 0x6009
// Size: 0x2
function unsetenhancedsixthsense()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x2725dc7d, Offset: 0x6013
// Size: 0x1d4
function setcamoelite()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_1f2c4f17a1a95db4" );
    
    while ( true )
    {
        traces = 0;
        players = level.players;
        var_4be834fa60de1f85 = 0;
        
        foreach ( otherplayer in players )
        {
            if ( !isdefined( otherplayer ) || !otherplayer player::isreallyalive() )
            {
                continue;
            }
            
            if ( otherplayer.team == self.team )
            {
                continue;
            }
            
            if ( isdefined( otherplayer.perks[ "specialty_empimmune" ] ) )
            {
                continue;
            }
            
            fromotherplayer = self.origin - otherplayer.origin;
            otherplayeraim = anglestoforward( otherplayer getplayerangles() );
            dot = vectordot( fromotherplayer, otherplayeraim );
            
            if ( dot <= 0 )
            {
                continue;
            }
            
            var_18964b465bd0e9eb = vectornormalize( fromotherplayer );
            var_460bd69c9ed20eac = vectornormalize( otherplayeraim );
            dot = vectordot( var_18964b465bd0e9eb, var_460bd69c9ed20eac );
            
            if ( dot < 12 )
            {
                continue;
            }
            
            traces++;
            tracestart = otherplayer geteye();
            traceend = self geteye();
            
            if ( trace::ray_trace_passed( tracestart, traceend, self, trace::create_default_contents( 1 ) ) )
            {
                var_4be834fa60de1f85 = 1;
                break;
            }
            
            if ( traces >= 10 )
            {
                waitframe();
                traces = 0;
            }
        }
        
        updatecamoeliteoverlay( var_4be834fa60de1f85 );
        waitframe();
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0x78c5efc6, Offset: 0x61ef
// Size: 0xc
function updatecamoeliteoverlay( visible )
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xab176f97, Offset: 0x6203
// Size: 0x2
function unsetcamoelite()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe46325ef, Offset: 0x620d
// Size: 0x10
function setcarepackage()
{
    thread killstreaks::givekillstreak( "airdrop_assault", 0, 0 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xaa4cf180, Offset: 0x6225
// Size: 0x2
function unsetcarepackage()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x98d0abb6, Offset: 0x622f
// Size: 0x10
function setuav()
{
    thread killstreaks::givekillstreak( "uav", 0, 0 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x364cb92d, Offset: 0x6247
// Size: 0x2
function unsetuav()
{
    
}

// Namespace perkfunctions
// Params 1
// Checksum 0x2d66d4fa, Offset: 0x6251
// Size: 0xe4
function setjuiced( waittime )
{
    self endon( #"death_or_disconnect" );
    self endon( #"faux_spawn" );
    self endon( #"unset_juiced" );
    level endon( #"game_ended" );
    self.isjuiced = 1;
    self.movespeedscaler = 1.25;
    common::function_a0f5c85d465c5f0a( "moveSpeedScaler", self.movespeedscaler - 1 );
    weapons::updatemovespeedscale();
    perk::giveperk( "specialty_fastreload" );
    perk::giveperk( "specialty_quickdraw" );
    perk::giveperk( "specialty_stalker" );
    perk::giveperk( "specialty_fastoffhand" );
    perk::giveperk( "specialty_fastsprintrecovery" );
    perk::giveperk( "specialty_quickswap" );
    thread unsetjuicedondeath();
    thread unsetjuicedonride();
    thread unsetjuicedonmatchend();
    
    if ( !isdefined( waittime ) )
    {
        waittime = 10;
    }
    
    wait waittime;
    unsetjuiced();
}

// Namespace perkfunctions
// Params 1
// Checksum 0x5a1ccef2, Offset: 0x633d
// Size: 0xf6
function unsetjuiced( death )
{
    if ( !isdefined( death ) )
    {
        assert( isalive( self ) );
        self.movespeedscaler = 1;
        
        if ( common::function_8ff835bf23198a0( "moveSpeedScaler" ) )
        {
            common::function_d85a92c557ea5a52( "moveSpeedScaler" );
        }
        
        if ( isdefined( self.perks[ "specialty_lightweight" ] ) )
        {
            self.movespeedscaler = perk::lightweightscalar();
            common::function_78021bb179add5f3( "moveSpeedScaler", self.movespeedscaler - 1 );
        }
        
        assert( isdefined( self.movespeedscaler ) );
        weapons::updatemovespeedscale();
    }
    
    perk::removeperk( "specialty_fastreload" );
    perk::removeperk( "specialty_quickdraw" );
    perk::removeperk( "specialty_stalker" );
    perk::removeperk( "specialty_fastoffhand" );
    perk::removeperk( "specialty_fastsprintrecovery" );
    perk::removeperk( "specialty_quickswap" );
    self.isjuiced = undefined;
    self notify( #"unset_juiced" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x711642d7, Offset: 0x643b
// Size: 0x36
function unsetjuicedonride()
{
    self endon( #"disconnect" );
    self endon( #"unset_juiced" );
    
    while ( true )
    {
        waitframe();
        
        if ( utility::isusingremote() )
        {
            thread unsetjuiced();
            break;
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x9b023140, Offset: 0x6479
// Size: 0x34
function unsetjuicedondeath()
{
    self endon( #"disconnect" );
    self endon( #"unset_juiced" );
    utility::waittill_any( "death", "faux_spawn" );
    thread unsetjuiced( 1 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x744f2087, Offset: 0x64b5
// Size: 0x33
function unsetjuicedonmatchend()
{
    self endon( #"disconnect" );
    self endon( #"unset_juiced" );
    level utility::waittill_any( "round_end_finished", "game_ended" );
    thread unsetjuiced();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe5aaeea1, Offset: 0x64f0
// Size: 0xc, Type: bool
function hasjuiced()
{
    return isdefined( self.isjuiced );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x4cbe6167, Offset: 0x6505
// Size: 0x3cd
function setcombathigh()
{
    self endon( #"death_or_disconnect" );
    self endon( #"unset_combathigh" );
    level endon( #"end_game" );
    self.damageblockedtotal = 0;
    
    if ( level.splitscreen )
    {
        yoffset = 56;
        iconsize = 21;
    }
    else
    {
        yoffset = 112;
        iconsize = 32;
    }
    
    if ( isdefined( self.juicedtimer ) )
    {
        self.juicedtimer destroy();
    }
    
    if ( isdefined( self.juicedicon ) )
    {
        self.juicedicon destroy();
    }
    
    self.combathighoverlay = newclienthudelem( self );
    self.combathighoverlay.x = 0;
    self.combathighoverlay.y = 0;
    self.combathighoverlay.alignx = "left";
    self.combathighoverlay.aligny = "top";
    self.combathighoverlay.horzalign = "fullscreen";
    self.combathighoverlay.vertalign = "fullscreen";
    self.combathighoverlay setshader( "combathigh_overlay", 640, 480 );
    self.combathighoverlay.sort = -10;
    self.combathighoverlay.archived = 1;
    self.combathightimer = hud_util::createtimer( "hudsmall", 1 );
    self.combathightimer hud_util::setpoint( "CENTER", "CENTER", 0, yoffset );
    self.combathightimer settimer( 10 );
    self.combathightimer.color = ( 0.8, 0.8, 0 );
    self.combathightimer.archived = 0;
    self.combathightimer.foreground = 1;
    self.combathighicon = hud_util::createicon( "specialty_painkiller", iconsize, iconsize );
    self.combathighicon.alpha = 0;
    self.combathighicon hud_util::setparent( self.combathightimer );
    self.combathighicon hud_util::setpoint( "BOTTOM", "TOP" );
    self.combathighicon.archived = 1;
    self.combathighicon.sort = 1;
    self.combathighicon.foreground = 1;
    self.combathighoverlay.alpha = 0;
    self.combathighoverlay fadeovertime( 1 );
    self.combathighicon fadeovertime( 1 );
    self.combathighoverlay.alpha = 1;
    self.combathighicon.alpha = 0.85;
    thread unsetcombathighondeath();
    thread unsetcombathighonride();
    wait 8;
    self.combathighicon fadeovertime( 2 );
    self.combathighicon.alpha = 0;
    self.combathighoverlay fadeovertime( 2 );
    self.combathighoverlay.alpha = 0;
    self.combathightimer fadeovertime( 2 );
    self.combathightimer.alpha = 0;
    wait 2;
    self.damageblockedtotal = undefined;
    perk::removeperk( "specialty_combathigh" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x5f9d0009, Offset: 0x68da
// Size: 0x33
function unsetcombathighondeath()
{
    self endon( #"disconnect" );
    self endon( #"unset_combathigh" );
    self waittill( #"death" );
    thread perk::removeperk( "specialty_combathigh" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xfe12b700, Offset: 0x6915
// Size: 0x36
function unsetcombathighonride()
{
    self endon( #"disconnect" );
    self endon( #"unset_combathigh" );
    
    for ( ;; )
    {
        waitframe();
        
        if ( utility::isusingremote() )
        {
            thread perk::removeperk( "specialty_combathigh" );
            break;
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x7b6f1e95, Offset: 0x6953
// Size: 0x38
function unsetcombathigh()
{
    self notify( #"unset_combathigh" );
    self.combathighoverlay destroy();
    self.combathighicon destroy();
    self.combathightimer destroy();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x7b7687fd, Offset: 0x6993
// Size: 0xc
function setlightarmor()
{
    lightarmor::setlightarmorvalue( self, 150 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa97ba81, Offset: 0x69a7
// Size: 0xa
function unsetlightarmor()
{
    lightarmor::lightarmor_unset( self );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xd671206a, Offset: 0x69b9
// Size: 0x16f
function setrevenge()
{
    self notify( #"stoprevenge" );
    waitframe();
    
    if ( !isdefined( self.lastkilledby ) )
    {
        return;
    }
    
    if ( level.teambased && self.team == self.lastkilledby.team )
    {
        return;
    }
    
    revengeparams = spawnstruct();
    revengeparams.showto = self;
    revengeparams.icon = "compassping_revenge";
    revengeparams.offset = ( 0, 0, 64 );
    revengeparams.width = 10;
    revengeparams.height = 10;
    revengeparams.archived = 0;
    revengeparams.delay = 1.5;
    revengeparams.constantsize = 0;
    revengeparams.pintoscreenedge = 1;
    revengeparams.fadeoutpinnedicon = 0;
    revengeparams.is3d = 0;
    self.revengeparams = revengeparams;
    self.lastkilledby thread entityheadicons::setheadicon_singleimage( revengeparams.showto, revengeparams.icon, revengeparams.offset, undefined, undefined, undefined, revengeparams.delay );
    thread watchrevengedeath();
    thread watchrevengekill();
    thread watchrevengedisconnected();
    thread watchrevengevictimdisconnected();
    thread watchstoprevenge();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x303f54cb, Offset: 0x6b30
// Size: 0x9d
function watchrevengedeath()
{
    self endon( #"stoprevenge" );
    self endon( #"disconnect" );
    lastkilledby = self.lastkilledby;
    
    while ( true )
    {
        lastkilledby waittill( #"spawned_player" );
        lastkilledby thread entityheadicons::setheadicon_singleimage( self.revengeparams.showto, self.revengeparams.icon, self.revengeparams.offset, undefined, undefined, undefined, self.revengeparams.delay );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xc5984461, Offset: 0x6bd5
// Size: 0x27
function watchrevengekill()
{
    self endon( #"stoprevenge" );
    self waittill( #"killed_enemy" );
    self notify( #"stoprevenge" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x6d1791da, Offset: 0x6c04
// Size: 0x2f
function watchrevengedisconnected()
{
    self endon( #"stoprevenge" );
    self.lastkilledby waittill( #"disconnect" );
    self notify( #"stoprevenge" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xfe9f4bc7, Offset: 0x6c3b
// Size: 0xad
function watchstoprevenge()
{
    lastkilledby = self.lastkilledby;
    self waittill( #"stoprevenge" );
    
    if ( !isdefined( lastkilledby ) )
    {
        return;
    }
    
    foreach ( headicon in lastkilledby.entityheadicons )
    {
        if ( !isdefined( headicon ) )
        {
            continue;
        }
        
        headicon destroy();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x2a30e723, Offset: 0x6cf0
// Size: 0xe5
function watchrevengevictimdisconnected()
{
    objid = self.objidfriendly;
    lastkilledby = self.lastkilledby;
    lastkilledby endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"stoprevenge" );
    self waittill( #"disconnect" );
    
    if ( !isdefined( lastkilledby ) )
    {
        return;
    }
    
    foreach ( headicon in lastkilledby.entityheadicons )
    {
        if ( !isdefined( headicon ) )
        {
            continue;
        }
        
        headicon destroy();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xdd3a6ac5, Offset: 0x6ddd
// Size: 0xe
function unsetrevenge()
{
    self notify( #"stoprevenge" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x20b7355d, Offset: 0x6df3
// Size: 0xd
function setphaseslide()
{
    self.canphaseslide = 1;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x8a8dceb7, Offset: 0x6e08
// Size: 0xc
function unsetphaseslide()
{
    self.canphaseslide = 0;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x9a0e3a9b, Offset: 0x6e1c
// Size: 0xd
function setteleslide()
{
    self.canteleslide = 1;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xaab98ef4, Offset: 0x6e31
// Size: 0xc
function unsetteleslide()
{
    self.canteleslide = 0;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb1b7ffe4, Offset: 0x6e45
// Size: 0xd
function setphaseslashrephase()
{
    self.hasrephase = 1;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x602bd94, Offset: 0x6e5a
// Size: 0xc
function unsetphaseslashrephase()
{
    self.hasrephase = 0;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x598c07e9, Offset: 0x6e6e
// Size: 0x2
function setphasefall()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x693bb387, Offset: 0x6e78
// Size: 0x2
function unsetphasefall()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x8ff30074, Offset: 0x6e82
// Size: 0x2
function setextenddodge()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb881017f, Offset: 0x6e8c
// Size: 0x2
function unsetextenddodge()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x733fd2a2, Offset: 0x6e96
// Size: 0x9
function setauraquickswap()
{
    archassault::auraquickswap_run();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe694d57c, Offset: 0x6ea7
// Size: 0x2
function unsetauraquickswap()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x3e90211e, Offset: 0x6eb1
// Size: 0x2
function setauraspeed()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe279570, Offset: 0x6ebb
// Size: 0x2
function unsetauraspeed()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x28d9b4fb, Offset: 0x6ec5
// Size: 0x9
function setmarktargets()
{
    perk_mark_targets::marktarget_init();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x9c9bb132, Offset: 0x6ed6
// Size: 0x2
function unsetmarktargets()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x6e0c8534, Offset: 0x6ee0
// Size: 0x2
function setbatterypack()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x597e843f, Offset: 0x6eea
// Size: 0x2
function unsetbatterypack()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa040a830, Offset: 0x6ef4
// Size: 0x2
function setcamoclone()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x90f71c5e, Offset: 0x6efe
// Size: 0x2
function unsetcamoclone()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x49875501, Offset: 0x6f08
// Size: 0x16
function setblockhealthregen()
{
    self.healthregendisabled = 1;
    playerhealth::forcehealthregen( self, 0 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x41991f48, Offset: 0x6f26
// Size: 0x23
function unsetblockhealthregen()
{
    self.healthregendisabled = undefined;
    playerhealth::forcehealthregen( self, 1, undefined, { #nobattlechatter:1 } );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xc1c63a68, Offset: 0x6f51
// Size: 0x2
function setscorestreakpack()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb2b16925, Offset: 0x6f5b
// Size: 0x2
function unsetscorestreakpack()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x2dd7a397, Offset: 0x6f65
// Size: 0x2
function setsuperpack()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x1d6017f9, Offset: 0x6f6f
// Size: 0x2
function unsetsuperpack()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x8d6daed3, Offset: 0x6f79
// Size: 0x2
function setspawncloak()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x27575538, Offset: 0x6f83
// Size: 0x2
function unsetspawncloak()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x5f2f623d, Offset: 0x6f8d
// Size: 0x19
function setdodgedefense()
{
    damage_utility::adddamagemodifier( "dodgeDefense", 0.5, 0, &dodgedefenseignorefunc );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x6db8ff10, Offset: 0x6fae
// Size: 0xf
function unsetdodgedefense()
{
    damage_utility::removedamagemodifier( "dodgeDefense", 0 );
}

// Namespace perkfunctions
// Params 7
// Checksum 0xa02f812a, Offset: 0x6fc5
// Size: 0x7b, Type: bool
function dodgedefenseignorefunc( inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc )
{
    if ( !( isdefined( victim.dodging ) && victim.dodging && isdefined( victim.perks[ "specialty_dodge_defense" ] ) ) )
    {
        return true;
    }
    
    return false;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x494e0022, Offset: 0x7049
// Size: 0x2
function setdodgewave()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x79f9b44c, Offset: 0x7053
// Size: 0x2
function unsetdodgewave()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xbcd2b721, Offset: 0x705d
// Size: 0x2
function setgroundpound()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x8ba0b62a, Offset: 0x7067
// Size: 0x2
function unsetgroundpound()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb80bbd21, Offset: 0x7071
// Size: 0xd5
function setmeleekill()
{
    self giveweapon( "iw7_fistsperk_mp" );
    self assignweaponmeleeslot( "iw7_fistsperk_mp" );
    
    if ( self hasweapon( level.defaultfist ) )
    {
        currweap = self getcurrentweapon();
        inventory_utility::_takeweapon( level.defaultfist );
        self giveweapon( "iw7_fistslethal_mp" );
        
        if ( currweap.basename == level.defaultfist )
        {
            inventory_utility::_switchtoweapon( "iw7_fistslethal_mp" );
            
            if ( isdefined( self.spawnweaponobj ) && self.gettingloadout && self.spawnweaponobj.basename == level.defaultfist )
            {
                self.spawnweaponobj = makeweapon( "iw7_fistslethal_mp" );
                self setspawnweapon( self.spawnweaponobj );
            }
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x83ea45cd, Offset: 0x714e
// Size: 0x6f
function unsetmeleekill()
{
    inventory_utility::_takeweapon( "iw7_fistsperk_mp" );
    
    if ( self hasweapon( "iw7_fistslethal_mp" ) )
    {
        currweap = self.currentweapon;
        inventory_utility::_takeweapon( "iw7_fistslethal_mp" );
        self giveweapon( level.defaultfist );
        
        if ( currweap.basename == "iw7_fistslethal_mp" )
        {
            inventory_utility::_switchtoweapon( level.defaultfist );
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xc0edfac0, Offset: 0x71c5
// Size: 0x2
function setpowercell()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xf05a4eae, Offset: 0x71cf
// Size: 0x2
function unsetpowercell()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x2f7a407a, Offset: 0x71d9
// Size: 0x2
function setoverclock()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x1fcdf414, Offset: 0x71e3
// Size: 0x2
function unsetoverclock()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb50a0ea8, Offset: 0x71ed
// Size: 0xf
function setovercharge()
{
    self setclientomnvar( "ui_overcharge", 1 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x1f30f542, Offset: 0x7204
// Size: 0xe
function unsetovercharge()
{
    self setclientomnvar( "ui_overcharge", 0 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xbcb2c711, Offset: 0x721a
// Size: 0x2
function setpersonaltrophy()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x17f70996, Offset: 0x7224
// Size: 0x2
function unsetpersonaltrophy()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x98aca9d5, Offset: 0x722e
// Size: 0x2
function setdisruptorpunch()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x33e96752, Offset: 0x7238
// Size: 0x2
function unsetdisruptorpunch()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xf0648ccc, Offset: 0x7242
// Size: 0x17
function setequipmentping()
{
    if ( !game_utility_mp::lpcfeaturegated() )
    {
        level.equipmentpingactive = 1;
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x1ce903c7, Offset: 0x7261
// Size: 0x2
function unsetequipmentping()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xee92c8bd, Offset: 0x726b
// Size: 0x2
function setmanatarms()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xde257cd3, Offset: 0x7275
// Size: 0x2
function unsetmanatarms()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x98efbde8, Offset: 0x727f
// Size: 0x4a
function setnoscopeoutline()
{
    if ( !isdefined( level.noscopeoutlinesetnotifs ) )
    {
        level.noscopeoutlinesetnotifs = [];
        level.noscopeoutlineunsetnotifs = [];
        level thread processnoscopeoutlinesetnotifs();
        level thread processnoscopeoutlineunsetnotifs();
    }
    
    level.noscopeoutlinesetnotifs[ level.noscopeoutlinesetnotifs.size ] = self;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb3570e89, Offset: 0x72d1
// Size: 0x18
function unsetnoscopeoutline()
{
    level.noscopeoutlineunsetnotifs[ level.noscopeoutlineunsetnotifs.size ] = self;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe0409f8d, Offset: 0x72f1
// Size: 0x86
function processnoscopeoutlinesetnotifs()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( level.noscopeoutlinesetnotifs.size > 0 )
        {
            i = 0;
            
            while ( isdefined( level.noscopeoutlinesetnotifs[ i ] ) )
            {
                level notify( #"set_noscopeoutline", level.noscopeoutlinesetnotifs[ i ] );
                level.noscopeoutlinesetnotifs[ i ] notify( #"set_noscopeoutline" );
                i++;
                waitframe();
            }
            
            level.noscopeoutlinesetnotifs = [];
            continue;
        }
        
        waitframe();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe6b57d7b, Offset: 0x737f
// Size: 0x86
function processnoscopeoutlineunsetnotifs()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( level.noscopeoutlineunsetnotifs.size > 0 )
        {
            i = 0;
            
            while ( isdefined( level.noscopeoutlineunsetnotifs[ i ] ) )
            {
                level notify( #"unset_noscopeoutline", level.noscopeoutlineunsetnotifs[ i ] );
                level.noscopeoutlineunsetnotifs[ i ] notify( #"unset_noscopeoutline" );
                i++;
                waitframe();
            }
            
            level.noscopeoutlineunsetnotifs = [];
            continue;
        }
        
        waitframe();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xd01d79c9, Offset: 0x740d
// Size: 0x2
function setcloak()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xd274da3c, Offset: 0x7417
// Size: 0x2
function unsetcloak()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x949ac373, Offset: 0x7421
// Size: 0x2
function setwalllock()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x96d1449c, Offset: 0x742b
// Size: 0x2
function unsetwalllock()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x35b17bac, Offset: 0x7435
// Size: 0x2
function setrush()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x53fd0cdd, Offset: 0x743f
// Size: 0x18
function unsetrush()
{
    self notify( #"removecombathigh" );
    self.speedonkillmod = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb21686dd, Offset: 0x745f
// Size: 0x9
function sethover()
{
    thread runhover();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa4e1b1f8, Offset: 0x7470
// Size: 0x2
function unsethover()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x441754c9, Offset: 0x747a
// Size: 0x36
function setmomentum()
{
    self.momentumspeedincrease = 0.05;
    common::function_ac4bf3256b2545e3( "momentumSpeedIncrease", 0.05 );
    common::function_11a0a06c67c80f4d( "momentumSpeedIncrease", 2 );
    weapons::updatemovespeedscale();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x3ef88421, Offset: 0x74b8
// Size: 0x1f
function unsetmomentum()
{
    self.momentumspeedincrease = undefined;
    common::function_d85a92c557ea5a52( "momentumSpeedIncrease" );
    weapons::updatemovespeedscale();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe1ab1f0, Offset: 0x74df
// Size: 0x2
function setscavengereqp()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x99ff1a79, Offset: 0x74e9
// Size: 0x2
function unsetscavengereqp()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x26b31637, Offset: 0x74f3
// Size: 0x2
function setspawnview()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xaef105b2, Offset: 0x74fd
// Size: 0x7f
function unsetspawnview()
{
    foreach ( player in level.players )
    {
        player notify( #"end_spawnview" );
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0xced3fa8a, Offset: 0x7584
// Size: 0xc
function setheadgear( power )
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x67127cbc, Offset: 0x7598
// Size: 0x2
function unsetheadgear()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xf64b3a1e, Offset: 0x75a2
// Size: 0x2
function setftlslide()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xf400bdf1, Offset: 0x75ac
// Size: 0x2
function unsetftlslide()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x92616267, Offset: 0x75b6
// Size: 0x2
function setimprovedprone()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x692bc48, Offset: 0x75c0
// Size: 0x2
function unsetimprovedprone()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xf29c221e, Offset: 0x75ca
// Size: 0xc3
function setsupportkillstreaks()
{
    self endon( #"disconnect" );
    self waittill( #"hash_d3c2fc4c31a502ec" );
    
    if ( !isdefined( self.streakdata.streaks[ 1 ] ) )
    {
        foreach ( streak in self.streakdata.streaks[ "killstreaks" ] )
        {
            streak.earned = 0;
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa8095b3a, Offset: 0x7695
// Size: 0xe
function unsetsupportkillstreaks()
{
    self notify( #"hash_f4a0d94b6c54809e" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x5781238, Offset: 0x76ab
// Size: 0x17
function setoverrideweaponspeed()
{
    self.overrideweaponspeed_speedscale = 0.98;
    weapons::updatemovespeedscale();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xda6ee04a, Offset: 0x76ca
// Size: 0xc
function unsetoverrideweaponspeed()
{
    self.overrideweaponspeed_speedscale = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x9f098756, Offset: 0x76de
// Size: 0x2
function setcloakaerial()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa87b865d, Offset: 0x76e8
// Size: 0x2
function unsetcloakaerial()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa21c0332, Offset: 0x76f2
// Size: 0xd
function setspawnradar()
{
    self.hasspawnradar = 1;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x826f8d9, Offset: 0x7707
// Size: 0xd
function unsetspawnradar()
{
    self.hasspawnradar = 1;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x266d39e0, Offset: 0x771c
// Size: 0x2
function setimprovedmelee()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb29ee7cf, Offset: 0x7726
// Size: 0x2
function unsetimprovedmelee()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x93ef6007, Offset: 0x7730
// Size: 0x2
function setthief()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x9186c3f2, Offset: 0x773a
// Size: 0x2
function unsetthief()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x86a747df, Offset: 0x7744
// Size: 0x19
function setadsawareness()
{
    thread runadsawareness();
    self setscriptablepartstate( "heightened_senses", "default" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x27535f8f, Offset: 0x7765
// Size: 0x156
function runadsawareness()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_d14c5726a4cac3a1" );
    self.awarenessradius = 256;
    self.awarenessqueryrate = 2;
    thread awarenessmonitorstance();
    
    while ( true )
    {
        wait self.awarenessqueryrate;
        
        foreach ( player in level.players )
        {
            if ( player.team == self.team )
            {
                continue;
            }
            
            if ( isdefined( player.perks[ "specialty_coldblooded" ] ) )
            {
                bundle = level.perkbundles[ "specialty_coldblooded" ];
                
                if ( !isdefined( bundle ) || !bundle.var_d7cefdb3566b4447 )
                {
                    continue;
                }
            }
            
            if ( player isonground() && !player issprinting() && !player iswallrunning() && !player issprintsliding() )
            {
                continue;
            }
            
            thread playincomingwarning( player );
        }
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0x173c4074, Offset: 0x78c3
// Size: 0x82
function playincomingwarning( target )
{
    self setscriptablepartstate( "heightened_senses", "scrn_pulse" );
    self playrumbleonentity( "damage_heavy" );
    target playsoundtoplayer( "ghost_senses_ping", self );
    wait 0.2;
    
    if ( isdefined( self ) )
    {
        self setscriptablepartstate( "heightened_senses", "default" );
        
        if ( player::isreallyalive() )
        {
            self playrumbleonentity( "damage_heavy" );
            
            if ( isdefined( target ) && target player::isreallyalive() )
            {
                target playsoundtoplayer( "ghost_senses_ping", self );
            }
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x27404961, Offset: 0x794d
// Size: 0xc1
function awarenessmonitorstance()
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        stance = self getstance();
        velocity = self getvelocity();
        
        switch ( stance )
        {
            case #"hash_c6775c88e38f7803":
                self.awarenessradius = 400;
                self.awarenessqueryrate = 2;
                break;
            case #"hash_3fed0cbd303639eb":
                self.awarenessradius = 650;
                self.awarenessqueryrate = 1;
                break;
            case #"hash_d91940431ed7c605":
                self.awarenessradius = 700;
                self.awarenessqueryrate = 0.5;
                break;
        }
        
        wait 0.01;
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x8122c994, Offset: 0x7a16
// Size: 0x49
function awarenessaudiopulse()
{
    self endon( #"death_or_disconnect" );
    self endon( #"stop_awareness" );
    
    while ( true )
    {
        playsoundatpos( self.origin + ( 0, 0, 5 ), "ghost_senses_ping" );
        wait 2;
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb8ce26f2, Offset: 0x7a67
// Size: 0x1e
function unsetadsawareness()
{
    self notify( #"hash_d14c5726a4cac3a1" );
    self setscriptablepartstate( "heightened_senses", "default" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x65e75ad9, Offset: 0x7a8d
// Size: 0x2
function setrearguard()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x61c69f0f, Offset: 0x7a97
// Size: 0xc
function unsetrearguard()
{
    self.hasrearguardshield = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xfb608295, Offset: 0x7aab
// Size: 0xd
function setsolobuddyboost()
{
    self.hassolobuddyboost = 1;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x50254c28, Offset: 0x7ac0
// Size: 0xc
function unsetsolobuddyboost()
{
    self.hassolobuddyboost = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x20fda85f, Offset: 0x7ad4
// Size: 0x43
function setthrowingknifemelee()
{
    if ( !isdefined( self.throwingknifemelee ) )
    {
        /#
            iprintln( "<dev string:x68>" );
        #/
        
        return;
    }
    
    self giveweapon( self.throwingknifemelee );
    self assignweaponmeleeslot( self.throwingknifemelee );
    thread watchthrowingknifescavenge();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x836bd60c, Offset: 0x7b1f
// Size: 0x3c
function unsetthrowingknifemelee()
{
    if ( isdefined( self.throwingknifemelee ) && self hasweapon( self.throwingknifemelee ) )
    {
        self takeweapon( self.throwingknifemelee );
    }
    
    self notify( #"specialty_equip_throwingknife_end" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xeb58ebce, Offset: 0x7b63
// Size: 0x7c
function watchthrowingkifefireswipe()
{
    self endon( #"death_or_disconnect" );
    self endon( #"specialty_equip_throwingknife_end" );
    
    while ( true )
    {
        self waittill( #"weapon_change", weapon );
        
        if ( weapon.basename == "iw8_throwingknife_fire_melee_mp" )
        {
            self setscriptablepartstate( "equipFlamingKnife", "active" );
            self waittill( #"weapon_change" );
            self setscriptablepartstate( "equipFlamingKnife", "neutral" );
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xd2f9022b, Offset: 0x7be7
// Size: 0x12
function killthrowingknifefire()
{
    self setscriptablepartstate( "equipFlamingKnife", "neutral" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x44ec1785, Offset: 0x7c01
// Size: 0x7c
function function_9aaa06d95df87a63()
{
    self endon( #"death_or_disconnect" );
    self endon( #"specialty_equip_throwingknife_end" );
    
    while ( true )
    {
        self waittill( #"weapon_change", weapon );
        
        if ( weapon.basename == "iw8_throwingknife_electric_melee_mp" )
        {
            self setscriptablepartstate( "equipFlamingKnife", "active" );
            self waittill( #"weapon_change" );
            self setscriptablepartstate( "equipFlamingKnife", "neutral" );
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xaa116a1b, Offset: 0x7c85
// Size: 0x12
function function_4bef82a572e9a5a4()
{
    self setscriptablepartstate( "equipFlamingKnife", "neutral" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x7bcfdbe7, Offset: 0x7c9f
// Size: 0xbf
function watchthrowingknifescavenge()
{
    self endon( #"death_or_disconnect" );
    self endon( #"specialty_equip_throwingknife_end" );
    
    while ( true )
    {
        self waittill( #"offhand_fired", weapon );
        
        if ( weapon::isthrowingknife( weapon ) )
        {
            ammo = self getammocount( weapon );
            
            if ( ammo == 0 )
            {
                if ( isdefined( self.throwingknifemelee ) && self hasweapon( self.throwingknifemelee ) )
                {
                    self takeweapon( self.throwingknifemelee );
                }
            }
            
            while ( self getammocount( weapon ) == 0 )
            {
                wait 0.05;
            }
            
            self giveweapon( self.throwingknifemelee );
            self assignweaponmeleeslot( self.throwingknifemelee );
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x55410ceb, Offset: 0x7d66
// Size: 0x83
function setbulletoutline()
{
    self.bulletoutline = spawnstruct();
    self.bulletoutline.player = self;
    self.bulletoutline.enemies = [];
    self.bulletoutline.enemyids = [];
    self.bulletoutline.enemyendtimes = [];
    self.bulletoutline thread watchbulletoutline();
    self.bulletoutline thread watchbulletoutlinecleanup();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xc69d049, Offset: 0x7df1
// Size: 0x18
function unsetbulletoutline()
{
    self notify( #"unsetBulletOutline" );
    self.bulletoutline = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x7f8f0a3b, Offset: 0x7e11
// Size: 0x10a
function watchbulletoutline()
{
    self.player endon( #"death_or_disconnect" );
    self.player endon( #"unsetBulletOutline" );
    
    while ( isdefined( self.player ) )
    {
        time = gettime();
        
        foreach ( index, enemy in self.enemies )
        {
            if ( !isdefined( enemy ) )
            {
                bulletoutlineremoveenemy( undefined, index );
                continue;
            }
            
            if ( isdefined( enemy.perks[ "specialty_noscopeoutline" ] ) )
            {
                bulletoutlineremoveenemy( enemy, index );
                continue;
            }
            
            if ( time >= self.enemyendtimes[ index ] )
            {
                bulletoutlineremoveenemy( enemy, index );
            }
        }
        
        waitframe();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x6879997d, Offset: 0x7f23
// Size: 0x9c
function watchbulletoutlinecleanup()
{
    self.player utility::waittill_any( "disconnect", "unsetBulletOutline" );
    
    foreach ( index, enemy in self.enemies )
    {
        if ( isdefined( enemy ) )
        {
            bulletoutlineremoveenemy( enemy, index );
        }
    }
}

// Namespace perkfunctions
// Params 3
// Checksum 0xdfd558f2, Offset: 0x7fc7
// Size: 0xb5
function bulletoutlineaddenemy( enemy, duration, offensive )
{
    entnum = enemy getentitynumber();
    endtime = gettime() + duration * 1000;
    self.enemies[ entnum ] = enemy;
    
    if ( !isdefined( self.enemyids[ entnum ] ) )
    {
        self.enemyids[ entnum ] = outline::outlineenableforplayer( enemy, self.player, "outline_depth_red", "perk" );
    }
    
    if ( !( isdefined( self.enemyendtimes[ entnum ] ) && isdefined( offensive ) ) || offensive )
    {
        self.enemyendtimes[ entnum ] = endtime;
    }
}

// Namespace perkfunctions
// Params 2
// Checksum 0xcd64c283, Offset: 0x8084
// Size: 0x72
function bulletoutlineremoveenemy( enemy, index )
{
    assert( isdefined( enemy ) || isdefined( index ) );
    
    if ( !isdefined( index ) )
    {
        index = enemy getentitynumber();
    }
    
    self.enemies[ index ] = undefined;
    self.enemyendtimes[ index ] = undefined;
    
    if ( isdefined( enemy ) )
    {
        outline::outlinedisable( self.enemyids[ index ], enemy );
    }
    
    self.enemyids[ index ] = undefined;
}

// Namespace perkfunctions
// Params 4
// Checksum 0x8613b885, Offset: 0x80fe
// Size: 0x14d
function bulletoutlinecheck( attacker, victim, weapon, meansofdeath )
{
    if ( !isdefined( attacker.bulletoutline ) && !isdefined( victim.bulletoutline ) )
    {
        return;
    }
    
    if ( !( meansofdeath == "MOD_HEAD_SHOT" || meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_EXPLOSIVE_BULLET" ) )
    {
        return;
    }
    
    if ( !isplayer( attacker ) || !isplayer( victim ) )
    {
        return;
    }
    
    if ( !player_utility::playersareenemies( attacker.owner ?? attacker, victim.owner ?? victim ) )
    {
        return;
    }
    
    if ( outline::outlineoccluded( attacker geteye(), victim geteye() ) )
    {
        return;
    }
    
    if ( isdefined( attacker.bulletoutline ) && !isdefined( victim.perks[ "specialty_noscopeoutline" ] ) )
    {
        attacker.bulletoutline bulletoutlineaddenemy( victim, 1 );
    }
    
    if ( isdefined( victim.bulletoutline ) && !isdefined( attacker.perks[ "specialty_noscopeoutline" ] ) )
    {
        victim.bulletoutline bulletoutlineaddenemy( attacker, 2, 0 );
    }
}

// Namespace perkfunctions
// Params 2
// Checksum 0x44ab062b, Offset: 0x8253
// Size: 0x87
function markempsignatures( target, id )
{
    if ( !isdefined( target.empmarked ) )
    {
        target.empmarked = [];
    }
    
    if ( target.empmarked[ id ] == "active" )
    {
        return;
    }
    
    target.empmarked[ id ] = "active";
    thread empvfx( target, id );
    target utility::waittill_any( "death", "cloak_end" );
    target.empmarked[ id ] = undefined;
}

// Namespace perkfunctions
// Params 2
// Checksum 0x8d15d67a, Offset: 0x82e2
// Size: 0x23
function empvfx( target, id )
{
    target.empmarked[ id ] = undefined;
}

// Namespace perkfunctions
// Params 1
// Checksum 0xc2cb6ef, Offset: 0x830d
// Size: 0x3f
function function_43f07b5bbe813394( killstreaktimer )
{
    delay = killstreaktimer ?? 0;
    
    if ( delay > 0 )
    {
        if ( self.inspawncamera )
        {
            delay += spawncamera::getspawncamerablendtime();
        }
        
        wait delay;
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x8f255c6f, Offset: 0x8354
// Size: 0xd9
function function_972e127f16af366b()
{
    if ( level.var_f3d1cde89907a07a )
    {
        var_3ee9dcfa6415803a = 0;
        
        foreach ( squadindex, squadarray in level.squaddata[ self.team ] )
        {
            var_3ee9dcfa6415803a += level.activeadvanceduavs[ squadindex ];
        }
        
        return ( level.activeadvanceduavcount - var_3ee9dcfa6415803a > 0 );
    }
    
    return level.activeadvanceduavcount - ( level.activeadvanceduavs[ self.team ] ?? 0 ) > 0;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xea133ff2, Offset: 0x8435
// Size: 0x57, Type: bool
function function_b8987d13aaa62a17()
{
    key = level.teambased ? self.team : self.guid;
    var_8b6b00b5a3da1a4b = level.activeadvanceduavs[ key ] ?? 0;
    return level.activeadvanceduavcount - var_8b6b00b5a3da1a4b > 0;
}

// Namespace perkfunctions
// Params 1
// Checksum 0xa0c044d5, Offset: 0x8495
// Size: 0xeb, Type: bool
function function_d0626438f82f8443( minspeed )
{
    var_9edbd654b8505573 = lengthsquared( self getvelocity() ) >= squared( minspeed );
    
    if ( var_9edbd654b8505573 )
    {
        if ( isdefined( self.var_da093905786118a2 ) )
        {
            self.var_da093905786118a2 = undefined;
        }
        
        return true;
    }
    
    if ( self.isdefusing )
    {
        return true;
    }
    
    if ( self.isplanting )
    {
        return true;
    }
    
    if ( isdefined( self.vehicle_controlling ) && isdefined( self.vehicle_controlling.streakinfo ) )
    {
        return true;
    }
    
    if ( utility::isusingremote() )
    {
        return true;
    }
    
    if ( !isdefined( self.var_da093905786118a2 ) )
    {
        gracetime = getdvarfloat( @"hash_5cf78be1abae9320", 2 );
        self.var_da093905786118a2 = gettime() + gracetime * 1000;
        return true;
    }
    
    if ( gettime() < self.var_da093905786118a2 )
    {
        return true;
    }
    
    return false;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x2a465f03, Offset: 0x8589
// Size: 0x1c
function removegpsjammer()
{
    self notify( #"remove_gpsjammer" );
    self setplayerghost( 0 );
    self setplayeradvanceduavdot( 0 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x30378505, Offset: 0x85ad
// Size: 0x1b
function setgroundpoundshield()
{
    level._effect[ "groundPoundShield_impact" ] = loadfxasset( "vfx_iw7_requests_mp_debug_warning" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x78c11522, Offset: 0x85d0
// Size: 0xe
function unsetgroundpoundshield()
{
    self notify( #"groundpoundshield_unset" );
}

// Namespace perkfunctions
// Params 1
// Checksum 0xfae32775, Offset: 0x85e6
// Size: 0x13
function groundpoundshield_onimpact( var_697dbc12ab8fceec )
{
    thread groundpoundshield_raiseondelay();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x14e0d1ed, Offset: 0x8601
// Size: 0x33
function groundpoundshield_raiseondelay()
{
    self endon( #"death_or_disconnect" );
    self endon( #"groundPound_unset" );
    self endon( #"groundpoundland" );
    wait 0.25;
    groundpoundshield_raise();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb35d2917, Offset: 0x863c
// Size: 0x289
function groundpoundshield_raise()
{
    if ( isdefined( self.groundpoundshield ) )
    {
        thread groundpoundshield_lower( self.groundpoundshield );
    }
    
    origin = self.origin + anglestoforward( self.angles ) * 5;
    angles = self.angles + ( 0, 90, 0 );
    xmodel = spawn( "script_model", origin );
    xmodel.angles = angles;
    xmodel setmodel( "weapon_shinguard_col_wm" );
    var_802105f2b141296b = spawn( "script_model", origin );
    var_802105f2b141296b.angles = angles;
    var_802105f2b141296b setmodel( "weapon_shinguard_fr_wm" );
    var_802105f2b141296b.outlineid = outline::outlineenableforall( var_802105f2b141296b, "outline_nodepth_cyan", "equipment" );
    var_8024eff2b144eee0 = spawn( "script_model", origin );
    var_8024eff2b144eee0.angles = angles;
    var_8024eff2b144eee0 setmodel( "weapon_shinguard_en_wm" );
    var_8024eff2b144eee0.outlineid = outline::outlineenableforall( var_8024eff2b144eee0, "outline_nodepth_orange", "equipment" );
    xmodel.visfr = var_802105f2b141296b;
    xmodel.visen = var_8024eff2b144eee0;
    xmodel.owner = self;
    xmodel setcandamage( 1 );
    xmodel.health = 9999;
    xmodel.shieldhealth = 210;
    self.groundpoundshield = xmodel;
    players = level.characters;
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( level.teambased && player.team == self.team )
        {
            var_8024eff2b144eee0 hidefromplayer( player );
            continue;
        }
        
        var_802105f2b141296b hidefromplayer( player );
    }
    
    thread groundpoundshield_monitorjoinedteam( xmodel );
    thread groundpoundshield_loweronleavearea( xmodel );
    thread groundpoundshield_lowerontime( xmodel, 3.25 );
    thread groundpoundshield_loweronjump( xmodel );
    thread groundpoundshield_deleteondisconnect( xmodel );
    thread groundpoundshield_monitorhealth( xmodel );
    thread groundpound_raisefx();
    return xmodel;
}

// Namespace perkfunctions
// Params 1
// Checksum 0xf0135bb3, Offset: 0x88ce
// Size: 0x30
function groundpoundshield_lower( xmodel )
{
    self notify( #"groundpoundshield_end" );
    
    if ( !isdefined( xmodel ) )
    {
        return;
    }
    
    thread groundpoundshield_lowerfx();
    thread groundpoundshield_deleteshield( xmodel );
}

// Namespace perkfunctions
// Params 1
// Checksum 0x9b37d174, Offset: 0x8906
// Size: 0x30
function groundpoundshield_break( xmodel )
{
    self notify( #"groundpoundshield_end" );
    
    if ( !isdefined( xmodel ) )
    {
        return;
    }
    
    thread groundpoundshield_breakfx();
    thread groundpoundshield_deleteshield( xmodel );
}

// Namespace perkfunctions
// Params 1
// Checksum 0xb1930303, Offset: 0x893e
// Size: 0x1cd
function groundpoundshield_monitorhealth( xmodel )
{
    self endon( #"death_or_disconnect" );
    self endon( #"groundPound_unset" );
    self endon( #"groundpoundshield_end" );
    self endon( #"hash_4bc13d205b4b5da4" );
    
    while ( true )
    {
        xmodel waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon );
        
        if ( isdefined( attacker ) )
        {
            if ( attacker == self || attacker.team != self.team )
            {
                xmodel.shieldhealth -= damage;
            }
        }
        
        xmodel.health = 9999;
        thread groundpoundshield_damagedfx( attacker, point, direction_vec );
        
        if ( xmodel.shieldhealth <= 0 )
        {
            thread groundpoundshield_break( xmodel );
            return;
        }
        
        if ( xmodel.shieldhealth <= 105 )
        {
            if ( xmodel.visfr.model != "weapon_shinguard_dam_wm" )
            {
                xmodel.visfr setmodel( "weapon_shinguard_dam_wm" );
                outline::outlinerefresh( xmodel.visfr );
            }
            
            if ( xmodel.visen.model != "weapon_shinguard_dam_wm" )
            {
                xmodel.visen setmodel( "weapon_shinguard_dam_wm" );
                outline::outlinerefresh( xmodel.visen );
            }
        }
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0xe0ed2c2e, Offset: 0x8b13
// Size: 0x52
function groundpoundshield_loweronjump( xmodel )
{
    self endon( #"death_or_disconnect" );
    self endon( #"groundPound_unset" );
    self endon( #"groundpoundshield_end" );
    self endon( #"hash_4bc13d205b4b5da4" );
    self waittill( #"jump_begin" );
    thread groundpoundshield_lower( xmodel );
}

// Namespace perkfunctions
// Params 2
// Checksum 0x9fc41ad0, Offset: 0x8b6d
// Size: 0x51
function groundpoundshield_lowerontime( xmodel, time )
{
    self endon( #"death_or_disconnect" );
    self endon( #"groundPound_unset" );
    self endon( #"groundpoundshield_end" );
    self endon( #"hash_4bc13d205b4b5da4" );
    wait time;
    thread groundpoundshield_lower( xmodel );
}

// Namespace perkfunctions
// Params 1
// Checksum 0x8223582b, Offset: 0x8bc6
// Size: 0x70
function groundpoundshield_loweronleavearea( xmodel )
{
    self endon( #"death_or_disconnect" );
    self endon( #"groundPound_unset" );
    self endon( #"groundpoundshield_end" );
    self endon( #"hash_4bc13d205b4b5da4" );
    
    while ( isdefined( xmodel ) )
    {
        if ( lengthsquared( xmodel.origin - self.origin ) > 11664 )
        {
            thread groundpoundshield_lower( xmodel );
            return;
        }
        
        waitframe();
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0xaecb03aa, Offset: 0x8c3e
// Size: 0x32
function groundpoundshield_deleteondisconnect( xmodel )
{
    self endon( #"hash_4bc13d205b4b5da4" );
    utility::waittill_any( "death_or_disconnect", "groundPound_unset" );
    thread groundpoundshield_deleteshield( xmodel );
}

// Namespace perkfunctions
// Params 1
// Checksum 0x53e035c9, Offset: 0x8c78
// Size: 0xc
function groundpoundshield_monitorjoinedteam( xmodel )
{
    
}

// Namespace perkfunctions
// Params 1
// Checksum 0x73c51aef, Offset: 0x8c8c
// Size: 0x8d
function groundpoundshield_deleteshield( xmodel )
{
    self notify( #"hash_4bc13d205b4b5da4" );
    outline::outlinedisable( xmodel.visen.outlineid, xmodel.visen );
    outline::outlinedisable( xmodel.visfr.outlineid, xmodel.visfr );
    xmodel.visfr delete();
    xmodel.visen delete();
    xmodel delete();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x709bceb3, Offset: 0x8d21
// Size: 0x32
function groundpound_raisefx()
{
    self endon( #"disconnect" );
    self endon( #"groundPound_unset" );
    self endon( #"groundpoundshield_end" );
    self endon( #"hash_4bc13d205b4b5da4" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xccdb227a, Offset: 0x8d5b
// Size: 0x32
function groundpoundshield_lowerfx()
{
    self endon( #"disconnect" );
    self endon( #"groundPound_unset" );
    self endon( #"groundpoundshield_end" );
    self endon( #"hash_4bc13d205b4b5da4" );
}

// Namespace perkfunctions
// Params 3
// Checksum 0x9457583c, Offset: 0x8d95
// Size: 0x7f
function groundpoundshield_damagedfx( attacker, point, direction_vec )
{
    self endon( #"disconnect" );
    self endon( #"groundPound_unset" );
    self endon( #"groundpoundshield_end" );
    self endon( #"hash_4bc13d205b4b5da4" );
    playfx( utility::getfx( "groundPoundShield_impact" ), point, -1 * direction_vec );
    playsoundatpos( point, "ds_shield_impact" );
    attacker damagefeedback::updatedamagefeedback( "hitbulletstorm" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa5198328, Offset: 0x8e1c
// Size: 0x32
function groundpoundshield_breakfx()
{
    self endon( #"disconnect" );
    self endon( #"groundPound_unset" );
    self endon( #"groundpoundshield_end" );
    self endon( #"hash_4bc13d205b4b5da4" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x9014268f, Offset: 0x8e56
// Size: 0x34
function setgroundpoundshock()
{
    level._effect[ "groundPoundShock_impact_sm" ] = loadfxasset( "vfx_iw7_requests_mp_debug_warning" );
    level._effect[ "groundPoundShock_impact_lrg" ] = loadfxasset( "vfx_iw7_requests_mp_debug_warning" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x3bdd74bf, Offset: 0x8e92
// Size: 0xe
function unsetgroundpoundshock()
{
    self notify( #"groundpoundshock_unset" );
}

// Namespace perkfunctions
// Params 1
// Checksum 0x6ec680d9, Offset: 0x8ea8
// Size: 0x1d8
function groundpoundshock_onimpact( var_697dbc12ab8fceec )
{
    self endon( #"death_or_disconnect" );
    self endon( #"groundPound_unset" );
    self endon( #"groundpoundshock_unset" );
    radius = undefined;
    effectid = undefined;
    
    switch ( var_697dbc12ab8fceec )
    {
        case #"hash_845a1f955e7fce37":
            effectid = utility::getfx( "groundPoundShock_impact_sm" );
            radius = 144;
            break;
        case #"hash_845a1e955e7fcca4":
            effectid = utility::getfx( "groundPoundShock_impact_sm" );
            radius = 180;
            break;
        case #"hash_845a21955e7fd15d":
            effectid = utility::getfx( "groundPoundShock_impact_lrg" );
            radius = 216;
            break;
    }
    
    thread groundpoundshock_onimpactfx( radius, effectid );
    enemies = undefined;
    
    if ( level.teambased )
    {
        enemies = teams::getenemyplayers( self.team, 1 );
    }
    else
    {
        enemies = level.characters;
    }
    
    radiussqr = radius * radius;
    contents = trace::create_contents( 0, 1, 0, 0, 1, 0, 0 );
    
    foreach ( enemy in enemies )
    {
        if ( lengthsquared( enemy geteye() - self geteye() ) > radiussqr )
        {
            continue;
        }
        
        castresult = physics_raycast( self geteye(), enemy geteye(), contents, undefined, 0, "physicsquery_closest" );
        
        if ( isdefined( castresult ) && castresult.size > 0 )
        {
            continue;
        }
        
        thread groundpoundshock_empplayer( enemy );
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0x59ed3fd4, Offset: 0x9088
// Size: 0x3f
function groundpoundshock_empplayer( victim )
{
    victim endon( #"death_or_disconnect" );
    gamescore::trackdebuffassist( self, victim, "groundpound_mp" );
    wait 3;
    
    if ( isdefined( self ) )
    {
        gamescore::untrackdebuffassist( self, victim, "groundpound_mp" );
    }
}

// Namespace perkfunctions
// Params 2
// Checksum 0x21313562, Offset: 0x90cf
// Size: 0x40
function groundpoundshock_onimpactfx( radius, effectid )
{
    playfx( effectid, self.origin + ( 0, 0, 20 ), ( 0, 0, 1 ) );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa6daafae, Offset: 0x9117
// Size: 0x2
function setgroundpoundboost()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x3014923d, Offset: 0x9121
// Size: 0xe
function unsetgroundpoundboost()
{
    self notify( #"groundpoundboost_unset" );
}

// Namespace perkfunctions
// Params 1
// Checksum 0x588ac7f3, Offset: 0x9137
// Size: 0x19
function groundpoundboost_onimpact( var_697dbc12ab8fceec )
{
    utility::set_doublejumpenergy( self energy_getmax( 0 ) );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x3c79ba8f, Offset: 0x9158
// Size: 0x22
function setbattleslideshield()
{
    level._effect[ "battleSlideShield_damage" ] = loadfxasset( "vfx_iw7_requests_mp_debug_warning" );
    thread battleslideshield_monitor();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x32b28dd1, Offset: 0x9182
// Size: 0xe
function unsetbattleslideshield()
{
    self notify( #"battleslideshield_unset" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x42e03f2c, Offset: 0x9198
// Size: 0x4e
function battleslideshield_monitor()
{
    self endon( #"death_or_disconnect" );
    self endon( #"battleSlide_unset" );
    self notify( #"hash_2cdf315b10631d0c" );
    self endon( #"hash_2cdf315b10631d0c" );
    
    while ( true )
    {
        self waittill( #"sprint_slide_begin" );
        thread battleslideshield_raise();
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0x2e74189e, Offset: 0x91ee
// Size: 0x128
function battleslideshield_monitorhealth( xmodel )
{
    self endon( #"disconnect" );
    self endon( #"battleSlide_unset" );
    
    while ( isdefined( xmodel ) )
    {
        xmodel waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon );
        thread battleslideshield_damagedfx( xmodel, attacker, point, direction_vec );
        
        if ( xmodel.health <= 0 )
        {
            thread battleslideshield_break( xmodel );
            xmodel delete();
            continue;
        }
        
        if ( xmodel.health <= 125 )
        {
            if ( xmodel.model != "weapon_shinguard_dam_wm" )
            {
                xmodel setmodel( "weapon_shinguard_dam_wm" );
            }
            
            continue;
        }
        
        if ( xmodel.model != "weapon_shinguard_wm" )
        {
            xmodel setmodel( "weapon_shinguard_wm" );
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x83707d06, Offset: 0x931e
// Size: 0xce
function battleslideshield_raise()
{
    if ( isdefined( self.battleslideshield ) )
    {
        thread battleslideshield_lower( self.battleslideshield );
    }
    
    xmodel = utility::spawn_tag_origin();
    xmodel setmodel( "weapon_shinguard_wm" );
    xmodel setcandamage( 1 );
    xmodel.health = 250;
    xmodel linkto( self, "tag_origin", ( 30, 0, 0 ), ( 0, 90, 0 ) );
    xmodel show();
    self.battleslideshield = xmodel;
    thread battleslideshield_killonjumpfall( xmodel );
    thread battleslideshield_killonsprint( xmodel );
    thread battleslideshield_killontime( xmodel );
    thread battleslideshield_unlinkonstop( xmodel );
    thread battleslideshield_monitorhealth( xmodel );
    thread battleslideshield_killondeathdisconnectunset( xmodel );
    thread battleslideshield_raisefx( xmodel );
    return xmodel;
}

// Namespace perkfunctions
// Params 1
// Checksum 0x2323e967, Offset: 0x93f5
// Size: 0x30
function battleslideshield_lower( xmodel )
{
    self notify( #"battleslideshield_end" );
    
    if ( !isdefined( xmodel ) )
    {
        return;
    }
    
    thread battleslideshield_lowerfx( xmodel );
    xmodel delete();
}

// Namespace perkfunctions
// Params 1
// Checksum 0xcea646e6, Offset: 0x942d
// Size: 0x31
function battleslideshield_killondeathdisconnectunset( xmodel )
{
    xmodel endon( #"death" );
    utility::waittill_any( "death_or_disconnect", "battleSlide_unset" );
    xmodel delete();
}

// Namespace perkfunctions
// Params 1
// Checksum 0x442eb18b, Offset: 0x9466
// Size: 0x6f
function battleslideshield_killonjumpfall( xmodel )
{
    self endon( #"death_or_disconnect" );
    self endon( #"battleSlide_unset" );
    self endon( #"hash_c6a22f6430871c8d" );
    self endon( #"battleslideshield_end" );
    xmodel endon( #"death" );
    
    while ( true )
    {
        if ( !self isonground() )
        {
            xmodel delete();
            self notify( #"battleslideshield_end" );
            return;
        }
        
        waitframe();
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0x94f122bf, Offset: 0x94dd
// Size: 0x69
function battleslideshield_killonsprint( xmodel )
{
    self endon( #"death_or_disconnect" );
    self endon( #"battleSlide_unset" );
    self endon( #"hash_c6a22f6430871c8d" );
    self endon( #"battleslideshield_end" );
    xmodel endon( #"death" );
    self waittill( #"sprint_begin" );
    xmodel delete();
    self notify( #"battleslideshield_end" );
}

// Namespace perkfunctions
// Params 1
// Checksum 0x9e6e6ae0, Offset: 0x954e
// Size: 0x70
function battleslideshield_loweronleavearea( xmodel )
{
    self endon( #"death_or_disconnect" );
    self endon( #"battleSlide_unset" );
    self endon( #"battleslideshield_end" );
    xmodel endon( #"death" );
    
    while ( true )
    {
        if ( lengthsquared( xmodel.origin - self.origin ) > 11664 )
        {
            thread battleslideshield_lower( xmodel );
            return;
        }
        
        waitframe();
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0x4db4c7c0, Offset: 0x95c6
// Size: 0x4c
function battleslideshield_lowerontime( xmodel )
{
    self endon( #"death_or_disconnect" );
    self endon( #"battleSlide_unset" );
    self endon( #"battleslideshield_end" );
    xmodel endon( #"death" );
    wait 3.5;
    thread battleslideshield_lower( xmodel );
}

// Namespace perkfunctions
// Params 1
// Checksum 0x1a0b2c46, Offset: 0x961a
// Size: 0x45
function battleslideshield_unlink( xmodel )
{
    if ( !isdefined( xmodel ) )
    {
        return;
    }
    
    xmodel unlink();
    self notify( #"hash_c6a22f6430871c8d" );
    thread battleslideshield_lowerontime( xmodel );
    thread battleslideshield_loweronleavearea( xmodel );
    self notify( #"hash_c6a22f6430871c8d" );
}

// Namespace perkfunctions
// Params 1
// Checksum 0xbe98834e, Offset: 0x9667
// Size: 0x6f
function battleslideshield_killontime( xmodel )
{
    self endon( #"death_or_disconnect" );
    self endon( #"battleSlide_unset" );
    self endon( #"hash_c6a22f6430871c8d" );
    self endon( #"battleslideshield_end" );
    xmodel endon( #"death" );
    self waittill( #"sprint_slide_end" );
    wait 0.75;
    xmodel delete();
    self notify( #"battleslideshield_end" );
}

// Namespace perkfunctions
// Params 1
// Checksum 0x646d81bd, Offset: 0x96de
// Size: 0x78
function battleslideshield_unlinkonstop( xmodel )
{
    self endon( #"death_or_disconnect" );
    self endon( #"battleSlide_unset" );
    self endon( #"hash_c6a22f6430871c8d" );
    self endon( #"battleslideshield_end" );
    xmodel endon( #"death" );
    self waittill( #"sprint_slide_end" );
    
    while ( true )
    {
        if ( lengthsquared( self getvelocity() ) < 100 )
        {
            thread battleslideshield_unlink( xmodel );
            return;
        }
        
        waitframe();
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0xdb4d97aa, Offset: 0x975e
// Size: 0x29
function battleslideshield_break( xmodel )
{
    if ( !isdefined( xmodel ) )
    {
        return;
    }
    
    thread battleslideshield_breakfx( xmodel );
    self notify( #"battleslideshield_end" );
}

// Namespace perkfunctions
// Params 1
// Checksum 0xc71782f2, Offset: 0x978f
// Size: 0x31
function battleslideshield_raisefx( xmodel )
{
    self endon( #"disconnect" );
    self endon( #"battleSlide_unset" );
    xmodel endon( #"death" );
}

// Namespace perkfunctions
// Params 1
// Checksum 0x79379044, Offset: 0x97c8
// Size: 0x31
function battleslideshield_lowerfx( xmodel )
{
    self endon( #"disconnect" );
    self endon( #"battleSlide_unset" );
    xmodel endon( #"death" );
}

// Namespace perkfunctions
// Params 4
// Checksum 0x367e01c, Offset: 0x9801
// Size: 0x7d
function battleslideshield_damagedfx( xmodel, attacker, point, direction_vec )
{
    self endon( #"disconnect" );
    self endon( #"battleSlide_unset" );
    xmodel endon( #"death" );
    playfx( utility::getfx( "battleSlideShield_damage" ), point, -1 * direction_vec );
    playsoundatpos( point, "ds_shield_impact" );
    attacker damagefeedback::updatedamagefeedback( "hitbulletstorm" );
}

// Namespace perkfunctions
// Params 1
// Checksum 0x4387c42b, Offset: 0x9886
// Size: 0xc
function battleslideshield_breakfx( xmodel )
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x3aff18f, Offset: 0x989a
// Size: 0x2
function setbattleslideoffense()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x241a0567, Offset: 0x98a4
// Size: 0x2
function unsetbattleslideoffense()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x4cbd662e, Offset: 0x98ae
// Size: 0x4
function getbattleslideoffensedamage()
{
    return 100;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x57d42ae5, Offset: 0x98bb
// Size: 0x3b
function setthruster()
{
    level._effect[ "thrusterRadFr" ] = loadfx( "vfx/iw7/core/mp/powers/thrust_blast/vfx_thrust_blast_radius_fr" );
    level._effect[ "thrusterRadEn" ] = loadfx( "vfx/iw7/core/mp/powers/thrust_blast/vfx_thrust_blast_radius_en" );
    thrusterwatchdoublejump();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb6702db1, Offset: 0x98fe
// Size: 0x29
function unsetthruster()
{
    if ( isdefined( self.thrustfxent ) )
    {
        self.thrustfxent delete();
    }
    
    self notify( #"thruster_unset" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x3b2688cd, Offset: 0x992f
// Size: 0x49
function thrusterwatchdoublejump()
{
    self endon( #"death_or_disconnect" );
    self endon( #"thruster_unset" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"hash_66b93b488df62cd0" );
        thread thrusterloop();
        thread thrusterdamageloop();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x4b2ca089, Offset: 0x9980
// Size: 0x148
function thrusterloop()
{
    self endon( #"death_or_disconnect" );
    self endon( #"thruster_unset" );
    level endon( #"game_ended" );
    self endon( #"doubleJumpBoostEnd" );
    thread thrusterstopfx();
    
    if ( !isdefined( self.thrustfxent ) )
    {
        self.thrustfxent = spawn( "script_model", self.origin );
        self.thrustfxent setmodel( "tag_origin" );
    }
    else
    {
        self.thrustfxent.origin = self.origin;
    }
    
    waitframe();
    
    for ( ;; )
    {
        self playrumbleonentity( "damage_light" );
        earthquake( 0.1, 0.3, self.origin, 120 );
        groundposition = playerphysicstrace( self.origin + ( 0, 0, 10 ), self.origin - ( 0, 0, 600 ) ) + ( 0, 0, 1 );
        self.thrustfxent.origin = groundposition;
        self.thrustfxent.angles = ( 90, 0, 0 );
        waitframe();
        wait 0.33;
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x8f73a0e2, Offset: 0x9ad0
// Size: 0x66
function thrusterdamageloop()
{
    self endon( #"death_or_disconnect" );
    self endon( #"thruster_unset" );
    level endon( #"game_ended" );
    self endon( #"doubleJumpBoostEnd" );
    
    while ( true )
    {
        damage::radiusplayerdamage( self.origin, 12, 64, 5, 12, self, undefined, "MOD_IMPACT", "thruster_mp", 1 );
        wait 0.05;
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x2523aafa, Offset: 0x9b3e
// Size: 0x2c
function thrusterstopfx()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    utility::waittill_any( "doubleJumpBoostEnd", "thruster_unset" );
    waitframe();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xdc7daf7f, Offset: 0x9b72
// Size: 0x79
function runhover()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_1f2c4f17a1a95db4" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self ishighjumping() && self playerads() > 0.3 && self energy_getenergy( 0 ) > 0 )
        {
            executehover();
            thread watchhoverend();
            self waittill( #"hover_ended" );
            endhover();
        }
        
        wait 0.1;
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa6525a1f, Offset: 0x9bf3
// Size: 0x50
function watchhoverend()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_1f2c4f17a1a95db4" );
    level endon( #"game_ended" );
    self endon( #"hash_50393ede7a4364b5" );
    
    while ( self playerads() > 0.3 )
    {
        waitframe();
    }
    
    self notify( #"hover_ended" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x4337fe8b, Offset: 0x9c4b
// Size: 0x6d
function executehover()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_1f2c4f17a1a95db4" );
    level endon( #"game_ended" );
    self.ishovering = 1;
    self allowmovement( 0 );
    self allowjump( 0 );
    self playlocalsound( "ghost_wall_attach" );
    org = utility::spawn_tag_origin();
    self playerlinkto( org );
    thread managetimeout( org );
}

// Namespace perkfunctions
// Params 1
// Checksum 0xf8a60d9c, Offset: 0x9cc0
// Size: 0x6e
function managetimeout( org )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_1f2c4f17a1a95db4" );
    level endon( #"game_ended" );
    oldrate = self energy_getrestorerate( 0 );
    self energy_setrestorerate( 0, 1 );
    wait 2;
    self notify( #"hover_ended" );
    self energy_setrestorerate( 0, oldrate );
    self energy_setenergy( 0, 0 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x502f8d6e, Offset: 0x9d36
// Size: 0x51
function endhover()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_1f2c4f17a1a95db4" );
    level endon( #"game_ended" );
    self.ishovering = undefined;
    self allowmovement( 1 );
    self allowjump( 1 );
    self playlocalsound( "ghost_wall_detach" );
    self unlink();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xc8a7f02f, Offset: 0x9d8f
// Size: 0x2
function setadsmarktarget()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x5c542e00, Offset: 0x9d99
// Size: 0x2
function unsetadsmarktarget()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x36bce325, Offset: 0x9da3
// Size: 0x2
function sethelmet()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xfb698c15, Offset: 0x9dad
// Size: 0x2
function unsethelmet()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xc4e8e21f, Offset: 0x9db7
// Size: 0xc
function setarmorvest()
{
    self.tookvesthit = 0;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xd7a942db, Offset: 0x9dcb
// Size: 0x2
function unsetarmorvest()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x273e8f20, Offset: 0x9dd5
// Size: 0x14
function setdoorbreach()
{
    destructible::allowplayertobreach( self );
    door::updatealldoorslockvisibilityforplayer( self, 1 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x27452a44, Offset: 0x9df1
// Size: 0xa
function unsetdoorbreach()
{
    destructible::allowplayertobreach( self );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x23d1a56f, Offset: 0x9e03
// Size: 0x33
function setdoorsense()
{
    if ( !isdefined( level.playerswithdoorsense ) )
    {
        level.playerswithdoorsense = 1;
        return;
    }
    
    level.playerswithdoorsense += 1;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x13661164, Offset: 0x9e3e
// Size: 0x17
function unsetdoorsense()
{
    level.playerswithdoorsense -= 1;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x26ca6bf5, Offset: 0x9e5d
// Size: 0x9
function setworsenedgunkick()
{
    updateweaponkick();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x55bd3896, Offset: 0x9e6e
// Size: 0xb
function unsetworsenedgunkick()
{
    updateweaponkick( 1 );
}

// Namespace perkfunctions
// Params 1
// Checksum 0x14db23cd, Offset: 0x9e81
// Size: 0xd4
function updateweaponkick( var_c3df8a3a3b6065e2 )
{
    if ( !isdefined( self.weaponkickrecoil ) )
    {
        self.weaponkickrecoil = 0;
    }
    
    recoil = -25;
    
    if ( isdefined( self.perks[ "specialty_worsenedgunkick" ] ) && !var_c3df8a3a3b6065e2 )
    {
        if ( isdefined( self.currentweapon ) )
        {
            switch ( self.currentweapon.classname )
            {
                case #"hash_8cdaf2e4ecfe5b51":
                    recoil = -20;
                    break;
                case #"hash_fa24dff6bd60a12d":
                    recoil = -20;
                    break;
            }
        }
    }
    else
    {
        recoil = 0;
    }
    
    if ( recoil != self.weaponkickrecoil )
    {
        utility::setrecoilscale( -1 * self.weaponkickrecoil );
        utility::setrecoilscale( recoil );
        self.weaponkickrecoil = recoil;
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb1bf9589, Offset: 0x9f5d
// Size: 0xd6
function setkillstreaktoscorestreak()
{
    if ( level.gametypebundle.requisitionsenabled )
    {
        return;
    }
    
    if ( level.gamemodebundle.streakearn == #"score" )
    {
        return;
    }
    
    newpoints = undefined;
    
    if ( self.pers[ #"hash_2e974632f1fb8250" ] == self.lifeid )
    {
        newpoints = self.pers[ #"killstreaktoscorestreak" ];
        self.pers[ #"killstreaktoscorestreak" ] = undefined;
        self.pers[ #"hash_2e974632f1fb8250" ] = undefined;
    }
    else
    {
        newpoints = killstreaktoscorestreak_killtoscore( self.streakpoints );
    }
    
    killstreaks::updatestreakcosts();
    killstreaks::setstreakpoints( newpoints );
    thread killstreaks::function_f1923f85651597e9( self.streakpoints );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe0f2133a, Offset: 0xa03b
// Size: 0xaf
function unsetkillstreaktoscorestreak()
{
    if ( level.gametypebundle.requisitionsenabled )
    {
        return;
    }
    
    if ( level.gamemodebundle.streakearn == #"score" )
    {
        return;
    }
    
    self.pers[ #"killstreaktoscorestreak" ] = self.streakpoints;
    self.pers[ #"hash_2e974632f1fb8250" ] = self.lifeid;
    newpoints = killstreaktoscorestreak_scoretokill( self.streakpoints );
    killstreaks::updatestreakcosts();
    killstreaks::setstreakpoints( newpoints );
    thread killstreaks::function_f1923f85651597e9( self.streakpoints );
}

// Namespace perkfunctions
// Params 1
// Checksum 0x987a19d2, Offset: 0xa0f2
// Size: 0x11
function killstreaktoscorestreak_killtoscore( streakpoints )
{
    return streakpoints * 125;
}

// Namespace perkfunctions
// Params 1
// Checksum 0x38f315be, Offset: 0xa10c
// Size: 0x15
function killstreaktoscorestreak_scoretokill( streakpoints )
{
    return int( streakpoints / 125 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x8f6efda5, Offset: 0xa12a
// Size: 0x22
function setchainkillstreaks()
{
    if ( self.streakpoints <= 0 )
    {
        self.pers[ "canKillChain" ] = 1;
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe1f8cf2a, Offset: 0xa154
// Size: 0x1e
function unsetchainkillstreaks()
{
    if ( !level.gameended )
    {
        self.pers[ "canKillChain" ] = undefined;
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x85288ebe, Offset: 0xa17a
// Size: 0x22
function setscrapweapons()
{
    if ( getdvarint( @"perk_graverobber_enabled" ) == 1 )
    {
        self setclientomnvar( "ui_graverobber", 1 );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x62a8e6a5, Offset: 0xa1a4
// Size: 0xe
function unsetscrapweapons()
{
    self setclientomnvar( "ui_graverobber", 0 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xc095e6b9, Offset: 0xa1ba
// Size: 0x16
function setdooralarm()
{
    self.alarmeddoors = [];
    door::updatealldoorsalarmvisibilityforplayer( self, 1 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xbb8d0e55, Offset: 0xa1d8
// Size: 0x8f
function unsetdooralarm()
{
    foreach ( alarmeddoor in self.alarmeddoors )
    {
        alarmeddoor door::removealarmdoor( 0 );
    }
    
    self.alarmeddoors = undefined;
    door::updatealldoorsalarmvisibilityforplayer( self, 0 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x748a185c, Offset: 0xa26f
// Size: 0x9
function setreviveuseweapon()
{
    thread proximityrevivethink();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x482cf806, Offset: 0xa280
// Size: 0x41f
function proximityrevivethink()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"unset_revive_use_weapon" );
    
    if ( !isdefined( self.proximityrevivefauxtrigger ) )
    {
        fauxtrigger = spawnstruct();
        fauxtrigger.usetime = level.laststandrevivetimer * 0.5;
        fauxtrigger.curprogress = 0;
        fauxtrigger.owner = undefined;
        fauxtrigger.id = "laststand_reviver";
        fauxtrigger.trigger = spawnstruct();
        fauxtrigger.trigger.id = "laststand_reviver";
        self.proximityrevivefauxtrigger = fauxtrigger;
    }
    
    fauxtrigger = self.proximityrevivefauxtrigger;
    
    if ( !isdefined( self.hiddenreviveents ) )
    {
        self.hiddenreviveents = [];
    }
    
    self.canrevivewithweapon = 1;
    
    if ( isdefined( level.revivetriggers ) )
    {
        foreach ( entnum, ent in level.revivetriggers )
        {
            if ( !isdefined( self.hiddenreviveents[ entnum ] ) )
            {
                ent.trigger disableplayeruse( self );
                self.hiddenreviveents[ entnum ] = ent.trigger;
            }
        }
    }
    
    foreach ( entnum, ent in level.laststandreviveents )
    {
        if ( !isdefined( self.hiddenreviveents[ entnum ] ) )
        {
            ent disableplayeruse( self );
            self.hiddenreviveents[ entnum ] = ent;
        }
    }
    
    while ( true )
    {
        players = player_utility::script_getplayersinradius( self.origin, 150, self.team, self );
        
        foreach ( player in players )
        {
            if ( player.inlaststand && !player.stuckinlaststand && !player.laststandhealisactive && !player player::getbeingrevivedinternal() && !isdefined( fauxtrigger.owner ) )
            {
                thread proximityrevive( player, fauxtrigger );
            }
        }
        
        if ( isdefined( level.revivetriggers ) )
        {
            foreach ( useent in level.revivetriggers )
            {
                if ( useent.ownerteam == self.team )
                {
                    if ( !useent.trigger.owner player::getbeingrevivedinternal() && !isdefined( fauxtrigger.owner ) )
                    {
                        if ( distancesquared( useent.trigger.origin, self.origin ) <= 22500 )
                        {
                            thread proximityrevive( useent.trigger.owner, fauxtrigger, useent );
                        }
                    }
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace perkfunctions
// Params 3
// Checksum 0x3c5f553, Offset: 0xa6a7
// Size: 0x221
function proximityrevive( player, fauxtrigger, reviveent )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"unset_revive_use_weapon" );
    player endon( #"death_or_disconnect" );
    player endon( #"last_stand_exit" );
    player player::setbeingrevivedinternal( 1 );
    fauxtrigger.owner = player;
    fauxtrigger.trigger.owner = player;
    thread watchproximityrevivefail( player, fauxtrigger, reviveent );
    
    if ( isdefined( reviveent ) )
    {
        reviveent.trigger hide();
        reviveent.trigger makeunusable();
        reviveent teamrevive::revivetriggerholdonusebegin( self, 1 );
    }
    else if ( isdefined( player.laststandreviveent ) )
    {
        player.laststandreviveent hide();
        player.laststandreviveent makeunusable();
    }
    
    player laststand::function_a972f0e70d85b369();
    player player::_freezecontrols( 1, undefined, "proximityRevive" );
    
    while ( fauxtrigger.curprogress < fauxtrigger.usetime )
    {
        if ( distancesquared( self.origin, player.origin ) > 90000 )
        {
            self notify( #"prox_revive_fail" );
            return;
        }
        
        gameobjects::updateuiprogress( fauxtrigger, 1 );
        fauxtrigger.curprogress += level.framedurationseconds;
        waitframe();
    }
    
    gameobjects::updateuiprogress( fauxtrigger, 0 );
    player gameobjects::updateuiprogress( fauxtrigger, 0 );
    player player::_freezecontrols( 0, undefined, "proximityRevive" );
    fauxtrigger.curprogress = 0;
    fauxtrigger.owner = undefined;
    fauxtrigger.trigger.owner = undefined;
    
    if ( player.inlaststand )
    {
        player laststand::exit( "last_stand_revived", self );
        return;
    }
    
    reviveent teamrevive::revivetriggerholdonuseend( self.team, self, 1, 1 );
    reviveent teamrevive::revivetriggerholdonuse( self );
}

// Namespace perkfunctions
// Params 3
// Checksum 0xbd925a99, Offset: 0xa8d0
// Size: 0x155
function watchproximityrevivefail( player, fauxtrigger, reviveent )
{
    level endon( #"game_ended" );
    player endon( #"last_stand_exit" );
    player endon( #"spawned_player" );
    team = player.team;
    utility::waittill_any_ents_return( self, "death_or_disconnect", self, "unset_revive_use_weapon", self, "prox_revive_fail", player, "death_or_disconnect", player, "last_stand_exit" );
    
    if ( isdefined( reviveent ) )
    {
        reviveent.trigger show();
        reviveent.trigger makeusable();
        reviveent teamrevive::revivetriggerholdonuseend( team, self, 0, 1 );
    }
    
    if ( isdefined( player ) )
    {
        player player::setbeingrevivedinternal( 0 );
        player gameobjects::updateuiprogress( fauxtrigger, 0 );
        player player::_freezecontrols( 0, undefined, "proximityRevive" );
        
        if ( isdefined( player.laststandreviveent ) )
        {
            player.laststandreviveent show();
            player.laststandreviveent makeusable();
        }
        
        player laststand::function_a972f0e70d85b369();
    }
    
    if ( isdefined( self ) )
    {
        fauxtrigger.owner = undefined;
        fauxtrigger.trigger.owner = undefined;
        fauxtrigger.curprogress = 0;
        gameobjects::updateuiprogress( fauxtrigger, 0 );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa78d00ae, Offset: 0xaa2d
// Size: 0xaf
function unsetreviveuseweapon()
{
    self notify( #"unset_revive_use_weapon" );
    self.canrevivewithweapon = undefined;
    
    foreach ( ent in self.hiddenreviveents )
    {
        if ( isdefined( ent ) && ent.owner != self )
        {
            ent showtoplayer( self );
            ent enableplayeruse( self );
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xf080929e, Offset: 0xaae4
// Size: 0x2
function setremotedefuse()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x67653917, Offset: 0xaaee
// Size: 0x2
function unsetremotedefuse()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xab20656e, Offset: 0xaaf8
// Size: 0x9
function setalwaysminimap()
{
    player::showminimap();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe10d3b7b, Offset: 0xab09
// Size: 0x9
function unsetalwaysminimap()
{
    player::hideminimap();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xccde1cf2, Offset: 0xab1a
// Size: 0x34
function supersprintkillrefresh_init()
{
    level._effect[ "super_sprint_refresh" ] = loadfxasset( "vfx_iw8_mp_perk_hustle" );
    level._effect[ "super_sprint_refresh_night" ] = loadfxasset( "vfx_iw8_mp_perk_hustle_night" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xc0a6565b, Offset: 0xab56
// Size: 0x30
function supersprintkillrefresh_onkill()
{
    sprintfraction = self getsprintmeterfraction();
    
    if ( sprintfraction < 1 )
    {
        perks::activateperk( "specialty_super_sprint_kill_refresh" );
        self refreshsprinttime();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x8ada3274, Offset: 0xab8e
// Size: 0x13
function setgasgrenaderesist()
{
    if ( player::isreallyalive() )
    {
        return;
    }
    
    gas_grenade::gas_updateplayereffects();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x82c4780a, Offset: 0xaba9
// Size: 0x13
function unsetgasgrenaderesist()
{
    if ( player::isreallyalive() )
    {
        return;
    }
    
    gas_grenade::gas_updateplayereffects();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x1ffdbb35, Offset: 0xabc4
// Size: 0x2
function setfastreloadlaunchers()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x36563f8c, Offset: 0xabce
// Size: 0x24
function unsetfastreloadlaunchers()
{
    if ( self.fastreloadlaunchers )
    {
        perk::removeperk( "specialty_fastreload" );
        self.fastreloadlaunchers = undefined;
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x961187fe, Offset: 0xabfa
// Size: 0x147
function markequipment_monitorlook()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_4754e733ad1413f8" );
    flags::gameflagwait( "prematch_done" );
    
    if ( !isdefined( self.markequipmentstate ) )
    {
        self.markequipmentstate = spawnstruct();
        self.markequipmentstate.markingtime = 0;
        self.markequipmentstate.markingent = undefined;
        self.markequipmentstate.markedents = [];
        self.markequipmentstate.markedentindex = 0;
        self.markequipmentstate.pastmarkedents = [];
        self.markequipmentstate.pastmarkedentindex = 0;
    }
    
    while ( true )
    {
        self waittill( #"marks_target_changed", ent );
        startmarking = isdefined( ent ) && !isdefined( self.markequipmentstate.markingent );
        self.markequipmentstate.markingent = ent;
        self.markequipmentstate.markingtime = 0;
        
        if ( startmarking )
        {
            thread markequipment_updatestate();
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x1debfeb5, Offset: 0xad49
// Size: 0x4d6
function markequipment_updatestate()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_4754e733ad1413f8" );
    lasttime = gettime();
    maxdist = 0;
    
    if ( self entityhasmark( #"air_killstreak", self.markequipmentstate.markingent ) )
    {
        maxdist = getdvarint( @"perk_see_air_killstreak_distance" );
    }
    else if ( self entityhasmark( #"killstreak", self.markequipmentstate.markingent ) )
    {
        maxdist = getdvarint( @"perk_see_killstreak_distance" );
    }
    else if ( self entityhasmark( #"equipment", self.markequipmentstate.markingent ) )
    {
        maxdist = getdvarint( @"perk_see_equipment_distance" );
    }
    else
    {
        assert( 0, "<dev string:xc7>" );
    }
    
    maxdistsqrd = maxdist * maxdist;
    
    while ( isdefined( self.markequipmentstate.markingent ) && !self.ishacking )
    {
        if ( self entitymarkfilteredin( self.markequipmentstate.markingent ) )
        {
            break;
        }
        
        if ( self.vehicle == self.markequipmentstate.markingent )
        {
            break;
        }
        
        if ( vehicle_occupancy::function_3080323254ba6900( self ) && !self isinvehicleleanout() )
        {
            break;
        }
        
        if ( distancesquared( self.origin, self.markequipmentstate.markingent.origin ) > maxdistsqrd )
        {
            break;
        }
        
        currenttime = gettime();
        deltatime = currenttime - lasttime;
        self.markequipmentstate.markingtime += deltatime;
        
        if ( !arraycontains( self.markequipmentstate.markedents, self.markequipmentstate.markingent ) )
        {
            if ( player::isplayerads() )
            {
                markindex = self.markequipmentstate.markedentindex;
                ent = self.markequipmentstate.markedents[ markindex ];
                
                if ( isdefined( ent ) )
                {
                    ent filterinplayermarks( undefined );
                    outlinehelper_updateentityoutline( ent );
                }
                
                if ( level.teambased )
                {
                    self.markequipmentstate.markingent filterinplayermarks( self.team );
                }
                else
                {
                    self.markequipmentstate.markingent filterinplayermarks( self );
                }
                
                outlinehelper_updateentityoutline( self.markequipmentstate.markingent );
                self playlocalsound( "iw8_mp_perk_tactical_recon_marked" );
                
                if ( level.teambased && vehicle_compass::instance_is_registered( self.markequipmentstate.markingent ) )
                {
                    self.markequipmentstate.markingent.teammarkedfor = self.team;
                    players = teams::getteamdata( self.markequipmentstate.markingent.teammarkedfor, "players" );
                    vehicle_compass::function_f43158fa5698deb9( self.markequipmentstate.markingent, players );
                }
                
                self.markequipmentstate.markedents[ markindex ] = self.markequipmentstate.markingent;
                self.markequipmentstate.markedentindex = ( markindex + 1 ) % 999;
                
                if ( !arraycontains( self.markequipmentstate.pastmarkedents, self.markequipmentstate.markingent ) )
                {
                    killstreaks::givescoreformarktarget( 1 );
                    self.markequipmentstate.pastmarkedents[ self.markequipmentstate.pastmarkedentindex ] = self.markequipmentstate.markingent;
                    self.markequipmentstate.pastmarkedentindex++;
                }
                else
                {
                    killstreaks::givescoreformarktarget( 0 );
                }
                
                thread unmarkafterduration( self.markequipmentstate.markingent );
                break;
            }
        }
        
        lasttime = currenttime;
        waitframe();
    }
    
    if ( !self.ishacking )
    {
        self setclientomnvar( "ui_securing", 0 );
        self setclientomnvar( "ui_securing_progress", 0 );
    }
    
    self.markequipmentstate.markingent = undefined;
    self.markequipmentstate.markingtime = 0;
}

// Namespace perkfunctions
// Params 1
// Checksum 0x83f8657e, Offset: 0xb227
// Size: 0x6f
function unmarkafterduration( markedent )
{
    level endon( #"game_ended" );
    self endon( #"hash_4754e733ad1413f8" );
    self endon( "unmarkEnt_" + self getentitynumber() );
    markedent endon( #"death" );
    timeoutduration = getdvarint( @"perk_mark_equipment_duration" );
    utility::waittill_any_timeout_no_endon_death( timeoutduration, "disconnect" );
    unmarkent( markedent );
}

// Namespace perkfunctions
// Params 1
// Checksum 0x6c015932, Offset: 0xb29e
// Size: 0xb3
function unmarkent( markedent )
{
    markedent filterinplayermarks( undefined );
    
    if ( isdefined( markedent.teammarkedfor ) )
    {
        if ( level.teambased && vehicle_compass::instance_is_registered( markedent ) )
        {
            players = teams::getteamdata( markedent.teammarkedfor, "players" );
            vehicle_compass::function_f43158fa5698deb9( markedent, players );
        }
        
        markedent.teammarkedfor = undefined;
    }
    
    if ( isdefined( self ) )
    {
        self.markequipmentstate.markedents = arrayremove( self.markequipmentstate.markedents, markedent );
        markedent notify( "unmarkEnt_" + self getentitynumber() );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x93a812dd, Offset: 0xb359
// Size: 0x1d
function setmarkequipment()
{
    if ( !level.teambased )
    {
        return;
    }
    
    self enabletargetmarks();
    thread markequipment_monitorlook();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x79c155b0, Offset: 0xb37e
// Size: 0xc2
function unsetmarkequipment()
{
    if ( !level.teambased )
    {
        return;
    }
    
    if ( isdefined( self.markequipmentstate ) )
    {
        foreach ( ent in self.markequipmentstate.markedents )
        {
            if ( isdefined( ent ) )
            {
                unmarkent( ent );
            }
        }
    }
    
    self.markequipmentstate = undefined;
    self disabletargetmarks();
    self notify( #"hash_4754e733ad1413f8" );
}

// Namespace perkfunctions
// Params 1
// Checksum 0xde9de593, Offset: 0xb448
// Size: 0x38
function getchildoutlineents( ent )
{
    if ( !isdefined( ent ) )
    {
        return [];
    }
    
    if ( !isdefined( ent.childoutlineents ) )
    {
        return [ ent ];
    }
    
    return ent.childoutlineents;
}

// Namespace perkfunctions
// Params 2
// Checksum 0xee266f2c, Offset: 0xb489
// Size: 0x1e
function outlinehelper_getallplayers( ent, outlinedata )
{
    return level.players;
}

// Namespace perkfunctions
// Params 1
// Checksum 0xbb28aa76, Offset: 0xb4b0
// Size: 0xe, Type: bool
function outlinehelper_validplayer( player )
{
    return true;
}

// Namespace perkfunctions
// Params 1
// Checksum 0x7bd57f6e, Offset: 0xb4c7
// Size: 0xb2
function outlinehelper_verifydata( outlinedata )
{
    assert( isdefined( outlinedata ) );
    
    if ( !isdefined( outlinedata.getplayers ) )
    {
        outlinedata.getplayers = &outlinehelper_getallplayers;
    }
    
    if ( !isdefined( outlinedata.validplayer ) )
    {
        outlinedata.validplayer = &outlinehelper_validplayer;
    }
    
    if ( !isdefined( outlinedata.hudoutlineassetname ) )
    {
        outlinedata.hudoutlineassetname = "spotter_notarget";
    }
    
    if ( !isdefined( outlinedata.prioritygroup ) )
    {
        outlinedata.prioritygroup = "perk";
    }
    
    if ( !isdefined( outlinedata.waittime ) )
    {
        outlinedata.waittime = 0.1;
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0x48bb983b, Offset: 0xb581
// Size: 0x36
function outlinehelper_updateentityoutline( ent )
{
    if ( isdefined( ent ) )
    {
        entitynum = ent getentitynumber();
        outlinehelper_disableentityoutline( entitynum );
        outlinehelper_enableentityoutline( ent );
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0xd108d073, Offset: 0xb5bf
// Size: 0x448
function outlinehelper_enableentityoutline( ent )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    entitynum = ent getentitynumber();
    entitydata = self.entityoutlines[ entitynum ];
    
    if ( isdefined( entitydata ) )
    {
        return;
    }
    
    outlinedata = undefined;
    
    if ( self entitymarkfilteredin( ent ) )
    {
        outlinedata = spawnstruct();
        outlinedata.prioritygroup = "perk_superior";
        outlinedata.hudoutlineassetname = "spotter_target";
        outlinehelper_verifydata( outlinedata );
    }
    
    bundle = self.var_f547ec965235d71a ?? level.perkbundles[ level.gamemodebundle.var_82a98650f6df937e ];
    ismarked = self entitymarkfilteredin( ent );
    
    if ( self entityhasmark( #"air_killstreak", ent ) )
    {
        if ( !isdefined( ent.model ) )
        {
            return;
        }
        
        outlinedata = spawnstruct();
        
        if ( ismarked )
        {
            outlinedata.prioritygroup = "perk_superior";
            outlinedata.hudoutlineassetname = bundle.var_b23a22e7faf06c32 ?? "spotter_target_killstreak_air";
        }
        else
        {
            outlinedata.prioritygroup = "perk";
            outlinedata.hudoutlineassetname = bundle.var_af90df32a92766cd ?? "spotter_notarget_killstreak_air";
        }
        
        outlinehelper_verifydata( outlinedata );
    }
    else if ( self entityhasmark( #"killstreak", ent ) )
    {
        if ( !isdefined( ent.model ) )
        {
            return;
        }
        
        outlinedata = spawnstruct();
        
        if ( ismarked )
        {
            outlinedata.prioritygroup = "perk_superior";
            outlinedata.hudoutlineassetname = bundle.var_c6cabf9b368038db ?? "spotter_target_killstreak";
        }
        else
        {
            outlinedata.prioritygroup = "perk";
            outlinedata.hudoutlineassetname = bundle.var_d0e792802af67048 ?? "spotter_notarget_killstreak";
        }
        
        outlinehelper_verifydata( outlinedata );
    }
    else if ( self entityhasmark( #"equipment", ent ) )
    {
        outlinedata = spawnstruct();
        
        if ( ismarked )
        {
            outlinedata.prioritygroup = "perk_superior";
            outlinedata.hudoutlineassetname = bundle.var_6086d3a2d535eb59 ?? "spotter_target_equipment";
        }
        else
        {
            outlinedata.prioritygroup = "perk";
            outlinedata.hudoutlineassetname = bundle.var_b5f2b371930434fa ?? "spotter_notarget_equipment";
        }
        
        outlinehelper_verifydata( outlinedata );
    }
    
    if ( isdefined( outlinedata ) )
    {
        if ( outlinedata.prioritygroup )
        {
            outlinedata.prioritygroup = getxhash( outlinedata.prioritygroup );
        }
        
        entitydata = spawnstruct();
        self.entityoutlines[ entitynum ] = entitydata;
        entitydata.list = [];
        entitydata.ent = ent;
        childents = getchildoutlineents( ent );
        
        foreach ( child in childents )
        {
            child outline::hudoutline_add_channel_internal( outlinedata.prioritygroup, outline::outlineprioritygroupmap( outlinedata.prioritygroup ), outlinedata.hudoutlineassetname );
            entoutlineid = outline::outlineenableforplayer( child, self, outlinedata.hudoutlineassetname, outlinedata.prioritygroup );
            outline = spawnstruct();
            outline.ent = child;
            outline.id = entoutlineid;
            childnum = child getentitynumber();
            entitydata.list[ childnum ] = outline;
            params = { #targetent:entitydata.ent, #outlineowner:self };
            callback::callback( #"hash_e8b4ec317feca9a8", params );
        }
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0xc62c5dcc, Offset: 0xba0f
// Size: 0xc9
function outlinehelper_disableentityoutline( entnum )
{
    if ( isdefined( entnum ) )
    {
        entitydata = self.entityoutlines[ entnum ];
        
        if ( isdefined( entitydata ) )
        {
            foreach ( outline in entitydata.list )
            {
                outline::outlinedisable( outline.id, outline.ent );
            }
            
            self.entityoutlines[ entnum ] = undefined;
        }
    }
}

// Namespace perkfunctions
// Params 2
// Checksum 0x56f9f27b, Offset: 0xbae0
// Size: 0xb7
function markedentities_removeentsbyindex( entarray, var_c2e0e7a4aa9c1eda )
{
    resultarray = [];
    
    foreach ( ent in entarray )
    {
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        entnum = ent getentitynumber();
        
        if ( !arraycontains( var_c2e0e7a4aa9c1eda, entnum ) )
        {
            resultarray[ resultarray.size ] = ent;
        }
    }
    
    return resultarray;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x465f4222, Offset: 0xbba0
// Size: 0x24a
function markedentities_think()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self.entityoutlines = [];
    
    while ( true )
    {
        self waittill( #"marks_changed", var_ce9009fa10727dba, var_86c56dba059eb666, var_1ee03bf8ec82dfac );
        
        if ( isdefined( var_ce9009fa10727dba ) )
        {
            foreach ( removedentindex in var_ce9009fa10727dba )
            {
                outlinehelper_disableentityoutline( removedentindex );
            }
            
            if ( isdefined( self.markequipmentstate ) )
            {
                self.markequipmentstate.markedents = markedentities_removeentsbyindex( self.markequipmentstate.markedents, var_ce9009fa10727dba );
                
                if ( self.markequipmentstate.markedentindex > self.markequipmentstate.markedents.size )
                {
                    self.markequipmentstate.markedentindex = self.markequipmentstate.markedents.size;
                }
            }
        }
        
        if ( isdefined( var_86c56dba059eb666 ) )
        {
            foreach ( changedentindex in var_86c56dba059eb666 )
            {
                outlinehelper_disableentityoutline( changedentindex );
            }
        }
        
        if ( isdefined( var_1ee03bf8ec82dfac ) )
        {
            foreach ( addedent in var_1ee03bf8ec82dfac )
            {
                outlinehelper_enableentityoutline( addedent );
            }
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x6d02e553, Offset: 0xbdf2
// Size: 0x2
function setbettermissionrewards()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x41758d07, Offset: 0xbdfc
// Size: 0x2
function unsetbettermissionrewards()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0xd3f51471, Offset: 0xbe06
// Size: 0x17
function setspecialistbonus()
{
    if ( !isbrgamemode() )
    {
        self setclientomnvar( "ui_specialist_bonus_active", 1 );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa082473d, Offset: 0xbe25
// Size: 0x16
function unsetspecialistbonus()
{
    if ( !isbrgamemode() )
    {
        self setclientomnvar( "ui_specialist_bonus_active", 0 );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x84a59a95, Offset: 0xbe43
// Size: 0x14
function setthirdpersonmode()
{
    self.perkthirdperson = 1;
    class::setthirdpersonview();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x106003a2, Offset: 0xbe5f
// Size: 0x20
function function_1a8b6c7b9a39972()
{
    self.perkthirdperson = undefined;
    
    if ( !level.gameended )
    {
        class::setthirdpersonview();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb70252e, Offset: 0xbe87
// Size: 0x19
function setundying()
{
    self notify( #"hash_f935aadcccc8d627" );
    self.undying = 1;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x8d008304, Offset: 0xbea8
// Size: 0x18
function unsetundying()
{
    self notify( #"undyingend" );
    self.undying = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa6c86cbe, Offset: 0xbec8
// Size: 0xf
function setbulletsuppress()
{
    self setclientomnvar( "ui_overcharge", 2 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xd8da23b, Offset: 0xbedf
// Size: 0xe
function unsetbulletsuppress()
{
    self setclientomnvar( "ui_overcharge", 0 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa0462d9, Offset: 0xbef5
// Size: 0x9
function setarmored()
{
    thread function_9d38ed5c13aaaada();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x102cf0d3, Offset: 0xbf06
// Size: 0x2
function unsetarmored()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x8149cd90, Offset: 0xbf10
// Size: 0x1a
function function_9d38ed5c13aaaada()
{
    self endon( #"death_or_disconnect" );
    waitframe();
    armor::givestartingarmor( 50, 1 );
}

// Namespace perkfunctions
// Params 1
// Checksum 0x5b3ce554, Offset: 0xbf32
// Size: 0x50
function function_2c76c64834f172ac( perk )
{
    if ( !level.useperkpackage )
    {
        return;
    }
    
    switch ( perk )
    {
        case #"hash_53b0051b1bb90222":
            function_bfc964d58208e7e3();
            break;
        case #"hash_f3b391e08ecec3c1":
            function_b26e026be0d02c0e();
            break;
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe7961c38, Offset: 0xbf8a
// Size: 0x5f, Type: bool
function function_a8f6f4b741b7d9ec()
{
    super = supers_mp::getcurrentsuper();
    
    if ( !isdefined( super ) )
    {
        return false;
    }
    
    if ( !isdefined( super.basepoints ) )
    {
        return false;
    }
    
    if ( !isdefined( super.extrapoints ) )
    {
        return false;
    }
    
    if ( !isdefined( super.staticdata.pointsneeded ) )
    {
        return false;
    }
    
    return true;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x95aee8, Offset: 0xbff2
// Size: 0x96
function function_bfc964d58208e7e3()
{
    if ( !function_a8f6f4b741b7d9ec() )
    {
        return;
    }
    
    currentpoints = supers_mp::issuperready() || supers_mp::issuperinuse() ? supers_mp::getsuperpointsneeded() : supers_mp::getcurrentsuperpoints();
    maxpoints = supers_mp::getsuperpointsneeded();
    supers_mp::givesuperpoints( supers_mp::getsuperpointsneeded() );
    self.overclockcharge = clamp( currentpoints, 0, maxpoints );
    
    if ( !isdefined( self.var_ad3d5ed8f39cd225 ) )
    {
        self.var_ad3d5ed8f39cd225 = 1;
    }
    
    self.var_ad3d5ed8f39cd225 += 1;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x46b1f806, Offset: 0xc090
// Size: 0x17
function function_b26e026be0d02c0e()
{
    triggerportableradarping( self.origin, self, 3000, 3000 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x5948a196, Offset: 0xc0af
// Size: 0x26
function function_d528d96ec5dc040()
{
    self.pers[ "hasEarnedHardlineStreak" ] = 0;
    killstreaks::givestreakpoints( #"perk_package_activate", 3, 0 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xaca75009, Offset: 0xc0dd
// Size: 0x82
function function_4be34403fbdf958a()
{
    equipment = self getweaponslistoffhands();
    
    foreach ( item in equipment )
    {
        self givemaxammo( item );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x726c51a1, Offset: 0xc167
// Size: 0x13
function function_2ef7527009eba08()
{
    killstreaks::awardkillstreak( "scrambler_drone_guard", "other" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x992f84df, Offset: 0xc182
// Size: 0xd1
function function_f82fcdb61151a80f()
{
    playertargets = utility::function_1b1340a94b43b874( self.origin, 3000 );
    outlinedata = snapshot_grenade::snapshot_grenade_createoutlinedata( self, self.origin );
    
    foreach ( player in playertargets )
    {
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( !player_utility::playersareenemies( self, player ) )
        {
            continue;
        }
        
        snapshot_grenade::snapshot_grenade_applysnapshot( player, self, outlinedata, 2500, 1 );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe13a04b4, Offset: 0xc25b
// Size: 0x2f
function function_4190421520933e95()
{
    if ( isdefined( self.perks[ "specialty_armored" ] ) && self getammocount( "bandage_br" ) < 1 )
    {
        armor::function_164c824617d7e8d7( 1 );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x89b2befe, Offset: 0xc292
// Size: 0x9b
function setanteup()
{
    self notify( #"hash_4747242a38af6a00" );
    self endon( #"hash_4747242a38af6a00" );
    self endon( #"death_or_disconnect" );
    
    if ( self.gettingloadout )
    {
        self waittill( #"giveloadout" );
    }
    
    if ( self.var_55a786dd61f7ab08 )
    {
        return;
    }
    
    bundle = level.perkbundles[ "specialty_ante_up" ];
    points = bundle.var_e22a02bc263271f7 ?? 0;
    waitframe();
    killstreaks::givestreakpoints( "perk", 0, points );
    self.var_55a786dd61f7ab08 = 1;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x128e8d77, Offset: 0xc335
// Size: 0xb7
function unsetanteup()
{
    bundle = level.perkbundles[ "specialty_ante_up" ];
    points = bundle.var_e22a02bc263271f7 ?? 0;
    
    if ( self.var_55a786dd61f7ab08 && isdefined( self.streakpoints ) )
    {
        params = { #scorepoints:-1 * points, #killpoints:0, #type:"perk" };
        callback::callback( #"hash_62785a5e7e758499", params );
        killstreaks::setstreakpoints( self.streakpoints - points );
        killstreaks::updatestreakmeterui();
        self.var_55a786dd61f7ab08 = 0;
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x4820a4d9, Offset: 0xc3f4
// Size: 0xc
function setcombatmedic()
{
    self.var_5244874f5ae962e0 = 0;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x7f52a5e9, Offset: 0xc408
// Size: 0xc
function unsetcombatmedic()
{
    self.var_5244874f5ae962e0 = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe8bf658d, Offset: 0xc41c
// Size: 0x9
function function_dbb41248e5cce834()
{
    thread function_41204405ee6bdb16();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xc8223a3d, Offset: 0xc42d
// Size: 0xb0
function function_d84740731971dc17()
{
    self notify( #"hash_27fb0cb7d5750a2b" );
    
    if ( self.var_2cde182e1c9a34ac.size > 0 )
    {
        trackingarray = self.var_2cde182e1c9a34ac;
        self.var_2cde182e1c9a34ac = [];
        
        foreach ( player in trackingarray )
        {
            player notify( #"disable_high_gain_effect" );
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xeafdbc99, Offset: 0xc4e5
// Size: 0x3b1
function function_41204405ee6bdb16()
{
    self endon( #"disconnect" );
    self endon( #"hash_27fb0cb7d5750a2b" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self.var_2cde182e1c9a34ac ) )
    {
        self.var_2cde182e1c9a34ac = [];
    }
    
    if ( !level.teambased )
    {
        return;
    }
    
    var_2c5c44f5f4f8608a = isdefined( self.perks[ "specialty_cct_vest" ] );
    
    while ( true )
    {
        if ( !player::isreallyalive( self ) )
        {
            if ( self.var_2cde182e1c9a34ac.size > 0 )
            {
                trackingarray = self.var_2cde182e1c9a34ac;
                self.var_2cde182e1c9a34ac = [];
                
                foreach ( player in trackingarray )
                {
                    player notify( #"disable_high_gain_effect" );
                }
            }
            
            wait 0.2;
            continue;
        }
        
        trackingarray = self.var_2cde182e1c9a34ac;
        targetallies = getplayersinradius( self.origin, 700, undefined, undefined, self, self.team );
        self.var_2cde182e1c9a34ac = targetallies;
        var_22529fed5740c96e = var_2c5c44f5f4f8608a;
        
        foreach ( player in trackingarray )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( arraycontains( targetallies, player ) )
            {
                continue;
            }
            
            player notify( #"disable_high_gain_effect" );
        }
        
        foreach ( player in targetallies )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !var_22529fed5740c96e && isdefined( player.perks[ "specialty_cct_vest" ] ) )
            {
                var_22529fed5740c96e = 1;
            }
            
            if ( arraycontains( trackingarray, player ) )
            {
                continue;
            }
            
            if ( !isdefined( player.perks[ "specialty_high_gain_antenna" ] ) && !isdefined( player.perks[ "specialty_cct_vest" ] ) )
            {
                player perk::giveperk( "specialty_expanded_minimap" );
            }
            
            player thread function_544740880d076a08( self );
        }
        
        self.sharingacousticsensor = var_22529fed5740c96e;
        
        foreach ( player in targetallies )
        {
            hasacousticsensor = isdefined( player.perks[ "specialty_acousticSensor" ] );
            var_254c5e6858061fb9 = isdefined( player.perks[ "specialty_cct_vest" ] );
            
            if ( var_22529fed5740c96e && !hasacousticsensor )
            {
                player perk::giveperk( "specialty_acousticSensor" );
                continue;
            }
            
            if ( !var_22529fed5740c96e && hasacousticsensor && !var_254c5e6858061fb9 )
            {
                player perk::removeperk( "specialty_acousticSensor" );
            }
        }
        
        wait 0.2;
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0xb2868a95, Offset: 0xc89e
// Size: 0xde
function function_75c3783d2f6770a( equipment )
{
    if ( !isdefined( self.var_c9c85537b8609fa6 ) )
    {
        self.var_c9c85537b8609fa6 = [];
    }
    
    self.var_c9c85537b8609fa6 = arraycombineunique( self.var_c9c85537b8609fa6, [ equipment ] );
    
    if ( !isdefined( self.var_7eca6c66e513b2dd[ "specialty_signal_jammer" ] ) )
    {
        return;
    }
    
    foreach ( player in self.var_7eca6c66e513b2dd[ "specialty_signal_jammer" ] )
    {
        objidpoolmanager::objective_playermask_addshowplayer( equipment.signaljammerobjectiveid, player );
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0x7cba3f32, Offset: 0xc984
// Size: 0xeb
function function_50c792db42de8362( equipment )
{
    if ( isdefined( self.var_c9c85537b8609fa6 ) && isdefined( equipment ) )
    {
        self.var_c9c85537b8609fa6 = arrayremove( self.var_c9c85537b8609fa6, equipment );
    }
    
    if ( !isdefined( self.var_7eca6c66e513b2dd[ "specialty_signal_jammer" ] ) )
    {
        return;
    }
    
    foreach ( player in self.var_7eca6c66e513b2dd[ "specialty_signal_jammer" ] )
    {
        if ( isdefined( equipment ) && isdefined( equipment.signaljammerobjectiveid ) )
        {
            objidpoolmanager::objective_playermask_hidefrom( equipment.signaljammerobjectiveid, player );
        }
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0x9e06ccb8, Offset: 0xca77
// Size: 0xb4
function function_8b22ba7733b2676b( var_c9aa39fc83b96db8 )
{
    if ( !isdefined( self.var_c9c85537b8609fa6 ) )
    {
        return;
    }
    
    foreach ( equipment in self.var_c9c85537b8609fa6 )
    {
        if ( isdefined( equipment ) && isdefined( equipment.signaljammerobjectiveid ) )
        {
            objidpoolmanager::objective_playermask_addshowplayer( equipment.signaljammerobjectiveid, var_c9aa39fc83b96db8 );
        }
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0x58f8bd91, Offset: 0xcb33
// Size: 0xa5
function function_afc2673c79c65116( equipmentlist )
{
    if ( !isdefined( equipmentlist ) )
    {
        return;
    }
    
    foreach ( equipment in equipmentlist )
    {
        if ( isdefined( equipment ) && isdefined( equipment.signaljammerobjectiveid ) )
        {
            objidpoolmanager::objective_playermask_hidefrom( equipment.signaljammerobjectiveid, self );
        }
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0x26507b0d, Offset: 0xcbe0
// Size: 0x2b3
function function_544740880d076a08( sourceplayer )
{
    self notify( #"hash_29f1d707ab96e5b1" );
    self endon( #"hash_29f1d707ab96e5b1" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_445522ad710f05c5 ) )
    {
        self.var_445522ad710f05c5 = [];
    }
    
    self.var_445522ad710f05c5[ self.var_445522ad710f05c5.size ] = sourceplayer;
    var_2c5c44f5f4f8608a = isdefined( self.perks[ "specialty_cct_vest" ] );
    var_10f2855fc22a8bec = isdefined( self.perks[ "specialty_high_gain_antenna" ] );
    
    while ( true )
    {
        result = utility::waittill_any_return( "death_or_disconnect", "disable_high_gain_effect" );
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( !isdefined( result ) || result == "death_or_disconnect" )
        {
            if ( !var_2c5c44f5f4f8608a && !var_10f2855fc22a8bec )
            {
                perk::removeperk( "specialty_expanded_minimap" );
            }
            
            if ( !var_2c5c44f5f4f8608a )
            {
                perk::removeperk( "specialty_acousticSensor" );
            }
            
            self.var_445522ad710f05c5 = [];
            return;
        }
        
        if ( result == "disable_high_gain_effect" )
        {
            keepacousticsensor = 0;
            
            if ( self.var_445522ad710f05c5.size == 1 )
            {
                if ( !var_2c5c44f5f4f8608a && !var_10f2855fc22a8bec )
                {
                    perk::removeperk( "specialty_expanded_minimap" );
                }
                
                if ( !var_2c5c44f5f4f8608a )
                {
                    perk::removeperk( "specialty_acousticSensor" );
                }
                
                self.var_445522ad710f05c5 = [];
                return;
            }
            
            if ( isdefined( self ) && isdefined( self.var_2cde182e1c9a34ac ) )
            {
                foreach ( player in self.var_445522ad710f05c5 )
                {
                    if ( !( isdefined( player ) && isdefined( player.var_2cde182e1c9a34ac ) ) )
                    {
                        continue;
                    }
                    
                    if ( arraycontains( player.var_2cde182e1c9a34ac, self ) && isalive( player ) )
                    {
                        if ( player.sharingacousticsensor )
                        {
                            keepacousticsensor = 1;
                        }
                        
                        continue;
                    }
                    
                    self.var_445522ad710f05c5 = arrayremove( self.var_445522ad710f05c5, player );
                }
                
                if ( self.var_445522ad710f05c5.size == 0 )
                {
                    if ( !var_2c5c44f5f4f8608a && !var_10f2855fc22a8bec )
                    {
                        perk::removeperk( "specialty_expanded_minimap" );
                    }
                    
                    if ( !var_2c5c44f5f4f8608a )
                    {
                        perk::removeperk( "specialty_acousticSensor" );
                    }
                    
                    return;
                }
                
                if ( !keepacousticsensor && !var_2c5c44f5f4f8608a && isdefined( self.perks[ "specialty_acousticSensor" ] ) )
                {
                    perk::removeperk( "specialty_acousticSensor" );
                }
            }
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb07617f2, Offset: 0xce9b
// Size: 0x64
function setlrdetector()
{
    if ( getdvarint( @"hash_a93a2419d7580413", 0 ) == 1 )
    {
        return;
    }
    
    self.var_9a75394b90838539 = 0;
    self.lrdetectorstate = 0;
    function_88b7e96ae06e67dd( 0 );
    function_332870c27adf18fb( 0 );
    playernum = self getentitynumber();
    level.lrdetector_players[ playernum ] = self;
    self.var_f3ec703c3d489cc4 = [];
}

// Namespace perkfunctions
// Params 0
// Checksum 0x3693f07a, Offset: 0xcf07
// Size: 0x9
function unsetlrdetector()
{
    thread clearlrdetector();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xda872828, Offset: 0xcf18
// Size: 0x7a
function clearlrdetector()
{
    self endon( #"disconnect" );
    self.var_9a75394b90838539 = undefined;
    self.lrdetectorstate = undefined;
    self.lrdetectorsource = undefined;
    self.var_f3ec703c3d489cc4 = undefined;
    self.var_62ec24b9b4ae896f = undefined;
    self notify( #"removelrdetector" );
    playernum = self getentitynumber();
    level.lrdetector_players[ playernum ] = undefined;
    waitframe();
    function_88b7e96ae06e67dd( 0 );
    function_332870c27adf18fb( 0 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xd9cf0f60, Offset: 0xcf9a
// Size: 0x37
function setsignaljammer()
{
    playernum = self getentitynumber();
    level.signaljammer_players[ playernum ] = self;
    level.delayminetime = 1.6;
    function_5d1ebac53638d86f( 0 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x40fef65f, Offset: 0xcfd9
// Size: 0x27
function unsetsignaljammer()
{
    playernum = self getentitynumber();
    level.signaljammer_players[ playernum ] = undefined;
    function_5d1ebac53638d86f( 0 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe094ee01, Offset: 0xd008
// Size: 0x33
function function_a38118f90c3fdb8()
{
    if ( !isdefined( self.var_8f4684cdf987fd02 ) )
    {
        self.var_8f4684cdf987fd02 = 1;
        return;
    }
    
    self.var_8f4684cdf987fd02 += 1;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xdcd9afe4, Offset: 0xd043
// Size: 0x42
function function_20920d82ddd7f555()
{
    if ( !isdefined( self.var_8f4684cdf987fd02 ) )
    {
        return;
    }
    
    if ( self.var_8f4684cdf987fd02 > 1 )
    {
        self.var_8f4684cdf987fd02 -= 1;
        return;
    }
    
    self.var_8f4684cdf987fd02 = undefined;
}

// Namespace perkfunctions
// Params 4
// Checksum 0x753c8fd9, Offset: 0xd08d
// Size: 0x16e
function function_a682fbbdf1856e15( pickupent, fromkiosk, var_6432f32bb6fece8b, backpackequip )
{
    var_846fe83b2ae66e94 = armor::getarmorhealth();
    var_a8cace2fa46c6fd9 = level.var_1bfbe247e8d32b1b;
    maxarmoramount = self.maxarmorhealth;
    
    if ( pickupent.count > 0 && var_846fe83b2ae66e94 < maxarmoramount )
    {
        platesneeded = 0;
        var_aa9dc5dc49206268 = maxarmoramount - var_846fe83b2ae66e94;
        
        if ( var_aa9dc5dc49206268 <= var_a8cace2fa46c6fd9 )
        {
            platesneeded = 1;
        }
        else
        {
            platesneeded = ceil( var_aa9dc5dc49206268 / var_a8cace2fa46c6fd9 );
        }
        
        if ( platesneeded == pickupent.count )
        {
            pickupent.count = 0;
            armor::setarmorhealth( maxarmoramount );
            return 0;
        }
        else if ( platesneeded < pickupent.count )
        {
            pickupent.count -= platesneeded;
            armor::setarmorhealth( maxarmoramount );
            pickupremains = br_pickups::takeequipmentpickup( pickupent, fromkiosk, var_6432f32bb6fece8b, backpackequip );
            return pickupremains;
        }
        else
        {
            newarmoramount = min( pickupent.count * var_a8cace2fa46c6fd9, maxarmoramount );
            pickupent.count = 0;
            armor::setarmorhealth( newarmoramount );
            return 0;
        }
        
        return;
    }
    
    pickupremains = br_pickups::takeequipmentpickup( pickupent, fromkiosk, var_6432f32bb6fece8b, backpackequip );
    return pickupremains;
}

// Namespace perkfunctions
// Params 1
// Checksum 0xc284189b, Offset: 0xd203
// Size: 0xb1, Type: bool
function function_4cd566e687b2f810( armor )
{
    var_846fe83b2ae66e94 = armor::getarmorhealth();
    var_a8cace2fa46c6fd9 = level.var_1bfbe247e8d32b1b;
    maxarmoramount = self.maxarmorhealth;
    
    if ( var_846fe83b2ae66e94 < maxarmoramount )
    {
        platesneeded = 0;
        var_aa9dc5dc49206268 = maxarmoramount - var_846fe83b2ae66e94;
        
        if ( var_aa9dc5dc49206268 <= var_a8cace2fa46c6fd9 )
        {
            platesneeded = 1;
        }
        else
        {
            platesneeded = ceil( var_aa9dc5dc49206268 / var_a8cace2fa46c6fd9 );
        }
        
        if ( platesneeded == 1 )
        {
            armor::setarmorhealth( maxarmoramount );
            return true;
        }
        else
        {
            newarmoramount = min( var_a8cace2fa46c6fd9, maxarmoramount );
            armor::setarmorhealth( newarmoramount );
            return true;
        }
    }
    
    return false;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x5d0e4617, Offset: 0xd2bd
// Size: 0x51
function setdurability()
{
    healthscale = getdvarfloat( @"hash_295c99a0f67c5f7d", 1.5 );
    self.maxhealth = int( healthscale * getdvarfloat( @"scr_player_maxhealth", 150 ) );
    self.health = self.maxhealth;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe5da83e9, Offset: 0xd316
// Size: 0x1a
function unsetdurability()
{
    self.maxhealth = getdvarfloat( @"scr_player_maxhealth", 150 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xc1c9d607, Offset: 0xd338
// Size: 0x5c
function setsuperspeed()
{
    speedboost = getdvarfloat( @"hash_94084550cb0f64e7", 2 );
    self.var_54ae9e78b6a23b31 = self.movespeedscaler;
    self.movespeedscaler = speedboost;
    common::function_a0f5c85d465c5f0a( "moveSpeedScaler", self.movespeedscaler - 1 );
    weapons::updatemovespeedscale();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x39431325, Offset: 0xd39c
// Size: 0x3d
function unsetsuperspeed()
{
    self.movespeedscaler = self.var_54ae9e78b6a23b31;
    common::function_a0f5c85d465c5f0a( "moveSpeedScaler", self.var_54ae9e78b6a23b31 - 1 );
    self.var_54ae9e78b6a23b31 = undefined;
    weapons::updatemovespeedscale();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa379f712, Offset: 0xd3e1
// Size: 0xd
function setoverwatch()
{
    self.radarshowenemydirection = 1;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x4a72b5ea, Offset: 0xd3f6
// Size: 0x5b
function unsetoverwatch()
{
    if ( isdefined( level.activeadvanceduavs ) )
    {
        if ( level.var_f3d1cde89907a07a && level.activeadvanceduavs[ self.sessionsquadid ] > 0 )
        {
            return;
        }
        else if ( level.activeadvanceduavs[ self.team ] > 0 )
        {
            return;
        }
    }
    
    self.radarshowenemydirection = 0;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xaf272d35, Offset: 0xd459
// Size: 0xd
function function_ad8c1836182c9fd4()
{
    self setgrenadethrowscale( 1.15 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x447c024, Offset: 0xd46e
// Size: 0xa
function function_753de29c5a277a37()
{
    self setgrenadethrowscale( 1 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x6f22a5be, Offset: 0xd480
// Size: 0x2
function function_72fbe49594529b4a()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x5f9511d0, Offset: 0xd48a
// Size: 0x2
function function_a43e4b2108c33369()
{
    
}

// Namespace perkfunctions
// Params 0
// Checksum 0x443f6bbe, Offset: 0xd494
// Size: 0x25
function function_271ba0f1374e2e9c()
{
    self.radarshowenemydirection = 1;
    
    if ( game_utility::getgametype() == "dmz" )
    {
        level thread overlord::function_e4b131025a62a0f9( self );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xd7f75d47, Offset: 0xd4c1
// Size: 0x7e
function function_854fff275d22cb93()
{
    if ( !( isdefined( self ) && isdefined( self.team ) ) )
    {
        return 0;
    }
    
    if ( game_utility::getgametype() == "dmz" )
    {
        self notify( #"hash_93c1e3a2e9da1586" );
    }
    
    if ( level.var_f3d1cde89907a07a && level.activeadvanceduavs[ self.sessionsquadid ] > 0 )
    {
        return;
    }
    else if ( level.activeadvanceduavs[ self.team ] > 0 )
    {
        return;
    }
    
    self.radarshowenemydirection = 0;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xf9eae615, Offset: 0xd547
// Size: 0xd
function function_454a06381c946fbb()
{
    self.hasplatepouch = 1;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x52af2893, Offset: 0xd55c
// Size: 0xc
function function_4217611c148026a6()
{
    self.hasplatepouch = 0;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xefabbbd9, Offset: 0xd570
// Size: 0xa
function unsettalkinggun()
{
    talking_gun::talkinggun_removeplayer( self );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x912a04b1, Offset: 0xd582
// Size: 0x21
function function_36736e40b14d6fa6()
{
    if ( !getdvarint( @"hash_18bf04d5c5766462" ) )
    {
        return;
    }
    
    talking_gun::function_7240e492db43ecc3( self, "announcer" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x9c88871c, Offset: 0xd5ab
// Size: 0x21
function function_36736d40b14d6d73()
{
    if ( !getdvarint( @"hash_18bf04d5c5766462" ) )
    {
        return;
    }
    
    talking_gun::function_7240e492db43ecc3( self, "robot" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x5975e1af, Offset: 0xd5d4
// Size: 0x21
function function_36736c40b14d6b40()
{
    if ( !getdvarint( @"hash_18bf04d5c5766462" ) )
    {
        return;
    }
    
    talking_gun::function_7240e492db43ecc3( self, "hypeman" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x199870b2, Offset: 0xd5fd
// Size: 0x21
function function_36737340b14d7aa5()
{
    if ( !getdvarint( @"hash_18bf04d5c5766462" ) )
    {
        return;
    }
    
    talking_gun::function_7240e492db43ecc3( self, "blackcell" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe2cacef9, Offset: 0xd626
// Size: 0xf
function function_6b2a299d4c0ef3c6()
{
    talking_gun::function_7240e492db43ecc3( self, "announcer" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x7f5a83a4, Offset: 0xd63d
// Size: 0xf
function function_db94b7f360ebac2d()
{
    talking_gun::function_7240e492db43ecc3( self, "robot" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x47f4bdab, Offset: 0xd654
// Size: 0x1c
function function_17340d217eb1c8ad()
{
    utility::callsharedfunc( #"molotov_shots", #"addplayer", self );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x7c63a513, Offset: 0xd678
// Size: 0x1c
function function_90048b4936a8e84c()
{
    utility::callsharedfunc( #"molotov_shots", #"hash_fd50b15c572cd0d8", self );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x825255a2, Offset: 0xd69c
// Size: 0x9
function setdoublebarrel()
{
    thread function_66c03efcded2baed();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x302a1067, Offset: 0xd6ad
// Size: 0x5e
function function_66c03efcded2baed()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_412bc3b804d90f1f" );
    
    while ( true )
    {
        if ( self getcurrentweaponclipammo() == 1 )
        {
            self.var_1d1e022a5aa5050b = 1;
        }
        else
        {
            self.var_1d1e022a5aa5050b = undefined;
        }
        
        self waittill( #"reload_ammo_added" );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x5e69eabc, Offset: 0xd713
// Size: 0x18
function unsetdoublebarrel()
{
    self notify( #"hash_412bc3b804d90f1f" );
    self.var_1d1e022a5aa5050b = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb35ea472, Offset: 0xd733
// Size: 0xd
function setdivefire()
{
    self setsuit( "rex_divefire" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xd474272a, Offset: 0xd748
// Size: 0xe
function unsetdivefire()
{
    self setsuit( utility::function_f825237e0eda5adf() );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x6de0a225, Offset: 0xd75e
// Size: 0x39
function function_451bb0f2335700f7()
{
    if ( utility::issharedfuncdefined( #"dynamicstance", #"runlogic" ) )
    {
        self [[ utility::getsharedfunc( #"dynamicstance", #"runlogic" ) ]]();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xf9137c0a, Offset: 0xd79f
// Size: 0x39
function function_214dadcb1c3f25a4()
{
    if ( utility::issharedfuncdefined( #"dynamicstance", #"stoplogic" ) )
    {
        self [[ utility::getsharedfunc( #"dynamicstance", #"stoplogic" ) ]]();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x31349158, Offset: 0xd7e0
// Size: 0x14
function function_343e6628f48d83ce()
{
    val::set( "heavySniper", "jog", 0 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xcdd71ce3, Offset: 0xd7fc
// Size: 0x21
function function_66423ea5dee68a31()
{
    self notify( #"hash_7d30d713cb918c55" );
    val::set( "heavySniper", "jog", 1 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x8b6f1503, Offset: 0xd825
// Size: 0x14
function function_fe4bee78e7a77d39()
{
    val::set( "heavyLauncher", "jog", 0 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x1f9ccb2d, Offset: 0xd841
// Size: 0x15
function function_90071494daf5b7de()
{
    val::set( "heavyLauncher", "jog", 1 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x45f25775, Offset: 0xd85e
// Size: 0x14b
function function_50867caa9ef245ea()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_7d30d713cb918c55" );
    
    while ( true )
    {
        self waittill( #"weapon_fired" );
        ads = self playerads();
        stance = self getstance();
        
        if ( ads < 1 && stance != "prone" )
        {
            targetmag = 22 * ( 1 - ads );
            
            if ( stance == "crouch" )
            {
                targetmag *= 0.5;
            }
            
            var_419293d4216a28e = getframeduration() / 490 * targetmag;
            var_d2a5858d74987653 = getframeduration() / 10 * targetmag;
            var_ea1c43d651ee2e5e = self getplayerangles( 1 );
            pushdir = -1 * anglestoforward( var_ea1c43d651ee2e5e );
            
            for ( mag = 0; mag < targetmag ; mag = min( mag, targetmag ) )
            {
                self pushplayervector( pushdir * mag, 0 );
                waitframe();
                mag += var_d2a5858d74987653;
            }
            
            while ( mag > 0 )
            {
                self pushplayervector( pushdir * mag, 0 );
                waitframe();
                mag -= var_419293d4216a28e;
            }
            
            self pushplayervector( ( 0, 0, 0 ), 0 );
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x498bf6e3, Offset: 0xd9b1
// Size: 0xa5
function setnods()
{
    if ( isstring( level.nvgvisionsetoverride ) )
    {
        visionsetnight( level.nvgvisionsetoverride );
    }
    else
    {
        self visionsetnightforplayer( function_31cc474e01dd8f5d() );
        self visionsetthermalforplayer( "flir_2_color_gradient" );
    }
    
    if ( !isdefined( self.pers[ "killstreak_forcedNVGOff" ] ) )
    {
        self.pers[ "killstreak_forcedNVGOff" ] = 0;
    }
    
    thread function_922817bf86d02352( 0 );
    thread function_7e6a077e167989f8( 2 );
    self notifyonplayercommand( "nods_button_down", "+usereload" );
    self notifyonplayercommand( "nods_button_up", "-usereload" );
    self notifyonplayercommand( "nods_kbm_button", "nightvision" );
    thread function_f32c648e4a2aae8f();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xca1fbe3f, Offset: 0xda5e
// Size: 0x72
function unsetnods()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self notify( #"nods_removed" );
    self notifyonplayercommandremove( "nods_button_down", "+usereload" );
    self notifyonplayercommandremove( "nods_button_up", "-usereload" );
    self notifyonplayercommandremove( "nods_kbm_button", "nightvision" );
    
    if ( self.pers[ "useNVG" ] )
    {
        wait 1;
        function_f7f9525ed9be4022();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xca1fccef, Offset: 0xdad8
// Size: 0xe3
function function_31cc474e01dd8f5d()
{
    value = getdvarint( @"hash_35d51fe231a93ba9", 0 );
    visionset = undefined;
    
    switch ( value )
    {
        case 0:
            visionset = "nvg_base_mp";
            break;
        case 1:
            visionset = "flir_2_color_gradient";
            break;
        case 2:
            visionset = "nvg_base_color_nods_jup_test";
            break;
        case 3:
            visionset = "nvg_base_color_nods_jup_test_02";
            break;
        case 4:
            visionset = "nvg_base_color_nods_jup_test_03";
            break;
        case 5:
            visionset = "nvg_base_color_nods_jup_test_04";
            break;
        case 6:
            visionset = "nvg_base_color_nods_jup_test_05";
            break;
        default:
            visionset = "nvg_base_mp";
            break;
    }
    
    return visionset;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x66640d86, Offset: 0xdbc4
// Size: 0x92
function function_f32c648e4a2aae8f()
{
    self endon( #"death_or_disconnect" );
    self endon( #"nods_removed" );
    
    while ( true )
    {
        result = utility::waittill_any_return( "nods_button_down", "nods_kbm_button" );
        
        if ( result == "nods_kbm_button" && !self usinggamepad() )
        {
            function_f7f9525ed9be4022();
            wait 1;
            continue;
        }
        
        if ( result == "nods_button_down" )
        {
            result = utility::waittill_any_timeout( 0.5, "nods_button_up" );
        }
        
        if ( result != "nods_button_up" )
        {
            function_f7f9525ed9be4022();
            wait 1;
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x26550385, Offset: 0xdc5e
// Size: 0x137
function function_f7f9525ed9be4022()
{
    if ( self isonladder() || self ishanging() || self isthrowinggrenade() )
    {
        return;
    }
    
    if ( isstring( level.nvgvisionsetoverride ) )
    {
        visionsetnight( level.nvgvisionsetoverride );
    }
    else
    {
        self visionsetnightforplayer( function_31cc474e01dd8f5d() );
        self visionsetthermalforplayer( "flir_2_color_gradient" );
    }
    
    nodsversion = getdvarint( @"hash_787fb71bbd471c11", 3 );
    
    if ( self.pers[ "useNVG" ] )
    {
        self notify( #"hash_789a752956b97dc2" );
        
        if ( nodsversion == 0 || nodsversion == 3 )
        {
            self nightvisionviewoff();
            thread function_922817bf86d02352( 0 );
            
            if ( nodsversion == 3 )
            {
                thread function_c005e75a5eb656db( 0.5 );
            }
        }
        else if ( nodsversion == 1 )
        {
            player_utility::setthermalvision( 0 );
        }
        
        function_d027c8a5f08a645e();
        return;
    }
    
    thread function_a201e3a0b05f6a62();
    
    if ( nodsversion == 0 || nodsversion == 3 )
    {
        self nightvisionviewon();
        thread function_922817bf86d02352( 1 );
        
        if ( nodsversion == 3 )
        {
            thread nods_outlineplayers( 0.6 );
        }
    }
    else if ( nodsversion == 1 )
    {
        player_utility::setthermalvision( 1, 12, 1000 );
    }
    
    function_d027c8a5f08a645e();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xc0cc9934, Offset: 0xdd9d
// Size: 0x61
function function_d027c8a5f08a645e()
{
    if ( !self.pers[ "useNVG" ] )
    {
        self.pers[ "useNVG" ] = 1;
        return;
    }
    
    if ( self.pers[ "useNVG" ] && !self.pers[ "killstreak_forcedNVGOff" ] )
    {
        self.pers[ "useNVG" ] = 0;
    }
}

// Namespace perkfunctions
// Params 2
// Checksum 0xc27d8604, Offset: 0xde06
// Size: 0x90
function function_7e6a077e167989f8( delay, var_e5a4783c00385874 )
{
    if ( !game[ "flags" ][ "prematch_done" ] )
    {
        flags::gameflagwait( "prematch_done" );
    }
    
    wait delay;
    time = 4;
    
    if ( isdefined( var_e5a4783c00385874 ) && ( isint( var_e5a4783c00385874 ) || isfloat( var_e5a4783c00385874 ) ) )
    {
        time = var_e5a4783c00385874;
    }
    
    if ( self usinggamepad() )
    {
        thread print::tutorialprint( &"jup_perks/nods_press_to_use", time );
        return;
    }
    
    thread print::tutorialprint( &"jup_perks/nods_press_to_use_kb", time );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x495a0c0b, Offset: 0xde9e
// Size: 0x81
function function_a201e3a0b05f6a62()
{
    self endon( #"hash_789a752956b97dc2" );
    self waittill( #"death_or_disconnect" );
    self notify( #"hash_2ecb63dc4b3e862b" );
    nodsversion = getdvarint( @"hash_787fb71bbd471c11", 0 );
    
    if ( nodsversion == 0 || nodsversion == 3 )
    {
        self nightvisionviewoff();
        waitframe();
        
        if ( nodsversion == 3 )
        {
            function_c005e75a5eb656db();
        }
    }
    else if ( nodsversion == 1 )
    {
        player_utility::setthermalvision( 0 );
    }
    
    function_d027c8a5f08a645e();
}

// Namespace perkfunctions
// Params 1
// Checksum 0xc8f467a8, Offset: 0xdf27
// Size: 0xc0
function function_922817bf86d02352( enabled )
{
    if ( getdvarint( @"hash_1ffc5f854690aa28", 1 ) == 0 )
    {
        return;
    }
    
    if ( isdefined( self.nvg3rdpersonmodel ) )
    {
        self detach( self.nvg3rdpersonmodel, "j_head" );
        self.nvg3rdpersonmodel = undefined;
    }
    
    if ( enabled )
    {
        modeldown = function_45aae1f77ea601a4();
        
        if ( isdefined( modeldown ) )
        {
            self.nvg3rdpersonmodel = modeldown;
            self attach( self.nvg3rdpersonmodel, "j_head" );
        }
        
        return;
    }
    
    modelup = function_dc85bb44662e92cb();
    
    if ( isdefined( modelup ) )
    {
        self.nvg3rdpersonmodel = modelup;
        self attach( self.nvg3rdpersonmodel, "j_head" );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xed2461bf, Offset: 0xdfef
// Size: 0x57
function function_45aae1f77ea601a4()
{
    modeldown = undefined;
    
    if ( isdefined( level.nvgheadoverrides[ self.operatorcustomization.head ] ) )
    {
        modeldown = level.nvgheadoverrides[ self.operatorcustomization.head ][ "down" ];
    }
    
    return modeldown;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x9adde539, Offset: 0xe04f
// Size: 0x57
function function_dc85bb44662e92cb()
{
    modelup = undefined;
    
    if ( isdefined( level.nvgheadoverrides[ self.operatorcustomization.head ] ) )
    {
        modelup = level.nvgheadoverrides[ self.operatorcustomization.head ][ "up" ];
    }
    
    return modelup;
}

// Namespace perkfunctions
// Params 1
// Checksum 0x1070d95e, Offset: 0xe0af
// Size: 0x204
function nods_outlineplayers( animdelay )
{
    self endon( #"hash_789a752956b97dc2" );
    self endon( #"hash_2ecb63dc4b3e862b" );
    
    if ( animdelay > 0 )
    {
        wait animdelay;
    }
    
    distancechecks = getdvarint( @"hash_b439df56cc1fc84c", 1 );
    distancethreshold = getdvarint( @"hash_aaccfa1cd779f68", 3000 );
    distancethreshold *= distancethreshold;
    var_7d98054b482fa45c = getdvarint( @"hash_1151abd1f1c19ee3", 1 );
    outlineasset = undefined;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player == self )
            {
                continue;
            }
            
            inrange = 1;
            
            if ( distancechecks )
            {
                dist = distancesquared( self.origin, player.origin );
                
                if ( dist >= distancethreshold )
                {
                    inrange = 0;
                }
            }
            
            entnum = player getentitynumber();
            
            if ( !isdefined( self.outlineents ) )
            {
                self.outlineents = [];
            }
            
            if ( isdefined( self.outlineents[ entnum ] ) && inrange )
            {
                continue;
            }
            else if ( isdefined( self.outlineents[ entnum ] ) )
            {
                outline::outlinedisable( self.outlineents[ entnum ], player );
                continue;
            }
            
            if ( player.team == self.team )
            {
                if ( var_7d98054b482fa45c )
                {
                    outlineasset = "outline_depth_blue";
                }
            }
            else
            {
                outlineasset = "outline_depth_orange";
            }
            
            self.outlineents[ entnum ] = outline::outlineenableforplayer( player, self, outlineasset, "level_script" );
        }
        
        wait 0.5;
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0xebd0f82a, Offset: 0xe2bb
// Size: 0xdf
function function_c005e75a5eb656db( animdelay )
{
    if ( animdelay > 0 )
    {
        wait animdelay;
    }
    
    foreach ( player in level.players )
    {
        if ( player == self )
        {
            continue;
        }
        
        entnum = player getentitynumber();
        
        if ( !( isdefined( self.outlineents ) && isdefined( self.outlineents[ entnum ] ) ) )
        {
            continue;
        }
        
        outline::outlinedisable( self.outlineents[ entnum ], player );
    }
    
    self.outlineents = undefined;
}

// Namespace perkfunctions
// Params 3
// Checksum 0x71fef423, Offset: 0xe3a2
// Size: 0xa2
function function_efbeb5e089c168f1( damage, attacker, victim )
{
    dmgmod = clamp( getdvarfloat( @"hash_3bb44b33b3bf5abd", 0.25 ), 0, 1 );
    dmgclamp = clamp( getdvarfloat( @"hash_36b8e20bff4b3196", 0.8 ), 0, 1 );
    var_ed30eb0c259df2de = int( damage * dmgmod );
    
    if ( attacker != victim )
    {
        var_ed30eb0c259df2de = int( clamp( var_ed30eb0c259df2de, 0, victim.maxhealth * dmgclamp ) );
    }
    
    return var_ed30eb0c259df2de;
}

// Namespace perkfunctions
// Params 6
// Checksum 0xb931b8c2, Offset: 0xe44d
// Size: 0x81, Type: bool
function function_9a1ac6b245e03569( attacker, victim, objweapon, smeansofdeath, inflictor, hitloc )
{
    if ( smeansofdeath != "MOD_FIRE" )
    {
        return true;
    }
    
    if ( attacker == victim && !victim.var_144a0420512cccd9 )
    {
        return true;
    }
    
    if ( victim damage_utility::isstuckdamage( inflictor, smeansofdeath ) )
    {
        return true;
    }
    
    if ( function_c06e0a254dc4afe7( objweapon, hitloc ) )
    {
        return true;
    }
    
    return false;
}

// Namespace perkfunctions
// Params 2
// Checksum 0x66b173ed, Offset: 0xe4d7
// Size: 0x61
function function_c06e0a254dc4afe7( objweapon, hitloc )
{
    if ( weapon::issuperweapon( objweapon ) )
    {
        return 1;
    }
    
    if ( weapon::iskillstreakweapon( objweapon ) )
    {
        return 1;
    }
    
    switch ( objweapon.basenamehash )
    {
        case %"bomb_site_mp":
            return 1;
        default:
            return 0;
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xdf01c93c, Offset: 0xe540
// Size: 0x9
function settaccom()
{
    thread function_cbcf2fc790606dce();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xceaefe46, Offset: 0xe551
// Size: 0xe
function unsettaccom()
{
    self notify( #"unset_perk_taccom" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xca01b58, Offset: 0xe567
// Size: 0x28b
function function_cbcf2fc790606dce()
{
    self endon( #"death_or_disconnect" );
    self endon( #"unset_perk_taccom" );
    self.var_5028ab78137287a1 = spawnstruct();
    self.var_5028ab78137287a1.player = [];
    self.var_5028ab78137287a1.cooldown = [];
    requireads = getdvarint( @"hash_87ea8b287cb730ea", 1 );
    bundle = level.perkbundles[ "specialty_taccom_system" ];
    
    while ( true )
    {
        if ( requireads && self playerads() < 1 )
        {
            wait 0.1;
            continue;
        }
        
        targetedenemy = function_32074b9ddb5af01( bundle, targetedenemy );
        
        if ( !isdefined( targetedenemy ) )
        {
            if ( isdefined( self.var_a49a814aeb48ec6a ) )
            {
                self.var_a49a814aeb48ec6a = undefined;
                self.var_7670d9ca2da907d6 = undefined;
            }
            
            wait 0.1;
            continue;
        }
        
        if ( self.var_a49a814aeb48ec6a != targetedenemy )
        {
            self.var_a49a814aeb48ec6a = targetedenemy;
            self.var_19a33ef3ec0185fe = gettime() + bundle.var_95a568fe28e52d26;
            wait 0.1;
        }
        else if ( !isdefined( self.var_19a33ef3ec0185fe ) )
        {
            self.var_19a33ef3ec0185fe = gettime() + bundle.var_95a568fe28e52d26;
        }
        else if ( gettime() >= self.var_19a33ef3ec0185fe )
        {
            num = targetedenemy getentitynumber();
            
            if ( self.var_5028ab78137287a1.player[ num ] == targetedenemy )
            {
                if ( self.var_5028ab78137287a1.cooldown[ num ] > gettime() )
                {
                    wait 0.1;
                    continue;
                }
            }
            
            var_6b9b78226a00d5df = function_372ff24ea539ee8e();
            newpingindex = calloutmarkerping::function_a3f0d6526c09f579( var_6b9b78226a00d5df, self.var_a49a814aeb48ec6a.origin + ( 0, 0, 50 ) );
            thread calloutmarkerping::function_3c501da3379eca0a( self, newpingindex, undefined, [ "unset_perk_taccom", "disconnect" ], bundle.var_96997552219a4fb7 );
            perks::activateperk( "specialty_taccom_system" );
            self.var_19a33ef3ec0185fe = undefined;
            self.var_5028ab78137287a1.player[ num ] = targetedenemy;
            self.var_5028ab78137287a1.cooldown[ num ] = gettime() + bundle.var_f394398a5cbbb095;
            targetedenemy = undefined;
            wait bundle.var_b94b5b496e0c0936;
        }
        
        wait 0.1;
    }
}

// Namespace perkfunctions
// Params 2
// Checksum 0xc2a24626, Offset: 0xe7fa
// Size: 0x19c
function function_32074b9ddb5af01( bundle, var_ba1155d55be7900 )
{
    selfpos = self getvieworigin();
    selfaim = anglestoforward( self getplayerangles() );
    targetedenemy = undefined;
    enemydist = undefined;
    
    foreach ( player in level.players )
    {
        if ( self.team == player.team )
        {
            continue;
        }
        
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player getviewmodel() ) )
        {
            continue;
        }
        
        if ( isdefined( player.perks[ "specialty_thermal_camo" ] ) )
        {
            continue;
        }
        
        enemypos = player gettagorigin( "j_spinelower" );
        
        if ( function_64c25953a7ef2015( self, enemypos, selfpos, selfaim, bundle ) )
        {
            dist = distancesquared( selfpos, enemypos );
            maxdist = bundle.var_42518896e04e0360 * bundle.var_42518896e04e0360;
            
            if ( dist > maxdist )
            {
                continue;
            }
            
            if ( player == var_ba1155d55be7900 )
            {
                return player;
            }
            
            if ( !isdefined( targetedenemy ) )
            {
                targetedenemy = player;
                enemydist = dist;
                continue;
            }
            
            if ( dist < enemydist )
            {
                targetedenemy = player;
                enemydist = dist;
            }
        }
    }
    
    return targetedenemy;
}

// Namespace perkfunctions
// Params 5
// Checksum 0xc8ba6091, Offset: 0xe99f
// Size: 0xdf
function function_64c25953a7ef2015( player, enemypos, playerpos, playeraim, bundle )
{
    fromplayer = enemypos - playerpos;
    dot = vectordot( fromplayer, playeraim );
    
    if ( dot <= 0 )
    {
        return 0;
    }
    
    fromplayerlength = length( fromplayer );
    var_667d2a328d71f2d9 = bundle.var_db68f56c66b8b50e;
    var_667d2a328d71f2d9 += bundle.var_ecfc7c419afdf037 * sqrt( fromplayerlength );
    var_90ca182e9394998e = math::degrees_to_radians( var_667d2a328d71f2d9 );
    var_c31b64911d358ba7 = 1 - 0.5 * var_90ca182e9394998e * var_90ca182e9394998e;
    
    if ( dot < var_c31b64911d358ba7 * fromplayerlength )
    {
        return 0;
    }
    
    if ( taccom_check_los( playerpos, enemypos ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace perkfunctions
// Params 2
// Checksum 0x4fd32b7d, Offset: 0xea86
// Size: 0x68, Type: bool
function taccom_check_los( playerpos, enemypos )
{
    raycastcontents = physics_createcontents( [ "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_ainoshoot", "physicscontents_playernosight" ] );
    raycastresults = physics_raycast( playerpos, enemypos, raycastcontents, undefined, 0, "physicsquery_any", 1 );
    return !raycastresults;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xd2930b48, Offset: 0xeaf7
// Size: 0x58
function function_372ff24ea539ee8e()
{
    var_6b9b78226a00d5df = 4;
    
    if ( isdefined( self.perks[ "specialty_guardian" ] ) || isdefined( self.perks[ "specialty_ally_damage_warning" ] ) )
    {
        var_6b9b78226a00d5df = getxhashasset( level.perkbundles[ "specialty_guardian" ].calloutmarkerping );
    }
    
    return var_6b9b78226a00d5df;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xc658c87c, Offset: 0xeb58
// Size: 0x10
function function_c33564fdb1204df2()
{
    self.var_a5d6f4ed935e5707 = &function_82216a87afc58706;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x52670791, Offset: 0xeb70
// Size: 0xc
function function_af8e0c9892ab706f()
{
    self.var_a5d6f4ed935e5707 = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xdac9b81b, Offset: 0xeb84
// Size: 0xe
function function_82216a87afc58706()
{
    perks::activateperk( "specialty_compression_carrier" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x144ecfee, Offset: 0xeb9a
// Size: 0xd
function function_ae30c17379be69cd()
{
    self setswimspeedscale( 1.3 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xbf1b77aa, Offset: 0xebaf
// Size: 0xa
function function_fba0a841ec46489a()
{
    self setswimspeedscale( 1 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa3670b, Offset: 0xebc1
// Size: 0xd8
function function_6a537b8942d4f8ea()
{
    bundle = level.perkbundles[ "specialty_support_streaker" ];
    
    if ( !( isdefined( bundle ) && isdefined( bundle.var_dd03dab4037c6a9e ) ) || isdefined( level.var_bee218a6459d6380 ) )
    {
        return;
    }
    
    bundlestreaks = bundle.var_dd03dab4037c6a9e;
    level.var_bee218a6459d6380 = [];
    
    for ( i = 0; i < bundlestreaks.size ; i++ )
    {
        streakbundle = bundlestreaks[ i ];
        overridesstruct = spawnstruct();
        overridesstruct.values = [];
        overridesstruct.values[ "support_streaker" ] = streakbundle.cost;
        level.var_bee218a6459d6380[ streakbundle.streakname ] = overridesstruct;
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xff9d740c, Offset: 0xeca1
// Size: 0x10e
function function_d216200231680410()
{
    if ( !isdefined( level.var_bee218a6459d6380 ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_9dd169071832cb54 ) || self.var_9dd169071832cb54.size == 0 )
    {
        self.var_9dd169071832cb54 = arraycopy( level.var_bee218a6459d6380 );
    }
    else
    {
        foreach ( streakname, var_cbf13e19ff25bb95 in level.var_bee218a6459d6380 )
        {
            if ( isdefined( self.var_9dd169071832cb54[ streakname ] ) )
            {
                self.var_9dd169071832cb54[ streakname ].values[ "support_streaker" ] = var_cbf13e19ff25bb95.values[ "support_streaker" ];
                continue;
            }
            
            self.var_9dd169071832cb54[ streakname ] = var_cbf13e19ff25bb95;
        }
    }
    
    function_7dac3b995579b1cb();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x82d8cd22, Offset: 0xedb7
// Size: 0xf6
function function_1e1efff76d8a2fcf()
{
    if ( !( isdefined( self.var_9dd169071832cb54 ) && isdefined( level.var_bee218a6459d6380 ) ) )
    {
        return;
    }
    
    foreach ( streakname, var_cbf13e19ff25bb95 in level.var_bee218a6459d6380 )
    {
        if ( self.var_9dd169071832cb54[ streakname ].values.size > 1 )
        {
            self.var_9dd169071832cb54[ streakname ].values[ "support_streaker" ] = undefined;
            continue;
        }
        
        self.var_9dd169071832cb54[ streakname ] = undefined;
    }
    
    if ( self.var_9dd169071832cb54.size == 0 )
    {
        self.var_9dd169071832cb54 = undefined;
    }
    
    function_7dac3b995579b1cb();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x26b8c1e5, Offset: 0xeeb5
// Size: 0x19
function function_7dac3b995579b1cb()
{
    killstreaks::updatestreakcosts();
    thread killstreaks::function_f1923f85651597e9( self.streakpoints );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x8b9c0297, Offset: 0xeed6
// Size: 0x3bd
function signalJammer_think()
{
    level endon( #"game_ended" );
    level.signaljammer_players = [];
    level.var_8cd5e4e8e4e8c9d7 = [];
    var_f2423b2e2c787eab = getdvarint( @"hash_6cf8ef451d7eb086", 400 );
    var_44e959bccbed21eb = float( var_f2423b2e2c787eab * var_f2423b2e2c787eab );
    var_a5bd7da424ad069f = getdvarint( @"hash_9e837079460d2ffd", 2000 );
    var_ebdc6d348380bcd5 = getdvarint( @"hash_db6950720d7faa27", 1200 );
    throttle = throttle::throttle_initialize_gate( "signalJammer_think", 50 );
    throttle_waited = 0;
    
    while ( true )
    {
        if ( !throttle_waited )
        {
            waitframe();
        }
        else
        {
            throttle_waited = 0;
        }
        
        if ( level.signaljammer_players.size == 0 && level.var_8cd5e4e8e4e8c9d7.size == 0 )
        {
            continue;
        }
        
        equipmentarray = [[ level.getactiveequipmentarray ]]();
        
        foreach ( objid, equipment in level.var_8cd5e4e8e4e8c9d7 )
        {
            if ( !arraycontains( equipmentarray, equipment ) )
            {
                objidpoolmanager::returnobjectiveid( objid );
                level.var_8cd5e4e8e4e8c9d7[ objid ] = undefined;
            }
        }
        
        foreach ( player in level.signaljammer_players )
        {
            foreach ( equipment in equipmentarray )
            {
                if ( isdefined( equipment ) && isdefined( equipment.team ) && isdefined( player ) && isdefined( player.team ) && equipment.team != player.team )
                {
                    thisdistsqr = distancesquared( player.origin, equipment.origin );
                    
                    if ( thisdistsqr < var_44e959bccbed21eb )
                    {
                        if ( !isdefined( equipment.signaljammerobjectiveid ) )
                        {
                            objid = objidpoolmanager::requestobjectiveid();
                            
                            if ( objid != -1 )
                            {
                                objidpoolmanager::objective_add_objective( objid, "active", equipment.origin, "icon_navbar_signal_jammer", "icon_small" );
                                objective_setshowoncompass( objid, 1 );
                                function_2b8e3d3ae2a6414a( objid, 1 );
                                objective_setbackground( objid, 1 );
                                equipment.signaljammerobjectiveid = objid;
                                level.var_8cd5e4e8e4e8c9d7[ objid ] = equipment;
                            }
                        }
                        
                        objidpoolmanager::objective_playermask_addshowplayer( equipment.signaljammerobjectiveid, player );
                        player thread function_75c3783d2f6770a( equipment );
                        prop = thisdistsqr / var_44e959bccbed21eb;
                        var_bb4ebdaa3dc8b7d1 = math::lerp( var_ebdc6d348380bcd5, var_a5bd7da424ad069f, prop );
                        player function_5d1ebac53638d86f( var_bb4ebdaa3dc8b7d1, equipment );
                    }
                    else if ( isdefined( equipment.signaljammerobjectiveid ) )
                    {
                        objective_removeclientfrommask( equipment.signaljammerobjectiveid, player );
                        player thread function_50c792db42de8362( equipment );
                    }
                    
                    throttle_waited |= throttle::throttle_wait_gate( throttle );
                }
            }
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xfcb7e04e, Offset: 0xf29b
// Size: 0x28
function lrdetector_think()
{
    level endon( #"game_ended" );
    level.lrdetector_players = [];
    
    while ( true )
    {
        waitframe();
        function_26cfd56413905537();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x5f0ab914, Offset: 0xf2cb
// Size: 0x5d2
function function_26cfd56413905537()
{
    process = 0;
    var_bec930df44bed6d0 = 1;
    
    if ( getdvarint( @"hash_331b1ec774a4d54b", 0 ) )
    {
        var_bec930df44bed6d0 = 0;
    }
    
    foreach ( num, player in level.lrdetector_players )
    {
        var_1ac82d49ca9fede5 = [];
        otherplayerlaser = undefined;
        var_6bb0cf79d6b0896b = undefined;
        var_1359f2ac5158009e = undefined;
        var_72cd2e4640c1f2b3 = 0;
        var_790699a003c3f6ff = undefined;
        
        if ( !isdefined( player ) )
        {
            level.lrdetector_players[ num ] = undefined;
            break;
        }
        
        var_f103cd961c74f5cf = player gettagorigin( "j_spinelower" );
        playeraim = anglestoforward( player getplayerangles() );
        equipmentarray = [[ level.getactiveequipmentarray ]]();
        playerarray = level.players;
        streakarray = level.activekillstreaks;
        activeobjects = undefined;
        
        if ( isdefined( equipmentarray ) && isdefined( playerarray ) )
        {
            activeobjects = arraycombineunique( playerarray, equipmentarray );
        }
        else
        {
            if ( isdefined( equipmentarray ) )
            {
                activeobjects = equipmentarray;
            }
            
            if ( isdefined( playerarray ) )
            {
                activeobjects = playerarray;
            }
        }
        
        if ( isdefined( streakarray ) )
        {
            var_e21da19762284217 = [];
            
            foreach ( streak in streakarray )
            {
                switch ( streak.streakname )
                {
                    case #"hash_fa4536bde6f7ad9":
                    case #"hash_ab5712e297cd430e":
                    case #"hash_cf0ef5bef19a311b":
                        var_e21da19762284217[ var_e21da19762284217.size ] = streak;
                        break;
                }
            }
            
            activeobjects = arraycombineunique( activeobjects, var_e21da19762284217 );
        }
        
        if ( !isdefined( activeobjects ) )
        {
            continue;
        }
        
        foreach ( targetobj in activeobjects )
        {
            if ( process >= 25 )
            {
                process = 0;
                waitframe();
            }
            
            if ( !isdefined( player ) )
            {
                level.lrdetector_players[ num ] = undefined;
                break;
            }
            
            if ( isplayer( targetobj ) )
            {
                if ( !player lrdetector_shouldwarnaboutotherplayer( targetobj ) )
                {
                    continue;
                }
                
                process++;
                
                if ( targetobj utility::isusingremote() )
                {
                    var_1359f2ac5158009e = targetobj.origin;
                }
                else if ( isplayer( targetobj ) || isagent( targetobj ) )
                {
                    var_1359f2ac5158009e = targetobj geteye();
                }
                else
                {
                    var_1359f2ac5158009e = targetobj gettagorigin( "j_spinelower" );
                }
                
                otherplayeraim = anglestoforward( targetobj getplayerangles() );
                otherplayerlaser = function_eacf9841b4b42e89( targetobj );
                var_6bb0cf79d6b0896b = player function_cef345cbad0a4fb9( targetobj, var_f103cd961c74f5cf );
                
                /#
                    if ( getdvarint( @"hash_4a5e53c86be19882", 0 ) > 0 )
                    {
                        otherplayerlaser = 1;
                    }
                    
                    if ( getdvarint( @"hash_72de1d9c7d36f7e2", 0 ) > 0 )
                    {
                        var_6bb0cf79d6b0896b = 1;
                    }
                #/
                
                if ( !otherplayerlaser && !var_6bb0cf79d6b0896b )
                {
                    continue;
                }
                
                if ( var_6bb0cf79d6b0896b )
                {
                    var_72cd2e4640c1f2b3 = 1;
                    var_1ac82d49ca9fede5[ var_1ac82d49ca9fede5.size ] = targetobj;
                }
                else if ( player lrdetector_inotherplayertargetcone( targetobj, var_f103cd961c74f5cf, var_1359f2ac5158009e, otherplayeraim ) )
                {
                    castcontents = physics_createcontents( [ "physicscontents_ainosight" ] );
                    castresults = physics_raycast( var_f103cd961c74f5cf, var_1359f2ac5158009e, castcontents, [ player, targetobj ], 0, "physicsquery_closest" );
                    
                    if ( isdefined( castresults ) && castresults.size > 0 )
                    {
                        continue;
                    }
                    else
                    {
                        var_72cd2e4640c1f2b3 = 1;
                        var_1ac82d49ca9fede5[ var_1ac82d49ca9fede5.size ] = targetobj;
                    }
                }
            }
            else if ( isdefined( targetobj ) )
            {
                if ( targetobj.exploding )
                {
                    continue;
                }
                
                var_1359f2ac5158009e = targetobj.origin;
                process++;
                
                if ( isdefined( targetobj.streakname ) )
                {
                    if ( function_dc18220a740972e7( targetobj, player ) )
                    {
                        var_72cd2e4640c1f2b3 = 1;
                        var_1ac82d49ca9fede5[ var_1ac82d49ca9fede5.size ] = targetobj;
                    }
                }
                else if ( function_8de35e7a8f8158f7( targetobj, player ) )
                {
                    var_72cd2e4640c1f2b3 = 1;
                    var_1ac82d49ca9fede5[ var_1ac82d49ca9fede5.size ] = targetobj;
                }
            }
            else
            {
                continue;
            }
            
            if ( isdefined( targetobj ) && !arraycontains( player.var_f3ec703c3d489cc4, targetobj ) && arraycontains( var_1ac82d49ca9fede5, targetobj ) )
            {
                var_790699a003c3f6ff = 1;
            }
        }
        
        var_1ac82d49ca9fede5 = player function_677f98e43b2a27f6( var_1ac82d49ca9fede5 );
        player.var_f3ec703c3d489cc4 = var_1ac82d49ca9fede5;
        
        if ( var_72cd2e4640c1f2b3 )
        {
            dot = undefined;
            var_56141330b0cb3ab3 = getdvarfloat( @"hash_176909c53ee0395e", 0.985 );
            
            foreach ( targetobj in var_1ac82d49ca9fede5 )
            {
                if ( !isdefined( dot ) )
                {
                    dot = function_e2088323efb0a069( playeraim, var_f103cd961c74f5cf, targetobj.origin );
                    break;
                }
                
                tempdot = function_e2088323efb0a069( playeraim, var_f103cd961c74f5cf, targetobj.origin );
                
                if ( tempdot > dot )
                {
                    dot = tempdot;
                }
            }
            
            if ( dot >= var_56141330b0cb3ab3 )
            {
                var_bec930df44bed6d0 = 1;
            }
        }
        
        player thread function_4ee1aef067acc529( var_72cd2e4640c1f2b3, var_bec930df44bed6d0, var_790699a003c3f6ff );
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0x49c16da, Offset: 0xf8a5
// Size: 0x298
function function_677f98e43b2a27f6( var_1ac82d49ca9fede5 )
{
    if ( !isdefined( 750 ) || 0 )
    {
        return var_1ac82d49ca9fede5;
    }
    
    if ( !isdefined( self.var_62ec24b9b4ae896f ) )
    {
        self.var_62ec24b9b4ae896f = [];
    }
    
    if ( !isdefined( var_1ac82d49ca9fede5 ) )
    {
        var_1ac82d49ca9fede5 = [];
    }
    
    foreach ( ent in self.var_f3ec703c3d489cc4 )
    {
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        entdetected = arraycontains( var_1ac82d49ca9fede5, ent );
        var_a609bde66243383e = 0;
        var_bc3e40a32c748c1f = undefined;
        
        if ( self.var_62ec24b9b4ae896f.size > 0 )
        {
            for ( index = 0; index < self.var_62ec24b9b4ae896f.size ; index++ )
            {
                if ( self.var_62ec24b9b4ae896f[ index ].ent == ent )
                {
                    var_bc3e40a32c748c1f = index;
                    var_a609bde66243383e = 1;
                    break;
                }
            }
        }
        
        if ( entdetected && var_a609bde66243383e )
        {
            self.var_62ec24b9b4ae896f[ var_bc3e40a32c748c1f ] = undefined;
            
            if ( isint( var_bc3e40a32c748c1f ) )
            {
                function_cdc669dbc8ea2101( self.var_62ec24b9b4ae896f );
            }
            
            continue;
        }
        
        if ( !entdetected && !var_a609bde66243383e )
        {
            newentry = spawnstruct();
            newentry.ent = ent;
            newentry.time = gettime();
            self.var_62ec24b9b4ae896f[ self.var_62ec24b9b4ae896f.size ] = newentry;
        }
    }
    
    removedelay = getdvarint( @"hash_1418e2a60694ce70", 750 );
    
    for ( index = self.var_62ec24b9b4ae896f.size - 1; index >= 0 ; index-- )
    {
        ent = self.var_62ec24b9b4ae896f[ index ];
        
        if ( !isdefined( ent ) )
        {
            self.var_62ec24b9b4ae896f[ index ] = undefined;
            
            if ( isint( index ) )
            {
                function_cdc669dbc8ea2101( self.var_62ec24b9b4ae896f );
            }
            
            continue;
        }
        
        entdetected = arraycontains( var_1ac82d49ca9fede5, ent.ent );
        
        if ( !entdetected )
        {
            removetime = ent.time + removedelay;
            
            if ( gettime() < removetime )
            {
                var_1ac82d49ca9fede5[ var_1ac82d49ca9fede5.size ] = ent.ent;
                continue;
            }
            
            self.var_62ec24b9b4ae896f[ index ] = undefined;
            
            if ( isint( index ) )
            {
                function_cdc669dbc8ea2101( self.var_62ec24b9b4ae896f );
            }
        }
    }
    
    return var_1ac82d49ca9fede5;
}

// Namespace perkfunctions
// Params 3
// Checksum 0xb563aed5, Offset: 0xfb46
// Size: 0xe2
function function_4ee1aef067acc529( var_72cd2e4640c1f2b3, var_bec930df44bed6d0, var_790699a003c3f6ff )
{
    if ( var_72cd2e4640c1f2b3 )
    {
        if ( var_790699a003c3f6ff )
        {
            thread function_af88f9e6d1ca0522();
        }
        
        if ( !isdefined( self.var_d2fd8a032becb2f7 ) )
        {
            self.var_d2fd8a032becb2f7 = gettime();
            function_88b7e96ae06e67dd( 16 );
            function_332870c27adf18fb( var_bec930df44bed6d0 );
        }
        else
        {
            currtime = gettime();
            var_4f27f030b1fccb5c = undefined;
            
            switch ( var_bec930df44bed6d0 )
            {
                case 1:
                    var_4f27f030b1fccb5c = 500;
                    break;
            }
            
            if ( currtime - var_4f27f030b1fccb5c >= self.var_d2fd8a032becb2f7 )
            {
                function_88b7e96ae06e67dd( 16 );
                function_332870c27adf18fb( var_bec930df44bed6d0 );
                self.var_d2fd8a032becb2f7 = currtime;
            }
            else if ( !var_790699a003c3f6ff )
            {
                function_88b7e96ae06e67dd( 0 );
            }
        }
        
        return;
    }
    
    function_88b7e96ae06e67dd( 0 );
}

// Namespace perkfunctions
// Params 2
// Checksum 0xf4a58519, Offset: 0xfc30
// Size: 0x18f, Type: bool
function function_8de35e7a8f8158f7( targetobj, player )
{
    var_a3765bf0fc68e0ac = targetobj.owner;
    var_7abb8ea921e296dc = 1;
    
    if ( var_7abb8ea921e296dc )
    {
        if ( isdefined( var_a3765bf0fc68e0ac ) && !player_utility::playersareenemies( player, var_a3765bf0fc68e0ac ) )
        {
            return false;
        }
    }
    
    if ( distancesquared( targetobj.origin, player.origin ) > 202500 )
    {
        return false;
    }
    
    var_d081bb167b020b4e = undefined;
    
    if ( isdefined( targetobj.weapon_name ) )
    {
        var_d081bb167b020b4e = targetobj.weapon_name;
    }
    
    if ( !isdefined( var_d081bb167b020b4e ) && isdefined( targetobj.weapon_object ) )
    {
        var_d081bb167b020b4e = targetobj.weapon_object.basename;
    }
    
    if ( isdefined( var_d081bb167b020b4e ) )
    {
        if ( var_d081bb167b020b4e == "claymore_mp" || var_d081bb167b020b4e == "jup_claymore_mp" || var_d081bb167b020b4e == "jup_claymore_cp" )
        {
            if ( player lrdetector_inotherplayertargetcone( targetobj, player.origin, targetobj.origin, anglestoforward( targetobj.angles ), 25 ) )
            {
                castcontents = physics_createcontents( [ "physicscontents_ainosight" ] );
                castresults = physics_raycast( player.origin, targetobj.origin, castcontents, [ player, targetobj ], 0, "physicsquery_closest" );
                
                if ( isdefined( castresults ) && castresults.size > 0 )
                {
                    return false;
                }
                
                return true;
            }
        }
    }
    
    return false;
}

// Namespace perkfunctions
// Params 2
// Checksum 0x41c3344a, Offset: 0xfdc8
// Size: 0x167, Type: bool
function function_dc18220a740972e7( killstreak, player )
{
    streakname = killstreak.streakname;
    
    if ( isdefined( streakname ) )
    {
        if ( streakname == "remote_turret" || streakname == "pac_sentry" || streakname == "sentry_turret" )
        {
            if ( isdefined( killstreak.owner ) && !player_utility::playersareenemies( player, killstreak.owner ) )
            {
                return false;
            }
            
            if ( distancesquared( killstreak.origin, player.origin ) > 36000000 )
            {
                return false;
            }
            
            if ( player lrdetector_inotherplayertargetcone( killstreak, player.origin, killstreak.origin, anglestoforward( killstreak.angles ) ) )
            {
                traceloc = killstreak gettagorigin( "tag_flash", 1 );
                
                if ( !isdefined( traceloc ) )
                {
                    traceloc = killstreak.origin + ( 0, 0, 6 );
                }
                
                castcontents = physics_createcontents( [ "physicscontents_ainosight" ] );
                castresults = physics_raycast( player.origin, traceloc, castcontents, [ player, killstreak ], 0, "physicsquery_closest" );
                
                if ( isdefined( castresults ) && castresults.size > 0 )
                {
                    return false;
                }
                
                return true;
            }
        }
    }
    
    return false;
}

// Namespace perkfunctions
// Params 1
// Checksum 0xc254bafc, Offset: 0xff38
// Size: 0xf0, Type: bool
function lrdetector_shouldwarnaboutotherplayer( otherplayer )
{
    if ( !isdefined( self.perks[ "specialty_lr_detector" ] ) )
    {
        return false;
    }
    
    if ( !player::isreallyalive() )
    {
        return false;
    }
    
    if ( !isdefined( otherplayer ) )
    {
        return false;
    }
    
    if ( !otherplayer player::isreallyalive() )
    {
        return false;
    }
    
    if ( otherplayer.team == self.team )
    {
        return false;
    }
    
    if ( otherplayer == self )
    {
        return false;
    }
    
    if ( distancesquared( otherplayer.origin, self.origin ) > 36000000 )
    {
        return false;
    }
    
    if ( !otherplayer val::get( "fire" ) )
    {
        return false;
    }
    
    if ( otherplayer utility::isusingremote() )
    {
        remotename = otherplayer player::getremotename();
        
        if ( remotename == "gunship" || remotename == "radar_drone_recon" || remotename == "chopper_gunner" || remotename == "cruise_predator" )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace perkfunctions
// Params 1
// Checksum 0x43d1dfa7, Offset: 0x10031
// Size: 0x7b, Type: bool
function function_eacf9841b4b42e89( otherplayer )
{
    equippedweapon = undefined;
    equippedweapon = otherplayer getcurrentweapon();
    
    if ( isdefined( equippedweapon ) )
    {
    }
    else
    {
        return false;
    }
    
    if ( isdefined( equippedweapon.basename ) && issubstr( equippedweapon.basename, "laser" ) )
    {
        return true;
    }
    
    if ( function_180f246714b6c204( equippedweapon ) )
    {
        return true;
    }
    
    if ( function_7974b348bf7596e9( equippedweapon ) )
    {
        return true;
    }
    
    if ( function_38e455437698f6af( equippedweapon ) )
    {
        return true;
    }
    
    return false;
}

// Namespace perkfunctions
// Params 2
// Checksum 0xba0a4010, Offset: 0x100b5
// Size: 0x120
function function_cef345cbad0a4fb9( otherplayer, var_f103cd961c74f5cf )
{
    if ( distancesquared( otherplayer.origin, self.origin ) > 562500 )
    {
        return 0;
    }
    
    if ( otherplayer utility::isusingremote() )
    {
        remotename = otherplayer player::getremotename();
        
        if ( remotename == "assault_drone" || remotename == "sentry_turret" || remotename == "recon_drone" || remotename == "tacCam" || remotename == "remote_turret" || remotename == "pac_sentry" )
        {
            if ( getdvarint( @"hash_1440d4d37f1d5de5" ) == 1 )
            {
                castcontents = physics_createcontents( [ "physicscontents_ainosight" ] );
                castresults = physics_raycast( var_f103cd961c74f5cf, otherplayer.origin, castcontents, [ self, otherplayer ], 0, "physicsquery_closest" );
                
                if ( isdefined( castresults ) && castresults.size > 0 )
                {
                    return 0;
                }
                
                return 1;
            }
            else
            {
                return 1;
            }
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    return 0;
}

// Namespace perkfunctions
// Params 5
// Checksum 0x6e13f399, Offset: 0x101dd
// Size: 0xcb, Type: bool
function lrdetector_inotherplayertargetcone( otherplayer, playerpos, otherplayerpos, otherplayeraim, var_10fc129678e65e06 )
{
    fromotherplayer = playerpos - otherplayerpos;
    dot = vectordot( fromotherplayer, otherplayeraim );
    
    if ( dot <= 0 )
    {
        return false;
    }
    
    var_3c9c3b8a993e0c31 = length( fromotherplayer );
    
    if ( isdefined( var_10fc129678e65e06 ) )
    {
        var_667d2a328d71f2d9 = var_10fc129678e65e06;
    }
    else
    {
        var_667d2a328d71f2d9 = 12;
    }
    
    var_667d2a328d71f2d9 += -0.15 * sqrt( var_3c9c3b8a993e0c31 );
    var_90ca182e9394998e = math::degrees_to_radians( var_667d2a328d71f2d9 );
    var_c31b64911d358ba7 = 1 - 0.5 * var_90ca182e9394998e * var_90ca182e9394998e;
    
    if ( dot < var_c31b64911d358ba7 * var_3c9c3b8a993e0c31 )
    {
        return false;
    }
    
    return true;
}

// Namespace perkfunctions
// Params 3
// Checksum 0x4d88260f, Offset: 0x102b1
// Size: 0x46
function function_e2088323efb0a069( playeraim, playerpos, otherplayerpos )
{
    tootherplayer = otherplayerpos - playerpos;
    dot = vectordot( playeraim, vectornormalize( tootherplayer ) );
    return dot;
}

// Namespace perkfunctions
// Params 1
// Checksum 0x4031d9c6, Offset: 0x10300
// Size: 0x75
function function_88b7e96ae06e67dd( vfxvalue )
{
    if ( vfxvalue == 0 )
    {
        if ( self.lrdetectoractive )
        {
            self setscriptablepartstate( "lrDetector", "lrDetector_off", 0 );
            self.lrdetectoractive = 0;
        }
        
        return;
    }
    
    self setclientomnvar( "ui_lr_detector", gettime() );
    
    if ( !self.lrdetectoractive )
    {
        self setscriptablepartstate( "lrDetector", "lrDetector_on", 0 );
        self.lrdetectoractive = 1;
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x4700965a, Offset: 0x1037d
// Size: 0x32
function function_af88f9e6d1ca0522()
{
    function_88b7e96ae06e67dd( 16 );
    self playsoundtoplayer( "prk_lr_detector_first_beep", self );
    wait 0.1;
    function_88b7e96ae06e67dd( 16 );
    self playsoundtoplayer( "prk_lr_detector_first_beep", self );
}

// Namespace perkfunctions
// Params 1
// Checksum 0xb07eb48f, Offset: 0x103b7
// Size: 0x1f
function function_332870c27adf18fb( var_bec930df44bed6d0 )
{
    if ( var_bec930df44bed6d0 != 0 )
    {
        self playsoundtoplayer( "prk_lr_detector_beep", self );
    }
}

// Namespace perkfunctions
// Params 2
// Checksum 0x6731d905, Offset: 0x103de
// Size: 0x8a
function function_5d1ebac53638d86f( var_5e1c15f03b56b021, fromentity )
{
    if ( var_5e1c15f03b56b021 > 0 && isdefined( fromentity ) )
    {
        if ( !isdefined( self.var_9cc6e35fea1f22bf ) )
        {
            self.var_9cc6e35fea1f22bf = gettime();
            self playsoundtoplayer( "prk_signal_jammer_beep", self, fromentity );
            return;
        }
        
        currtime = gettime();
        
        if ( currtime - self.var_9cc6e35fea1f22bf >= var_5e1c15f03b56b021 )
        {
            self.var_9cc6e35fea1f22bf = currtime;
            self playsoundtoplayer( "prk_signal_jammer_beep", self, fromentity );
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb1e6ed1e, Offset: 0x10470
// Size: 0x4cf
function settacmask()
{
    bundle = level.perkbundles[ "specialty_tac_mask" ];
    
    if ( !( isdefined( bundle ) && isdefined( bundle.var_bbafac0ab10c371 ) ) )
    {
        return;
    }
    
    self.var_73dbcc359d6c3c97 = [];
    
    foreach ( index, var_b8a1092bf8fc12d6 in bundle.var_bbafac0ab10c371 )
    {
        switch ( var_b8a1092bf8fc12d6.trait_type )
        {
            case #"stun":
                if ( isdefined( var_b8a1092bf8fc12d6.trait_setting ) )
                {
                    switch ( var_b8a1092bf8fc12d6.trait_setting )
                    {
                        case #"hash_8b85ac7f081e7060":
                            perks::_setperk( "specialty_stun_resistance" );
                            self.var_73dbcc359d6c3c97[ index ] = "specialty_stun_resistance";
                            break;
                        case #"hash_db653a4972b3c13b":
                        case #"hash_e3ea33954e1ac9f7":
                        default:
                            break;
                    }
                }
                
                break;
            case #"emp":
                if ( isdefined( var_b8a1092bf8fc12d6.trait_setting ) )
                {
                    switch ( var_b8a1092bf8fc12d6.trait_setting )
                    {
                        case #"hash_8b85ac7f081e7060":
                            perks::_setperk( "specialty_emp_resist" );
                            self.var_73dbcc359d6c3c97[ index ] = "specialty_emp_resist";
                            break;
                        case #"hash_e3ea33954e1ac9f7":
                            perks::_setperk( "specialty_emp_immunity" );
                            perks::_setperk( "specialty_empimmune" );
                            self.var_73dbcc359d6c3c97[ index ] = "specialty_emp_immunity";
                            break;
                        case #"hash_db653a4972b3c13b":
                        default:
                            break;
                    }
                }
                
                break;
            case #"gas":
                if ( isdefined( var_b8a1092bf8fc12d6.trait_setting ) )
                {
                    switch ( var_b8a1092bf8fc12d6.trait_setting )
                    {
                        case #"hash_8b85ac7f081e7060":
                            perks::_setperk( "specialty_gas_grenade_resist" );
                            self.var_73dbcc359d6c3c97[ index ] = "specialty_gas_grenade_resist";
                            break;
                        case #"hash_e3ea33954e1ac9f7":
                            perks::_setperk( "specialty_gas_immunity" );
                            self.var_73dbcc359d6c3c97[ index ] = "specialty_gas_immunity";
                        case #"hash_db653a4972b3c13b":
                        default:
                            break;
                    }
                }
                
                break;
            case #"Hallucination":
                if ( isdefined( var_b8a1092bf8fc12d6.trait_setting ) )
                {
                    switch ( var_b8a1092bf8fc12d6.trait_setting )
                    {
                        case #"hash_e3ea33954e1ac9f7":
                            perks::_setperk( "specialty_hallucination_immunity" );
                            self.var_73dbcc359d6c3c97[ index ] = "specialty_hallucination_immunity";
                            break;
                        case #"hash_8b85ac7f081e7060":
                        case #"hash_db653a4972b3c13b":
                        default:
                            break;
                    }
                }
                
                break;
            case #"shock":
                if ( isdefined( var_b8a1092bf8fc12d6.trait_setting ) )
                {
                    switch ( var_b8a1092bf8fc12d6.trait_setting )
                    {
                        case #"hash_e3ea33954e1ac9f7":
                            perks::_setperk( "specialty_shock_immunity" );
                            self.var_73dbcc359d6c3c97[ index ] = "specialty_shock_immunity";
                            break;
                        case #"hash_8b85ac7f081e7060":
                        case #"hash_db653a4972b3c13b":
                        default:
                            break;
                    }
                }
            case #"snapshot":
                if ( isdefined( var_b8a1092bf8fc12d6.trait_setting ) )
                {
                    switch ( var_b8a1092bf8fc12d6.trait_setting )
                    {
                        case #"hash_e3ea33954e1ac9f7":
                            perks::_setperk( "specialty_snapshot_immunity" );
                            self.var_73dbcc359d6c3c97[ index ] = "specialty_snapshot_immunity";
                            break;
                        case #"hash_8b85ac7f081e7060":
                        case #"hash_db653a4972b3c13b":
                        default:
                            break;
                    }
                }
            case #"hack":
                if ( isdefined( var_b8a1092bf8fc12d6.trait_setting ) )
                {
                    switch ( var_b8a1092bf8fc12d6.trait_setting )
                    {
                        case #"hash_8b85ac7f081e7060":
                            break;
                        case #"hash_e3ea33954e1ac9f7":
                            if ( level.specialty_hack_immunity_ref )
                            {
                                perks::_setperk( level.specialty_hack_immunity_ref );
                                self.var_73dbcc359d6c3c97[ index ] = level.specialty_hack_immunity_ref;
                            }
                            
                            break;
                        case #"hash_db653a4972b3c13b":
                        default:
                            break;
                    }
                }
                
                break;
            default:
                break;
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe658ba7c, Offset: 0x10947
// Size: 0xa4
function unsettacmask()
{
    if ( !isdefined( self.var_73dbcc359d6c3c97 ) )
    {
        return;
    }
    
    foreach ( var_c4cb56de27f7ef4e in self.var_73dbcc359d6c3c97 )
    {
        if ( isdefined( self.perks[ var_c4cb56de27f7ef4e ] ) )
        {
            perks::_unsetperk( var_c4cb56de27f7ef4e );
        }
    }
    
    self.var_73dbcc359d6c3c97 = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x1ddd8b7b, Offset: 0x109f3
// Size: 0x3a
function function_f1b0da7787d1de76()
{
    submix = "jup_mp_bone_conduction";
    var_517ab62266194468 = isbrgamemode();
    
    if ( var_517ab62266194468 )
    {
        submix = "wz_mp_bone_conduction";
    }
    
    self setsoundsubmix( submix, 0.2 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x2d2e1ab0, Offset: 0x10a35
// Size: 0x3a
function function_951916310f2669b3()
{
    submix = "jup_mp_bone_conduction";
    var_517ab62266194468 = isbrgamemode();
    
    if ( var_517ab62266194468 )
    {
        submix = "wz_mp_bone_conduction";
    }
    
    self clearsoundsubmix( submix, 0.2 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x31ef99eb, Offset: 0x10a77
// Size: 0x68
function setoutlander()
{
    if ( !isdefined( self.var_8ee8efc2c797c4a ) )
    {
        self.var_8ee8efc2c797c4a = 0;
    }
    
    self.var_d97303c92e1e679 = 1;
    self.var_8ee8efc2c797c4a += getdvarfloat( @"hash_50dc5065112199d7", -0.2 );
    
    if ( !getdvarint( @"scr_disable_powerup_zombie_legs", 0 ) )
    {
        thread function_fe694ff7f5e798b8();
    }
    
    outlander_updatemovespeed();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x4df22eb3, Offset: 0x10ae7
// Size: 0x44
function unsetoutlander()
{
    self.var_d97303c92e1e679 = 0;
    self.var_8ee8efc2c797c4a -= getdvarfloat( @"hash_50dc5065112199d7", -0.2 );
    self notify( #"outlander_unset" );
    outlander_updatemovespeed();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x67ad9a04, Offset: 0x10b33
// Size: 0x124
function outlander_updatemovespeed()
{
    if ( !self.var_c7db4a5f206339af && self.var_d97303c92e1e679 && self.isincircle )
    {
        if ( self.outlanderspeedmod != getdvarfloat( @"hash_f12f9c3e925d6a69", 0.1 ) )
        {
            self.outlanderspeedmod = getdvarfloat( @"hash_f12f9c3e925d6a69", 0.1 );
            
            if ( !common::function_8ff835bf23198a0( "outlanderSpeedMod" ) )
            {
                common::function_ac4bf3256b2545e3( "outlanderSpeedMod", self.outlanderspeedmod );
                common::function_11a0a06c67c80f4d( "outlanderSpeedMod", 2 );
            }
            else
            {
                common::function_a0f5c85d465c5f0a( "outlanderSpeedMod", self.outlanderspeedmod );
                common::function_11a0a06c67c80f4d( "outlanderSpeedMod", 2 );
            }
            
            weapons::updatemovespeedscale();
            function_fd784ee883797b4b( "outlander" );
        }
        
        return;
    }
    
    if ( isdefined( self.outlanderspeedmod ) && self.outlanderspeedmod != 0 )
    {
        self.outlanderspeedmod = 0;
        
        if ( common::function_8ff835bf23198a0( "outlanderSpeedMod" ) )
        {
            common::function_d85a92c557ea5a52( "outlanderSpeedMod" );
        }
        
        weapons::updatemovespeedscale();
        function_11ff2063f097a68f( "outlander" );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x140b40df, Offset: 0x10c5f
// Size: 0x46
function function_fe694ff7f5e798b8()
{
    self endon( #"death_or_disconnect" );
    self endon( #"outlander_unset" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        utility::waittill_any( "powerup_apply_zombie_legs", "powerup_remove_zombie_legs" );
        outlander_updatemovespeed();
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x71dfe0d6, Offset: 0x10cad
// Size: 0x24
function function_1b294f1fd95a639c()
{
    self.var_d33bc9b8c3cec4b1 = getdvarfloat( @"hash_28d9e384824bc463", 0.2 );
    thread function_bb5e3da0f2d1e369();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x93a542fb, Offset: 0x10cd9
// Size: 0xc
function function_d6a26ff0ffbcca13()
{
    self.var_d33bc9b8c3cec4b1 = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xf3acbd66, Offset: 0x10ced
// Size: 0xbc
function function_bb5e3da0f2d1e369()
{
    self endon( #"death_or_disconnect" );
    self notify( #"hash_6742bd3e02d6e925" );
    self endon( #"hash_6742bd3e02d6e925" );
    
    while ( true )
    {
        message = utility::waittill_any_return( "last_stand_enter", "last_stand_exit" );
        
        if ( message == "last_stand_enter" )
        {
            if ( !common::function_8ff835bf23198a0( "last_stand_speed_mod" ) )
            {
                var_d33bc9b8c3cec4b1 = getdvarfloat( @"hash_28d9e384824bc463", 0.2 );
                common::function_983eeeeb432f3d8( "last_stand_speed_mod", undefined, undefined, var_d33bc9b8c3cec4b1, undefined );
                weapons::updatemovespeedscale();
            }
            
            continue;
        }
        
        if ( common::function_8ff835bf23198a0( "last_stand_speed_mod" ) )
        {
            common::function_d85a92c557ea5a52( "last_stand_speed_mod" );
            weapons::updatemovespeedscale();
        }
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa27b93e8, Offset: 0x10db1
// Size: 0x28
function function_fff7a0358ed34419()
{
    self.var_77a21d85c8390691 = 1;
    common::function_ac4bf3256b2545e3( "brMoveSpeed", 0 );
    weapons::updatemovespeedscale();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xcf1f9c33, Offset: 0x10de1
// Size: 0x1f
function function_2536cd7a9a7c0c2()
{
    self.var_77a21d85c8390691 = undefined;
    common::function_d85a92c557ea5a52( "brMoveSpeed" );
    weapons::updatemovespeedscale();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x80783ca4, Offset: 0x10e08
// Size: 0x1d
function function_bce2a7da8e9aaa18()
{
    self.var_513f2c4fa2e259ee = getdvarfloat( @"hash_d2139809963cc0c8", 0.8 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xf847e9d3, Offset: 0x10e2d
// Size: 0xc
function function_a0eaacbeb295e85b()
{
    self.var_513f2c4fa2e259ee = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xfbc31a, Offset: 0x10e41
// Size: 0x1d
function function_63dd61f2bb756611()
{
    self.var_dab13b55173196a1 = getdvarfloat( @"hash_c825c43c66abd9c7", 0.8 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x88530f62, Offset: 0x10e66
// Size: 0xc
function function_f763b10a60848216()
{
    self.var_dab13b55173196a1 = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x2a41a848, Offset: 0x10e7a
// Size: 0x1d
function function_d10786a48612f59f()
{
    self.var_b1e841fd6ae912d7 = getdvarfloat( @"hash_80d20097a357fa4b", 0.8 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xf25b9981, Offset: 0x10e9f
// Size: 0xc
function function_cadc32058803b5e()
{
    self.var_b1e841fd6ae912d7 = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x7ef098c2, Offset: 0x10eb3
// Size: 0x1e
function function_97390db64b0bcff6()
{
    self.resolutespeedmod = 0;
    self.hasresolute = 1;
    thread function_d0ad73760f565619();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xe69e21eb, Offset: 0x10ed9
// Size: 0xc
function function_1623f7e271aa7855()
{
    self.resolutespeedmod = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xef89055, Offset: 0x10eed
// Size: 0x274
function function_d0ad73760f565619()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    var_86e98d863571c950 = getdvarint( @"hash_87db853764e7f565", 3000 );
    var_7bbdef26a829d954 = getdvarfloat( @"scr_perk_resolute_speed_mod", 0.15 );
    var_6d47c0d4be510823 = getdvarint( @"hash_af88e95e4b2803e7", 3000 );
    
    if ( !isdefined( self.var_5e8735663d0e6abb ) )
    {
        self.var_5e8735663d0e6abb = [];
    }
    
    while ( self.hasresolute )
    {
        speedmod = 0;
        timestamp = gettime();
        
        if ( !self.var_c7db4a5f206339af && isdefined( self.lastshottime ) && player::isreallyalive( self ) && self.lastshottime + var_86e98d863571c950 >= timestamp )
        {
            speedmod = var_7bbdef26a829d954;
        }
        
        if ( isdefined( self.resolutespeedmod ) && speedmod != self.resolutespeedmod )
        {
            self.resolutespeedmod = speedmod;
            
            if ( !common::function_8ff835bf23198a0( "resoluteSpeedMod" ) )
            {
                common::function_ac4bf3256b2545e3( "resoluteSpeedMod", speedmod );
            }
            else if ( speedmod <= 0 )
            {
                common::function_d85a92c557ea5a52( "resoluteSpeedMod" );
            }
            
            if ( player::isreallyalive( self ) )
            {
                weapons::updatemovespeedscale();
            }
            
            if ( speedmod > 0 )
            {
                function_fd784ee883797b4b( "lightweight" );
            }
            else
            {
                function_11ff2063f097a68f( "lightweight" );
                self.var_5e8735663d0e6abb = [];
            }
        }
        
        if ( self.var_5e8735663d0e6abb.size > 0 )
        {
            foreach ( guid, ts in self.var_5e8735663d0e6abb )
            {
                if ( timestamp >= ts + var_6d47c0d4be510823 )
                {
                    self.var_5e8735663d0e6abb[ guid ] = undefined;
                }
            }
        }
        
        waitframe();
    }
    
    self.var_5e8735663d0e6abb = undefined;
    
    if ( isdefined( self.resolutespeedmod ) )
    {
        self.resolutespeedmod = undefined;
        
        if ( common::function_8ff835bf23198a0( "resoluteSpeedMod" ) )
        {
            common::function_d85a92c557ea5a52( "resoluteSpeedMod" );
        }
        
        function_11ff2063f097a68f( "lightweight" );
        
        if ( player::isreallyalive( self ) )
        {
            weapons::updatemovespeedscale();
        }
    }
    
    self.lastshottime = undefined;
}

// Namespace perkfunctions
// Params 1
// Checksum 0x80b3eec9, Offset: 0x11169
// Size: 0xa4
function function_fd784ee883797b4b( source )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    assert( isdefined( source ), "<dev string:x123>" );
    
    if ( !isdefined( self.var_ae655eb63a7e3f0c ) )
    {
        self.var_ae655eb63a7e3f0c = [];
    }
    
    if ( !arraycontains( self.var_ae655eb63a7e3f0c, source ) )
    {
        self.var_ae655eb63a7e3f0c[ self.var_ae655eb63a7e3f0c.size ] = source;
    }
    
    if ( !self.var_444aa6da01789ac8 )
    {
        self.var_444aa6da01789ac8 = 1;
        self lerpfovbypreset( "zombiedefault" );
        self setclientomnvar( "ui_speedboost_overlay", 0 );
    }
    
    waitframe();
}

// Namespace perkfunctions
// Params 1
// Checksum 0xe76bd0cf, Offset: 0x11215
// Size: 0xc4
function function_11ff2063f097a68f( source )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    assert( isdefined( source ), "<dev string:x151>" );
    
    if ( !isdefined( self.var_ae655eb63a7e3f0c ) || self.var_ae655eb63a7e3f0c.size <= 0 )
    {
        return;
    }
    
    sources = self.var_ae655eb63a7e3f0c;
    
    if ( arraycontains( sources, source ) )
    {
        self.var_ae655eb63a7e3f0c = arrayremove( sources, source );
    }
    
    if ( self.var_ae655eb63a7e3f0c.size <= 0 )
    {
        if ( self.var_444aa6da01789ac8 )
        {
            self.var_444aa6da01789ac8 = undefined;
            childthread function_a33239d3fc27be21();
            self lerpfovbypreset( "default_2seconds" );
        }
        
        self.var_ae655eb63a7e3f0c = undefined;
    }
    
    waitframe();
}

// Namespace perkfunctions
// Params 2
// Checksum 0x564a9a0d, Offset: 0x112e1
// Size: 0x64, Type: bool
function function_9a4f085a6e6f1eef( victim, attacker )
{
    return victim.var_f61304f33083793e && isdefined( attacker ) && isdefined( attacker.guid ) && ( !isdefined( victim.var_5e8735663d0e6abb ) || !isdefined( victim.var_5e8735663d0e6abb[ attacker.guid ] ) );
}

// Namespace perkfunctions
// Params 2
// Checksum 0x9dd3d369, Offset: 0x1134e
// Size: 0x5a
function function_f248ab44cf241b4( victim, attacker )
{
    if ( victim.var_f61304f33083793e )
    {
        if ( !isdefined( victim.var_5e8735663d0e6abb ) )
        {
            victim.var_5e8735663d0e6abb = [];
        }
        
        victim.var_5e8735663d0e6abb[ attacker.guid ] = gettime();
    }
}

// Namespace perkfunctions
// Params 0, eflags: 0x4
// Checksum 0x6c38372b, Offset: 0x113b0
// Size: 0x24
function private function_a33239d3fc27be21()
{
    self setclientomnvar( "ui_speedboost_overlay", 2 );
    wait 1;
    
    if ( isdefined( self ) )
    {
        self setclientomnvar( "ui_speedboost_overlay", -1 );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xaf5fba08, Offset: 0x113dc
// Size: 0x20
function function_9bbd59fb188c4958()
{
    uav_tower::function_9033276b6b21c1e8( "discount_perk", getdvarfloat( @"hash_cf717cd86623a83e", 0.5 ) );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x4c99a24a, Offset: 0x11404
// Size: 0xe
function function_b18dc1eb47068b19()
{
    uav_tower::function_fb0cabac970236c3( "discount_perk" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x50f0c898, Offset: 0x1141a
// Size: 0x9
function function_3c706efa8353065e()
{
    function_6958800685937439();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xfbb5061f, Offset: 0x1142b
// Size: 0x9
function function_d23a839bdb7c5657()
{
    function_6958800685937439();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x23bae0d9, Offset: 0x1143c
// Size: 0xbd
function function_6958800685937439()
{
    if ( getdvarint( @"hash_a50815ce2cfbefbc", 0 ) )
    {
        squad = player::getteamarray( self.team );
        
        if ( isdefined( squad ) )
        {
            foreach ( player in squad )
            {
                player function_459650df764d857( br_quest_util::function_bf57ff81684bd6a( player ) );
            }
        }
        
        return;
    }
    
    function_459650df764d857( br_quest_util::function_bf57ff81684bd6a( self ) );
}

// Namespace perkfunctions
// Params 1
// Checksum 0x7016310b, Offset: 0x11501
// Size: 0x19
function function_459650df764d857( mod )
{
    self setclientomnvar( "ui_br_contract_plunder_mod", mod );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xf535c7ab, Offset: 0x11522
// Size: 0x1a
function setexplosiveregenhalt()
{
    self.explosiveregenhalt = getdvarfloat( @"hash_e7cd825be6986e79", 30 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xeda7072a, Offset: 0x11544
// Size: 0xc
function unsetexplosiveregenhalt()
{
    self.explosiveregenhalt = undefined;
}

// Namespace perkfunctions
// Params 1
// Checksum 0x2ab2853e, Offset: 0x11558
// Size: 0x8c
function explosiveregenhalt_activate( victim )
{
    level endon( #"game_ended" );
    victim endon( #"death_or_disconnect" );
    victim endon( #"end_explosiveregenhalt" );
    attacker = self;
    
    if ( getdvarfloat( @"hash_3421a3bfb58341ec", 1 ) == 0 )
    {
        return;
    }
    
    if ( victim.explosiveregenhaltactive )
    {
        return;
    }
    
    if ( !player::isreallyalive( victim ) )
    {
        return;
    }
    
    victim thread function_b03c0b14206c4d8c( attacker );
    victim thread function_27b6719d8f650f83();
    victim thread function_29d3e46aba8c0321();
}

// Namespace perkfunctions
// Params 1
// Checksum 0xeb0399a, Offset: 0x115ec
// Size: 0x180
function function_b03c0b14206c4d8c( attacker )
{
    level endon( #"game_ended" );
    victim = self;
    victim endon( #"death_or_disconnect" );
    victim endon( #"end_explosiveregenhalt" );
    victim.var_1bf40eeb0eeec0f4 = attacker.explosiveregenhalt;
    victim.explosiveregenhaltactive = 1;
    holdtime = getdvarfloat( @"hash_50c83353fd8eba49", 0.75 );
    hinttime = getdvarint( @"hash_2b9ae035e8979b5c", 30 );
    var_7c03ab22ca24f11a = getdvarint( @"hash_9a274384ac61906", 1 );
    
    if ( victim usinggamepad() )
    {
        victim thread function_f8cee572dcdd845b( &"wz_perks/explosive_regen_halt_hold", hinttime );
    }
    else
    {
        victim thread function_f8cee572dcdd845b( &"wz_perks/explosive_regen_halt_hold_kb", hinttime );
    }
    
    while ( true )
    {
        victim waittill( #"stop_explosiveregenhalt" );
        supers_mp::function_d629c90761cd2a1c( "gesture_tracker_grenade_remove_mp", 1 );
        victim thread function_ba0319299d77df33( holdtime );
        result = victim utility::waittill_any_timeout( holdtime, "continue_explosiveRegenHalt" );
        
        if ( result == "continue_explosiveRegenHalt" )
        {
            victim setclientomnvar( "ui_securing", 0 );
            victim setclientomnvar( "ui_securing_progress", 0 );
            continue;
        }
        
        victim thread print::tutorialprint( &"wz_perks/explosive_regen_halt_end", var_7c03ab22ca24f11a );
        victim.explosiveregenhaltactive = undefined;
        victim notify( #"end_explosiveregenhalt" );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0xed5f3419, Offset: 0x11774
// Size: 0x97
function function_27b6719d8f650f83()
{
    level endon( #"game_ended" );
    victim = self;
    victim endon( #"death_or_disconnect" );
    victim endon( #"end_explosiveregenhalt" );
    holdtimer = 0;
    
    while ( true )
    {
        buttonpressed = victim reloadbuttonpressed();
        
        if ( buttonpressed )
        {
            if ( holdtimer > 0.3 )
            {
                victim notify( #"stop_explosiveregenhalt" );
            }
            
            holdtimer += level.framedurationseconds;
        }
        else
        {
            holdtimer = 0;
            victim notify( #"continue_explosiveRegenHalt" );
        }
        
        waitframe();
    }
}

// Namespace perkfunctions
// Params 2
// Checksum 0xcb64a4e4, Offset: 0x11813
// Size: 0x5c
function function_f8cee572dcdd845b( msg, hinttime )
{
    victim = self;
    victim endon( #"stop_explosiveregenhalt" );
    victim endon( #"end_explosiveregenhalt" );
    
    if ( !isdefined( victim ) || !player::isreallyalive( victim ) )
    {
        return;
    }
    
    victim print::tutorialprint( msg, hinttime );
}

// Namespace perkfunctions
// Params 1
// Checksum 0x720e6560, Offset: 0x11877
// Size: 0xad
function function_ba0319299d77df33( holdtime )
{
    level endon( #"game_ended" );
    victim = self;
    victim endon( #"continue_explosiveRegenHalt" );
    victim endon( #"death_or_disconnect" );
    victim setclientomnvar( "ui_securing", 29 );
    timer = 0;
    
    while ( timer < holdtime )
    {
        time = min( timer / holdtime, 1 );
        victim setclientomnvar( "ui_securing_progress", time );
        waitframe();
        timer += level.framedurationseconds;
    }
    
    victim setclientomnvar( "ui_securing", 0 );
    victim setclientomnvar( "ui_securing_progress", 0 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x3896ac81, Offset: 0x1192c
// Size: 0x48
function function_29d3e46aba8c0321()
{
    level endon( #"game_ended" );
    victim = self;
    victim waittill( #"end_explosiveregenhalt" );
    victim thread print::tutorialprint( &"wz_perks/explosive_regen_halt_end", 1 );
    victim.explosiveregenhaltactive = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa3b8a5c0, Offset: 0x1197c
// Size: 0x1b
function setscavenger()
{
    utility::callsharedfunc( #"scavenger_bag", #"startwatchingforscavengercleanup" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa582d8, Offset: 0x1199f
// Size: 0x1b
function unsetscavenger()
{
    utility::callsharedfunc( #"scavenger_bag", #"stopwatchingforscavengercleanup" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x40ecc177, Offset: 0x119c2
// Size: 0x1d
function function_28838db7975c4ab()
{
    self.var_d0d222d2577ebcbf = getdvarfloat( @"hash_2f47a9b7c7ebab97", 0.8 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x1283af62, Offset: 0x119e7
// Size: 0xc
function function_e25a8e4383767e44()
{
    self.var_d0d222d2577ebcbf = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x6a0bcf1, Offset: 0x119fb
// Size: 0x1d
function function_8a08a6e976d284cf()
{
    self.var_3e398b71be70e3c6 = getdvarfloat( @"hash_d273a042e1a2ba0d", 0.75 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x9e31680, Offset: 0x11a20
// Size: 0xc
function function_41291b8a52213092()
{
    self.var_3e398b71be70e3c6 = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xb4152e71, Offset: 0x11a34
// Size: 0x18
function cricketinit()
{
    if ( !isdefined( level.var_43aee273edb1cb64 ) )
    {
        level.var_43aee273edb1cb64 = [];
    }
}

// Namespace perkfunctions
// Params 2
// Checksum 0x49d62722, Offset: 0x11a54
// Size: 0x45
function function_deeb2f40153920c7( weaponrootname, usefunc )
{
    if ( !isdefined( level.var_43aee273edb1cb64 ) )
    {
        level.var_43aee273edb1cb64 = [];
    }
    
    if ( !isdefined( usefunc ) )
    {
        usefunc = &weapons::_detonate;
    }
    
    level.var_43aee273edb1cb64[ weaponrootname ] = usefunc;
}

// Namespace perkfunctions
// Params 3
// Checksum 0xdd7736fe, Offset: 0x11aa1
// Size: 0x7a
function function_11c3fafb448b240( weaponrootname, timeout, destroyfunc )
{
    if ( !isdefined( level.var_c305c49a7c7bc1e4 ) )
    {
        level.var_c305c49a7c7bc1e4 = [];
    }
    
    if ( !isdefined( destroyfunc ) )
    {
        destroyfunc = &function_f9dc2cb0aa924def;
    }
    
    timeoutstruct = spawnstruct();
    timeoutstruct.destroyfunc = destroyfunc;
    timeoutstruct.timeout = timeout;
    level.var_663ca3264dd82ca8[ weaponrootname ] = timeoutstruct;
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa8e1dd37, Offset: 0x11b23
// Size: 0x25
function function_f9dc2cb0aa924def()
{
    if ( isdefined( self.headiconid ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconid );
    }
    
    self delete();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x3410f11b, Offset: 0x11b50
// Size: 0x15
function function_f36e2e30ffc151f2()
{
    self notify( #"hash_a52e20adcb81bc1f" );
    thread function_e7b9f0412258c9ad();
}

// Namespace perkfunctions
// Params 0
// Checksum 0x82ce04ff, Offset: 0x11b6d
// Size: 0x5c
function function_e7b9f0412258c9ad()
{
    self endon( #"hash_a52e20adcb81bc1f" );
    
    while ( true )
    {
        self waittill( #"last_stand_enter" );
        smoke = equipment_mp::getweaponfromequipmentref( "equip_smoke" );
        magicgrenademanual( smoke, self.origin, ( 0, 0, -10 ), 0.5 );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x6bb7eb4d, Offset: 0x11bd1
// Size: 0xe
function function_f78a5439fa7b5357()
{
    self notify( #"hash_a52e20adcb81bc1f" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x79f47daa, Offset: 0x11be7
// Size: 0x32
function function_fa766b2eb1ff9cba()
{
    utility::callsharedfunc( #"container", #"modifyplayerloottime", "searchKit", getdvarfloat( @"hash_d25fe979acb8737c", 0.25 ) );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x2c4e081, Offset: 0x11c21
// Size: 0x21
function function_44d850ab2447eca9()
{
    utility::callsharedfunc( #"container", #"modifyplayerloottime", "searchKit", 0 );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xa21c0332, Offset: 0x11c4a
// Size: 0xd
function function_c775dc12e5354b5d()
{
    self.hasplatepouch = 1;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x826f8e3, Offset: 0x11c5f
// Size: 0xc
function function_59a67331f0cb8998()
{
    self.hasplatepouch = undefined;
}

// Namespace perkfunctions
// Params 1
// Checksum 0x4e70c03e, Offset: 0x11c73
// Size: 0x12
function refreshstamina( attacker )
{
    self refreshsprinttime();
}

// Namespace perkfunctions
// Params 0
// Checksum 0xc1b9f97b, Offset: 0x11c8d
// Size: 0x1e
function function_ec48c8136d633d1e()
{
    self.var_dbc1643a48094e30 = self.var_9842326056fd7207.var_dbc1643a48094e30;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x4a9624a7, Offset: 0x11cb3
// Size: 0xc
function function_1e140a7cf0c1dd91()
{
    self.var_dbc1643a48094e30 = undefined;
}

// Namespace perkfunctions
// Params 0
// Checksum 0x9a7cc215, Offset: 0x11cc7
// Size: 0x96
function function_a3f92efd68179bc7()
{
    equipment_charge_time = getmatchrulesdata( "arenaData", "equipmentChargeTime" );
    lethal_equipment_ref = equipment_mp::getcurrentequipment( "primary" );
    tactical_equipment_ref = equipment_mp::getcurrentequipment( "secondary" );
    
    if ( !gunfight_loadouts::function_2c1d142864561f9a( lethal_equipment_ref ) )
    {
        self.var_a9612a64bc77e7b8[ "primary" ] = equipment_charge_time;
        equipment_mp::setequipmentammo( lethal_equipment_ref, 0 );
    }
    
    if ( !gunfight_loadouts::function_2c1d142864561f9a( tactical_equipment_ref ) )
    {
        self.var_a9612a64bc77e7b8[ "secondary" ] = equipment_charge_time;
        equipment_mp::setequipmentammo( tactical_equipment_ref, 0 );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x27f8bf5e, Offset: 0x11d65
// Size: 0x47
function function_83dbfe8dfca4da8b()
{
    if ( gamelogic_mp::inprematch() )
    {
        return;
    }
    
    thread function_f90b78be566b1e90( "super_utility_drop" );
    
    if ( getdvarint( @"scr_swap_battle_ready_uav", 1 ) == 0 )
    {
        thread function_f90b78be566b1e90( "uav" );
        return;
    }
    
    thread function_f90b78be566b1e90( "supply_sweep" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0x1f2902c6, Offset: 0x11db4
// Size: 0x2
function function_de1a45cc0c81a0c4()
{
    
}

// Namespace perkfunctions
// Params 1
// Checksum 0x50f1cda2, Offset: 0x11dbe
// Size: 0xda
function function_f90b78be566b1e90( item )
{
    level endon( #"game_ended" );
    player = self;
    player endon( #"death_or_disconnect" );
    
    if ( common_item::items_isenabled() )
    {
        itembundlename = common_item_database::function_a4f0a21951180013( item );
        itembundle = getscriptbundle( itembundlename );
        
        if ( !itembundle.scriptable )
        {
            assertmsg( "<dev string:x180>" + item );
            return;
        }
        
        fakeitem = spawnstruct();
        fakeitem.type = itembundle.scriptable;
        fakeitem.count = common_item::function_ea3b3088d82fd357( itembundle );
        fakeitem.fromcache = 1;
        obtainresult = player common_item::function_96119bed8ab4c5d9( fakeitem, 0, 1 );
    }
}

// Namespace perkfunctions
// Params 0
// Checksum 0x84dd0299, Offset: 0x11ea0
// Size: 0x18
function setbandolier()
{
    if ( gamelogic_mp::inprematch() )
    {
        return;
    }
    
    thread bandolier_spawnitem( "wz_consumable_satchel_ammo" );
}

// Namespace perkfunctions
// Params 0
// Checksum 0xbc3800f8, Offset: 0x11ec0
// Size: 0x2
function unsetbandolier()
{
    
}

// Namespace perkfunctions
// Params 1
// Checksum 0xdccdf2ff, Offset: 0x11eca
// Size: 0xc6
function bandolier_spawnitem( item )
{
    level endon( #"game_ended" );
    player = self;
    player endon( #"death_or_disconnect" );
    
    if ( common_item::items_isenabled() )
    {
        itembundlename = common_item_database::function_a4f0a21951180013( item );
        itembundle = getscriptbundle( itembundlename );
        scriptable_name = itembundle.scriptable;
        fakeitem = spawnstruct();
        fakeitem.type = scriptable_name;
        fakeitem.count = common_item::function_ea3b3088d82fd357( itembundle );
        fakeitem.fromcache = 1;
        obtainresult = player common_item::function_96119bed8ab4c5d9( fakeitem, 0, 1 );
    }
}

// Namespace perkfunctions
// Params 1
// Checksum 0x781f789d, Offset: 0x11f98
// Size: 0xb0
function function_bc67eadf98fb969a( scriptablename )
{
    if ( !isdefined( scriptablename ) )
    {
        return;
    }
    
    perkname = undefined;
    
    if ( issubstr( scriptablename, "comms" ) )
    {
        perkname = "specialty_pc_comms";
    }
    else if ( issubstr( scriptablename, "medic" ) )
    {
        perkname = "specialty_pc_medic";
    }
    else if ( issubstr( scriptablename, "stealth" ) )
    {
        perkname = "specialty_pc_stealth";
    }
    else if ( issubstr( scriptablename, "tempered" ) )
    {
        perkname = "specialty_pc_tempered";
    }
    else if ( issubstr( scriptablename, "high_capacity" ) )
    {
        perkname = "specialty_pc_high_capacity";
    }
    else if ( issubstr( scriptablename, "cqc" ) )
    {
        perkname = "specialty_pc_close_quarter";
    }
    
    return perkname;
}

// Namespace perkfunctions
// Params 3
// Checksum 0x4382bf56, Offset: 0x12051
// Size: 0x104
function applystunresistence( attacker, victim, time )
{
    if ( isdefined( victim.perks[ "specialty_stun_resistance" ] ) && attacker != victim )
    {
        if ( isdefined( victim.stunscalar ) && isdefined( time ) )
        {
            time *= victim.stunscalar;
        }
        
        attackerowner = attacker.owner ?? attacker;
        victimowner = victim.owner ?? victim;
        
        if ( isplayer( attackerowner ) && attackerowner != victim )
        {
            attacker damagefeedback::updatedamagefeedback( "hittacresist", undefined, undefined, undefined, 1 );
        }
        
        if ( player_utility::playersareenemies( attackerowner, victimowner ) )
        {
            perks::activateperk( "specialty_tac_resist" );
        }
    }
    else if ( !victim val::get( "stunned" ) )
    {
        time = 0;
    }
    
    if ( victim game_utility_mp::ismatchstartprotected() )
    {
        time *= 0.1;
    }
    
    return time;
}

