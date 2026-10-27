// scripts\mp\common\perks\perk_hunter.gsc  (hash_098605104cf3f67d.gscc) (size: 3301 Bytes / 0xce5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x50b57110 (1354068240)
// size ...... 3301 (0xce5)
// includes .. 4   (offset: 0xbd9)
// strings ... 16  (offset: 0xbf9)
// dev strs .. 2   (offset: 0xccd)
// exports ... 7   (offset: 0x825)
// cseg ...... 0x1b3 + 0x672 (0x825)
// imports ... 22  (offset: 0x93d)
// animtree1 . 0   (offset: 0xce5)
// animtree2 . 0   (offset: 0xce5)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\vision_utility;

#namespace perk_hunter;

// Namespace perk_hunter
// Params 0, eflags: 0x1
// Checksum 0x2cfdda1c, Offset: 0x1d1
// Size: 0x18
function autoexec main()
{
    level callback::add( #"register_perk", &perk_register );
}

// Namespace perk_hunter
// Params 1
// Checksum 0x48767a5c, Offset: 0x1f1
// Size: 0x9c
function perk_register( params )
{
    bundle = level.perkbundles[ "specialty_hunter" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_hunter", &perk_set, &perk_unset, [ "specialty_quickdraw", "specialty_fastoffhand", "specialty_quickswap", "specialty_stalker", "specialty_sprintfire", "specialty_fastsprintrecovery", "specialty_sixth_sense" ] );
    }
}

// Namespace perk_hunter
// Params 0
// Checksum 0x7f616df5, Offset: 0x295
// Size: 0xd0
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
    
    namespace_9d8e359c3b1041e5::giveperksharedfunc( "specialty_combat_tracker" );
    thread perk_think();
}

// Namespace perk_hunter
// Params 0
// Checksum 0x23e630f9, Offset: 0x36d
// Size: 0x11d
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
    
    namespace_9d8e359c3b1041e5::removeperksharedfunc( "specialty_combat_tracker" );
    self.var_cdde407b656b8600 = undefined;
}

// Namespace perk_hunter
// Params 0
// Checksum 0x29990345, Offset: 0x492
// Size: 0x300
function perk_think()
{
    self endon( #"zombie_vision_unset" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    bundle = level.perkbundles[ "specialty_hunter" ];
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

// Namespace perk_hunter
// Params 0
// Checksum 0x163e54a0, Offset: 0x79a
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

