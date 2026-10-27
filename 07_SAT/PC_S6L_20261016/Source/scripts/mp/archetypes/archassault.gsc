// scripts\mp\archetypes\archassault.gsc  (hash_69a005ba63022c32.gscc) (size: 1367 Bytes / 0x557 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xefd3ed53 (4023643475)
// size ...... 1367 (0x557)
// includes .. 3   (offset: 0x4ff)
// strings ... 4   (offset: 0x517)
// dev strs .. 0   (offset: 0x557)
// exports ... 7   (offset: 0x2bf)
// cseg ...... 0xae + 0x211 (0x2bf)
// imports ... 10  (offset: 0x3d7)
// animtree1 . 0   (offset: 0x557)
// animtree2 . 0   (offset: 0x557)
#using scripts\common\utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\points;

#namespace archassault;

// Namespace archassault
// Params 0
// Checksum 0x53fea600, Offset: 0xcc
// Size: 0x9
function applyarchetype()
{
    equipextras();
}

// Namespace archassault
// Params 0
// Checksum 0xe03e6b08, Offset: 0xdd
// Size: 0x2
function equipextras()
{
    
}

// Namespace archassault
// Params 0
// Checksum 0x7ca69ff0, Offset: 0xe7
// Size: 0x2
function removearchetype()
{
    
}

// Namespace archassault
// Params 0
// Checksum 0xfa3cd864, Offset: 0xf1
// Size: 0xe5
function auraquickswap_run()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_1f2c4f17a1a95db4" );
    self setclientomnvar( "ui_aura_quickswap", 0 );
    
    while ( true )
    {
        self waittill( #"got_a_kill" );
        auraplayers = utility::playersincylinder( self.origin, 384 );
        
        foreach ( player in auraplayers )
        {
            if ( player.team != self.team )
            {
                continue;
            }
            
            player thread auraquickswap_bestowaura( self );
        }
    }
}

// Namespace archassault
// Params 1
// Checksum 0xb1a3d5e8, Offset: 0x1de
// Size: 0xa6
function auraquickswap_bestowaura( player )
{
    self endon( #"death_or_disconnect" );
    self endon( #"giveloadout_start" );
    level endon( #"game_ended" );
    
    if ( self != player )
    {
        player thread points::doscoreevent( #"buff_teammate" );
    }
    
    self setclientomnvar( "ui_aura_quickswap", 1 );
    perk::giveperk( "specialty_fastreload" );
    self playlocalsound( "mp_overcharge_on" );
    thread cleanupafterplayerdeath();
    wait 5;
    self playlocalsound( "mp_overcharge_off" );
    self notify( #"removeauraquickswap" );
    perk::removeperk( "specialty_fastreload" );
    self setclientomnvar( "ui_aura_quickswap", 0 );
}

// Namespace archassault
// Params 0
// Checksum 0x9d88251f, Offset: 0x28c
// Size: 0x33
function cleanupafterplayerdeath()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self waittill( #"death" );
    self setclientomnvar( "ui_aura_quickswap", 0 );
}

