// scripts\common\ai\aitypes\zombie_callisto\zombie_callisto_zombees.gsc  (hash_33fa4c207bbcdc40.gscc) (size: 8406 Bytes / 0x20d6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2fc121ea (801186282)
// size ...... 8406 (0x20d6)
// includes .. 12  (offset: 0x1eb6)
// strings ... 26  (offset: 0x1f16)
// dev strs .. 10  (offset: 0x205e)
// exports ... 21  (offset: 0x1222)
// cseg ...... 0x213 + 0x100f (0x1222)
// imports ... 81  (offset: 0x156a)
// animtree1 . 0   (offset: 0x20d6)
// animtree2 . 0   (offset: 0x20d6)
#using script_16ea1b94f0f381b3;
#using script_75cfaf905999d816;
#using script_7c2e89079a7b7f97;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\status_effects\status_effects;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\mp_agent_damage;

#namespace zombie_callisto_zombees;

// Namespace zombie_callisto_zombees
// Params 0
// Checksum 0x2c040227, Offset: 0x231
// Size: 0x3e
function function_480aceb42c1bc321()
{
    /#
        setup_zombees_devgui();
    #/
    
    level callback::add( "on_healingaura_healed", &function_12dce3dab813d5d4 );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &function_291175cbb5dc9a90 );
}

// Namespace zombie_callisto_zombees
// Params 1
// Checksum 0x6dd16e2, Offset: 0x277
// Size: 0x18
function function_12dce3dab813d5d4( params )
{
    self notify( #"healing_aura_activated" );
}

// Namespace zombie_callisto_zombees
// Params 0
// Checksum 0x56031b2f, Offset: 0x297
// Size: 0x3f3
function init_zombie_callisto_zombees()
{
    self.active_bees = 0;
    self.var_49d756f6c3af84e9 = [];
    self function_786bb6aa1b76c7ee( "zombeesattack_cooldown", int( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.zombeescooldown * 1000 ) );
    self function_786bb6aa1b76c7ee( "zombeesattack_maxrange", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.zombeesattackrange );
    self function_786bb6aa1b76c7ee( "zombeesattack_canattack", 1 );
    self.var_1e5a69b47d416c23 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3826bbd4a54bd97 / 100;
    self.var_b9d5600c52d29c40 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f3ada42a68c2ee05;
    
    for ( var_4d54160378fa19cf = 0; var_4d54160378fa19cf < 2 ; var_4d54160378fa19cf++ )
    {
        self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ] = spawn( "script_model", self.origin );
        self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ] setmodel( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.zombeesmodel );
        self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ] notsolid();
        self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ] hide();
        self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ] setnonstick( 1 );
        self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ].var_d62ad5bfd64ba592 = "tag_origin";
        self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ].owner = self;
        self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ].isactive = 0;
        self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ].beesdps = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.zombeesdps * ( self.var_fe048a2106d8ef00[ #"zombees_damage" ] ?? 1 );
        self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ].duration = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.zombeesduration;
        self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ].var_30d41208260198b1 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_324a6bb5b0f47b7 * self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_324a6bb5b0f47b7;
        self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ].hitmovespeedscale = 1 - self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_a23f0eff98de4957;
        self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ].var_fbee4018bf39e009 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_b298d914e9f0fa23;
        self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ] callback::add( "homing_ball_hit_character", &function_a7bd2bbb9886d587 );
        namespace_62d6417c8f47a982::function_825925e0a97eedb7( self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ] );
        namespace_62d6417c8f47a982::enable_vehicle_collision( self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ] );
        namespace_62d6417c8f47a982::function_9d6fcfde1a685656( self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ], self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9fdc37618598890, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.zombeesacceleration, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_85d5240d7f598fae, 2000 );
        namespace_62d6417c8f47a982::function_192e744d83b3f2aa( self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ], self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_1eb562771f65c6db );
        namespace_62d6417c8f47a982::function_f209b09df560f7db( self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ], 1 );
    }
    
    thread bees_listener();
}

// Namespace zombie_callisto_zombees
// Params 2
// Checksum 0x3edb5270, Offset: 0x692
// Size: 0x21, Type: bool
function function_fdb6e29486445e7c( taskid, params )
{
    return self.active_bees < 2;
}

// Namespace zombie_callisto_zombees
// Params 0
// Checksum 0x6aaf1b3d, Offset: 0x6bc
// Size: 0x30
function function_f6c84cfcf2964ef0()
{
    for ( var_4d54160378fa19cf = 0; var_4d54160378fa19cf < 2 ; var_4d54160378fa19cf++ )
    {
        self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ] function_34f385a6d43f64bb();
    }
}

