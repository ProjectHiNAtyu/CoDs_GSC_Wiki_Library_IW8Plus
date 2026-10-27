// scripts\mp\common\equipment\armor_plate.gsc  (hash_387d176d911ba977.gscc) (size: 5675 Bytes / 0x162b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa91102e1 (2836464353)
// size ...... 5675 (0x162b)
// includes .. 11  (offset: 0x13e3)
// strings ... 31  (offset: 0x143b)
// dev strs .. 0   (offset: 0x162b)
// exports ... 14  (offset: 0xc53)
// cseg ...... 0x259 + 0x9fa (0xc53)
// imports ... 44  (offset: 0xe83)
// animtree1 . 0   (offset: 0x162b)
// animtree2 . 0   (offset: 0x162b)
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\equipment;
#using scripts\mp\hud_message;
#using scripts\mp\supers;

#namespace armor_plate;

// Namespace armor_plate
// Params 0
// Checksum 0x4b6ff499, Offset: 0x277
// Size: 0x11c
function br_armor_plate_used()
{
    assert( self.br_maxarmorhealth > 0 );
    armorammo = equipment_mp::getequipmentslotammo( "health" );
    
    if ( armorammo <= 0 )
    {
        return;
    }
    
    if ( self isparachuting() )
    {
        self notify( #"br_try_armor_cancel" );
        return;
    }
    
    if ( isdefined( self.armorqueued ) )
    {
        self.armorqueued--;
    }
    
    var_3c4b3ef26764ec25 = self.br_armorhealth + 5;
    newarmorhealth = clamp( var_3c4b3ef26764ec25, 0, self.br_maxarmorhealth );
    var_3b4517e2840c4873 = max( 1, getdvarint( @"scr_br_armor_heal_amount", 50 ) );
    newarmorhealth = int( newarmorhealth / var_3b4517e2840c4873 ) * var_3b4517e2840c4873 + var_3b4517e2840c4873;
    self.br_armorhealth = clamp( newarmorhealth, 0, self.br_maxarmorhealth );
    br_armor_plate_amount_equipped_set( self.br_armorhealth );
    equipment_mp::decrementequipmentslotammo( "health", 1 );
    challenges::function_4cfe18f48cc7a55c( self, undefined, level.armorref ?? "equip_armorplate" );
    self notify( #"armor_plate_inserted" );
}

// Namespace armor_plate
// Params 0
// Checksum 0x87084f30, Offset: 0x39b
// Size: 0xa8
function br_armor_plate_broken_remove()
{
    var_3c4b3ef26764ec25 = self.br_armorhealth + 5;
    newarmorhealth = clamp( var_3c4b3ef26764ec25, 0, self.br_maxarmorhealth );
    var_3b4517e2840c4873 = max( 1, getdvarint( @"scr_br_armor_heal_amount", 50 ) );
    newarmorhealth = int( newarmorhealth / var_3b4517e2840c4873 ) * var_3b4517e2840c4873;
    armorafter = clamp( newarmorhealth, 0, self.br_maxarmorhealth );
    
    if ( armorafter >= self.br_armorhealth )
    {
        return;
    }
    else
    {
        self.br_armorhealth = armorafter;
    }
    
    br_armor_plate_amount_equipped_set( self.br_armorhealth );
}

// Namespace armor_plate
// Params 1
// Checksum 0x52144cc7, Offset: 0x44b
// Size: 0x142
function br_armor_plate_amount_equipped_set( armorvalue )
{
    self setclientomnvar( "ui_armor_percent", int( armorvalue ) );
    br_public::updatebrscoreboardstat( "armorHealthRatio", int( armorvalue ) );
    squadmemberindex = self.sessionuimemberindex;
    
    if ( !( isdefined( squadmemberindex ) && isdefined( self.team ) ) )
    {
        return;
    }
    
    squadmates = level.teamdata[ self.team ][ "players" ];
    
    if ( isdefined( level.squaddata[ self.team ][ self.sessionsquadid ] ) )
    {
        squadmates = level.squaddata[ self.team ][ self.sessionsquadid ].players;
    }
    
    foreach ( player in squadmates )
    {
        player setclientomnvar( "ui_armor_squad_index_" + squadmemberindex, int( armorvalue ) );
    }
}

// Namespace armor_plate
// Params 2
// Checksum 0x3e489ed4, Offset: 0x595
// Size: 0xb6
function br_use_armor_plate( item, itemcount )
{
    self endon( #"disconnect" );
    
    if ( itemcount == 0 )
    {
        return;
    }
    else if ( self.insertingarmorplate )
    {
        return;
    }
    else if ( self isswitchingweapon() )
    {
        return;
    }
    
    if ( !br_is_allowed_armor_insert() )
    {
        return;
    }
    
    weaponobj = makeweapon( "armor_plate_deploy_mp" );
    streakinfo = killstreak_utility::createstreakinfo( "", self );
    streakinfo.armorweapon = weaponobj;
    br_toggle_armor_allows( 1 );
    thread br_watch_armor_cancel_notifys();
    switchresult = killstreakdeploy::switchtodeployweapon( weaponobj, streakinfo, &br_insert_armor, undefined, undefined, undefined, undefined, 0 );
}

// Namespace armor_plate
// Params 0
// Checksum 0x9c3203b4, Offset: 0x653
// Size: 0x7a
function br_watch_armor_cancel_notifys()
{
    self endon( #"hash_9b36be00d6abe5b1" );
    self endon( #"disconnect" );
    br_add_player_commands();
    thread br_watch_armor_weapon();
    self.stoparmorinsert = 0;
    utility::waittill_any( "death", "mantle_start", "last_stand_enter", "scr_change_swim_state", "special_weapon_fired", "br_try_armor_cancel", "br_armor_plate_done" );
    self notify( #"cancel_all_killstreak_deployments" );
    self.stoparmorinsert = 1;
    thread br_armor_repair_end();
}

// Namespace armor_plate
// Params 0
// Checksum 0x15c93f8e, Offset: 0x6d5
// Size: 0xc1
function br_watch_armor_weapon()
{
    self endon( #"disconnect" );
    self endon( #"hash_9b36be00d6abe5b1" );
    
    while ( isdefined( self.currentweapon ) && isdefined( self.currentweapon.basename ) && self.currentweapon.basename != "armor_plate_deploy_mp" )
    {
        if ( self isonladder() )
        {
            self notify( #"br_try_armor_cancel" );
        }
        
        waitframe();
    }
    
    while ( isdefined( self.currentweapon ) && self.currentweapon.basename == "armor_plate_deploy_mp" )
    {
        if ( self isonladder() )
        {
            self notify( #"br_try_armor_cancel" );
        }
        
        waitframe();
    }
    
    self notify( #"br_try_armor_cancel" );
}

// Namespace armor_plate
// Params 1
// Checksum 0x777b75e, Offset: 0x79e
// Size: 0xa9
function br_toggle_armor_allows( isusingarmor )
{
    if ( isusingarmor )
    {
        val::set( "using_armor", "melee", 0 );
        val::set( "using_armor", "killstreaks", 0 );
        val::set( "using_armor", "crate_use", 0 );
        val::set( "using_armor", "equipment_primary", 0 );
        val::set( "using_armor", "equipment_secondary", 0 );
        val::set( "using_armor", "offhand_weapons", 0 );
        val::set( "using_armor", "offhand_throwback", 0 );
    }
    else
    {
        val::reset_all( "using_armor" );
    }
    
    self.insertingarmorplate = isusingarmor;
}

// Namespace armor_plate
// Params 1
// Checksum 0x3e3e4bdc, Offset: 0x84f
// Size: 0x185
function br_insert_armor( streakinfo )
{
    self endon( #"disconnect" );
    self endon( #"hash_9b36be00d6abe5b1" );
    
    if ( !br_is_allowed_armor_insert() || self.stoparmorinsert )
    {
        return;
    }
    
    currenttime = gettime();
    var_1c5456e57812327c = currenttime + 1860;
    var_b3e5db6969dd616e = 2000;
    armorendtime = 1860;
    
    while ( currenttime < var_1c5456e57812327c )
    {
        if ( streakinfo.armorweapon != self getcurrentweapon() )
        {
            return;
        }
        
        waitframe();
        currenttime = gettime();
    }
    
    br_armor_plate_used();
    var_5517460be53dde17 = ( var_b3e5db6969dd616e - armorendtime ) / 1000;
    wait var_5517460be53dde17;
    
    while ( br_should_continue_adding_armor() )
    {
        itemname = self.equipment[ "health" ];
        itemcount = equipment_mp::getequipmentslotammo( "health" );
        
        if ( isdefined( itemname ) && isdefined( itemcount ) && itemcount > 0 && self.br_armorhealth < self.br_maxarmorhealth )
        {
            var_11624a363f806b48 = gettime() + 1250;
            
            while ( gettime() < var_11624a363f806b48 )
            {
                if ( streakinfo.armorweapon != self getcurrentweapon() )
                {
                    return;
                }
                
                waitframe();
            }
            
            br_armor_plate_used();
            var_3da70c5c0d9aa785 = 0.25;
            wait var_3da70c5c0d9aa785;
            continue;
        }
        
        break;
    }
    
    self notify( #"br_armor_plate_done" );
}

// Namespace armor_plate
// Params 0
// Checksum 0x480cd963, Offset: 0x9dc
// Size: 0xe9, Type: bool
function br_is_allowed_armor_insert()
{
    if ( isdefined( self.vehicle ) )
    {
        seat = vehicle_occupancy::get_occupant_seat( self.vehicle, self );
        
        if ( seat == "driver" )
        {
            return false;
        }
    }
    
    var_9c61278e70197e5e = self isskydiving() || self isonladder() || self isswimming();
    var_2b1d9ef7ce5e665c = player_utility::function_cdedd9a19069ca4c( self ) || self.isjuggernaut || supers_mp::issuperinuse() && self.super.staticdata.ref != "super_deadsilence";
    
    if ( var_9c61278e70197e5e || var_2b1d9ef7ce5e665c )
    {
        return false;
    }
    
    if ( self.br_armorhealth == self.br_maxarmorhealth )
    {
        hud_message::showerrormessage( level.br_pickups.br_pickupdenyarmorfull );
        return false;
    }
    
    return true;
}

// Namespace armor_plate
// Params 0
// Checksum 0x1073491, Offset: 0xace
// Size: 0x3a, Type: bool
function br_should_continue_adding_armor()
{
    isholdinggamepad = utility::is_player_gamepad_enabled() && self weaponswitchbuttonpressed();
    hasarmorqueue = self.armorqueued > 0;
    return isholdinggamepad || hasarmorqueue;
}

// Namespace armor_plate
// Params 0
// Checksum 0xffbe50ef, Offset: 0xb11
// Size: 0x62
function br_add_player_commands()
{
    self notifyonplayercommand( "br_try_armor_cancel", "+weapnext" );
    self notifyonplayercommand( "br_try_armor_cancel", "+weapprev" );
    self notifyonplayercommand( "br_try_armor_cancel", "+attack" );
    self notifyonplayercommand( "br_try_armor_cancel", "+smoke" );
    self notifyonplayercommand( "br_try_armor_cancel", "+frag" );
    self notifyonplayercommand( "br_try_armor_cancel", "+melee_zoom" );
}

// Namespace armor_plate
// Params 0
// Checksum 0xaa7356e8, Offset: 0xb7b
// Size: 0x62
function br_remove_player_commands()
{
    self notifyonplayercommandremove( "br_try_armor_cancel", "+weapnext" );
    self notifyonplayercommandremove( "br_try_armor_cancel", "+weapprev" );
    self notifyonplayercommandremove( "br_try_armor_cancel", "+attack" );
    self notifyonplayercommandremove( "br_try_armor_cancel", "+smoke" );
    self notifyonplayercommandremove( "br_try_armor_cancel", "+frag" );
    self notifyonplayercommandremove( "br_try_armor_cancel", "+melee_zoom" );
}

// Namespace armor_plate
// Params 0
// Checksum 0x974f03e0, Offset: 0xbe5
// Size: 0x6e
function br_armor_repair_end()
{
    self endon( #"disconnect" );
    self notify( #"hash_9b36be00d6abe5b1" );
    br_remove_player_commands();
    
    while ( isdefined( self.currentweapon ) && self.currentweapon.basename == "armor_plate_deploy_mp" )
    {
        waitframe();
    }
    
    waitframe();
    
    if ( self.armorqueued )
    {
        self.armorqueued = 0;
    }
    
    br_toggle_armor_allows( 0 );
}

