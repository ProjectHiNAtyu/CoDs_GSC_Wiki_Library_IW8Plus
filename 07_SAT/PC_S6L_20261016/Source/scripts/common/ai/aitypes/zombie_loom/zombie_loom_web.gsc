// scripts\common\ai\aitypes\zombie_loom\zombie_loom_web.gsc  (hash_0abf203d95a8ff29.gscc) (size: 6805 Bytes / 0x1a95 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1bd75964 (467097956)
// size ...... 6805 (0x1a95)
// includes .. 5   (offset: 0x18b1)
// strings ... 25  (offset: 0x18d9)
// dev strs .. 3   (offset: 0x1a6d)
// exports ... 22  (offset: 0xde9)
// cseg ...... 0x22b + 0xbbe (0xde9)
// imports ... 63  (offset: 0x1159)
// animtree1 . 0   (offset: 0x1a95)
// animtree2 . 0   (offset: 0x1a95)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_loom_web;

// Namespace zombie_loom_web
// Params 0
// Checksum 0xdbf630f4, Offset: 0x249
// Size: 0x5a
function function_a1e961123aed1e16()
{
    /#
        setup_web_devgui();
    #/
    
    if ( !val::is_registered( "webbed" ) )
    {
        val::register( "webbed", 0, 1, "$self" );
    }
    
    if ( !val::is_registered( "recently_webbed" ) )
    {
        val::register( "recently_webbed", 0, 1, "$self" );
    }
    
    level function_ad17c486899ccb99();
}

// Namespace zombie_loom_web
// Params 0
// Checksum 0xf4c4fe1f, Offset: 0x2ab
// Size: 0x119
function init_zombie_loom_web()
{
    self.var_697845a75531a531 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_697845a75531a531;
    self.var_77b43222d017d38a = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_77b43222d017d38a;
    self.var_ef3477be63009176 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ef3477be63009176;
    self.var_ad4d2bf5a002f6b0 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ad4d2bf5a002f6b0;
    self.var_a50a053bdb31b613 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_a50a053bdb31b613;
    self.var_c3fd9516649eb3e = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_c3fd9516649eb3e;
    callback::add( "on_web_projectile_impact_player", &function_36f8b5a17be7df65 );
    callback::add( "on_web_projectile_impact_ai", &function_c63c7433964523fe );
    callback::add( "on_web_projectile_impact_world", &function_32226b1894de37b4 );
}

// Namespace zombie_loom_web
// Params 1
// Checksum 0x92bc65c, Offset: 0x3cc
// Size: 0x1d, Type: bool
function is_target_webbed( ent )
{
    return ent val::get( "webbed" ) ?? 0;
}

// Namespace zombie_loom_web
// Params 1, eflags: 0x4
// Checksum 0x67e9c3e, Offset: 0x3f2
// Size: 0x1e
function private function_36f8b5a17be7df65( params )
{
    function_1ea17e59d3264519( params.player );
}

// Namespace zombie_loom_web
// Params 1, eflags: 0x4
// Checksum 0xc023b698, Offset: 0x418
// Size: 0x1e
function private function_c63c7433964523fe( params )
{
    function_1ea17e59d3264519( params.ai );
}

// Namespace zombie_loom_web
// Params 1, eflags: 0x4
// Checksum 0xe7d292ca, Offset: 0x43e
// Size: 0x1e
function private function_32226b1894de37b4( params )
{
    thread spawn_webbed_area( params.position );
}

