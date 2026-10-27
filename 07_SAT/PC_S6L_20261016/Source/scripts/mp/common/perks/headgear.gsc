// scripts\mp\common\perks\headgear.gsc  (hash_444a6ec5fafe27bd.gscc) (size: 1114 Bytes / 0x45a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa027c7de (2686961630)
// size ...... 1114 (0x45a)
// includes .. 2   (offset: 0x40e)
// strings ... 4   (offset: 0x41e)
// dev strs .. 0   (offset: 0x45a)
// exports ... 7   (offset: 0x232)
// cseg ...... 0xa0 + 0x192 (0x232)
// imports ... 7   (offset: 0x34a)
// animtree1 . 0   (offset: 0x45a)
// animtree2 . 0   (offset: 0x45a)
#using scripts\mp\equipment;
#using scripts\mp\operator;

#namespace headgear;

// Namespace headgear
// Params 0
// Checksum 0x3a6c7d09, Offset: 0xbe
// Size: 0x1b
function init()
{
    level._effect[ "helmet_pop" ] = loadfxasset( "vfx_iw7_core_human_helmet_sdf_army_split" );
}

// Namespace headgear
// Params 2
// Checksum 0x50e688c7, Offset: 0xe1
// Size: 0x2b
function removeheadgear( equipmentref, slot )
{
    self notify( #"remove_headgear" );
    self.hasheadgear = undefined;
}

// Namespace headgear
// Params 3
// Checksum 0xef55a120, Offset: 0x114
// Size: 0x74
function runheadgear( equipmentref, slot, variantid )
{
    self endon( #"death_or_disconnect" );
    self endon( #"remove_headgear" );
    self.hasheadgear = 1;
    self waittill( #"headgear_save" );
    self.hasheadgear = 0;
    
    if ( equipmentref != "" )
    {
        equipment_mp::setequipmentammo( equipmentref, 0 );
    }
    
    runheadgeareffects();
}

// Namespace headgear
// Params 0
// Checksum 0x58b13c07, Offset: 0x190
// Size: 0x85
function runheadgeareffects()
{
    playfxontag( level._effect[ "helmet_pop" ], self, "j_head" );
    self detach( self.headmodel, "" );
    operator::function_44f7d464da13e4f6( self.operatorcustomization.operatorref, self.operatorcustomization.skinref );
    self.headmodel = self.backuphead;
    self attach( self.backuphead, "", 1 );
}

// Namespace headgear
// Params 0
// Checksum 0xcc46230e, Offset: 0x21d
// Size: 0x7
function getdamagemod()
{
    return 0.1;
}

// Namespace headgear
// Params 0
// Checksum 0xfbd3a639, Offset: 0x22d
// Size: 0x4
function getmaxdamage()
{
    return 20;
}

