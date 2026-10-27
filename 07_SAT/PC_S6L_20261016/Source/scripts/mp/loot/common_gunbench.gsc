// scripts\mp\loot\common_gunbench.gsc  (hash_5caecb38ff9c6c2d.gscc) (size: 9902 Bytes / 0x26ae / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x933ba9fa (2470160890)
// size ...... 9902 (0x26ae)
// includes .. 16  (offset: 0x22f2)
// strings ... 39  (offset: 0x2372)
// dev strs .. 0   (offset: 0x26ae)
// exports ... 20  (offset: 0x17d2)
// cseg ...... 0x381 + 0x1451 (0x17d2)
// imports ... 70  (offset: 0x1af2)
// animtree1 . 0   (offset: 0x26ae)
// animtree2 . 0   (offset: 0x26ae)
#using script_16ea1b94f0f381b3;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\currency;
#using scripts\mp\loot\common_instance_inventory;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\loot\common_kiosk;

#namespace common_gunbench;

// Namespace common_gunbench
// Params 0, eflags: 0x5
// Checksum 0x42e9090c, Offset: 0x39f
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"common_gunbench", #"common_item", &init_gunbench, undefined );
}

// Namespace common_gunbench
// Params 0
// Checksum 0x6b8dd997, Offset: 0x3c8
// Size: 0x25
function init_gunbench()
{
    if ( !function_2ab0b4dca8482b09() )
    {
        return;
    }
    
    scriptable::scriptable_addusedcallbackbypart( "br_workbench", &use_gunbench );
    thread function_71044e7f34def746();
}