// Namespace zombie_loom_web
// Params 1
// Checksum 0xf57e337a, Offset: 0x464
// Size: 0x2be
function spawn_webbed_area( position )
{
    position = utility::drop_to_ground( position, 0 );
    web = spawn( "script_model", position );
    web setmodel( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f28e33a2e1e8a6df );
    web.spawntime = gettime();
    web.owner = self;
    web.team = self.team;
    web.var_bba5db50e1875a1 = self.var_ad4d2bf5a002f6b0 * self.var_ad4d2bf5a002f6b0;
    web.var_ad4d2bf5a002f6b0 = self.var_ad4d2bf5a002f6b0;
    web.var_a50a053bdb31b613 = self.var_a50a053bdb31b613;
    web.entnum = web getentitynumber();
    web endon( #"death" );
    web thread function_d7097c91159bc302( self.var_c3fd9516649eb3e );
    web.webbedtargets = [];
    
    while ( true )
    {
        potential_targets = getplayersandaiarrayinradius( position, self.var_ad4d2bf5a002f6b0 );
        
        /#
            if ( getdvarint( @"hash_32e70ac7c4846668", 0 ) > 0 )
            {
                sphere( position, self.var_ad4d2bf5a002f6b0, ( 255, 0, 0 ), 0, 30 );
            }
        #/
        
        foreach ( target in potential_targets )
        {
            if ( target.team == self.team )
            {
                continue;
            }
            
            if ( !isdefined( target.entnum ) )
            {
                target.entnum = target getentitynumber();
            }
            
            if ( web.webbedtargets[ target.entnum ] )
            {
                continue;
            }
            
            if ( target function_a76b284e8414acbb() )
            {
                continue;
            }
            
            target val::set( "webbed_area_" + web.entnum, "webbed", 1 );
            target utility::function_32b24db3127bff40( "web_fx", "web_on" );
            web.webbedtargets[ target.entnum ] = target;
            target callback::callback( #"hash_abdf98ae1ea92589", { #owner:self, #web:web } );
            target thread function_292015d9893cacf0( web, self.var_c3fd9516649eb3e );
        }
        
        wait 0.3;
    }
}

// Namespace zombie_loom_web
// Params 2, eflags: 0x4
// Checksum 0x9a93c24f, Offset: 0x72a
// Size: 0x9d
function private function_644bdf1298dd5dcb( web_entnum, target )
{
    if ( !isdefined( target ) )
    {
        return;
    }
    
    id = "webbed_area_" + web_entnum;
    target effect_slow::function_80a4bd13b5ba303a( id );
    target val::reset( id, "webbed" );
    target callback::callback( #"hash_95831f433eaeb889", { #owner:self.owner, #web:self } );
    
    if ( !target val::get( "webbed" ) )
    {
        target utility::function_32b24db3127bff40( "web_fx", "web_off" );
    }
}

// Namespace zombie_loom_web
// Params 1, eflags: 0x4
// Checksum 0xfcd7947, Offset: 0x7cf
// Size: 0x15
function private function_c56003a2409a610d( params )
{
    thread function_f488096a6ee17f69( params );
}

// Namespace zombie_loom_web
// Params 1, eflags: 0x4
// Checksum 0x55c2a46a, Offset: 0x7ec
// Size: 0x34
function private function_f488096a6ee17f69( value_id )
{
    self notify( value_id );
    self endon( value_id );
    wait 5;
    
    if ( self && isalive( self ) )
    {
        val::reset( value_id, "recently_webbed" );
    }
}

// Namespace zombie_loom_web
// Params 2, eflags: 0x4
// Checksum 0xab2d08c1, Offset: 0x828
// Size: 0x148
function private function_292015d9893cacf0( web, duration )
{
    self endon( #"death_or_disconnect" );
    web endon( #"death" );
    spawntime = web.spawntime;
    entnum = web.entnum;
    slowduration = duration - utility::function_6f5d2e1f1ff70482( gettime() - spawntime );
    
    if ( slowduration > 0 )
    {
        id = "webbed_area_" + entnum;
        val::set( id, "recently_webbed", 1 );
        effect_slow::slow( id, web.var_a50a053bdb31b613, slowduration, web.owner, &function_c56003a2409a610d, undefined, undefined, id );
        
        while ( self && web && distancesquared( self.origin, web.origin ) < web.var_bba5db50e1875a1 && !function_a76b284e8414acbb() )
        {
            wait 0.3;
        }
        
        if ( self )
        {
            web function_644bdf1298dd5dcb( entnum, self );
            
            if ( web.webbedtargets && self )
            {
                web.webbedtargets[ self.entnum ] = undefined;
            }
        }
    }
}

// Namespace zombie_loom_web
// Params 1, eflags: 0x4
// Checksum 0x4e32f8d3, Offset: 0x978
// Size: 0x110
function private function_d7097c91159bc302( duration )
{
    if ( self.owner )
    {
        self.owner utility::waittill_any_timeout( duration, "death" );
        
        if ( self )
        {
            foreach ( target in self.webbedtargets )
            {
                if ( !target )
                {
                    continue;
                }
                
                function_644bdf1298dd5dcb( self.entnum, target );
            }
            
            self notify( #"death" );
        }
    }
    
    if ( self )
    {
        utility::function_32b24db3127bff40( "web", "off" );
    }
    
    wait 0.2;
    playworldsound( self.origin + ( 0, 0, 45 ), #"hash_389f436c64ed89fc" );
    self delete();
}

// Namespace zombie_loom_web
// Params 1, eflags: 0x4
// Checksum 0x8cb65855, Offset: 0xa90
// Size: 0xbb
function private function_1ea17e59d3264519( hitent )
{
    if ( isalive( hitent ) && !hitent function_a76b284e8414acbb() )
    {
        self.var_865aafa52f1e6798 = 1;
        hitent val::set( "webbed_projectile", "recently_webbed", 1 );
        hitent effect_slow::slow( "webbed_projectile", self.var_697845a75531a531, self.var_77b43222d017d38a, self, &function_c56003a2409a610d, undefined, undefined, "webbed_projectile" );
        hitent val::set( "webbed_projectile", "webbed", 1 );
        hitent utility::function_32b24db3127bff40( "web_fx", "web_on" );
        hitent thread function_55ce571066cf5b31( self.var_ef3477be63009176 );
        thread spawn_webbed_area( hitent.origin );
    }
}

// Namespace zombie_loom_web
// Params 1, eflags: 0xc
// Checksum 0x35e890b9, Offset: 0xb53
// Size: 0x68
function private function_55ce571066cf5b31( delay )
{
    self notify( #"hash_f9f432438eb9db1d" );
    self endon( #"hash_f9f432438eb9db1d" );
    self endon( #"death" );
    wait delay;
    
    if ( self )
    {
        val::reset( "webbed_projectile", "webbed" );
        
        if ( !val::get( "webbed" ) )
        {
            utility::function_32b24db3127bff40( "web_fx", "web_off" );
        }
    }
}

// Namespace zombie_loom_web
// Params 0, eflags: 0x4
// Checksum 0x323788f1, Offset: 0xbc3
// Size: 0x74
function private function_ad17c486899ccb99()
{
    callback::add( #"player_damaged", &function_74aba2c9e0c82d18 );
    callback::add( #"on_used_super", &function_f6857bf535618581 );
    callback::add( "usurped_power_deploying", &function_cf765afc7357fd63 );
    callback::add( "on_healingaura_healed", &function_cf765afc7357fd63 );
    callback::add( #"on_adrenaline_used", &function_cf765afc7357fd63 );
    callback::add( "lightray_healing", &function_cf765afc7357fd63 );
}

// Namespace zombie_loom_web
// Params 0
// Checksum 0x66e82215, Offset: 0xc3f
// Size: 0x5a, Type: bool
function function_a76b284e8414acbb()
{
    var_a486f1d1629803ac = isplayer( self ) && self.mask_ee.var_73e37bf886655ce7.ref == "zmloot_scarab_loom_ride_ee_mask";
    return var_a486f1d1629803ac || utility::ent_flag( "wiley_fox_active" ) || utility::ent_flag( "is_usurped_power_grabbed" );
}

// Namespace zombie_loom_web
// Params 1, eflags: 0x4
// Checksum 0x1bd9f101, Offset: 0xca2
// Size: 0x3c
function private function_74aba2c9e0c82d18( params )
{
    if ( params.smeansofdeath == "MOD_BURNED" || params.smeansofdeath == "MOD_FIRE" )
    {
        function_cf765afc7357fd63();
    }
}

// Namespace zombie_loom_web
// Params 1, eflags: 0x4
// Checksum 0xb33e11cd, Offset: 0xce6
// Size: 0x72
function private function_f6857bf535618581( params )
{
    if ( isplayer( params.player ) )
    {
        var_e93a67c34276fb3f = params.superinfo.staticdata.ref;
        
        if ( var_e93a67c34276fb3f == "super_healing_aura" || var_e93a67c34276fb3f == "super_wiley_fox" )
        {
            params.player function_cf765afc7357fd63();
        }
    }
}

// Namespace zombie_loom_web
// Params 1, eflags: 0x4
// Checksum 0x34c3c718, Offset: 0xd60
// Size: 0x31
function private function_cf765afc7357fd63( params )
{
    if ( is_target_webbed( self ) && effect_slow::function_6fab6266b5f636c3( "webbed_projectile" ) )
    {
        effect_slow::function_80a4bd13b5ba303a( "webbed_projectile" );
    }
}

/#

    // Namespace zombie_loom_web
    // Params 0
    // Checksum 0x678291c2, Offset: 0xd99
    // Size: 0x2e, Type: dev
    function setup_web_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3a>", "<dev string:x4d>", &function_40ed0c886d273747 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_loom_web
    // Params 0, eflags: 0x4
    // Checksum 0xbd2780da, Offset: 0xdcf
    // Size: 0x1a, Type: dev
    function private function_40ed0c886d273747()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x4d>", @"hash_32e70ac7c4846668" );
    }

#/