// Namespace zombie_callisto_zombees
// Params 1, eflags: 0x4
// Checksum 0x6f0eec6f, Offset: 0x6f4
// Size: 0x4e
function private function_291175cbb5dc9a90( params )
{
    if ( !isdefined( self.var_49d756f6c3af84e9 ) )
    {
        return;
    }
    
    function_f6c84cfcf2964ef0();
    
    for ( var_4d54160378fa19cf = 0; var_4d54160378fa19cf < 2 ; var_4d54160378fa19cf++ )
    {
        self.var_49d756f6c3af84e9[ var_4d54160378fa19cf ] delete();
    }
}

// Namespace zombie_callisto_zombees
// Params 0, eflags: 0x4
// Checksum 0x7b68643b, Offset: 0x74a
// Size: 0x2a
function private bees_listener()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"spawn_bees" );
        thread on_spawn_bees();
    }
}

// Namespace zombie_callisto_zombees
// Params 1, eflags: 0x4
// Checksum 0xb72f7db9, Offset: 0x77c
// Size: 0x12d
function private function_a7bd2bbb9886d587( params )
{
    var_90ec0886f9ccf215 = params.var_14e87d44408dd566;
    
    if ( !isdefined( var_90ec0886f9ccf215 ) || !self.isactive || var_90ec0886f9ccf215.team == self.team || var_90ec0886f9ccf215.ignoreme )
    {
        return;
    }
    
    if ( self.origin[ 2 ] < var_90ec0886f9ccf215.origin[ 2 ] )
    {
        self.origin = ( self.origin[ 0 ], self.origin[ 1 ], var_90ec0886f9ccf215.origin[ 2 ] );
        return;
    }
    
    if ( self.incontact != var_90ec0886f9ccf215 )
    {
        self.incontact = var_90ec0886f9ccf215;
        thread function_99c65f3cf30ba11b( var_90ec0886f9ccf215 );
    }
    
    /#
        if ( getdvarint( @"hash_a93343106ef80aff", 0 ) > 0 )
        {
            sphere( self.origin, 5, ( 1, 0, 0 ), 0, 20 );
        }
    #/
    
    if ( self && var_90ec0886f9ccf215 )
    {
        namespace_62d6417c8f47a982::set_target_ent( self, var_90ec0886f9ccf215 );
        namespace_62d6417c8f47a982::function_cf9c0c9c03fe5550( self, 1 );
    }
    
    thread function_479ad603decb16a3();
}

