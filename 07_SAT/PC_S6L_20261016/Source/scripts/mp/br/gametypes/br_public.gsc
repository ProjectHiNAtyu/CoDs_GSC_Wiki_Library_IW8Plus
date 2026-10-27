// scripts\mp\br\gametypes\br_public.gsc  (hash_2aa77b5f4dfc2051.gscc) (size: 29796 Bytes / 0x7464 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa67b51c4 (2793099716)
// size ...... 29796 (0x7464)
// includes .. 32  (offset: 0x6d9c)
// strings ... 100 (offset: 0x6e9c)
// dev strs .. 11  (offset: 0x73e0)
// exports ... 132 (offset: 0x45e8)
// cseg ...... 0xa28 + 0x3bc0 (0x45e8)
// imports ... 160 (offset: 0x5a88)
// animtree1 . 0   (offset: 0x7464)
// animtree2 . 0   (offset: 0x7464)
#using scripts\common\bots\bots_util;
#using scripts\common\script;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_spawn;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\equipment\molotov;
#using scripts\mp\common\killstreaks\helper_drone;
#using scripts\mp\common\killstreaks\manual_turret;
#using scripts\mp\common\killstreaks\remoteuav;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\streamhint;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\hud_message;
#using scripts\mp\javelin;
#using scripts\mp\laststand;
#using scripts\mp\meatshield;
#using scripts\mp\operator;

#namespace br_public;

// Namespace br_public
// Params 1
// Checksum 0xabd8d583, Offset: 0xa46
// Size: 0x18, Type: bool
function iswaitingtoentergulag( player )
{
    return istrue( player.entergulagwait );
}

// Namespace br_public
// Params 1
// Checksum 0x8699135, Offset: 0xa67
// Size: 0x18, Type: bool
function isloadinggulag( player )
{
    return istrue( player.gulagloading );
}

// Namespace br_public
// Params 1
// Checksum 0x13c2f590, Offset: 0xa88
// Size: 0x18, Type: bool
function isrespawningfromtoken( player )
{
    return istrue( player.respawningfromtoken );
}

// Namespace br_public
// Params 0
// Checksum 0xb7dd340, Offset: 0xaa9
// Size: 0x18, Type: bool
function isplayeringulag()
{
    return self.jailed || self.gulagarena;
}

// Namespace br_public
// Params 0
// Checksum 0xee30f71d, Offset: 0xaca
// Size: 0x25, Type: bool
function isplayerinorgoingtogulag()
{
    return self.jailed || self.gulagarena || self.gulag;
}

// Namespace br_public
// Params 0
// Checksum 0x3f27b3c3, Offset: 0xaf8
// Size: 0x28, Type: bool
function function_200f54779296445e()
{
    return isdefined( self ) && isdefined( self.arena ) && self.arena.goagain;
}

// Namespace br_public
// Params 0
// Checksum 0x200e9ef0, Offset: 0xb29
// Size: 0xc, Type: bool
function function_4bbd58f4f9043df3()
{
    return istrue( self.wasingulag );
}

// Namespace br_public
// Params 0
// Checksum 0xacf63e68, Offset: 0xb3e
// Size: 0xd, Type: bool
function isplayerwaitingresurgencerespawn()
{
    return self.respawndelay > 0;
}

// Namespace br_public
// Params 0
// Checksum 0xe2c44568, Offset: 0xb54
// Size: 0x30, Type: bool
function iseligibleforteamrevive()
{
    return self.br_iseliminated && !isalive( self ) && ( !self.gulag || self.var_6aebb152eede315c );
}

// Namespace br_public
// Params 1
// Checksum 0x8a55cb0b, Offset: 0xb8d
// Size: 0x15, Type: bool
function isplayerdead( player )
{
    return !player::isreallyalive( player );
}

// Namespace br_public
// Params 1
// Checksum 0x6b859321, Offset: 0xbab
// Size: 0x17
function function_5a91d8c6c620f983( player )
{
    return player.br_iseliminated;
}

// Namespace br_public
// Params 0
// Checksum 0x16cd13a3, Offset: 0xbcb
// Size: 0x19
function function_73870bd0a4e2894d()
{
    if ( isusingmatchrulesdata() )
    {
        return getmatchrulesdata( "brData", "gondolaEnabled" );
    }
    
    return 0;
}

// Namespace br_public
// Params 0
// Checksum 0xd5a56ced, Offset: 0xbed
// Size: 0x28
function function_9dc52a7da56f6544()
{
    if ( isusingmatchrulesdata() )
    {
        return getmatchrulesdata( "brData", "trainEnabled" );
    }
    
    return getdvarint( @"scr_wztrain_enable", 0 ) > 0;
}

// Namespace br_public
// Params 0
// Checksum 0xbf76afcb, Offset: 0xc1e
// Size: 0xc, Type: bool
function playeriszombie()
{
    return istrue( self.iszombie );
}

// Namespace br_public
// Params 0
// Checksum 0x3c5fb156, Offset: 0xc33
// Size: 0xc, Type: bool
function function_f15af281b8fa7b96()
{
    return istrue( self.isghost );
}

