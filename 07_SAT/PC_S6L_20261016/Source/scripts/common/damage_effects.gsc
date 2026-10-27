// scripts\common\damage_effects.gsc  (hash_6a5d3bf7a5b7064a.gscc) (size: 49659 Bytes / 0xc1fb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe20c3de2 (3792453090)
// size ...... 49659 (0xc1fb)
// includes .. 8   (offset: 0xba9f)
// strings ... 101 (offset: 0xbadf)
// dev strs .. 15  (offset: 0xc12f)
// exports ... 148 (offset: 0x8363)
// cseg ...... 0xc27 + 0x773c (0x8363)
// imports ... 246 (offset: 0x9a83)
// animtree1 . 0   (offset: 0xc1fb)
// animtree2 . 0   (offset: 0xc1fb)
#using script_526546c2a2b21d91;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\shellshock_utility;
#using scripts\common\swim_common;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;

#namespace damage_effects;

// Namespace damage_effects
// Params 4
// Checksum 0xc5376312, Offset: 0xc45
// Size: 0x18f
function init( var_9b255a0fe977d3fa, var_22d5905e922fbec, var_c7ed7c71efc37cd5, var_b1a25a9239f018ef )
{
    if ( !isdefined( level.var_df984a778b312c7f ) )
    {
        level.var_df984a778b312c7f = 0.55;
    }
    
    if ( !isdefined( level.var_b487d47112fa93d ) )
    {
        level.var_b487d47112fa93d = 0.7;
    }
    
    level.damage_effects = spawnstruct();
    level.damage_effects.var_9b255a0fe977d3fa = var_9b255a0fe977d3fa;
    level.damage_effects.var_22d5905e922fbec = var_22d5905e922fbec;
    level.damage_effects.var_c7ed7c71efc37cd5 = var_c7ed7c71efc37cd5;
    level.damage_effects.var_b1a25a9239f018ef = var_b1a25a9239f018ef;
    level.damage_effects.var_71fb9e54a35000ee = getdvarint( @"hash_816b3104c83b99ae", 1 ) == 1;
    utility::registersharedfunc( #"damage_effects", #"hash_7ff5e70e05a98fb0", &function_62abb01e22577bf9 );
    callback::add( "on_armor_break", &onarmorbreak );
    
    if ( level.projectbundle.var_404374de902c8ca5 )
    {
        function_f7189a431541745c();
    }
    
    if ( level.gamemodebundle.var_e60b353ab6286751 )
    {
        function_fc21ac568b697622();
    }
    
    if ( !isdefined( level.var_6881a28ba2b60045 ) )
    {
        level.var_6881a28ba2b60045 = function_38fb86b5e4b7b3b1();
    }
    
    function_c80edccdcbe24517();
    function_301ebc09bfa72350();
    
    if ( getdvarint( @"hash_2c286b3bdd26f426" ) )
    {
        function_d8f038b4c9fbcdba();
    }
}

// Namespace damage_effects
// Params 0
// Checksum 0x4a2899de, Offset: 0xddc
// Size: 0x5a
function function_d8f038b4c9fbcdba()
{
    level.projectbundle.var_ef6418bd4fa8e55d = 1;
    level.projectbundle.var_464f31339c96f4ea = 1;
    level.projectbundle.var_8bb0c098c608ca9b = 1;
    level.projectbundle.var_a8c3b67e59666db9 = 1;
}

// Namespace damage_effects
// Params 0
// Checksum 0xc66624c4, Offset: 0xe3e
// Size: 0x275
function initdamageeffects()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.damage ) )
    {
        self.damage = spawnstruct();
    }
    else if ( isdefined( self.damage.var_be8bd22166474a49 ) )
    {
        foreach ( overlay in self.damage.var_be8bd22166474a49 )
        {
            if ( isdefined( overlay ) )
            {
                overlay destroy();
            }
        }
    }
    
    self.damage.var_be8bd22166474a49 = [];
    self.damage.var_21b9ceae80e00583 = [];
    self.damage.altdirectionalbloodoverlay = 0;
    self.damage.lastdiretionalbloodtime = -999999;
    self.damage.var_1b128c1413b534a = -999999;
    self.damage.var_7765940a1ee100f = -999999;
    self.damage.var_e8850c713b49f0fd = -999999;
    self.damage.var_e370e6e42d37c44 = -999999;
    self.damage.lastdamagetime = -999999;
    self.damage.lightdamaged = 0;
    self.damage.var_afe3644f2b88911 = 0;
    self.damage.var_3ed5e06d6d3a1175 = 0;
    self.damage.var_99e1bf56c7f1850f = 0;
    self.damage.var_3193bde100f1ac9d = -999999;
    self.damage.var_ecbd4831b1ecab4e = 1;
    
    if ( isdefined( level.projectbundle ) && level.projectbundle.var_404374de902c8ca5 )
    {
        function_ddcb7b8e06658e55();
    }
    
    initdeathsdooroverlaypulse();
    function_ab65deebd45a1f3b();
    function_eae6e9153504e252();
    function_b4c30e05d90273d3();
    thread function_2d7c16d23b87e977();
    thread function_e3bd5dd021a50141();
}

// Namespace damage_effects
// Params 1
// Checksum 0x7c8b31fd, Offset: 0x10bb
// Size: 0x3e
function onarmorbreak( params )
{
    if ( level.gamemodebundle.var_1a1e0bab1c82c7d1 && isplayer( self ) )
    {
        self setclientomnvar( o"ui_armor_break", gettime() );
    }
}

