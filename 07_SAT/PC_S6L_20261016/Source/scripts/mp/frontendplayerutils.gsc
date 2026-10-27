// scripts\mp\frontendplayerutils.gsc  (hash_28efb67ed55070ae.gscc) (size: 1566 Bytes / 0x61e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc37e3dea (3279830506)
// size ...... 1566 (0x61e)
// includes .. 1   (offset: 0x5da)
// strings ... 3   (offset: 0x5e2)
// dev strs .. 0   (offset: 0x61e)
// exports ... 3   (offset: 0x3be)
// cseg ...... 0x78 + 0x346 (0x3be)
// imports ... 14  (offset: 0x436)
// animtree1 . 0   (offset: 0x61e)
// animtree2 . 0   (offset: 0x61e)
#using scripts\common\weapon;

#namespace frontendplayerutils;

// Namespace frontendplayerutils
// Params 1
// Checksum 0xf539534f, Offset: 0x96
// Size: 0x6a
function get_default_weapon( isprimary )
{
    gamemodebundle = getgamemodescriptbundle();
    
    if ( isdefined( gamemodebundle ) && isdefined( gamemodebundle.weaponlist ) )
    {
        weaponlistbundle = getscriptbundle( gamemodebundle.weaponlist );
        
        if ( isprimary )
        {
            return weaponlistbundle.defaultprimaryweapon;
        }
        
        return weaponlistbundle.defaultsecondaryweapon;
    }
}

// Namespace frontendplayerutils
// Params 0
// Checksum 0x9b6f8760, Offset: 0x108
// Size: 0x2b6
function update_player_weapon()
{
    loadoutdata = self function_cb8df376b3e57420();
    var_cc1b7f4c7438f7d7 = loadoutdata.primaryweaponentityindex;
    var_9c610576e6f20eb3 = loadoutdata.secondaryweaponentityindex;
    var_239024bd710e6fb4 = isdefined( self.primaryweaponobj ) && isdefined( var_cc1b7f4c7438f7d7 );
    var_a37b674954de2308 = isdefined( self.secondaryweaponobj ) && isdefined( var_9c610576e6f20eb3 );
    
    if ( var_239024bd710e6fb4 && var_a37b674954de2308 )
    {
        var_b86aab6d2b0e3017 = self.primaryweaponobj == var_cc1b7f4c7438f7d7 && self.secondaryweaponobj == var_9c610576e6f20eb3;
        var_e2889866b794b2ca = self.primaryweaponobj == var_9c610576e6f20eb3 && self.secondaryweaponobj == var_cc1b7f4c7438f7d7;
        
        if ( var_b86aab6d2b0e3017 || var_e2889866b794b2ca )
        {
            return;
        }
    }
    
    if ( self.primaryweaponobj )
    {
        self takeweapon( self.primaryweaponobj );
    }
    
    if ( self.secondaryweaponobj )
    {
        self takeweapon( self.secondaryweaponobj );
    }
    
    self.primaryweaponobj = undefined;
    self.secondaryweaponobj = undefined;
    self.primaryweaponobj = loadoutdata.primaryweaponentityindex;
    
    if ( !isdefined( self.primaryweaponobj ) || self.primaryweaponobj.basename == "none" )
    {
        primaryweapon = get_default_weapon( 1 );
        self.primaryweaponobj = weapon::buildweapon( primaryweapon, [], "camo_none", "none", 0, [], "none", [], 0, [] );
    }
    
    self giveweapon( self.primaryweaponobj );
    self setweaponammoclip( self.primaryweaponobj, weaponclipsize( self.primaryweaponobj ) );
    self setweaponammostock( self.primaryweaponobj, weaponmaxammo( self.primaryweaponobj ) );
    self setactionslot( 3, "altmode" );
    self.secondaryweaponobj = loadoutdata.secondaryweaponentityindex;
    
    if ( !isdefined( self.secondaryweaponobj ) || self.secondaryweaponobj.basename == "none" )
    {
        secondaryweapon = get_default_weapon();
        self.secondaryweaponobj = weapon::buildweapon( secondaryweapon, [], "camo_none", "none", 0, [], "none", [], 0, [] );
    }
    
    self giveweapon( self.secondaryweaponobj );
    self setweaponammoclip( self.secondaryweaponobj, weaponclipsize( self.secondaryweaponobj ) );
    self setweaponammostock( self.secondaryweaponobj, weaponmaxammo( self.secondaryweaponobj ) );
    self switchtoweaponimmediate( self.primaryweaponobj );
}