// Namespace common_gunbench
// Params 0
// Checksum 0x2334fd8f, Offset: 0x3f5
// Size: 0x3e, Type: bool
function function_2ab0b4dca8482b09()
{
    if ( !common_kiosk::function_5274212108b240d3() )
    {
        return false;
    }
    
    if ( !level.gametypebundle.var_80d6dda82f37d2a4 )
    {
        return false;
    }
    
    if ( !getdvarint( @"scr_enable_workbench", 1 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace common_gunbench
// Params 0, eflags: 0x4
// Checksum 0xe2ce5aab, Offset: 0x43c
// Size: 0x3f
function private function_71044e7f34def746()
{
    level endon( #"game_ended" );
    
    while ( !utility::issharedfuncdefined( #"game", #"registeronluieventcallback" ) )
    {
        wait 1;
    }
    
    namespace_9d8e359c3b1041e5::registeronluieventcallbacksharedfunc( &function_6e6bf8de17926033 );
}

// Namespace common_gunbench
// Params 6
// Checksum 0x13f4bf08, Offset: 0x483
// Size: 0x175
function use_gunbench( instance, part, state, player, bautouse, usestring )
{
    if ( !common_item::function_f107d23d5275a951( instance.type, "gunbench" ) )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        player = self;
    }
    
    if ( !player item_weapon::function_de6f68adce59a780() )
    {
        return;
    }
    
    if ( player.carryinghostage )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            player [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"mp/deny_use_carry" );
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
            newstate = "open";
            instance setscriptablepartstate( "br_workbench", newstate );
            instance thread common_kiosk::kioskfixupproneplayers();
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

// Namespace common_gunbench
// Params 2, eflags: 0x4
// Checksum 0xb51dff84, Offset: 0x600
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
    
    player thread common_kiosk::_watchtoautoclosemenu( kiosk );
    player calloutmarkerping::function_d34345aa1f30ebba();
}

// Namespace common_gunbench
// Params 1
// Checksum 0x7c77ddcb, Offset: 0x6f4
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

// Namespace common_gunbench
// Params 2
// Checksum 0x53424028, Offset: 0x780
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

// Namespace common_gunbench
// Params 2
// Checksum 0x2e52c848, Offset: 0x893
// Size: 0x342
function upgradeweapon( player, value )
{
    newattachmentindex = function_12c3dc6db53b4659( value );
    attachmentcost = 0;
    newattachment = undefined;
    assert( newattachmentindex == 15 || newattachmentindex < weapon::function_45ab75ece154ca8f() );
    
    if ( newattachmentindex != 15 && newattachmentindex < weapon::function_45ab75ece154ca8f() )
    {
        newattachment = player getplayerdata( level.loadoutsgroup, "upgradeWeapon", "attachmentSetup", newattachmentindex, "attachment" );
        attachmentcost = function_db72b9c539c26616( player );
    }
    
    upgradeweapon = player common_inventory::function_25c18fb30f61d5dd( level.loadoutsgroup, "upgradeWeapon" );
    assert( isdefined( upgradeweapon ) );
    
    if ( function_fb661bb159046f9c( player, upgradeweapon ) )
    {
        return;
    }
    
    var_e55499fe73434369 = currency::get_gunbench_currency();
    
    if ( !player currency::attempt_purchase( var_e55499fe73434369, attachmentcost, undefined, undefined, #"gunbench" ) )
    {
        return;
    }
    
    weaponindex = function_75e43f1d7d1c0696( value );
    var_51bce6fcf5d22557 = undefined;
    
    if ( weaponindex == 2 )
    {
        if ( common_instance_inventory::isenabled() )
        {
        }
        else
        {
            common_inventory::function_1923cd40e1b4efc8( upgradeweapon );
        }
    }
    else
    {
        slotname = item_weapon::function_72e6bdd2cc8a6199( weaponindex );
        var_51bce6fcf5d22557 = player item_weapon::function_e7484276ad85f220( slotname );
        ammoinclip = player getweaponammoclip( var_51bce6fcf5d22557 );
        var_d5c556bc8f734ddf = player getweaponammostock( var_51bce6fcf5d22557 );
        inventory_utility::_takeweapon( var_51bce6fcf5d22557 );
        player common_instance_inventory::function_1e5fd659146e4d80( weaponindex );
        player item_weapon::function_35910aac16378fec( upgradeweapon, ammoinclip, var_d5c556bc8f734ddf );
    }
    
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
        
        player.pers[ "telemetry" ].var_7c1ae2ca5233c19a = 1;
        player.pers[ "telemetry" ].weaponslotindex = weaponindex;
        
        if ( isdefined( newattachment ) )
        {
            function_932466384b9e20e6( player, newattachment, attachmentcost );
        }
    }
    
    itemtype = function_1cb7184bc422d538( upgradeweapon, newattachment );
    var_3a3fb91e35ecdb7 = upgradeweapon issilenced();
    var_b26b6655da6d9b96 = 0;
    
    if ( isdefined( var_51bce6fcf5d22557 ) )
    {
        var_b26b6655da6d9b96 = var_51bce6fcf5d22557 issilenced();
        
        if ( newattachmentindex == 15 )
        {
            function_bfb7481f4d86b53b( player, var_51bce6fcf5d22557, upgradeweapon );
        }
    }
    
    if ( game_utility::getgametype() == "dmz" )
    {
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
}

// Namespace common_gunbench
// Params 1
// Checksum 0x4b34b89b, Offset: 0xbdd
// Size: 0x4c
function function_db72b9c539c26616( player )
{
    baseprice = currency::get_gunbench_cost();
    
    if ( !common_instance_inventory::isenabled() )
    {
        return baseprice;
    }
    
    upgradediscount = player common_instance_inventory::function_e8c80d2fa9b2512e();
    return int( max( 0, baseprice - baseprice * upgradediscount ) );
}

// Namespace common_gunbench
// Params 1, eflags: 0x4
// Checksum 0xaebe342f, Offset: 0xc32
// Size: 0x11
function private function_75e43f1d7d1c0696( value )
{
    return value & 3;
}

// Namespace common_gunbench
// Params 1, eflags: 0x4
// Checksum 0x41facb4a, Offset: 0xc4c
// Size: 0x14
function private function_12c3dc6db53b4659( value )
{
    return ( value & 60 ) >> 2;
}

// Namespace common_gunbench
// Params 2
// Checksum 0x56d4500e, Offset: 0xc69
// Size: 0x165
function function_ec92e4bc68960cee( player, insuredslot )
{
    oldattachments = [];
    var_3bf6ce5b0607ff16 = [];
    maxprimaryattachments = weapon::function_45ab75ece154ca8f();
    
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

// Namespace common_gunbench
// Params 2
// Checksum 0xe4a31c57, Offset: 0xdd6
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

// Namespace common_gunbench
// Params 2
// Checksum 0x1c846e7f, Offset: 0xe32
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
    
    if ( player common_inventory::function_d33e11a8dda3cb20() )
    {
        playerdataweapon = player common_inventory::function_7bf60ff8870e96b4();
        
        if ( issameweapon( playerdataweapon, newweapon ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace common_gunbench
// Params 3
// Checksum 0xe52e6e3e, Offset: 0xefa
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

// Namespace common_gunbench
// Params 1
// Checksum 0x9c8f2dae, Offset: 0x1057
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

// Namespace common_gunbench
// Params 3
// Checksum 0x5d3c7be4, Offset: 0x10e5
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

// Namespace common_gunbench
// Params 1
// Checksum 0xd7a4b1ca, Offset: 0x1226
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

