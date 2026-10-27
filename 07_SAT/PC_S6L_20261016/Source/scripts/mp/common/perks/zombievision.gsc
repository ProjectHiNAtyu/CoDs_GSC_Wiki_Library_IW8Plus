// scripts\mp\common\perks\zombievision.gsc  (hash_7ee3f0e0b7f810d2.gscc) (size: 2905 Bytes / 0xb59 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xecfebc0f (3976117263)
// size ...... 2905 (0xb59)
// includes .. 3   (offset: 0xaad)
// strings ... 9   (offset: 0xac5)
// dev strs .. 2   (offset: 0xb41)
// exports ... 7   (offset: 0x731)
// cseg ...... 0x10d + 0x624 (0x731)
// imports ... 20  (offset: 0x849)
// animtree1 . 0   (offset: 0xb59)
// animtree2 . 0   (offset: 0xb59)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\vision_utility;

#namespace zombievision;

// Namespace zombievision
// Params 0, eflags: 0x1
// Checksum 0xc36a605a, Offset: 0x12b
// Size: 0x18
function autoexec main()
{
    level callback::add( #"register_perk", &perk_register );
}

// Namespace zombievision
// Params 1
// Checksum 0xa4e5e40f, Offset: 0x14b
// Size: 0x66
function perk_register( params )
{
    bundle = level.perkbundles[ "specialty_zombie_vision" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_zombie_vision", &perk_set, &perk_unset, [ "specialty_combat_tracker" ] );
    }
}

// Namespace zombievision
// Params 0
// Checksum 0xada3882, Offset: 0x1b9
// Size: 0xc4
function perk_set()
{
    self notify( #"zombie_vision_set" );
    utility::callsharedfunc( #"battlerage", #"suspendvisionsets" );
    
    if ( !self.var_204294373302d750 )
    {
        self.var_204294373302d750 = 1;
        
        if ( utility::issharedfuncdefined( #"gametype", #"hash_c33c2e13f88dc633" ) )
        {
            thread utility::callsharedfunc( #"gametype", #"hash_c33c2e13f88dc633" );
        }
        else
        {
            vision_utility::function_89d3efe42060754c( "hms_test_zombie", 1 );
        }
    }
    
    if ( !isdefined( level.brgametype ) || !level.brgametype.var_e1bdd4bbb3dc3e91 )
    {
        self setscriptablepartstate( "zombie", "zombie_vision" );
    }
    
    thread perk_think();
}

// Namespace zombievision
// Params 0
// Checksum 0xdb2879fb, Offset: 0x285
// Size: 0x111
function perk_unset()
{
    self notify( #"zombie_vision_unset" );
    thread function_1de45ddcf98192ea();
    
    if ( !isdefined( level.brgametype ) || !level.brgametype.var_e1bdd4bbb3dc3e91 )
    {
        self setscriptablepartstate( "zombie", "off" );
    }
    
    foreach ( mark in self.var_cdde407b656b8600 )
    {
        if ( utility::issharedfuncdefined( #"outline", #"outlinedisable" ) )
        {
            [[ utility::getsharedfunc( #"outline", #"outlinedisable" ) ]]( mark.outlineid, mark.ent );
        }
    }
    
    self.var_cdde407b656b8600 = undefined;
}

// Namespace zombievision
// Params 0
// Checksum 0xa80a1974, Offset: 0x39e
// Size: 0x300
function perk_think()
{
    self endon( #"zombie_vision_unset" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    bundle = level.perkbundles[ "specialty_zombie_vision" ];
    detectionrange = bundle.var_54ad495c2261bd12;
    var_29600282bf0b05ed = bundle.var_cd2ba0a6d74bc489;
    self.var_cdde407b656b8600 = [];
    assert( utility::issharedfuncdefined( #"outline", #"outlineenableforplayer" ), "<dev string:x24>" );
    assert( utility::issharedfuncdefined( #"outline", #"outlinedisable" ), "<dev string:x72>" );
    
    while ( true )
    {
        entsinrange = getplayersandaiarrayinradius( self.origin, detectionrange );
        
        foreach ( ent in entsinrange )
        {
            id = ent getentitynumber();
            
            if ( isdefined( self.var_cdde407b656b8600[ id ] ) )
            {
                self.var_cdde407b656b8600[ id ].lastupdate = gettime();
                continue;
            }
            
            outline_asset = ent.team == self.team ? "jup_zombie_vision_friendly" : "jup_zombie_vision_enemy";
            self.var_cdde407b656b8600[ id ] = spawnstruct();
            self.var_cdde407b656b8600[ id ].ent = ent;
            self.var_cdde407b656b8600[ id ].outlineid = [[ utility::getsharedfunc( #"outline", #"outlineenableforplayer" ) ]]( ent, self, outline_asset, "level_script" );
            self.var_cdde407b656b8600[ id ].lastupdate = gettime();
        }
        
        foreach ( index, mark in self.var_cdde407b656b8600 )
        {
            if ( mark.lastupdate < gettime() - var_29600282bf0b05ed )
            {
                [[ utility::getsharedfunc( #"outline", #"outlinedisable" ) ]]( mark.outlineid, mark.ent );
                self.var_cdde407b656b8600[ index ] = undefined;
            }
        }
        
        wait 0.25;
    }
}

// Namespace zombievision
// Params 0
// Checksum 0x2f062dd5, Offset: 0x6a6
// Size: 0x8b
function function_1de45ddcf98192ea()
{
    self endon( #"zombie_vision_set" );
    self endon( #"death_or_disconnect" );
    wait 1;
    utility::callsharedfunc( #"battlerage", #"resumevisionsets" );
    self.var_204294373302d750 = undefined;
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_beaafbecbd34bbc1" ) )
    {
        thread utility::callsharedfunc( #"gametype", #"hash_beaafbecbd34bbc1" );
        return;
    }
    
    vision_utility::function_6cb9d8e0202ee81( "hms_test_zombie", 1 );
}

