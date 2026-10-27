// scripts\mp\ob\supers\mega_jump.gsc  (hash_0e9538c98c7ca65e.gscc) (size: 7911 Bytes / 0x1ee7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe64ba0c (241482252)
// size ...... 7911 (0x1ee7)
// includes .. 8   (offset: 0x1e0b)
// strings ... 6   (offset: 0x1e4b)
// dev strs .. 2   (offset: 0x1ecf)
// exports ... 19  (offset: 0x127b)
// cseg ...... 0xcd + 0x11ae (0x127b)
// imports ... 71  (offset: 0x1573)
// animtree1 . 0   (offset: 0x1ee7)
// animtree2 . 0   (offset: 0x1ee7)
#using scripts\common\callbacks;
#using scripts\common\mega_jump;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\player;
#using scripts\mp\hud_util;
#using scripts\mp\supers;

#namespace super_mega_jump;

// Namespace super_mega_jump
// Params 0, eflags: 0x5
// Checksum 0xd4ed5d13, Offset: 0xeb
// Size: 0x18
function private autoexec main()
{
    level callback::add( #"register_super", &register );
}

// Namespace super_mega_jump
// Params 1, eflags: 0x4
// Checksum 0xd3b25d89, Offset: 0x10b
// Size: 0x42
function private register( params )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_mega_jump" );
    
    if ( !bundle )
    {
        return;
    }
    
    supers_mp::function_48aaa60b2ce7b8a1( "super_mega_jump", undefined, undefined, &begin_use, &end_use );
}

