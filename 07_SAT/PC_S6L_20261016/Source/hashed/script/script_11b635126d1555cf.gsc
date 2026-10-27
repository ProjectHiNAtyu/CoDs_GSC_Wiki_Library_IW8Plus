// script_11b635126d1555cf  (hash_11b635126d1555cf.gscc) (size: 1101 Bytes / 0x44d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x25501092 (626004114)
// size ...... 1101 (0x44d)
// includes .. 3   (offset: 0x3f9)
// strings ... 4   (offset: 0x411)
// dev strs .. 0   (offset: 0x44d)
// exports ... 6   (offset: 0x229)
// cseg ...... 0xb8 + 0x171 (0x229)
// imports ... 8   (offset: 0x319)
// animtree1 . 0   (offset: 0x44d)
// animtree2 . 0   (offset: 0x44d)
#using scripts\common\callbacks;
#using scripts\common\values;
#using scripts\mp\flags;

#namespace specialty_engineer;

// Namespace specialty_engineer
// Params 0, eflags: 0x1
// Checksum 0x2ef971b9, Offset: 0xd6
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_engineer
// Params 1
// Checksum 0x998aaafc, Offset: 0xf6
// Size: 0x43
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_engineer", &setengineer, &unsetengineer, [ "specialty_outlinekillstreaks" ] );
    }
}

// Namespace specialty_engineer
// Params 0
// Checksum 0x922ca0b6, Offset: 0x141
// Size: 0x2d
function setengineer()
{
    self.var_ee14101bfc5363a7 = self.var_9842326056fd7207.var_ee14101bfc5363a7 ?? 1000000;
    thread engineer_enablemarksafterprematch();
}

// Namespace specialty_engineer
// Params 0
// Checksum 0xe41a6aab, Offset: 0x176
// Size: 0x76
function engineer_enablemarksafterprematch()
{
    self notify( #"hash_82947cdd049e2f1f" );
    self endon( #"hash_82947cdd049e2f1f" );
    self endon( #"hash_4e4ec496035203b7" );
    self endon( #"disconnect" );
    flags::gameflagwait( "prematch_done" );
    dist = self.var_ee14101bfc5363a7;
    
    if ( isdefined( self ) )
    {
        val::set( "specialty_engineer", "entity_mark_equipment", dist );
        self.perkengineerset = 1;
    }
}

// Namespace specialty_engineer
// Params 0
// Checksum 0xda384e1d, Offset: 0x1f4
// Size: 0x35
function unsetengineer()
{
    if ( self.perkengineerset )
    {
        val::reset( "specialty_engineer", "entity_mark_equipment" );
        self.perkengineerset = undefined;
    }
    
    self notify( #"hash_4e4ec496035203b7" );
}