// Namespace zombie_callisto_zombees
// Params 0, eflags: 0xc
// Checksum 0x50359611, Offset: 0x8b1
// Size: 0x7b
function private function_479ad603decb16a3()
{
    self notify( #"hash_39eb668a3afe8a77" );
    self endon( #"hash_39eb668a3afe8a77" );
    self endon( #"death" );
    self endon( #"ball_deactivate" );
    wait 1;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.incontact = undefined;
    namespace_62d6417c8f47a982::function_cf9c0c9c03fe5550( self, 0 );
    
    /#
        if ( getdvarint( @"hash_a93343106ef80aff", 0 ) > 0 )
        {
            iprintln( "<dev string:x24>" );
        }
    #/
    
    self notify( #"contact_ended" );
}

// Namespace zombie_callisto_zombees
// Params 1, eflags: 0xc
// Checksum 0x4998c8be, Offset: 0x934
// Size: 0x170
function private function_99c65f3cf30ba11b( var_90ec0886f9ccf215 )
{
    self notify( #"hash_63060636430315af" );
    self endon( #"hash_63060636430315af" );
    self endon( #"death" );
    self endon( #"ball_deactivate" );
    self endon( #"contact_ended" );
    
    if ( !isdefined( self.var_c9df1069932f57d ) )
    {
        self.var_c9df1069932f57d = 0;
    }
    
    while ( self.incontact )
    {
        if ( isdefined( self.beesdps ) && isdefined( var_90ec0886f9ccf215 ) )
        {
            if ( gettime() > self.var_c9df1069932f57d )
            {
                /#
                    if ( getdvarint( @"hash_a93343106ef80aff", 0 ) > 0 )
                    {
                        iprintln( "<dev string:x48>" );
                    }
                #/
                
                var_90ec0886f9ccf215 dodamage( self.beesdps, self.origin, self.owner, self, "MOD_PROJECTILE", "<explicitweaponnone>" );
                self.var_c9df1069932f57d = gettime() + 1000;
                
                if ( isplayer( var_90ec0886f9ccf215 ) )
                {
                    var_90ec0886f9ccf215 playsoundtoplayer( #"hash_cd2a97ee53f603ef", var_90ec0886f9ccf215 );
                    level callback::callback( "vo_callisto_zombeee_attack", { #targethit:var_90ec0886f9ccf215 } );
                    
                    if ( var_90ec0886f9ccf215 getscriptablehaspart( "zombees_vfx" ) )
                    {
                        var_90ec0886f9ccf215 utility::function_32b24db3127bff40( "zombees_vfx", "on" );
                    }
                }
            }
            
            waittime = max( self.var_c9df1069932f57d - gettime(), 0 );
            wait utility::function_6f5d2e1f1ff70482( waittime );
            continue;
        }
        
        return;
    }
}

// Namespace zombie_callisto_zombees
// Params 0
// Checksum 0xb8d1f5da, Offset: 0xaac
// Size: 0x238
function on_spawn_bees()
{
    self endon( #"death" );
    
    if ( self.active_bees != 2 )
    {
        ball = undefined;
        
        for ( i = 0; i < 2 ; i++ )
        {
            if ( !self.var_49d756f6c3af84e9[ i ].isactive )
            {
                ball = self.var_49d756f6c3af84e9[ i ];
            }
        }
        
        if ( !isdefined( ball ) )
        {
            return;
        }
        
        hive_tag = zombie_callisto_zombeehive::function_c1e4372f46de0584();
        
        if ( !hive_tag )
        {
            return;
        }
        
        spawn_pos = self gettagorigin( hive_tag );
        self.active_bees++;
        part_name = hive_tag + "_spawn_vfx";
        
        if ( self getscriptablehaspart( part_name ) )
        {
            utility::function_32b24db3127bff40( hive_tag, "on" );
        }
        
        if ( status_effects::has_status_effect_type( "charm" ) )
        {
            ball utility::function_32b24db3127bff40( "base", "swarm_on_brainrot" );
        }
        else
        {
            ball utility::function_32b24db3127bff40( "base", "swarm_on" );
        }
        
        ball dontinterpolate();
        ball.origin = spawn_pos;
        velocity = function_8aaed5e9294fe7ef( spawn_pos );
        ball namespace_62d6417c8f47a982::function_e47e242b17d4abc3( velocity, 3, 0 );
        target_ent = self.enemy;
        
        if ( isdefined( target_ent ) )
        {
            namespace_62d6417c8f47a982::set_target_ent( ball, target_ent );
        }
        
        ball setcandamage( 1 );
        ball solid();
        ball show();
        ball function_b398682b38f521f5( 1 );
        ball.var_2b5852f808241817 = int( min( self.maxhealth * self.var_1e5a69b47d416c23, self.var_b9d5600c52d29c40 ) );
        ball.maxhealth = 1000000000;
        ball.health = ball.maxhealth;
        ball.team = self.team;
        ball.isactive = 1;
        ball.ball_spawn_time = gettime();
        ball thread function_18d5bd176f761513();
        ball thread function_be8454f0f96512e7();
        ball thread function_7fa2c847b7ed7fd3( target_ent );
        damage_utility::register_damageable_entity( ball, ball.team );
    }
}

// Namespace zombie_callisto_zombees
// Params 0, eflags: 0x4
// Checksum 0xe1df6632, Offset: 0xcec
// Size: 0x89
function private function_18d5bd176f761513()
{
    self endon( #"death" );
    self endon( #"ball_deactivate" );
    
    while ( true )
    {
        if ( distancesquared( self.origin, self.owner.origin ) > self.var_30d41208260198b1 )
        {
            function_34f385a6d43f64bb( 1 );
            break;
        }
        
        if ( gettime() - self.ball_spawn_time > self.duration * 1000 )
        {
            function_34f385a6d43f64bb( 1 );
            break;
        }
        
        wait 1;
    }
}

// Namespace zombie_callisto_zombees
// Params 0, eflags: 0x4
// Checksum 0x920ca9b3, Offset: 0xd7d
// Size: 0x240
function private function_be8454f0f96512e7()
{
    self endon( #"death" );
    self endon( #"ball_deactivate" );
    
    while ( true )
    {
        waitframe();
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        self.health = 1000000000;
        
        if ( attacker.team == self.team )
        {
            continue;
        }
        
        if ( !isdefined( self.var_2b5852f808241817 ) )
        {
            return;
        }
        
        if ( inflictor && inflictor vehicle::is_vehicle() && meansofdeath == "MOD_CRUSH" )
        {
            return;
        }
        
        if ( !isdefined( objweapon ) )
        {
            objweapon = level.weaponnone;
        }
        
        element = zombie_damage::get_element( objweapon, attacker, meansofdeath );
        dmgstruct = zombie_damage::build_damage_struct( inflictor, attacker, damage, idflags, meansofdeath, objweapon, point, direction_vec, undefined, undefined, undefined, undefined, objweapon );
        dmgstruct.idamage = zombie_damage::function_881dfa87252ee0ea( dmgstruct );
        damage = zombie_damage::function_cef159ba09a96f98( dmgstruct );
        thread namespace_62d6417c8f47a982::function_8660a257418ee3ea( self.hitmovespeedscale, self.var_fbee4018bf39e009 );
        utility::function_32b24db3127bff40( "impact", "bees_hit" );
        
        if ( element == "fire" )
        {
            damage = int( damage * 1.5 );
        }
        
        self.var_2b5852f808241817 -= damage;
        var_c57ed7c52106c0f3 = 0;
        
        if ( self.var_2b5852f808241817 <= 0 )
        {
            var_c57ed7c52106c0f3 = 1;
        }
        
        if ( isplayer( attacker ) )
        {
            attacker namespace_9d8e359c3b1041e5::updatehitmarker_sharedfunc( "standard", var_c57ed7c52106c0f3 );
            
            if ( mp_agent_damage::function_e7d118eb7b017fa4() )
            {
                namespace_9d8e359c3b1041e5::displaydamagenumber_sharedfunc( attacker, self, "none", meansofdeath, objweapon, int( damage ), self.origin, 0, element, 0, 0 );
            }
        }
        
        if ( var_c57ed7c52106c0f3 )
        {
            function_34f385a6d43f64bb();
        }
    }
}

// Namespace zombie_callisto_zombees
// Params 1, eflags: 0x4
// Checksum 0x36a3cd8b, Offset: 0xfc5
// Size: 0x3f
function private function_7fa2c847b7ed7fd3( target )
{
    self endon( #"death" );
    self endon( #"ball_deactivate" );
    
    if ( isdefined( target ) )
    {
        target waittill( #"healing_aura_activated" );
        function_34f385a6d43f64bb();
    }
}

// Namespace zombie_callisto_zombees
// Params 1, eflags: 0x4
// Checksum 0xb12fff6c, Offset: 0x100c
// Size: 0x91
function private function_34f385a6d43f64bb( var_35fb3104d4d6ca0e )
{
    if ( self.isactive )
    {
        state = var_35fb3104d4d6ca0e ? "swarm_disperse" : "swarm_destroyed";
        utility::function_32b24db3127bff40( "base", state );
        damage_utility::function_b84e11c8ca9801fe( self, self.team );
        namespace_62d6417c8f47a982::function_6299c776502742fa( self );
        self setcandamage( 0 );
        self notsolid();
        self.var_2b5852f808241817 = 0;
        self.incontact = undefined;
        thread function_b86672926114ec4f();
        self notify( #"ball_deactivate" );
    }
}

// Namespace zombie_callisto_zombees
// Params 0, eflags: 0x4
// Checksum 0xf20f59f9, Offset: 0x10a5
// Size: 0x5b
function private function_b86672926114ec4f()
{
    self.owner endon( #"death" );
    wait 2;
    
    if ( self )
    {
        self.isactive = 0;
        
        if ( isdefined( self.owner.active_bees ) )
        {
            self.owner.active_bees--;
        }
        
        self hide();
    }
}

// Namespace zombie_callisto_zombees
// Params 1, eflags: 0x4
// Checksum 0x2cbe7935, Offset: 0x1108
// Size: 0x4f
function private function_8aaed5e9294fe7ef( spawn_pos )
{
    vel_dir = vectornormalize( spawn_pos - self getcentroid() );
    vel_mag = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9fdc37618598890;
    return vel_dir * vel_mag;
}

/#

    // Namespace zombie_callisto_zombees
    // Params 0
    // Checksum 0xa30b9696, Offset: 0x1160
    // Size: 0x44, Type: dev
    function setup_zombees_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x62>" );
        devgui::add_devgui_func( "<dev string:x7c>", "<dev string:x87>", &force_bees );
        devgui::add_devgui_func( "<dev string:x9b>", "<dev string:xa6>", &function_c5cc4d1b5b8e850e );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_callisto_zombees
    // Params 0, eflags: 0x4
    // Checksum 0x9c99a4a1, Offset: 0x11ac
    // Size: 0x54, Type: dev
    function private force_bees()
    {
        callisto = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xb4>" );
        
        if ( isdefined( callisto ) && callisto function_fdb6e29486445e7c( undefined, undefined ) )
        {
            callisto function_786bb6aa1b76c7ee( "<dev string:xc4>", 1 );
        }
    }

    // Namespace zombie_callisto_zombees
    // Params 0, eflags: 0x4
    // Checksum 0xd42a88cf, Offset: 0x1208
    // Size: 0x1a, Type: dev
    function private function_c5cc4d1b5b8e850e()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xd5>", @"hash_a93343106ef80aff" );
    }

#/
