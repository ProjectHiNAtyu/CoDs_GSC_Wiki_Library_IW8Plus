// scripts\mp\common\perks\perceptive.gsc  (hash_14ab44fecbcc3273.gscc) (size: 3078 Bytes / 0xc06 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8b1ed9e9 (2334054889)
// size ...... 3078 (0xc06)
// includes .. 3   (offset: 0xb6a)
// strings ... 9   (offset: 0xb82)
// dev strs .. 0   (offset: 0xc06)
// exports ... 13  (offset: 0x67e)
// cseg ...... 0x12c + 0x552 (0x67e)
// imports ... 24  (offset: 0x886)
// animtree1 . 0   (offset: 0xc06)
// animtree2 . 0   (offset: 0xc06)
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\utility;

#namespace perceptive;

// Namespace perceptive
// Params 0, eflags: 0x1
// Checksum 0xc852b59a, Offset: 0x14a
// Size: 0x98
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_3c26e63df0ff0308 );
    
    if ( !isdefined( level.sharedfuncs[ #"perceptive" ][ #"incrementcount" ] ) )
    {
        utility::registersharedfunc( #"perceptive", #"incrementcount", &function_42bca1267728522d );
    }
    
    if ( !isdefined( level.sharedfuncs[ #"perceptive" ][ #"decrementcount" ] ) )
    {
        utility::registersharedfunc( #"perceptive", #"decrementcount", &function_13b9243f3f43b0e9 );
    }
}

// Namespace perceptive
// Params 1
// Checksum 0x96ed5eb2, Offset: 0x1ea
// Size: 0xac
function function_3c26e63df0ff0308( params )
{
    bundle = level.perkbundles[ "specialty_perceptive" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isfunction( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_spykitimmune" );
        level [[ params.var_a2358848c4408242 ]]( "specialty_enemyradar" );
    }
    
    if ( isfunction( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_perceptive", &setperceptive, &unsetperceptive, [ "specialty_spykitimmune", "specialty_enemyradar" ] );
    }
}

// Namespace perceptive
// Params 0
// Checksum 0x90230c21, Offset: 0x29e
// Size: 0x41
function setperceptive()
{
    self setclientomnvar( o"ui_perceptive", 0 );
    self setclientomnvar( o"ui_perceptive_indicator", 0 );
    thread function_be8ee01e0f29f957();
    self notify( #"perceptive_count_update" );
    level notify( #"uav_update" );
}

// Namespace perceptive
// Params 0
// Checksum 0xdc0a17a5, Offset: 0x2e7
// Size: 0x3a
function unsetperceptive()
{
    self notify( #"perceptive_unset" );
    self setclientomnvar( o"ui_perceptive", 0 );
    self setclientomnvar( o"ui_perceptive_indicator", 0 );
    level notify( #"uav_update" );
}

// Namespace perceptive
// Params 1
// Checksum 0xae262f07, Offset: 0x329
// Size: 0x54
function function_42bca1267728522d( entnum )
{
    if ( !isnumber( entnum ) )
    {
        script::demoforcesre( "EntNum is not a number." );
        return;
    }
    
    if ( !isdefined( self.var_e05c483acdc9f920 ) )
    {
        self.var_e05c483acdc9f920 = [];
    }
    
    self.var_e05c483acdc9f920[ entnum ] = 1;
    self notify( #"perceptive_count_update" );
}

// Namespace perceptive
// Params 1
// Checksum 0xfa32d223, Offset: 0x385
// Size: 0x3b
function function_13b9243f3f43b0e9( entnum )
{
    if ( !isnumber( entnum ) )
    {
        script::demoforcesre( "EntNum is not a number." );
        return;
    }
    
    self.var_e05c483acdc9f920[ entnum ] = undefined;
    self notify( #"perceptive_count_update" );
}

// Namespace perceptive
// Params 0
// Checksum 0xd6c63733, Offset: 0x3c8
// Size: 0x5b
function function_be8ee01e0f29f957()
{
    self endon( #"death_or_disconnect" );
    self endon( #"perceptive_unset" );
    
    while ( true )
    {
        message = utility::waittill_any_ents_return( self, "perceptive_count_update", self, "spotted_by_enemy_radar", self, "unspotted_by_enemy_radar", level, "uav_update", self, "weapon_fired" );
        thread function_7e790850c62da1ed( message );
    }
}

// Namespace perceptive
// Params 0
// Checksum 0x47803dc2, Offset: 0x42b
// Size: 0xe, Type: bool
function function_ed771d0ba08e754b()
{
    return self.var_e05c483acdc9f920.size > 0;
}

// Namespace perceptive
// Params 1
// Checksum 0x8015bfb5, Offset: 0x442
// Size: 0xe1
function function_7e790850c62da1ed( message )
{
    self notify( #"hash_422110f6b813bb45" );
    self endon( #"hash_422110f6b813bb45" );
    
    if ( !isplayer( self ) || !isalive( self ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    waittillframeend();
    
    if ( !isplayer( self ) || !isalive( self ) )
    {
        return;
    }
    
    if ( message == "weapon_fired" && gettime() - ( self.var_5a4003bfe509b071 ?? 0 ) <= 100 )
    {
        function_721efc2ed2c55396();
        thread function_cdb052273a331d5d( level.perkbundles[ "specialty_perceptive" ].var_9c3c75f868103ee2 ?? 0.1 );
        return;
    }
    
    if ( function_ed771d0ba08e754b() || !function_ba821a96d0af754d( self ) && self spottedbyenemyradar() )
    {
        function_721efc2ed2c55396();
        return;
    }
    
    thread function_4abe49a4ee09ce28( 0.1 );
}

// Namespace perceptive
// Params 0, eflags: 0x4
// Checksum 0xba12821c, Offset: 0x52b
// Size: 0x44
function private function_721efc2ed2c55396()
{
    profilestart();
    self notify( #"perceptiveactivated" );
    
    if ( !self getclientomnvar( o"ui_perceptive" ) )
    {
        self setclientomnvar( o"ui_perceptive", 1 );
        self setclientomnvar( o"ui_perceptive_indicator", 1 );
    }
    
    profilestop();
}

// Namespace perceptive
// Params 1, eflags: 0xc
// Checksum 0xc8724b11, Offset: 0x577
// Size: 0x7c
function private function_4abe49a4ee09ce28( delay )
{
    self notify( #"hash_8d33e728ef6bb8d1" );
    self endon( #"hash_8d33e728ef6bb8d1" );
    
    if ( gettime() < self.var_e20931fece069409 )
    {
        return;
    }
    
    if ( delay )
    {
        self endon( #"death_or_disconnect", #"perceptive_unset", #"perceptiveactivated" );
        wait delay;
    }
    
    self setclientomnvar( o"ui_perceptive", 0 );
    self setclientomnvar( o"ui_perceptive_indicator", 0 );
}

// Namespace perceptive
// Params 1, eflags: 0xc
// Checksum 0xae96d0f4, Offset: 0x5fb
// Size: 0x83
function private function_cdb052273a331d5d( delay )
{
    self notify( #"hash_1e5e6517a3f47948" );
    self endon( #"hash_1e5e6517a3f47948" );
    self.var_e20931fece069409 = self.var_5a4003bfe509b071 + delay * 1000;
    
    if ( delay )
    {
        self endon( #"death_or_disconnect", #"perceptive_unset", #"perceptiveactivated" );
        wait delay;
    }
    
    self setclientomnvar( o"ui_perceptive", 0 );
    self setclientomnvar( o"ui_perceptive_indicator", 0 );
}

