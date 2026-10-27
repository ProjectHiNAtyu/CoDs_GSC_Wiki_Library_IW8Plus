// script_79edb4ed1f52fb62  (hash_79edb4ed1f52fb62.gscc) (size: 13854 Bytes / 0x361e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x45e38033 (1172537395)
// size ...... 13854 (0x361e)
// includes .. 11  (offset: 0x32ce)
// strings ... 37  (offset: 0x3326)
// dev strs .. 15  (offset: 0x3562)
// exports ... 32  (offset: 0x21d6)
// cseg ...... 0x352 + 0x1e84 (0x21d6)
// imports ... 99  (offset: 0x26d6)
// animtree1 . 0   (offset: 0x361e)
// animtree2 . 0   (offset: 0x361e)
#using script_16ea1b94f0f381b3;
#using script_4fb7a9021a570c8a;
#using script_75753577a55139f3;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_cannonball;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\zm\zm_utility;

#namespace zombie_diana_necrotic_projectile;

/#

    // Namespace zombie_diana_necrotic_projectile
    // Params 0
    // Checksum 0xd3b2098, Offset: 0x370
    // Size: 0xd, Type: dev
    function function_3baac86e7fec1b47()
    {
        level thread necrotic_projectile_devgui();
    }

#/

// Namespace zombie_diana_necrotic_projectile
// Params 0
// Checksum 0x1a413ef2, Offset: 0x385
// Size: 0x12c
function init_diana_necrotic_projectile()
{
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ), "<dev string:x24>" );
    self.var_459c6df661602ddb = getdvarfloat( @"hash_b2b36a867139c56c", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_c0b2a45ae38d58f2 );
    self.var_ea968bae159ea1c0 = getdvarfloat( @"hash_c1431381946e9bc7", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_236c9e012742ff5 );
    set_necrotic_projectile_velocity( getdvarfloat( @"hash_531cdfda35f36069", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_53bc6a3258a04b99 ) );
    set_necrotic_projectile_multi_shot_number( 3 );
    self.var_e9a5d31752cfc1b0 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_e9a5d31752cfc1b0;
    self.var_d07837715994c833 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_d07837715994c833;
    self.var_ec6a77694f724d49 = [];
    self function_786bb6aa1b76c7ee( "necrotic_projectile_single_shot", 0 );
    thread function_aac3640314955f0c();
}

// Namespace zombie_diana_necrotic_projectile
// Params 2
// Checksum 0x8744bdc0, Offset: 0x4b9
// Size: 0x48
function set_necrotic_projectile_damage_range( minrange, maxrange )
{
    assert( minrange <= maxrange, "<dev string:x97>" );
    
    if ( isdefined( minrange ) )
    {
        self.var_459c6df661602ddb = minrange;
    }
    
    if ( isdefined( maxrange ) )
    {
        self.var_ea968bae159ea1c0 = maxrange;
    }
}

// Namespace zombie_diana_necrotic_projectile
// Params 1
// Checksum 0xae015d4d, Offset: 0x509
// Size: 0x2c
function set_necrotic_projectile_velocity( velocity )
{
    assert( isdefined( velocity ), "<dev string:xe9>" );
    
    if ( velocity )
    {
        self.var_53bc6a3258a04b99 = velocity;
    }
}

// Namespace zombie_diana_necrotic_projectile
// Params 0
// Checksum 0xc3f98b17, Offset: 0x53d
// Size: 0xb
function get_necrotic_projectile_velocity()
{
    return self.var_53bc6a3258a04b99;
}

// Namespace zombie_diana_necrotic_projectile
// Params 1
// Checksum 0xf7c353d6, Offset: 0x551
// Size: 0x44
function set_necrotic_projectile_multi_shot_number( var_8a1a44bfa7f6042b )
{
    assert( var_8a1a44bfa7f6042b <= self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_7e9f5ea82c6f8dba, "<dev string:x12a>" );
    self.var_8272d46ee98222d5 = var_8a1a44bfa7f6042b;
}

// Namespace zombie_diana_necrotic_projectile
// Params 1
// Checksum 0xaf2affc1, Offset: 0x59d
// Size: 0x17
function set_necrotic_projectile_cooldown( cooldownseconds )
{
    self.var_d07837715994c833 = cooldownseconds;
}

// Namespace zombie_diana_necrotic_projectile
// Params 1
// Checksum 0x15158a47, Offset: 0x5bc
// Size: 0x17
function function_d43db4f022d36e9c( percent )
{
    self.var_e9a5d31752cfc1b0 = percent;
}

