// script_6d4c5bf7d72d6d4a  (hash_6d4c5bf7d72d6d4a.gscc) (size: 21217 Bytes / 0x52e1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x609b438d (1620788109)
// size ...... 21217 (0x52e1)
// includes .. 11  (offset: 0x4ec5)
// strings ... 41  (offset: 0x4f1d)
// dev strs .. 17  (offset: 0x51e9)
// exports ... 37  (offset: 0x3969)
// cseg ...... 0x34f + 0x361a (0x3969)
// imports ... 118 (offset: 0x3f31)
// animtree1 . 0   (offset: 0x52e1)
// animtree2 . 0   (offset: 0x52e1)
#using script_16ea1b94f0f381b3;
#using script_4fb7a9021a570c8a;
#using script_75753577a55139f3;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\shellshock_utility;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace zombie_diana_necrotic_beam;

/#

    // Namespace zombie_diana_necrotic_beam
    // Params 0
    // Checksum 0x722343, Offset: 0x36d
    // Size: 0xd, Type: dev
    function function_6e5b3d623dea435f()
    {
        level thread necrotic_beam_devgui();
    }

#/

// Namespace zombie_diana_necrotic_beam
// Params 0
// Checksum 0x2178c2a9, Offset: 0x382
// Size: 0x140
function init_diana_necrotic_beam()
{
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ), "<dev string:x24>" );
    function_1726fda8a9443f30( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_12555c2d12ccc9e3, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_64676c02ded99bbc );
    self.var_d4f29f1205f3f7b9 = 1;
    self.var_bf44f13272202612 = getdvarfloat( @"hash_f8abef9726586b66", -70 );
    self.var_6d139d6f89ee9f49 = getdvarfloat( @"hash_26103c788d241b8d", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_6d139d6f89ee9f49 );
    self.var_d27f4fe48e41462f = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_d27f4fe48e41462f;
    self.var_eae9ccfd2469d520 = getdvarfloat( @"hash_9e314f7c7c86b33a", 2.5 );
    self.var_736ad81cb3c31ad1 = 1;
    self.var_5dec4cc95b2ae8a3 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5dec4cc95b2ae8a3;
    self.var_bea3ad7183a3e0ec = [];
    thread function_a97c728429e8c828();
}

// Namespace zombie_diana_necrotic_beam
// Params 2
// Checksum 0xf34fba7b, Offset: 0x4ca
// Size: 0x48
function function_1726fda8a9443f30( minrange, maxrange )
{
    assert( minrange <= maxrange, "<dev string:x97>" );
    
    if ( isdefined( minrange ) )
    {
        self.var_1477342ebbff9fec = minrange;
    }
    
    if ( isdefined( maxrange ) )
    {
        self.var_2d8f77bcc722e893 = maxrange;
    }
}

// Namespace zombie_diana_necrotic_beam
// Params 1
// Checksum 0xc68b99ee, Offset: 0x51a
// Size: 0x17
function function_11fa21e59bb35d9c( var_3a885224047264ef )
{
    self.var_302c4e595988f21a = var_3a885224047264ef;
}

// Namespace zombie_diana_necrotic_beam
// Params 1
// Checksum 0x973d2819, Offset: 0x539
// Size: 0x17
function set_necrotic_beam_cooldown( cooldownseconds )
{
    self.var_5dec4cc95b2ae8a3 = cooldownseconds;
}

// Namespace zombie_diana_necrotic_beam
// Params 1
// Checksum 0x2a77c03e, Offset: 0x558
// Size: 0x2f
function function_f68f7d07e46fbb70( reductionseconds )
{
    self.var_5dec4cc95b2ae8a3 = clamp( self.var_5dec4cc95b2ae8a3 - reductionseconds, 0, self.var_5dec4cc95b2ae8a3 );
}

// Namespace zombie_diana_necrotic_beam
// Params 1
// Checksum 0x213b4520, Offset: 0x58f
// Size: 0x17
function function_d6a6dc868f2c4e06( maxnumber )
{
    self.var_6b1405438bf971d = maxnumber;
}