// Namespace br_public
// Params 0
// Checksum 0xb3c8cce2, Offset: 0xc48
// Size: 0x40
function watchhealend()
{
    self endon( #"hash_d6e8f8a845e8dfe1" );
    self endon( #"death_or_disconnect" );
    self endon( #"armor_plate_done" );
    level endon( #"game_ended" );
    childthread heal_removeonplayernotifies();
    childthread heal_removeondamage();
}

// Namespace br_public
// Params 0
// Checksum 0x98f09761, Offset: 0xc90
// Size: 0x4a
function heal_removeonplayernotifies()
{
    self notifyonplayercommand( "try_heal_cancel", "+weapnext" );
    self notifyonplayercommand( "try_heal_cancel", "+attack" );
    self notifyonplayercommand( "try_heal_cancel", "+breath_sprint" );
    utility::waittill_any( "death", "try_heal_cancel" );
    healend();
}

// Namespace br_public
// Params 0
// Checksum 0xf548bae3, Offset: 0xce2
// Size: 0xa6
function heal_removeondamage()
{
    while ( true )
    {
        self waittill( #"damage", idamage, eattacker, vdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon );
        
        if ( isbrgamemode() && ( smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_UNKNOWN" ) )
        {
            continue;
        }
        
        healend();
    }
}

// Namespace br_public
// Params 0
// Checksum 0xecf5280a, Offset: 0xd90
// Size: 0x3e
function healend()
{
    self notifyonplayercommandremove( "try_heal_cancel", "+weapnext" );
    self notifyonplayercommandremove( "try_heal_cancel", "+attack" );
    self notifyonplayercommandremove( "try_heal_cancel", "+breath_sprint" );
    self notify( #"hash_d6e8f8a845e8dfe1" );
}

// Namespace br_public
// Params 1
// Checksum 0x1840b97c, Offset: 0xdd6
// Size: 0x2d
function removeitemfrominventory( slot )
{
    assert( isdefined( self.br_inventory_slots[ slot ] ) );
    self.br_inventory_slots[ slot ] = undefined;
}

// Namespace br_public
// Params 1
// Checksum 0xd4e4afc0, Offset: 0xe0b
// Size: 0x3b, Type: bool
function ishelmet( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"armor" && issubstr( scriptablename, "helmet" );
}

// Namespace br_public
// Params 1
// Checksum 0x7b4c85c9, Offset: 0xe4f
// Size: 0x14, Type: bool
function isarmor( scriptablename )
{
    return ishelmet( scriptablename );
}

// Namespace br_public
// Params 1
// Checksum 0xf1744ee3, Offset: 0xe6c
// Size: 0x14, Type: bool
function isarmorplate( scriptablename )
{
    return scriptablename == "brloot_armor_plate";
}

// Namespace br_public
// Params 1
// Checksum 0x144470a6, Offset: 0xe89
// Size: 0x3b, Type: bool
function function_d115f1547e28f0c6( scriptablename )
{
    return issubstr( scriptablename, "brloot_plate_carrier" ) || level.br_pickups.br_itemtype[ scriptablename ] == #"plate_carrier";
}

// Namespace br_public
// Params 1
// Checksum 0x787b8a27, Offset: 0xecd
// Size: 0x17
function isvoucher( scriptablename )
{
    return issubstr( scriptablename, "brloot_voucher" );
}

// Namespace br_public
// Params 1
// Checksum 0x9597d544, Offset: 0xeed
// Size: 0x52
function function_f7d29d5dab587ae1( scriptablename )
{
    if ( !isdefined( scriptablename ) )
    {
        return 1;
    }
    
    if ( issubstr( scriptablename, "brloot_plate_carrier_2" ) )
    {
        return 2;
    }
    
    if ( issubstr( scriptablename, "brloot_plate_carrier_3" ) || scriptablename == "brloot_plate_carrier_tempered" || scriptablename == "brloot_plate_carrier_high_capacity" )
    {
        return 3;
    }
    
    return 1;
}

// Namespace br_public
// Params 1
// Checksum 0xbacc944a, Offset: 0xf48
// Size: 0x39
function function_3a7d2e84c32519a9( platesize )
{
    if ( !isdefined( platesize ) || platesize <= 1 )
    {
        return;
    }
    
    if ( platesize == 2 )
    {
        return "brloot_plate_carrier_2";
    }
    
    if ( platesize == 3 )
    {
        return "brloot_plate_carrier_3";
    }
}

// Namespace br_public
// Params 1
// Checksum 0x174ae6fd, Offset: 0xf8a
// Size: 0x2c, Type: bool
function ishealitem( scriptablename )
{
    return scriptablename == "brloot_health_bandages" || scriptablename == "brloot_health_firstaid" || scriptablename == "brloot_health_adrenaline";
}

// Namespace br_public
// Params 1
// Checksum 0xb7097060, Offset: 0xfbf
// Size: 0x20, Type: bool
function isheartbeatsensor( scriptablename )
{
    return scriptablename == "brloot_offhand_heartbeatsensor" || scriptablename == "brloot_super_heartbeatsensor";
}

// Namespace br_public
// Params 1
// Checksum 0x6af51d88, Offset: 0xfe8
// Size: 0x68, Type: bool
function isequipment( scriptablename )
{
    return isarmorplate( scriptablename ) || ishealitem( scriptablename ) || level.br_pickups.br_itemtype[ scriptablename ] == #"lethal" || level.br_pickups.br_itemtype[ scriptablename ] == #"tactical";
}

// Namespace br_public
// Params 1
// Checksum 0x99b2077b, Offset: 0x1059
// Size: 0x2c, Type: bool
function isequipmentlethal( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"lethal";
}

// Namespace br_public
// Params 1
// Checksum 0x97557e14, Offset: 0x108e
// Size: 0x2c, Type: bool
function isequipmenttactical( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"tactical";
}

// Namespace br_public
// Params 1
// Checksum 0xebb63322, Offset: 0x10c3
// Size: 0x2c, Type: bool
function isammo( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"ammo";
}

// Namespace br_public
// Params 1
// Checksum 0xc8dde5c, Offset: 0x10f8
// Size: 0x2c, Type: bool
function istoken( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"token";
}

// Namespace br_public
// Params 1
// Checksum 0xc37d121e, Offset: 0x112d
// Size: 0x2c, Type: bool
function iskiosk( scriptablename )
{
    return scriptablename == "br_plunder_box" || scriptablename == "br_plunder_box_high_tier" || scriptablename == "br_plunder_box_nocollision";
}

// Namespace br_public
// Params 1
// Checksum 0xe86565cd, Offset: 0x1162
// Size: 0x14, Type: bool
function isdeployablekiosk( scriptablename )
{
    return scriptablename == "drone_deployable_kiosk";
}

// Namespace br_public
// Params 1
// Checksum 0x544cade2, Offset: 0x117f
// Size: 0x14, Type: bool
function isweaponupgrade( scriptablename )
{
    return scriptablename == "br_workbench";
}

// Namespace br_public
// Params 1
// Checksum 0xdbc7e5b0, Offset: 0x119c
// Size: 0x14, Type: bool
function function_dea12ed962e61597( scriptablename )
{
    return scriptablename == "br_plunder_box_stronghold";
}

// Namespace br_public
// Params 1
// Checksum 0xaed3bb40, Offset: 0x11b9
// Size: 0x22
function function_3b368f59d476261e( scriptablename )
{
    return level.br_pickups.br_specialitem[ scriptablename ];
}

// Namespace br_public
// Params 1
// Checksum 0xd068edc4, Offset: 0x11e4
// Size: 0x67, Type: bool
function isloadoutdrop( scriptablename )
{
    isequipment = isdefined( scriptablename ) && isequipment( scriptablename );
    isarmor = isdefined( scriptablename ) && isarmor( scriptablename );
    isammo = isdefined( scriptablename ) && isammo( scriptablename );
    return isequipment || isarmor || isammo;
}

// Namespace br_public
// Params 0
// Checksum 0xa6f9bac4, Offset: 0x1254
// Size: 0x6e, Type: bool
function playercanplaynotcriticalgesture()
{
    if ( self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || player::isplayerads() || self.insertingarmorplate )
    {
        return false;
    }
    
    curweap = self getcurrentweapon();
    
    if ( isnullweapon( curweap ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_public
// Params 0
// Checksum 0xabee880d, Offset: 0x12cb
// Size: 0x3e
function hasrespawntoken()
{
    return function_2d9074b461a9f5cb() ? self.hasrespawntoken && isdefined( self.var_ccf5a598b0d5582e ) && self.var_ccf5a598b0d5582e > 0 : istrue( self.hasrespawntoken );
}

// Namespace br_public
// Params 0
// Checksum 0x5eaf8c33, Offset: 0x1312
// Size: 0x12, Type: bool
function function_2d9074b461a9f5cb()
{
    return getdvarint( @"hash_2015fbf6cf89f38c", 0 ) != 0;
}

// Namespace br_public
// Params 0
// Checksum 0x1c10692b, Offset: 0x132d
// Size: 0x61
function function_ec4d7cb61b4d915e()
{
    player = self;
    
    if ( !function_2d9074b461a9f5cb() )
    {
        return ( player.hasrespawntoken ? 1 : 0 );
    }
    
    if ( !isdefined( player.var_ccf5a598b0d5582e ) )
    {
        return 0;
    }
    
    return player.hasrespawntoken ? player.var_ccf5a598b0d5582e : 0;
}

// Namespace br_public
// Params 0
// Checksum 0x4fd18ae6, Offset: 0x1396
// Size: 0x6f
function function_f8e966575e96628e()
{
    player = self;
    
    if ( !function_2d9074b461a9f5cb() )
    {
        return player.hasrespawntoken;
    }
    
    if ( !isdefined( player.var_ccf5a598b0d5582e ) )
    {
        return 0;
    }
    
    if ( player.hasrespawntoken && player.var_ccf5a598b0d5582e >= getdvarint( @"hash_70e23890d2ce185b", 1 ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace br_public
// Params 0
// Checksum 0xda8cfa6b, Offset: 0x140d
// Size: 0x1b, Type: bool
function function_70c1f4b75530023f()
{
    player = self;
    return istrue( player.var_70c1f4b75530023f );
}

// Namespace br_public
// Params 0
// Checksum 0xd6a038c3, Offset: 0x1431
// Size: 0x52, Type: bool
function function_b648dc1bd1363daf()
{
    return !level.br_pickups.var_1a2dcc64a08f0324 || level.br_pickups.var_7dc8a97db7af6e3 && isdefined( level.gulag ) && level.gulag.shutdown;
}

// Namespace br_public
// Params 2
// Checksum 0xe808788b, Offset: 0x148c
// Size: 0x3c, Type: bool
function function_69153dc21f82c59a( player, scriptablename )
{
    if ( !( isdefined( player ) && isdefined( scriptablename ) ) )
    {
        return false;
    }
    
    currentselfrevive = function_a62f204c9c901e6f( player );
    return currentselfrevive == scriptablename;
}

// Namespace br_public
// Params 1
// Checksum 0xf5e00075, Offset: 0x14d1
// Size: 0x47
function function_a62f204c9c901e6f( player )
{
    if ( !isdefined( player ) || !player laststand::hasselfrevivetoken() || !isdefined( player.selfrevivedata ) )
    {
        return;
    }
    
    return player.selfrevivedata.name;
}

// Namespace br_public
// Params 1
// Checksum 0xfe7bf2f6, Offset: 0x1521
// Size: 0x47
function function_af655f4c315d1874( player )
{
    if ( !isdefined( player ) || !player laststand::hasselfrevivetoken() || !isdefined( player.selfrevivedata ) )
    {
        return;
    }
    
    return player.selfrevivedata.perk;
}

// Namespace br_public
// Params 1
// Checksum 0xfe7bf2f6, Offset: 0x1571
// Size: 0x47
function function_d889bda49cd10c98( player )
{
    if ( !isdefined( player ) || !player laststand::hasselfrevivetoken() || !isdefined( player.selfrevivedata ) )
    {
        return;
    }
    
    return player.selfrevivedata.type;
}

// Namespace br_public
// Params 1
// Checksum 0x793bbc16, Offset: 0x15c1
// Size: 0x3c
function function_f448cf07ef04a61b( scriptablename )
{
    if ( !isdefined( scriptablename ) )
    {
        return 0;
    }
    
    switch ( scriptablename )
    {
        case #"hash_b3bbb437bf12b40a":
            return 1;
        default:
            return 0;
    }
}

// Namespace br_public
// Params 1
// Checksum 0x35903fbf, Offset: 0x1605
// Size: 0x3d
function function_232a41fcb87530a7( scriptablename )
{
    if ( !isdefined( scriptablename ) )
    {
        return;
    }
    
    switch ( scriptablename )
    {
        case #"hash_b3bbb437bf12b40a":
            return "specialty_br_faster_revive";
        default:
            return;
    }
}

// Namespace br_public
// Params 0
// Checksum 0xda8cfa6b, Offset: 0x164a
// Size: 0x1b, Type: bool
function hasplatepouch()
{
    player = self;
    return istrue( player.hasplatepouch );
}

// Namespace br_public
// Params 0
// Checksum 0x55ed4a4d, Offset: 0x166e
// Size: 0x1b, Type: bool
function hasspecialistbonus()
{
    player = self;
    return istrue( player.hasbrspecialistbonus );
}

// Namespace br_public
// Params 1
// Checksum 0x88464a8e, Offset: 0x1692
// Size: 0x4e
function hasaccesscard( specifictype )
{
    player = self;
    
    if ( !( isdefined( specifictype ) && isdefined( player.accesscard ) ) )
    {
        return isdefined( player.accesscard );
    }
    
    return specifictype == player.accesscard;
}

// Namespace br_public
// Params 1
// Checksum 0x4036cf05, Offset: 0x16e8
// Size: 0x14
function haskey( lootid )
{
    return br_default_inventory::function_46da5d3784eb9b40( lootid );
}

// Namespace br_public
// Params 1
// Checksum 0xc3905c62, Offset: 0x1705
// Size: 0x2d1
function cleanac130struct( planestruct )
{
    if ( isdefined( planestruct.playerslot1 ) )
    {
        if ( isdefined( planestruct.playerslot1.head ) )
        {
            planestruct.playerslot1.head delete();
        }
        
        if ( isdefined( planestruct.playerslot1.helmet ) )
        {
            planestruct.playerslot1.helmet delete();
        }
        
        planestruct.playerslot1 delete();
    }
    
    if ( isdefined( planestruct.playerslot2 ) )
    {
        if ( isdefined( planestruct.playerslot2.head ) )
        {
            planestruct.playerslot2.head delete();
        }
        
        planestruct.playerslot2 delete();
    }
    
    if ( isdefined( planestruct.playerslot3 ) )
    {
        planestruct.playerslot3 delete();
    }
    
    if ( isdefined( planestruct.playerslot4 ) )
    {
        planestruct.playerslot4 delete();
    }
    
    if ( isdefined( planestruct.aidoorchief ) )
    {
        planestruct.aidoorchief delete();
    }
    
    if ( isdefined( planestruct.cameraent ) )
    {
        planestruct.cameraent delete();
    }
    
    if ( isdefined( planestruct.cameraentmoving ) )
    {
        planestruct.cameraentmoving delete();
    }
    
    if ( isdefined( planestruct.playerpositionents ) )
    {
        foreach ( ent in planestruct.playerpositionents )
        {
            ent delete();
        }
    }
    
    if ( isdefined( planestruct.cloudcoverfx ) )
    {
        planestruct.cloudcoverfx delete();
    }
    
    if ( isdefined( planestruct.staticc130 ) && planestruct.staticc130.cleanme )
    {
        planestruct.staticc130 delete();
    }
    
    if ( isdefined( planestruct.movingc130 ) && planestruct.movingc130.cleanme )
    {
        if ( planestruct.movingc130.innards.cleanme )
        {
            planestruct.movingc130.innards delete();
        }
        
        planestruct.movingc130 delete();
    }
}

// Namespace br_public
// Params 0
// Checksum 0x2a49583b, Offset: 0x19de
// Size: 0x16
function function_c61dc6b780cede50()
{
    player = self;
    player function_4bdf2fa26c2d815d();
}

// Namespace br_public
// Params 2
// Checksum 0xc406eaeb, Offset: 0x19fc
// Size: 0x5b1
function updatebrscoreboardstat( statname, value )
{
    if ( !isdefined( value ) )
    {
        /#
            script::demoforcesre( "<dev string:x24>" + statname );
        #/
        
        return;
    }
    
    player = self;
    assert( isplayer( player ) );
    assert( isstring( statname ) );
    bitoffset = 0;
    bitwidth = 0;
    infoindex = 0;
    var_b4745ef5fcef3bc9 = 0;
    
    switch ( statname )
    {
        case #"hash_30a2bd77d6fd595f":
            [ bitoffset, bitwidth, infoindex ] = [ 0, 8, 0 ];
            break;
        case #"hash_80e2211904012a81":
            [ bitoffset, bitwidth, infoindex ] = [ 0, 12, 0 ];
            break;
        case #"hash_b05aede94835bd45":
            [ bitoffset, bitwidth, infoindex ] = [ 0, 15, 0 ];
            break;
        case #"hash_6d7da638af8fecbb":
            [ bitoffset, bitwidth, infoindex ] = [ 0, 8, 1 ];
            break;
        case #"hash_67733e84369e4cb1":
            [ bitoffset, bitwidth, infoindex ] = [ 0, 8, 1 ];
            break;
        case #"hash_b0f342895fb227f9":
            [ bitoffset, bitwidth, infoindex ] = [ 8, 7, 1 ];
            break;
        case #"hash_16a3898de48ed541":
            [ bitoffset, bitwidth, infoindex ] = [ 0, 8, 2 ];
            break;
        case #"hash_ecd8ab7521415233":
            [ bitoffset, bitwidth, infoindex ] = [ 8, 4, 2 ];
            break;
        case #"hash_e806c669b1968751":
            [ bitoffset, bitwidth, infoindex ] = [ 12, 3, 2 ];
            break;
        case #"hash_7423dc1edc0a169a":
            [ bitoffset, bitwidth, infoindex ] = [ 15, 1, 2 ];
            break;
        case #"hash_b90a4e6c283d0c06":
            [ bitoffset, bitwidth, infoindex ] = [ 0, 16, 3 ];
            break;
        case #"hash_f43fd3867872aef3":
            [ bitoffset, bitwidth, infoindex ] = [ 0, 10, 4 ];
            break;
        case #"hash_837c8aaaaaa8c5ab":
            [ bitoffset, bitwidth, infoindex ] = [ 10, 6, 4 ];
            break;
        case #"hash_97c4881805a48fcc":
            [ bitoffset, bitwidth, infoindex ] = [ 0, 2, 5 ];
            break;
        case #"hash_9eaf5b602890d1cf":
            [ bitoffset, bitwidth, infoindex ] = [ 2, 5, 5 ];
            break;
        case #"hash_b2f1c851d3e528be":
            [ bitoffset, bitwidth, infoindex ] = [ 7, 3, 5 ];
            break;
        case #"hash_d51f323231c74144":
            [ bitoffset, bitwidth, infoindex ] = [ 10, 1, 5 ];
            break;
        case #"hash_6b7ae20b0a7395fe":
            [ bitoffset, bitwidth, infoindex ] = [ 11, 1, 5 ];
            break;
        case #"hash_1580ef2bedfde211":
        case #"hash_466dcff665608ca0":
        case #"hash_6f4e7e5330c0b130":
        case #"hash_985d10ac4d0e3bcc":
        case #"hash_a356e771faafb08c":
        case #"hash_a765c47eedad2989":
        case #"hash_f933905aabddd9c7":
            var_b4745ef5fcef3bc9 = 1;
            break;
        default:
            assertmsg( "<dev string:x5e>" + statname + "<dev string:x74>" );
            return;
    }
    
    if ( getprojectname() == "REW" && value > 1 << bitwidth )
    {
        return;
    }
    
    assert( value < 1 << bitwidth || var_b4745ef5fcef3bc9, "<dev string:x8d>" + statname + "<dev string:x9e>" + value + "<dev string:xaa>" );
    player packstatintoextrainfo( value, bitoffset, bitwidth, infoindex );
}

// Namespace br_public
// Params 4
// Checksum 0x62d7e7ad, Offset: 0x1fb5
// Size: 0x1bc
function packstatintoextrainfo( value, bitoffset, bitwidth, infoindex )
{
    player = self;
    infovalues = [ player.extrascore0, player.extrascore1, player.extrascore2, player.extrascore3, player.extrascore4, player.extrascore5 ];
    mask = ( 1 << bitwidth ) - 1;
    shiftedvalue = ( value & mask ) << bitoffset;
    invertedmask = ~( mask << bitoffset );
    prevvalue = infovalues[ infoindex ];
    cleanedbase = prevvalue & invertedmask;
    repackedvalue = cleanedbase + shiftedvalue;
    
    switch ( infoindex )
    {
        case 0:
            player.extrascore0 = repackedvalue;
            break;
        case 1:
            player.extrascore1 = repackedvalue;
            break;
        case 2:
            player.extrascore2 = repackedvalue;
            break;
        case 3:
            player.extrascore3 = repackedvalue;
            break;
        case 4:
            player.extrascore4 = repackedvalue;
            break;
        case 5:
            player.extrascore5 = repackedvalue;
            break;
        default:
            break;
    }
}

// Namespace br_public
// Params 1
// Checksum 0x5757690c, Offset: 0x2179
// Size: 0x57
function setplayerdownedextrainfo( value )
{
    laststand::function_c26a7c4bf9ba9d98( self, "Downed icon set to " + value + " in br_public.gsc" );
    
    if ( value )
    {
        self.game_extrainfo |= 256;
        return;
    }
    
    self.game_extrainfo &= ~256;
}

// Namespace br_public
// Params 1
// Checksum 0xf1ea4459, Offset: 0x21d8
// Size: 0x45
function function_2b3eecf2f265dd02( value )
{
    if ( value )
    {
        self.game_extrainfo |= 1048576;
        return;
    }
    
    self.game_extrainfo &= ~1048576;
}

// Namespace br_public
// Params 1
// Checksum 0x4d7c8b8d, Offset: 0x2225
// Size: 0x45
function function_47a09f1100546e96( value )
{
    if ( value )
    {
        self.game_extrainfo |= 2097152;
        return;
    }
    
    self.game_extrainfo &= ~2097152;
}

// Namespace br_public
// Params 1
// Checksum 0x40b4d574, Offset: 0x2272
// Size: 0x41
function setplayerbeingrevivedextrainfo( value )
{
    if ( value )
    {
        self.game_extrainfo |= 512;
        return;
    }
    
    self.game_extrainfo &= ~512;
}

// Namespace br_public
// Params 1
// Checksum 0x3c38dda4, Offset: 0x22bb
// Size: 0x41
function setplayerselfrevivingextrainfo( value )
{
    if ( value )
    {
        self.game_extrainfo |= 1024;
        return;
    }
    
    self.game_extrainfo &= ~1024;
}

// Namespace br_public
// Params 1
// Checksum 0xdce11c71, Offset: 0x2304
// Size: 0x45
function setplayermostwantedextrainfo( value )
{
    if ( value )
    {
        self.game_extrainfo |= 262144;
        return;
    }
    
    self.game_extrainfo &= ~262144;
}

// Namespace br_public
// Params 1
// Checksum 0xe68b8e0f, Offset: 0x2351
// Size: 0x45
function sethasrespawntokenextrainfo( value )
{
    if ( value )
    {
        self.game_extrainfo |= 524288;
        return;
    }
    
    self.game_extrainfo &= ~524288;
}

// Namespace br_public
// Params 0
// Checksum 0xf9c5ad76, Offset: 0x239e
// Size: 0x13c
function incrementplayersdownedstat()
{
    player = self;
    
    if ( !isdefined( player.br_playersdowned ) )
    {
        player.br_playersdowned = 0;
    }
    
    player.br_playersdowned++;
    player updatebrscoreboardstat( "playersDowned", player.br_playersdowned );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "downs" ] ) )
        {
            player.leaderboarddata[ "downs" ] = player.leaderboarddata[ "downs" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "downs" ] ) )
        {
            [[ level.leaderboardfunc[ "downs" ] ]]( player, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:xc9>" );
        
        if ( isdefined( player.pers[ "downs" ] ) )
        {
            player.pers[ "downs" ] = player.pers[ "downs" ] + 1;
        }
    }
    
    player codcasterclientmatchdata::function_8ecc753b54a5740f( 16, 1 );
}

// Namespace br_public
// Params 1
// Checksum 0xd355cfc2, Offset: 0x24e2
// Size: 0x45
function function_99e432af35c80c99( value )
{
    if ( value )
    {
        self.game_extrainfo |= 4194304;
        return;
    }
    
    self.game_extrainfo &= ~4194304;
}

// Namespace br_public
// Params 1
// Checksum 0xe2459046, Offset: 0x252f
// Size: 0x45
function function_4b66f0c3d7997b1a( value )
{
    if ( value )
    {
        self.game_extrainfo |= 8388608;
        return;
    }
    
    self.game_extrainfo &= ~8388608;
}

// Namespace br_public
// Params 1
// Checksum 0x528f2869, Offset: 0x257c
// Size: 0x45
function function_99cb14b2b9be7b27( value )
{
    if ( value )
    {
        self.game_extrainfo |= 16777216;
        return;
    }
    
    self.game_extrainfo &= ~16777216;
}

// Namespace br_public
// Params 1
// Checksum 0x21d479e2, Offset: 0x25c9
// Size: 0x45
function function_7813786b92d850ff( value )
{
    if ( value )
    {
        self.game_extrainfo |= 33554432;
        return;
    }
    
    self.game_extrainfo &= ~33554432;
}

// Namespace br_public
// Params 0
// Checksum 0xad4f9fbd, Offset: 0x2616
// Size: 0x5b, Type: bool
function isplayerbrsquadleader()
{
    player = self;
    
    /#
        if ( player.isbrsquadleader != player.game_extrainfo & 16384 )
        {
            assertmsg( "<dev string:xef>" );
        }
    #/
    
    return player.isbrsquadleader && player.game_extrainfo & 16384;
}

// Namespace br_public
// Params 2
// Checksum 0xf50b2423, Offset: 0x267a
// Size: 0xad
function brbroadcastplayercardsplash( splash, optionalnumber )
{
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( player isplayeringulag() )
        {
            continue;
        }
        
        player thread hud_message::showsplash( splash, optionalnumber, player );
    }
}

// Namespace br_public
// Params 9
// Checksum 0x59ff7974, Offset: 0x272f
// Size: 0x100
function brleaderdialogteamexcludeplayer( dialog, team, excludeplayer, excludegulag, allowdead, delay, var_144dbd587acfc8fd, prefixoverride, var_963f12470be1ae88 )
{
    assert( isplayer( excludeplayer ) );
    
    foreach ( teammate in level.teamdata[ team ][ "players" ] )
    {
        if ( !isdefined( teammate ) )
        {
            continue;
        }
        
        if ( teammate != excludeplayer )
        {
            brleaderdialogplayer( dialog, teammate, excludegulag, allowdead, delay, var_144dbd587acfc8fd, prefixoverride, undefined, var_963f12470be1ae88 );
        }
    }
}

// Namespace br_public
// Params 9
// Checksum 0xf7845e3a, Offset: 0x2837
// Size: 0x7b
function function_d37b11df5bdfb45b( dialog, team, squadindex, excludegulag, delay, var_144dbd587acfc8fd, prefixoverride, allowdead, var_963f12470be1ae88 )
{
    squadmates = teams::getsquadmates( team, squadindex );
    brleaderdialog( dialog, excludegulag, squadmates, allowdead, delay, var_144dbd587acfc8fd, prefixoverride, var_963f12470be1ae88 );
}

// Namespace br_public
// Params 8
// Checksum 0xb77959d, Offset: 0x28ba
// Size: 0x6e
function brleaderdialogteam( dialog, team, excludegulag, delay, var_144dbd587acfc8fd, prefixoverride, allowdead, var_963f12470be1ae88 )
{
    brleaderdialog( dialog, excludegulag, level.teamdata[ team ][ "players" ], allowdead, delay, var_144dbd587acfc8fd, prefixoverride, var_963f12470be1ae88 );
}

// Namespace br_public
// Params 8
// Checksum 0x96bc54a6, Offset: 0x2930
// Size: 0x118
function brleaderdialog( dialog, excludegulag, playersoverride, allowdead, delay, var_144dbd587acfc8fd, prefixoverride, var_963f12470be1ae88 )
{
    if ( !isdefined( game[ "dialog" ][ dialog ] ) )
    {
        println( "<dev string:x132>" + dialog + "<dev string:x13a>" );
        return;
    }
    
    players = playersoverride ?? level.players;
    soundname = function_98922162e13bc0aa( dialog, prefixoverride );
    
    foreach ( player in players )
    {
        thread brleaderdialogplayer( dialog, player, excludegulag, allowdead, delay, var_144dbd587acfc8fd, prefixoverride, soundname, var_963f12470be1ae88 );
    }
}

// Namespace br_public
// Params 2
// Checksum 0xc52ed9df, Offset: 0x2a50
// Size: 0xd0, Type: bool
function modeplayerskipdialog( dialog, excludegulag = 1 )
{
    if ( excludegulag && isplayeringulag() )
    {
        return true;
    }
    
    if ( self.playinggulagbink )
    {
        return true;
    }
    
    if ( isbrpracticemode() )
    {
        if ( self.playingtutorialdialogue )
        {
            return true;
        }
        
        if ( dialog == "deploy_squad_leader" || dialog == "prematch_enter" )
        {
            return true;
        }
        
        if ( ( dialog == "circle_closing" || dialog == "first_circle" ) && !level.playerumpedfromplane )
        {
            return true;
        }
    }
    
    issolos = level.maxteamsize == 1;
    
    if ( issolos )
    {
        switch ( dialog )
        {
            case #"hash_8c7e4eedbb3a6dd9":
                return true;
        }
    }
    
    return false;
}

// Namespace br_public
// Params 0
// Checksum 0x7371c36f, Offset: 0x2b29
// Size: 0x15
function function_1fdd9360c6f92759()
{
    return [ "allies", "axis" ];
}

// Namespace br_public
// Params 1
// Checksum 0xb1952be5, Offset: 0x2b47
// Size: 0x55
function brgetoperatorteam( player )
{
    if ( isai( player ) )
    {
        operatorteam = player.botoperatorteam;
    }
    else
    {
        operatorteam = player operator::function_1e32019139bf7206();
    }
    
    if ( istutorial() || isbrpracticemode() )
    {
        operatorteam = "allies";
    }
    
    return operatorteam;
}

// Namespace br_public
// Params 10
// Checksum 0xf4ee2f9c, Offset: 0x2ba5
// Size: 0x1e2
function brleaderdialogplayer( dialog, player, excludegulag, allowdead, delay, var_144dbd587acfc8fd, prefixoverride, soundname, var_963f12470be1ae88, replace_group )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( isdefined( level.br_ending ) && var_963f12470be1ae88 )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( player.isdisconnecting )
    {
        return;
    }
    
    if ( !isdefined( allowdead ) )
    {
        allowdead = getdvarint( @"hash_a6587a24d2081693", 1 );
    }
    
    if ( !isalive( player ) && !allowdead )
    {
        return;
    }
    
    if ( player.extracted )
    {
        return;
    }
    
    if ( isplayer( player ) && player issplitscreenplayer() && !player issplitscreenplayerprimary() )
    {
        return;
    }
    
    if ( player modeplayerskipdialog( dialog, excludegulag ) )
    {
        return;
    }
    
    if ( istutorial() || isbrpracticemode() )
    {
        if ( dialog == "mission_scav_accept" || dialog == "mission_obj_next_nptarget" )
        {
            return;
        }
    }
    
    if ( !isdefined( soundname ) )
    {
        soundname = function_98922162e13bc0aa( dialog, prefixoverride );
    }
    
    if ( isdefined( soundname ) )
    {
        soundname = tolower( soundname );
        
        if ( soundexists( soundname ) )
        {
            soundlength = lookupsoundlength( soundname, 1 ) / 1000;
            
            if ( delay >= level.framedurationseconds )
            {
                wait delay;
            }
            
            group = replace_group ? replace_group.group : undefined;
            replaceexisting = replace_group ? replace_group.replaceexisting : 0;
            player queuedialogforplayer( #"queue1", soundname, dialog, soundlength, group, replaceexisting );
            return;
        }
        
        function_c8080a201232c345( soundname );
    }
}

// Namespace br_public
// Params 2
// Checksum 0xf8e43ee, Offset: 0x2d8f
// Size: 0xd5
function function_98922162e13bc0aa( dialog, prefixoverride )
{
    if ( !isdefined( level.var_4dbf349a7cabc44e ) )
    {
        level.var_4dbf349a7cabc44e = [];
    }
    
    soundindex = dialog;
    
    if ( isdefined( prefixoverride ) )
    {
        soundindex += prefixoverride;
    }
    
    var_7237854e3be197ca = level.var_4dbf349a7cabc44e[ soundindex ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( !isdefined( prefixoverride ) )
    {
        prefixoverride = game[ "dialog_prefix" ][ dialog ];
    }
    
    prefix = string( prefixoverride ?? "dx_br_brdm_" );
    soundname = prefix + game[ "dialog" ][ dialog ];
    soundname = function_cf160870cf43013b( game[ "dialog" ][ dialog ], prefix, soundname );
    
    if ( isdefined( soundname ) )
    {
        soundname = tolower( soundname );
    }
    
    level.var_4dbf349a7cabc44e[ soundindex ] = soundname;
    return soundname;
}

// Namespace br_public
// Params 3, eflags: 0x4
// Checksum 0x4f28fd43, Offset: 0x2e6d
// Size: 0x14b
function private function_6fa0d4b79921f7bf( dialogalias, prefix, var_dedde72fd00bbda1 )
{
    var_46593b5eda38f377 = strtok( dialogalias, "_" );
    updatedstring = "";
    
    for ( i = 0; i < var_46593b5eda38f377.size ; i++ )
    {
        if ( i != 0 )
        {
            updatedstring += "_";
        }
        
        var_92dcf9b0ab0da824 = var_46593b5eda38f377[ i ];
        refname = function_762861273300a7f1( var_92dcf9b0ab0da824 );
        
        if ( refname == "" )
        {
            refname = tablelookup( "sound/tables/iw9/dialog/gamedef_ref_table.csv", 2, var_92dcf9b0ab0da824, 1 );
            
            if ( refname )
            {
                if ( var_92dcf9b0ab0da824 == "gams" )
                {
                    var_6e209c6dcd5b7eb1 = "gmst";
                }
                else
                {
                    var_6e209c6dcd5b7eb1 = tablelookup( "sound/tables/s6/dialog/gamedef_ref_table.csv", 1, refname, 2 );
                }
                
                switch ( var_6e209c6dcd5b7eb1 )
                {
                    case #"hash_6dabe074177d7643":
                        var_6e209c6dcd5b7eb1 = "grav";
                        break;
                    default:
                        break;
                }
                
                updatedstring += var_6e209c6dcd5b7eb1;
                function_a90c6661be1987bd( var_92dcf9b0ab0da824, var_6e209c6dcd5b7eb1 );
            }
            else
            {
                updatedstring += var_46593b5eda38f377[ i ];
            }
            
            continue;
        }
        
        updatedstring += refname;
    }
    
    updatedstring = prefix + updatedstring;
    level.var_f2906e227b434955[ dialogalias ][ prefix ][ var_dedde72fd00bbda1 ] = updatedstring;
    return updatedstring;
}

// Namespace br_public
// Params 3
// Checksum 0xf1a076ec, Offset: 0x2fc1
// Size: 0x9c
function function_cf160870cf43013b( dialogalias, prefix, var_dedde72fd00bbda1 )
{
    soundname = var_dedde72fd00bbda1;
    
    if ( !issubstr( dialogalias, "wzan" ) )
    {
        return soundname;
    }
    
    if ( !isdefined( level.var_f2906e227b434955 ) )
    {
        level.var_f2906e227b434955 = [];
    }
    
    newalias = level.var_f2906e227b434955[ dialogalias ][ prefix ][ var_dedde72fd00bbda1 ];
    
    if ( !isdefined( newalias ) )
    {
        newalias = function_6fa0d4b79921f7bf( dialogalias, prefix, var_dedde72fd00bbda1 );
    }
    
    if ( !soundexists( newalias ) )
    {
        function_c8080a201232c345( var_dedde72fd00bbda1, newalias );
    }
    else
    {
        soundname = newalias;
    }
    
    return soundname;
}

// Namespace br_public
// Params 2
// Checksum 0xf80a2b32, Offset: 0x3066
// Size: 0x97
function function_c8080a201232c345( var_dedde72fd00bbda1, updatedstring )
{
    if ( true )
    {
        return;
    }
    
    if ( !isdefined( level.var_ffe15e6c64354ec1 ) )
    {
        level.var_ffe15e6c64354ec1 = [];
    }
    
    if ( !arraycontains( level.var_ffe15e6c64354ec1, var_dedde72fd00bbda1 ) )
    {
        level.var_ffe15e6c64354ec1[ level.var_ffe15e6c64354ec1.size ] = var_dedde72fd00bbda1;
        
        if ( isdefined( updatedstring ) )
        {
            script::demoforcesre( "SoundName for " + updatedstring + " was not found for the previous project " + var_dedde72fd00bbda1 + " alias. Make sure the new project line for this VO is added to the project files." );
            return;
        }
        
        script::demoforcesre( "SoundName for " + var_dedde72fd00bbda1 + " was probably deleted and there was not an equivalent for the new project created for it." );
    }
}

// Namespace br_public
// Params 2
// Checksum 0xbd456c73, Offset: 0x3105
// Size: 0x39
function function_a90c6661be1987bd( var_f0d9f561cc17890f, var_829cf779a390174a )
{
    if ( !isdefined( level.var_40d7d1d1f2be8177 ) )
    {
        level.var_40d7d1d1f2be8177 = [];
    }
    
    level.var_40d7d1d1f2be8177[ var_f0d9f561cc17890f ] = var_829cf779a390174a;
}

// Namespace br_public
// Params 1
// Checksum 0xeb57cff, Offset: 0x3146
// Size: 0x20, Type: bool
function function_762861273300a7f1( var_f0d9f561cc17890f )
{
    return level.var_40d7d1d1f2be8177[ var_f0d9f561cc17890f ] ?? "";
}

// Namespace br_public
// Params 0
// Checksum 0xabe3fd1b, Offset: 0x316f
// Size: 0x11, Type: bool
function function_379fb7b09f4ef13e()
{
    return level.script == "mp_bm_tut";
}

// Namespace br_public
// Params 0
// Checksum 0x712a3e62, Offset: 0x3189
// Size: 0x24, Type: bool
function istutorial()
{
    return level.script == "mp_br_tut" || level.script == "mp_lc_br_tut";
}

// Namespace br_public
// Params 0
// Checksum 0x26c17cd, Offset: 0x31b6
// Size: 0x41
function isbrpracticemode()
{
    if ( !isdefined( level.isbrpracticemode ) )
    {
        if ( !isdefined( level.script ) )
        {
            return 0;
        }
        
        level.isbrpracticemode = level.script == "mp_br_quarry";
    }
    
    return level.isbrpracticemode;
}

// Namespace br_public
// Params 0
// Checksum 0x30150fc4, Offset: 0x3200
// Size: 0x11, Type: bool
function isdmzbotpracticematch()
{
    return level.script == "mp_br_money";
}

// Namespace br_public
// Params 0
// Checksum 0x6a9925fa, Offset: 0x321a
// Size: 0x26, Type: bool
function isanytutorialorbotpracticematch()
{
    return istutorial() || function_379fb7b09f4ef13e() || isbrpracticemode() || isdmzbotpracticematch();
}

// Namespace br_public
// Params 2
// Checksum 0x5aa6fae, Offset: 0x3249
// Size: 0x83
function playerstreamhintdroptoground( streamorigin, startheight = br_infils_util::getinfilspawnoffset() )
{
    var_1484e496629e39e9 = getdvarint( @"hash_c103b956e0125687", 4500 );
    
    if ( var_1484e496629e39e9 >= 0 )
    {
        var_f4feabcd5c9f80b8 = startheight - var_1484e496629e39e9;
        contents = trace::create_contents( 0, 1, 1, 1, 0, 0, 1 );
        streamorigin = utility::drop_to_ground( streamorigin, 0, -1 * var_f4feabcd5c9f80b8, undefined, contents );
    }
    
    return streamorigin;
}

// Namespace br_public
// Params 0
// Checksum 0xfec855d3, Offset: 0x32d5
// Size: 0x12
function getdefaultstreamhinttimeoutms()
{
    return getdvarint( @"hash_aaffd5b201281ad4", 9000 );
}

// Namespace br_public
// Params 0
// Checksum 0x57b74d30, Offset: 0x32f0
// Size: 0x1d
function playerclearstreamhintorigin()
{
    self notify( #"hash_b70a0ed0949e821f" );
    
    if ( streamhint::function_bac26315148e18d3() )
    {
        self clearpredictedstreampos();
    }
}

// Namespace br_public
// Params 0
// Checksum 0xe2bbae7e, Offset: 0x3315
// Size: 0x18c
function function_85f6a1f0ca78ff67()
{
    self cancelmantle();
    
    if ( self isskydiving() )
    {
        self skydive_interrupt();
    }
    
    if ( self.inlaststand )
    {
        laststand::exit( "last_stand_self_revive" );
    }
    
    if ( isdefined( self.burninginfo ) )
    {
        molotov::molotov_clear_burning();
    }
    
    if ( self isonascender() )
    {
        br_utility::function_a8021859c16f9008();
    }
    
    if ( vehicle::is_in_vehicle() )
    {
        data = spawnstruct();
        data.allowairexit = 1;
        data.exittype = "INVOLUNTARY";
        thread vehicle_occupancy::exit( self.vehicle, undefined, self, data, 1 );
    }
    
    if ( isdefined( self.remoteuav ) )
    {
        self.remoteuav remoteuav::remoteuav_leave();
    }
    
    if ( isdefined( self.currentturret ) )
    {
        manual_turret::manualturret_endplayeruse( self.currentturret );
    }
    
    if ( isdefined( self.usingremote ) )
    {
        vehicles = vehicle_getarray();
        
        foreach ( vehicle in vehicles )
        {
            if ( vehicle.owner == self )
            {
                if ( isdefined( vehicle.helperdronetype ) )
                {
                    vehicle helper_drone::helperdrone_explode( 1 );
                }
            }
        }
    }
    
    javelin::javelin_forceclear();
}

// Namespace br_public
// Params 0
// Checksum 0x2de33aaf, Offset: 0x34a9
// Size: 0x2a
function calchelicoptertrailpoint()
{
    droppoint = self.origin - anglestoforward( self.angles ) * 150;
    return droppoint;
}

// Namespace br_public
// Params 1
// Checksum 0x11337eb0, Offset: 0x34dc
// Size: 0x107
function prematchmusic( team )
{
    if ( game_utility::getgametype() == "dmz" )
    {
        return;
    }
    
    teamarray = teams::getteamdata( team, "players" );
    
    if ( isarray( teamarray ) && teamarray.size == 0 )
    {
        return;
    }
    
    setglobalsoundcontext( "lobby_fade", "on", 3 );
    
    if ( !isdefined( level.skip_death_vo ) && isbrgamemode() )
    {
        level.skip_death_vo = 1;
    }
    
    var_7ca343079e1bf1ea = 15.7;
    
    if ( level.matchcountdowntime > var_7ca343079e1bf1ea )
    {
        waittime = level.matchcountdowntime - var_7ca343079e1bf1ea;
        wait waittime;
        br_lobby_outro = audio_utility::function_d4d265f3dcd0a13c( "br_lobby_outro" );
        audio_utility::function_bbf712dc44d33e6c( team, br_lobby_outro );
        audio_utility::function_5249e37b222313c8( team, "mp_br_lobby_fade", 8 );
        wait level.matchcountdowntime;
        return;
    }
    
    println( "<dev string:x162>" + level.matchcountdowntime );
}

// Namespace br_public
// Params 1
// Checksum 0x288bc8, Offset: 0x35eb
// Size: 0x74
function prematchdialog( team )
{
    if ( istutorial() || game_utility::getgametype() == "dmz" )
    {
        return;
    }
    
    if ( level.matchcountdowntime > 3 )
    {
        waittime = level.matchcountdowntime - 4;
        wait waittime;
        brleaderdialogteam( "prematch_end", team, undefined, undefined, undefined, level.brgametype.dialogprefix );
    }
}

// Namespace br_public
// Params 1
// Checksum 0x79ac623f, Offset: 0x3667
// Size: 0x188
function function_736f223adc68e677( timeinseconds )
{
    if ( !getdvarint( @"hash_65f74244d3c0f108", 1 ) )
    {
        return;
    }
    
    var_dab0b62f6c8721e = getdvarint( @"hash_501689ed1f1820d6", 2 );
    players = level.players;
    restrictions = [ "execution_attack", "execution_victim", "meatshield_attacker", "meatshield_victim" ];
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player val::set_array( "prematch_plotarmor", restrictions, 0 );
        player meatshield::function_db06fbfec0ffa2eb();
    }
    
    wait timeinseconds + var_dab0b62f6c8721e;
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player val::set_array( "prematch_plotarmor", restrictions, 1 );
    }
}

// Namespace br_public
// Params 1
// Checksum 0xc47a2a93, Offset: 0x37f7
// Size: 0xcd
function applyprematchplotarmor( countdowntime )
{
    if ( getdvarint( @"hash_fe3afd6ead4aa523", 1 ) == 0 )
    {
        return;
    }
    
    timeinseconds = 5;
    waittime = countdowntime - timeinseconds;
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    foreach ( player in level.players )
    {
        player.plotarmor = 1;
    }
    
    level thread function_736f223adc68e677( timeinseconds );
}

// Namespace br_public
// Params 0
// Checksum 0x28bffe21, Offset: 0x38cc
// Size: 0x1c
function br_onvehicledeath()
{
    player = self;
    player armor::damagearmor( 150, 1 );
}

// Namespace br_public
// Params 0
// Checksum 0x8ac60a67, Offset: 0x38f0
// Size: 0x49
function br_delaynojip()
{
    level endon( #"game_ended" );
    delayseconds = getdvarint( @"hash_c1af35bdcbb75c06", 30 );
    wait delayseconds;
    setnojipscore( 1, 1 );
    setnojiptime( 1, 1 );
    level.nojip = 1;
}

// Namespace br_public
// Params 7
// Checksum 0xe3f07e3c, Offset: 0x3941
// Size: 0x68
function raytraceoffset( origin, xoffset, yoffset, updist, downdist, contents, ignoreents )
{
    result = trace::ray_trace( origin + ( xoffset, yoffset, updist ), origin + ( xoffset, yoffset, downdist ), ignoreents, contents );
    return result;
}

// Namespace br_public
// Params 0
// Checksum 0x6dc31e7d, Offset: 0x39b2
// Size: 0x1b, Type: bool
function function_b4d14b7b48e551af()
{
    return level.br_level.var_7dd04763bfd623c1 ?? 10000;
}

// Namespace br_public
// Params 0
// Checksum 0xaba174f6, Offset: 0x39d6
// Size: 0x1b, Type: bool
function function_5d8b60a1b01b8249()
{
    return level.br_level.var_cd92896f34e2d8ef ?? -2400;
}

// Namespace br_public
// Params 2
// Checksum 0xdda8fb81, Offset: 0x39fa
// Size: 0x48
function function_3f5764d569c51461( origin, radius )
{
    if ( !isdefined( level.cratedata.crates ) )
    {
        return;
    }
    
    return function_c44b31a67523b336( level.cratedata.crates, origin, radius );
}

// Namespace br_public
// Params 2
// Checksum 0xc7b57b5e, Offset: 0x3a4b
// Size: 0xe0
function function_62b8be45a981f059( origin, radius )
{
    drones = [];
    
    if ( isdefined( level.redeploy_drone_info_struct ) )
    {
        radiussq = radius * radius;
        
        foreach ( droneinstance in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
        {
            distsq = distance2dsquared( origin, droneinstance.origin );
            
            if ( distsq < radiussq )
            {
                drones[ drones.size ] = droneinstance;
            }
        }
    }
    
    return drones;
}

// Namespace br_public
// Params 5
// Checksum 0x7c2c3e8c, Offset: 0x3b34
// Size: 0x3c
function drop_to_ground_br( pos, updist, downdist, upvector, contents )
{
    return droptogroundmultitrace( pos, updist, downdist, contents );
}

// Namespace br_public
// Params 5
// Checksum 0x7ef85adc, Offset: 0x3b79
// Size: 0x50
function droptogroundmultitrace( origin, updist, downdist, contentsoverride, ignoreents )
{
    result = droptogroundmultitrace_internal( origin, updist, downdist, contentsoverride, ignoreents );
    return result[ "position" ];
}

// Namespace br_public
// Params 6
// Checksum 0x6c696ad3, Offset: 0x3bd2
// Size: 0x47
function function_3881e27a5abdb6ff( origin, updist, downdist, contentsoverride, ignoreents, var_69fd22f9e720e316 )
{
    return droptogroundmultitrace_internal( origin, updist, downdist, contentsoverride, ignoreents, var_69fd22f9e720e316 );
}

// Namespace br_public
// Params 6
// Checksum 0x2b7f5933, Offset: 0x3c22
// Size: 0x291
function droptogroundmultitrace_internal( origin, updist, downdist, contentsoverride, ignoreents, var_69fd22f9e720e316 )
{
    var_e19d3f45bafc368f = function_5d8b60a1b01b8249();
    var_b5b42f7b65eecf19 = function_b4d14b7b48e551af();
    
    if ( !isdefined( updist ) )
    {
        updist = getdvarint( @"hash_2a585c8e6dceac23", 5000 );
    }
    
    if ( !isdefined( downdist ) )
    {
        var_d3e2e64845578711 = -18000 + var_e19d3f45bafc368f;
        downdist = getdvarint( @"hash_31f5cb462b87b556", var_d3e2e64845578711 );
    }
    
    low = getdvarint( @"hash_8408f03a735c0934", var_e19d3f45bafc368f );
    high = getdvarint( @"hash_fdc476e42fa40a6e", var_b5b42f7b65eecf19 );
    contents = contentsoverride ?? trace::create_contents( 0, 1, 1, 1, 0, 0, 1 );
    
    if ( !isdefined( ignoreents ) )
    {
        ignoreents = [];
    }
    
    leveldata = vehicle_spawn::get_data();
    
    if ( isdefined( leveldata.instancesbyref ) )
    {
        ignoreents = arraycombine( ignoreents, leveldata.instancesbyref[ "little_bird" ] );
        ignoreents = arraycombine( ignoreents, leveldata.instancesbyref[ "little_bird_mg" ] );
        ignoreents = arraycombine( ignoreents, leveldata.instancesbyref[ "veh9_palfa" ] );
    }
    
    crates = function_3f5764d569c51461( origin, 100 );
    ignoreents = arraycombine( ignoreents, crates );
    var_af9c26b6415ac903 = var_69fd22f9e720e316 > 0;
    
    if ( var_af9c26b6415ac903 )
    {
        end = origin + ( 0, 0, downdist );
        result = trace::sphere_trace( origin, end, var_69fd22f9e720e316, ignoreents, contents );
        
        if ( traceresultisvalid( result, low ) )
        {
            return result;
        }
    }
    else
    {
        result = raytraceoffset( origin, 0, 0, updist, downdist, contents, ignoreents );
        
        if ( traceresultisvalid( result, low ) )
        {
            return result;
        }
        
        result = raytraceoffset( origin, 15, 0, updist, downdist, contents, ignoreents );
        
        if ( traceresultisvalid( result, low ) )
        {
            return result;
        }
        
        result = raytraceoffset( origin, 0, 15, updist, downdist, contents, ignoreents );
        
        if ( traceresultisvalid( result, low ) )
        {
            return result;
        }
        
        result = raytraceoffset( origin, -15, 0, updist, downdist, contents, ignoreents );
        
        if ( traceresultisvalid( result, low ) )
        {
            return result;
        }
        
        result = raytraceoffset( origin, 0, -15, updist, downdist, contents, ignoreents );
        
        if ( traceresultisvalid( result, low ) )
        {
            return result;
        }
    }
    
    result = [];
    result[ "position" ] = ( origin[ 0 ], origin[ 1 ], high );
    result[ "fraction" ] = 0;
    return result;
}

// Namespace br_public
// Params 2
// Checksum 0xcd45c5a9, Offset: 0x3ebc
// Size: 0x30, Type: bool
function traceresultisvalid( result, lowestz )
{
    return result[ "fraction" ] != 1 && result[ "position" ][ 2 ] > lowestz;
}

// Namespace br_public
// Params 0
// Checksum 0x6ef72d22, Offset: 0x3ef5
// Size: 0x6c
function function_8d4a6d302a72d5ed()
{
    if ( !getdvarint( @"hash_74ce45c3ef7d0741", 1 ) )
    {
        return;
    }
    
    if ( self.triggertype == "proximity" && !self.usetime )
    {
        self.touchlist = [];
        self.touchlist[ "neutral" ] = [];
        self.touchlist[ "none" ] = [];
        self.assisttouchlist = undefined;
    }
}

// Namespace br_public
// Params 1
// Checksum 0xab59bbe, Offset: 0x3f69
// Size: 0x48
function function_c6c1721a0ec2bf0( scriptablename )
{
    if ( isammo( scriptablename ) )
    {
        lootid = loot::getlootidfromref( scriptablename );
    }
    else
    {
        lootid = loot::function_d3e3bcaea591a6a2( scriptablename );
    }
    
    if ( isdefined( lootid ) )
    {
        return br_default_inventory::function_46da5d3784eb9b40( lootid );
    }
    
    return 0;
}

// Namespace br_public
// Params 2
// Checksum 0x77ca4fc7, Offset: 0x3fba
// Size: 0x4d
function function_72605517df8071a5( flag, bool )
{
    currentvalue = self getclientomnvar( "br_archived_flags" );
    
    if ( bool )
    {
        currentvalue |= flag;
    }
    else
    {
        currentvalue &= ~flag;
    }
    
    self setclientomnvar( "br_archived_flags", currentvalue );
}

// Namespace br_public
// Params 1
// Checksum 0x78408e51, Offset: 0x400f
// Size: 0x17
function function_bb22d91d6d217fe1( bool )
{
    function_72605517df8071a5( 1, bool );
}

// Namespace br_public
// Params 1
// Checksum 0xd97cf306, Offset: 0x402e
// Size: 0x35, Type: bool
function function_2a6e320ec6ac64d1( scriptablename )
{
    if ( !isdefined( scriptablename ) )
    {
        return false;
    }
    
    return scriptablename == "brloot_offhand_binoculars" || scriptablename == "brloot_offhand_heartbeatsensor" || scriptablename == "brloot_offhand_geigercounter";
}

// Namespace br_public
// Params 0
// Checksum 0xdb234a59, Offset: 0x406c
// Size: 0x16a, Type: bool
function function_a0236cbb3d65af8e()
{
    squaddata = level.squaddata[ self.team ][ self.sessionsquadid ];
    squadleader = squaddata.squadleader;
    
    if ( self != squadleader || squaddata.players.size == 1 )
    {
        return false;
    }
    
    allhumanplayers = [];
    playerindex = 0;
    
    foreach ( player in squaddata.players )
    {
        if ( !isbot( player ) )
        {
            allhumanplayers[ allhumanplayers.size ] = player;
        }
        
        if ( player == squadleader )
        {
            playerindex = allhumanplayers.size;
        }
    }
    
    if ( allhumanplayers.size <= 1 )
    {
        return false;
    }
    
    br::setplayerbrsquadleader( 0 );
    newsquadleader = allhumanplayers[ playerindex % allhumanplayers.size ];
    squaddata.squadleader = newsquadleader;
    newsquadleader br::setplayerbrsquadleader( 1 );
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        function_1ed30c5a51142384( self.team, self.sessionsquadid, newsquadleader );
    }
    
    function_6d76f568c284a375( squaddata, newsquadleader );
    return true;
}

// Namespace br_public
// Params 2, eflags: 0x4
// Checksum 0xeacc0385, Offset: 0x41df
// Size: 0xdb
function private function_6d76f568c284a375( squaddata, newsquadleader )
{
    if ( flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    foreach ( player in squaddata.players )
    {
        player setclientomnvar( "ui_squad_leader", newsquadleader );
        
        if ( player::isreallyalive( player ) )
        {
            if ( newsquadleader == player )
            {
                player thread hud_message::showsplash( "br_become_new_jump_leader" );
                continue;
            }
            
            player thread hud_message::showsplash( "br_jump_leader_changed", newsquadleader getentitynumber() );
        }
    }
}

// Namespace br_public
// Params 1
// Checksum 0x311863ca, Offset: 0x42c2
// Size: 0x6a, Type: bool
function function_63526e8677d58de8( var_8717efe7961f882c )
{
    if ( !isdefined( self ) || !self.game_extrainfo & 16777216 )
    {
        return false;
    }
    
    logstring( "detachFromGroup: " + self.name + " shouldCallNotify: " + string( var_8717efe7961f882c ) + ";\n" );
    function_99cb14b2b9be7b27( 0 );
    
    if ( var_8717efe7961f882c )
    {
        self notify( #"stop_push" );
    }
    
    return true;
}

// Namespace br_public
// Params 0
// Checksum 0x59635498, Offset: 0x4335
// Size: 0x77, Type: bool
function function_2b77621af91326f6()
{
    if ( self.game_extrainfo & 16777216 )
    {
        return false;
    }
    
    logstring( "followJumpLeader: " + self.name + ";\n" );
    function_99cb14b2b9be7b27( 1 );
    squadleader = squad_utility::getsquadleader( self.team, self.sessionsquadid );
    
    if ( isdefined( squadleader ) )
    {
        thread hud_message::showsplash( "br_jump_leader_changed", squadleader getentitynumber() );
    }
    
    return true;
}

// Namespace br_public
// Params 0
// Checksum 0x5411c5c1, Offset: 0x43b5
// Size: 0x12, Type: bool
function function_e6445d548e426852()
{
    return istrue( self.game_extrainfo & 16777216 );
}

// Namespace br_public
// Params 1
// Checksum 0x5374e887, Offset: 0x43d0
// Size: 0xcb
function kickplayersatcircleedge( var_cfb22293cfac3833 = undefined )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    remainingdistance = distance2d( self.origin, self.pathstruct.endptui );
    remainingtime = remainingdistance / br_c130::getc130speed();
    
    if ( isdefined( var_cfb22293cfac3833 ) )
    {
        earlytime = [[ var_cfb22293cfac3833 ]]();
    }
    else
    {
        var_7ed32b47eb546016 = hashcat( @"scr_", game_utility::getgametype(), "_kick_player_time_before_circle_edge" );
        earlytime = getdvarfloat( var_7ed32b47eb546016, 1.1 );
    }
    
    wait remainingtime - earlytime;
    br_c130::function_18bde48c632c3922( level.players, "c130" );
}

// Namespace br_public
// Params 0
// Checksum 0xc891bf66, Offset: 0x44a3
// Size: 0x22
function function_ab5e009b1898c081()
{
    if ( teams::squadasteamenabled() )
    {
        return level.maxsquadsize;
    }
    
    return level.maxteamsize;
}

// Namespace br_public
// Params 2
// Checksum 0x963d6ccf, Offset: 0x44cd
// Size: 0x3e
function function_bb301e2885948354( team, squadindex )
{
    if ( teams::squadasteamenabled() )
    {
        return squad_utility::getsquadalivecount( team, squadindex );
    }
    
    return level.teamdata[ team ][ "aliveCount" ];
}

// Namespace br_public
// Params 1
// Checksum 0xd773b917, Offset: 0x4513
// Size: 0x1c
function function_ec36cf40e2b38aa6( team )
{
    return getarraykeys( level.squaddata[ team ] );
}

// Namespace br_public
// Params 0
// Checksum 0x2c40501d, Offset: 0x4538
// Size: 0x20, Type: bool
function function_73ed6e27eb5e7544()
{
    return isdefined( level.elite_ironclad.team_info.state );
}

// Namespace br_public
// Params 0
// Checksum 0x56148646, Offset: 0x4561
// Size: 0x86, Type: bool
function function_3109598c9cf407f1()
{
    foreach ( player in level.players )
    {
        if ( player.var_82a2163fbb84a684 > 0 )
        {
            return true;
        }
    }
    
    return false;
}

