// scripts\mp\br\gametypes\br_weapon_upgrade.gsc  (hash_40bdc07c52e35fc3.gscc) (size: 9808 Bytes / 0x2650 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd6b3058d (3602056589)
// size ...... 9808 (0x2650)
// includes .. 16  (offset: 0x229c)
// strings ... 37  (offset: 0x231c)
// dev strs .. 0   (offset: 0x2650)
// exports ... 18  (offset: 0x181c)
// cseg ...... 0x36e + 0x14ae (0x181c)
// imports ... 67  (offset: 0x1aec)
// animtree1 . 0   (offset: 0x2650)
// animtree2 . 0   (offset: 0x2650)
#using scripts\common\scriptable;
#using scripts\common\telemetry_utils;
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br_armory_kiosk;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item_weapon;

#namespace br_weapon_upgrade;

// Namespace br_weapon_upgrade
// Params 0
// Checksum 0x7a18adc3, Offset: 0x38c
// Size: 0x33
function init()
{
    if ( function_f931980fcbcda20b() )
    {
        scriptable::scriptable_addusedcallbackbypart( "br_workbench", &weaponupgradeused );
        lui_game_event_aggregator::registeronluieventcallback( &function_6e6bf8de17926033 );
        
        /#
            level thread br_armory_kiosk::function_93c45949deab67bb();
        #/
    }
}

