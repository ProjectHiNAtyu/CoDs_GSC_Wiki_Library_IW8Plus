// scripts\mp\br\gametypes\br_armor.gsc  (hash_6a98156eaac648ed.gscc) (size: 3289 Bytes / 0xcd9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x95b318e9 (2511542505)
// size ...... 3289 (0xcd9)
// includes .. 7   (offset: 0xc09)
// strings ... 12  (offset: 0xc41)
// dev strs .. 0   (offset: 0xcd9)
// exports ... 14  (offset: 0x735)
// cseg ...... 0x14d + 0x5e8 (0x735)
// imports ... 23  (offset: 0x965)
// animtree1 . 0   (offset: 0xcd9)
// animtree2 . 0   (offset: 0xcd9)
#using script_16ea1b94f0f381b3;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\equipment\armor_plate;
#using scripts\mp\common\utility\perk;

#namespace br_armor;

// Namespace br_armor
// Params 0
// Checksum 0x33fcb82a, Offset: 0x16b
// Size: 0x23
function main()
{
    /#
        setdvarifuninitialized( @"hash_6f491f10c40cf0a9", -1 );
    #/
    
    level.onhelmetsniped = &onhelmetsniped;
}

// Namespace br_armor
// Params 0
// Checksum 0x389e8e33, Offset: 0x196
// Size: 0x2f
function initarmor()
{
    self.br_armorhealth = 0;
    self.br_maxarmorhealth = getmaxarmorhealth();
    self setclientomnvar( "ui_armor_percent", 0 );
    armor_plate::br_armor_plate_amount_equipped_set( 0 );
}

// Namespace br_armor
// Params 0
// Checksum 0x48639de8, Offset: 0x1cd
// Size: 0x16
function getmaxarmorhealth()
{
    if ( level.pe_heavyarmor_active )
    {
        return 200;
    }
    
    return 150;
}

// Namespace br_armor
// Params 1
// Checksum 0xace4da62, Offset: 0x1ec
// Size: 0xa0
function getoldarmorent( var_8e26bbe098ebd388 )
{
    pickup = spawnstruct();
    pickup.count = 1;
    pickup.maxcount = 1;
    pickup.stackable = 1;
    
    if ( br_public::ishelmet( var_8e26bbe098ebd388.scriptablename ) )
    {
    }
    else if ( br_pickups::isgasmask( var_8e26bbe098ebd388.scriptablename ) )
    {
        pickup.gasmaskhealth = self.gasmaskhealth;
    }
    else
    {
        pickup.armorhealth = self.br_armorhealth;
    }
    
    return pickup;
}

// Namespace br_armor
// Params 1
// Checksum 0xe5956e02, Offset: 0x295
// Size: 0x4c
function helmetitemtypeforlevel( helmetlevel )
{
    switch ( helmetlevel )
    {
        case 1:
            return "brloot_armor_helmet_1";
        case 2:
            return "brloot_armor_helmet_2";
        case 3:
            return "brloot_armor_helmet_3";
    }
}

// Namespace br_armor
// Params 1
// Checksum 0xf7aa938f, Offset: 0x2ea
// Size: 0x6d
function givestartingarmor( var_334e86a2e3db2cbe )
{
    if ( isdefined( var_334e86a2e3db2cbe ) )
    {
        var_3d6ea419e6000666 = var_334e86a2e3db2cbe;
    }
    else
    {
        var_3d6ea419e6000666 = 100;
    }
    
    if ( getdvarint( @"scr_br_alt_mode_gg", 0 ) )
    {
        var_3d6ea419e6000666 = getmaxarmorhealth();
    }
    
    var_2cd7a5606ce9e46 = getdvarint( @"hash_6f491f10c40cf0a9", -1 );
    
    if ( var_2cd7a5606ce9e46 >= 0 )
    {
        var_3d6ea419e6000666 = var_2cd7a5606ce9e46;
    }
    
    givearmorvalue( var_3d6ea419e6000666 );
}

