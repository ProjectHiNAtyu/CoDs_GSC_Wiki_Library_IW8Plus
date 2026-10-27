// scripts\mp\common\equipment\health_kit.gsc  (hash_7c0a42353e91fe0a.gscc) (size: 7144 Bytes / 0x1be8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x327870ad (846753965)
// size ...... 7144 (0x1be8)
// includes .. 11  (offset: 0x1a14)
// strings ... 22  (offset: 0x1a6c)
// dev strs .. 0   (offset: 0x1be8)
// exports ... 29  (offset: 0xe24)
// cseg ...... 0x212 + 0xc12 (0xe24)
// imports ... 62  (offset: 0x12ac)
// animtree1 . 0   (offset: 0x1be8)
// animtree2 . 0   (offset: 0x1be8)
#using script_16ea1b94f0f381b3;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\debuff_util;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\playerhealth;
#using scripts\mp\supers;

#namespace health_kit;

// Namespace health_kit
// Params 0, eflags: 0x1
// Checksum 0x3ae7aa51, Offset: 0x230
// Size: 0x9
function autoexec main()
{
    function_7ae8d1f36d4c40b7();
}

// Namespace health_kit
// Params 0
// Checksum 0xa31ccfad, Offset: 0x241
// Size: 0x6e
function function_7ae8d1f36d4c40b7()
{
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_trauma_kit", &function_e93e2f175526397f, &function_a9c8c516b0dc6ed6, &function_64a6993ac39454d5, &function_da854f6fc90b3aa9, undefined, undefined, undefined, undefined, undefined );
    supers_mp::function_48aaa60b2ce7b8a1( "super_med_kit", &function_e93e2f175526397f, &function_a9c8c516b0dc6ed6, &function_f585e6584ca58cad, &function_da854f6fc90b3aa9, undefined, undefined, undefined, undefined, undefined );
    level callback::add( #"player_offhand_pullback", &on_player_offhand_pullback );
}

// Namespace health_kit
// Params 1, eflags: 0x4
// Checksum 0x62d2a9ee, Offset: 0x2b7
// Size: 0x35
function private on_player_offhand_pullback( params )
{
    if ( params.objweapon.basenamehash == %"sat_trauma_kit_wz" )
    {
        thread function_2d0ebe76a0e96bc9();
    }
}

// Namespace health_kit
// Params 0
// Checksum 0xa277e4d7, Offset: 0x2f4
// Size: 0xc6
function function_e93e2f175526397f()
{
    if ( !isbot( self ) )
    {
        foreach ( command in [ "+weapnext", "+weapprev", "selectweapon1", "selectweapon2", "selectweapon3", "select_melee_weapon", "-special" ] )
        {
            self notifyonplayercommand( "trauma_kit_use_stopped", command );
        }
    }
    
    function_9dd7fc502293e44b();
}

// Namespace health_kit
// Params 0
// Checksum 0x42f29b42, Offset: 0x3c2
// Size: 0xdc
function function_a9c8c516b0dc6ed6()
{
    self notify( #"take_trauma_kit" );
    self.var_96a334a30f17d55f = undefined;
    
    if ( !isbot( self ) )
    {
        foreach ( command in [ "+weapnext", "+weapprev", "selectweapon1", "selectweapon2", "selectweapon3", "select_melee_weapon", "-special" ] )
        {
            self notifyonplayercommandremove( "trauma_kit_use_stopped", command );
        }
    }
    
    function_1950d32887244671();
}

// Namespace health_kit
// Params 0, eflags: 0xc
// Checksum 0x46821d7a, Offset: 0x4a6
// Size: 0x97
function private function_2d0ebe76a0e96bc9()
{
    self notify( #"hash_e52177e8c88346e0" );
    self endon( #"hash_e52177e8c88346e0" );
    thread function_4a60780f18895261();
    self endon( #"death_or_disconnect" );
    self endon( #"take_trauma_kit" );
    self endon( #"trauma_kit_use_stopped" );
    self.var_96a334a30f17d55f = undefined;
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_trauma_kit" );
    useduration = bundle.var_73e59f040d7dd557 ?? 1;
    wait useduration;
    self.var_96a334a30f17d55f = 1;
    self releaseoffhand();
}

// Namespace health_kit
// Params 0, eflags: 0xc
// Checksum 0x884d9443, Offset: 0x545
// Size: 0x7c
function private function_4a60780f18895261()
{
    self notify( #"hash_6926f0392d1d0ed8" );
    self endon( #"hash_6926f0392d1d0ed8" );
    
    if ( isbot( self ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_trauma_kit" );
    useduration = bundle.var_73e59f040d7dd557 ?? 1;
    function_dad33b3551c41a2( useduration );
    self setclientomnvar( "ui_health_kit_progress", 0 );
}

// Namespace health_kit
// Params 1, eflags: 0x4
// Checksum 0xb5927d85, Offset: 0x5c9
// Size: 0x34
function private function_dad33b3551c41a2( useduration )
{
    self endon( #"take_trauma_kit" );
    self endon( #"trauma_kit_use_stopped" );
    childthread function_d01d322312c3b4e4();
    function_9d0e2c4f70a6d211( useduration );
}

// Namespace health_kit
// Params 0, eflags: 0x4
// Checksum 0xf5233ab2, Offset: 0x605
// Size: 0x4f
function private function_d01d322312c3b4e4()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_trauma_kit" );
    
    while ( true )
    {
        if ( self getheldoffhand().basenamehash != bundle.offhandweapon )
        {
            break;
        }
        
        waitframe();
    }
    
    self notify( #"trauma_kit_use_stopped" );
}

// Namespace health_kit
// Params 0
// Checksum 0x4ab3f765, Offset: 0x65c
// Size: 0x94, Type: bool
function function_64a6993ac39454d5()
{
    self endon( #"death_or_disconnect" );
    self notify( #"trauma_kit_use_stopped" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_trauma_kit" );
    
    if ( !validateuse( bundle ) )
    {
        return false;
    }
    
    if ( !isdefined( self.var_96a334a30f17d55f ) )
    {
        return false;
    }
    
    thread useovertime( bundle );
    challenges::function_a0936b0e5b4550f3( "super_trauma_kit", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
    self.var_96a334a30f17d55f = undefined;
    self notify( #"take_trauma_kit" );
    return true;
}

// Namespace health_kit
// Params 2
// Checksum 0x7d9d5324, Offset: 0x6f9
// Size: 0x15
function function_da854f6fc90b3aa9( fromdeath, attacker )
{
    
}

// Namespace health_kit
// Params 0, eflags: 0x4
// Checksum 0x303bc4e6, Offset: 0x716
// Size: 0x3d
function private function_9dd7fc502293e44b()
{
    if ( !isdefined( self ) || !getdvarint( @"hash_f9997a881c7c12d2", 1 ) )
    {
        return;
    }
    
    function_1ac0d40590b906dd();
    function_d6d5955e618644dd( 1 );
    self notifyonplayercommand( "trauma_kit_super_button_pressed", "+special" );
}

// Namespace health_kit
// Params 0, eflags: 0x4
// Checksum 0x8bc9e7ae, Offset: 0x75b
// Size: 0x37
function private function_1950d32887244671()
{
    if ( !getdvarint( @"hash_f9997a881c7c12d2", 1 ) )
    {
        return;
    }
    
    self notifyonplayercommandremove( "trauma_kit_super_button_pressed", "+special" );
    function_d6d5955e618644dd( 0 );
    function_465636a5135ca636( 1 );
}

// Namespace health_kit
// Params 1, eflags: 0x4
// Checksum 0x91ec895, Offset: 0x79a
// Size: 0x5d
function private function_1ac0d40590b906dd( params )
{
    canuse = 1;
    superref = namespace_9d8e359c3b1041e5::getcurrentsuperrefsharedfunc();
    
    if ( superref == "super_trauma_kit" && function_1a3211e5ef678595( supers_mp::function_5ffd3dfa9cc1e8de( superref ) ) == #"health_full" )
    {
        canuse = 0;
    }
    
    function_465636a5135ca636( canuse );
}

// Namespace health_kit
// Params 1, eflags: 0x4
// Checksum 0x377b243b, Offset: 0x7ff
// Size: 0x74
function private function_465636a5135ca636( canuse )
{
    if ( canuse )
    {
        val::reset_all( "super_traumaKit_canUseSupers" );
        callback::remove( #"player_damaged", &function_1ac0d40590b906dd );
        return;
    }
    
    val::set( "super_traumaKit_canUseSupers", "supers", 0 );
    
    if ( !callback::exists( #"player_damaged", &function_1ac0d40590b906dd ) )
    {
        callback::add( #"player_damaged", &function_1ac0d40590b906dd );
    }
}

// Namespace health_kit
// Params 1, eflags: 0xc
// Checksum 0xe29104e8, Offset: 0x87b
// Size: 0x9d
function private function_d6d5955e618644dd( shouldwatch )
{
    self notify( #"hash_da3e2a180849a5c5" );
    self endon( #"hash_da3e2a180849a5c5" );
    
    if ( !shouldwatch )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        message = utility::waittill_any_return( "healed", "trauma_kit_super_button_pressed" );
        
        switch ( message )
        {
            case #"hash_72607be1d457a73a":
                function_1ac0d40590b906dd();
                break;
            case #"hash_1e4369f6345dcc58":
                function_2a2fb7edb20e964b();
                break;
        }
    }
}

// Namespace health_kit
// Params 0, eflags: 0x4
// Checksum 0x1d568445, Offset: 0x920
// Size: 0x82
function private function_2a2fb7edb20e964b()
{
    if ( namespace_9d8e359c3b1041e5::getcurrentsuperrefsharedfunc() == "super_trauma_kit" && supers_mp::issuperready() && player::isaliveandnotinlaststand( self ) && val::get( "supers" ) == 0 )
    {
        self playlocalsound( "fly_pickup_deny" );
        
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"hash_19fc512ff8952bf3" );
        }
    }
}

// Namespace health_kit
// Params 0
// Checksum 0x9cd51f58, Offset: 0x9aa
// Size: 0x7
function function_712a3c3caa4ef0a7()
{
    return "super_trauma_kit";
}

// Namespace health_kit
// Params 0
// Checksum 0xe71a5bfe, Offset: 0x9ba
// Size: 0xd
function function_f585e6584ca58cad()
{
    return beginuse( "super_med_kit" );
}

// Namespace health_kit
// Params 1, eflags: 0x4
// Checksum 0x64146b8a, Offset: 0x9d0
// Size: 0x7e, Type: bool
function private validateuse( bundle )
{
    var_80ac516348e38afd = function_1a3211e5ef678595( bundle );
    
    if ( var_80ac516348e38afd == #"health_full" )
    {
        self playlocalsound( "fly_pickup_deny" );
        
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"hash_19fc512ff8952bf3" );
        }
    }
    
    return !isdefined( var_80ac516348e38afd );
}

// Namespace health_kit
// Params 1, eflags: 0x4
// Checksum 0x25519f46, Offset: 0xa57
// Size: 0x9c
function private function_1a3211e5ef678595( bundle )
{
    if ( !player::isaliveandnotinlaststand( self ) )
    {
        return #"hash_fdb1912063c976c7";
    }
    
    canheal = bundle.var_fbc919d450461f96 > 0 && self.health < self.maxhealth;
    var_868a2ee681d7898b = bundle.var_6e2a29421bc22548 > 0 && ( self.temphealth ?? 0 ) < bundle.var_6e2a29421bc22548;
    
    if ( !canheal && !var_868a2ee681d7898b )
    {
        return #"health_full";
    }
}

// Namespace health_kit
// Params 1, eflags: 0x4
// Checksum 0x2e336736, Offset: 0xafc
// Size: 0xab, Type: bool
function private beginuse( supername )
{
    self endon( #"death_or_disconnect" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( supername );
    
    if ( !validateuse( bundle ) )
    {
        return false;
    }
    
    useduration = bundle.var_73e59f040d7dd557 ?? 1;
    function_8889d5fcc0ae296();
    thread pickups::playerplaygestureweaponanim( "iw8_ges_plyr_self_revive", useduration );
    thread function_9d0e2c4f70a6d211( useduration );
    wait useduration;
    challenges::function_a0936b0e5b4550f3( supername, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
    function_c502142c8e38766d();
    thread useovertime( bundle );
    return true;
}

// Namespace health_kit
// Params 1, eflags: 0xc
// Checksum 0x4f2c0d91, Offset: 0xbb0
// Size: 0xa5
function private function_9d0e2c4f70a6d211( durationseconds )
{
    self notify( #"hash_a204b7ad33510bf" );
    self endon( #"hash_a204b7ad33510bf" );
    self setclientomnvar( "ui_health_kit_progress", 0 );
    starttimems = gettime();
    endtimems = starttimems + durationseconds * 1000;
    
    while ( gettime() < endtimems )
    {
        if ( !isdefined( self ) || !player::isreallyalive( self ) )
        {
            break;
        }
        
        self setclientomnvar( "ui_health_kit_progress", ( gettime() - starttimems ) / ( endtimems - starttimems ) );
        waitframe();
    }
    
    if ( isdefined( self ) )
    {
        self setclientomnvar( "ui_health_kit_progress", 0 );
    }
}

// Namespace health_kit
// Params 1, eflags: 0x4
// Checksum 0x13e76195, Offset: 0xc5d
// Size: 0x112
function private useovertime( bundle )
{
    var_575fa5fcfb8b6b1c = bundle.var_fbc919d450461f96 ?? 0;
    var_bba1abd6b6e8005b = bundle.var_1d4e79acfac62dfd ?? 0;
    var_35a846a6bc3711bd = bundle.var_4adaaa9a0ab1c9d3 ?? 0;
    var_1cd15acbddb54186 = bundle.var_6e2a29421bc22548 ?? 0;
    regenspeedmod = bundle.var_c800833cf3039be8 ?? 1;
    
    if ( getdvarint( @"hash_71cacccd4ab39d5b", 1 ) )
    {
        debuff_util::function_91c904a55dd47b6a( var_35a846a6bc3711bd );
    }
    
    playerhealth::function_ed81022bf9702b0a( self, var_1cd15acbddb54186 );
    var_478ec9584780ac6e = var_575fa5fcfb8b6b1c + var_1cd15acbddb54186;
    
    if ( var_bba1abd6b6e8005b > 0 )
    {
        thread playerhealth::function_e32a83bf4c298600( undefined, 3, { #amount:var_478ec9584780ac6e, #nobattlechatter:1 } );
    }
    
    waittillframeend();
    self [[ utility::getsharedfunc( #"supers", #"superusefinished" ) ]]();
}

// Namespace health_kit
// Params 0, eflags: 0x4
// Checksum 0xed66170d, Offset: 0xd77
// Size: 0x35
function private function_8889d5fcc0ae296()
{
    if ( !function_478231ebea935bee() )
    {
        var_1479f07b528e4ff7 = "offhand_1h_wm_stim_v0";
        self attach( var_1479f07b528e4ff7, "tag_accessory_left" );
        self.var_cc53b164d9ca6852 = var_1479f07b528e4ff7;
    }
}

// Namespace health_kit
// Params 0, eflags: 0x4
// Checksum 0xd7b92ba1, Offset: 0xdb4
// Size: 0x2a
function private function_6885379789fd02bc()
{
    if ( !function_478231ebea935bee() )
    {
        self attach( "misc_wm_stim_pistol_v0", "tag_accessory_left" );
        self.var_cc53b164d9ca6852 = "misc_wm_stim_pistol_v0";
    }
}

// Namespace health_kit
// Params 0
// Checksum 0x3399e096, Offset: 0xde6
// Size: 0x29
function function_c502142c8e38766d()
{
    if ( function_478231ebea935bee() )
    {
        self detach( self.var_cc53b164d9ca6852, "tag_accessory_left" );
        self.var_cc53b164d9ca6852 = undefined;
    }
}

// Namespace health_kit
// Params 0, eflags: 0x4
// Checksum 0xf6fadcf4, Offset: 0xe17
// Size: 0xc, Type: bool
function private function_478231ebea935bee()
{
    return isdefined( self.var_cc53b164d9ca6852 );
}