// Namespace zombie_diana_necrotic_beam
// Params 0
// Checksum 0x81f04a26, Offset: 0x5ae
// Size: 0x1dc
function function_4084db6a60bfeb55()
{
    self notify( #"hash_c2c6c23b8b88b9e2" );
    self notify( #"necrotic_beam_end" );
    self notify( #"hash_989656d7c033290e" );
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            player.var_78e2a20b23c8c44b = undefined;
        }
    }
    
    self.var_bea3ad7183a3e0ec = function_5713d46873b29625( self.var_bea3ad7183a3e0ec ?? [] );
    
    foreach ( scriptable in self.var_bea3ad7183a3e0ec )
    {
        scriptable freescriptable();
    }
    
    self.var_bea3ad7183a3e0ec = [];
    self.var_58b19f9c88d4dce1 = function_5713d46873b29625( self.var_58b19f9c88d4dce1 ?? [] );
    
    foreach ( emitter in self.var_58b19f9c88d4dce1 )
    {
        emitter freescriptable();
    }
    
    self.var_58b19f9c88d4dce1 = [];
}

// Namespace zombie_diana_necrotic_beam
// Params 0, eflags: 0xc
// Checksum 0xfb4f87ae, Offset: 0x792
// Size: 0x10b
function private function_a97c728429e8c828()
{
    self notify( #"hash_499c8998498f2664" );
    self endon( #"hash_499c8998498f2664" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"necrotic_beam_start", var_3421dd8ec85fe5f8 );
        thread function_b97f460746613ed9();
        zombie_diana_targeting::function_63056c67b91ac873( 0.5 );
        self function_786bb6aa1b76c7ee( "in_idle_waiting_for_action", 1 );
        waitmsg = utility::waittill_any_in_array_or_timeout( [ "armor_break_start", "hibernation_start", "idle_loop_end" ], 2 );
        
        if ( waitmsg == "idle_loop_end" )
        {
            self.var_fbd2b9707b5bd16f = 1;
            thread function_bb9aa6e1b845412();
            
            if ( self.InAssaultRounds )
            {
                asm::function_d82cb83c9c260d49( 0.8 );
            }
            
            asm::function_7256f5ba459c840b( "necrotic_beam_in" );
            thread function_a907f1c506d3ce87();
            thread function_fc967235b1b480f8( var_3421dd8ec85fe5f8 );
            
            if ( !self.InAssaultRounds )
            {
                level thread function_bb64b8e5b1d71b16( self );
            }
        }
        
        self function_786bb6aa1b76c7ee( "in_idle_waiting_for_action", 0 );
    }
}

// Namespace zombie_diana_necrotic_beam
// Params 0, eflags: 0x4
// Checksum 0x77ec428f, Offset: 0x8a5
// Size: 0xd4
function private function_b97f460746613ed9()
{
    self endon( #"death" );
    self endon( #"necrotic_beam_fire" );
    self endon( #"necrotic_beam_anim_end" );
    
    while ( true )
    {
        var_3e342c6508e03260 = isent( self.var_b14209598a0140ab ) && ( !isalive( self.var_b14209598a0140ab ) || self.var_b14209598a0140ab.inlaststand || self.var_b14209598a0140ab.notarget || self.var_b14209598a0140ab.aether_shroud_active );
        
        if ( var_3e342c6508e03260 )
        {
            newtarget = { #origin:self.var_b14209598a0140ab.origin };
            zombie_diana_targeting::set_diana_target( newtarget );
        }
        
        waitframe();
    }
}

// Namespace zombie_diana_necrotic_beam
// Params 0, eflags: 0x4
// Checksum 0xe6bf3396, Offset: 0x981
// Size: 0x11c
function private function_bb9aa6e1b845412()
{
    self endon( #"death" );
    self endon( #"necrotic_beam_fire" );
    self endon( #"necrotic_beam_anim_end" );
    self function_af99635258e79543( 0 );
    self function_a8fe8d86843b9cee( 0 );
    yawdiff = 0;
    var_40103a9cd5fe0b1b = 0;
    
    while ( true )
    {
        tagorigin = self gettagorigin( "tag_mouth_fx", 1 );
        targetpos = zombie_diana_targeting::function_380a323f0e968785();
        
        if ( !targetpos )
        {
            self function_af99635258e79543( yawdiff );
            self function_a8fe8d86843b9cee( var_40103a9cd5fe0b1b );
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

// Namespace zombie_diana_necrotic_beam
// Params 0, eflags: 0x4
// Checksum 0x205dd2d0, Offset: 0xaa5
// Size: 0x113
function private function_a907f1c506d3ce87()
{
    self endon( #"death" );
    var_1f84179e8fada1c6 = 3.5;
    var_5e329eb1c5e4e878 = 2;
    var_7f4a5293e3aed365 = 1;
    utility::function_32b24db3127bff40( "necrotic_beam", "tell" );
    utility::waittill_notify_or_timeout( "necrotic_beam_fire", var_1f84179e8fada1c6 );
    utility::function_32b24db3127bff40( "necrotic_beam", "spit" );
    utility::waittill_notify_or_timeout( "necrotic_beam_end", var_5e329eb1c5e4e878 );
    utility::function_32b24db3127bff40( "necrotic_beam", "off_with_audio" );
    utility::waittill_notify_or_timeout( "necrotic_beam_anim_end", var_7f4a5293e3aed365 );
    
    if ( self.InAssaultRounds )
    {
        asm::function_d82cb83c9c260d49( 1 );
    }
    
    self.var_fbd2b9707b5bd16f = undefined;
    self.var_5c1fff7a74cd6f12 = gettime();
    
    if ( self.var_f9e48b7ff2c39654.size + 1 > 6 )
    {
        self.var_f9e48b7ff2c39654[ self.var_f9e48b7ff2c39654.size - 1 ] = undefined;
    }
    
    self.var_f9e48b7ff2c39654 = arraycombine( [ "necrotic_beam" ], self.var_f9e48b7ff2c39654 );
}

// Namespace zombie_diana_necrotic_beam
// Params 1, eflags: 0xc
// Checksum 0x6410d350, Offset: 0xbc0
// Size: 0x93a
function private function_fc967235b1b480f8( var_3421dd8ec85fe5f8 )
{
    self notify( #"hash_17eeb37b76c1e0ee" );
    self endon( #"hash_17eeb37b76c1e0ee" );
    self endon( #"death" );
    self endon( #"necrotic_beam_end" );
    utility::waittill_notify_or_timeout( "necrotic_beam_fire", 4 );
    self.var_e75182c9826b644b = spawnstruct();
    self.var_e75182c9826b644b.var_316c974eb01d8fa = [];
    self.var_e75182c9826b644b.var_d5765d50acacb150 = function_d63b37c2c983bf56();
    
    if ( !var_3421dd8ec85fe5f8 )
    {
        self.var_e75182c9826b644b.var_eaffd0f0b368aacb = vectornormalize2( zombie_diana_targeting::function_380a323f0e968785() - self.var_e75182c9826b644b.var_d5765d50acacb150 );
    }
    else
    {
        self.var_e75182c9826b644b.var_eaffd0f0b368aacb = vectornormalize2( var_3421dd8ec85fe5f8 - self.var_e75182c9826b644b.var_d5765d50acacb150 );
    }
    
    self.var_e75182c9826b644b.var_1007430e2ab9fc58 = function_6e3d4c7b81638567( self.var_e75182c9826b644b );
    self.var_e75182c9826b644b.targetent = spawn( "script_model_animated", self.var_e75182c9826b644b.var_1007430e2ab9fc58.pos );
    self.var_e75182c9826b644b.targetent setmodel( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f4615ecafed1394d );
    self.var_e75182c9826b644b.targetent dontinterpolate();
    thread utility::function_9a9165839779317f( self.var_e75182c9826b644b.targetent, "necrotic_beam_end" );
    thread utility::delete_on_death( self.var_e75182c9826b644b.targetent );
    var_2853764413515e57 = getdvarfloat( @"hash_85619fbe5e53148f", 0.1 );
    var_d4184d8fb64620d4 = getdvarfloat( @"hash_26103c788d241b8d", self.var_6d139d6f89ee9f49 ) * var_2853764413515e57;
    self.var_e75182c9826b644b.beamvfx = function_f5f8abcd7522eee2( utility::getfx( "diana_necrotic_beam_attack_vfx" ), self.var_e75182c9826b644b.var_d5765d50acacb150, self.var_e75182c9826b644b.var_1007430e2ab9fc58.pos );
    self.var_e75182c9826b644b.beamvfx namespace_9d8e359c3b1041e5::forcenetfieldhighlod_sharedfunc( 1 );
    thread utility::function_9a9165839779317f( self.var_e75182c9826b644b.beamvfx, "necrotic_beam_end" );
    thread utility::delete_on_death( self.var_e75182c9826b644b.beamvfx );
    specificsettings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    
    while ( true )
    {
        if ( !self.var_e75182c9826b644b )
        {
            break;
        }
        
        self.var_e75182c9826b644b.var_d5765d50acacb150 = function_d63b37c2c983bf56();
        self.var_e75182c9826b644b.var_1007430e2ab9fc58 = function_6e3d4c7b81638567( self.var_e75182c9826b644b, var_d4184d8fb64620d4 );
        self.var_e75182c9826b644b.beamvfx function_13a61377e568d700( self.var_e75182c9826b644b.var_d5765d50acacb150, self.var_e75182c9826b644b.var_1007430e2ab9fc58.pos );
        var_47a4a6a0afd9ebbf = self.var_302c4e595988f21a ? self [[ self.var_302c4e595988f21a ]]( self.var_e75182c9826b644b.var_1007430e2ab9fc58.pos ) : 1;
        
        if ( level.players.size > 0 )
        {
            /#
                if ( getdvarint( @"hash_3b4fc3e73d8f98c9", 0 ) )
                {
                    circle( self.var_e75182c9826b644b.var_1007430e2ab9fc58.pos, specificsettings.var_78f1a6536e5ade83, undefined, ( 0, 1, 1 ), 0, 1 );
                }
            #/
            
            nearbyplayers = getplayersinradius( self.var_e75182c9826b644b.var_1007430e2ab9fc58.pos, specificsettings.var_78f1a6536e5ade83 );
            
            foreach ( player in nearbyplayers )
            {
                if ( !player.var_f468cf5c9e75db1 && !player.var_27aab356c363561a )
                {
                    player beam_impact_player( self, self.var_e75182c9826b644b.var_eaffd0f0b368aacb, self.var_e75182c9826b644b );
                }
            }
            
            if ( var_47a4a6a0afd9ebbf )
            {
                var_56a7db1bbb4b12e5 = getdvarfloat( @"hash_f0eab7863a72daf3", 50 );
                navmeshsnap = getclosestpointonnavmesh( self.var_e75182c9826b644b.var_1007430e2ab9fc58.pos, level.players[ 0 ], 0, 0, 0, 0 );
                var_47a4a6a0afd9ebbf = navmeshsnap && distancesquared( self.var_e75182c9826b644b.var_1007430e2ab9fc58.pos, navmeshsnap ) <= squared( var_56a7db1bbb4b12e5 );
            }
        }
        
        if ( self.var_113e179091297b80 )
        {
            var_b3681961876a01d9 = function_fa0a12b820b5811d( self.var_e75182c9826b644b.var_1007430e2ab9fc58.pos );
        }
        
        if ( self.var_e75182c9826b644b.var_1007430e2ab9fc58.hitground && var_47a4a6a0afd9ebbf && !var_b3681961876a01d9 )
        {
            self.var_e75182c9826b644b.targetent utility::function_32b24db3127bff40( "beam_target", "beam_target_on" );
            self.var_e75182c9826b644b.targetent.origin = self.var_e75182c9826b644b.var_1007430e2ab9fc58.pos;
            var_60d09eda7071fd5a = !self.var_e75182c9826b644b.var_3ee7906c66a02f19 || distance2dsquared( self.var_e75182c9826b644b.var_1007430e2ab9fc58.pos, self.var_e75182c9826b644b.var_3ee7906c66a02f19 ) >= squared( 250 );
            
            if ( var_60d09eda7071fd5a && !self.InAssaultRounds )
            {
                level thread namespace_11bfef4f5e98b9a1::function_3b9d49a506783a2f( self, self.var_e75182c9826b644b.var_1007430e2ab9fc58.pos, specificsettings.var_aeedc6e43aaf55c3, getdvarfloat( @"hash_200fad49eb5efb2e", specificsettings.var_19479a669d70e80d ), specificsettings.var_f2f81c951c3ddcf6, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3738d1332f70b824 );
                self.var_e75182c9826b644b.var_3ee7906c66a02f19 = self.var_e75182c9826b644b.var_1007430e2ab9fc58.pos;
                
                /#
                    if ( getdvarint( @"hash_3b4fc3e73d8f98c9", 0 ) )
                    {
                        level thread function_c5cf85f8aa004da1( self.var_e75182c9826b644b.var_1007430e2ab9fc58.pos, specificsettings.var_aeedc6e43aaf55c3, getdvarfloat( @"hash_200fad49eb5efb2e", specificsettings.var_19479a669d70e80d ) );
                    }
                #/
                
                if ( !isdefined( self.var_e75182c9826b644b.var_aa700e93561cd553 ) )
                {
                    self.var_e75182c9826b644b.var_aa700e93561cd553 = self.var_e75182c9826b644b.var_1007430e2ab9fc58.pos;
                }
                
                var_16a4ab47e7fdbec7 = spawnscriptable( "scriptable_zombie_diana_necrotic_beam_impact_boss_fight", self.var_e75182c9826b644b.var_1007430e2ab9fc58.pos, ( 0, 0, 0 ) );
                
                if ( var_16a4ab47e7fdbec7 )
                {
                    self.var_bea3ad7183a3e0ec[ self.var_bea3ad7183a3e0ec.size ] = var_16a4ab47e7fdbec7;
                    level thread function_4ca170e10afd0408( var_16a4ab47e7fdbec7, specificsettings.var_aeedc6e43aaf55c3, specificsettings.var_19479a669d70e80d, self );
                }
            }
            
            self.var_e75182c9826b644b.var_ab5097fbe7b297d1 = self.var_e75182c9826b644b.var_1007430e2ab9fc58.pos;
        }
        else
        {
            self.var_e75182c9826b644b.targetent utility::function_32b24db3127bff40( "beam_target", "off" );
        }
        
        if ( var_3421dd8ec85fe5f8 && vectordot2( self.var_e75182c9826b644b.var_eaffd0f0b368aacb, var_3421dd8ec85fe5f8 - self.var_e75182c9826b644b.var_1007430e2ab9fc58.pos ) < 0 )
        {
            utility::function_32b24db3127bff40( "necrotic_beam", "off_with_audio" );
            self notify( #"necrotic_beam_end" );
        }
        
        waitframe();
    }
}

// Namespace zombie_diana_necrotic_beam
// Params 0, eflags: 0x4
// Checksum 0xeee8712e, Offset: 0x1502
// Size: 0x7f
function private function_d63b37c2c983bf56()
{
    var_c2d140635f85f767 = self gettagorigin( "tag_mouth_fx", 1 );
    
    if ( !isdefined( var_c2d140635f85f767 ) )
    {
        if ( isdefined( self.var_d5765d50acacb150 ) )
        {
            return self.var_d5765d50acacb150;
        }
        
        var_62ad4cdd76a40603 = 200;
        var_d83cebdb6959705 = 100;
        var_c2d140635f85f767 = self.origin + anglestoup( self.angles ) * var_62ad4cdd76a40603 + anglestoforward( self.angles ) * var_d83cebdb6959705;
    }
    
    return var_c2d140635f85f767;
}

// Namespace zombie_diana_necrotic_beam
// Params 3, eflags: 0x4
// Checksum 0xb9c3405a, Offset: 0x158a
// Size: 0x46f
function private function_6e3d4c7b81638567( beaminfo, var_d4184d8fb64620d4, inflyover )
{
    var_f72913849c609c94 = getdvarfloat( @"hash_5ba3463ed655d19d", 15000 );
    talismanscriptable = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.talismanscriptable;
    
    if ( !beaminfo.var_1007430e2ab9fc58 || inflyover )
    {
        var_4287ed188cc03942 = vectorcross( beaminfo.var_eaffd0f0b368aacb, ( 0, 0, 1 ) );
        var_186da4f37d1da7fc = rotatepointaroundvector( var_4287ed188cc03942, beaminfo.var_eaffd0f0b368aacb, self.var_bf44f13272202612 );
        var_dec76700ef3272fe = beaminfo.var_d5765d50acacb150 + var_186da4f37d1da7fc * var_f72913849c609c94;
    }
    else
    {
        var_241c92799905fbfb = var_d4184d8fb64620d4 * beaminfo.var_eaffd0f0b368aacb;
        var_69d786029b3784ef = vectornormalize( beaminfo.var_1007430e2ab9fc58.pos + var_241c92799905fbfb - beaminfo.var_d5765d50acacb150 );
        var_dec76700ef3272fe = beaminfo.var_1007430e2ab9fc58.pos + var_69d786029b3784ef * var_f72913849c609c94;
    }
    
    ignoreents = beaminfo.var_316c974eb01d8fa;
    ignoreents = arraycombineunique( ignoreents, [ self ] );
    var_55557372632f518e = var_dec76700ef3272fe;
    
    /#
        if ( getdvarint( @"hash_3b4fc3e73d8f98c9", 0 ) )
        {
            sphere( beaminfo.var_d5765d50acacb150, 10, ( 1, 1, 0 ), 0, 1 );
            sphere( var_dec76700ef3272fe, 10, ( 1, 1, 0 ), 0, 1 );
            line( beaminfo.var_d5765d50acacb150, var_dec76700ef3272fe, ( 1, 1, 0 ), 1, 0, 1 );
        }
    #/
    
    contents = trace::create_default_contents();
    
    if ( !self.InAssaultRounds )
    {
        contents |= physics_createcontents( [ "physicscontents_ttlosclip" ] );
    }
    
    traceresult = trace::ray_trace_get_all_results( beaminfo.var_d5765d50acacb150, var_dec76700ef3272fe, ignoreents, contents, 0, 1 );
    
    foreach ( hitresult in traceresult )
    {
        if ( hitresult[ "hittype" ] == "hittype_scriptable" && hitresult[ "scriptable" ].type == talismanscriptable && hitresult[ "scriptable" ].state == "active" )
        {
            hitresult[ "scriptable" ] scriptabledodamage( 0, self, self, hitresult[ "position" ], var_69d786029b3784ef );
            hitsurface = 0;
        }
        
        if ( hitresult[ "hittype" ] == "hittype_world" && hitresult[ "surfacetype" ] != "surftype_water" || hitresult[ "hittype" ] == "hittype_entity" && hitresult[ "entity" ].classname != "script_brushmodel" )
        {
            if ( hitresult[ "hittype" ] == "hittype_entity" && isplayer( hitresult[ "entity" ] ) && !arraycontains( beaminfo.var_316c974eb01d8fa, hitresult[ "entity" ] ) && hitresult[ "entity" ].var_f468cf5c9e75db1 != 1 )
            {
                var_77781e1d3a1e20bf = hitresult[ "entity" ];
                var_77781e1d3a1e20bf beam_impact_player( self, beaminfo.var_eaffd0f0b368aacb, beaminfo );
                continue;
            }
            
            if ( distancesquared( beaminfo.var_d5765d50acacb150, hitresult[ "position" ] ) < distancesquared( beaminfo.var_d5765d50acacb150, var_55557372632f518e ) )
            {
                var_55557372632f518e = hitresult[ "position" ];
                hitsurface = !function_4aad082baf252738( var_55557372632f518e, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_aeedc6e43aaf55c3 );
            }
        }
    }
    
    /#
        if ( getdvarint( @"hash_3b4fc3e73d8f98c9", 0 ) )
        {
            sphere( var_55557372632f518e, 20, ( 1, 0, 0 ), 0, 1 );
        }
    #/
    
    return { #hitground:istrue( hitsurface ), #pos:var_55557372632f518e };
}

// Namespace zombie_diana_necrotic_beam
// Params 3, eflags: 0x4
// Checksum 0x611b0d66, Offset: 0x1a02
// Size: 0xed
function private beam_impact_player( inflictor, var_a5c82d3851cbb97, beaminfo )
{
    var_b0cc8cb427fd7b58 = 6;
    
    if ( arraycontains( beaminfo.var_316c974eb01d8fa, self ) )
    {
        return;
    }
    
    shellshock_utility::_shellshock( %"hash_3e853b61f7d7058a", #"damage", 1.5 );
    self dodamage( getdvarfloat( @"hash_eaf1f9a3de9ba12b", inflictor.var_d27f4fe48e41462f ), self.origin, self, self, "MOD_EXPLOSIVE", undefined, "torso_upper" );
    self.var_27aab356c363561a = 1;
    utility::function_a9cdce367aa4fef5( #"necrotic_beam_hit_player", var_b0cc8cb427fd7b58, #"game_ended", &function_ccd2e1a9eb8900b );
    callback::callback( "on_hornet_boss_beam_vo" );
    beaminfo.var_316c974eb01d8fa = arraycombineunique( beaminfo.var_316c974eb01d8fa, [ self ] );
}

// Namespace zombie_diana_necrotic_beam
// Params 1, eflags: 0x4
// Checksum 0xe787f8ee, Offset: 0x1af7
// Size: 0x57
function private function_fd8e17b0f00a4575( inflictor )
{
    self endon( #"death" );
    var_f07ec2e26d68259f = 0.3;
    wait var_f07ec2e26d68259f;
    
    if ( isalive( self ) )
    {
        while ( !self isonground() )
        {
            waitframe();
        }
    }
    
    if ( isalive( inflictor ) )
    {
        inflictor notify( #"stop_current_movement_prediction" );
    }
}

// Namespace zombie_diana_necrotic_beam
// Params 0, eflags: 0x4
// Checksum 0x837e8936, Offset: 0x1b56
// Size: 0xc
function private function_ccd2e1a9eb8900b()
{
    self.var_27aab356c363561a = undefined;
}

// Namespace zombie_diana_necrotic_beam
// Params 1, eflags: 0x4
// Checksum 0xbcdf2867, Offset: 0x1b6a
// Size: 0x127, Type: bool
function private function_fa0a12b820b5811d( pos )
{
    foreach ( lavaflow in utility::getstructarray( "lf_parent", "targetname" ) )
    {
        if ( ispointinvolume( pos, lavaflow.trigger ) )
        {
            return true;
        }
    }
    
    foreach ( borderlava in utility::getstructarray( "border_lv", "targetname" ) )
    {
        if ( ispointinvolume( pos, borderlava.trigger ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_diana_necrotic_beam
// Params 1, eflags: 0xc
// Checksum 0xa1d23015, Offset: 0x1c9a
// Size: 0x372
function private function_bb64b8e5b1d71b16( diana )
{
    self notify( #"hash_b1e11a934c0bdc3e" );
    self endon( #"hash_b1e11a934c0bdc3e" );
    diana endon( #"death" );
    diana endon( #"hash_c2c6c23b8b88b9e2" );
    var_b9f55e3331096e9c = 10000;
    var_3954b3e1b0a4cc49 = getdvarfloat( @"hash_d01add2634dfa76f", 280 );
    diana utility::waittill_notify_or_timeout( "necrotic_beam_fire", 4 );
    diana utility::waittill_notify_or_timeout( "necrotic_beam_end", getdvarfloat( @"hash_9e314f7c7c86b33a", diana.var_eae9ccfd2469d520 ) );
    var_602da605170591d4 = diana.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    
    if ( !isdefined( diana.var_abec8411e225b966 ) )
    {
        diana.var_abec8411e225b966 = getdvarfloat( @"hash_15a0da3c624e2469", var_602da605170591d4.var_63f5d62894bbbf21 );
    }
    
    if ( !isdefined( diana.var_92cadc58744429e8 ) )
    {
        diana.var_92cadc58744429e8 = getdvarint( @"hash_fcb2d80cd6624d9b", 100 );
    }
    
    diana.var_e75182c9826b644b.var_6f519aa544b31346 = [];
    var_a54600eb791d41c2 = diana.var_113e179091297b80;
    var_abec8411e225b966 = diana.var_abec8411e225b966;
    var_ea3b4ff6911ed389 = diana.var_e75182c9826b644b.var_ab5097fbe7b297d1;
    explosionstarttime = gettime();
    explosioncounter = 0;
    var_6975e430ea36c8d2 = diana.var_e75182c9826b644b.var_aa700e93561cd553;
    
    if ( !var_ea3b4ff6911ed389 || !var_6975e430ea36c8d2 )
    {
        return;
    }
    
    while ( vectordot2( diana.var_e75182c9826b644b.var_eaffd0f0b368aacb, var_ea3b4ff6911ed389 - var_6975e430ea36c8d2 ) > 0 && gettime() - explosionstarttime < var_b9f55e3331096e9c )
    {
        var_6975e430ea36c8d2 = explosioncounter * diana.var_92cadc58744429e8 * diana.var_e75182c9826b644b.var_eaffd0f0b368aacb;
        var_6975e430ea36c8d2 += diana.var_e75182c9826b644b.var_aa700e93561cd553;
        
        /#
            if ( getdvarint( @"hash_3b4fc3e73d8f98c9", 0 ) )
            {
                sphere( var_6975e430ea36c8d2, 12, ( 1, 0.5, 0 ), 0, 1 );
            }
        #/
        
        if ( diana.var_d4f29f1205f3f7b9 )
        {
            var_f3147cee9f76ba22 = 3;
            
            for ( j = 0; j < var_f3147cee9f76ba22 ; j++ )
            {
                explosionpos = utility::getrandompointincircle( var_6975e430ea36c8d2, var_3954b3e1b0a4cc49 );
                function_bdc69d8e43222fcd( explosionpos, diana, diana.var_e75182c9826b644b, var_a54600eb791d41c2 );
                explosioncounter++;
                wait var_abec8411e225b966;
            }
            
            continue;
        }
        
        function_bdc69d8e43222fcd( var_6975e430ea36c8d2, diana, diana.var_e75182c9826b644b, var_a54600eb791d41c2 );
        explosioncounter++;
        wait var_abec8411e225b966;
    }
    
    foreach ( hitent in diana.var_e75182c9826b644b.var_6f519aa544b31346 )
    {
        hitent.var_ecbd75d8039c11ed = undefined;
    }
    
    diana.var_e75182c9826b644b = undefined;
}

// Namespace zombie_diana_necrotic_beam
// Params 4, eflags: 0x4
// Checksum 0xfab52a0f, Offset: 0x2014
// Size: 0x357
function private function_bdc69d8e43222fcd( explosionpos, diana, beaminfo, var_a54600eb791d41c2 )
{
    var_bee1b073f8036d72 = utility::drop_to_ground( explosionpos, getdvarfloat( @"hash_c808d19d5b499a2e", 1000 ) );
    
    if ( var_bee1b073f8036d72 )
    {
        explosionpos = var_bee1b073f8036d72;
    }
    
    var_47a4a6a0afd9ebbf = diana.var_302c4e595988f21a ? diana [[ diana.var_302c4e595988f21a ]]( explosionpos ) : 1;
    
    if ( var_47a4a6a0afd9ebbf && level.players.size > 0 )
    {
        var_56a7db1bbb4b12e5 = getdvarfloat( @"hash_f0eab7863a72daf3", 50 );
        navmeshsnap = getclosestpointonnavmesh( explosionpos, level.players[ 0 ], 0, 0, 0, 0 );
        var_47a4a6a0afd9ebbf = navmeshsnap && distancesquared( explosionpos, navmeshsnap ) <= squared( var_56a7db1bbb4b12e5 );
    }
    
    if ( var_a54600eb791d41c2 )
    {
        var_b3681961876a01d9 = function_fa0a12b820b5811d( explosionpos );
    }
    
    var_c14477e9fce5476b = function_4aad082baf252738( explosionpos, diana.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_aeedc6e43aaf55c3 );
    
    /#
        if ( getdvarint( @"hash_3b4fc3e73d8f98c9", 0 ) )
        {
            var_8851e05a8ba18c01 = var_47a4a6a0afd9ebbf && !var_c14477e9fce5476b && !var_b3681961876a01d9;
            debugcolor = var_8851e05a8ba18c01 ? ( 0, 1, 0 ) : ( 1, 0, 0 );
            sphere( explosionpos, 15, debugcolor, 0, 1 );
            
            if ( var_8851e05a8ba18c01 )
            {
                circle( explosionpos, diana.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_aeedc6e43aaf55c3, undefined, ( 0, 1, 0 ), 0, 1 );
            }
        }
    #/
    
    if ( var_47a4a6a0afd9ebbf && !var_c14477e9fce5476b && !var_b3681961876a01d9 )
    {
        diana namespace_11bfef4f5e98b9a1::function_55e7322e9409d6cc( undefined, explosionpos, vectortoangles( beaminfo.var_eaffd0f0b368aacb ), diana.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_aeedc6e43aaf55c3, "MOD_EXPLOSIVE", diana.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_12555c2d12ccc9e3, diana.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_64676c02ded99bbc, 0, undefined, "necrotic_beam", undefined, undefined, undefined, diana.var_736ad81cb3c31ad1, 2500, 0.32, 1 );
    }
    
    nearbyplayers = getplayersinradius( explosionpos, diana.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_aeedc6e43aaf55c3 );
    
    foreach ( player in nearbyplayers )
    {
        if ( !player.var_ecbd75d8039c11ed )
        {
            player.var_ecbd75d8039c11ed = 1;
            beaminfo.var_6f519aa544b31346 = arraycombineunique( beaminfo.var_6f519aa544b31346, [ player ] );
        }
    }
}

// Namespace zombie_diana_necrotic_beam
// Params 4, eflags: 0x4
// Checksum 0x91a9d8cb, Offset: 0x2373
// Size: 0x9f
function private function_4ca170e10afd0408( scriptableent, aoeradius, scriptableduration, diana )
{
    diana endon( #"hash_c2c6c23b8b88b9e2" );
    endtime = gettime() + utility::function_4b74c15943231980( scriptableduration );
    
    while ( gettime() < endtime )
    {
        if ( !scriptableent )
        {
            return;
        }
        
        if ( function_4aad082baf252738( scriptableent.origin, aoeradius ) )
        {
            scriptableent utility::function_32b24db3127bff40( "beam_target", "off" );
            scriptableent freescriptable();
            return;
        }
        
        waitframe();
    }
    
    if ( scriptableent )
    {
        scriptableent freescriptable();
    }
}

// Namespace zombie_diana_necrotic_beam
// Params 2, eflags: 0x4
// Checksum 0xb4647b65, Offset: 0x241a
// Size: 0xe2, Type: bool
function private function_4aad082baf252738( pos, explosionradius )
{
    var_af6001e7336d9024 = 10;
    
    foreach ( talisman in level.talisman_system.talismans )
    {
        if ( talisman.state == "active" && distancesquared( pos, talisman.scriptable.origin ) <= squared( explosionradius + 240 + var_af6001e7336d9024 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_diana_necrotic_beam
// Params 2
// Checksum 0xeffb5fef, Offset: 0x2505
// Size: 0x61
function function_4f40e1bd28157c18( taskid, params )
{
    var_a5224197dac87f4f = gettime() - ( self.var_5c1fff7a74cd6f12 ?? 0 );
    cooldownscore = clamp( math::remap( var_a5224197dac87f4f, 0, utility::function_4b74c15943231980( self.var_5dec4cc95b2ae8a3 ), 0, 1 ), 0, 1 );
    return cooldownscore;
}

// Namespace zombie_diana_necrotic_beam
// Params 2
// Checksum 0x23e9d3cf, Offset: 0x256f
// Size: 0xcb
function function_7581cc981b5c4302( taskid, params )
{
    var_3e610e5ccf9068ea = 0;
    
    foreach ( var_2bdea747682d42f1 in self.var_f9e48b7ff2c39654 )
    {
        if ( var_2bdea747682d42f1 == "necrotic_beam" )
        {
            var_3e610e5ccf9068ea++;
        }
    }
    
    var_9a48b1aac439ed1d = clamp( math::remap( var_3e610e5ccf9068ea, self.var_6b1405438bf971d ?? 3, 0, 0, 1 ), 0, 1 );
    return var_9a48b1aac439ed1d;
}

// Namespace zombie_diana_necrotic_beam
// Params 0
// Checksum 0xdddafff9, Offset: 0x2643
// Size: 0x2d0
function function_e17d8c0df80cd369()
{
    self notify( #"hash_bcebadd15c233261" );
    self endon( #"hash_bcebadd15c233261" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"fly_over_beam_start" );
        thread function_d9dfd9fb17f246f();
        startpos = function_d63b37c2c983bf56();
        var_a7a414a1d5310fd2 = vectornormalize2( ( self.var_b14209598a0140ab.origin ?? startpos + anglestoforward( self.angles ) ) - startpos );
        var_7b1275d3886d46e8 = getdvarfloat( @"hash_d4c33ebe321f9204", 35 );
        self.var_b7b6040fe66b5208 = spawnstruct();
        self.var_b7b6040fe66b5208.var_316c974eb01d8fa = [];
        self.var_b7b6040fe66b5208.var_d5765d50acacb150 = startpos;
        self.var_b7b6040fe66b5208.var_eaffd0f0b368aacb = rotatepointaroundvector( ( 0, 0, 1 ), var_a7a414a1d5310fd2, var_7b1275d3886d46e8 );
        self.var_7a622700dff4dec7 = spawnstruct();
        self.var_7a622700dff4dec7.var_316c974eb01d8fa = [];
        self.var_7a622700dff4dec7.var_d5765d50acacb150 = startpos;
        self.var_7a622700dff4dec7.var_eaffd0f0b368aacb = rotatepointaroundvector( ( 0, 0, 1 ), var_a7a414a1d5310fd2, var_7b1275d3886d46e8 * -1 );
        var_41d7fca85ad6f084 = function_6e3d4c7b81638567( self.var_b7b6040fe66b5208, undefined, 1 );
        var_fa8f6de0264f2945 = function_6e3d4c7b81638567( self.var_7a622700dff4dec7, undefined, 1 );
        self.var_b7b6040fe66b5208.beamvfx = function_f5f8abcd7522eee2( utility::getfx( "diana_necrotic_beam_attack_vfx" ), startpos, var_41d7fca85ad6f084.pos );
        self.var_b7b6040fe66b5208.beamvfx namespace_9d8e359c3b1041e5::forcenetfieldhighlod_sharedfunc( 1 );
        thread utility::function_9a9165839779317f( self.var_b7b6040fe66b5208.beamvfx, "fly_over_beam_end" );
        thread utility::delete_on_death( self.var_b7b6040fe66b5208.beamvfx );
        self.var_7a622700dff4dec7.beamvfx = function_f5f8abcd7522eee2( utility::getfx( "diana_necrotic_beam_attack_vfx" ), startpos, var_fa8f6de0264f2945.pos );
        self.var_7a622700dff4dec7.beamvfx namespace_9d8e359c3b1041e5::forcenetfieldhighlod_sharedfunc( 1 );
        thread utility::function_9a9165839779317f( self.var_7a622700dff4dec7.beamvfx, "fly_over_beam_end" );
        thread utility::delete_on_death( self.var_7a622700dff4dec7.beamvfx );
        level thread function_6d613253abd500b9( self, "left" );
        level thread function_6d613253abd500b9( self, "right" );
        thread function_da3e75943944da32();
    }
}

// Namespace zombie_diana_necrotic_beam
// Params 0, eflags: 0x4
// Checksum 0x7791c8c4, Offset: 0x291b
// Size: 0x1ea
function private function_da3e75943944da32()
{
    self endon( #"death" );
    self endon( #"fly_over_beam_end" );
    specificsettings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self.var_b7b6040fe66b5208.targetent = spawn( "script_model_animated", self.var_b7b6040fe66b5208.var_d5765d50acacb150 );
    self.var_b7b6040fe66b5208.targetent setmodel( specificsettings.var_f4615ecafed1394d );
    self.var_b7b6040fe66b5208.targetent dontinterpolate();
    thread utility::function_9a9165839779317f( self.var_b7b6040fe66b5208.targetent, "fly_over_beam_end" );
    thread utility::delete_on_death( self.var_b7b6040fe66b5208.targetent );
    self.var_7a622700dff4dec7.targetent = spawn( "script_model_animated", self.var_7a622700dff4dec7.var_d5765d50acacb150 );
    self.var_7a622700dff4dec7.targetent setmodel( specificsettings.var_f4615ecafed1394d );
    self.var_7a622700dff4dec7.targetent dontinterpolate();
    thread utility::function_9a9165839779317f( self.var_7a622700dff4dec7.targetent, "fly_over_beam_end" );
    thread utility::delete_on_death( self.var_7a622700dff4dec7.targetent );
    
    while ( true )
    {
        startpos = function_d63b37c2c983bf56();
        self.var_b7b6040fe66b5208.var_d5765d50acacb150 = startpos;
        self.var_7a622700dff4dec7.var_d5765d50acacb150 = startpos;
        function_9db487d6fe0c4748( self.var_b7b6040fe66b5208, specificsettings );
        function_9db487d6fe0c4748( self.var_7a622700dff4dec7, specificsettings );
        waitframe();
    }
}

// Namespace zombie_diana_necrotic_beam
// Params 2, eflags: 0x4
// Checksum 0x821b13fb, Offset: 0x2b0d
// Size: 0x44c
function private function_9db487d6fe0c4748( beaminfo, specificsettings )
{
    beaminfo.var_1007430e2ab9fc58 = function_6e3d4c7b81638567( beaminfo, undefined, 1 );
    beaminfo.beamvfx function_13a61377e568d700( beaminfo.var_d5765d50acacb150, beaminfo.var_1007430e2ab9fc58.pos );
    var_47a4a6a0afd9ebbf = self.var_302c4e595988f21a ? self [[ self.var_302c4e595988f21a ]]( beaminfo.var_1007430e2ab9fc58.pos ) : 1;
    
    if ( level.players.size > 0 )
    {
        nearbyplayers = getplayersinradius( beaminfo.var_1007430e2ab9fc58.pos, specificsettings.var_78f1a6536e5ade83 );
        
        foreach ( player in nearbyplayers )
        {
            if ( !player.var_f468cf5c9e75db1 && !arraycontains( beaminfo.var_316c974eb01d8fa, player ) )
            {
                player beam_impact_player( self, beaminfo.var_eaffd0f0b368aacb, beaminfo );
            }
        }
        
        if ( var_47a4a6a0afd9ebbf )
        {
            var_56a7db1bbb4b12e5 = getdvarfloat( @"hash_f0eab7863a72daf3", 50 );
            navmeshsnap = getclosestpointonnavmesh( beaminfo.var_1007430e2ab9fc58.pos, level.players[ 0 ], 0, 0, 0, 0 );
            var_47a4a6a0afd9ebbf = navmeshsnap && distancesquared( beaminfo.var_1007430e2ab9fc58.pos, navmeshsnap ) <= squared( var_56a7db1bbb4b12e5 );
        }
    }
    
    var_b3681961876a01d9 = 0;
    
    if ( self.var_113e179091297b80 )
    {
        var_b3681961876a01d9 = function_fa0a12b820b5811d( beaminfo.var_1007430e2ab9fc58.pos );
    }
    
    if ( beaminfo.var_1007430e2ab9fc58.hitground && var_47a4a6a0afd9ebbf && !var_b3681961876a01d9 )
    {
        beaminfo.targetent utility::function_32b24db3127bff40( "beam_target", "beam_target_on" );
        beaminfo.targetent.origin = beaminfo.var_1007430e2ab9fc58.pos;
        var_60d09eda7071fd5a = !beaminfo.var_3ee7906c66a02f19 || distance2dsquared( beaminfo.var_1007430e2ab9fc58.pos, beaminfo.var_3ee7906c66a02f19 ) >= squared( 250 );
        
        if ( var_60d09eda7071fd5a )
        {
            level thread namespace_11bfef4f5e98b9a1::function_3b9d49a506783a2f( self, beaminfo.var_1007430e2ab9fc58.pos, specificsettings.var_aeedc6e43aaf55c3, getdvarfloat( @"hash_200fad49eb5efb2e", specificsettings.var_19479a669d70e80d ), specificsettings.var_f2f81c951c3ddcf6, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3738d1332f70b824 );
            beaminfo.var_3ee7906c66a02f19 = beaminfo.var_1007430e2ab9fc58.pos;
            
            if ( !isdefined( beaminfo.var_aa700e93561cd553 ) )
            {
                beaminfo.var_aa700e93561cd553 = beaminfo.var_1007430e2ab9fc58.pos;
            }
            
            var_16a4ab47e7fdbec7 = spawnscriptable( "scriptable_zombie_diana_necrotic_beam_impact_boss_fight", beaminfo.var_1007430e2ab9fc58.pos, ( 0, 0, 0 ) );
            
            if ( var_16a4ab47e7fdbec7 )
            {
                self.var_bea3ad7183a3e0ec[ self.var_bea3ad7183a3e0ec.size ] = var_16a4ab47e7fdbec7;
                level thread function_4ca170e10afd0408( var_16a4ab47e7fdbec7, specificsettings.var_aeedc6e43aaf55c3, specificsettings.var_19479a669d70e80d, self );
            }
        }
        
        beaminfo.var_ab5097fbe7b297d1 = beaminfo.var_1007430e2ab9fc58.pos;
        return;
    }
    
    beaminfo.targetent utility::function_32b24db3127bff40( "beam_target", "off" );
}

// Namespace zombie_diana_necrotic_beam
// Params 2, eflags: 0x4
// Checksum 0x6f6b3fad, Offset: 0x2f61
// Size: 0x334
function private function_6d613253abd500b9( diana, side )
{
    diana endon( #"death" );
    diana endon( #"hash_c2c6c23b8b88b9e2" );
    var_b9f55e3331096e9c = 10000;
    var_3954b3e1b0a4cc49 = getdvarfloat( @"hash_d01add2634dfa76f", 280 );
    diana utility::waittill_notify_or_timeout( "fly_over_beam_end", 6 );
    beaminfo = side == "left" ? diana.var_b7b6040fe66b5208 : diana.var_7a622700dff4dec7;
    
    if ( !beaminfo || !beaminfo.var_aa700e93561cd553 )
    {
        if ( side == "left" )
        {
            diana.var_b7b6040fe66b5208 = undefined;
            return;
        }
        
        diana.var_7a622700dff4dec7 = undefined;
        return;
    }
    
    var_602da605170591d4 = diana.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    
    if ( !isdefined( diana.var_abec8411e225b966 ) )
    {
        diana.var_abec8411e225b966 = getdvarfloat( @"hash_15a0da3c624e2469", var_602da605170591d4.var_63f5d62894bbbf21 );
    }
    
    if ( !isdefined( diana.var_92cadc58744429e8 ) )
    {
        diana.var_92cadc58744429e8 = getdvarint( @"hash_fcb2d80cd6624d9b", 100 );
    }
    
    beaminfo.var_6f519aa544b31346 = [];
    var_a54600eb791d41c2 = diana.var_113e179091297b80;
    var_abec8411e225b966 = diana.var_abec8411e225b966;
    var_ea3b4ff6911ed389 = beaminfo.var_ab5097fbe7b297d1;
    groundpathdir = vectornormalize2( var_ea3b4ff6911ed389 - beaminfo.var_aa700e93561cd553 );
    explosionstarttime = gettime();
    explosioncounter = 0;
    var_6975e430ea36c8d2 = beaminfo.var_aa700e93561cd553;
    
    while ( vectordot2( groundpathdir, var_ea3b4ff6911ed389 - var_6975e430ea36c8d2 ) > 0 && gettime() - explosionstarttime < var_b9f55e3331096e9c )
    {
        var_6975e430ea36c8d2 = explosioncounter * diana.var_92cadc58744429e8 * groundpathdir;
        var_6975e430ea36c8d2 += beaminfo.var_aa700e93561cd553;
        
        if ( diana.var_d4f29f1205f3f7b9 )
        {
            var_f3147cee9f76ba22 = 3;
            
            for ( j = 0; j < var_f3147cee9f76ba22 ; j++ )
            {
                explosionpos = utility::getrandompointincircle( var_6975e430ea36c8d2, var_3954b3e1b0a4cc49 );
                function_bdc69d8e43222fcd( explosionpos, diana, beaminfo, var_a54600eb791d41c2 );
                explosioncounter++;
                wait var_abec8411e225b966;
            }
            
            continue;
        }
        
        function_bdc69d8e43222fcd( var_6975e430ea36c8d2, diana, beaminfo, var_a54600eb791d41c2 );
        explosioncounter++;
        wait var_abec8411e225b966;
    }
    
    foreach ( hitent in beaminfo.var_6f519aa544b31346 )
    {
        hitent.var_ecbd75d8039c11ed = undefined;
    }
    
    if ( side == "left" )
    {
        diana.var_b7b6040fe66b5208 = undefined;
        return;
    }
    
    diana.var_7a622700dff4dec7 = undefined;
}

// Namespace zombie_diana_necrotic_beam
// Params 0, eflags: 0x4
// Checksum 0x747db9a0, Offset: 0x329d
// Size: 0x7d
function private function_d9dfd9fb17f246f()
{
    self endon( #"death" );
    var_b80b366b5cea53d9 = 3.5;
    var_c87788c10e35f2d = 2.5;
    utility::function_32b24db3127bff40( "necrotic_beam", "tell" );
    utility::waittill_notify_or_timeout( "fly_over_beam_start", var_b80b366b5cea53d9 );
    utility::function_32b24db3127bff40( "necrotic_beam", "spit" );
    utility::waittill_notify_or_timeout( "fly_over_beam_end", var_c87788c10e35f2d );
    utility::function_32b24db3127bff40( "necrotic_beam", "off_with_audio" );
}

/#

    // Namespace zombie_diana_necrotic_beam
    // Params 0
    // Checksum 0x9c3b878d, Offset: 0x3322
    // Size: 0x5c, Type: dev
    function necrotic_beam_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x114>" );
        devgui::add_devgui_func( "<dev string:x12b>", "<dev string:x13c>", &do_necrotic_beam );
        devgui::add_devgui_func( "<dev string:x14d>", "<dev string:x15e>", &function_b5c377473e427246 );
        devgui::add_devgui_func( "<dev string:x16f>", "<dev string:x18e>", &function_a513b6d4f56429f9, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_diana_necrotic_beam
    // Params 1
    // Checksum 0x54885043, Offset: 0x3386
    // Size: 0x66, Type: dev
    function do_necrotic_beam( params )
    {
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x1ad>" );
        
        if ( isdefined( diana ) )
        {
            diana.var_b14209598a0140ab = level.players[ 0 ];
            diana notify( #"necrotic_beam_start" );
        }
    }

    // Namespace zombie_diana_necrotic_beam
    // Params 1
    // Checksum 0xac6b5e9f, Offset: 0x33f4
    // Size: 0xa5, Type: dev
    function function_b5c377473e427246( params )
    {
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x1ad>" );
        
        if ( isdefined( diana ) )
        {
            diana.var_b14209598a0140ab = level.players[ 0 ];
            diana.var_7bd8c0a747b9f670 = "<dev string:x1ba>";
            diana.inflyover = 1;
            diana function_a265cb2399b739ab( diana.var_7bd8c0a747b9f670, 1 );
            diana asm::function_7256f5ba459c840b( "<dev string:x1c3>" );
            diana thread function_e17d8c0df80cd369();
        }
    }

    // Namespace zombie_diana_necrotic_beam
    // Params 2, eflags: 0x4
    // Checksum 0x9864dea1, Offset: 0x34a1
    // Size: 0x347, Type: dev
    function private function_a265cb2399b739ab( direction, isflyover )
    {
        params = { #var_315c3f93aa18970f:self.vantagepoint };
        
        switch ( self.vantagepoint )
        {
            case #"hash_fbd39e4f5634905a":
                switch ( direction )
                {
                    case #"hash_96815ce4f2a3dbc5":
                        self.vantagepoint = "<dev string:x1d7>";
                        break;
                    case #"hash_c9b3133a17a3b2d0":
                        self.vantagepoint = "<dev string:x1e1>";
                        break;
                    case #"hash_5e8d04fc8bad0698":
                        self.vantagepoint = "<dev string:x1e6>";
                        break;
                }
                
                break;
            case #"hash_a1e9b77432f55b0e":
                switch ( direction )
                {
                    case #"hash_96815ce4f2a3dbc5":
                        self.vantagepoint = "<dev string:x1cb>";
                        break;
                    case #"hash_c9b3133a17a3b2d0":
                        self.vantagepoint = "<dev string:x1e6>";
                        break;
                    case #"hash_5e8d04fc8bad0698":
                        self.vantagepoint = "<dev string:x1d7>";
                        break;
                }
                
                break;
            case #"hash_b9ff0a9f617355e4":
                switch ( direction )
                {
                    case #"hash_96815ce4f2a3dbc5":
                        self.vantagepoint = "<dev string:x1e1>";
                        break;
                    case #"hash_c9b3133a17a3b2d0":
                        self.vantagepoint = "<dev string:x1d7>";
                        break;
                    case #"hash_5e8d04fc8bad0698":
                        self.vantagepoint = "<dev string:x1cb>";
                        break;
                }
                
                break;
            case #"hash_22ce3b03c1e51a9c":
                switch ( direction )
                {
                    case #"hash_96815ce4f2a3dbc5":
                        self.vantagepoint = "<dev string:x1e6>";
                        break;
                    case #"hash_c9b3133a17a3b2d0":
                        self.vantagepoint = "<dev string:x1cb>";
                        break;
                    case #"hash_5e8d04fc8bad0698":
                        self.vantagepoint = "<dev string:x1e1>";
                        break;
                }
                
                break;
        }
        
        if ( isflyover )
        {
            var_f8a9c64333a5d723 = zombie_diana_targeting::function_f84be701d1a07953();
            
            if ( var_f8a9c64333a5d723 )
            {
                var_ad783f494bb96041 = self.vantagepoint;
                
                foreach ( var_315c3f93aa18970f in getarraykeys( self.vantagepoints ) )
                {
                    if ( distance2dsquared( var_f8a9c64333a5d723.origin, self.vantagepoints[ var_315c3f93aa18970f ].origin ) < distance2dsquared( var_f8a9c64333a5d723.origin, self.vantagepoints[ var_ad783f494bb96041 ].origin ) )
                    {
                        var_ad783f494bb96041 = var_315c3f93aa18970f;
                    }
                }
                
                self.vantagepoint = var_ad783f494bb96041;
            }
        }
        
        params.var_dc86ce9c653750f0 = self.vantagepoint;
        
        if ( !params.var_dc86ce9c653750f0 )
        {
            params.var_dc86ce9c653750f0 = "<dev string:x1e6>";
        }
        
        callback::callback( "<dev string:x1ec>", params );
    }

    // Namespace zombie_diana_necrotic_beam
    // Params 1
    // Checksum 0x1dc4f50f, Offset: 0x37f0
    // Size: 0xf7, Type: dev
    function function_a513b6d4f56429f9( params )
    {
        level.var_c2b04403174fae74 = 1;
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x1ad>" );
        
        if ( isdefined( diana ) )
        {
            while ( true )
            {
                diana waittill( #"necrotic_beam_end" );
                
                foreach ( var_1270bf1323449fe1 in diana.var_e75182c9826b644b.var_9f5f8bb24295ece0 )
                {
                    sphere( var_1270bf1323449fe1, 10, ( 1, 0, 0 ), 0, 1 );
                }
                
                waitframe();
            }
        }
    }

    // Namespace zombie_diana_necrotic_beam
    // Params 3, eflags: 0x4
    // Checksum 0x1c70de41, Offset: 0x38ef
    // Size: 0x7a, Type: dev
    function private function_c5cf85f8aa004da1( aoepos, aoeradius, aoeduration )
    {
        endtime = gettime() + utility::function_4b74c15943231980( aoeduration );
        
        while ( gettime() < endtime )
        {
            sphere( aoepos, 12, ( 1, 0.5, 0 ), 0, 1 );
            circle( aoepos, aoeradius, undefined, ( 1, 0.5, 0 ), 0, 1 );
            waitframe();
        }
    }

#/
