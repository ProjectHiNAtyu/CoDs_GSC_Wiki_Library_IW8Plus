// script_15efdb5808058ab7  (hash_15efdb5808058ab7.gscc) (size: 6895 Bytes / 0x1aef / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe087c3ff (3766993919)
// size ...... 6895 (0x1aef)
// includes .. 10  (offset: 0x18f3)
// strings ... 22  (offset: 0x1943)
// dev strs .. 11  (offset: 0x1a6b)
// exports ... 20  (offset: 0xdaf)
// cseg ...... 0x1bf + 0xbf0 (0xdaf)
// imports ... 72  (offset: 0x10cf)
// animtree1 . 0   (offset: 0x1aef)
// animtree2 . 0   (offset: 0x1aef)
#using script_16ea1b94f0f381b3;
#using script_193e3e231841082f;
#using script_75cfaf905999d816;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\mp_agent_damage;

#namespace namespace_473bdc208d3e708a;

// Namespace namespace_473bdc208d3e708a
// Params 0
// Checksum 0x8975b99b, Offset: 0x1dd
// Size: 0x153
function init_spittle()
{
    self.var_89e47b7d790b5459 = 0;
    self.var_6023f91de2a2a578 = [];
    var_4912869f02b165bf = [[ self.var_24610c747736231e ]]();
    
    for ( var_4d54160378fa19cf = 0; var_4d54160378fa19cf < 6 ; var_4d54160378fa19cf++ )
    {
        self.var_6023f91de2a2a578[ var_4d54160378fa19cf ] = spawn( "script_model", self.origin );
        self.var_6023f91de2a2a578[ var_4d54160378fa19cf ] setmodel( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_1a59c79d833ed5af );
        self.var_6023f91de2a2a578[ var_4d54160378fa19cf ].var_d62ad5bfd64ba592 = "tag_origin";
        self.var_6023f91de2a2a578[ var_4d54160378fa19cf ].var_f39d8960915f9a15 = self;
        self.var_6023f91de2a2a578[ var_4d54160378fa19cf ] callback::add( "homing_ball_hit_character", &function_9d02c3f74af350ab );
        namespace_62d6417c8f47a982::function_825925e0a97eedb7( self.var_6023f91de2a2a578[ var_4d54160378fa19cf ] );
        
        if ( var_4912869f02b165bf < 7 )
        {
            namespace_62d6417c8f47a982::function_9d6fcfde1a685656( self.var_6023f91de2a2a578[ var_4d54160378fa19cf ], 80, 12, 150 );
            continue;
        }
        
        namespace_62d6417c8f47a982::function_9d6fcfde1a685656( self.var_6023f91de2a2a578[ var_4d54160378fa19cf ], 100, 24, 200 );
    }
    
    thread function_38ac0395ebeb15fd();
    thread function_d6021a128c86f3a2();
    thread function_1ae7e61fc81aea8c();
    
    /#
        function_7e0acc3880a7ac1b();
    #/
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0xd0e0d5af, Offset: 0x338
// Size: 0x2a
function private function_1ae7e61fc81aea8c()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"spittle_start" );
        function_9aa760a719da279a();
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0x4cebc0c7, Offset: 0x36a
// Size: 0x6f
function private function_9aa760a719da279a()
{
    thread utility::thread_on_notify( "spawn_spittle_ball", &function_b06fd34c3eff741b, self, self, "spittle_end" );
    thread utility::thread_on_notify( "release_ents_in_mouth", &function_a6ad0ce7e41a4f7e, self, self, "spittle_end" );
    thread utility::thread_on_notify( "open_mouth_spittle", &on_open_mouth, self );
    ai::set_blackboard_cooldown( "spittle_cooldown", getdvarint( @"worm_spittle_cooldown", 25000 ) );
    
    /#
        spittle_print( "<dev string:x24>" );
    #/
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0xfcaaa6d1, Offset: 0x3e1
// Size: 0x109
function private function_b06fd34c3eff741b()
{
    function_f4a77d5d66639ff4();
    var_f06c3d8143b76949 = self gettagorigin( "tag_fx_mouth" );
    var_6742ddc637543391 = getdvarfloat( @"hash_d03ff094337507bb", 250 );
    var_bab22379463b4591 = getdvarfloat( @"hash_49eef1dc7ee5f947", 50 );
    targets = get_spittle_targets();
    var_c192abbbd3f14fcb = targets.size;
    
    if ( self.var_6005157a6615b97f > 1 )
    {
        var_c192abbbd3f14fcb = max( 4, var_c192abbbd3f14fcb );
    }
    
    var_c192abbbd3f14fcb = clamp( var_c192abbbd3f14fcb, 2, 6 );
    
    if ( self.disable_spittle )
    {
        var_c192abbbd3f14fcb = 0;
    }
    
    for ( var_4d54160378fa19cf = 0; var_4d54160378fa19cf < var_c192abbbd3f14fcb ; var_4d54160378fa19cf++ )
    {
        var_4afaff7eba049a9b = function_2e2530da63d333b8( var_bab22379463b4591, var_4d54160378fa19cf, var_c192abbbd3f14fcb );
        target = targets.size <= 0 ? undefined : targets[ var_4d54160378fa19cf % targets.size ];
        setup_spittle_ball_spawn( self.var_6023f91de2a2a578[ var_4d54160378fa19cf ], var_4afaff7eba049a9b, var_6742ddc637543391, var_f06c3d8143b76949, target );
        wait 0.1;
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0xd517acd6, Offset: 0x4f2
// Size: 0x9
function private function_a6ad0ce7e41a4f7e()
{
    function_f4a77d5d66639ff4();
}

// Namespace namespace_473bdc208d3e708a
// Params 5, eflags: 0x4
// Checksum 0xf039f72a, Offset: 0x503
// Size: 0x11d
function private setup_spittle_ball_spawn( ball, velocity, var_6742ddc637543391, var_f06c3d8143b76949, target_ent )
{
    ball utility::function_32b24db3127bff40( "spittle", "spittle_on" );
    ball dontinterpolate();
    ball.origin = var_f06c3d8143b76949 + anglestoforward( self.angles ) * 150;
    ball namespace_62d6417c8f47a982::function_e47e242b17d4abc3( velocity, getdvarfloat( @"hash_829137421b9a9889", 3 ), var_6742ddc637543391 );
    
    if ( isdefined( target_ent ) )
    {
        namespace_62d6417c8f47a982::set_target_ent( ball, target_ent );
    }
    
    ball setcandamage( 1 );
    ball solid();
    ball.var_2b5852f808241817 = getdvarint( @"hash_2851a67e797b5352", 50 );
    ball.maxhealth = 10000;
    ball.health = ball.maxhealth;
    ball.team = self.team;
    ball thread function_faf7815361b217d7();
    ball.ball_spawn_time = gettime();
    self.var_89e47b7d790b5459++;
}

// Namespace namespace_473bdc208d3e708a
// Params 4, eflags: 0x4
// Checksum 0x65d7c889, Offset: 0x628
// Size: 0xce
function private function_2e2530da63d333b8( var_bab22379463b4591, var_4d54160378fa19cf, num_to_spawn, use_current_speed )
{
    initial_forward_speed = getdvarfloat( @"hash_819a621ebc0c490a", 500 );
    var_ae2a3a25b259d063 = getdvarfloat( @"hash_e9a5f6f18ff08271", 100 );
    var_5c936623cd11d232 = var_4d54160378fa19cf * var_bab22379463b4591 / num_to_spawn - var_bab22379463b4591 * 0.5;
    forward_vec = anglestoforward( self.angles + ( 0, var_5c936623cd11d232, 0 ) );
    velocity = forward_vec * initial_forward_speed + ( 0, 0, -1 ) * var_ae2a3a25b259d063;
    
    if ( use_current_speed )
    {
        velocity = vectornormalize( velocity ) * length( self.var_392df2a13f5c07f7 );
    }
    
    return velocity;
}

// Namespace namespace_473bdc208d3e708a
// Params 1, eflags: 0x4
// Checksum 0xa7e34f5f, Offset: 0x6ff
// Size: 0x171
function private function_9d02c3f74af350ab( params )
{
    var_90ec0886f9ccf215 = params.var_14e87d44408dd566;
    
    if ( !isdefined( var_90ec0886f9ccf215 ) )
    {
        return;
    }
    
    if ( self.origin[ 2 ] < var_90ec0886f9ccf215.origin[ 2 ] )
    {
        self.origin = ( self.origin[ 0 ], self.origin[ 1 ], var_90ec0886f9ccf215.origin[ 2 ] );
        return;
    }
    
    if ( utility::ent_flag( "hit_character" ) )
    {
        return;
    }
    
    spittle_damage = 30;
    
    if ( self.var_f39d8960915f9a15.use_lethal_attacks && self.var_f39d8960915f9a15.var_6005157a6615b97f >= 7 )
    {
        spittle_damage = 60;
        
        if ( self.var_f39d8960915f9a15.var_6005157a6615b97f >= 13 )
        {
            spittle_damage = max( spittle_damage, var_90ec0886f9ccf215.health * 0.5 );
        }
    }
    
    var_90ec0886f9ccf215 dodamage( spittle_damage, self.origin, self, self, "MOD_IMPACT" );
    utility::ent_flag_set( "hit_character" );
    thread utility::ent_flag_clear_delayed( "hit_character", 2 );
    
    if ( isplayer( var_90ec0886f9ccf215 ) )
    {
        currentstate = var_90ec0886f9ccf215 getscriptablepartstate( "deathwormVFX", 1 );
        
        if ( isdefined( currentstate ) && currentstate != "swallowed" )
        {
            var_90ec0886f9ccf215 utility::function_32b24db3127bff40( "deathwormVFX", "hit_by_spittle" );
        }
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0x5c00b040, Offset: 0x878
// Size: 0x17f
function private function_faf7815361b217d7()
{
    self endon( #"death" );
    
    while ( true )
    {
        waitframe();
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        dmgstruct = zombie_damage::build_damage_struct( inflictor, attacker, damage, idflags, meansofdeath, undefined, point, direction_vec, undefined, undefined, undefined, undefined, objweapon );
        damage = zombie_damage::function_881dfa87252ee0ea( dmgstruct );
        self.var_2b5852f808241817 -= damage;
        var_c57ed7c52106c0f3 = 0;
        
        if ( self.var_2b5852f808241817 <= 0 )
        {
            function_c53b95c9159978a8();
            var_c57ed7c52106c0f3 = 1;
        }
        
        if ( isplayer( attacker ) )
        {
            attacker namespace_9d8e359c3b1041e5::updatehitmarker_sharedfunc( "standard", var_c57ed7c52106c0f3 );
            
            if ( mp_agent_damage::function_e7d118eb7b017fa4() )
            {
                namespace_9d8e359c3b1041e5::displaydamagenumber_sharedfunc( attacker, self, "none", meansofdeath, objweapon, int( damage ), self.origin, 0, undefined, 0, 0 );
            }
        }
        
        /#
            spittle_print( "<dev string:x32>" + self.health, self.origin );
        #/
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0xb6e14029, Offset: 0x9ff
// Size: 0x6a
function private function_c53b95c9159978a8()
{
    utility::function_32b24db3127bff40( "spittle", "spittle_impact" );
    namespace_62d6417c8f47a982::function_6299c776502742fa( self );
    self setcandamage( 0 );
    self notsolid();
    self.var_2b5852f808241817 = 0;
    
    if ( isdefined( self.var_f39d8960915f9a15 ) && isdefined( self.var_f39d8960915f9a15.var_89e47b7d790b5459 ) )
    {
        self.var_f39d8960915f9a15.var_89e47b7d790b5459--;
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0x51242982, Offset: 0xa71
// Size: 0x41
function private on_open_mouth()
{
    self endon( #"death" );
    utility::function_7c10ea82c1e305b8( "mouth", "spittle" );
    utility::waittill_multiple( "close_mouth_spittle", "spittle_end" );
    utility::function_7c10ea82c1e305b8( "mouth", "off" );
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0x3080ce8a, Offset: 0xaba
// Size: 0x65
function private function_38ac0395ebeb15fd()
{
    balls = self.var_6023f91de2a2a578;
    self waittill( #"death" );
    
    for ( var_4d54160378fa19cf = 0; var_4d54160378fa19cf < 6 ; var_4d54160378fa19cf++ )
    {
        balls[ var_4d54160378fa19cf ] function_c53b95c9159978a8();
    }
    
    wait 2;
    
    for ( var_4d54160378fa19cf = 0; var_4d54160378fa19cf < 6 ; var_4d54160378fa19cf++ )
    {
        balls[ var_4d54160378fa19cf ] delete();
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0x35433104, Offset: 0xb27
// Size: 0x89
function private function_d6021a128c86f3a2()
{
    self endon( #"death" );
    
    while ( true )
    {
        for ( var_4d54160378fa19cf = 0; var_4d54160378fa19cf < 6 ; var_4d54160378fa19cf++ )
        {
            ball = self.var_6023f91de2a2a578[ var_4d54160378fa19cf ];
            
            if ( ball.var_2b5852f808241817 > 0 )
            {
                time_alive = gettime() - ball.ball_spawn_time;
                
                if ( time_alive > 120000 )
                {
                    ball function_c53b95c9159978a8();
                }
            }
            
            waitframe();
        }
        
        wait 30;
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0xcf8ad9e, Offset: 0xbb8
// Size: 0xb7
function private get_spittle_targets()
{
    var_67f9e5a5f6aed92 = 2000;
    potential_targets = self function_f017e352a29a57a1( self.origin, var_67f9e5a5f6aed92, 1 );
    filtered_targets = [];
    
    foreach ( target in potential_targets )
    {
        if ( !target.damageshield )
        {
            filtered_targets[ filtered_targets.size ] = target;
        }
    }
    
    return filtered_targets;
}

/#

    // Namespace namespace_473bdc208d3e708a
    // Params 0
    // Checksum 0xbb5db44f, Offset: 0xc78
    // Size: 0x44, Type: dev
    function function_7e0acc3880a7ac1b()
    {
        devgui::function_9082edeb5db93280( "<dev string:x3b>" );
        devgui::add_devgui_func( "<dev string:x57>", "<dev string:x65>", &force_spittle );
        devgui::add_devgui_func( "<dev string:x73>", "<dev string:x81>", &function_7e420dfeb5c2a3ac );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_473bdc208d3e708a
    // Params 0, eflags: 0x4
    // Checksum 0xb10fdc2f, Offset: 0xcc4
    // Size: 0x48, Type: dev
    function private force_spittle()
    {
        var_79481b4b9f445f8f = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x8f>" );
        
        if ( !isdefined( var_79481b4b9f445f8f ) )
        {
            return;
        }
        
        var_79481b4b9f445f8f function_786bb6aa1b76c7ee( "<dev string:xa0>", 1 );
    }

    // Namespace namespace_473bdc208d3e708a
    // Params 0, eflags: 0x4
    // Checksum 0x1ff5a1a4, Offset: 0xd14
    // Size: 0x16, Type: dev
    function private debug_spittle()
    {
        return getdvarint( @"hash_c4c95fbc22ee699", 0 ) > 0;
    }

    // Namespace namespace_473bdc208d3e708a
    // Params 0, eflags: 0x4
    // Checksum 0x97d9c512, Offset: 0xd32
    // Size: 0x1a, Type: dev
    function private function_7e420dfeb5c2a3ac()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xab>", @"hash_c4c95fbc22ee699" );
    }

    // Namespace namespace_473bdc208d3e708a
    // Params 2, eflags: 0x4
    // Checksum 0xbf5bcc4e, Offset: 0xd54
    // Size: 0x5b, Type: dev
    function private spittle_print( text, pos )
    {
        if ( debug_spittle() )
        {
            if ( !isdefined( pos ) )
            {
                pos = self.origin + ( 0, 0, 70 );
            }
            
            print3d( pos, "<dev string:xc3>" + text, ( 1, 0, 0 ) );
        }
    }

#/
