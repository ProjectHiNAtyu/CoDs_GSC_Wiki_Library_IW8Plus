// script_21453148428dc2c0  (hash_21453148428dc2c0.gscc) (size: 11511 Bytes / 0x2cf7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5949b634 (1498002996)
// size ...... 11511 (0x2cf7)
// includes .. 10  (offset: 0x29ff)
// strings ... 37  (offset: 0x2a4f)
// dev strs .. 15  (offset: 0x2c37)
// exports ... 25  (offset: 0x1bc3)
// cseg ...... 0x3e1 + 0x17e2 (0x1bc3)
// imports ... 86  (offset: 0x1fab)
// animtree1 . 0   (offset: 0x2cf7)
// animtree2 . 0   (offset: 0x2cf7)
#using script_2de83d6261680959;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace zombie_diana_necrotic_fan;

/#

    // Namespace zombie_diana_necrotic_fan
    // Params 0
    // Checksum 0x3dbd55c0, Offset: 0x3ff
    // Size: 0xd, Type: dev
    function function_cb5c579bde7f861()
    {
        level thread necrotic_fan_devgui();
    }

#/

// Namespace zombie_diana_necrotic_fan
// Params 0
// Checksum 0xd3800175, Offset: 0x414
// Size: 0x6f
function init_diana_necrotic_fan()
{
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ), "<dev string:x24>" );
    set_necrotic_fan_cooldown( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_6932d5e78e1d3dbb );
    set_necrotic_fan_anchor_point( self.origin + anglestoforward( self.angles ) * 100 );
    thread function_d27066d00847f206();
}