// Namespace super_mega_jump
// Params 0, eflags: 0x4
// Checksum 0x98c5fca7, Offset: 0x155
// Size: 0x1f2, Type: bool
function private begin_use()
{
    assert( isplayer( self ) );
    init_data();
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_mega_jump" );
    assert( isdefined( bundle ), "<dev string:x24>" );
    
    if ( !mega_jump::function_73a22993dd3552d9( self.megajumpdata ) || mega_jump::is_jump_blocked( self.megajumpdata ) )
    {
        function_9b0065d6803f0742( self, &"hash_537d114765de23b1" );
        return false;
    }
    
    if ( vehicle::is_in_vehicle( 1 ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_cd3a10a0abd05989", 0 ) == 1 )
    {
        self.megajumpdata.jumpcharge = 0;
    }
    
    enablemeter = getdvarint( @"hash_93116b073e8c86ce", 0 ) == 1;
    
    if ( enablemeter && self.megajumpdata.var_f6fe964172e0713b && self.megajumpdata.jumpcharge )
    {
        self.megajumpdata.hudelem = mega_jump::function_6f111bab77b7e98e( self.megajumpdata );
        thread mega_jump::function_71d518aa9f31af3( self.megajumpdata );
    }
    
    thread mega_jump::function_d4e3654470dc5faf( self.megajumpdata );
    val::set( "super_mega_jump", "vehicle_use", 0 );
    
    if ( self.megajumpdata.jumpcharge )
    {
        jumpbutton = mega_jump::get_jump_button( self.megajumpdata );
        
        if ( ![[ jumpbutton ]]() )
        {
            self disableoffhandsecondaryweapons();
            thread mega_jump::function_95e0626532c216af( self.megajumpdata, 0, self.megajumpdata.var_2ddae231fa1bce8d, undefined, 0 );
        }
        
        thread function_7d8729d895632e06();
    }
    else
    {
        do_jump( self.megajumpdata );
    }
    
    thread function_c13b22b1d3677046( self.megajumpdata );
    self.megajumpdata.megajumpinprogress = 1;
    return true;
}

// Namespace super_mega_jump
// Params 2, eflags: 0x4
// Checksum 0x1f6ebe28, Offset: 0x350
// Size: 0x1c
function private end_use( fromdeath, attacker )
{
    on_unset();
}

// Namespace super_mega_jump
// Params 0, eflags: 0x4
// Checksum 0xefcb6ff1, Offset: 0x374
// Size: 0x123
function private on_unset()
{
    self endon( #"disconnect" );
    var_2636c0e53510918d = isdefined( self.megajumpdata ) && !self isonground() && !self isparachuting() && !self iswingsuitdeployed() && !self isswimming() && !self isonladder();
    mega_jump::reset_gravity( self.megajumpdata );
    mega_jump::function_390b0ad3b5327478( self.megajumpdata );
    val::reset( "super_mega_jump", "vehicle_use" );
    
    if ( self.megajumpdata.hudelem )
    {
        self.megajumpdata.hudelem.barelem hud_util::destroyelem();
        self.megajumpdata.hudelem hud_util::destroyelem();
    }
    
    if ( isdefined( self.megajumpdata ) )
    {
        self.megajumpdata = undefined;
    }
    
    self enableoffhandsecondaryweapons();
    
    if ( var_2636c0e53510918d )
    {
        thread function_4b28309bf54b1332();
    }
    else
    {
        mega_jump::set_fall_damage_reduction( 0 );
    }
    
    mega_jump::toggle_allows( 0 );
    self notify( #"hash_81ca3283df4a7852" );
}

// Namespace super_mega_jump
// Params 0, eflags: 0x4
// Checksum 0x6021a1f0, Offset: 0x49f
// Size: 0x62
function private function_4b28309bf54b1332()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( player::isaliveandnotinlaststand( self ) && !self isonground() && !self isparachuting() && !self iswingsuitdeployed() && !self isswimming() && !self isonladder() )
    {
        waitframe();
    }
    
    mega_jump::set_fall_damage_reduction( 0 );
}

// Namespace super_mega_jump
// Params 0, eflags: 0x4
// Checksum 0xd54a0d9b, Offset: 0x509
// Size: 0x635
function private init_data()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_mega_jump" );
    data = spawnstruct();
    data.source = "super_mega_jump";
    data.jumpvelocity = utility::callsharedfunc( "super_mega_jump", #"hash_8017d0662b5d464" ) ?? bundle.megajumpvelocity;
    data.var_cbd83be916eedb5 = bundle.var_3b76a61902432497;
    data.var_dd3219c1e457c686 = bundle.var_e2aebbfc92519514;
    data.var_7c03c68f5f3ba7db = bundle.var_adc698418b4d3b9d;
    data.var_4ced135dbe9fa50c = bundle.var_672189d04c170ada;
    data.var_749471e3c5f60fcf = bundle.var_9d0417a21f588be1;
    data.var_b8cd115af1fd2864 = bundle.var_79a6de1b04ebbd66;
    data.var_eacbf2fc79e9e24d = bundle.var_22c530628ea9fde7;
    data.var_f32618e2a8138a0d = bundle.var_f7584ba9122e3507;
    data.var_7bea7513df321b89 = bundle.var_5535de47b65e8155;
    data.killscoreevent = bundle.var_f41b24bdb9fdf6de;
    data.var_c804c31804a771d9 = bundle.var_ad994152a2a9da7;
    data.stunenemies = bundle.var_9c25f45c6dca3700;
    data.var_996156cbbcea8faa = bundle.var_ff2c1cd528ff37b8;
    data.var_d77e705f0ccb6392 = bundle.var_6164ce7e13855584;
    data.var_eed7703e78988f29 = bundle.var_429183b0657cb76f;
    data.aistunduration = bundle.var_ad53203432490026;
    data.var_151ed9464ec398ca = bundle.var_6bbc1e47fb622b5c;
    data.var_595de568155e6bbf = bundle.var_c05ae45a7bdbf91d;
    data.playersstunduration = bundle.var_31a6efbeaf5a119d;
    data.var_2574d45002fd6e91 = bundle.var_7c6bdba9bce92db7;
    data.var_3a79d2bad66cb960 = bundle.var_173318e4d97c84f2;
    data.var_b46f2cd1d2ce3065 = bundle.var_c37eb4a3af5b8c33;
    data.knockbackenemies = undefined;
    data.var_318512672428e90f = undefined;
    data.var_b347a841e826d76b = undefined;
    data.var_f01f8e2076f48d47 = undefined;
    data.invulnerability = undefined;
    data.invulnerabilityduration = undefined;
    data.jumpcharge = bundle.megajumpcharge;
    data.var_94f4b18847f3db46 = bundle.var_a48fa8df27168a28;
    data.var_85cfd875cb522cf5 = bundle.var_cf3778503b52f173;
    data.var_4216a58f5384bbe4 = bundle.var_75eca75862ae4cea;
    data.var_2ddae231fa1bce8d = bundle.var_ebfd1bb606e241ff;
    data.var_e14ece62d463f34b = bundle.var_fe82bfd676739da1;
    data.var_fb383ec529298474 = bundle.var_cfc524bc8272965e;
    
    if ( bundle.var_cfc524bc8272965e )
    {
        data.var_9f8f8e3512f02bdf = &function_1b23f732e99619b8;
    }
    
    data.var_3033f47b69bebd3 = bundle.var_80c26f6a9250b9bd;
    data.var_2f81976b1022304c = bundle.var_d97c7203673b8386;
    data.var_10b5f37366d72995 = bundle.var_156178d13fd94797;
    data.applyjumpvelocity = &function_7ba68979645347cb;
    data.var_1b4e0b2c23f781ca = utility::callsharedfunc( "super_mega_jump", #"hash_2c5f615801de8fc3" ) ?? bundle.var_24e614eb17a7536c;
    data.var_2f73f374e23d1a57 = utility::callsharedfunc( "super_mega_jump", #"hash_424e162a1e8fa5fe" ) ?? bundle.var_62b6e69d66176059;
    data.var_d5c0efa15ba4c349 = bundle.var_7e002b16b8c07e9f;
    data.var_1db13b161abefa7a = bundle.var_44e9b97c76fb8bc0;
    data.var_4c1ed65d36e30ae8 = bundle.var_43536fce4ee2d852;
    data.var_ea5b9ffb01601a99 = bundle.var_2a28fe2bc38b15bb;
    data.var_56787ed479e23a53 = bundle.var_c2a1034950c8a9c1;
    data.var_ed8a4d10547d554a = bundle.var_dbe704d32630b648;
    data.damageradius = bundle.megajumpdamageradius;
    data.var_5969330601bd2a4f = bundle.var_a348105a618502e1;
    data.var_20d433e71e42e8ca = bundle.var_518da48bb0500ecd ?? 0;
    data.var_c853e3e5f6b758dc = bundle.var_c2ab8d8a695f418b;
    data.var_d43079b5fa943d16 = bundle.var_b291eae62d6ebbe8 ? 0 : getdvarint( @"hash_ebe3d2a2189714ad", 1 );
    data.jumpbutton = bundle.var_b291eae62d6ebbe8 ? undefined : &function_815cc98d0e7d0f3f;
    data.var_f6fe964172e0713b = 1;
    data.barxpos = -370;
    data.barypos = -50;
    data.var_c27a2418f1d8f32d = 1;
    data.var_6acc825afc52be6e = "sat_mega_jump_ob";
    
    if ( data.var_f6fe964172e0713b )
    {
        data.var_cbc393d6c6f0e3b = ( 1, 1, 1 );
        data.var_8d688d62dfcbcfb8 = ( 0, 1, 0 );
        data.var_b6d9b1fbfc2f221e = ( 1, 0, 0 );
        data.var_e0f3e1650880f2cf = ( 1, 0.6, 0 );
    }
    
    /#
        data.debug = getdvarint( @"scr_super_mega_jump_debug", 0 ) == 1;
    #/
    
    self.megajumpdata = data;
}

// Namespace super_mega_jump
// Params 1
// Checksum 0xa8b248ce, Offset: 0xb46
// Size: 0x7c
function do_jump( jumpdata )
{
    mega_jump::set_fall_damage_reduction( 1 );
    
    if ( jumpdata.var_ed8a4d10547d554a )
    {
        thread mega_jump::function_b589a29befcba7b6( jumpdata );
    }
    
    if ( jumpdata.var_eacbf2fc79e9e24d )
    {
        thread mega_jump::function_43bf34120b60df84( jumpdata, 1 );
    }
    
    function_7ba68979645347cb( jumpdata );
    thread function_9e64cb677623b6bf();
    jumpdata.var_66d334566c265db7 = 0;
    jumpdata.jumpsucceeded = 1;
    self notify( #"hash_76158f9795c6f611" );
}

// Namespace super_mega_jump
// Params 2
// Checksum 0xdc8aeb44, Offset: 0xbca
// Size: 0x201
function function_7ba68979645347cb( jumpdata, fraction )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_81ca3283df4a7852" );
    level endon( #"game_ended" );
    fraction = fraction ?? 1;
    dir = ( 0, 0, 1 );
    var_3345c1d37f86cce0 = self getvelocity();
    speed = length2d( var_3345c1d37f86cce0 );
    maxspeed = jumpdata.var_d5c0efa15ba4c349;
    speedboost = mapfloat( 0, maxspeed, jumpdata.var_1db13b161abefa7a, jumpdata.var_4c1ed65d36e30ae8, speed );
    scriptspeedboost = getdvarfloat( @"hash_d79302fdddaf3899", 1 );
    jumpboost = mapfloat( 0, maxspeed, jumpdata.var_ea5b9ffb01601a99, jumpdata.var_56787ed479e23a53, speed );
    var_3b63803e135a4d2c = getdvarfloat( @"hash_1fce28da16db4f20", 1 );
    jumpvelocity = dir * fraction * jumpdata.jumpvelocity;
    var_3e2b66d8be0f57c7 = var_3345c1d37f86cce0 * speedboost * scriptspeedboost + jumpvelocity * jumpboost * var_3b63803e135a4d2c;
    
    /#
        if ( jumpdata.debug )
        {
            print3d( self.origin, "<dev string:x7d>" + fraction * jumpdata.jumpvelocity, ( 1, 1, 1 ), 1, 1, 400, 0 );
        }
    #/
    
    if ( jumpdata.var_1b4e0b2c23f781ca )
    {
        self setgravityscale( jumpdata.var_1b4e0b2c23f781ca );
    }
    
    if ( !jumpdata.var_d43079b5fa943d16 )
    {
        mega_jump::toggle_allows( 0 );
    }
    
    self.megajumpdata.isjumping = 1;
    waitframe();
    self jumpscripted( var_3e2b66d8be0f57c7 );
    self notify( #"hash_65e8bcca9cf92cbb" );
    self notify( #"superjump_jumped" );
}

// Namespace super_mega_jump
// Params 2
// Checksum 0x912df6bc, Offset: 0xdd3
// Size: 0x128
function function_c13b22b1d3677046( jumpdata, var_4a256b90e2572d59 )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_81ca3283df4a7852" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        canjump = mega_jump::function_73a22993dd3552d9( jumpdata ) && !function_5e4e797128f5f68b();
        jumpbutton = mega_jump::get_jump_button( jumpdata );
        
        if ( self [[ jumpbutton ]]() && !jumpdata.incooldown && jumpdata.var_66d334566c265db7 && canjump )
        {
            self disableoffhandsecondaryweapons();
            
            if ( jumpdata.jumpcharge )
            {
                mega_jump::function_e3c042b8026e2789( jumpdata, var_4a256b90e2572d59, undefined, jumpbutton );
            }
            else
            {
                do_jump( jumpdata );
            }
            
            continue;
        }
        
        while ( self [[ jumpbutton ]]() )
        {
            if ( jumpdata.var_2f73f374e23d1a57 )
            {
                self setgravityscale( jumpdata.var_2f73f374e23d1a57 );
            }
            
            waitframe();
        }
        
        if ( jumpdata.var_1b4e0b2c23f781ca )
        {
            self setgravityscale( jumpdata.var_1b4e0b2c23f781ca );
        }
        
        jumpdata.var_66d334566c265db7 = 1;
        waitframe();
    }
}

// Namespace super_mega_jump
// Params 0
// Checksum 0xbce69884, Offset: 0xf03
// Size: 0x7
function function_815cc98d0e7d0f3f()
{
    return self secondaryoffhandbuttonpressed();
}

// Namespace super_mega_jump
// Params 1, eflags: 0x4
// Checksum 0xb3bc9a2d, Offset: 0xf13
// Size: 0x54
function private function_7d8729d895632e06( jumpdata )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_81ca3283df4a7852" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"superjump_jumped" );
        thread function_9e64cb677623b6bf();
        thread function_932b0050bcd4bf10();
        return;
    }
}

// Namespace super_mega_jump
// Params 0, eflags: 0x4
// Checksum 0x6d4b746a, Offset: 0xf6f
// Size: 0x1b5
function private function_9e64cb677623b6bf()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"superjump_cancel", #"hash_81ca3283df4a7852" );
    
    while ( self isonground() )
    {
        waitframe();
    }
    
    val::set( "jump_superpower", "usability", 1 );
    val::set( "jump_superpower", "disallow_usability_but_loot", 1 );
    
    if ( !self isonground() && !self isparachuting() && !self isskydiving() && !self isswimming() )
    {
        self.megajumpdata.isfreefalling = 1;
        mega_jump::set_fall_damage_reduction( 1 );
        
        while ( player::isaliveandnotinlaststand( self ) )
        {
            if ( self isonground() || self isparachuting() || self iswingsuitdeployed() || self isswimming() || self isonladder() )
            {
                waitframe();
                break;
            }
            
            waitframe();
        }
    }
    
    self enableoffhandsecondaryweapons();
    mega_jump::set_fall_damage_reduction( 0 );
    
    if ( mega_jump::can_skydive() )
    {
        mega_jump::function_f52bb5f367da9f23( 1 );
    }
    
    mega_jump::reset_gravity( self.megajumpdata );
    
    if ( self isonground() )
    {
        mega_jump::land_on_ground( self.megajumpdata );
        self notify( #"hash_76158f9795c6f611" );
        waitframe();
    }
    
    val::set( "jump_superpower", "disallow_usability_but_loot", 0 );
    val::set( "jump_superpower", "usability", 1 );
    
    if ( self.megajumpdata )
    {
        self.megajumpdata.megajumpinprogress = undefined;
        self.megajumpdata.isjumping = undefined;
    }
    
    self.megajumpendtime = gettime();
    thread supers_mp::superusefinished( undefined, undefined, undefined, 1, undefined, undefined, #"tactical" );
}

// Namespace super_mega_jump
// Params 0, eflags: 0x4
// Checksum 0xb5ea835f, Offset: 0x112c
// Size: 0x7f
function private function_932b0050bcd4bf10()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_81ca3283df4a7852" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self isjumping() || function_5e4e797128f5f68b() )
        {
            return;
        }
        
        if ( !mega_jump::function_73a22993dd3552d9( self.megajumpdata ) || mega_jump::is_jump_blocked( self.megajumpdata ) )
        {
            function_9b0065d6803f0742( self, &"hash_537d114765de23b1" );
            thread cancel();
            return;
        }
        
        waitframe();
    }
}

// Namespace super_mega_jump
// Params 0, eflags: 0x4
// Checksum 0x80671dff, Offset: 0x11b3
// Size: 0x62
function private cancel()
{
    self notify( #"superjump_cancel" );
    self function_6bbbd0de64500d92();
    mega_jump::set_fall_damage_reduction( 0 );
    mega_jump::reset_gravity( self.megajumpdata );
    mega_jump::function_390b0ad3b5327478( self.megajumpdata );
    thread supers_mp::superusefinished( undefined, undefined, undefined, undefined, undefined, undefined, #"tactical" );
    supers_mp::refundsuper( #"tactical" );
}

// Namespace super_mega_jump
// Params 0, eflags: 0x4
// Checksum 0xb6fe1b79, Offset: 0x121d
// Size: 0x15
function private function_5e4e797128f5f68b()
{
    return self.megajumpdata.isjumping;
}

// Namespace super_mega_jump
// Params 0
// Checksum 0xaefb8424, Offset: 0x123b
// Size: 0x15
function function_d030d60e3764de0f()
{
    return self.megajumpdata.megajumpinprogress;
}

// Namespace super_mega_jump
// Params 1, eflags: 0x4
// Checksum 0xd4aed2eb, Offset: 0x1259
// Size: 0x22
function private function_1b23f732e99619b8( jumpdata )
{
    function_9b0065d6803f0742( self, &"hash_537d114765de23b1" );
    thread cancel();
}