// Namespace zombie_diana_necrotic_projectile
// Params 0
// Checksum 0xf842f352, Offset: 0x5db
// Size: 0x1ee
function function_95d3b9d0dd153b31()
{
    self notify( #"hash_989656d7c033290e" );
    self notify( #"necrotic_projectile_end" );
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            player.var_78e2a20b23c8c44b = undefined;
        }
    }
    
    self.var_ec6a77694f724d49 = function_5713d46873b29625( self.var_ec6a77694f724d49 ?? [] );
    
    foreach ( projectile in self.var_ec6a77694f724d49 )
    {
        if ( projectile.marker )
        {
            projectile.marker freescriptable();
        }
        
        projectile delete();
    }
    
    self.var_ec6a77694f724d49 = [];
    self.var_58b19f9c88d4dce1 = function_5713d46873b29625( self.var_58b19f9c88d4dce1 ?? [] );
    
    foreach ( emitter in self.var_58b19f9c88d4dce1 )
    {
        emitter freescriptable();
    }
    
    self.var_58b19f9c88d4dce1 = [];
}

// Namespace zombie_diana_necrotic_projectile
// Params 0, eflags: 0xc
// Checksum 0x625e8a64, Offset: 0x7d1
// Size: 0x1c7
function private function_aac3640314955f0c()
{
    self notify( #"hash_429049ff04f06768" );
    self endon( #"hash_429049ff04f06768" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"necrotic_projectile_start", var_1c67f52186639b57, skipanim, var_8f889e6a7112f0ed, var_ada03b08d5d04aa4 );
        var_a088290e60a28452 = var_1c67f52186639b57 ? 0.6 : 0.2;
        zombie_diana_targeting::function_63056c67b91ac873( var_a088290e60a28452 );
        var_87039c038b880a07 = !var_8f889e6a7112f0ed && randomfloat( 100 ) <= self.var_e9a5d31752cfc1b0;
        
        if ( !skipanim )
        {
            thread function_bb9aa6e1b845412();
            self function_786bb6aa1b76c7ee( "in_idle_waiting_for_action", 1 );
            
            if ( !var_87039c038b880a07 )
            {
                thread function_176d8d67a63e7ece();
                self function_786bb6aa1b76c7ee( "necrotic_projectile_single_shot", 1 );
                
                if ( !var_8f889e6a7112f0ed )
                {
                    waitmsg = utility::waittill_any_in_array_or_timeout( [ "armor_break_start", "hibernation_start", "idle_loop_end" ], 2 );
                    
                    if ( waitmsg == "idle_loop_end" || var_8f889e6a7112f0ed )
                    {
                        asm::function_7256f5ba459c840b( "necrotic_projectile_in" );
                        thread function_4a84e62b18073b10( var_87039c038b880a07, var_1c67f52186639b57, skipanim, var_ada03b08d5d04aa4 );
                    }
                }
                else
                {
                    asm::function_7256f5ba459c840b( "necrotic_projectile_in" );
                    thread function_4a84e62b18073b10( var_87039c038b880a07, var_1c67f52186639b57, skipanim, var_ada03b08d5d04aa4 );
                }
            }
            else
            {
                waitmsg = utility::waittill_any_in_array_or_timeout( [ "armor_break_start", "hibernation_start", "idle_loop_end" ], 2 );
                
                if ( waitmsg == "idle_loop_end" )
                {
                    asm::function_7256f5ba459c840b( "necrotic_projectile_in" );
                    thread function_4a84e62b18073b10( var_87039c038b880a07, var_1c67f52186639b57, skipanim, var_ada03b08d5d04aa4 );
                }
            }
            
            self function_786bb6aa1b76c7ee( "in_idle_waiting_for_action", 0 );
            continue;
        }
        
        thread function_4a84e62b18073b10( 0, var_1c67f52186639b57, skipanim, var_ada03b08d5d04aa4 );
    }
}

// Namespace zombie_diana_necrotic_projectile
// Params 0, eflags: 0x4
// Checksum 0x2d526990, Offset: 0x9a0
// Size: 0x3f
function private function_176d8d67a63e7ece()
{
    self endon( #"death" );
    utility::waittill_notify_or_timeout( "no_armor_break_during_projectile_start", 1 );
    self.var_7daf7e8bd9f744b4 = 1;
    utility::waittill_notify_or_timeout( "no_armor_break_during_projectile_end", 2 );
    self.var_7daf7e8bd9f744b4 = undefined;
}

// Namespace zombie_diana_necrotic_projectile
// Params 4, eflags: 0xc
// Checksum 0x7e6fc07a, Offset: 0x9e7
// Size: 0x329
function private function_4a84e62b18073b10( var_87039c038b880a07, var_1c67f52186639b57, skipanim, var_ada03b08d5d04aa4 )
{
    self notify( #"hash_efbbb78d3d6401b6" );
    self endon( #"hash_efbbb78d3d6401b6" );
    self endon( #"death" );
    
    /#
        var_f0b7c40fa749b39c = anglestoforward( self.angles );
    #/
    
    if ( !skipanim )
    {
        self waittill( #"necrotic_projectile_fire" );
    }
    
    if ( var_87039c038b880a07 )
    {
        var_b3f7f30111155b73 = 0;
        
        for ( i = 0; i < self.var_8272d46ee98222d5 ; i++ )
        {
            var_3e342c6508e03260 = isent( self.var_b14209598a0140ab ) && !isalive( self.var_b14209598a0140ab ) || self.var_b14209598a0140ab.inlaststand || self.var_b14209598a0140ab.notarget || self.var_b14209598a0140ab.aether_shroud_active;
            
            if ( !var_b3f7f30111155b73 && var_3e342c6508e03260 )
            {
                newtarget = { #origin:self.var_b14209598a0140ab.origin };
                zombie_diana_targeting::set_diana_target( newtarget );
                var_b3f7f30111155b73 = 1;
            }
            
            launch_necrotic_projectile( self.var_b14209598a0140ab, 0, 0, var_ada03b08d5d04aa4 );
            wait getdvarfloat( @"hash_14c9d2575dde3b90", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_bc6036047bc1f011 );
        }
    }
    else
    {
        var_3e342c6508e03260 = isent( self.var_b14209598a0140ab ) && !isalive( self.var_b14209598a0140ab ) || self.var_b14209598a0140ab.inlaststand || self.var_b14209598a0140ab.notarget || self.var_b14209598a0140ab.aether_shroud_active;
        
        if ( var_3e342c6508e03260 )
        {
            newtarget = { #origin:self.var_b14209598a0140ab.origin };
            zombie_diana_targeting::set_diana_target( newtarget );
        }
        
        launch_necrotic_projectile( self.var_b14209598a0140ab, var_1c67f52186639b57, 0, var_ada03b08d5d04aa4 );
    }
    
    if ( !skipanim )
    {
        asm::asm_fireevent( self.asmname, "necrotic_projectile_end" );
        self waittill( #"necrotic_projectile_end" );
        
        if ( self getaiblackboarddynamic( "necrotic_projectile_single_shot" ) )
        {
            self function_786bb6aa1b76c7ee( "necrotic_projectile_single_shot", 0 );
        }
        
        self function_af99635258e79543( 0 );
        self function_a8fe8d86843b9cee( 0 );
        self.var_72b48c6ef48112e2 = gettime();
        
        if ( self.var_f9e48b7ff2c39654.size && self.var_f9e48b7ff2c39654.size + 1 > 6 )
        {
            self.var_f9e48b7ff2c39654[ self.var_f9e48b7ff2c39654.size - 1 ] = undefined;
        }
        
        self.var_f9e48b7ff2c39654 = arraycombine( [ var_87039c038b880a07 ? "necrotic_projectile_multi_shot" : "necrotic_projectile_single_shot" ], self.var_f9e48b7ff2c39654 );
        
        /#
            self orientmode( "<dev string:x187>", vectortoyaw( var_f0b7c40fa749b39c ) );
            self.var_b14209598a0140ab = undefined;
        #/
    }
}

// Namespace zombie_diana_necrotic_projectile
// Params 0, eflags: 0x4
// Checksum 0xe311651a, Offset: 0xd18
// Size: 0xfa
function private function_bb9aa6e1b845412()
{
    self endon( #"death" );
    self endon( #"necrotic_projectile_end" );
    self function_af99635258e79543( 0 );
    self function_a8fe8d86843b9cee( 0 );
    
    while ( true )
    {
        tagorigin = self gettagorigin( "tag_mouth_fx", 1 );
        targetpos = zombie_diana_targeting::function_380a323f0e968785();
        
        if ( !targetpos )
        {
            waitframe();
            continue;
        }
        
        vectotarget = targetpos - tagorigin;
        yawtotarget = vectortoyaw( vectotarget );
        yawdiff = angleclamp180( yawtotarget - self.angles[ 1 ] );
        yawdiff = clamp( yawdiff, -45, 45 );
        self function_af99635258e79543( yawdiff );
        var_8c45315ae5a7c408 = vectortopitch( vectotarget );
        var_40103a9cd5fe0b1b = angleclamp180( var_8c45315ae5a7c408 - self.angles[ 0 ] );
        var_40103a9cd5fe0b1b = clamp( var_40103a9cd5fe0b1b, -45, 1 );
        self function_a8fe8d86843b9cee( var_40103a9cd5fe0b1b );
        waitframe();
    }
}

// Namespace zombie_diana_necrotic_projectile
// Params 4
// Checksum 0xdf4bf428, Offset: 0xe1a
// Size: 0x501
function launch_necrotic_projectile( targetent, var_1c67f52186639b57, var_f774cba3b8c08c8a, var_ada03b08d5d04aa4 )
{
    var_8f84000640ce74d7 = self gettagorigin( "tag_mouth_fx", 1 );
    
    if ( !isdefined( var_8f84000640ce74d7 ) )
    {
        var_79e79e46e07c7067 = 200;
        var_ddece6f075557639 = 100;
        var_8f84000640ce74d7 = self.origin + anglestoup( self.angles ) * var_79e79e46e07c7067 + anglestoforward( self.angles ) * var_ddece6f075557639;
    }
    
    if ( !self.InAssaultRounds && ( var_1c67f52186639b57 || var_f774cba3b8c08c8a ) )
    {
        var_7902db0bd4d1d119 = var_1c67f52186639b57 ? "summon_agni_zombies" : "move";
        
        if ( var_1c67f52186639b57 && !self.InAssaultRounds )
        {
            entryindex = self aigetanimweight( "summon_agni_zombies", 0 ) > 0 ? 0 : 1;
            var_e6644201dd56c7ff = getdvarfloat( @"hash_2aa9d6da85a3d7d3", 0.0125 );
        }
        else
        {
            entryindex = 2;
            var_e6644201dd56c7ff = getdvarfloat( @"hash_2aa9d6da85a3d7d3", 0.021 );
        }
        
        var_14a1a349b35fe523 = animsetgetanimfromindex( self.animsetname, var_7902db0bd4d1d119, entryindex );
        var_9ac59c5e7752ef33 = self aigetanimtime( var_7902db0bd4d1d119, entryindex );
        predictiondelta = getmovedelta( var_14a1a349b35fe523, var_9ac59c5e7752ef33, clamp( var_9ac59c5e7752ef33 + var_e6644201dd56c7ff, 0, 1 ) );
        predictiondelta = rotatevector( predictiondelta, self.angles );
        var_8f84000640ce74d7 += predictiondelta;
    }
    
    thread function_b22607949d133a30();
    
    if ( self.var_b14209598a0140ab && self.var_b14209598a0140ab == targetent )
    {
        endpoint = zombie_diana_targeting::function_380a323f0e968785();
    }
    
    if ( !endpoint )
    {
        endpoint = targetent.origin;
    }
    
    vectotarget = endpoint - var_8f84000640ce74d7;
    necroticprojectile = spawn( "script_model", var_8f84000640ce74d7 );
    necroticprojectile setmodel( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_235742e83afce00f );
    necroticprojectile.startingpos = var_8f84000640ce74d7;
    necroticprojectile.owner = self;
    necroticprojectile.startingdir = vectornormalize( vectotarget );
    necroticprojectile.angles = vectortoangles( vectotarget );
    necroticprojectile.var_842f2b76dccb8851 = 0;
    
    if ( var_1c67f52186639b57 )
    {
        necroticprojectile.velocity = getdvarfloat( @"hash_4037a983566a7276", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3135c4427c387407 );
    }
    else
    {
        necroticprojectile.velocity = getdvarfloat( @"hash_531cdfda35f36069", self.var_53bc6a3258a04b99 );
    }
    
    necroticprojectile.moveintervaltime = getdvarfloat( @"hash_a242bb73a637bb13", 0.1 );
    necroticprojectile.maxrange = getdvarfloat( @"hash_6633e9c23fd5d52e", 15000 );
    necroticprojectile.var_1c67f52186639b57 = var_1c67f52186639b57;
    necroticprojectile.var_1f0763e64ee2683d = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_1f0763e64ee2683d ?? 22;
    startpoint = var_8f84000640ce74d7;
    
    if ( necroticprojectile.velocity > 0 )
    {
        necroticprojectile.expectedtime = length( vectotarget ) / necroticprojectile.velocity;
    }
    else
    {
        necroticprojectile.expectedtime = 15;
    }
    
    if ( self.velocity )
    {
        midpoint = self.velocity * necroticprojectile.expectedtime / 3 + startpoint;
        
        if ( midpoint[ 2 ] < startpoint[ 2 ] )
        {
            midpoint = ( midpoint[ 0 ], midpoint[ 1 ], startpoint[ 2 ] );
        }
    }
    else
    {
        midpoint = ( startpoint + endpoint ) / 2;
    }
    
    if ( var_ada03b08d5d04aa4 )
    {
        var_b314961aec1f068 = necroticprojectile.startingdir * necroticprojectile.maxrange + necroticprojectile.startingpos;
        ignoreents = [ necroticprojectile, necroticprojectile.owner ];
        trace = trace::ray_trace( var_8f84000640ce74d7, var_b314961aec1f068, ignoreents, trace::create_default_contents( 1 ), 1, 0, 1 );
        
        if ( trace[ "hittype" ] == "hittype_world" && trace[ "surfacetype" ] != "surftype_water" )
        {
            var_4c83982fac6ebf48 = spawnscriptable( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_4c83982fac6ebf48, trace[ "position" ], ( 0, 0, 1 ) );
            var_4c83982fac6ebf48 thread function_910082083dcae25b( necroticprojectile );
            necroticprojectile.marker = var_4c83982fac6ebf48;
        }
    }
    
    self.var_ec6a77694f724d49[ self.var_ec6a77694f724d49.size ] = necroticprojectile;
    necroticprojectile thread necrotic_projectile_monitor( startpoint, midpoint, endpoint, necroticprojectile.expectedtime );
}

// Namespace zombie_diana_necrotic_projectile
// Params 1, eflags: 0x4
// Checksum 0xc31f3b82, Offset: 0x1323
// Size: 0x45
function private function_910082083dcae25b( necroticprojectile )
{
    necroticprojectile utility::waittill_any_in_array_or_timeout( [ "death", "necroticProjectileDetonated" ], necroticprojectile.expectedtime ?? 15 );
    
    if ( self )
    {
        self freescriptable();
    }
}

// Namespace zombie_diana_necrotic_projectile
// Params 0, eflags: 0x4
// Checksum 0x594199f6, Offset: 0x1370
// Size: 0x35
function private function_b22607949d133a30()
{
    utility::function_32b24db3127bff40( "necrotic_projectile", "spit" );
    utility::waittill_notify_or_timeout( "death", 0.1 );
    utility::function_32b24db3127bff40( "necrotic_projectile", "off" );
}

// Namespace zombie_diana_necrotic_projectile
// Params 4, eflags: 0x4
// Checksum 0xf72d6d0, Offset: 0x13ad
// Size: 0x18e
function private necrotic_projectile_monitor( start, mid, end, expectedtime )
{
    self endon( #"death" );
    self.owner endon( #"death" );
    necroticprojectile = self;
    talismanscriptable = necroticprojectile.owner.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.talismanscriptable;
    necroticprojectile.currentmovetime = 0;
    
    /#
        if ( getdvarint( @"hash_d89deb1511a9fdb8", 0 ) )
        {
            sphere( start, 100, ( 0, 1, 0 ), 0, utility::function_329f35afae907694( expectedtime ) );
            sphere( mid, 100, ( 1, 1, 0 ), 0, utility::function_329f35afae907694( expectedtime ) );
            sphere( end, 100, ( 1, 0, 0 ), 0, utility::function_329f35afae907694( expectedtime ) );
        }
    #/
    
    contents = trace::create_default_contents();
    contents |= physics_createcontents( [ "physicscontents_ttlosclip" ] );
    
    while ( isdefined( necroticprojectile ) )
    {
        if ( necroticprojectile.shoulddetonate )
        {
            necroticprojectile thread necrotic_projectile_detonate( 0, necroticprojectile.origin );
        }
        else
        {
            necroticprojectile function_1740181006e5757f( start, mid, end, expectedtime, talismanscriptable, contents );
            necroticprojectile.var_842f2b76dccb8851 += 1;
        }
        
        wait necroticprojectile.moveintervaltime;
    }
}

// Namespace zombie_diana_necrotic_projectile
// Params 6, eflags: 0x4
// Checksum 0x5a8244db, Offset: 0x1543
// Size: 0x2a4
function private function_1740181006e5757f( start, mid, end, expectedtime, talismanscriptable, contents )
{
    self endon( #"death" );
    self.owner endon( #"death" );
    necroticprojectile = self;
    diana = necroticprojectile.owner;
    newtime = necroticprojectile.currentmovetime + necroticprojectile.moveintervaltime;
    
    if ( necroticprojectile.currentmovetime > expectedtime )
    {
        necroticprojectile.shoulddetonate = 1;
        return;
    }
    
    movetopoint = function_4d3beb6f8cc55169( start, mid, end, clamp( newtime / expectedtime, 0, 1 ) );
    necroticprojectile.olddir = movetopoint - necroticprojectile.origin;
    var_fbb9735819b74bdc = !diana.InAssaultRounds ? contents : undefined;
    ignoreents = [ necroticprojectile, necroticprojectile.owner ];
    trace = trace::ray_trace( necroticprojectile.origin, movetopoint, ignoreents, var_fbb9735819b74bdc, 1, 0, 1 );
    
    if ( trace[ "hittype" ] == "hittype_world" && trace[ "surfacetype" ] != "surftype_water" || trace[ "hittype" ] == "hittype_entity" || trace[ "hittype" ] == "hittype_scriptable" )
    {
        impactpoint = trace[ "position" ];
        delay = function_d220d72e3227958( necroticprojectile.origin, impactpoint, length( necroticprojectile.olddir ), necroticprojectile.moveintervaltime );
        
        if ( trace[ "hittype" ] == "hittype_entity" )
        {
            hittarget = trace[ "entity" ];
        }
        else if ( trace[ "hittype" ] == "hittype_scriptable" && trace[ "scriptable" ].type == talismanscriptable && trace[ "scriptable" ].state == "active" )
        {
            hittarget = trace[ "scriptable" ];
            hittarget scriptabledodamage( 0, self, self, impactpoint, self.startingdir );
            necroticprojectile.var_11a9e5b1bbc18fea = 1;
        }
        
        necroticprojectile thread necrotic_projectile_detonate( delay, impactpoint, hittarget );
    }
    
    necroticprojectile moveto( movetopoint, necroticprojectile.moveintervaltime );
    necroticprojectile.currentmovetime = newtime;
}

// Namespace zombie_diana_necrotic_projectile
// Params 4, eflags: 0x4
// Checksum 0x1166b875, Offset: 0x17ef
// Size: 0xbb
function private function_4d3beb6f8cc55169( start, mid, end, t )
{
    var_25812a1b6ad3af6a = 1 - t;
    x = var_25812a1b6ad3af6a * var_25812a1b6ad3af6a * start[ 0 ] + 2 * var_25812a1b6ad3af6a * t * mid[ 0 ] + t * t * end[ 0 ];
    y = var_25812a1b6ad3af6a * var_25812a1b6ad3af6a * start[ 1 ] + 2 * var_25812a1b6ad3af6a * t * mid[ 1 ] + t * t * end[ 1 ];
    z = var_25812a1b6ad3af6a * var_25812a1b6ad3af6a * start[ 2 ] + 2 * var_25812a1b6ad3af6a * t * mid[ 2 ] + t * t * end[ 2 ];
    return ( x, y, z );
}

// Namespace zombie_diana_necrotic_projectile
// Params 4, eflags: 0x4
// Checksum 0x790a22b9, Offset: 0x18b3
// Size: 0x45
function private function_d220d72e3227958( currentpos, detonatepos, movedist, timeinterval )
{
    ratio = distancesquared( detonatepos, currentpos ) / squared( movedist );
    return ratio * timeinterval;
}

// Namespace zombie_diana_necrotic_projectile
// Params 3, eflags: 0xc
// Checksum 0xffdb36c7, Offset: 0x1901
// Size: 0x23c
function private necrotic_projectile_detonate( delay, impactpoint, hittarget )
{
    self notify( #"hash_e36a542efc242699" );
    self endon( #"hash_e36a542efc242699" );
    self endon( #"death" );
    self.owner endon( #"death" );
    var_c51968f2442471f9 = 0.8;
    necroticprojectile = self;
    necroticprojectile.isdetonating = 1;
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    diana = necroticprojectile.owner;
    
    if ( diana )
    {
        var_aeedc6e43aaf55c3 = diana.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_aeedc6e43aaf55c3;
        var_459c6df661602ddb = diana.var_459c6df661602ddb;
        var_ea968bae159ea1c0 = diana.var_ea968bae159ea1c0;
        var_1f0763e64ee2683d = getdvarfloat( @"hash_8436cb3e215de182", necroticprojectile.var_1f0763e64ee2683d );
        
        if ( necroticprojectile )
        {
            var_495a29da29e85c25 = necroticprojectile.olddir;
            
            if ( function_4aad082baf252738( impactpoint, var_aeedc6e43aaf55c3 ) || diana.InAssaultRounds )
            {
                var_e7b44c29d4aa813f = 0;
            }
            else
            {
                var_e7b44c29d4aa813f = var_1f0763e64ee2683d;
            }
            
            explosiontype = !necroticprojectile.var_1c67f52186639b57 ? "necrotic_projectile" : undefined;
            diana namespace_11bfef4f5e98b9a1::function_55e7322e9409d6cc( hittarget, impactpoint, vectortoangles( var_495a29da29e85c25 ), var_aeedc6e43aaf55c3, "MOD_EXPLOSIVE", var_459c6df661602ddb, var_ea968bae159ea1c0, var_e7b44c29d4aa813f, undefined, explosiontype, necroticprojectile.var_1c67f52186639b57, 1, var_c51968f2442471f9, 0, 2500, 0.32, 1, diana.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_af542b793aa178a9 );
            
            if ( necroticprojectile.var_1c67f52186639b57 && !necroticprojectile.var_11a9e5b1bbc18fea )
            {
                level thread function_f25ee8ab0dc6b4d7( diana, impactpoint, var_495a29da29e85c25 );
            }
            
            necroticprojectile notify( #"necroticProjectileDetonated" );
            
            if ( isdefined( necroticprojectile ) )
            {
                if ( necroticprojectile.marker )
                {
                    necroticprojectile.marker freescriptable();
                }
                
                necroticprojectile delete();
            }
        }
    }
}

// Namespace zombie_diana_necrotic_projectile
// Params 2, eflags: 0x4
// Checksum 0xd9ad5475, Offset: 0x1b45
// Size: 0xd9, Type: bool
function private function_4aad082baf252738( pos, explosionradius )
{
    foreach ( talisman in level.talisman_system.talismans )
    {
        if ( !explosionradius )
        {
            continue;
        }
        
        if ( talisman.state != "hidden" && distancesquared( pos, talisman.scriptable.origin ) <= squared( explosionradius + 240 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_diana_necrotic_projectile
// Params 3, eflags: 0x4
// Checksum 0x96e5bf9b, Offset: 0x1c27
// Size: 0x234
function private function_f25ee8ab0dc6b4d7( diana, impactpoint, projectiledir )
{
    if ( !diana.var_8ef0695e15c92a76 || diana.var_8ef0695e15c92a76 <= 0 )
    {
        return;
    }
    
    numtospawn = diana.var_8ef0695e15c92a76 + ( diana.var_c1583df14aa1c037 ?? 0 );
    var_40829c0359f623b7 = vectortoyaw( projectiledir );
    spawnangles = [];
    
    if ( numtospawn == 1 )
    {
        spawnangles[ 0 ] = var_40829c0359f623b7;
    }
    else
    {
        var_30496eadb602f2f8 = 140 / ( numtospawn - 1 );
        
        for ( i = 0; i < numtospawn ; i++ )
        {
            spawnangles[ i ] = angleclamp180( var_40829c0359f623b7 + -70 + i * var_30496eadb602f2f8 );
        }
    }
    
    for ( i = 0; i < numtospawn ; i++ )
    {
        agnispawnangles = ( 0, spawnangles[ i ], 0 );
        aitypes = function_b3988325430ce242( "zombie_base_armored_agni" );
        
        if ( !aitypes )
        {
            return;
        }
        
        agnizombie = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( aitypes, impactpoint, agnispawnangles, diana.team );
        
        if ( agnizombie )
        {
            agnizombie.spawn_source = "diana_summon_zombies_spawn";
            agnizombie utility::ent_flag_wait_or_timeout( "zombie_asm_init_finished", 0.5 );
            roundnumber = zm_utility::get_round_number();
            agnizombie zombie_utils::set_zombie_round_difficulty( roundnumber );
            agnizombie.var_8d1ec8d2c55d4025 = 1;
            var_718db66838ae92fc = anglestoforward( agnispawnangles );
            var_fa9e89c63419ed31 = vectorcross( ( 0, 0, 1 ), var_718db66838ae92fc );
            cannonballdir = rotatepointaroundvector( var_fa9e89c63419ed31, var_718db66838ae92fc, -1 * getdvarfloat( @"hash_9cdc7830276fa38c", 75 ) );
            agnizombie zombie_cannonball::cannonball_ai( cannonballdir, getdvarfloat( @"hash_df95e9f9f0bff0da", 600 ), zombie_cannonball::adv_settings( 1, getdvarfloat( @"hash_1ca78a6ee61aada9", 8 ), 0, getdvarfloat( @"hash_7969230501e41c22", 900 ), undefined, 500 ), "roll_forward" );
            agnizombie zombie_cannonball::function_c47b4675a71d8167( &function_1e3ce87be6c0b4f5 );
        }
    }
}

// Namespace zombie_diana_necrotic_projectile
// Params 0, eflags: 0x4
// Checksum 0x2497febe, Offset: 0x1e63
// Size: 0x21
function private function_1e3ce87be6c0b4f5()
{
    self.death_source = "cannonball_failsafe";
    self.var_a13bed1ac47e1b2c = 1;
    self kill();
}

// Namespace zombie_diana_necrotic_projectile
// Params 2
// Checksum 0x55049b99, Offset: 0x1e8c
// Size: 0x2e, Type: bool
function function_5d5a0241d1d308e1( taskid, params )
{
    return self.var_8f07f1045f74e12e && self.var_8f07f1045f74e12e.size > 0;
}

// Namespace zombie_diana_necrotic_projectile
// Params 2
// Checksum 0x5492bd61, Offset: 0x1ec3
// Size: 0x61
function function_9e247b8febfbdae0( taskid, params )
{
    var_35177491c0c045d7 = gettime() - ( self.var_72b48c6ef48112e2 ?? 0 );
    cooldownscore = clamp( math::remap( var_35177491c0c045d7, 0, utility::function_4b74c15943231980( self.var_d07837715994c833 ), 0, 1 ), 0, 1 );
    return cooldownscore;
}

// Namespace zombie_diana_necrotic_projectile
// Params 2
// Checksum 0x81222167, Offset: 0x1f2d
// Size: 0xcb
function function_4b1479d8d62f435a( taskid, params )
{
    var_5988a62b2e6252b6 = 0;
    
    foreach ( var_2bdea747682d42f1 in self.var_f9e48b7ff2c39654 )
    {
        if ( var_2bdea747682d42f1 == "necrotic_projectile_multi_shot" || var_2bdea747682d42f1 == "necrotic_projectile_single_shot" )
        {
            var_5988a62b2e6252b6++;
        }
    }
    
    var_9a48b1aac439ed1d = clamp( math::remap( var_5988a62b2e6252b6, 3, 0, 0, 1 ), 0, 1 );
    return var_9a48b1aac439ed1d;
}

/#

    // Namespace zombie_diana_necrotic_projectile
    // Params 0
    // Checksum 0x693193af, Offset: 0x2001
    // Size: 0x5a, Type: dev
    function necrotic_projectile_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x192>" );
        devgui::add_devgui_func( "<dev string:x1a9>", "<dev string:x1cc>", &do_necrotic_projectile_single_shot );
        devgui::add_devgui_func( "<dev string:x1ef>", "<dev string:x211>", &do_necrotic_projectile_multi_shot );
        devgui::add_devgui_func( "<dev string:x233>", "<dev string:x264>", &function_b762970fde805dc3 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_diana_necrotic_projectile
    // Params 1
    // Checksum 0xb34176cc, Offset: 0x2063
    // Size: 0x95, Type: dev
    function do_necrotic_projectile_single_shot( params )
    {
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x293>" );
        
        if ( isdefined( diana ) )
        {
            if ( params && arraycontains( params, "<dev string:x2a0>" ) )
            {
                diana.var_7d37f9a166905785 = 1;
                params = arrayremove( params, "<dev string:x2ab>" );
            }
            
            diana.var_b14209598a0140ab = level.players[ 0 ];
            diana notify( #"necrotic_projectile_start" );
        }
    }

    // Namespace zombie_diana_necrotic_projectile
    // Params 1
    // Checksum 0xa204da7c, Offset: 0x2100
    // Size: 0x68, Type: dev
    function function_b762970fde805dc3( params )
    {
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x293>" );
        
        if ( isdefined( diana ) )
        {
            diana.var_b14209598a0140ab = level.players[ 0 ];
            diana notify( #"necrotic_projectile_start", 1 );
        }
    }

    // Namespace zombie_diana_necrotic_projectile
    // Params 1
    // Checksum 0x3f5dacc6, Offset: 0x2170
    // Size: 0x66, Type: dev
    function do_necrotic_projectile_multi_shot( params )
    {
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x293>" );
        
        if ( isdefined( diana ) )
        {
            diana.var_b14209598a0140ab = level.players[ 0 ];
            diana notify( #"necrotic_projectile_start" );
        }
    }

#/