// Namespace damage_effects
// Params 1
// Checksum 0x3386700b, Offset: 0x1101
// Size: 0x1a4
function onenterdeathsdoor( smeansofdeath )
{
    self.damage.var_7765940a1ee100f = gettime();
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( self.reduceddamageeffects )
    {
        return;
    }
    
    if ( level.projectbundle.var_da5287e97e4886a )
    {
        if ( !isbot( self ) && !self.var_38620c16757519d1 )
        {
            if ( function_27dec7ae8fd0b67b( smeansofdeath ) )
            {
                function_7114bea20f7966e4();
            }
            else
            {
                function_23d7fe1244c4a184();
                function_a8b1f372b14f6fe0();
            }
        }
    }
    
    if ( self.deathsdoor )
    {
        return;
    }
    
    self.deathsdoor = 1;
    function_7bec040f73ca0296();
    
    if ( level.healthregendisabled )
    {
        self painvisionon();
    }
    
    if ( !isbot( self ) && !self.var_38620c16757519d1 )
    {
        if ( !level.projectbundle.var_da5287e97e4886a )
        {
            if ( !self.damage.var_3ed5e06d6d3a1175 )
            {
                if ( level.projectbundle.var_464f31339c96f4ea )
                {
                    function_84db26d2e08b6253( 2 );
                }
                
                function_41af24893f875219();
                function_8f42d7460c42768();
            }
        }
        else
        {
            function_41af24893f875219();
        }
    }
    
    if ( isdefined( level.damage_effects.var_c7ed7c71efc37cd5 ) )
    {
        self [[ level.damage_effects.var_c7ed7c71efc37cd5 ]]();
    }
    
    level callback::callback( #"deaths_door_enter", { #player:self } );
    
    if ( level.gamemodebundle.var_e60b353ab6286751 )
    {
    }
    
    self notify( #"deaths_door_enter" );
}

// Namespace damage_effects
// Params 1
// Checksum 0x94024a06, Offset: 0x12ad
// Size: 0xe1
function onexitdeathsdoor( healed )
{
    if ( healed )
    {
        self.painbreathloopsplayed = 0;
        self.hasdonepainbreathloopthislife = 0;
    }
    
    if ( !self.deathsdoor )
    {
        return;
    }
    
    self.deathsdoor = 0;
    
    if ( isplayer( self ) && !isbot( self ) )
    {
        function_f36d2fcb0884ef11();
        function_12ead737e0eaa800();
        function_23d7fe1244c4a184();
    }
    
    if ( level.healthregendisabled )
    {
        self painvisionoff();
    }
    
    if ( isdefined( level.damage_effects.var_b1a25a9239f018ef ) )
    {
        self [[ level.damage_effects.var_b1a25a9239f018ef ]]( !healed );
    }
    
    self.damage.var_1b128c1413b534a = gettime();
    self notify( #"deaths_door_exit" );
    utility::delaythreadendon( 0.1, "sndStartDeathsDoorSFX", &function_3ebda8157e05cafe );
}

// Namespace damage_effects
// Params 1
// Checksum 0xba38b68f, Offset: 0x1396
// Size: 0x6a
function function_ab7f2385c14d2139( healed )
{
    if ( !function_b1fbb5b747b5663a() )
    {
        return;
    }
    
    if ( !isplayer( self ) || function_b921453be5b6a831() )
    {
        return;
    }
    
    function_e7a8119fe7715b09();
    function_3ccde4410e6b0443();
    
    if ( isplayer( self ) && !isbot( self ) && !self.damage.var_44a4710e972906b2 )
    {
        function_374c3331659edb75();
    }
}

// Namespace damage_effects
// Params 1
// Checksum 0x8834083, Offset: 0x1408
// Size: 0x62
function function_a19591252686e9dd( healed )
{
    if ( !function_b1fbb5b747b5663a() )
    {
        return;
    }
    
    if ( !function_b921453be5b6a831() )
    {
        return;
    }
    
    function_e7a8119fe7715b09( 0 );
    
    if ( isplayer( self ) && !isbot( self ) )
    {
        function_eae44f812199514d();
    }
    
    self.damage.var_e8850c713b49f0fd = gettime();
    function_4ba06b084708abfb();
}

// Namespace damage_effects
// Params 9
// Checksum 0xaf7b3d8d, Offset: 0x1472
// Size: 0x67
function callback_playerdamageeffects( idamage, einflictor, eattacker, evictim, smeansofdeath, vpoint, lightarmordamage, objweapon, shitloc )
{
    damageeffects( idamage, einflictor, eattacker, evictim, smeansofdeath, vpoint, lightarmordamage, objweapon, shitloc );
}

// Namespace damage_effects
// Params 10
// Checksum 0x60f823b4, Offset: 0x14e1
// Size: 0x72
function playerdamageeffects( idamage, einflictor, eattacker, evictim, smeansofdeath, vpoint, lightarmordamage, objweapon, shitloc, vdir )
{
    damageeffects( idamage, einflictor, eattacker, evictim, smeansofdeath, vpoint, lightarmordamage, objweapon, shitloc, vdir );
}

// Namespace damage_effects
// Params 5
// Checksum 0x481a5dd1, Offset: 0x155b
// Size: 0x3cb
function falldamageeffects( falldamage, var_26513e86ba7265ea, var_26744886ba98c3a0, var_ed71587cca5f2fdb, var_ed4e4e7cca38d225 )
{
    if ( falldamage == 0 )
    {
        return;
    }
    
    if ( self function_4bbc5b259f2dd62c() && getdvarfloat( @"hash_6d2627647f7a6ac8", 1 ) == 1 )
    {
        return;
    }
    
    falldamage = min( self.maxhealth, falldamage );
    factor = falldamage / self.maxhealth;
    factor = math::normalized_float_smooth_out( factor );
    
    if ( isdefined( level.gamemodebundle.pbgpostfxbundle_falldamage ) )
    {
        pbgmix = math::factor_value( 0.8, 1, factor );
        pbgtimescale = math::factor_value( 1, 0.3, factor );
        pbgpostfxbundlestart( self, level.gamemodebundle.pbgpostfxbundle_falldamage, pbgtimescale, pbgmix );
    }
    
    if ( level.projectbundle.var_4c6526c76e411c75 )
    {
        mag = math::factor_value( 0.35, 0.61, factor );
        time = math::factor_value( 0.32, 0.4, factor );
        self earthquakeforplayer( mag, time, self.origin, 5000 );
    }
    
    if ( self function_4bbc5b259f2dd62c() && level.projectbundle.var_dab1c2079efa9082 )
    {
        return;
    }
    
    if ( level.projectbundle.var_bec849b8d4def8da )
    {
        if ( factor < 0.33 )
        {
            if ( level.projectbundle.var_7d9d6164fc942323 != "" )
            {
                self playlocalsound( level.projectbundle.var_7d9d6164fc942323 );
            }
        }
        else if ( factor < 0.7 )
        {
            if ( level.projectbundle.var_b674130f2c20bad != "" )
            {
                self playlocalsound( level.projectbundle.var_b674130f2c20bad );
            }
        }
        else if ( level.projectbundle.var_6ef0fe0929468e5c != "" )
        {
            self playlocalsound( level.projectbundle.var_6ef0fe0929468e5c );
        }
    }
    
    var_b2ba5d0eb410fee3 = getdvarfloat( @"scr_falling_damage_min_shock_factor", 0.5 );
    
    if ( factor >= var_b2ba5d0eb410fee3 )
    {
        maxshockduration = getdvarfloat( @"scr_falling_damage_max_shock_duration", level.projectbundle.var_fd842a18c1abd8be );
        var_7143686bce02003d = 1 - var_b2ba5d0eb410fee3;
        shockfactor = ( factor - var_b2ba5d0eb410fee3 ) / var_7143686bce02003d;
        shockduration = shockfactor * maxshockduration;
        shellshock_utility::_shellshock( getxhashasset( tolower( level.projectbundle.falldamageshock ) ), #"damage", shockduration, 0, 0 );
    }
    
    if ( level.projectbundle.var_464f31339c96f4ea )
    {
        intensity = math::factor_value( 5.51, 10.49, factor );
        intensity = int( round( intensity ) );
        
        if ( intensity > 8 )
        {
            function_215449d89c78ba2c();
        }
        
        function_9b917b5c0140143c( intensity );
        return;
    }
    
    var_eee13de19bf1ebaa = var_26513e86ba7265ea ?? 0.5;
    var_ef0447e19c184960 = var_26744886ba98c3a0 ?? 0.5;
    pulsealphamin = var_ed71587cca5f2fdb ?? 0.3;
    pulsealphamax = var_ed4e4e7cca38d225 ?? 0.7;
    pulsetime = math::factor_value( var_eee13de19bf1ebaa, var_ef0447e19c184960, factor );
    pulsealpha = math::factor_value( pulsealphamin, pulsealphamax, factor );
    function_26b66cf8cd25584f( pulsealpha, pulsetime );
}

// Namespace damage_effects
// Params 0
// Checksum 0x3dd53cd7, Offset: 0x192e
// Size: 0x29
function function_c0599ac395bb08c4()
{
    fadetime = 3000;
    thread function_eccb5c90bcab510c( self, 0, getdvarint( @"hash_d19a1653066cd960", fadetime ) );
}

// Namespace damage_effects
// Params 3, eflags: 0x4
// Checksum 0xa54ed9b1, Offset: 0x195f
// Size: 0xb3
function private function_eccb5c90bcab510c( player, var_98b6d38320fb65c2, fadetime = 0 )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( !isdefined( player.var_2a98d793d9ac5562 ) )
    {
        player.var_2a98d793d9ac5562 = [];
    }
    
    if ( player.var_2a98d793d9ac5562[ var_98b6d38320fb65c2 ] )
    {
        return;
    }
    
    function_c46403e02a1dcc7d( player, var_98b6d38320fb65c2, fadetime );
    player.var_2a98d793d9ac5562[ var_98b6d38320fb65c2 ] = 1;
    waittime = level.framedurationseconds + fadetime / 1000;
    wait waittime;
    player.var_2a98d793d9ac5562[ var_98b6d38320fb65c2 ] = undefined;
}

// Namespace damage_effects
// Params 0
// Checksum 0x45b1ff9b, Offset: 0x1a1a
// Size: 0xc
function function_414da3ff14df86f3()
{
    thread function_eccb5c90bcab510c( self, 0, 0 );
}

// Namespace damage_effects
// Params 0
// Checksum 0x6e5aa7da, Offset: 0x1a2e
// Size: 0xf
function function_215449d89c78ba2c()
{
    self.var_dc0bd2510ceae040 = gettime();
}

// Namespace damage_effects
// Params 0
// Checksum 0xcfaf6b51, Offset: 0x1a45
// Size: 0x37
function function_dc0bd2510ceae040()
{
    if ( isdefined( self.var_dc0bd2510ceae040 ) && gettime() - self.var_dc0bd2510ceae040 < 750 )
    {
        return 1;
    }
    
    self.var_dc0bd2510ceae040 = undefined;
    return 0;
}

// Namespace damage_effects
// Params 0
// Checksum 0x8ec4a570, Offset: 0x1a84
// Size: 0x9
function ondeatheffects()
{
    showuidamageflash();
}

// Namespace damage_effects
// Params 3
// Checksum 0xca141e96, Offset: 0x1a95
// Size: 0xd2
function damagescreenshake( idamage, smeansofdeath, lightarmordamage )
{
    if ( !function_6b7ab87854634b84() )
    {
        return;
    }
    
    if ( smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_BUMP" )
    {
        return;
    }
    
    if ( level.projectbundle.var_e533946d35317a32 && smeansofdeath == "MOD_FIRE" )
    {
        return;
    }
    
    currenttime = gettime();
    intensityindex = function_cc37f85269bbae47( idamage, smeansofdeath, lightarmordamage, currenttime );
    impulseasset = level.projectbundle.var_c8c3e8736187c0f8[ intensityindex ].impulsemotion;
    self function_9c6091c690ea2ca3( impulseasset );
    self.damage.var_3193bde100f1ac9d = currenttime;
}

// Namespace damage_effects
// Params 4
// Checksum 0x53682d79, Offset: 0x1b6f
// Size: 0x1c4
function function_cc37f85269bbae47( idamage, smeansofdeath, lightarmordamage, currenttime )
{
    var_ce316e72d23d908b = currenttime - self.damage.var_3193bde100f1ac9d;
    
    if ( var_ce316e72d23d908b < 750 )
    {
        var_6ae5e19bdce77dae = math::normalize_value( 0, 750, var_ce316e72d23d908b );
        var_7b1a0e38a1538ef7 = math::factor_value( 0, -0.35, 1 - var_6ae5e19bdce77dae );
    }
    else
    {
        var_6ae5e19bdce77dae = math::normalize_value( 0, 2000, var_ce316e72d23d908b - 750 );
        var_7b1a0e38a1538ef7 = math::factor_value( 0, 1 - self.damage.var_ecbd4831b1ecab4e, var_6ae5e19bdce77dae );
    }
    
    normdamage = math::normalize_value( level.projectbundle.var_32a30d5d7b98f5cf, level.projectbundle.var_3b0a2aefa4903f49, idamage );
    damageintensity = math::factor_value( 0.4, 1, normdamage );
    self.damage.var_ecbd4831b1ecab4e += var_7b1a0e38a1538ef7;
    self.damage.var_ecbd4831b1ecab4e = clamp( self.damage.var_ecbd4831b1ecab4e, 0, 1 );
    intensityindex = round( damageintensity * self.damage.var_ecbd4831b1ecab4e * level.projectbundle.var_c8c3e8736187c0f8.size );
    intensityindex = int( clamp( intensityindex, 0, level.projectbundle.var_c8c3e8736187c0f8.size - 1 ) );
    return intensityindex;
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x77e5d7bd, Offset: 0x1d3c
// Size: 0x37
function private function_c80edccdcbe24517()
{
    if ( !function_3c66110c15ef8b8e() )
    {
        return;
    }
    
    callback::add( #"player_in_air_begin", &function_e7302a4eea4a864 );
    callback::add( #"player_in_air_end", &function_e8e4555050c92d50 );
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x1e35dd0b, Offset: 0x1d7b
// Size: 0x45
function private function_eae6e9153504e252()
{
    if ( !function_3c66110c15ef8b8e() )
    {
        return;
    }
    
    self.damage.inairstarttime = gettime();
    self.damage.var_bfe50dcfa201091a = self.origin[ 2 ];
}

// Namespace damage_effects
// Params 1, eflags: 0x4
// Checksum 0x69b82df5, Offset: 0x1dc8
// Size: 0x5d
function private function_e7302a4eea4a864( params )
{
    if ( !isplayer( self ) || !isdefined( self.damage ) )
    {
        return;
    }
    
    self.damage.inairstarttime = gettime();
    self.damage.var_bfe50dcfa201091a = self.origin[ 2 ];
}

// Namespace damage_effects
// Params 1, eflags: 0x4
// Checksum 0xe24113a4, Offset: 0x1e2d
// Size: 0x15d
function private function_e8e4555050c92d50( params )
{
    if ( !isplayer( self ) || !isdefined( self.damage ) || !isdefined( self.damage.inairstarttime ) )
    {
        return;
    }
    
    if ( self ismantling() )
    {
        return;
    }
    
    inairtime = gettime() - self.damage.inairstarttime;
    airdrop = self.damage.var_bfe50dcfa201091a - self.origin[ 2 ];
    
    if ( airdrop < -20 )
    {
        impulseasset = undefined;
    }
    else if ( airdrop < 30 )
    {
        if ( inairtime < 100 )
        {
            impulseasset = undefined;
        }
        else if ( inairtime < 350 )
        {
            impulseasset = level.projectbundle.var_5a14a387c4e07330;
        }
        else
        {
            impulseasset = level.projectbundle.var_d588a988dbda4f26;
        }
    }
    else if ( airdrop < 100 )
    {
        impulseasset = level.projectbundle.var_d588a988dbda4f26;
    }
    else if ( airdrop < 240 )
    {
        impulseasset = level.projectbundle.var_c4ab9f88cea0c66f;
    }
    else
    {
        impulseasset = level.projectbundle.var_c603c20afa693f77;
    }
    
    if ( isdefined( impulseasset ) )
    {
        self function_9c6091c690ea2ca3( impulseasset );
    }
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0xde25670a, Offset: 0x1f92
// Size: 0x80
function private function_301ebc09bfa72350()
{
    if ( function_4c9f147158908a8f() )
    {
        level._effect[ "breath_exh_light" ] = loadfxasset( level.gamemodebundle.var_fe6e8424eb62379c );
        level._effect[ "breath_exh_med" ] = loadfxasset( level.gamemodebundle.var_2bb346ad62a69d1e );
        level._effect[ "breath_exh_heavy" ] = loadfxasset( level.gamemodebundle.var_6c156499d6ee5be3 );
    }
}

// Namespace damage_effects
// Params 0
// Checksum 0xf9d7560c, Offset: 0x201a
// Size: 0x3c
function function_b4c30e05d90273d3()
{
    if ( !function_4c9f147158908a8f() )
    {
        return;
    }
    
    if ( !isplayer( self ) || !isalive( self ) )
    {
        return;
    }
    
    if ( !function_5b132c232b742ddf() )
    {
        return;
    }
    
    level.player thread function_dc3f62d4960cafd5();
}

// Namespace damage_effects
// Params 0
// Checksum 0x6649d309, Offset: 0x205e
// Size: 0x95
function function_dc3f62d4960cafd5()
{
    self notify( #"hash_c5089d26cc08297f" );
    self endon( #"hash_c5089d26cc08297f" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"entity_breath_exhale", type );
        
        /#
            if ( getdvarint( @"scr_debug_breath", 0 ) )
            {
                iprintlnbold( type );
            }
        #/
        
        if ( function_3c46ab06e9d59893() )
        {
            vfx = function_a71fee05a4db408( type );
            playfxontagforclients( level._effect[ vfx ], self, "tag_origin", self );
        }
    }
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0xf0385698, Offset: 0x20fb
// Size: 0xb
function private function_5b132c232b742ddf()
{
    return level.var_b71007f65426e929;
}

// Namespace damage_effects
// Params 1, eflags: 0x4
// Checksum 0x2deae8c0, Offset: 0x210f
// Size: 0x160
function private function_a71fee05a4db408( type )
{
    switch ( type )
    {
        case #"hash_a18cdb0bc422300":
        case #"hash_215e95779a031af6":
        case #"hash_21c1085f9d6a42b0":
        case #"hash_2dfaba74cd8c70e1":
        case #"hash_2fe47f593863e8e1":
        case #"hash_56642fcca464d95d":
        case #"hash_7035900fc5513237":
        case #"hash_776fded5fd6cfefe":
        case #"hash_9d91d549829c1b85":
        case #"hash_a9afdbd997d301ac":
        case #"hash_af3d2cdae6d2f698":
        case #"hash_cba800daa64db4d9":
        case #"hash_e28e653e60a930da":
        case #"hash_e5d27197139370ae":
            return "breath_exh_heavy";
        case #"hash_924b8f06693095a":
        case #"hash_251d791d72234760":
        case #"hash_468996c7aaf95bfe":
        case #"hash_54f7003ab5530a27":
        case #"hash_6c49a6364c8f28f8":
        case #"hash_91863a69961b3e7a":
        case #"hash_93387a85ca6f106c":
        case #"hash_acc3008c2b3748f9":
        case #"hash_d62d1eb0179f70bb":
        case #"hash_ee71bdc2aeaff9dd":
        case #"hash_f7839cdd5c57ac44":
            return "breath_exh_light";
        default:
            return "breath_exh_med";
    }
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0xadeeb746, Offset: 0x2277
// Size: 0x28, Type: bool
function private function_3c46ab06e9d59893()
{
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( !self.iscold )
    {
        return false;
    }
    
    if ( self isswimunderwater() )
    {
        return false;
    }
    
    return true;
}

// Namespace damage_effects
// Params 1
// Checksum 0xc5a84537, Offset: 0x22a8
// Size: 0x39
function function_64c247b6e0b566cd( postfxbundle = level.gamemodebundle.pbgpostfxbundle_pain )
{
    pbgpostfx::setpain( { #postfxbundlename:postfxbundle } );
}

// Namespace damage_effects
// Params 1
// Checksum 0xb77d34bf, Offset: 0x22e9
// Size: 0x6a, Type: bool
function function_ae27c589e09c3181( smeansofdeath )
{
    switch ( smeansofdeath ?? "" )
    {
        case #"hash_3c20f39c73a1422b":
        case #"hash_571e46e17a3cf2e3":
        case #"hash_66cb246f3e55fbe2":
        case #"hash_a86d8c43482948a4":
        case #"hash_a911a1880d996edb":
        case #"hash_c22b13f81bed11f0":
            return true;
    }
    
    return false;
}

// Namespace damage_effects
// Params 1
// Checksum 0x7e90232d, Offset: 0x235c
// Size: 0x46, Type: bool
function function_1e948faff668cf2( smeansofdeath )
{
    switch ( smeansofdeath ?? "" )
    {
        case #"hash_b15027ffbdc0ecb":
        case #"hash_b1078ff213fddba6":
        case #"hash_e5033ccbb2f0e988":
            return true;
    }
    
    return false;
}

// Namespace damage_effects
// Params 1
// Checksum 0x53f576e0, Offset: 0x23ab
// Size: 0x1b, Type: bool
function function_3919f2c3b31dabb6( smeansofdeath )
{
    if ( smeansofdeath == "MOD_FIRE" )
    {
        return true;
    }
    
    return false;
}

// Namespace damage_effects
// Params 1
// Checksum 0x2776ae51, Offset: 0x23cf
// Size: 0x1b, Type: bool
function function_350d5615a4efa50b( smeansofdeath )
{
    if ( smeansofdeath == "MOD_DOWN" )
    {
        return true;
    }
    
    return false;
}

// Namespace damage_effects
// Params 0
// Checksum 0x2c80a242, Offset: 0x23f3
// Size: 0x49, Type: bool
function recentdeathsdoor()
{
    if ( isdeathsdoor() )
    {
        return true;
    }
    
    if ( isdefined( self.damage.var_1b128c1413b534a ) && gettime() - self.damage.var_1b128c1413b534a < 2000 )
    {
        return true;
    }
    
    return false;
}

// Namespace damage_effects
// Params 0
// Checksum 0x5fd59689, Offset: 0x2445
// Size: 0x49, Type: bool
function function_724e8a0b2df6c8fa()
{
    if ( function_b921453be5b6a831() )
    {
        return true;
    }
    
    if ( isdefined( self.damage.var_e8850c713b49f0fd ) && gettime() - self.damage.var_e8850c713b49f0fd < 2000 )
    {
        return true;
    }
    
    return false;
}

// Namespace damage_effects
// Params 0
// Checksum 0xaff084b9, Offset: 0x2497
// Size: 0xb
function isdeathsdoor()
{
    return self.deathsdoor;
}

// Namespace damage_effects
// Params 0
// Checksum 0x8cd9b413, Offset: 0x24ab
// Size: 0x15
function function_b921453be5b6a831()
{
    return self.damage.lightdamaged;
}

// Namespace damage_effects
// Params 1
// Checksum 0xca16e986, Offset: 0x24c9
// Size: 0x2b
function function_e7a8119fe7715b09( state = 1 )
{
    self.damage.lightdamaged = state;
}

// Namespace damage_effects
// Params 0
// Checksum 0xd52916da, Offset: 0x24fc
// Size: 0x2b
function function_b1fbb5b747b5663a()
{
    /#
        if ( getdvarint( @"hash_f1f12de0770e7bb0", 0 ) )
        {
            return 0;
        }
    #/
    
    return level.projectbundle.var_e956d74d95c468e4;
}

// Namespace damage_effects
// Params 0
// Checksum 0xe637560a, Offset: 0x2530
// Size: 0x68
function function_6b7ab87854634b84()
{
    /#
        if ( getdvarint( @"hash_3ac128d2ac5b9ebf", 0 ) )
        {
            return 0;
        }
        
        if ( level.projectbundle.var_993bb67134b2fe39 && level.projectbundle.var_c8c3e8736187c0f8.size == 0 )
        {
            assertmsg( "<dev string:x24>" );
        }
    #/
    
    return level.projectbundle.var_993bb67134b2fe39;
}

// Namespace damage_effects
// Params 0
// Checksum 0xae69ff6f, Offset: 0x25a1
// Size: 0x2b
function function_3c66110c15ef8b8e()
{
    /#
        if ( getdvarint( @"hash_3ac128d2ac5b9ebf", 0 ) )
        {
            return 0;
        }
    #/
    
    return level.projectbundle.var_22c28eacca0721bd;
}

// Namespace damage_effects
// Params 0
// Checksum 0x712fde53, Offset: 0x25d5
// Size: 0x2b
function function_4c9f147158908a8f()
{
    /#
        if ( getdvarint( @"hash_51cbdc4d2d9ca2ca", 0 ) )
        {
            return 0;
        }
    #/
    
    return level.gamemodebundle.var_fa376b701d0ec353;
}

// Namespace damage_effects
// Params 1
// Checksum 0xdc1a2325, Offset: 0x2609
// Size: 0x2b
function function_9b7d46471e3fc1e6( damage )
{
    if ( damage > 0 )
    {
        self.damage.lastdamagetime = gettime();
    }
}

// Namespace damage_effects
// Params 0
// Checksum 0xd1ff903, Offset: 0x263c
// Size: 0x383
function function_f7189a431541745c()
{
    if ( !level.gamemodebundle.var_385e12999dd56be5 )
    {
        level._effect[ "blood_unarmored_front_med" ] = loadfxasset( "vfx_rex_core_player_1p_blood_forward" );
        level._effect[ "blood_unarmored_back_med" ] = loadfxasset( "vfx_rex_core_player_1p_blood_back" );
        level._effect[ "blood_unarmored_left_med" ] = loadfxasset( "vfx_rex_core_player_1p_blood_left" );
        level._effect[ "blood_unarmored_right_med" ] = loadfxasset( "vfx_rex_core_player_1p_blood_right" );
        level._effect[ "blood_armored_front_med" ] = loadfxasset( "vfx_rex_core_player_1p_armor_mid" );
        level._effect[ "blood_armored_back_med" ] = loadfxasset( "vfx_rex_core_player_1p_armor_back" );
        level._effect[ "blood_armored_left_med" ] = loadfxasset( "vfx_rex_core_player_1p_armor_left" );
        level._effect[ "blood_armored_right_med" ] = loadfxasset( "vfx_rex_core_player_1p_armor_right" );
        level._effect[ "blood_deathsdoor" ] = loadfxasset( "vfx_rex_core_player_1p_blood_deathsdoor_01" );
        return;
    }
    
    if ( level.gamemodebundle.var_5b2f193031e1cb3f )
    {
        particlebundle = getscriptbundle( level.gamemodebundle.var_5b2f193031e1cb3f );
        level._effect[ "blood_unarmored_front_med" ] = loadfxasset( particlebundle.blood_unarmored_front_med );
        level._effect[ "blood_unarmored_back_med" ] = loadfxasset( particlebundle.blood_unarmored_back_med );
        level._effect[ "blood_unarmored_left_med" ] = loadfxasset( particlebundle.blood_unarmored_left_med );
        level._effect[ "blood_unarmored_right_med" ] = loadfxasset( particlebundle.blood_unarmored_right_med );
        level._effect[ "blood_armored_front_med" ] = loadfxasset( particlebundle.blood_armored_front_med );
        level._effect[ "blood_armored_back_med" ] = loadfxasset( particlebundle.blood_armored_back_med );
        level._effect[ "blood_armored_left_med" ] = loadfxasset( particlebundle.blood_armored_left_med );
        level._effect[ "blood_armored_right_med" ] = loadfxasset( particlebundle.blood_armored_right_med );
        level._effect[ "blood_deathsdoor" ] = loadfxasset( particlebundle.blood_deathsdoor );
        level._effect[ "blood_killcam" ] = loadfxasset( particlebundle.blood_killcam );
        level._effect[ "blood_screen_back" ] = loadfxasset( particlebundle.blood_screen_back );
        level._effect[ "blood_screen_forward" ] = loadfxasset( particlebundle.blood_screen_forward );
        level._effect[ "blood_screen_left" ] = loadfxasset( particlebundle.blood_screen_left );
        level._effect[ "blood_screen_right" ] = loadfxasset( particlebundle.blood_screen_right );
        level._effect[ "blood_headshot" ] = loadfxasset( particlebundle.blood_headshot );
        level._effect[ "blood_back_ch" ] = loadfxasset( particlebundle.blood_back_ch );
        level._effect[ "blood_left_ch" ] = loadfxasset( particlebundle.blood_left_ch );
        level._effect[ "blood_mid_ch" ] = loadfxasset( particlebundle.blood_mid_ch );
        level._effect[ "blood_right_ch" ] = loadfxasset( particlebundle.blood_right_ch );
    }
}

// Namespace damage_effects
// Params 0
// Checksum 0xd702c43a, Offset: 0x29c7
// Size: 0x38f
function function_ddcb7b8e06658e55()
{
    self.damage.var_36f37abd252184c6 = [];
    
    if ( !level.gamemodebundle.var_385e12999dd56be5 )
    {
        self.damage.var_36f37abd252184c6[ "blood_unarmored_front_med" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_unarmored_back_med" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_unarmored_left_med" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_unarmored_right_med" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_armored_front_med" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_armored_back_med" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_armored_left_med" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_armored_right_med" ] = -9999999;
    }
    else
    {
        self.damage.var_36f37abd252184c6[ "blood_unarmored_front_med" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_unarmored_back_med" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_unarmored_left_med" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_unarmored_right_med" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_deathsdoor" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_armored_front_med" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_armored_back_med" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_armored_left_med" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_armored_right_med" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_killcam" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_screen_back" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_screen_forward" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_screen_left" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_screen_right" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_headshot" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_back_ch" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_left_ch" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_mid_ch" ] = -9999999;
        self.damage.var_36f37abd252184c6[ "blood_right_ch" ] = -9999999;
    }
    
    self.damage.var_5cca578d4e528b0b = -999999;
}

// Namespace damage_effects
// Params 2
// Checksum 0x8b0dc7e7, Offset: 0x2d5e
// Size: 0x2d
function function_1e8905858f17456b( vfxid, currenttime )
{
    self.damage.var_36f37abd252184c6[ vfxid ] = currenttime;
}

// Namespace damage_effects
// Params 0
// Checksum 0x1fcf05f5, Offset: 0x2d93
// Size: 0x19
function function_dbe4bdbb0a9c16d9()
{
    self thread [[ level.damage_effects.var_22d5905e922fbec ]]();
}

/#

    // Namespace damage_effects
    // Params 1
    // Checksum 0xf5133e6b, Offset: 0x2db4
    // Size: 0x97, Type: dev
    function function_969f93d53616a231( vfxid )
    {
        if ( !isdefined( self ) || !isdefined( self.damage ) || !isdefined( self.damage.var_36f37abd252184c6 ) )
        {
            assertmsg( "<dev string:x93>" + vfxid + "<dev string:xb3>" );
        }
        
        keys = getarraykeys( self.damage.var_36f37abd252184c6 );
        
        if ( !arraycontains( keys, vfxid ) )
        {
            assertmsg( "<dev string:x112>" + vfxid + "<dev string:x11b>" );
        }
    }

#/

// Namespace damage_effects
// Params 0
// Checksum 0x632398a7, Offset: 0x2e53
// Size: 0x8d
function function_1c301d9880ec1528()
{
    if ( isdefined( level.gamemodebundle.var_f32418127adb1042 ) )
    {
        str_submix = level.gamemodebundle.var_f32418127adb1042;
        n_fadetime = level.gamemodebundle.var_abec16e90b260d5b ?? float( -1 );
        n_scale = level.gamemodebundle.var_aa505d67d375c298 ?? 1;
        self setsoundsubmix( str_submix, n_fadetime, n_scale );
    }
}

// Namespace damage_effects
// Params 0
// Checksum 0xa35c8558, Offset: 0x2ee8
// Size: 0x6a
function function_e8cba6f10a4635e9()
{
    if ( isdefined( level.gamemodebundle.var_f32418127adb1042 ) )
    {
        str_submix = level.gamemodebundle.var_f32418127adb1042;
        n_fadetime = level.gamemodebundle.var_1fe339836deb2428 ?? float( -1 );
        self clearsoundsubmix( str_submix, n_fadetime );
    }
}

// Namespace damage_effects
// Params 0
// Checksum 0xdf81235e, Offset: 0x2f5a
// Size: 0x1bc
function playerbreathingpainsound()
{
    self endon( #"death_or_disconnect" );
    self endon( #"deaths_door_exit" );
    self endon( #"healed" );
    self endon( #"joined_spectators" );
    self endon( #"last_stand_exit" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self.painbreathloopsplayed ) )
    {
        self.painbreathloopsplayed = 0;
    }
    
    if ( level.gamemodebundle.var_9fca605755fb380a == #"hash_6b808ce6a5a4ce47" )
    {
        if ( function_4042d2fbe6237835( #"hash_6b808ce6a5a4ce47" ) )
        {
            level.gamemodebundle.var_9fca605755fb380a = undefined;
        }
        else
        {
            self enableplayerbreathsystem( 0 );
            self playlocalsound( "plr_breath_pain_init" );
        }
    }
    
    wait 0.5;
    
    while ( true )
    {
        if ( utility::isusingremote() )
        {
            waitframe();
            continue;
        }
        
        if ( !val::get( "health_regen" ) || level.healthregendisabled || level.var_6a872024f536a219 < 40 )
        {
            self.painbreathloopsplayed++;
            
            if ( self.painbreathloopsplayed > ( self.hasdonepainbreathloopthislife ? 1 : 4 ) )
            {
                wait 1;
                self.hasdonepainbreathloopthislife = 1;
                onexitdeathsdoor( 0 );
                break;
            }
        }
        
        if ( level.gamemodebundle.var_9fca605755fb380a == #"hash_6b808ce6a5a4ce47" )
        {
            self playlocalsound( "plr_breath_pain_ong_inh" );
            wait math::round_float( 2.55, 2 );
            self playlocalsound( "plr_breath_pain_ong_exh" );
            wait math::round_float( 2.55, 2 );
            continue;
        }
        
        self playlocalsound( "plr_breath_pain_ong_inh" );
        wait 1.7;
        self playlocalsound( "plr_breath_pain_ong_exh" );
        wait 1.7;
    }
}

// Namespace damage_effects
// Params 0
// Checksum 0x5c73d00, Offset: 0x311e
// Size: 0x73
function updatefirsttimedamaged()
{
    if ( ( level.var_63d1c72ce3422d7a ?? function_15bf270501d22aaa() ) > 2000 )
    {
        assert( isdefined( level.var_9196ec5c24823331 ) );
        
        if ( !isdefined( self.lasttimedamaged ) )
        {
            self.firsttimedamaged = gettime();
            return;
        }
        
        if ( gettime() - self.lasttimedamaged > level.var_9196ec5c24823331 )
        {
            self.firsttimedamaged = gettime();
        }
    }
}

// Namespace damage_effects
// Params 0
// Checksum 0x4ac068fb, Offset: 0x3199
// Size: 0x16
function function_a9ae7b1d997859e9()
{
    self.attackers = [];
    self.attackerdata = [];
}

// Namespace damage_effects
// Params 0
// Checksum 0xe5c4861b, Offset: 0x31b7
// Size: 0xc, Type: bool
function function_27ca464df86b9b02()
{
    return function_15bf270501d22aaa() > 2000;
}

// Namespace damage_effects
// Params 0
// Checksum 0xed301250, Offset: 0x31cc
// Size: 0x10c
function removeoldattackersovertime()
{
    self endon( #"damage" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self.attackers ) )
    {
        return;
    }
    
    var_63d1c72ce3422d7a = function_15bf270501d22aaa();
    
    while ( true )
    {
        time = gettime();
        
        foreach ( guid, attacker in self.attackers )
        {
            if ( isdefined( attacker ) && time - self.attackerdata[ guid ].lasttimedamaged < var_63d1c72ce3422d7a )
            {
                continue;
            }
            
            self.attackers[ guid ] = undefined;
            self.attackerdata[ guid ] = undefined;
        }
        
        waitframe();
    }
}

// Namespace damage_effects
// Params 0
// Checksum 0x63886f15, Offset: 0x32e0
// Size: 0x282
function initdeathsdooroverlaypulse()
{
    if ( level.projectbundle.var_464f31339c96f4ea )
    {
        return;
    }
    
    if ( !( isdefined( level.projectbundle ) && isdefined( level.projectbundle.var_d5e8b3677ff3a87a ) ) )
    {
        shader = "ui_player_pain_deathsdoor_pulse_overlay";
    }
    else
    {
        shader = level.projectbundle.var_d5e8b3677ff3a87a;
    }
    
    self.damage.deathsdooroverlaypulse = newclienthudelem( self );
    self.damage.deathsdooroverlaypulse.sort = 9;
    self.damage.deathsdooroverlaypulse.x = 0;
    self.damage.deathsdooroverlaypulse.y = 0;
    self.damage.deathsdooroverlaypulse.alignx = "left";
    self.damage.deathsdooroverlaypulse.aligny = "top";
    self.damage.deathsdooroverlaypulse.foreground = 0;
    self.damage.deathsdooroverlaypulse.lowresbackground = 1;
    self.damage.deathsdooroverlaypulse.horzalign = "fullscreen";
    self.damage.deathsdooroverlaypulse.vertalign = "fullscreen";
    self.damage.deathsdooroverlaypulse.alpha = 0;
    self.damage.deathsdooroverlaypulse.enablehudlighting = 0;
    self.damage.deathsdooroverlaypulse.scramblerdisabled = 1;
    self.damage.deathsdooroverlaypulse setshader( shader, 640, 480 );
    self.damage.deathsdooroverlaypulse.masteralpha = 0;
    self.damage.var_be8bd22166474a49[ self.damage.var_be8bd22166474a49.size ] = self.damage.deathsdooroverlaypulse;
}

// Namespace damage_effects
// Params 0
// Checksum 0xae02613e, Offset: 0x356a
// Size: 0x26a
function function_ab65deebd45a1f3b()
{
    if ( level.projectbundle.var_9a1394c33dfd79f0 )
    {
        return;
    }
    
    if ( !( isdefined( level.projectbundle ) && isdefined( level.projectbundle.var_ef7504f479065dd9 ) ) )
    {
        shader = "ui_player_pain_blood_overlay";
    }
    else
    {
        shader = level.projectbundle.var_ef7504f479065dd9;
    }
    
    self.damage.var_f75e894d2c972ee9 = newclienthudelem( self );
    self.damage.var_f75e894d2c972ee9.sort = 10;
    self.damage.var_f75e894d2c972ee9.x = 0;
    self.damage.var_f75e894d2c972ee9.y = 0;
    self.damage.var_f75e894d2c972ee9.alignx = "left";
    self.damage.var_f75e894d2c972ee9.aligny = "top";
    self.damage.var_f75e894d2c972ee9.foreground = 0;
    self.damage.var_f75e894d2c972ee9.lowresbackground = 1;
    self.damage.var_f75e894d2c972ee9.horzalign = "fullscreen";
    self.damage.var_f75e894d2c972ee9.vertalign = "fullscreen";
    self.damage.var_f75e894d2c972ee9.alpha = 0;
    self.damage.var_f75e894d2c972ee9.enablehudlighting = 0;
    self.damage.var_f75e894d2c972ee9.scramblerdisabled = 1;
    self.damage.var_f75e894d2c972ee9 setshader( shader, 640, 480 );
    self.damage.var_21b9ceae80e00583 = arraycombine( self.damage.var_be8bd22166474a49, [ self.damage.var_f75e894d2c972ee9 ] );
}

// Namespace damage_effects
// Params 0, eflags: 0xc
// Checksum 0xcd7534e4, Offset: 0x37dc
// Size: 0x17d
function private function_2d7c16d23b87e977()
{
    self notify( #"hash_f55fe2f13765c61" );
    self endon( #"hash_f55fe2f13765c61" );
    overlays = self.damage.var_be8bd22166474a49;
    utility::waittill_any( "death_or_disconnect", "ending_cinematic" );
    
    foreach ( overlay in overlays )
    {
        if ( isdefined( overlay ) )
        {
            overlay destroy();
        }
    }
    
    if ( isdefined( self ) && self isconnected() )
    {
        if ( level.projectbundle.var_464f31339c96f4ea )
        {
            function_84db26d2e08b6253( 0 );
        }
        
        if ( function_b1fbb5b747b5663a() )
        {
            function_bf638d276a175e4e();
        }
        
        if ( level.projectbundle.var_da5287e97e4886a )
        {
            function_e9d5bd60f242763();
        }
        
        if ( level.projectbundle.var_9a1394c33dfd79f0 || level.projectbundle.var_404374de902c8ca5 )
        {
            if ( self.damage.var_3ed5e06d6d3a1175 )
            {
                self.damage.var_3ed5e06d6d3a1175 = 0;
            }
            
            function_414da3ff14df86f3();
        }
        
        function_39e2c9af4aaa0e8b();
    }
}

// Namespace damage_effects
// Params 0, eflags: 0xc
// Checksum 0x429e4b54, Offset: 0x3961
// Size: 0x187
function private function_e3bd5dd021a50141()
{
    self notify( #"hash_d4601ac6f2797545" );
    self endon( #"hash_d4601ac6f2797545" );
    overlays = self.damage.var_21b9ceae80e00583;
    utility::waittill_any( "disconnect", "death_delay_finished", "spawned", "ending_cinematic" );
    
    foreach ( overlay in overlays )
    {
        if ( isdefined( overlay ) )
        {
            overlay destroy();
        }
    }
    
    if ( isdefined( self ) && self isconnected() )
    {
        if ( level.projectbundle.var_464f31339c96f4ea )
        {
            function_84db26d2e08b6253( 0 );
        }
        
        if ( function_b1fbb5b747b5663a() )
        {
            function_bf638d276a175e4e();
        }
        
        if ( level.projectbundle.var_da5287e97e4886a )
        {
            function_e9d5bd60f242763();
        }
        
        if ( level.projectbundle.var_9a1394c33dfd79f0 || level.projectbundle.var_404374de902c8ca5 )
        {
            if ( self.damage.var_3ed5e06d6d3a1175 )
            {
                self.damage.var_3ed5e06d6d3a1175 = 0;
            }
            
            function_414da3ff14df86f3();
        }
        
        function_39e2c9af4aaa0e8b();
    }
}

// Namespace damage_effects
// Params 1, eflags: 0x4
// Checksum 0x81fc2668, Offset: 0x3af0
// Size: 0x43
function private function_6318913aa478d700( alphavalue )
{
    if ( getdvarint( @"touch_enabled" ) )
    {
        return ( alphavalue * 0.6 );
    }
    
    if ( isdefined( self.perks[ "specialty_reduce_death_door" ] ) )
    {
        return ( alphavalue * 0.5 );
    }
    
    return alphavalue;
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x8c0e8aa, Offset: 0x3b3c
// Size: 0x48
function private function_40f64353c6aec349()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( level.gamemodebundle.var_3f4afcb4c7c3085f && self getscriptablehaspart( "deaths_door" ) )
    {
        self setscriptablepartstate( "deaths_door", "loop_sound_on", 0 );
    }
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x7011acac, Offset: 0x3b8c
// Size: 0x48
function private function_39e2c9af4aaa0e8b()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( level.gamemodebundle.var_3f4afcb4c7c3085f && self getscriptablehaspart( "deaths_door" ) )
    {
        self setscriptablepartstate( "deaths_door", "loop_sound_off", 0 );
    }
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x3fc6923d, Offset: 0x3bdc
// Size: 0x18b
function private function_7bec040f73ca0296()
{
    if ( self.deathsdoorsfx )
    {
        return;
    }
    
    if ( self.var_38620c16757519d1 )
    {
        return;
    }
    
    if ( self.inlaststand && level.gamemodebundle.var_4d995a7e8f2fe6db )
    {
        return;
    }
    
    self notify( #"sndStartDeathsDoorSFX" );
    self.deathsdoorsfx = 1;
    self.painbreathloopsplayed = 0;
    
    if ( level.gamemodebundle.var_9fca605755fb380a != #"hash_6b808ce6a5a4ce47" )
    {
        self enableplayerbreathsystem( 0 );
    }
    
    self setentitysoundcontext( "deaths_door", "active", 0.1 );
    function_1c301d9880ec1528();
    function_40f64353c6aec349();
    
    if ( !level.gamemodebundle.var_faebbaa9bdf8fa64 )
    {
        self notify( #"hash_8a4f2396a57e506e" );
    }
    
    if ( isdefined( level.gamemodebundle.var_9d44880cfd22ca3c ) && soundexists( level.gamemodebundle.var_9d44880cfd22ca3c ) )
    {
        playworldsound( self.origin, level.gamemodebundle.var_9d44880cfd22ca3c, self );
    }
    
    if ( isdefined( level.gamemodebundle.var_ba8ee46a4a66aee2 ) && soundexists( level.gamemodebundle.var_ba8ee46a4a66aee2 ) )
    {
        self stoplocalsound( level.gamemodebundle.var_ba8ee46a4a66aee2 );
    }
    
    if ( !level.gamemodebundle.var_58f729c29cb07f02 )
    {
        thread playerbreathingpainsound();
    }
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0xea12572d, Offset: 0x3d6f
// Size: 0x1a9
function private function_3ebda8157e05cafe()
{
    if ( !self.deathsdoorsfx )
    {
        return;
    }
    
    if ( self.var_38620c16757519d1 )
    {
        return;
    }
    
    self.deathsdoorsfx = 0;
    self setentitysoundcontext( "deaths_door", "", 0.1 );
    
    if ( level.gamemodebundle.var_9fca605755fb380a != #"hash_6b808ce6a5a4ce47" )
    {
        self enableplayerbreathsystem( 1 );
    }
    
    function_e8cba6f10a4635e9();
    function_39e2c9af4aaa0e8b();
    
    if ( self.inlaststand && level.gamemodebundle.var_4d995a7e8f2fe6db )
    {
        return;
    }
    
    if ( isdefined( level.gamemodebundle.var_9d44880cfd22ca3c ) && soundexists( level.gamemodebundle.var_9d44880cfd22ca3c ) )
    {
        function_4009348bd72e9021( level.gamemodebundle.var_9d44880cfd22ca3c, self );
    }
    
    if ( isdefined( level.gamemodebundle.var_ba8ee46a4a66aee2 ) && soundexists( level.gamemodebundle.var_ba8ee46a4a66aee2 ) )
    {
        self playlocalsound( level.gamemodebundle.var_ba8ee46a4a66aee2 );
    }
    
    if ( !level.gamemodebundle.var_58f729c29cb07f02 )
    {
        if ( level.gamemodebundle.var_9fca605755fb380a == #"hash_6b808ce6a5a4ce47" )
        {
            utility::delaycallendon( 2, "death_or_disconnect", &enableplayerbreathsystem, 1 );
            return;
        }
        
        self playlocalsound( [[ utility::getsharedfunc( #"damage_effects", #"isfemale" ) ]]() ? "Fem_breathing_better" : "breathing_better" );
    }
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x380e3924, Offset: 0x3f20
// Size: 0x26
function private function_3ccde4410e6b0443()
{
    if ( self.var_4ebc575d50fe5f68 )
    {
        return;
    }
    
    self notify( #"hash_6ba6a268b7b2de5" );
    self.var_4ebc575d50fe5f68 = 1;
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0xeb04fa30, Offset: 0x3f4e
// Size: 0x1a
function private function_4ba06b084708abfb()
{
    if ( !self.var_4ebc575d50fe5f68 )
    {
        return;
    }
    
    self.var_4ebc575d50fe5f68 = 0;
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x3f637715, Offset: 0x3f70
// Size: 0x2b
function private function_374c3331659edb75()
{
    self.damage.var_44a4710e972906b2 = 1;
    self notify( #"hash_8a4f2396a57e506e" );
    thread function_72bfd44565ca0849();
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0xdfe3594, Offset: 0x3fa3
// Size: 0x34
function private function_41af24893f875219()
{
    if ( !function_bd6a25759794a78f() )
    {
        return;
    }
    
    if ( level.projectbundle.var_464f31339c96f4ea )
    {
        thread function_c5ad022985636375();
        return;
    }
    
    thread function_eeabc3b1eb3bbef2();
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0xcb9e1009, Offset: 0x3fdf
// Size: 0x29
function private function_8f42d7460c42768()
{
    if ( level.projectbundle.var_9a1394c33dfd79f0 )
    {
        function_eb99657542aa3884();
        return;
    }
    
    function_e03186cc52ff7ea7();
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x483831ef, Offset: 0x4010
// Size: 0x94
function private function_e03186cc52ff7ea7()
{
    if ( !isdefined( self.damage.var_f75e894d2c972ee9 ) )
    {
        return;
    }
    
    self.damage.var_3ed5e06d6d3a1175 = 1;
    self.damage.var_f75e894d2c972ee9 fadeovertime( 0.15 );
    self.damage.var_f75e894d2c972ee9.alpha = function_6318913aa478d700( 1 );
    self.damage.var_f75e894d2c972ee9.var_4d0bb303932140d6 = 1;
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x1b65e26f, Offset: 0x40ac
// Size: 0xa1
function private function_eb99657542aa3884()
{
    /#
        if ( !isdefined( self.model ) || self.model == "<dev string:x153>" )
        {
            assertmsg( "<dev string:x154>" );
        }
        
        if ( !utility::hastag( self.model, "<dev string:x1a0>" ) )
        {
            assertmsg( "<dev string:x1ab>" );
        }
    #/
    
    if ( !self.damage.var_3ed5e06d6d3a1175 )
    {
        playfxontagforclients( level._effect[ "blood_deathsdoor" ], self, "tag_origin", self, 0 );
        self.damage.var_3ed5e06d6d3a1175 = 1;
    }
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x5238ca5a, Offset: 0x4155
// Size: 0xe8
function private function_a8b1f372b14f6fe0()
{
    /#
        if ( !level.projectbundle.var_464f31339c96f4ea )
        {
            assertmsg( "<dev string:x200>" );
        }
        
        if ( !isdefined( self.model ) || self.model == "<dev string:x153>" )
        {
            assertmsg( "<dev string:x154>" );
        }
        
        if ( !utility::hastag( self.model, "<dev string:x1a0>" ) )
        {
            assertmsg( "<dev string:x1ab>" );
        }
    #/
    
    if ( !self.damage.var_3ed5e06d6d3a1175 )
    {
        function_84db26d2e08b6253( 2 );
        function_64c247b6e0b566cd( level.gamemodebundle.pbgpostfxbundle_pain );
        playfxontagforclients( level._effect[ "blood_deathsdoor" ], self, "tag_origin", self, 0 );
        self.damage.var_3ed5e06d6d3a1175 = 1;
    }
}

// Namespace damage_effects
// Params 1, eflags: 0x4
// Checksum 0x4b89ef56, Offset: 0x4245
// Size: 0x3a, Type: bool
function private function_27dec7ae8fd0b67b( smeansofdeath )
{
    if ( self.damage.var_3ed5e06d6d3a1175 )
    {
        return false;
    }
    
    if ( isdefined( smeansofdeath ) && smeansofdeath == "MOD_FIRE" )
    {
        return true;
    }
    
    return false;
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x14ff4e1a, Offset: 0x4288
// Size: 0x79
function private function_7114bea20f7966e4()
{
    if ( !self.damage.var_99e1bf56c7f1850f )
    {
        /#
            if ( !level.projectbundle.var_464f31339c96f4ea )
            {
                assertmsg( "<dev string:x200>" );
            }
        #/
        
        function_84db26d2e08b6253( 3 );
        function_64c247b6e0b566cd( level.gamemodebundle.var_bdb279c4cb9d71fa );
        self.damage.var_99e1bf56c7f1850f = 1;
    }
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0xf90d0b2d, Offset: 0x4309
// Size: 0x2d
function private function_23d7fe1244c4a184()
{
    if ( self.damage.var_99e1bf56c7f1850f )
    {
        self.damage.var_99e1bf56c7f1850f = 0;
    }
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0xce6afd5d, Offset: 0x433e
// Size: 0x2d
function private function_e9d5bd60f242763()
{
    if ( self.damage.var_99e1bf56c7f1850f )
    {
        self.damage.var_99e1bf56c7f1850f = 0;
    }
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0xa5f603ed, Offset: 0x4373
// Size: 0x1f
function private function_bf638d276a175e4e()
{
    self.damage.var_44a4710e972906b2 = 0;
    function_d422eb20e78cf6b7( 0 );
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0xde171a54, Offset: 0x439a
// Size: 0x20
function private function_eae44f812199514d()
{
    self.damage.var_44a4710e972906b2 = 0;
    function_d422eb20e78cf6b7( 1 );
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0xdb8f057c, Offset: 0x43c2
// Size: 0x3c
function private function_f36d2fcb0884ef11()
{
    if ( !function_bd6a25759794a78f() )
    {
        return;
    }
    
    if ( level.projectbundle.var_464f31339c96f4ea )
    {
        function_84db26d2e08b6253( 1 );
        return;
    }
    
    thread function_de45b6f982d43164( 0, 3.5 );
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x756e4182, Offset: 0x4406
// Size: 0x4f, Type: bool
function private function_bd6a25759794a78f()
{
    if ( !level.projectbundle.var_ef6418bd4fa8e55d )
    {
        return false;
    }
    
    if ( !level.projectbundle.var_464f31339c96f4ea && !isdefined( self.damage.deathsdooroverlaypulse ) )
    {
        return false;
    }
    
    return true;
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x28877621, Offset: 0x445e
// Size: 0x29
function private function_12ead737e0eaa800()
{
    if ( level.projectbundle.var_9a1394c33dfd79f0 )
    {
        function_79fe0cdcfdc3adfc();
        return;
    }
    
    function_917a0582e2013c0f();
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0xf65a79de, Offset: 0x448f
// Size: 0x82
function private function_917a0582e2013c0f()
{
    if ( !isdefined( self.damage.var_f75e894d2c972ee9 ) )
    {
        return;
    }
    
    if ( self.damage.var_3ed5e06d6d3a1175 )
    {
        self.damage.var_3ed5e06d6d3a1175 = 0;
        self.damage.var_f75e894d2c972ee9 fadeovertime( 2 );
        self.damage.var_f75e894d2c972ee9.alpha = 0;
    }
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x37eb39c4, Offset: 0x4519
// Size: 0x54
function private function_79fe0cdcfdc3adfc()
{
    fadetime = 3000;
    
    if ( self.damage.var_3ed5e06d6d3a1175 )
    {
        self.damage.var_3ed5e06d6d3a1175 = 0;
        thread function_eccb5c90bcab510c( self, 0, getdvarint( @"hash_d19a1653066cd960", fadetime ) );
    }
}

// Namespace damage_effects
// Params 1, eflags: 0x4
// Checksum 0x598fd670, Offset: 0x4575
// Size: 0x35
function private function_62abb01e22577bf9( fadetime )
{
    if ( level.projectbundle.var_9a1394c33dfd79f0 )
    {
        function_cbe9c60da6f5eafb();
        return;
    }
    
    function_a45134e5f0512242( fadetime );
}

// Namespace damage_effects
// Params 1, eflags: 0x4
// Checksum 0xe2dbf403, Offset: 0x45b2
// Size: 0x91
function private function_a45134e5f0512242( fadetime )
{
    if ( !isdefined( self.damage.var_f75e894d2c972ee9 ) )
    {
        return;
    }
    
    if ( self.damage.var_3ed5e06d6d3a1175 )
    {
        self.damage.var_3ed5e06d6d3a1175 = 0;
        self.damage.var_f75e894d2c972ee9 fadeovertime( fadetime ?? 0.1 );
        self.damage.var_f75e894d2c972ee9.alpha = 0;
    }
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x7f9cce55, Offset: 0x464b
// Size: 0x54
function private function_cbe9c60da6f5eafb()
{
    fadetime = 3000;
    
    if ( self.damage.var_3ed5e06d6d3a1175 )
    {
        self.damage.var_3ed5e06d6d3a1175 = 0;
        thread function_eccb5c90bcab510c( self, 0, getdvarint( @"hash_d19a1653066cd960", fadetime ) );
    }
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0xdfd5350f, Offset: 0x46a7
// Size: 0x7e
function private applyshrapnelfx()
{
    self endon( #"disconnect" );
    self notify( #"applyshrapnelfx" );
    self endon( #"applyshrapnelfx" );
    self setclientomnvar( o"ui_shrapnel_overlay", 1 );
    self playlocalsound( "iw8_mp_perk_shrapnel" );
    endednormally = applyshrapnelfxinternal();
    
    if ( endednormally )
    {
        self setclientomnvar( o"ui_shrapnel_overlay", 2 );
        return;
    }
    
    self setclientomnvar( o"ui_shrapnel_overlay", 3 );
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0xc24396cd, Offset: 0x472d
// Size: 0x5b, Type: bool
function private applyshrapnelfxinternal()
{
    self endon( #"death" );
    self endon( #"joined_team" );
    self endon( #"joined_spectators" );
    level endon( #"game_ended" );
    value = utility::waittill_any_return( "shrapnel_ended_early", "shrapnel_ended", "force_regeneration" );
    return value == "shrapnel_ended";
}

// Namespace damage_effects
// Params 0
// Checksum 0xfff9f244, Offset: 0x4791
// Size: 0x4b
function function_15bf270501d22aaa()
{
    if ( !isdefined( level.var_63d1c72ce3422d7a ) )
    {
        level.var_63d1c72ce3422d7a = getdvarint( @"scr_attacker_time_buffer_ms", 2000 );
        level.var_9196ec5c24823331 = getdvarint( @"hash_2fd03831cb8a51e6", 4000 );
    }
    
    return level.var_63d1c72ce3422d7a;
}

// Namespace damage_effects
// Params 10, eflags: 0x4
// Checksum 0xc93886b0, Offset: 0x47e5
// Size: 0x2e2
function private damageeffects( idamage, einflictor, eattacker, evictim, smeansofdeath, vpoint, lightarmordamage, objweapon, shitloc, vdir )
{
    self endon( #"death_or_disconnect" );
    self notify( #"damageeffects" );
    
    if ( !shoulddodamageeffects() )
    {
        return;
    }
    
    if ( !isdefined( idamage ) )
    {
        idamage = 0;
    }
    
    if ( !isdefined( lightarmordamage ) )
    {
        lightarmordamage = 0;
    }
    
    function_9b7d46471e3fc1e6( idamage + lightarmordamage );
    
    if ( allowdamageflash( idamage, eattacker, evictim, smeansofdeath, vpoint, lightarmordamage, objweapon, shitloc, vdir ) )
    {
        showuidamageflash();
    }
    
    if ( self.reduceddamageeffects )
    {
        return;
    }
    
    factor = damageratio( idamage + lightarmordamage );
    
    if ( !isdefined( eattacker ) && ( smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_BUMP" ) )
    {
        eattacker = self;
    }
    
    var_d5e4e442caeb2fdb = function_1fde954cb0f07eca( einflictor, eattacker, smeansofdeath );
    
    if ( !isdefined( level.var_4885146d243ecfc4 ) || ![[ level.var_4885146d243ecfc4 ]]( idamage, eattacker, evictim, smeansofdeath, vpoint, lightarmordamage, objweapon, shitloc, vdir ) )
    {
        childthread damagepainvision( vpoint, factor, smeansofdeath, idamage, objweapon );
    }
    
    childthread function_6af01dc794666cd3( factor, smeansofdeath, idamage, lightarmordamage, objweapon, shitloc );
    
    if ( !isdefined( level.var_59c10bd85d1004bd ) || ![[ level.var_59c10bd85d1004bd ]]( idamage, eattacker, evictim, smeansofdeath, vpoint, lightarmordamage, objweapon, shitloc, vdir ) )
    {
        headshot = 0;
        
        if ( utility::issharedfuncdefined( #"damage", #"isheadshot" ) )
        {
            isspreadweapon = weapon::isspreadweapon( objweapon );
            headshot = 0;
            headshot = !isspreadweapon && utility::callsharedfunc( #"damage", #"isheadshot", shitloc, smeansofdeath, eattacker );
        }
        
        childthread damagebloodoverlaydirectional( var_d5e4e442caeb2fdb, factor, smeansofdeath, idamage, lightarmordamage, objweapon, shitloc, headshot );
    }
    
    damagescreenshake( idamage, smeansofdeath, lightarmordamage );
    
    if ( level.gamemodebundle.var_e60b353ab6286751 && isplayer( evictim ) && isalive( evictim ) )
    {
        evictim thread function_3c0c5097b14c612f( idamage, einflictor, eattacker, evictim, smeansofdeath, vpoint, lightarmordamage, objweapon, shitloc, vdir );
    }
    
    if ( isdefined( self.callbacks[ #"on_player_damage_effects" ] ) || isdefined( level.callbacks[ #"on_player_damage_effects" ] ) )
    {
        var_23e3622a1b7e3e6b = { #vdir:vdir, #factor:factor, #objweapon:objweapon, #lightarmordamage:lightarmordamage, #vpoint:vpoint, #smeansofdeath:smeansofdeath, #eattacker:eattacker, #idamage:idamage };
        callback::callback( #"on_player_damage_effects", var_23e3622a1b7e3e6b );
    }
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0xe682651b, Offset: 0x4acf
// Size: 0x84, Type: bool
function private shoulddodamageeffects()
{
    if ( !isplayer( self ) || isbot( self ) || issimulationplayer( self ) )
    {
        return false;
    }
    
    if ( isingodmode( self ) )
    {
        return false;
    }
    
    if ( utility::isusingremote() )
    {
        if ( isbrgamemode() && self.isincircle && level.damage_effects.var_71fb9e54a35000ee )
        {
            return true;
        }
        
        return false;
    }
    
    if ( self function_acbf60ca18b9864b() )
    {
        return false;
    }
    
    if ( getdvarfloat( @"enable_damage_effects", 1 ) == 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace damage_effects
// Params 5, eflags: 0x4
// Checksum 0x94bd3617, Offset: 0x4b5c
// Size: 0xee
function private damagepainvision( vpoint, factor, smeansofdeath, idamage, objweapon )
{
    self endon( #"damageeffects" );
    self endon( #"death_or_disconnect" );
    
    if ( !shoulddopainvision( objweapon ) )
    {
        return 0;
    }
    
    if ( function_1e948faff668cf2( smeansofdeath ) )
    {
        eventtype = "vsp_fall";
    }
    else if ( function_3919f2c3b31dabb6( smeansofdeath ) )
    {
        eventtype = "vsp_fire";
    }
    else if ( function_ae27c589e09c3181( smeansofdeath ) )
    {
        eventtype = "vsp_explosive";
    }
    else
    {
        eventtype = "vsp_bullet";
    }
    
    var_b631ed5e24732cbd = level.sharedfuncs[ #"fullscreenfx" ][ #"senddamageevent" ];
    
    if ( isdefined( var_b631ed5e24732cbd ) )
    {
        [[ var_b631ed5e24732cbd ]]( { #eventtype:eventtype, #player:self } );
    }
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x4b3233a0, Offset: 0x4c52
// Size: 0x1a
function private showuidamageflash()
{
    self setclientomnvar( o"ui_damage_event", self.damageeventcount );
}

// Namespace damage_effects
// Params 9, eflags: 0x4
// Checksum 0x31f04e16, Offset: 0x4c74
// Size: 0x9e, Type: bool
function private allowdamageflash( idamage, eattacker, evictim, smeansofdeath, vpoint, lightarmordamage, objweapon, shitloc, vdir )
{
    if ( isagent( evictim ) )
    {
        return false;
    }
    
    if ( isingodmode( evictim ) )
    {
        return false;
    }
    
    if ( idamage == 0 )
    {
        return false;
    }
    
    if ( level.var_4885146d243ecfc4 && [[ level.var_4885146d243ecfc4 ]]( idamage, eattacker, evictim, smeansofdeath, vpoint, lightarmordamage, objweapon, shitloc, vdir ) )
    {
        return false;
    }
    
    return true;
}

// Namespace damage_effects
// Params 1, eflags: 0x4
// Checksum 0xfe292eae, Offset: 0x4d1b
// Size: 0x51, Type: bool
function private shoulddopainvision( objweapon )
{
    if ( level.wpinprogress || self.focusbreath )
    {
        return false;
    }
    
    if ( objweapon.basenamehash == %"dragonsbreath_mp" )
    {
        return false;
    }
    
    if ( self.disablepainvision )
    {
        return false;
    }
    
    return true;
}

// Namespace damage_effects
// Params 1, eflags: 0x4
// Checksum 0x9b0a78b1, Offset: 0x4d75
// Size: 0x3c
function private function_a0bc2fddfac92421( fadetime )
{
    if ( level.wpinprogress )
    {
        return;
    }
    
    self [[ utility::getsharedfunc( #"damage_effects", #"hash_f93ac0b4812ca397" ) ]]( "", fadetime );
}

// Namespace damage_effects
// Params 6, eflags: 0x4
// Checksum 0xdd519ee0, Offset: 0x4db9
// Size: 0x21d
function private function_6af01dc794666cd3( factor, smeansofdeath, idamage, lightarmordamage, objweapon, shitloc )
{
    if ( !function_709a1d9b59357d1a( factor, smeansofdeath, idamage, lightarmordamage, objweapon, shitloc ) )
    {
        return;
    }
    
    normhealth = self getnormalhealth();
    
    if ( isdefined( level.gamemodebundle.var_dd38d7fffa98cc4b ) )
    {
        normhealth = math::normalize_value( 0.3, 1, normhealth );
        pbgmix = math::factor_value( 1, 0.3, normhealth );
        pbgtimescale = math::factor_value( 0.9, 1.2, normhealth );
        pbgpostfxbundlestart( self, level.gamemodebundle.var_dd38d7fffa98cc4b, pbgtimescale, pbgmix );
    }
    
    if ( isdefined( level.projectbundle.var_e533946d35317a32 ) )
    {
        self function_9c6091c690ea2ca3( level.projectbundle.var_e533946d35317a32 );
    }
    
    if ( level.projectbundle.var_e930d60e20634db1 )
    {
        if ( normhealth > 0.9 )
        {
            if ( level.projectbundle.var_56dee4882f92d3e2 != "" )
            {
                self playlocalsound( level.projectbundle.var_56dee4882f92d3e2 );
            }
            
            return;
        }
        
        if ( normhealth > 0.66 )
        {
            if ( level.projectbundle.var_f0a585b72582c880 != "" )
            {
                self playlocalsound( level.projectbundle.var_f0a585b72582c880 );
            }
            
            return;
        }
        
        if ( normhealth > 0.33 )
        {
            if ( level.projectbundle.var_edfdcad3582d02d5 != "" )
            {
                self playlocalsound( level.projectbundle.var_edfdcad3582d02d5 );
            }
            
            return;
        }
        
        if ( level.projectbundle.var_bc1a13ea90accf8a != "" )
        {
            self playlocalsound( level.projectbundle.var_bc1a13ea90accf8a );
        }
    }
}

// Namespace damage_effects
// Params 6, eflags: 0x4
// Checksum 0x32a5ee85, Offset: 0x4fde
// Size: 0x61, Type: bool
function private function_709a1d9b59357d1a( factor, smeansofdeath, idamage, lightarmordamage, objweapon, shitloc )
{
    if ( !level.projectbundle.var_da5287e97e4886a )
    {
        return false;
    }
    
    if ( smeansofdeath != "MOD_FIRE" )
    {
        return false;
    }
    
    return true;
}

// Namespace damage_effects
// Params 3
// Checksum 0x306fe268, Offset: 0x5048
// Size: 0x29
function function_b419947b64b7074( var_d5e4e442caeb2fdb, factor, smeansofdeath )
{
    function_4b73a2247d198113( var_d5e4e442caeb2fdb, factor, smeansofdeath );
}

// Namespace damage_effects
// Params 8, eflags: 0x4
// Checksum 0x2d67dba2, Offset: 0x5079
// Size: 0xc1
function private damagebloodoverlaydirectional( var_d5e4e442caeb2fdb, factor, smeansofdeath, idamage, lightarmordamage, objweapon, shitloc, headshot )
{
    if ( !function_6b2bb1a8da0087e4( factor, smeansofdeath, idamage, lightarmordamage, objweapon, shitloc ) )
    {
        return;
    }
    
    self.damage.lastdiretionalbloodtime = gettime();
    
    if ( level.projectbundle.var_404374de902c8ca5 )
    {
        function_4b73a2247d198113( var_d5e4e442caeb2fdb, factor, smeansofdeath, idamage, lightarmordamage, objweapon, shitloc, headshot );
        return;
    }
    
    if ( level.projectbundle.var_a8c3b67e59666db9 )
    {
        function_f5d1f33d05ea74a( var_d5e4e442caeb2fdb, smeansofdeath );
    }
}

// Namespace damage_effects
// Params 2, eflags: 0x4
// Checksum 0xdbaaf377, Offset: 0x5142
// Size: 0x210
function private function_f5d1f33d05ea74a( side, smeansofdeath )
{
    if ( !isdefined( side ) )
    {
        return;
    }
    
    altversion = undefined;
    
    if ( function_ae27c589e09c3181( smeansofdeath ) )
    {
        type = #"dirt";
    }
    else if ( !self [[ level.sharedfuncs[ #"damage_effects" ][ #"hasarmor" ] ]]() && !self.damage.var_fbe723a36365e86c )
    {
        type = #"blood";
        
        if ( self.damage.altdirectionalbloodoverlay )
        {
            altversion = #"alt";
            self.damage.altdirectionalbloodoverlay = 0;
        }
        else
        {
            self.damage.altdirectionalbloodoverlay = 1;
        }
    }
    else
    {
        type = #"armor";
    }
    
    if ( !isdefined( level.var_6881a28ba2b60045 ) )
    {
        level.var_6881a28ba2b60045 = function_38fb86b5e4b7b3b1();
    }
    
    material = level.var_6881a28ba2b60045[ type ][ side ][ altversion ?? #"default" ];
    splashmaterial = level.var_6881a28ba2b60045[ type ][ side ][ #"splash" ];
    randomoffsets = { #scale:randomfloatrange( 0, 1 ), #y:randomfloatrange( 0, 1 ), #x:randomfloatrange( 0, 1 ) };
    
    if ( level.gamemodebundle.var_25eda649fb0ea825 )
    {
        switch ( side )
        {
            case #"front":
            case #"back":
                noscaleovertime = 1;
                break;
        }
    }
    
    createscreeneffect( side, material, 0.15, 2, randomoffsets, 1, 1, 1, noscaleovertime );
    createscreeneffect( side, splashmaterial, 0.15, 0.15, randomoffsets, 0, 1, 1, noscaleovertime );
}

// Namespace damage_effects
// Params 0
// Checksum 0x2c240402, Offset: 0x535a
// Size: 0x46f
function function_38fb86b5e4b7b3b1()
{
    bundle = level.gamemodebundle.var_6881a28ba2b60045;
    materials = [ #"dirt":[ #"back":[ #"splash":bundle.var_6c568ac9d007f94f ?? %"fullscreen_dirt_bottom_splash", #"default":bundle.dirt_back ?? %"fullscreen_dirt_bottom" ], #"front":[ #"splash":bundle.var_350f15e124588bbb ?? %"fullscreen_dirt_bottom_splash", #"default":bundle.dirt_front ?? %"fullscreen_dirt_bottom" ], #"right":[ #"splash":bundle.dirt_right_splash ?? %"fullscreen_dirt_right_splash", #"default":bundle.dirt_right ?? %"fullscreen_dirt_right" ], #"left":[ #"splash":bundle.dirt_left_splash ?? %"fullscreen_dirt_left_splash", #"default":bundle.dirt_left ?? %"fullscreen_dirt_left" ] ], #"armor":[ #"back":[ #"splash":bundle.armor_back_splash ?? %"fullscreen_armor_bottom_splash", #"default":bundle.armor_back ?? %"fullscreen_armor_bottom" ], #"front":[ #"splash":bundle.var_594865e3f3f7eb5 ?? %"fullscreen_armor_bottom_splash", #"default":bundle.armor_front ?? %"fullscreen_armor_bottom" ], #"right":[ #"splash":bundle.armor_right_splash ?? %"fullscreen_armor_right_splash", #"default":bundle.armor_right ?? %"fullscreen_armor_right" ], #"left":[ #"splash":bundle.armor_left_splash ?? %"fullscreen_armor_left_splash", #"default":bundle.armor_left ?? %"fullscreen_armor_left" ] ], #"blood":[ #"back":[ #"splash":bundle.blood_back_splash ?? %"fullscreen_blood_bottom_splash", #"alt":bundle.blood_back_alt ?? %"fullscreen_blood_bottom_alt", #"default":bundle.blood_back ?? %"fullscreen_blood_bottom" ], #"front":[ #"splash":bundle.blood_front_splash ?? %"fullscreen_blood_bottom_splash", #"alt":bundle.blood_front_alt ?? %"fullscreen_blood_bottom_alt", #"default":bundle.blood_front ?? %"fullscreen_blood_bottom" ], #"right":[ #"splash":bundle.blood_right_splash ?? %"fullscreen_blood_right_splash", #"alt":bundle.blood_right_alt ?? %"fullscreen_blood_right_alt", #"default":bundle.blood_right ?? %"fullscreen_blood_right" ], #"left":[ #"splash":bundle.blood_left_splash ?? %"fullscreen_blood_left_splash", #"alt":bundle.blood_left_alt ?? %"fullscreen_blood_left_alt", #"default":bundle.blood_left ?? %"fullscreen_blood_left" ] ] ];
    return materials;
}

// Namespace damage_effects
// Params 8, eflags: 0x4
// Checksum 0xfe966d2, Offset: 0x57d2
// Size: 0x19a
function private function_4b73a2247d198113( var_d5e4e442caeb2fdb, factor, smeansofdeath, idamage, lightarmordamage, objweapon, shitloc, isheadshot )
{
    currenttime = gettime();
    
    if ( !function_b1323c25bc2f561c( var_d5e4e442caeb2fdb, smeansofdeath, currenttime ) )
    {
        return;
    }
    
    self.damage.var_5cca578d4e528b0b = currenttime;
    size = function_f9b6c0d93ab0d7a( factor );
    armor = function_4d404e58f208c30a();
    
    if ( level.gamemodebundle.var_e60b353ab6286751 && isheadshot )
    {
        playfxontagforclients( level._effect[ "blood_headshot" ], self, "tag_origin", self, 0 );
        return;
    }
    
    switch ( var_d5e4e442caeb2fdb )
    {
        case #"left":
            svfx = "blood" + armor + "left" + size;
            break;
        case #"right":
            svfx = "blood" + armor + "right" + size;
            break;
        case #"back":
            svfx = "blood" + armor + "back" + size;
            break;
        case #"front":
        default:
            svfx = "blood" + armor + "front" + size;
            break;
    }
    
    self thread [[ level.damage_effects.var_9b255a0fe977d3fa ]]( svfx, currenttime, 6 );
}

// Namespace damage_effects
// Params 3
// Checksum 0x72d9f3e, Offset: 0x5974
// Size: 0x2b
function function_bd47027c4d3e9288( msg1, msg2, timer )
{
    self endon( msg1 );
    self endon( msg2 );
    wait timer;
}

// Namespace damage_effects
// Params 1, eflags: 0x4
// Checksum 0x7be55cd0, Offset: 0x59a7
// Size: 0x11
function private function_f9b6c0d93ab0d7a( factor )
{
    return "_med";
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x5b9c8877, Offset: 0x59c1
// Size: 0x45
function private function_4d404e58f208c30a()
{
    if ( self [[ utility::getsharedfunc( #"damage_effects", #"hasarmor" ) ]]() )
    {
        return "_armored_";
    }
    
    if ( isdefined( self.var_3743638e74262366 ) )
    {
        return "_armored_";
    }
    
    return "_unarmored_";
}

// Namespace damage_effects
// Params 3, eflags: 0x4
// Checksum 0x57e8623f, Offset: 0x5a0e
// Size: 0x135
function private function_1fde954cb0f07eca( einflictor, eattacker, smeansofdeath )
{
    if ( !isdefined( eattacker ) )
    {
        return;
    }
    
    if ( einflictor && function_ae27c589e09c3181( smeansofdeath ) )
    {
        sourceorigin = einflictor.origin;
    }
    else
    {
        sourceorigin = eattacker.origin;
    }
    
    forwardvec = vectornormalize( anglestoforward( self.angles ) );
    var_dc50e7fd3a1cc172 = vectornormalize( ( sourceorigin[ 0 ], sourceorigin[ 1 ], 0 ) - ( self.origin[ 0 ], self.origin[ 1 ], 0 ) );
    fdot = vectordot( var_dc50e7fd3a1cc172, forwardvec );
    
    if ( abs( fdot ) > 0.819152 )
    {
        if ( fdot > 0 )
        {
            return #"front";
        }
        else
        {
            return #"back";
        }
        
        return;
    }
    
    rightvec = vectornormalize( anglestoright( self.angles ) );
    rdot = vectordot( var_dc50e7fd3a1cc172, rightvec );
    
    if ( rdot > 0 )
    {
        return #"right";
    }
    
    return #"left";
}

// Namespace damage_effects
// Params 6, eflags: 0x4
// Checksum 0x1d247bf7, Offset: 0x5b4b
// Size: 0x11b, Type: bool
function private function_6b2bb1a8da0087e4( factor, smeansofdeath, idamage, lightarmordamage, objweapon, shitloc )
{
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( idamage + lightarmordamage <= 7 )
    {
        return false;
    }
    
    if ( gettime() - self.damage.lastdiretionalbloodtime < 200 )
    {
        return false;
    }
    
    if ( level.var_ce11fa8b9f14341d ?? utility::iswegameplatform() )
    {
        return false;
    }
    
    if ( swim_common::isplayerunderwater() )
    {
        return false;
    }
    
    if ( function_1e948faff668cf2( smeansofdeath ) || function_3919f2c3b31dabb6( smeansofdeath ) )
    {
        return false;
    }
    
    if ( objweapon.basenamehash == %"dragonsbreath_mp" )
    {
        return false;
    }
    
    if ( self.inlaststand )
    {
        return false;
    }
    
    if ( shitloc == "shield" )
    {
        return false;
    }
    
    var_cdf0984f97281ec4 = level.sharedfuncs[ #"damage_effects" ][ #"hash_10afaf820ce5cf12" ];
    
    if ( isdefined( var_cdf0984f97281ec4 ) && [[ var_cdf0984f97281ec4 ]]() )
    {
        return false;
    }
    
    return true;
}

// Namespace damage_effects
// Params 3, eflags: 0x4
// Checksum 0xd87ff45c, Offset: 0x5c6f
// Size: 0x52, Type: bool
function private function_b1323c25bc2f561c( var_d5e4e442caeb2fdb, smeansofdeath, currenttime )
{
    if ( currenttime == self.damage.var_5cca578d4e528b0b )
    {
        return false;
    }
    
    if ( !isdefined( var_d5e4e442caeb2fdb ) )
    {
        return false;
    }
    
    if ( !utility::isbulletdamage( smeansofdeath ) )
    {
        return false;
    }
    
    return true;
}

// Namespace damage_effects
// Params 9
// Checksum 0xd7c24b97, Offset: 0x5cca
// Size: 0x313
function createscreeneffect( side, shader, intime, outtime, randomoffsets, fadein, lowres, containsblood, noscaleovertime )
{
    hud = newclienthudelem( self );
    
    if ( !isdefined( hud ) )
    {
        return;
    }
    
    hud.sort = 13;
    hud.foreground = 0;
    hud.lowresbackground = lowres;
    hud.horzalign = "fullscreen";
    hud.vertalign = "fullscreen";
    hud.alpha = 0;
    hud.enablehudlighting = 1;
    hud.scramblerdisabled = 1;
    hud.var_4d0bb303932140d6 = containsblood;
    
    if ( !noscaleovertime )
    {
        finalscale = lerp( 0.9, 1.25, randomoffsets.scale );
    }
    
    switch ( side )
    {
        case #"left":
            hud.aligny = "top";
            hud.alignx = "left";
            x = -640;
            y = lerp( -30, 30, randomoffsets.y );
            finaly = y;
            finalx = lerp( -55, 0, randomoffsets.x );
            break;
        case #"right":
            hud.aligny = "top";
            hud.alignx = "right";
            x = 1280;
            y = lerp( -30, 30, randomoffsets.y );
            finaly = y;
            finalx = lerp( 0, 55, randomoffsets.x ) + 640;
            break;
        case #"front":
        case #"back":
        default:
            hud.aligny = "bottom";
            hud.alignx = "left";
            y = 960;
            x = lerp( -50, 50, randomoffsets.x );
            finaly = lerp( 0, 50, randomoffsets.y );
            finaly += 10;
            finaly += 480;
            finalx = x;
            break;
    }
    
    hud.x = x;
    hud.y = y;
    
    if ( ( level.issp ?? utility::issp() ) && !getdvarint( @"hash_72d13bbb13fe76e3" ) )
    {
        hud setshader( shader, 640, 640 );
    }
    else
    {
        hud setshader( shader, 640, 480 );
    }
    
    thread screeneffectcleanup( hud );
    thread animatescreeneffect( hud, intime, outtime, finalx, finaly, finalscale, fadein, noscaleovertime );
}

// Namespace damage_effects
// Params 1, eflags: 0x4
// Checksum 0x15944fc8, Offset: 0x5fe5
// Size: 0x105
function private screeneffectcleanup( hud )
{
    if ( ( level.issp ?? utility::issp() ) && isdefined( self.damage.activescreeneffectoverlays ) && !getdvarint( @"hash_72d13bbb13fe76e3" ) )
    {
        self.damage.activescreeneffectoverlays[ self.damage.activescreeneffectoverlays.size ] = hud;
    }
    
    function_f705a0298cc56a54( hud );
    
    if ( ( level.issp ?? utility::issp() ) && isdefined( self.damage.activescreeneffectoverlays ) && !getdvarint( @"hash_72d13bbb13fe76e3" ) )
    {
        self.damage.activescreeneffectoverlays = arrayremove( self.damage.activescreeneffectoverlays, hud );
    }
    
    if ( isdefined( hud ) )
    {
        hud notify( #"hash_7830c7a7b62f12b7" );
        hud destroy();
    }
}

// Namespace damage_effects
// Params 1, eflags: 0x4
// Checksum 0x69847cdb, Offset: 0x60f2
// Size: 0x26
function private function_f705a0298cc56a54( hud )
{
    self endon( #"death_or_disconnect" );
    hud waittill( #"hash_7830c7a7b62f12b7" );
}

// Namespace damage_effects
// Params 8, eflags: 0x4
// Checksum 0xa283ece3, Offset: 0x6120
// Size: 0x162
function private animatescreeneffect( hud, intime, outtime, x, y, scale, fadein, noscaleovertime )
{
    self endon( #"death_or_disconnect" );
    hud endon( #"hash_7830c7a7b62f12b7" );
    
    if ( !noscaleovertime )
    {
        hud scaleovertime( intime, int( 640 * scale ), int( 480 * scale ) );
    }
    
    if ( !fadein )
    {
        hud moveovertime( intime );
        hud.x = x;
        hud.y = y;
        intime = level.framedurationseconds;
        hud.alpha = function_6318913aa478d700( 1 );
        wait level.framedurationseconds;
    }
    else
    {
        hud.x = x;
        hud.y = y;
        wait level.framedurationseconds;
        hud fadeovertime( intime );
        hud.alpha = function_6318913aa478d700( 1 );
        wait intime + 0.1;
    }
    
    if ( isdefined( hud ) )
    {
        hud fadeovertime( outtime );
        hud.alpha = 0;
    }
    
    wait outtime + level.framedurationseconds;
    
    if ( isdefined( hud ) )
    {
        hud notify( #"hash_7830c7a7b62f12b7" );
    }
}

// Namespace damage_effects
// Params 1
// Checksum 0x9cb2926d, Offset: 0x628a
// Size: 0x44
function damageratio( idamage )
{
    if ( level.issp ?? utility::issp() )
    {
        return math::normalize_value( 40, 160, idamage / self.damagemultiplier );
    }
    
    return math::normalize_value( 10, 40, idamage );
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0xbcf3f120, Offset: 0x62d7
// Size: 0x2e, Type: bool
function private function_b40bd6e3ca77cbbe()
{
    return self.deathsdoor || self.damage.deathsdooroverlaypulse.masteralpha > 0;
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x36f5a890, Offset: 0x630e
// Size: 0x104
function private function_c5ad022985636375()
{
    self notify( #"hash_86d84fd66e110f6f" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_86d84fd66e110f6f" );
    
    if ( !isdefined( self.heartbeat ) )
    {
        return;
    }
    
    /#
        if ( getdvarint( @"hash_3e196084edaeb3eb", 0 ) )
        {
            return;
        }
    #/
    
    self setclientomnvar( o"ui_deathdoor_pulse_intensity", 10 );
    self setclientomnvar( o"ui_deathdoor_pulse", gettime() );
    wait 0.1;
    
    while ( recentdeathsdoor() )
    {
        self.heartbeat waittill( #"heartbeat", intensity );
        
        if ( self.damage.var_99e1bf56c7f1850f )
        {
            intensity = 11;
        }
        
        /#
            if ( getdvarint( @"hash_3e196084edaeb3eb", 0 ) )
            {
                return;
            }
        #/
        
        if ( isdefined( intensity ) )
        {
            if ( !function_dc0bd2510ceae040() )
            {
                self setclientomnvar( o"ui_deathdoor_pulse_intensity", intensity );
                self setclientomnvar( o"ui_deathdoor_pulse", gettime() );
            }
        }
    }
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x847b0a5b, Offset: 0x641a
// Size: 0xd0
function private function_72bfd44565ca0849()
{
    function_d422eb20e78cf6b7( 2 );
    self notify( #"hash_86d84fd66e110f6f" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_86d84fd66e110f6f" );
    
    if ( !isdefined( self.heartbeat ) )
    {
        return;
    }
    
    /#
        if ( getdvarint( @"hash_3e196084edaeb3eb", 0 ) )
        {
            return;
        }
    #/
    
    function_ec1593cdc368a090( 5 );
    wait 0.1;
    
    while ( function_724e8a0b2df6c8fa() )
    {
        intensity = undefined;
        self.heartbeat waittill( #"heartbeat", intensity );
        
        /#
            if ( getdvarint( @"hash_3e196084edaeb3eb", 0 ) )
            {
                return;
            }
        #/
        
        if ( isdefined( intensity ) )
        {
            self setclientomnvar( o"ui_lightdamage_pulse_intensity", 0 );
            self setclientomnvar( o"ui_lightdamage_pulse", gettime() );
        }
    }
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x3453a145, Offset: 0x64f2
// Size: 0x1af
function private function_eeabc3b1eb3bbef2()
{
    if ( level.projectbundle.var_464f31339c96f4ea )
    {
        return;
    }
    
    self notify( #"hash_21f195c6033862e" );
    self endon( #"death_or_disconnect", #"hash_21f195c6033862e" );
    thread function_de45b6f982d43164( 1, 0.3 );
    
    if ( !isdefined( self.heartbeat.pulsetime ) )
    {
        return;
    }
    
    starttime = gettime();
    regendelaytime = [[ level.sharedfuncs[ #"damage_effects" ][ #"hash_5be2154f8714fc82" ] ]]();
    touchalpha = function_6318913aa478d700( 1 );
    
    while ( function_b40bd6e3ca77cbbe() )
    {
        pulsefraction = self.heartbeat.pulsetime;
        pulsealphamax = lerp( 0.15, 0.45, pulsefraction );
        pulsealphamin = lerp( 0.05, 0.28, pulsefraction );
        
        if ( regendelaytime > 0 )
        {
            var_8d28550fc2629cea = math::normalize_value( 0, regendelaytime, gettime() - starttime );
        }
        else
        {
            var_8d28550fc2629cea = 0;
        }
        
        if ( self.damage.deathsdooroverlaypulse )
        {
            self.damage.deathsdooroverlaypulse fadeovertime( level.framedurationseconds );
            self.damage.deathsdooroverlaypulse.alpha = lerp( pulsealphamax, pulsealphamin, var_8d28550fc2629cea ) * self.damage.deathsdooroverlaypulse.masteralpha * touchalpha;
        }
        
        waitframe();
    }
}

// Namespace damage_effects
// Params 1, eflags: 0x4
// Checksum 0x99e729b5, Offset: 0x66a9
// Size: 0x57
function private function_9b917b5c0140143c( intensity )
{
    if ( isdeathsdoor() )
    {
        type = 2;
    }
    else
    {
        type = 4;
    }
    
    function_84db26d2e08b6253( type );
    self setclientomnvar( o"ui_deathdoor_pulse_intensity", intensity );
    self setclientomnvar( o"ui_deathdoor_pulse", gettime() );
}

// Namespace damage_effects
// Params 1, eflags: 0x4
// Checksum 0xedca423e, Offset: 0x6708
// Size: 0x57
function private function_ec1593cdc368a090( intensity )
{
    if ( function_b921453be5b6a831() )
    {
        type = 2;
    }
    else
    {
        type = 3;
    }
    
    function_d422eb20e78cf6b7( type );
    self setclientomnvar( o"ui_deathdoor_pulse_intensity", intensity );
    self setclientomnvar( o"ui_deathdoor_pulse", gettime() );
}

// Namespace damage_effects
// Params 2, eflags: 0x4
// Checksum 0x84bc1ddf, Offset: 0x6767
// Size: 0x133
function private function_26b66cf8cd25584f( startalpha, time )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( self.deathsdoor )
    {
        return;
    }
    
    if ( !isdefined( self.damage ) )
    {
        return;
    }
    
    self notify( #"hash_6be478b70d8b4566" );
    self endon( #"hash_6be478b70d8b4566" );
    self endon( #"hash_21f195c6033862e" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    starttime = time;
    
    while ( time > 0 )
    {
        if ( !isdefined( self.damage.deathsdooroverlaypulse ) )
        {
            return;
        }
        
        timefactor = math::normalize_value( 0, starttime, time );
        pulsealpha = math::factor_value( 0, startalpha, timefactor );
        pulsealpha = function_6318913aa478d700( pulsealpha );
        self.damage.deathsdooroverlaypulse fadeovertime( level.framedurationseconds );
        self.damage.deathsdooroverlaypulse.alpha = pulsealpha;
        wait level.framedurationseconds;
        time -= level.framedurationseconds;
    }
}

// Namespace damage_effects
// Params 1, eflags: 0x4
// Checksum 0x72830764, Offset: 0x68a2
// Size: 0x30
function private function_d422eb20e78cf6b7( type )
{
    self setclientomnvar( o"ui_lightdamage_pulse_fade_type", type );
    self setclientomnvar( o"ui_lightdamage_pulse_fade", gettime() );
}

// Namespace damage_effects
// Params 1, eflags: 0x4
// Checksum 0x75ef7e0, Offset: 0x68da
// Size: 0x30
function private function_84db26d2e08b6253( type )
{
    self setclientomnvar( o"ui_deathdoor_pulse_fade_type", type );
    self setclientomnvar( o"ui_deathdoor_pulse_fade", gettime() );
}

// Namespace damage_effects
// Params 2, eflags: 0x4
// Checksum 0xb50bf397, Offset: 0x6912
// Size: 0x144
function private function_de45b6f982d43164( targetalpha, time )
{
    self notify( #"hash_6bb538a92c7e4a16" );
    
    if ( !isdefined( self.damage.deathsdooroverlaypulse ) )
    {
        return;
    }
    
    self endon( #"hash_6bb538a92c7e4a16", #"death_or_disconnect" );
    timer = time;
    startalpha = self.damage.deathsdooroverlaypulse.masteralpha;
    
    if ( isdefined( self.perks[ "specialty_reduce_death_door" ] ) )
    {
        targetalpha *= 0.5;
    }
    
    while ( timer > 0 )
    {
        if ( !isdefined( self.damage.deathsdooroverlaypulse ) )
        {
            return;
        }
        
        normtime = math::normalize_value( 0, time, timer );
        self.damage.deathsdooroverlaypulse.masteralpha = lerp( targetalpha, startalpha, normtime );
        timer -= level.framedurationseconds;
        waitframe();
    }
    
    if ( isdefined( self.damage.deathsdooroverlaypulse ) )
    {
        self.damage.deathsdooroverlaypulse.masteralpha = targetalpha;
    }
}

// Namespace damage_effects
// Params 10, eflags: 0xc
// Checksum 0x36d1e67e, Offset: 0x6a5e
// Size: 0x784
function private function_3c0c5097b14c612f( idamage, einflictor, eattacker, evictim, smeansofdeath, vpoint, lightarmordamage, objweapon, shitloc, vdir )
{
    self notify( #"hash_5165dba89a8ef792" );
    self endon( #"hash_5165dba89a8ef792" );
    self endon( #"death_disconnect" );
    level endon( #"game_ended" );
    isspreadweapon = weapon::isspreadweapon( objweapon );
    headshot = 0;
    
    if ( utility::issharedfuncdefined( #"damage", #"isheadshot" ) )
    {
        headshot = !isspreadweapon && utility::callsharedfunc( #"damage", #"isheadshot", shitloc, smeansofdeath, eattacker );
    }
    
    meleedamage = 0;
    sharpdamage = 0;
    var_dee4147437e1848c = 0;
    
    if ( smeansofdeath == "MOD_MELEE" )
    {
        meleedamage = 1;
        normalizedweaponname = removesubstr( objweapon.basename, "_mp" );
        
        foreach ( weaponentry in level.var_3ee3371f09a43391.sharp_weapon_list )
        {
            if ( weaponentry.weapondata == normalizedweaponname )
            {
                sharpdamage = 1;
                break;
            }
        }
        
        foreach ( weaponentry in level.var_3ee3371f09a43391.var_4271ec429c2c0e27 )
        {
            if ( weaponentry.weapondata == normalizedweaponname )
            {
                var_dee4147437e1848c = 1;
                break;
            }
        }
        
        if ( sharpdamage == 0 && var_dee4147437e1848c == 0 )
        {
            var_dee4147437e1848c = 1;
        }
    }
    
    var_6b237396e026108b = 10;
    var_e12aa1e9b393f526 = 200;
    
    if ( headshot || meleedamage )
    {
        var_6b237396e026108b = 20;
        var_e12aa1e9b393f526 = 300;
    }
    
    explosivedamage = 0;
    explosivedamagescalar = 1;
    
    if ( smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" )
    {
        explosivedamage = 1;
        explosivedamagescalar = math::remap( idamage, 1, 150, 1, 2 );
        var_6b237396e026108b = int( clamp( 20 * explosivedamagescalar, 0, 50 ) );
        var_e12aa1e9b393f526 = int( clamp( 300 * explosivedamagescalar, 0, 1000 ) );
    }
    
    self setclientomnvar( "ui_hud_shake_intensity", var_6b237396e026108b );
    self setclientomnvar( "ui_hud_shake_variation", 15 );
    self setclientomnvar( "ui_hud_shake_duration", var_e12aa1e9b393f526 );
    self setclientomnvar( "ui_hud_shake", 1 );
    healthfrac = math::remap( self.health, 0, self.maxhealth, 0, 1 );
    
    if ( self.health + idamage == 150 )
    {
        self setclientomnvar( o"ui_hud_initial_damage_event", gettime() );
    }
    
    foreach ( effect in level.var_3ee3371f09a43391.on_hit_effects )
    {
        pbgpostfxbundlestart( self, effect.pbgpostfxbundle );
    }
    
    if ( explosivedamage )
    {
        foreach ( effect in level.var_3ee3371f09a43391.explosive_effects )
        {
            pbgpostfxbundlestart( self, effect.pbgpostfxbundle );
        }
        
        thread function_ad75892f11965b17( explosivedamagescalar, 1 * explosivedamagescalar );
    }
    
    if ( var_dee4147437e1848c )
    {
        foreach ( effect in level.var_3ee3371f09a43391.var_6e5811dc02328a13 )
        {
            pbgpostfxbundlestart( self, effect.pbgpostfxbundle );
        }
        
        thread function_ad75892f11965b17( explosivedamagescalar, 1 * explosivedamagescalar );
    }
    
    if ( sharpdamage )
    {
        foreach ( effect in level.var_3ee3371f09a43391.var_b0ac0c5f1af7aa18 )
        {
            pbgpostfxbundlestart( self, effect.pbgpostfxbundle );
        }
    }
    
    if ( healthfrac <= 0.75 && healthfrac > 0.5 )
    {
        foreach ( effect in level.var_3ee3371f09a43391.var_2fa3aec42bb899ea )
        {
            pbgpostfxbundlestart( self, effect.pbgpostfxbundle );
        }
    }
    else if ( healthfrac <= 0.5 )
    {
        foreach ( effect in level.var_3ee3371f09a43391.var_26c0dc68f30f6168 )
        {
            pbgpostfxbundlestart( self, effect.pbgpostfxbundle );
        }
    }
    
    if ( self.deathsdoor )
    {
        foreach ( effect in level.var_3ee3371f09a43391.deaths_door_effects )
        {
            pbgpostfxbundlestart( self, effect.pbgpostfxbundle );
        }
        
        thread function_471671be51a21692();
    }
    
    self setclientomnvar( "ui_hud_shake", 0 );
}

// Namespace damage_effects
// Params 3
// Checksum 0x69dbb848, Offset: 0x71ea
// Size: 0x2e5
function function_7f61c7c682c86d02( healthperframe, var_f59a911b497039bd, var_295bb137e300b647 )
{
    self notify( #"hash_1bde3c1a13649eb6" );
    self endon( #"hash_1bde3c1a13649eb6" );
    self endon( #"death_or_disconnect" );
    waitframe();
    var_e1d8102a27925adb = 0.05;
    var_5fc006a5e7de01d9 = self.maxhealth - self.health;
    var_8410194ddd3526f0 = var_5fc006a5e7de01d9 / healthperframe;
    var_eea4bf65e4b07817 = var_8410194ddd3526f0 * var_e1d8102a27925adb;
    timelinescale = 1;
    
    if ( var_eea4bf65e4b07817 != 0 )
    {
        timelinescale = 1 / var_eea4bf65e4b07817;
    }
    
    if ( var_f59a911b497039bd && self.deathsdoor )
    {
        self setclientomnvar( o"ui_hud_healing_damage_event", gettime() );
        
        foreach ( effect in level.var_3ee3371f09a43391.deaths_door_effects )
        {
            pbgpostfxbundleend( self, effect.pbgpostfxbundle, timelinescale );
        }
    }
    
    if ( var_295bb137e300b647 )
    {
        foreach ( effect in level.var_3ee3371f09a43391.var_26c0dc68f30f6168 )
        {
            pbgpostfxbundleend( self, effect.pbgpostfxbundle, timelinescale );
        }
        
        foreach ( effect in level.var_3ee3371f09a43391.var_2fa3aec42bb899ea )
        {
            pbgpostfxbundleend( self, effect.pbgpostfxbundle, timelinescale );
        }
        
        foreach ( effect in level.var_3ee3371f09a43391.heal_start_effects )
        {
            pbgpostfxbundlestart( self, effect.pbgpostfxbundle, timelinescale );
        }
    }
}

// Namespace damage_effects
// Params 3
// Checksum 0x3fef9b85, Offset: 0x74d7
// Size: 0xc4
function function_772d325bd6c693c( vfx, currenttime, timeout )
{
    self endon( #"disconnect" );
    
    /#
        if ( !isdefined( self.model ) || self.model == "<dev string:x153>" )
        {
            iprintlnbold( "<dev string:x240>" + self getentitynumber() + "<dev string:x26d>" );
            return;
        }
        
        if ( !utility::hastag( self.model, "<dev string:x285>" ) )
        {
            iprintlnbold( "<dev string:x28d>" + self.model + "<dev string:x2b9>" );
            return;
        }
        
        function_969f93d53616a231( vfx );
    #/
    
    playfxontagforclients( level._effect[ vfx ], self, "tag_eye", self, 0 );
    function_1e8905858f17456b( vfx, currenttime );
}

// Namespace damage_effects
// Params 0
// Checksum 0x6ded0a5c, Offset: 0x75a3
// Size: 0xac
function function_bf2875d2fd55a5a()
{
    currenttime = gettime();
    
    foreach ( key, var_d6b6ff3cf4e90cf3 in self.damage.var_36f37abd252184c6 )
    {
        if ( currenttime - var_d6b6ff3cf4e90cf3 < 6000 )
        {
            killfxontag( level._effect[ key ], self, "tag_eye" );
        }
    }
}

// Namespace damage_effects
// Params 0
// Checksum 0x47118499, Offset: 0x7657
// Size: 0x1b2
function function_fc21ac568b697622()
{
    nightmode = 0;
    
    if ( getdvarint( @"hash_1c4a81c37c3eb689", 0 ) )
    {
        nightmode = 1;
    }
    
    fxbundle = getscriptbundle( level.gamemodebundle.var_c777433e12b567c2 );
    
    if ( nightmode )
    {
        fxbundle = getscriptbundle( level.gamemodebundle.var_2aa91944a3f8ebe8 );
    }
    
    if ( !isdefined( level.var_3ee3371f09a43391 ) )
    {
        level.var_3ee3371f09a43391 = spawnstruct();
    }
    
    level.var_3ee3371f09a43391.deaths_door_effects = fxbundle.deaths_door_effects;
    level.var_3ee3371f09a43391.var_6e5811dc02328a13 = fxbundle.var_38f3ed33130970a7;
    level.var_3ee3371f09a43391.explosive_effects = fxbundle.explosive_damage_effects;
    level.var_3ee3371f09a43391.var_26c0dc68f30f6168 = fxbundle.var_26c0dc68f30f6168;
    level.var_3ee3371f09a43391.var_2fa3aec42bb899ea = fxbundle.var_2978a7f29fdb2f63;
    level.var_3ee3371f09a43391.var_b0ac0c5f1af7aa18 = fxbundle.var_fbfd5a8be462cb6a;
    level.var_3ee3371f09a43391.on_hit_effects = fxbundle.on_hit_effects;
    level.var_3ee3371f09a43391.heal_start_effects = fxbundle.heal_start_fx;
    level.var_3ee3371f09a43391.sharp_weapon_list = fxbundle.sharp_weapon_list;
    level.var_3ee3371f09a43391.var_4271ec429c2c0e27 = fxbundle.var_4271ec429c2c0e27;
}

// Namespace damage_effects
// Params 2
// Checksum 0x313e1f04, Offset: 0x7811
// Size: 0x47
function function_ad75892f11965b17( intensityscalar, duration )
{
    self endon( #"death_or_disconnect" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( self.deathsdoor )
    {
        return;
    }
    
    InvalidOpCode( 0x59, 64 * intensityscalar, intensityscalar, 64 * intensityscalar, intensityscalar );
    // Unknown operator ( 0x59, t11, Black Ops 7 )
}

// Namespace damage_effects
// Params 0
// Checksum 0x4a53191d, Offset: 0x7880
// Size: 0x3c
function function_471671be51a21692()
{
    self endon( #"death_or_disconnect" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    var_10b9179d7617bbeb = getdvarfloat( @"hash_d26c7f479f9d3e44", 1 );
    InvalidOpCode( 0x59, 48, var_10b9179d7617bbeb, 48, var_10b9179d7617bbeb );
    // Unknown operator ( 0x59, t11, Black Ops 7 )
}

// Namespace damage_effects
// Params 4
// Checksum 0x3dcd5eef, Offset: 0x78f3
// Size: 0x83
function enableburnfx( skip_sound, var_8891fdbf4e932468, var_fe824c0029e3947a, burnsfxoverride )
{
    if ( !isdefined( self.burnfxstates ) )
    {
        self.burnfxstates = [];
    }
    
    if ( !isdefined( var_8891fdbf4e932468 ) )
    {
        var_8891fdbf4e932468 = "active";
    }
    
    if ( !isdefined( var_fe824c0029e3947a ) )
    {
        var_fe824c0029e3947a = "burning";
    }
    
    if ( !skip_sound )
    {
        thread enableburnsfx( burnsfxoverride );
    }
    
    self.burnfxstates[ var_fe824c0029e3947a ][ getburnfxstatepriority( var_8891fdbf4e932468 ) ] = var_8891fdbf4e932468;
    startburnfx();
}

// Namespace damage_effects
// Params 1, eflags: 0x4
// Checksum 0xd9a2b1e9, Offset: 0x797e
// Size: 0x51
function private getburnfxstatepriority( state )
{
    switch ( state )
    {
        case #"hash_9943bf0047670307":
            return 3;
        case #"hash_7173532436329889":
            return 2;
        case #"hash_bee8aefcdf5a9a8f":
            return 1;
        default:
            return 0;
    }
}

// Namespace damage_effects
// Params 2, eflags: 0x4
// Checksum 0x42b6d6b9, Offset: 0x79d7
// Size: 0x5e
function private gethightestpriotiryactiveburnstate( burnfxstates, var_3a02e46e25a0a244 = "burning" )
{
    i = 3;
    higheststate = undefined;
    
    while ( i >= 0 )
    {
        if ( isdefined( burnfxstates[ var_3a02e46e25a0a244 ][ i ] ) )
        {
            higheststate = burnfxstates[ var_3a02e46e25a0a244 ][ i ];
            break;
        }
        
        i--;
    }
    
    return higheststate;
}

// Namespace damage_effects
// Params 1, eflags: 0x4
// Checksum 0xc3aa3938, Offset: 0x7a3e
// Size: 0x11a
function private enableburnsfx( burnsfxoverride )
{
    self notify( #"updateburnsfx" );
    self endon( #"death_or_disconnect" );
    self endon( #"updateburnsfx" );
    
    if ( !isdefined( self.burnsfxenabled ) )
    {
        self.burnsfxenabled = 0;
    }
    
    if ( !isdefined( self.burnsfx ) )
    {
        self.burnsfx = spawn( "script_origin", self.origin );
        self.burnsfx.targetname = "enableBurnSFX";
        self.burnsfx linkto( self );
        var_b0fb849d9510c30 = level.sharedfuncs[ #"entity" ][ #"registerspawncount" ];
        
        if ( isdefined( var_b0fb849d9510c30 ) )
        {
            self.burnsfx [[ var_b0fb849d9510c30 ]]( 1 );
        }
        
        wait 0.05;
    }
    
    if ( self.burnsfxenabled == 0 )
    {
        if ( isdefined( self.burnsfx ) )
        {
            self.burnsfx playloopsound( burnsfxoverride ?? "iw9_weap_molotov_fire_enemy_burn" );
            self.burnsfxenabled = 1;
        }
    }
}

// Namespace damage_effects
// Params 4
// Checksum 0x870bb367, Offset: 0x7b60
// Size: 0x86
function enableburnfxfortime( duration, var_8891fdbf4e932468 = "active", burnsfxoverride, var_b82c2b3966aaeeaf )
{
    stateendon = "endon_burnfxForTime_" + var_8891fdbf4e932468;
    self notify( stateendon );
    self endon( #"disconnect" );
    self endon( #"clearburnfx" );
    self endon( stateendon );
    thread enableburnfx( 0, var_8891fdbf4e932468, undefined, burnsfxoverride );
    wait duration;
    thread disableburnfx( 0, var_8891fdbf4e932468, undefined, var_b82c2b3966aaeeaf );
}

// Namespace damage_effects
// Params 4
// Checksum 0x9bc84fd8, Offset: 0x7bee
// Size: 0xd5
function disableburnfx( skip_sound, burningstate, burningpart, var_b82c2b3966aaeeaf )
{
    if ( !isdefined( self.burnfxstates ) )
    {
        self.burnfxstates = [];
    }
    
    if ( !isdefined( burningpart ) )
    {
        burningpart = "burning";
    }
    
    if ( isdefined( burningstate ) && isdefined( self.burnfxstates[ burningpart ] ) )
    {
        self.burnfxstates[ burningpart ][ getburnfxstatepriority( burningstate ) ] = undefined;
        self.burnfxstates[ burningpart ] = function_5713d46873b29625( self.burnfxstates[ burningpart ] );
    }
    else
    {
        self.burnfxstates[ burningpart ] = [];
    }
    
    if ( self.burnfxstates[ burningpart ].size > 0 )
    {
        startburnfx();
        return;
    }
    
    stopburnfx();
    
    if ( !skip_sound )
    {
        thread disable_burnsfx( var_b82c2b3966aaeeaf );
    }
}

// Namespace damage_effects
// Params 1, eflags: 0x4
// Checksum 0x39f80615, Offset: 0x7ccb
// Size: 0x76
function private disable_burnsfx( var_b82c2b3966aaeeaf )
{
    self notify( #"updateburnsfx" );
    self endon( #"death_or_disconnect" );
    self endon( #"updateburnsfx" );
    wait 0.5;
    
    if ( self.burnsfxenabled == 1 )
    {
        if ( self.burnsfx )
        {
            self.burnsfx playloopsound( var_b82c2b3966aaeeaf ?? "iw9_weap_molotov_fire_enemy_burn_end" );
            wait 0.15;
            clearburnsfx();
        }
    }
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x6108fa54, Offset: 0x7d49
// Size: 0x14d
function private startburnfx()
{
    foreach ( part, state in self.burnfxstates )
    {
        var_8891fdbf4e932468 = gethightestpriotiryactiveburnstate( self.burnfxstates, part );
        
        if ( isdefined( var_8891fdbf4e932468 ) )
        {
            self setscriptablepartstate( part, var_8891fdbf4e932468 );
            self.burnfxplaying = 1;
            function_ee2719d440d66a15( var_8891fdbf4e932468, part );
            enqueuecorpsetablefunc = level.sharedfuncs[ #"damage" ][ #"enqueuecorpsetablefunc" ];
            
            if ( isdefined( enqueuecorpsetablefunc ) )
            {
                if ( !( isdefined( self.corpsetablefuncs ) && isdefined( self.corpsetablefuncs[ "burning" ] ) ) )
                {
                    [[ enqueuecorpsetablefunc ]]( "burning", &burnfxcorpstablefunc );
                }
            }
        }
    }
    
    if ( isdefined( self.callbacks[ #"hash_edf8432901e795b" ] ) || isdefined( level.callbacks[ #"hash_edf8432901e795b" ] ) )
    {
        callback::callback( #"hash_edf8432901e795b" );
    }
}

// Namespace damage_effects
// Params 1
// Checksum 0xcdf49c5e, Offset: 0x7e9e
// Size: 0x5b
function clearburning( clearcorpsetable )
{
    if ( isdefined( self.callbacks[ #"on_player_clear_burning" ] ) || isdefined( level.callbacks[ #"on_player_clear_burning" ] ) )
    {
        callback::callback( #"on_player_clear_burning" );
    }
    
    clearburnfx( clearcorpsetable );
    clearburnsfx();
}

// Namespace damage_effects
// Params 1, eflags: 0x4
// Checksum 0x8e723570, Offset: 0x7f01
// Size: 0x79
function private clearburnfx( clearcorpsetable )
{
    self notify( #"clearburnfx" );
    function_fb0348f11d17d087();
    
    if ( clearcorpsetable )
    {
        dequeuecorpsetablefunc = level.sharedfuncs[ #"damage" ][ #"dequeuecorpsetablefunc" ];
        
        if ( isdefined( dequeuecorpsetablefunc ) )
        {
            self [[ dequeuecorpsetablefunc ]]( "burning" );
        }
        
        function_ee2719d440d66a15();
    }
    
    self.burnfxplaying = undefined;
    self.burnfxstates = undefined;
}

// Namespace damage_effects
// Params 1
// Checksum 0xfe4ab8b8, Offset: 0x7f82
// Size: 0x9e
function burnfxcorpstablefunc( corpsetable )
{
    if ( isdefined( self ) && isdefined( self.var_68d6335dc889b9a3 ) )
    {
        foreach ( part, state in self.var_68d6335dc889b9a3 )
        {
            if ( isdefined( state ) )
            {
                corpsetable setscriptablepartstate( part, state, 0 );
            }
        }
    }
}

// Namespace damage_effects
// Params 2
// Checksum 0xf2bac8d1, Offset: 0x8028
// Size: 0x147
function function_ee2719d440d66a15( var_8891fdbf4e932468, burningpart )
{
    if ( isdefined( var_8891fdbf4e932468 ) )
    {
        if ( var_8891fdbf4e932468 == "nuke_active" || var_8891fdbf4e932468 == "wp_active" || var_8891fdbf4e932468 == "active" )
        {
            var_8891fdbf4e932468 = "flareUp";
        }
        else
        {
            switch ( var_8891fdbf4e932468 )
            {
                case #"hash_aff60910f2d22661":
                    var_8891fdbf4e932468 = "al_to_ar_";
                    break;
                case #"hash_e375a3f665d58036":
                    var_8891fdbf4e932468 = "al_to_ll_";
                    break;
                case #"hash_32f426f68ef33047":
                case #"hash_56dae623a0537cab":
                case #"hash_94143bf6c209d5b9":
                    var_8891fdbf4e932468 = "to_ar_lr";
                    break;
                case #"hash_79ca5b8a91fe4b3f":
                case #"hash_8b427f4805eb13fc":
                case #"hash_b81e7b23d386c21a":
                    var_8891fdbf4e932468 = "to_ll_lr";
                    break;
                case #"hash_384a0d26e7095bf9":
                case #"hash_4fa5087b17ea1b62":
                case #"hash_78a25902c839c2bc":
                case #"hash_a6405a3db3fbeda8":
                case #"hash_d00a40c1f19a1a07":
                case #"hash_d56c02428470d154":
                    var_8891fdbf4e932468 = "flareUp";
                    break;
            }
        }
        
        self.var_68d6335dc889b9a3[ burningpart ] = var_8891fdbf4e932468;
        return;
    }
    
    self.var_68d6335dc889b9a3 = undefined;
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0xa30a3898, Offset: 0x8177
// Size: 0xa0
function private stopburnfx()
{
    if ( isdefined( self.burnfxplaying ) )
    {
        function_fb0348f11d17d087();
        dequeuecorpsetablefunc = level.sharedfuncs[ #"damage" ][ #"dequeuecorpsetablefunc" ];
        
        if ( isdefined( dequeuecorpsetablefunc ) )
        {
            self [[ dequeuecorpsetablefunc ]]( "burning" );
        }
        
        function_ee2719d440d66a15();
        self.burnfxplaying = undefined;
    }
    
    if ( isdefined( self.callbacks[ #"hash_92ba82e85aebcd61" ] ) || isdefined( level.callbacks[ #"hash_92ba82e85aebcd61" ] ) )
    {
        callback::callback( #"hash_92ba82e85aebcd61" );
    }
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x139cad0b, Offset: 0x821f
// Size: 0xae
function private function_fb0348f11d17d087()
{
    if ( self isscriptable() )
    {
        if ( isdefined( self.burnfxstates ) )
        {
            foreach ( part, state in self.burnfxstates )
            {
                if ( self getscriptablehaspart( part ) && self getscriptableparthasstate( part, "neutral" ) )
                {
                    self setscriptablepartstate( part, "neutral" );
                }
            }
        }
    }
}

// Namespace damage_effects
// Params 0, eflags: 0x4
// Checksum 0x4d2032e2, Offset: 0x82d5
// Size: 0x8e
function private clearburnsfx()
{
    if ( self.burnsfxenabled == 1 )
    {
        if ( isdefined( self.burnsfx ) )
        {
            self.burnsfx stoploopsound();
        }
        
        self.burnsfxenabled = 0;
    }
    
    if ( isdefined( self.burnsfx ) )
    {
        var_b0fb849d9510c30 = level.sharedfuncs[ #"entity" ][ #"deregisterspawn" ];
        
        if ( isdefined( var_b0fb849d9510c30 ) )
        {
            self.burnsfx [[ var_b0fb849d9510c30 ]]();
        }
        
        self.burnsfx delete();
    }
}

