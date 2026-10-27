// script_4ca4034d0b68a7d4  (hash_4ca4034d0b68a7d4.gscc) (size: 8596 Bytes / 0x2194 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x55b42d49 (1437871433)
// size ...... 8596 (0x2194)
// includes .. 8   (offset: 0x1fa4)
// strings ... 22  (offset: 0x1fe4)
// dev strs .. 7   (offset: 0x2140)
// exports ... 24  (offset: 0x12f0)
// cseg ...... 0x231 + 0x10bf (0x12f0)
// imports ... 77  (offset: 0x16b0)
// animtree1 . 0   (offset: 0x2194)
// animtree2 . 0   (offset: 0x2194)
#using script_437ee0f94301721b;
#using script_bdb08507b3b7b94;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\zm\systems\zm_quest;

#namespace zombie_uranus_toxic_mouth;

// Namespace zombie_uranus_toxic_mouth
// Params 1
// Checksum 0x3fad3ee, Offset: 0x24f
// Size: 0x48
function function_2b091127547f62bc( aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( settings )
    {
        utility::add_fx( "zmb_uranus_toxic_screen_vfx", settings.var_4ceff682015dba3f );
    }
    
    /#
        devgui_init( settings );
    #/
}

// Namespace zombie_uranus_toxic_mouth
// Params 0
// Checksum 0x2c54d9c5, Offset: 0x29f
// Size: 0x69
function init_uranus_toxic_mouth()
{
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    zombie_uranus::register_cool_down( #"hash_3ba3d061e1acd462", settings.var_803418f96ddee261 );
    thread setup_uranus_mouth();
    zombie_uranus::register_can_use_skill( "uranus_skill_toxic", &can_toxic_attack );
    callback::add( #"on_ai_killed", &function_4c3c58b0ad321dd0 );
}

// Namespace zombie_uranus_toxic_mouth
// Params 0, eflags: 0x4
// Checksum 0xc3fc9269, Offset: 0x310
// Size: 0xc2
function private setup_uranus_mouth()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    waitframe();
    mouthorigin = self gettagorigin( "tag_mouth_fx", 1 ) ?? self.origin;
    self.uranus_mouth = utility::spawn_model( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_a45c2f4239faf628, mouthorigin );
    
    if ( utility::hastag( self.model, "tag_mouth_fx" ) )
    {
        self.uranus_mouth linkto( self, "tag_mouth_fx", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    thread utility::delete_on_death( self.uranus_mouth );
}

// Namespace zombie_uranus_toxic_mouth
// Params 1
// Checksum 0xcce7ead7, Offset: 0x3da
// Size: 0x8f
function function_4c3c58b0ad321dd0( params )
{
    foreach ( fog in self.var_cffd1bde314455c8 )
    {
        thread cleanup_fog( fog );
    }
    
    self.var_cffd1bde314455c8 = [];
}

// Namespace zombie_uranus_toxic_mouth
// Params 1
// Checksum 0xd1efa6ee, Offset: 0x471
// Size: 0x120
function function_8c6745c1b20befa3( target )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self.var_d0f992708a5b0e59 = 1;
    
    if ( !isdefined( self.var_cffd1bde314455c8 ) )
    {
        self.var_cffd1bde314455c8 = [];
    }
    
    zombie_uranus::start_cool_down( #"hash_61ccd92bbf0ca313" );
    zombie_uranus::start_cool_down( #"hash_3ba3d061e1acd462" );
    zombie_uranus::do_action( "uranus_toxic_mouth" );
    thread function_3240f60597cc343b();
    
    if ( randomint( 100 ) < 20 )
    {
        level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_eab78f27471b687f" ] );
    }
    
    msg = utility::waittill_any_return( "uranus_toxic_charge_end", "uranus_damaged" );
    
    if ( msg == "uranus_damaged" )
    {
        function_767a0657a0a9788();
        return;
    }
    
    function_d47f39c122c791fb( self, self.uranus_mouth.origin );
    wait 5;
    asm::asm_fireevent( self.asmname, "exit_loop" );
    function_767a0657a0a9788();
}

// Namespace zombie_uranus_toxic_mouth
// Params 3
// Checksum 0xc46eee4c, Offset: 0x599
// Size: 0x132
function function_d47f39c122c791fb( owner, start_pos, duration_end_notify )
{
    positions = utility::callsharedfunc( #"zombie_uranus", #"hash_5da8be93e88c8fb" );
    settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
    
    for ( i = 0; i < positions.size ; i++ )
    {
        fog = utility::spawn_model( settings.var_a45c2f4239faf628, start_pos );
        fog.radius = settings.var_a0fbdc2f075470d6;
        fog.height = settings.var_4ea52655f3dba4b;
        fog.owner = owner;
        
        if ( owner.var_cffd1bde314455c8 )
        {
            owner.var_cffd1bde314455c8[ owner.var_cffd1bde314455c8.size ] = fog;
        }
        
        fog thread function_4dc3c7d08f0ea3c7( positions[ i ], start_pos, duration_end_notify );
    }
    
    utility::callsharedfunc( #"zombie_uranus", #"hash_60b929ba0ef8ba4e", settings.lightingtoxic );
}

// Namespace zombie_uranus_toxic_mouth
// Params 0, eflags: 0x4
// Checksum 0xcb0af9bf, Offset: 0x6d3
// Size: 0x7a
function private function_3240f60597cc343b()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"uranus_damaged" );
    self.uranus_mouth utility::function_32b24db3127bff40( "fog_source", "vfx_on" );
    self asmsetstate( self.asmname, "toxic_attack_intro" );
    introlength = zombie_uranus_asm::get_anim_length( "toxic_attack_intro" );
    wait introlength;
    self notify( #"uranus_toxic_charge_end" );
}

// Namespace zombie_uranus_toxic_mouth
// Params 0, eflags: 0x4
// Checksum 0x6b62a0bd, Offset: 0x755
// Size: 0x32
function private function_767a0657a0a9788()
{
    self.uranus_mouth utility::function_32b24db3127bff40( "fog_source", "vfx_off" );
    self.var_d0f992708a5b0e59 = 0;
    zombie_uranus::end_action( "uranus_toxic_mouth" );
}

// Namespace zombie_uranus_toxic_mouth
// Params 3
// Checksum 0x31c25409, Offset: 0x78f
// Size: 0x1f1
function function_4dc3c7d08f0ea3c7( target, start_pos, duration_end_notify )
{
    self notify( #"hash_19948d9636670fb" );
    self endon( #"hash_19948d9636670fb" );
    level endon( #"game_ended" );
    fog = self;
    owner = fog.owner;
    
    if ( isalive( owner ) )
    {
        owner endon( #"death" );
    }
    
    settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
    fog utility::function_32b24db3127bff40( "fog_around", "vfx_on" );
    tgtpos = utility::drop_to_ground( target.origin, 50, -1000 );
    fog.targetpos = tgtpos;
    
    /#
        if ( is_debug_draw_fog() )
        {
            fog thread debug_draw_fog();
        }
    #/
    
    mover = utility::spawn_model( "tag_origin", start_pos );
    
    if ( isalive( owner ) )
    {
        owner thread utility::delete_on_death( mover );
    }
    
    fog.mover = mover;
    fog linkto( mover, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    mover moveto( tgtpos, settings.var_3ac2d335aedf9802 );
    wait settings.var_3ac2d335aedf9802;
    fog.effective = 1;
    fog thread function_da39b764d6df0feb( tgtpos, settings.var_abcb5b0c08553b50, duration_end_notify );
    fog childthread function_e6ec77bfe3b6c666();
    
    if ( duration_end_notify )
    {
        level waittill( duration_end_notify );
    }
    else
    {
        wait settings.var_abcb5b0c08553b50;
    }
    
    fog notify( #"hash_b57d8ccbd9bd829" );
    fog.effective = 0;
    fog utility::function_32b24db3127bff40( "fog_around", "vfx_off" );
    wait 2;
    cleanup_fog( fog );
}

// Namespace zombie_uranus_toxic_mouth
// Params 1
// Checksum 0xdec2fa7, Offset: 0x988
// Size: 0x106
function cleanup_fog( fog )
{
    if ( !fog )
    {
        return;
    }
    
    owner = fog.owner;
    phase = owner.phase ?? 1;
    settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
    utility::callsharedfunc( #"zombie_uranus", #"hash_60b929ba0ef8ba4e", settings.phase_list[ phase - 1 ].lighting );
    fog utility::function_32b24db3127bff40( "fog_around", "vfx_off" );
    
    if ( fog.mover )
    {
        fog unlink();
        fog.mover delete();
        fog.mover = undefined;
    }
    
    if ( owner )
    {
        owner.var_cffd1bde314455c8 = arrayremove( owner.var_cffd1bde314455c8, fog );
    }
    
    fog delete();
}

// Namespace zombie_uranus_toxic_mouth
// Params 3, eflags: 0x4
// Checksum 0xffb8685f, Offset: 0xa96
// Size: 0xfd
function private function_da39b764d6df0feb( pos, duration, duration_end_notify )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
    mdl = utility::spawn_model( settings.var_a45c2f4239faf628, pos );
    mdl endon( #"death" );
    
    if ( isalive( self.owner ) )
    {
        self.owner thread utility::delete_on_death( mdl );
    }
    
    mdl utility::function_32b24db3127bff40( "fog_center", "vfx_on" );
    
    if ( duration_end_notify )
    {
        level waittill( duration_end_notify );
    }
    else
    {
        wait duration;
    }
    
    mdl utility::function_32b24db3127bff40( "fog_center", "vfx_disappear" );
    wait 2;
    mdl utility::function_32b24db3127bff40( "fog_center", "vfx_off" );
    wait 1;
    mdl delete();
}

// Namespace zombie_uranus_toxic_mouth
// Params 0, eflags: 0xc
// Checksum 0xe177dfc7, Offset: 0xb9b
// Size: 0x11f
function private function_e6ec77bfe3b6c666()
{
    self notify( #"hash_49a3efe2384398d5" );
    self endon( #"hash_49a3efe2384398d5" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_b57d8ccbd9bd829" );
    wait 1;
    
    while ( self.effective )
    {
        targets = self.owner function_f017e352a29a57a1( self.origin, self.radius, 1 );
        
        foreach ( target in targets )
        {
            if ( target.origin[ 2 ] > self.origin[ 2 ] + self.height )
            {
                continue;
            }
            
            target thread function_804ce0dc3e919a40( self );
        }
        
        wait 0.5;
    }
}

// Namespace zombie_uranus_toxic_mouth
// Params 1, eflags: 0xc
// Checksum 0x6c08012b, Offset: 0xcc2
// Size: 0x2b7
function private function_804ce0dc3e919a40( fog )
{
    self notify( #"hash_936ca0ecb500ede6" );
    self endon( #"hash_936ca0ecb500ede6" );
    level endon( #"game_ended" );
    settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
    
    if ( !self.var_4cc711f5f376523f )
    {
        thread utility::callsharedfunc( #"zombie_uranus", #"hash_97a8f5361cf37a44", fog );
        thread utility::callsharedfunc( #"zombie_uranus", #"hash_918c6230c5839b4d", fog );
        self.var_4cc711f5f376523f = 1;
        
        if ( !isdefined( self.var_a14384aecdfda93c ) )
        {
            self.var_a14384aecdfda93c = self.maxhealth;
        }
        
        ratio = 1 - settings.var_bcaea73055ae94db;
        self.maxhealth = int( self.var_a14384aecdfda93c * ratio );
        self.health = min( self.health, self.maxhealth );
        
        if ( self.health > 1 )
        {
            health = self.health;
            self dodamage( 1, self.origin, self, undefined, "MOD_TRIGGER_HURT" );
            self playlocalsound( "evt_ai_uranus_toxic_fog_plr_hit" );
            self.health = health;
        }
        
        fx = utility::getfx( "zmb_uranus_toxic_screen_vfx" );
        playfxontagforclients( fx, self, "tag_eye", self );
        
        if ( settings.toxicpostfx )
        {
            pbgpostfxbundlestart( self, settings.toxicpostfx );
            self playlocalsound( "evt_toxic_fog_hallucination_start_plr" );
            self playloopsound( "evt_toxic_fog_hallucination_lp_plr" );
        }
    }
    
    utility::waittill_any_timeout( 3, "death_or_disconnect" );
    
    if ( self )
    {
        self notify( #"hash_5a198408c604399c" );
        utility::callsharedfunc( #"zombie_uranus", #"hash_42c16ac0465085db" );
        utility::callsharedfunc( #"zombie_uranus", #"hash_7f15bcf85cab1554" );
        fx = utility::getfx( "zmb_uranus_toxic_screen_vfx" );
        stopfxontagforclients( fx, self, "tag_eye", self );
        
        if ( settings.toxicpostfx )
        {
            pbgpostfxbundleend( self, settings.toxicpostfx );
            self stoploopsound( "evt_toxic_fog_hallucination_lp_plr" );
            self playlocalsound( "evt_toxic_fog_hallucination_stop_plr" );
        }
        
        self.maxhealth = self.var_a14384aecdfda93c;
        
        if ( self.health < self.maxhealth )
        {
            self.health += 1;
            self dodamage( 1, self.origin, self, undefined, "MOD_TRIGGER_HURT" );
        }
        
        self.var_4cc711f5f376523f = 0;
    }
}

// Namespace zombie_uranus_toxic_mouth
// Params 0
// Checksum 0x81ceff3a, Offset: 0xf81
// Size: 0x66, Type: bool
function can_toxic_attack()
{
    /#
        if ( getdvarint( @"hash_3cd98fdd1a0c1444" ) )
        {
            return false;
        }
    #/
    
    if ( !zombie_uranus::function_420be0b5922e064b() )
    {
        return false;
    }
    
    if ( zombie_uranus::get_phase() < 3 )
    {
        return false;
    }
    
    if ( self.var_d0f992708a5b0e59 )
    {
        return false;
    }
    
    if ( self.var_cffd1bde314455c8.size > 0 )
    {
        return false;
    }
    
    if ( zombie_uranus::has_cool_down( #"hash_3ba3d061e1acd462" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_uranus_toxic_mouth
// Params 2
// Checksum 0x731122af, Offset: 0xff0
// Size: 0x51
function function_83f1269dbec675ef( taskid, params )
{
    targets = zombie_uranus::get_random_targets( 0, 1 );
    
    if ( targets.size == 0 )
    {
        return anim.failure;
    }
    
    self.toxictarget = targets[ 0 ];
    return anim.success;
}

// Namespace zombie_uranus_toxic_mouth
// Params 2
// Checksum 0xe826495, Offset: 0x104a
// Size: 0x2e
function function_ea528c7045c55d38( taskid, params )
{
    thread function_8c6745c1b20befa3( self.toxictarget );
    return anim.success;
}

// Namespace zombie_uranus_toxic_mouth
// Params 2
// Checksum 0xf9b74668, Offset: 0x1081
// Size: 0x34
function function_6dc7a9b5536d738b( taskid, params )
{
    if ( self.var_d0f992708a5b0e59 )
    {
        return anim.running;
    }
    
    return anim.success;
}

/#

    // Namespace zombie_uranus_toxic_mouth
    // Params 1
    // Checksum 0xad479836, Offset: 0x10be
    // Size: 0x66, Type: dev
    function devgui_init( settings )
    {
        level.var_aee0efe9a0123a89 = settings;
        devgui::function_9082edeb5db93280( "<dev string:x24>" + "<dev string:x48>" );
        devgui::add_devgui_func( "<dev string:x55>", "<dev string:x61>", &function_e8638ebf8433596c, undefined, 40 );
        devgui::add_devgui_func( "<dev string:x74>", "<dev string:x86>", &function_402f18e5ff45a82, 1, 41 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_uranus_toxic_mouth
    // Params 0, eflags: 0x4
    // Checksum 0xb00c3aae, Offset: 0x112c
    // Size: 0x2e, Type: dev
    function private function_e8638ebf8433596c()
    {
        Uranus = level.debug_uranus;
        Uranus thread function_8c6745c1b20befa3( level.players[ 0 ] );
    }

    // Namespace zombie_uranus_toxic_mouth
    // Params 0, eflags: 0x4
    // Checksum 0x2626bbb5, Offset: 0x1162
    // Size: 0x13, Type: dev
    function private is_debug_draw_fog()
    {
        return getdvarint( @"hash_f997cbd2e1865ce1" );
    }

    // Namespace zombie_uranus_toxic_mouth
    // Params 0, eflags: 0x4
    // Checksum 0xfbe8bf06, Offset: 0x117d
    // Size: 0x4f, Type: dev
    function private function_402f18e5ff45a82()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xa2>", @"hash_f997cbd2e1865ce1" );
        
        if ( is_debug_draw_fog() && level.debug_uranus )
        {
            level.debug_uranus thread debug_draw();
            return;
        }
        
        level endon( #"hash_f89e58f58f0e8471" );
    }

    // Namespace zombie_uranus_toxic_mouth
    // Params 0, eflags: 0x4
    // Checksum 0x5ca9b822, Offset: 0x11d4
    // Size: 0x5d, Type: dev
    function private debug_draw()
    {
        level endon( #"game_ended" );
        level endon( #"hash_f89e58f58f0e8471" );
        self endon( #"death" );
        
        while ( true )
        {
            sphere( self.uranus_mouth.origin, 300, ( 1, 0, 0 ), 0, 1 );
            waitframe();
        }
    }

    // Namespace zombie_uranus_toxic_mouth
    // Params 0, eflags: 0xc
    // Checksum 0x2541d0a2, Offset: 0x1239
    // Size: 0xb7, Type: dev
    function private debug_draw_fog()
    {
        self notify( #"hash_b604bf77dbaa1ac7" );
        self endon( #"hash_b604bf77dbaa1ac7" );
        level endon( #"game_ended" );
        self endon( #"death" );
        
        while ( true )
        {
            color = self.effective ? ( 0, 1, 0 ) : ( 0.5, 0.5, 0.5 );
            utility::draw_circle( self.origin, self.radius, color, 1, 0, 1 );
            line( self.origin, self.targetpos, ( 0, 1, 0 ) );
            waitframe();
        }
    }

#/
