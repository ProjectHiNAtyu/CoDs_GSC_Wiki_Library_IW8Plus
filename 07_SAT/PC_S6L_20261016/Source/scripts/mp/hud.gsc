// scripts\mp\hud.gsc  (hash_026f0756f77cfcfd.gscc) (size: 1243 Bytes / 0x4db / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x81ca7f5b (2177531739)
// size ...... 1243 (0x4db)
// includes .. 0   (offset: 0x497)
// strings ... 5   (offset: 0x497)
// dev strs .. 0   (offset: 0x4db)
// exports ... 4   (offset: 0x393)
// cseg ...... 0x83 + 0x310 (0x393)
// imports ... 3   (offset: 0x433)
// animtree1 . 0   (offset: 0x4db)
// animtree2 . 0   (offset: 0x4db)
#namespace hud;

// Namespace hud
// Params 0
// Checksum 0x9051655e, Offset: 0xa1
// Size: 0x1be
function init()
{
    level.uiparent = spawnstruct();
    level.uiparent.horzalign = "left";
    level.uiparent.vertalign = "top";
    level.uiparent.alignx = "left";
    level.uiparent.aligny = "top";
    level.uiparent.x = 0;
    level.uiparent.y = 0;
    level.uiparent.width = 0;
    level.uiparent.height = 0;
    level.uiparent.children = [];
    level.fontheight = 12;
    level.hud[ "allies" ] = spawnstruct();
    level.hud[ "axis" ] = spawnstruct();
    level.primaryprogressbary = -61;
    level.primaryprogressbarx = 0;
    level.primaryprogressbarheight = 9;
    level.primaryprogressbarwidth = 120;
    level.primaryprogressbartexty = -75;
    level.primaryprogressbartextx = 0;
    level.primaryprogressbarfontsize = 1.2;
    level.teamprogressbary = 32;
    level.teamprogressbarheight = 14;
    level.teamprogressbarwidth = 192;
    level.teamprogressbartexty = 8;
    level.teamprogressbarfontsize = 1.65;
    level.lowertextyalign = "BOTTOM";
    level.lowertexty = -155;
    level.lowertextfontsize = 1.6;
}

// Namespace hud
// Params 1
// Checksum 0xa32141de, Offset: 0x267
// Size: 0x6f
function fontpulseinit( maxfontscale )
{
    self.basefontscale = self.fontscale;
    
    if ( isdefined( maxfontscale ) )
    {
        self.maxfontscale = min( maxfontscale, 6.3 );
    }
    else
    {
        self.maxfontscale = min( self.fontscale * 2, 6.3 );
    }
    
    self.inframes = 2;
    self.outframes = 4;
}

// Namespace hud
// Params 1
// Checksum 0x45601448, Offset: 0x2de
// Size: 0xb5
function fontpulse( player )
{
    self notify( #"hash_2e7b351661e69901" );
    self endon( #"hash_2e7b351661e69901" );
    self endon( #"death" );
    player endon( #"disconnect" );
    player endon( #"joined_team" );
    player endon( #"joined_spectators" );
    self changefontscaleovertime( self.inframes * 0.05 );
    self.fontscale = self.maxfontscale;
    wait self.inframes * 0.05;
    self changefontscaleovertime( self.outframes * 0.05 );
    self.fontscale = self.basefontscale;
}