// Namespace zombie_diana_necrotic_fan
// Params 0
// Checksum 0x9ba5eef1, Offset: 0x48b
// Size: 0xe
function function_ad53746de75bf86()
{
    self notify( #"hash_5d49f7eae6380e21" );
}

// Namespace zombie_diana_necrotic_fan
// Params 1
// Checksum 0xfc705f2, Offset: 0x4a1
// Size: 0x17
function set_necrotic_fan_cooldown( cooldownseconds )
{
    self.var_6932d5e78e1d3dbb = cooldownseconds;
}

// Namespace zombie_diana_necrotic_fan
// Params 1
// Checksum 0x6e416797, Offset: 0x4c0
// Size: 0x17
function set_necrotic_fan_anchor_point( var_6ffdf2ceff7e2473 )
{
    self.var_ebc162ef0f971703 = var_6ffdf2ceff7e2473;
}

// Namespace zombie_diana_necrotic_fan
// Params 0, eflags: 0xc
// Checksum 0x8b15b02c, Offset: 0x4df
// Size: 0x122
function private function_d27066d00847f206()
{
    self notify( #"hash_90e1046e9fd37d83" );
    self endon( #"hash_90e1046e9fd37d83" );
    self endon( #"death" );
    self endon( #"hash_5d49f7eae6380e21" );
    
    while ( true )
    {
        self waittill( #"necrotic_fan_start" );
        zombie_diana_metabones::function_258cc64099d507fc( arrayrandomize( [ "wing_left", "wing_right" ] ) );
        self function_786bb6aa1b76c7ee( "in_idle_waiting_for_action", 1 );
        waitmsg = utility::waittill_any_in_array_or_timeout( [ "armor_break_start", "hibernation_start", "idle_loop_end" ], 2 );
        
        if ( waitmsg == "idle_loop_end" )
        {
            self.var_fbd2b9707b5bd16f = 1;
            asm::function_7256f5ba459c840b( "necrotic_fan_in" );
            self function_786bb6aa1b76c7ee( "in_idle_waiting_for_action", 0 );
            thread function_49e6210b9784bcc();
            utility::waittill_notify_or_timeout( "necrotic_fan_fire_start", 6.5 );
            utility::function_32b24db3127bff40( "necrotic_fan", "fire" );
            thread function_fee2b1a75f5301b2();
            level thread function_e2b4641d5645465e( self );
            thread function_ebf15bf54214617e();
            continue;
        }
        
        self function_786bb6aa1b76c7ee( "in_idle_waiting_for_action", 0 );
    }
}

// Namespace zombie_diana_necrotic_fan
// Params 0, eflags: 0x4
// Checksum 0xe7f46566, Offset: 0x609
// Size: 0x40
function private function_49e6210b9784bcc()
{
    self endon( #"death" );
    self endon( #"necrotic_fan_fire_start" );
    const_time_to_land = 3.8;
    utility::waittill_notify_or_timeout( "necrotic_fan_landing", const_time_to_land );
    function_83c63afddd94519f();
}

// Namespace zombie_diana_necrotic_fan
// Params 0, eflags: 0x4
// Checksum 0x4ab50541, Offset: 0x651
// Size: 0x44
function private function_83c63afddd94519f()
{
    playrumbleonposition( "zombie_diana_impact_rumble", self.origin );
    earthquakeadvanced( 0.7, 0.35, 0.175, 0.8, self.origin, 875, 1750, 3500 );
}

// Namespace zombie_diana_necrotic_fan
// Params 0, eflags: 0x4
// Checksum 0x813c0e22, Offset: 0x69d
// Size: 0x98
function private function_fee2b1a75f5301b2()
{
    self endon( #"death" );
    utility::waittill_notify_or_timeout( "necrotic_fan_fire_end", 7 );
    self.var_fbd2b9707b5bd16f = undefined;
    utility::function_32b24db3127bff40( "necrotic_fan", "off" );
    zombie_diana_metabones::function_7be0540f93d9f77f();
    self.var_51a3642a860acf96 = gettime();
    
    if ( self.var_f9e48b7ff2c39654.size + 1 > 6 )
    {
        self.var_f9e48b7ff2c39654[ self.var_f9e48b7ff2c39654.size - 1 ] = undefined;
    }
    
    self.var_f9e48b7ff2c39654 = arraycombine( [ "necrotic_fan" ], self.var_f9e48b7ff2c39654 );
}

// Namespace zombie_diana_necrotic_fan
// Params 0, eflags: 0x4
// Checksum 0x4aeb332d, Offset: 0x73d
// Size: 0x198
function private function_ebf15bf54214617e()
{
    self endon( #"death" );
    self endon( #"necrotic_fan_fire_end" );
    var_e8ee0e4fdce4fba0 = 10000;
    var_5131afe9852748ee = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    
    while ( true )
    {
        wait var_5131afe9852748ee.var_e62564e6e06590b2;
        tagorigin = self gettagorigin( "tag_mouth_fx" );
        tagangles = self gettagangles( "tag_mouth_fx" );
        forwarddir = anglestoforward( tagangles );
        traceresult = trace::ray_trace( tagorigin, tagorigin + forwarddir * var_e8ee0e4fdce4fba0, [ self ], trace::create_default_contents( 1 ), 0, 1 );
        groundpos = traceresult[ "position" ];
        playersinradius = getplayersinradius( groundpos, getdvarfloat( @"hash_70a1c9f63a549393", var_5131afe9852748ee.var_eccd3b983faf8f39 ) );
        
        foreach ( player in playersinradius )
        {
            if ( !isalive( player ) || player.var_f468cf5c9e75db1 )
            {
                continue;
            }
            
            player dodamage( var_5131afe9852748ee.var_658ab62e170e67f8, groundpos, self, self, "MOD_FIRE", undefined, "torso_upper" );
        }
    }
}

// Namespace zombie_diana_necrotic_fan
// Params 4, eflags: 0x4
// Checksum 0xc1e31cb3, Offset: 0x8dd
// Size: 0x112, Type: bool
function private function_9125d4e249b90d8f( player, nfblockers, var_73e88b737908f8b1, diana )
{
    if ( nfblockers.size == 0 )
    {
        return false;
    }
    
    foreach ( blocker in nfblockers )
    {
        if ( distance2d( player.origin, blocker.origin ) > 225 )
        {
            continue;
        }
        
        var_7799a9a5ff47d35f = vectornormalize2( blocker.origin - var_73e88b737908f8b1 );
        var_24d788177ba3e8cf = vectornormalize2( player.origin - blocker.origin );
        
        if ( vectordot( var_7799a9a5ff47d35f, var_24d788177ba3e8cf ) >= 0.707 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_diana_necrotic_fan
// Params 1, eflags: 0x4
// Checksum 0xfa138868, Offset: 0x9f8
// Size: 0x752
function private function_e2b4641d5645465e( diana )
{
    level endon( #"death" );
    diana endon( #"death" );
    var_51283d41fa0e955f = 1.5;
    level.var_d93860aec3ce5714 = 1;
    
    switch ( diana.vantagepoint )
    {
        case #"hash_fbd39e4f5634905a":
            diana.var_c435bf1af09a0686 = "we_necrotic_fan_south";
            break;
        case #"hash_a1e9b77432f55b0e":
            diana.var_c435bf1af09a0686 = "we_necrotic_fan_west";
            break;
        case #"hash_b9ff0a9f617355e4":
            diana.var_c435bf1af09a0686 = "we_necrotic_fan_north";
            break;
        case #"hash_22ce3b03c1e51a9c":
            diana.var_c435bf1af09a0686 = "we_necrotic_fan_east";
            break;
    }
    
    activateworldevent( diana.var_c435bf1af09a0686 );
    diana thread function_6eec6fd755f9d83d();
    diana.var_7209b234b5b93b6f = [];
    
    foreach ( var_d2d81d749e4b1cc9 in level.talisman_system.talismans )
    {
        if ( var_d2d81d749e4b1cc9.state != "active" )
        {
            event = function_f0d740add0c6ce06( var_d2d81d749e4b1cc9.location );
            
            if ( event )
            {
                event += diana.vantagepoint;
                activateworldevent( event );
                diana.var_7209b234b5b93b6f[ diana.var_7209b234b5b93b6f.size ] = event;
            }
        }
    }
    
    var_73e88b737908f8b1 = diana gettagorigin( "j_spine1" );
    
    foreach ( player in level.players )
    {
        player utility::delaycall( 3.75, &playlocalsound, #"hash_143da01944f80fa2" );
    }
    
    wait 4.5;
    nfblockers = utility::getstructarray( "nf_blocker", "targetname" );
    var_ae34f8103d7a2dd2 = diana.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    var_db5242bb093c758 = var_ae34f8103d7a2dd2.var_8a9ddeb10b486034 / 2;
    var_f78cf900a2975c9e = diana.origin;
    var_e5fb1d6ddf4247fe = anglestoforward( ( 0, vectortoyaw( diana.var_ebc162ef0f971703 - var_f78cf900a2975c9e ), 0 ) );
    
    /#
        var_53f1b2889be31408 = rotatepointaroundvector( anglestoup( diana.angles ), var_e5fb1d6ddf4247fe, getdvarfloat( @"hash_3d67bab831e4acc5", var_db5242bb093c758 ) );
        var_27c1af808b3be121 = rotatepointaroundvector( anglestoup( diana.angles ), var_e5fb1d6ddf4247fe, -1 * getdvarfloat( @"hash_3d67bab831e4acc5", var_db5242bb093c758 ) );
        diana notify( #"hash_60aa5c4444ea13b", var_e5fb1d6ddf4247fe, var_53f1b2889be31408, var_27c1af808b3be121 );
    #/
    
    var_601a117a58005cbf = 0;
    
    while ( var_601a117a58005cbf <= var_ae34f8103d7a2dd2.var_d4d9ac1d71b0f805 )
    {
        wait var_ae34f8103d7a2dd2.var_f2f81c951c3ddcf6;
        var_9e9936e557158bbd = getplayersandaiarrayinradius( var_f78cf900a2975c9e, getdvarfloat( @"hash_c3ef7658e8664077", var_ae34f8103d7a2dd2.var_65952bd5617f9e11 ) );
        
        if ( var_9e9936e557158bbd.size > 0 )
        {
            foreach ( var_191f5dc0a0e3c25e in var_9e9936e557158bbd )
            {
                if ( var_191f5dc0a0e3c25e == diana || !isalive( var_191f5dc0a0e3c25e ) )
                {
                    continue;
                }
                
                var_6aff71c0d612f760 = vectornormalize2( var_191f5dc0a0e3c25e.origin - var_f78cf900a2975c9e );
                var_b222458f074454e6 = vectortoyaw( var_e5fb1d6ddf4247fe );
                var_775169ed2b67dfde = vectortoyaw( var_6aff71c0d612f760 );
                
                if ( abs( angleclamp180( var_b222458f074454e6 - var_775169ed2b67dfde ) ) > var_db5242bb093c758 )
                {
                    continue;
                }
                
                if ( isplayer( var_191f5dc0a0e3c25e ) && function_9125d4e249b90d8f( var_191f5dc0a0e3c25e, nfblockers, var_73e88b737908f8b1, diana ) )
                {
                    continue;
                }
                
                if ( isplayer( var_191f5dc0a0e3c25e ) && !var_191f5dc0a0e3c25e.var_f468cf5c9e75db1 )
                {
                    var_191f5dc0a0e3c25e thread damage_effects::enableburnfxfortime( var_51283d41fa0e955f );
                    var_7c58356b77ac7472 = getdvarfloat( @"hash_7109185b65698776", var_ae34f8103d7a2dd2.var_3f022991a7d560b5 );
                    
                    if ( !var_191f5dc0a0e3c25e effect_slow::function_c1be3c9f2d0b92d2( "necrotic_fan_slow" ) )
                    {
                        var_191f5dc0a0e3c25e effect_slow::slow( "necrotic_fan_slow", var_ae34f8103d7a2dd2.var_33d414de31953061, var_ae34f8103d7a2dd2.var_f2f81c951c3ddcf6 + 0.1, diana );
                    }
                }
                else if ( isai( var_191f5dc0a0e3c25e ) && var_191f5dc0a0e3c25e.type == "zombie" )
                {
                    var_191f5dc0a0e3c25e callback::callback( "burned" );
                    var_7c58356b77ac7472 = function_fadf8488fad97088( var_ae34f8103d7a2dd2, var_191f5dc0a0e3c25e.aicategory, var_191f5dc0a0e3c25e.maxhealth );
                }
                
                if ( !var_191f5dc0a0e3c25e.var_f468cf5c9e75db1 )
                {
                    diana.ignore_turtle_shell = 1;
                    var_191f5dc0a0e3c25e dodamage( var_7c58356b77ac7472, var_191f5dc0a0e3c25e.origin, diana, diana, "MOD_EXPLOSIVE", undefined, "torso_upper" );
                    level callback::callback( "on_hornet_boss_fan_out_vo", { #player:var_191f5dc0a0e3c25e } );
                    diana.ignore_turtle_shell = 0;
                }
            }
        }
        
        var_601a117a58005cbf += var_ae34f8103d7a2dd2.var_f2f81c951c3ddcf6;
    }
    
    deactivateworldevent( diana.var_c435bf1af09a0686 );
    
    foreach ( event in diana.var_7209b234b5b93b6f )
    {
        if ( event )
        {
            deactivateworldevent( event );
        }
    }
    
    diana.var_7209b234b5b93b6f = [];
    diana.var_c435bf1af09a0686 = undefined;
    
    if ( isalive( diana ) )
    {
        diana notify( #"necrotic_fan_aoe_finished" );
    }
    
    level.var_d93860aec3ce5714 = undefined;
    level notify( #"necrotic_fan_aoe_finished" );
    
    foreach ( player in level.players )
    {
        if ( player effect_slow::function_c1be3c9f2d0b92d2( "necrotic_fan_slow" ) )
        {
            player effect_slow::function_80a4bd13b5ba303a( "necrotic_fan_slow" );
        }
    }
}

// Namespace zombie_diana_necrotic_fan
// Params 0, eflags: 0xc
// Checksum 0xaa39c340, Offset: 0x1152
// Size: 0x106
function private function_6eec6fd755f9d83d()
{
    self notify( #"hash_4a423b0e71eaf3ea" );
    self endon( #"hash_4a423b0e71eaf3ea" );
    self endon( #"necrotic_fan_aoe_finished" );
    
    while ( true )
    {
        var_d2d81d749e4b1cc9 = undefined;
        level waittill( #"hash_7748191fb2849b3b", var_d2d81d749e4b1cc9 );
        event_prefix = function_f0d740add0c6ce06( var_d2d81d749e4b1cc9.location );
        
        if ( event_prefix )
        {
            foreach ( event in self.var_7209b234b5b93b6f )
            {
                if ( issubstr( event, event_prefix ) )
                {
                    deactivateworldevent( event, 1 );
                    self.var_7209b234b5b93b6f = arrayremove( self.var_7209b234b5b93b6f, event );
                    break;
                }
            }
        }
    }
}

// Namespace zombie_diana_necrotic_fan
// Params 1, eflags: 0x4
// Checksum 0x683200b3, Offset: 0x1260
// Size: 0xaa
function private function_f0d740add0c6ce06( loc )
{
    event = undefined;
    
    switch ( loc ?? "" )
    {
        case #"hash_bf1a695c21e57fe4":
            event = "we_necrotic_fan_talisman_center_";
            break;
        case #"hash_4251cc3493f32059":
            event = "we_necrotic_fan_talisman_upper_left_";
            break;
        case #"hash_871f7094693eaeb6":
            event = "we_necrotic_fan_talisman_lower_left_";
            break;
        case #"hash_792e69ff38fa22f2":
            event = "we_necrotic_fan_talisman_lower_center_";
            break;
        case #"hash_1817f5d3fbe18d3a":
            event = "we_necrotic_fan_talisman_upper_right_";
            break;
        default:
            break;
    }
    
    return event;
}

// Namespace zombie_diana_necrotic_fan
// Params 3, eflags: 0x4
// Checksum 0x41763820, Offset: 0x1313
// Size: 0xa4
function private function_fadf8488fad97088( var_ae34f8103d7a2dd2, aicategory, aimaxhealth )
{
    switch ( aicategory )
    {
        case #"hash_84fcf5e68d7230b2":
            var_3a5935d846b2c9d1 = var_ae34f8103d7a2dd2.var_97245944ff32d5de;
            break;
        case #"hash_8c089e813083e510":
            var_3a5935d846b2c9d1 = var_ae34f8103d7a2dd2.var_4e984270e54d0112;
            break;
        case #"hash_7b0e2f2ed84f34":
        case #"hash_4e47eb6c32f5b165":
            var_3a5935d846b2c9d1 = var_ae34f8103d7a2dd2.var_b951c324fc575266;
            break;
        default:
            return 0;
    }
    
    return aimaxhealth * var_3a5935d846b2c9d1;
}

// Namespace zombie_diana_necrotic_fan
// Params 2
// Checksum 0x8ed8ef1, Offset: 0x13c0
// Size: 0x61
function function_7d6b05af39c385d2( taskid, params )
{
    var_312dc2619151955d = gettime() - ( self.var_51a3642a860acf96 ?? 0 );
    cooldownscore = clamp( math::remap( var_312dc2619151955d, 0, utility::function_4b74c15943231980( self.var_6932d5e78e1d3dbb ), 0, 1 ), 0, 1 );
    return cooldownscore;
}

// Namespace zombie_diana_necrotic_fan
// Params 2
// Checksum 0x16852908, Offset: 0x142a
// Size: 0xbf
function function_4f6dc6642e3076e0( taskid, params )
{
    var_5430c5d883edabaf = 0;
    
    foreach ( var_2bdea747682d42f1 in self.var_f9e48b7ff2c39654 )
    {
        if ( var_2bdea747682d42f1 == "necrotic_fan" )
        {
            var_5430c5d883edabaf++;
        }
    }
    
    var_9a48b1aac439ed1d = clamp( math::remap( var_5430c5d883edabaf, 3, 0, 0, 1 ), 0, 1 );
    return var_9a48b1aac439ed1d;
}

/#

    // Namespace zombie_diana_necrotic_fan
    // Params 0
    // Checksum 0x18c842da, Offset: 0x14f2
    // Size: 0x70, Type: dev
    function necrotic_fan_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x97>" );
        devgui::add_devgui_func( "<dev string:xae>", "<dev string:xbe>", &do_necrotic_fan );
        devgui::add_devgui_func( "<dev string:xce>", "<dev string:xec>", &function_a47d16fa4aad0177 );
        devgui::add_devgui_func( "<dev string:x10a>", "<dev string:x127>", &function_7d4183daba199900 );
        devgui::add_devgui_func( "<dev string:x144>", "<dev string:x164>", &function_d8c4ae71de8e83de );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_diana_necrotic_fan
    // Params 1
    // Checksum 0xb3466a85, Offset: 0x156a
    // Size: 0x4f, Type: dev
    function do_necrotic_fan( params )
    {
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x184>" );
        
        if ( isdefined( diana ) )
        {
            diana notify( #"necrotic_fan_start" );
        }
    }

    // Namespace zombie_diana_necrotic_fan
    // Params 1
    // Checksum 0xa4616a37, Offset: 0x15c1
    // Size: 0x53, Type: dev
    function function_7d4183daba199900( params )
    {
        if ( isdefined( level.var_574304c411327c6e ) && level.var_574304c411327c6e )
        {
            level.var_574304c411327c6e = 0;
            level notify( #"hash_68f6df8d7e2e06ef" );
            return;
        }
        
        level.var_574304c411327c6e = 1;
        level thread function_3d8b6ffc3cf9f47d();
    }

    // Namespace zombie_diana_necrotic_fan
    // Params 0
    // Checksum 0x5293ab7a, Offset: 0x161c
    // Size: 0x12a, Type: dev
    function function_3d8b6ffc3cf9f47d()
    {
        level endon( #"hash_68f6df8d7e2e06ef" );
        nfblockers = utility::getstructarray( "<dev string:x191>", "<dev string:x19c>" );
        
        while ( true )
        {
            foreach ( blocker in nfblockers )
            {
                sphere( blocker.origin, 20, ( 0, 1, 1 ), 0, 1 );
                circle( blocker.origin, 225, ( 0, 0, 1 ), ( 0, 1, 1 ), 0, 1 );
                print3d( blocker.origin + ( 0, 0, 30 ), blocker.script_noteworthy, ( 0, 1, 1 ), 1, 1, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace zombie_diana_necrotic_fan
    // Params 1
    // Checksum 0x4f794c4, Offset: 0x174e
    // Size: 0x53, Type: dev
    function function_d8c4ae71de8e83de( params )
    {
        if ( isdefined( level.var_1d6c0207e2d4373b ) && level.var_1d6c0207e2d4373b )
        {
            level.var_1d6c0207e2d4373b = 0;
            level notify( #"hash_a79bac5979e730bb" );
            return;
        }
        
        level.var_1d6c0207e2d4373b = 1;
        level thread function_2ee1cf44c763adc9();
    }

    // Namespace zombie_diana_necrotic_fan
    // Params 0
    // Checksum 0xee1830c4, Offset: 0x17a9
    // Size: 0x162, Type: dev
    function function_2ee1cf44c763adc9()
    {
        level endon( #"hash_a79bac5979e730bb" );
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x184>" );
        
        if ( !isdefined( diana ) )
        {
            return;
        }
        
        var_602da605170591d4 = diana.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
        
        while ( true )
        {
            tagorigin = diana gettagorigin( "<dev string:x1a7>" );
            tagangles = diana gettagangles( "<dev string:x1a7>" );
            forwarddir = anglestoforward( tagangles );
            traceresult = trace::ray_trace( tagorigin, tagorigin + forwarddir * 10000, [ diana ], trace::create_default_contents(), 0, 1 );
            groundpos = traceresult[ "<dev string:x1b4>" ];
            fireradius = getdvarfloat( @"hash_70a1c9f63a549393", var_602da605170591d4.var_eccd3b983faf8f39 );
            
            if ( groundpos )
            {
                sphere( groundpos, 20, ( 1, 0.5, 0 ), 0, 1 );
                circle( groundpos, fireradius, ( 0, 0, 1 ), ( 1, 0.5, 0 ), 0, 1 );
                line( tagorigin, groundpos, ( 1, 0.5, 0 ), 1, 0, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace zombie_diana_necrotic_fan
    // Params 1
    // Checksum 0xedead5e1, Offset: 0x1913
    // Size: 0x2b0, Type: dev
    function function_a47d16fa4aad0177( params )
    {
        level.var_c2b04403174fae74 = 1;
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x184>" );
        
        if ( isdefined( diana ) )
        {
            while ( true )
            {
                diana waittill( #"hash_60aa5c4444ea13b", var_e5fb1d6ddf4247fe, var_f7f3137eddc2179, var_1265a8ac1e7ea65e );
                var_602da605170591d4 = diana.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
                line( diana.origin, diana.origin + var_e5fb1d6ddf4247fe * getdvarfloat( @"hash_c3ef7658e8664077", var_602da605170591d4.var_65952bd5617f9e11 ), ( 1, 0, 0 ), 1, 0, 1000 );
                line( diana.origin, diana.origin + var_f7f3137eddc2179 * getdvarfloat( @"hash_c3ef7658e8664077", var_602da605170591d4.var_65952bd5617f9e11 ), ( 1, 0, 0 ), 1, 0, 1000 );
                line( diana.origin, diana.origin + var_1265a8ac1e7ea65e * getdvarfloat( @"hash_c3ef7658e8664077", var_602da605170591d4.var_65952bd5617f9e11 ), ( 1, 0, 0 ), 1, 0, 1000 );
                line( diana.origin + var_f7f3137eddc2179 * getdvarfloat( @"hash_c3ef7658e8664077", var_602da605170591d4.var_65952bd5617f9e11 ), diana.origin + var_e5fb1d6ddf4247fe * getdvarfloat( @"hash_c3ef7658e8664077", var_602da605170591d4.var_65952bd5617f9e11 ), ( 1, 0, 0 ), 1, 0, 1000 );
                line( diana.origin + var_1265a8ac1e7ea65e * getdvarfloat( @"hash_c3ef7658e8664077", var_602da605170591d4.var_65952bd5617f9e11 ), diana.origin + var_e5fb1d6ddf4247fe * getdvarfloat( @"hash_c3ef7658e8664077", var_602da605170591d4.var_65952bd5617f9e11 ), ( 1, 0, 0 ), 1, 0, 1000 );
                circle( ( -24704, 42048, 16626 ), getdvarfloat( @"hash_c919c634dd3ae10b", 1200 ), ( 0, 0, 1 ), ( 0, 0, 1 ), 0, 1000 );
                sphere( ( -24704, 42048, 16626 ), 20, ( 0, 1, 0 ), 0, 1000 );
                waitframe();
            }
        }
    }

#/