// Namespace br_armor
// Params 1
// Checksum 0xa61ec857, Offset: 0x35f
// Size: 0x72
function givearmorvalue( value )
{
    if ( !isdefined( value ) || value < 0 )
    {
        return;
    }
    
    self.br_armorhealth = value;
    self.br_maxarmorhealth = getmaxarmorhealth();
    armorpercent = self.br_armorhealth / self.br_maxarmorhealth;
    self setclientomnvar( "ui_armor_percent", armorpercent );
    armor_plate::br_armor_plate_amount_equipped_set( self.br_armorhealth );
}

// Namespace br_armor
// Params 2
// Checksum 0x1ab4cc70, Offset: 0x3d9
// Size: 0x3b
function takehelmet( helmetitem, helmetlevel )
{
    self.br_helmetlevel = helmetlevel;
    
    if ( self.br_helmetlevel == 3 )
    {
        perk::giveperk( "specialty_stun_resistance" );
    }
}

// Namespace br_armor
// Params 0
// Checksum 0x2546b15c, Offset: 0x41c
// Size: 0x14
function breakarmor()
{
    armor::damagearmor( self.br_armorhealth, 1 );
}

// Namespace br_armor
// Params 1
// Checksum 0xafc8722d, Offset: 0x438
// Size: 0x75, Type: bool
function isarmorbetterthanequipped( armorname )
{
    helmetlevel = 0;
    
    if ( armorname == "equip_helmet_1" )
    {
        helmetlevel = 1;
    }
    else if ( armorname == "equip_helmet_2" )
    {
        helmetlevel = 2;
    }
    else if ( armorname == "equip_helmet_3" )
    {
        helmetlevel = 3;
    }
    
    if ( helmetlevel > 0 )
    {
        if ( !isdefined( self.br_helmetlevel ) || self.br_helmetlevel < helmetlevel )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_armor
// Params 3
// Checksum 0x743c535d, Offset: 0x4b6
// Size: 0x1fe
function popoffhelmet( impactdir, playerangles, playerorigin )
{
    level endon( #"game_ended" );
    helmettag = self gettagorigin( "j_helmet" );
    
    if ( !isdefined( helmettag ) )
    {
        helmettag = playerorigin + ( 0, 0, 80 );
    }
    
    helmet = spawn( "script_model", self gettagorigin( "j_helmet" ) );
    helmet setmodel( "loot_helmet" );
    helmet.angles = playerangles;
    up = anglestoup( playerangles );
    forward = impactdir;
    vel = vectornormalize( forward + up ) * 2500;
    helmet physicslaunchserver( helmet.origin, vel );
    helmetitem = "brloot_armor_helmet_" + self.br_helmetlevel;
    var_60f1c68fe71a0a7e = 15;
    var_1aac024883ef8293 = 0.1;
    var_60f1c68fe71a0a7e *= 1 / var_1aac024883ef8293;
    previousorigin = helmet.origin;
    
    for ( i = 0; i < var_60f1c68fe71a0a7e ; i++ )
    {
        wait var_1aac024883ef8293;
        compareorigin = previousorigin - helmet.origin;
        
        if ( compareorigin[ 0 ] < 2 && compareorigin[ 1 ] < 2 && compareorigin[ 2 ] < 2 && compareorigin[ 0 ] > -2 && compareorigin[ 1 ] > -2 && compareorigin[ 2 ] > -2 )
        {
            helmet delete();
            spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( helmet.origin, helmet.angles );
            pickupent = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( helmetitem, undefined, spawnoptions );
            pickupent.count = 1;
            return;
        }
        
        previousorigin = helmet.origin;
    }
    
    helmet delete();
}

// Namespace br_armor
// Params 2
// Checksum 0x121ebfbb, Offset: 0x6bc
// Size: 0x3b
function onhelmetsniped( victim, impactdir )
{
    if ( isdefined( victim ) )
    {
        victim thread popoffhelmet( impactdir, victim.angles, victim.origin );
    }
}

// Namespace br_armor
// Params 0
// Checksum 0xd2ccc424, Offset: 0x6ff
// Size: 0x36
function function_edeaf1f44432aa61()
{
    if ( isdefined( self.armorhealth ) )
    {
        armorpercent = self.armorhealth / getmaxarmorhealth();
        codcasterclientmatchdata::function_ee35d29284860183( 18, armorpercent );
    }
}