// Namespace br_weapon_upgrade
// Params 6
// Checksum 0x810d5ca5, Offset: 0x3c7
// Size: 0x16d
function weaponupgradeused( instance, part, state, player = self, bautouse, usestring )
{
    if ( !br_default_inventory::function_a073e760594105c6( player ) )
    {
        return;
    }
    
    if ( player.carryinghostage )
    {
        if ( isdefined( level.br_pickups ) && isdefined( level.br_pickups.var_9d247aba85e39454 ) )
        {
            player hud_message::showerrormessage( level.br_pickups.var_9d247aba85e39454 );
        }
        
        return;
    }
    
    if ( player.iscarryingartifact )
    {
        return;
    }
    
    validstate = state == "visible";
    
    if ( player.insertingarmorplate )
    {
        player notify( #"try_armor_cancel", "armory_kiosk_used" );
    }
    
    if ( !isdefined( state ) )
    {
        thread function_7ffde035748a4e21( player, instance );
        return;
    }
    
    if ( validstate )
    {
        if ( isdefined( instance ) )
        {
            if ( br_public::isweaponupgrade( instance.type ) )
            {
                newstate = "open";
                instance setscriptablepartstate( "br_workbench", newstate );
            }
            
            instance thread br_armory_kiosk::kioskfixupproneplayers();
        }
        
        function_ed458d4a2e91963e( player );
        thread function_7ffde035748a4e21( player, instance );
        return;
    }
    
    if ( state == "open" )
    {
        function_ed458d4a2e91963e( player );
        thread function_7ffde035748a4e21( player, instance );
    }
}

// Namespace br_weapon_upgrade
// Params 2, eflags: 0x4
// Checksum 0xe88ef78a, Offset: 0x53c
// Size: 0xec
function private function_7ffde035748a4e21( player, kiosk )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player endon( #"death" );
    
    if ( isdefined( level.var_87a21a3e41dc2e5d ) )
    {
        [[ level.var_87a21a3e41dc2e5d ]]( kiosk, player );
    }
    
    player setclientomnvar( "ui_buystation_purchase_response", 0 );
    player setclientomnvar( "ui_buystation_open", 8 );
    player.var_b42a76bce637a933 = 1;
    
    if ( isdefined( player.pers[ "telemetry" ] ) )
    {
        player.pers[ "telemetry" ].var_e1567de387d39e8c = 1;
        player.pers[ "telemetry" ].workbenchstarttime = telemetry_utils::get_time_from_match_start( gettime() );
    }
    
    player thread br_armory_kiosk::watchtoautoclosemenu( kiosk );
    player calloutmarkerping::function_d34345aa1f30ebba();
}

// Namespace br_weapon_upgrade
// Params 1
// Checksum 0x1d0846c9, Offset: 0x630
// Size: 0x84
function function_e1b1ad019639afb4( player )
{
    player setclientomnvar( "ui_buystation_purchase_response", 0 );
    player setclientomnvar( "ui_buystation_open", 1 );
    player.var_b42a76bce637a933 = undefined;
    player notify( #"hash_af164706b76a3248" );
    function_41934faf05f784a8( player );
    
    if ( isdefined( player.pers[ "telemetry" ].var_e1567de387d39e8c ) )
    {
        player.pers[ "telemetry" ].var_e1567de387d39e8c = 0;
    }
}

// Namespace br_weapon_upgrade
// Params 2
// Checksum 0x323ddb2a, Offset: 0x6bc
// Size: 0x10b
function function_6e6bf8de17926033( channel, value )
{
    player = self;
    
    if ( !player.var_b42a76bce637a933 )
    {
        return;
    }
    
    if ( channel == "br_cancel_upgrade_purchase" )
    {
        function_e1b1ad019639afb4( player );
        
        if ( isdefined( player.pers[ "telemetry" ] ) )
        {
            if ( isdefined( player.pers[ "telemetry" ].workbenchstarttime ) )
            {
                player.pers[ "telemetry" ].workbenchendtime = telemetry_utils::get_time_from_match_start( gettime() );
                player.pers[ "telemetry" ].workbenchtimespent = player.pers[ "telemetry" ].workbenchendtime - player.pers[ "telemetry" ].workbenchstarttime;
            }
        }
        
        return;
    }
    
    if ( channel == "upgrade_weapon" )
    {
        upgradeweapon( player, value );
    }
}

// Namespace br_weapon_upgrade
// Params 0
// Checksum 0xbb7d8ffe, Offset: 0x7cf
// Size: 0x2e
function function_f931980fcbcda20b()
{
    if ( !isdefined( level.weapon_upgrade_enabled ) )
    {
        level.weapon_upgrade_enabled = getdvarint( @"scr_enable_workbench", 0 );
    }
    
    return level.weapon_upgrade_enabled;
}

// Namespace br_weapon_upgrade
// Params 1
// Checksum 0xc5659978, Offset: 0x806
// Size: 0x64
function function_db72b9c539c26616( player )
{
    if ( !isdefined( level.var_3146730d4d5e50d6 ) )
    {
        level.var_3146730d4d5e50d6 = getdvarint( @"hash_a1d5dc7bd9d01032", 300 );
    }
    
    upgradediscount = br_instance_inventory::function_e8c80d2fa9b2512e( player );
    return int( max( 0, level.var_3146730d4d5e50d6 - level.var_3146730d4d5e50d6 * upgradediscount ) );
}

// Namespace br_weapon_upgrade
// Params 1, eflags: 0x4
// Checksum 0x16a251d7, Offset: 0x873
// Size: 0x11
function private function_75e43f1d7d1c0696( value )
{
    return value & 3;
}

// Namespace br_weapon_upgrade
// Params 1, eflags: 0x4
// Checksum 0xf9e6aeb2, Offset: 0x88d
// Size: 0x14
function private function_12c3dc6db53b4659( value )
{
    return ( value & 60 ) >> 2;
}

// Namespace br_weapon_upgrade
// Params 2
// Checksum 0x9c2dc747, Offset: 0x8aa
// Size: 0x16d
function function_ec92e4bc68960cee( player, insuredslot )
{
    oldattachments = [];
    var_3bf6ce5b0607ff16 = [];
    maxprimaryattachments = weapon::getmaxprimaryattachments( player class::function_facf39de1a82731a() );
    
    for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
    {
        oldattachments[ attachmentindex ] = player getplayerdata( level.var_6f9b00680ed002d8, "insuredWeapons", "weaponSetups", insuredslot, "attachmentSetup", attachmentindex, "attachment" );
        var_3bf6ce5b0607ff16[ attachmentindex ] = player getplayerdata( level.var_6f9b00680ed002d8, "insuredWeapons", "weaponSetups", insuredslot, "attachmentSetup", attachmentindex, "variantID" );
    }
    
    for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
    {
        upgradeattachment = player getplayerdata( level.loadoutsgroup, "upgradeWeapon", "attachmentSetup", attachmentindex, "attachment" );
        upgradeattachmentid = player getplayerdata( level.loadoutsgroup, "upgradeWeapon", "attachmentSetup", attachmentindex, "variantID" );
        player setplayerdata( level.var_6f9b00680ed002d8, "insuredWeapons", "weaponSetups", insuredslot, "attachmentSetup", attachmentindex, "attachment", upgradeattachment );
        player setplayerdata( level.var_6f9b00680ed002d8, "insuredWeapons", "weaponSetups", insuredslot, "attachmentSetup", attachmentindex, "variantID", upgradeattachmentid );
    }
}

// Namespace br_weapon_upgrade
// Params 2
// Checksum 0x85dc8755, Offset: 0xa1f
// Size: 0x53
function function_1cb7184bc422d538( weaponobj, attachment )
{
    if ( !isdefined( attachment ) )
    {
        return;
    }
    
    rootname = weapon::getweaponrootname( weaponobj );
    weaponasset = weapon::weaponassetnamemap( rootname );
    
    if ( isthermalattachment( weaponasset, attachment ) )
    {
        return "thermal_attachment";
    }
}

// Namespace br_weapon_upgrade
// Params 2
// Checksum 0xa4980b87, Offset: 0xa7b
// Size: 0xbf, Type: bool
function function_fb661bb159046f9c( player, newweapon )
{
    foreach ( weap in player.primaryweapons )
    {
        if ( issameweapon( weap, newweapon ) )
        {
            return true;
        }
    }
    
    if ( br_default_inventory::function_787d2ebb0cc2e86f( player ) )
    {
        playerdataweapon = br_default_inventory::function_3b4976a12ea5037b( player );
        
        if ( issameweapon( playerdataweapon, newweapon ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_weapon_upgrade
// Params 2
// Checksum 0xfdf8db87, Offset: 0xb43
// Size: 0x3f9
function upgradeweapon( player, value )
{
    if ( isdefined( player.pers[ "telemetry" ] ) )
    {
        player.pers[ "telemetry" ].var_7c1ae2ca5233c19a = 1;
    }
    
    newattachmentindex = function_12c3dc6db53b4659( value );
    attachmentcost = 0;
    newattachment = undefined;
    
    if ( newattachmentindex != 15 && newattachmentindex <= 4 )
    {
        attachmentcost = function_db72b9c539c26616( player );
        newattachment = player getplayerdata( level.loadoutsgroup, "upgradeWeapon", "attachmentSetup", newattachmentindex, "attachment" );
        function_932466384b9e20e6( player, newattachment, attachmentcost );
    }
    
    assert( player.plundercount >= attachmentcost );
    assert( newattachmentindex == 15 || newattachmentindex <= 4 );
    
    if ( player.plundercount < attachmentcost || newattachmentindex != 15 && newattachmentindex > 4 )
    {
        return;
    }
    
    if ( attachmentcost > 0 )
    {
        player br_plunder::playerplunderkioskpurchase( attachmentcost );
    }
    
    weaponindex = function_75e43f1d7d1c0696( value );
    upgradeweapon = br_default_inventory::function_4a9e65f11966819f( player, level.loadoutsgroup, "upgradeWeapon" );
    
    if ( function_fb661bb159046f9c( player, upgradeweapon ) )
    {
        return;
    }
    
    oldmetadata = br_instance_inventory::function_6a05cf5689058e1f( player, weaponindex );
    oldweaponinstance = br_instance_inventory::function_843e185e3cd37eb1( player, weaponindex );
    pastteam = player item_weapon::function_af299135a62729b8( undefined, weaponindex );
    itemtype = function_1cb7184bc422d538( upgradeweapon, newattachment );
    var_3a3fb91e35ecdb7 = upgradeweapon issilenced();
    var_b26b6655da6d9b96 = 0;
    
    if ( isdefined( player.pers[ "telemetry" ] ) )
    {
        if ( isdefined( upgradeweapon ) )
        {
            primaryvariantid = getweaponvariantindex( upgradeweapon );
            weaponrootname = weapon::getweaponrootname( upgradeweapon );
            
            if ( isdefined( weaponrootname ) )
            {
                player.pers[ "telemetry" ].workbenchweapon = weaponrootname;
                
                if ( isdefined( primaryvariantid ) )
                {
                    player.pers[ "telemetry" ].workbenchweapon = player.pers[ "telemetry" ].workbenchweapon + "|" + primaryvariantid;
                }
            }
        }
    }
    
    if ( weaponindex == 2 )
    {
        br_default_inventory::function_4494ac60be615891( player, upgradeweapon, 1, oldmetadata );
    }
    else
    {
        var_51bce6fcf5d22557 = br_pickups::function_5ef22d170cdde55e( player, weaponindex );
        inventory_utility::_takeweapon( var_51bce6fcf5d22557 );
        br_instance_inventory::function_1e5fd659146e4d80( player, weaponindex );
        br_pickups::equipweapon( upgradeweapon, weaponclipsize( upgradeweapon ), weaponindex, undefined, undefined, undefined, oldmetadata, undefined, undefined, undefined, weaponclipsize( upgradeweapon ) );
        var_b26b6655da6d9b96 = var_51bce6fcf5d22557 issilenced();
        
        if ( newattachmentindex == 15 )
        {
            function_bfb7481f4d86b53b( player, var_51bce6fcf5d22557, upgradeweapon );
        }
    }
    
    newweaponinstance = br_instance_inventory::function_843e185e3cd37eb1( player, weaponindex );
    br_instance_inventory::function_cbd51514c40a0b0f( player, weaponindex, oldweaponinstance, newweaponinstance );
    player item_weapon::function_59db11f47705f704( undefined, pastteam, weaponindex );
    insuredslot = br_instance_inventory::function_55fad71e8e81e9f0( player, weaponindex );
    
    if ( isdefined( player.pers[ "telemetry" ] ) )
    {
        player.pers[ "telemetry" ].weaponslotindex = weaponindex;
    }
    
    if ( isdefined( insuredslot ) )
    {
        function_ec92e4bc68960cee( player, int( insuredslot ) - 1 );
        
        if ( isdefined( player.pers[ "telemetry" ] ) )
        {
            player.pers[ "telemetry" ].var_71ebc0289ad8d33f = 1;
        }
    }
    
    if ( attachmentcost > 0 )
    {
        if ( var_3a3fb91e35ecdb7 && !var_b26b6655da6d9b96 )
        {
            itemtype = "silencer_attached";
        }
        
        lootid = weapon::getattachmentlootid( weapon::getweaponrootname( upgradeweapon ), newattachment );
        challenges::function_c102157423d9e481( "attachment", itemtype, lootid, 1, attachmentcost );
        return;
    }
    
    challenges::function_771f5a9bd9cb2f06( itemtype, undefined, undefined, 1, 0 );
}

// Namespace br_weapon_upgrade
// Params 3
// Checksum 0x8451f53c, Offset: 0xf44
// Size: 0x155
function function_bfb7481f4d86b53b( player, var_51bce6fcf5d22557, upgradeweapon )
{
    removedattachment = undefined;
    
    foreach ( attachment in var_51bce6fcf5d22557.attachments )
    {
        if ( !arraycontains( upgradeweapon.attachments, attachment ) )
        {
            removedattachment = attachment;
        }
    }
    
    if ( isdefined( removedattachment ) )
    {
        if ( isdefined( player.pers[ "telemetry" ] ) && isdefined( removedattachment ) )
        {
            if ( isdefined( player.pers[ "telemetry" ].workbenchattachmentsremoved ) )
            {
                player.pers[ "telemetry" ].workbenchattachmentsremoved = player.pers[ "telemetry" ].workbenchattachmentsremoved + "," + removedattachment;
                return;
            }
            
            player.pers[ "telemetry" ].workbenchattachmentsremoved = removedattachment;
        }
    }
}

// Namespace br_weapon_upgrade
// Params 1
// Checksum 0x24934856, Offset: 0x10a1
// Size: 0x86
function function_ed458d4a2e91963e( player )
{
    if ( isdefined( player.pers[ "telemetry" ].workbenchopencount ) )
    {
        player.pers[ "telemetry" ].workbenchopencount = player.pers[ "telemetry" ].workbenchopencount + 1;
        return;
    }
    
    player.pers[ "telemetry" ].workbenchopencount = 1;
}

// Namespace br_weapon_upgrade
// Params 3
// Checksum 0xe5201e1c, Offset: 0x112f
// Size: 0x139
function function_932466384b9e20e6( player, attachment, attachmentcost )
{
    if ( isdefined( player.pers[ "telemetry" ] ) )
    {
        if ( isdefined( player.pers[ "telemetry" ].workbenchcashspent ) && isdefined( attachmentcost ) )
        {
            player.pers[ "telemetry" ].workbenchcashspent = player.pers[ "telemetry" ].workbenchcashspent + attachmentcost;
        }
        else
        {
            player.pers[ "telemetry" ].workbenchcashspent = attachmentcost;
        }
        
        if ( isdefined( player.pers[ "telemetry" ].var_78d18ea309ab2b10 ) && isdefined( attachment ) )
        {
            player.pers[ "telemetry" ].var_78d18ea309ab2b10 = player.pers[ "telemetry" ].var_78d18ea309ab2b10 + "," + attachment;
            return;
        }
        
        player.pers[ "telemetry" ].var_78d18ea309ab2b10 = attachment;
    }
}

// Namespace br_weapon_upgrade
// Params 1
// Checksum 0x6fb8d432, Offset: 0x1270
// Size: 0x5ac
function function_41934faf05f784a8( player )
{
    workbenchopencount = 0;
    
    if ( isdefined( player.pers[ "telemetry" ].workbenchopencount ) )
    {
        workbenchopencount = player.pers[ "telemetry" ].workbenchopencount;
    }
    
    cashspent = 0;
    
    if ( isdefined( player.pers[ "telemetry" ].workbenchcashspent ) )
    {
        cashspent = int( player.pers[ "telemetry" ].workbenchcashspent );
    }
    
    var_59c22e870aa17bfa = 0;
    
    if ( isdefined( player.pers[ "telemetry" ].var_7c1ae2ca5233c19a ) )
    {
        var_59c22e870aa17bfa = player.pers[ "telemetry" ].var_7c1ae2ca5233c19a;
    }
    
    var_91f506de78f8791f = 0;
    
    if ( isdefined( player.pers[ "telemetry" ].var_71ebc0289ad8d33f ) )
    {
        var_91f506de78f8791f = player.pers[ "telemetry" ].var_71ebc0289ad8d33f;
    }
    
    weaponindex = 0;
    
    if ( isdefined( player.pers[ "telemetry" ].weaponslotindex ) )
    {
        weaponindex = player.pers[ "telemetry" ].weaponslotindex;
    }
    
    weaponref = "";
    
    if ( isdefined( player.pers[ "telemetry" ].workbenchweapon ) )
    {
        weaponref = player.pers[ "telemetry" ].workbenchweapon;
    }
    
    attachmentspurchased = "";
    
    if ( isdefined( player.pers[ "telemetry" ].var_78d18ea309ab2b10 ) )
    {
        attachmentspurchased = player.pers[ "telemetry" ].var_78d18ea309ab2b10;
    }
    
    attachmentsremoved = "";
    
    if ( isdefined( player.pers[ "telemetry" ].workbenchattachmentsremoved ) )
    {
        attachmentsremoved = player.pers[ "telemetry" ].workbenchattachmentsremoved;
    }
    
    forcedclosed = 0;
    
    if ( player.pers[ "telemetry" ].var_765f9934ae1cca3e )
    {
        forcedclosed = 1;
    }
    
    timespent = 0;
    
    if ( isdefined( player.pers[ "telemetry" ].workbenchtimespent ) )
    {
        timespent = player.pers[ "telemetry" ].workbenchtimespent;
    }
    
    xpos = 0;
    
    if ( isdefined( player.origin[ 0 ] ) )
    {
        xpos = player.origin[ 0 ];
    }
    
    ypos = 0;
    
    if ( isdefined( player.origin[ 1 ] ) )
    {
        ypos = player.origin[ 1 ];
    }
    
    zpos = 0;
    
    if ( isdefined( player.origin[ 2 ] ) )
    {
        zpos = player.origin[ 2 ];
    }
    
    pitch = 0;
    
    if ( isdefined( player.angles[ 0 ] ) )
    {
        pitch = player.angles[ 0 ];
    }
    
    yaw = 0;
    
    if ( isdefined( player.angles[ 1 ] ) )
    {
        yaw = player.angles[ 1 ];
    }
    
    roll = 0;
    
    if ( isdefined( player.angles[ 2 ] ) )
    {
        roll = player.angles[ 2 ];
    }
    
    player dlog_recordplayerevent( "dlog_event_dmz_workbench", [ "player_position_x", xpos, "player_position_y", ypos, "player_position_z", zpos, "player_rotation_pitch", pitch, "player_rotation_yaw", yaw, "player_rotation_roll", roll, "workbench_open_count", workbenchopencount, "workbench_was_weapon_edited", var_59c22e870aa17bfa, "workbench_weapon_edited_ref", weaponref, "workbench_weapon_slot_edited", weaponindex, "workbench_was_weapon_insured", var_91f506de78f8791f, "workbench_attachments_removed", attachmentsremoved, "workbench_attachments_added", attachmentspurchased, "workbench_cash_spent", cashspent, "workbench_time_spent", timespent, "workbench_session_ended_by_combat", forcedclosed ] );
    
    if ( isdefined( player.pers[ "telemetry" ].workbenchcashspent ) )
    {
        player.pers[ "telemetry" ].workbenchcashspent = 0;
    }
    
    if ( isdefined( player.pers[ "telemetry" ].var_78d18ea309ab2b10 ) )
    {
        player.pers[ "telemetry" ].var_78d18ea309ab2b10 = "";
    }
    
    attachmentsremoved = "";
    
    if ( isdefined( player.pers[ "telemetry" ].workbenchattachmentsremoved ) )
    {
        player.pers[ "telemetry" ].workbenchattachmentsremoved = "";
    }
}

