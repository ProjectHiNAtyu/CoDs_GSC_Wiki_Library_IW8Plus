// script_193e3e231841082f  (hash_193e3e231841082f.gscc) (size: 30363 Bytes / 0x769b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7927e2b (127041067)
// size ...... 30363 (0x769b)
// includes .. 15  (offset: 0x6d17)
// strings ... 79  (offset: 0x6d8f)
// dev strs .. 70  (offset: 0x733b)
// exports ... 54  (offset: 0x477b)
// cseg ...... 0x5af + 0x41cc (0x477b)
// imports ... 221 (offset: 0x4feb)
// animtree1 . 0   (offset: 0x769b)
// animtree2 . 0   (offset: 0x769b)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_deathworm\zombie_deathworm_arena;
#using scripts\common\ai\aitypes\zombie_deathworm\zombie_deathworm_metabones;
#using scripts\common\ai\stealth\utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\metabone;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\vision_utility;

#namespace namespace_473bdc208d3e708a;

/#

    // Namespace namespace_473bdc208d3e708a
    // Params 1
    // Checksum 0x5a950077, Offset: 0x5cd
    // Size: 0x17, Type: dev
    function init_burrow_precache( aitypescriptbundle )
    {
        level thread function_fc0e1deee9cb3d5e();
    }

#/

// Namespace namespace_473bdc208d3e708a
// Params 0
// Checksum 0x6add1225, Offset: 0x5ec
// Size: 0x153
function init_burrow()
{
    self.var_7e46b2ec66222b8e = [];
    self.var_999c41688f43106a = 0;
    self.var_59bf24d70026a084 = undefined;
    self.var_eec4b26e434824fc = undefined;
    self.var_da953d63dbd6053a = 0;
    self.var_205c771cbff58dbe = throttle::throttle_initialize( "worm_unburrow_spot", 1, level.framedurationseconds );
    self.var_83911c99c3fcc262 = 2;
    set_perfect_awareness( 1 );
    self.var_42c5553074544fc8 = [];
    self.worm_underground_ent = spawn( "script_model", self.origin );
    self.worm_underground_ent setmodel( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_34795e3cf2174cd4 );
    self.worm_underground_ent utility::function_7c10ea82c1e305b8( "dust_kickup", "off" );
    thread utility::delete_on_death( self.worm_underground_ent );
    self.var_b0a5bbcd2327e264 = spawn( "script_model", self.origin );
    thread function_fbe3d3cb46e1a028( self, self.var_b0a5bbcd2327e264 );
    callback::add( "on_zombie_ai_killed", &function_3695bbaa5fc2bea );
    self.var_7b1f7e0bb8df49f = getdvarint( @"hash_805b4dc0a122c30d", 1 );
    asm::asm_setstate( "emerge" );
    thread function_dc64d46cb981340c();
    
    /#
        function_e59323980bee407();
    #/
}

// Namespace namespace_473bdc208d3e708a
// Params 0
// Checksum 0x690d771a, Offset: 0x747
// Size: 0x52
function function_dc64d46cb981340c()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    state = asm::asm_getcurrentstate( self.asmname );
    
    if ( state == "emerge" )
    {
        utility::function_32b24db3127bff40( "audio", "emerge" );
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 3
// Checksum 0x7b4a777f, Offset: 0x7a1
// Size: 0x145
function function_ef44001f7f580b63( asmname, statename, params )
{
    /#
        burrow_print( "<dev string:x24>" );
    #/
    
    utility::ent_flag_set( "is_underground" );
    self setscriptablepartstate( "ambient_audio", "off" );
    utility::function_32b24db3127bff40( "base", "off" );
    self.var_83911c99c3fcc262 = 2;
    
    if ( isai( self.enemy ) )
    {
        self.var_83911c99c3fcc262 = 0;
    }
    else if ( isplayer( self.enemy ) )
    {
        self.var_83911c99c3fcc262 = 1;
    }
    
    set_perfect_awareness( 0 );
    self.var_999c41688f43106a = gettime();
    self.var_59bf24d70026a084 = undefined;
    self.var_eec4b26e434824fc = undefined;
    self.var_da953d63dbd6053a = 0;
    closest_tacpoint = findclosesttacpoint( self.origin );
    
    if ( isdefined( closest_tacpoint ) )
    {
        self.var_17f45fd4407379ae = closest_tacpoint.roomindex;
    }
    
    thread listen_for_player_events();
    thread update_screenshake( self.worm_underground_ent );
    function_3559e36ecd5987e0();
    thread function_933a125e28cb04b5();
    self invisiblenotsolid();
    self hide();
    utility::function_687d8d65c40a5f86( "combat", &function_91cb4362245baa84 );
}

// Namespace namespace_473bdc208d3e708a
// Params 4
// Checksum 0x5215fe03, Offset: 0x8ee
// Size: 0x39, Type: bool
function function_43cb559dc3586520( asmname, statename, tostatename, params )
{
    if ( utility::ent_flag( "can_emerge" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_473bdc208d3e708a
// Params 4
// Checksum 0x74e72a30, Offset: 0x930
// Size: 0x39, Type: bool
function function_9a0bd3372a7275fc( asmname, statename, tostatename, params )
{
    if ( utility::ent_flag( "can_emerge_attack" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_473bdc208d3e708a
// Params 4
// Checksum 0x5735580f, Offset: 0x972
// Size: 0x48, Type: bool
function function_410dc01c244d7e23( asmname, statename, tostatename, params )
{
    if ( utility::ent_flag( "can_emerge_attack" ) && utility::ent_flag( "can_emerge_attack_swallow" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_473bdc208d3e708a
// Params 3
// Checksum 0x1416273e, Offset: 0x9c3
// Size: 0x156
function function_38a70de9617e067b( asmname, statename, params )
{
    /#
        burrow_print( "<dev string:x36>" );
    #/
    
    self.var_7e46b2ec66222b8e = function_46f9072493651dc9( self.var_7e46b2ec66222b8e );
    set_perfect_awareness( 1 );
    self function_e8726d980fa12944();
    utility::function_32b24db3127bff40( "base", "on" );
    utility::delaycall( 0.5, &visiblesolid );
    self show();
    self.turnrate = getdvarfloat( @"hash_3ee5b89399c33924", 0.2 );
    utility::ent_flag_clear( "can_emerge" );
    utility::ent_flag_clear( "can_emerge_attack" );
    utility::ent_flag_clear( "can_emerge_attack_swallow" );
    self notify( #"start_emerge" );
    self.worm_underground_ent utility::ent_flag_clear( "is_underground" );
    
    if ( isdefined( self.worm_underground_ent ) )
    {
        target_location = self.worm_underground_ent.origin;
        to_target_location = target_location - self.origin;
        to_target_yaw = vectortoyaw( to_target_location );
        self forceteleport( target_location, ( 0, to_target_yaw, 0 ) );
    }
    
    thread function_d4261b9e41f64f43();
    thread utility::thread_on_notify( "emerge_from_ground", &on_emerge_from_ground, self, self, "leave_underground" );
}

// Namespace namespace_473bdc208d3e708a
// Params 3
// Checksum 0xdbe39570, Offset: 0xb21
// Size: 0x10c
function function_689a3485b676dbfe( asmname, statename, params )
{
    function_6d96c980e89bc817();
    self visiblesolid();
    self show();
    utility::ent_flag_clear( "can_emerge" );
    utility::ent_flag_clear( "can_emerge_attack" );
    utility::ent_flag_clear( "can_emerge_attack_swallow" );
    utility::ent_flag_clear( "is_underground" );
    utility::ent_flag_clear( "return_home" );
    utility::ent_flag_clear( "chase_directly" );
    self.var_42c5553074544fc8 = [];
    self.var_c6cd6511556ae4e4 = self.health / self.maxhealth;
    var_4912869f02b165bf = [[ self.var_24610c747736231e ]]();
    cooldown = getdvarint( @"worm_beam_cooldown", 40000 );
    
    if ( var_4912869f02b165bf >= 13 )
    {
        cooldown = int( cooldown * 0.25 );
    }
    
    ai::set_blackboard_cooldown( "burrow_cooldown", cooldown );
    self function_786bb6aa1b76c7ee( "in_burrow", 0 );
    self notify( #"leave_underground" );
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0xe687aabc, Offset: 0xc35
// Size: 0x1a0
function private on_emerge_from_ground()
{
    thread utility::thread_on_notify( "release_target_from_mouth", &function_79ae897c56797df4, self, self, "leave_underground" );
    state = asm::asm_getcurrentstate( self.asmname );
    
    if ( state == "emerge_attack_swallow" )
    {
        utility::function_32b24db3127bff40( "audio", "emerge_sharkbite" );
    }
    else if ( state == "emerge" || state == "emerge_attack" )
    {
        utility::function_32b24db3127bff40( "audio", "emerge" );
    }
    
    self setscriptablepartstate( "ambient_audio", "ambient_aboveground" );
    self.worm_underground_ent setscriptablepartstate( "ambient_audio", "off" );
    
    if ( isdefined( self.var_b0a5bbcd2327e264 ) )
    {
        self.var_b0a5bbcd2327e264 thread liftoff_ent( self );
        thread utility::thread_on_notify( "swallow_in_air", &attempt_swallow_in_air, self, self, "leave_underground" );
    }
    
    players = namespace_9d8e359c3b1041e5::getplayersinradiussharedfunc( self.origin, 500 );
    
    foreach ( player in players )
    {
        if ( distance2dsquared( player.origin, self.origin ) > squared( 200 ) )
        {
            function_bf098f0ff7c9c383( player, self.origin );
        }
    }
    
    /#
        burrow_print( "<dev string:x43>" );
    #/
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0x91a237c, Offset: 0xddd
// Size: 0x10a
function private function_79ae897c56797df4()
{
    foreach ( var_300d072535d95263 in self.var_7e46b2ec66222b8e )
    {
        if ( !isalive( var_300d072535d95263 ) || var_300d072535d95263.aicategory == "boss" )
        {
            continue;
        }
        
        if ( !isai( var_300d072535d95263 ) )
        {
            continue;
        }
        
        if ( var_300d072535d95263.aicategory != "special" && var_300d072535d95263.aicategory != "elite" && var_300d072535d95263.aicategory != "hvt" )
        {
            continue;
        }
        
        var_300d072535d95263 kill( var_300d072535d95263.origin, self, self, "MOD_MELEE" );
    }
    
    /#
        burrow_print( "<dev string:x56>" );
    #/
}

// Namespace namespace_473bdc208d3e708a
// Params 0
// Checksum 0x51abb63, Offset: 0xeef
// Size: 0x2d9
function function_f4a77d5d66639ff4()
{
    if ( self.var_7e46b2ec66222b8e.size <= 0 )
    {
        return;
    }
    
    var_f06c3d8143b76949 = self gettagorigin( "j_head" );
    aim_pos = self.origin + anglestoforward( self.angles ) * getdvarfloat( @"hash_87762a25acc5544a", 1200 );
    var_97722ff51b39f8ca = 2000;
    to_aim_pos = vectornormalize( aim_pos - var_f06c3d8143b76949 );
    var_8806c7b13081c5d7 = 50;
    self function_e8726d980fa12944();
    thread function_8ede3699497357a0();
    var_560954bf7c7084d7 = 0;
    
    foreach ( var_300d072535d95263 in self.var_7e46b2ec66222b8e )
    {
        if ( !isalive( var_300d072535d95263 ) || var_300d072535d95263.aicategory == "boss" )
        {
            continue;
        }
        
        if ( isplayer( var_300d072535d95263 ) )
        {
            var_300d072535d95263 utility::function_32b24db3127bff40( "deathwormVFX", "spitout" );
            var_300d072535d95263 vision_utility::function_6cb9d8e0202ee81( "zm_jup_death_worm", 0.05 );
            var_300d072535d95263 val::reset( "ai_worm_grab", "freezecontrols" );
            var_300d072535d95263 playerunlinkblend( 0.2, 1, 1, 1, 1 );
            var_300d072535d95263 knockback( to_aim_pos, var_97722ff51b39f8ca );
            var_300d072535d95263 showlegs();
            var_300d072535d95263 val::reset( "zm_deathworm", "allow_toggle_third_person" );
            
            if ( var_300d072535d95263.was_third_person )
            {
                var_300d072535d95263.was_third_person = undefined;
                var_300d072535d95263 setcamerathirdperson( 1 );
            }
            
            screenshake_for_player( var_300d072535d95263 );
            var_300d072535d95263 thread function_a4d4d319b9976483( var_300d072535d95263, self );
            var_300d072535d95263 skydive_beginfreefall();
        }
        else if ( isai( var_300d072535d95263 ) )
        {
            if ( isdefined( var_300d072535d95263.var_6da303dd1af5281c ) )
            {
                var_300d072535d95263 unlink();
                var_300d072535d95263 [[ var_300d072535d95263.var_6da303dd1af5281c ]]( aim_pos, 7500 );
            }
            else
            {
                var_300d072535d95263 kill( var_300d072535d95263.origin, self, self, "MOD_MELEE" );
                corpse = var_300d072535d95263 getcorpseentity();
                
                if ( isdefined( corpse ) )
                {
                    corpse startragdollfromimpact( "torso_lower", anglestoforward( self.angles ) * var_97722ff51b39f8ca * var_8806c7b13081c5d7 );
                }
            }
        }
        
        var_560954bf7c7084d7 = 1;
        var_300d072535d95263 utility::ent_flag_clear( "in_worm_mouth" );
        self.var_7e46b2ec66222b8e = arrayremove( self.var_7e46b2ec66222b8e, var_300d072535d95263 );
        
        /#
            if ( debug_burrow() )
            {
                burrow_print( "<dev string:x70>", aim_pos );
                line( var_f06c3d8143b76949, aim_pos, ( 1, 0, 0 ) );
            }
        #/
    }
    
    if ( var_560954bf7c7084d7 )
    {
        utility::function_7c10ea82c1e305b8( "mouth_gibbed", "mouth_gibbed_fire_on" );
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 1, eflags: 0x4
// Checksum 0xa9b9dd63, Offset: 0x11d0
// Size: 0x13
function private function_3695bbaa5fc2bea( params )
{
    function_f4a77d5d66639ff4();
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0xb5d2dfc4, Offset: 0x11eb
// Size: 0x17
function private function_8ede3699497357a0()
{
    self endon( #"death" );
    wait 1;
    self visiblesolid();
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0x87abc9b, Offset: 0x120a
// Size: 0x30f
function private function_d4261b9e41f64f43()
{
    self endon( #"death" );
    self endon( #"release_target_from_mouth" );
    self endon( #"leave_underground" );
    var_553ea9de41c02e15 = 0.75;
    var_f06c3d8143b76949 = self gettagorigin( "tag_fx_mouth" );
    grenades = getentitiesinradiusfrompartitiongrid( var_f06c3d8143b76949, 400, createentitytypemask( [ "etype_missile" ] ), [] );
    
    if ( isdefined( grenades ) )
    {
        foreach ( grenade in grenades )
        {
            if ( isdefined( grenade ) && grenade.classname != "rocket" )
            {
                grenade linkto( self, "j_inner_jaw" );
            }
        }
    }
    
    while ( true )
    {
        var_f06c3d8143b76949 = self gettagorigin( "tag_fx_mouth" );
        potential_targets = getplayersandaiarrayinradius( var_f06c3d8143b76949, 200 );
        
        foreach ( target in potential_targets )
        {
            if ( target == self )
            {
                continue;
            }
            
            if ( target utility::ent_flag( "in_worm_mouth" ) )
            {
                continue;
            }
            
            if ( isai( target ) && distancesquared( target.origin, var_f06c3d8143b76949 ) > squared( 200 * var_553ea9de41c02e15 ) )
            {
                /#
                    burrow_print( "<dev string:x82>" + target getentitynumber() + "<dev string:x8f>", target.origin + ( 0, 0, 70 ) );
                #/
                
                continue;
            }
            
            if ( isplayer( target ) && !arraycontains( self.var_42c5553074544fc8, target ) )
            {
                if ( !target utility::ent_flag( "knockback_by_unburrow" ) )
                {
                    target utility::ent_flag_set( "knockback_by_unburrow" );
                    target thread utility::ent_flag_clear_delayed( "knockback_by_unburrow", 6 );
                    target dodamage( 250, var_f06c3d8143b76949, self, self, "MOD_IMPACT", undefined, undefined, undefined, 65536 );
                    target setorigin( target.origin + ( 0, 0, 50 ), 1 );
                    target knockback( ( 0, 0, 1 ) + anglestoforward( self.origin ) * 0.2, getdvarfloat( @"hash_55af88022caa829b", 1000 ) );
                }
                
                continue;
            }
            
            if ( isai( target ) )
            {
                function_e918d59b09e09aa9( target, self.origin, 250 );
            }
        }
        
        /#
            if ( debug_burrow() )
            {
                sphere( var_f06c3d8143b76949, 200, ( 1, 0, 0 ) );
            }
        #/
        
        waitframe();
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 1, eflags: 0x4
// Checksum 0xbec34f52, Offset: 0x1521
// Size: 0x135
function private function_67d71a6a52806b3b( unburrow_pos )
{
    players = utility::playersincylinder( unburrow_pos, 200, undefined, 200 );
    
    /#
        if ( debug_burrow() )
        {
            cylinder( unburrow_pos, unburrow_pos + ( 0, 0, 200 ), 200 );
            sphere( unburrow_pos, 200, ( 1, 0, 0 ) );
            burrow_print( "<dev string:x9b>", unburrow_pos );
        }
    #/
    
    if ( players.size <= 0 )
    {
        return [];
    }
    
    var_b6004d37d44e185d = [];
    
    foreach ( player in players )
    {
        if ( !self.use_lethal_attacks && isdefined( player.armorhealth ) && player.armorhealth > 0 )
        {
            continue;
        }
        
        if ( player.health <= 250 )
        {
            var_b6004d37d44e185d[ var_b6004d37d44e185d.size ] = player;
        }
    }
    
    return var_b6004d37d44e185d;
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0xc461209, Offset: 0x165f
// Size: 0x1eb
function private attempt_swallow_in_air()
{
    if ( isdefined( self.var_b0a5bbcd2327e264 ) && isdefined( self.var_b0a5bbcd2327e264.players ) )
    {
        foreach ( target in self.var_b0a5bbcd2327e264.players )
        {
            if ( self.var_7b1f7e0bb8df49f )
            {
                var_e91b2b195e994ecf = arraycontains( self.var_efb9a8da17df5f6d, target );
                
                if ( !var_e91b2b195e994ecf )
                {
                    continue;
                }
            }
            
            target val::set( "ai_worm_grab", "freezecontrols" );
            target dodamage( 30, self.origin, self, self, "MOD_IMPACT", undefined, undefined, undefined, 65536 );
            swallowed = function_e918d59b09e09aa9( target, self.origin, 250, var_e91b2b195e994ecf );
            
            if ( !swallowed )
            {
                target unlink();
                target setorigin( target.origin + ( 0, 0, 50 ), 1 );
                target knockback( ( 0, 0, 1 ), getdvarfloat( @"hash_55af88022caa829b", 1000 ) );
                target val::reset( "ai_worm_grab", "freezecontrols" );
                target dodamage( 250, self.origin, self, self, "MOD_IMPACT", undefined, undefined, undefined, 65536 );
            }
        }
        
        self.var_b0a5bbcd2327e264.players = [];
    }
    
    if ( self.var_7b1f7e0bb8df49f )
    {
        if ( self.var_efb9a8da17df5f6d )
        {
            self.var_efb9a8da17df5f6d = [];
        }
        
        self notify( #"hash_7e728bca1bfaa8f8" );
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 1, eflags: 0x4
// Checksum 0x2f5242d, Offset: 0x1852
// Size: 0x45b
function private liftoff_ent( var_f39d8960915f9a15 )
{
    self endon( #"death" );
    self notify( #"liftoff_ent" );
    self endon( #"liftoff_ent" );
    var_f39d8960915f9a15 endon( #"swallow_in_air" );
    player = undefined;
    self.angles = ( 0, 0, 0 );
    
    foreach ( target in var_f39d8960915f9a15.var_42c5553074544fc8 )
    {
        if ( !target utility::ent_flag( "damaged_by_unburrow" ) )
        {
            target utility::ent_flag_set( "damaged_by_unburrow" );
            target thread utility::ent_flag_clear_delayed( "damaged_by_unburrow", 6 );
            
            if ( isdefined( var_f39d8960915f9a15.var_b0a5bbcd2327e264 ) )
            {
                if ( !isdefined( var_f39d8960915f9a15.var_b0a5bbcd2327e264.players ) )
                {
                    var_f39d8960915f9a15.var_b0a5bbcd2327e264.players = [];
                }
                
                var_f39d8960915f9a15.var_b0a5bbcd2327e264.players[ var_f39d8960915f9a15.var_b0a5bbcd2327e264.players.size ] = target;
                target skydive_beginfreefall();
                target skydive_setdeploymentstatus( 0 );
                target playsoundevent( %"sndevent_death_worm_swallow_hit_plr" );
                self.angles = ( 90, target.angles[ 1 ], 0 );
                target playerlinktoblend( var_f39d8960915f9a15.var_b0a5bbcd2327e264, undefined, 1.1, 0.2, 0.2, 0, 1 );
                target val::set( "ai_worm_grab", "freezecontrols" );
            }
            
            if ( target.armorhealth > 0 )
            {
                target dodamage( 250, var_f39d8960915f9a15.origin, var_f39d8960915f9a15, var_f39d8960915f9a15, "MOD_IMPACT", undefined, undefined, undefined, 65536 );
            }
            
            target dodamage( 1, var_f39d8960915f9a15.origin, var_f39d8960915f9a15, var_f39d8960915f9a15, "MOD_IMPACT" );
        }
        
        player = target;
    }
    
    start_pos = var_f39d8960915f9a15 gettagorigin( "tag_fx_mouth" );
    start_pos += anglestoforward( var_f39d8960915f9a15.angles ) * getdvarfloat( @"hash_145e04bf9bf831c", 190 );
    self.origin = start_pos;
    var_aa32eeed6e9d8749 = getdvarfloat( @"hash_7880d7d53a7c6738", 2900 ) * level.framedurationseconds;
    var_2c3584bb3585dc3b = var_aa32eeed6e9d8749;
    var_4b66c8ac1e971b14 = getdvarfloat( @"hash_9d41e6f6c42ede2c", 135 ) * level.framedurationseconds;
    b_going_down = 0;
    
    while ( true )
    {
        self.origin += ( 0, 0, var_2c3584bb3585dc3b );
        self.angles = ( self.angles[ 0 ], math::function_27800ff2fd4867c6( self.angles[ 1 ], var_f39d8960915f9a15.angles[ 1 ] + 180, 90 * level.framedurationseconds ), self.angles[ 2 ] );
        var_2c3584bb3585dc3b -= var_4b66c8ac1e971b14;
        
        if ( !b_going_down && var_2c3584bb3585dc3b < 0 )
        {
            if ( var_f39d8960915f9a15.var_7b1f7e0bb8df49f )
            {
                var_f39d8960915f9a15 thread function_caa1a13e3a472941();
            }
            
            b_going_down = 1;
            
            foreach ( target in var_f39d8960915f9a15.var_42c5553074544fc8 )
            {
                target unlink();
                
                if ( var_f39d8960915f9a15.var_7b1f7e0bb8df49f )
                {
                    target val::set( "ai_worm_grab", "freezecontrols", 0 );
                    target skydive_setdeploymentstatus( 1 );
                    continue;
                }
                
                target val::set( "ai_worm_grab", "freezecontrols", 1 );
            }
        }
        
        /#
            burrow_print( "<dev string:xb2>", self.origin );
            sphere( self.origin, 10, ( 1, 0, 0 ) );
        #/
        
        waitframe();
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 2, eflags: 0x4
// Checksum 0x3a0b0278, Offset: 0x1cb5
// Size: 0xb8
function private function_fbe3d3cb46e1a028( var_f39d8960915f9a15, liftoff_ent )
{
    var_f39d8960915f9a15 waittill( #"death" );
    
    if ( isdefined( liftoff_ent ) )
    {
        if ( isdefined( liftoff_ent.players ) )
        {
            foreach ( player in liftoff_ent.players )
            {
                player unlink();
            }
        }
        
        liftoff_ent delete();
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 4
// Checksum 0xc678e327, Offset: 0x1d75
// Size: 0x23f
function function_e918d59b09e09aa9( target, var_f06c3d8143b76949, damage, var_e91b2b195e994ecf )
{
    swallowed = 0;
    
    if ( isplayer( target ) )
    {
        if ( target function_a920418c9153d2d8( damage ) && ( !target islinked() || var_e91b2b195e994ecf ) )
        {
            swallowed = 1;
        }
    }
    else if ( isai( target ) )
    {
        if ( !target.damageshield )
        {
            swallowed = 1;
        }
    }
    
    if ( swallowed )
    {
        target utility::ent_flag_set( "in_worm_mouth" );
        self.var_7e46b2ec66222b8e[ self.var_7e46b2ec66222b8e.size ] = target;
        utility::function_32b24db3127bff40( "mouth_gibbed", "mouth_gibbed_on" );
        
        if ( isplayer( target ) )
        {
            player_vehicle = target utility::callsharedfunc( #"vehicle", #"hash_57088fe62d398fbd" );
            
            if ( isdefined( player_vehicle ) )
            {
                seatid = target utility::callsharedfunc( #"vehicle", #"hash_b5fe1e65eb52639c", player_vehicle, target );
                target thread utility::callsharedfunc( #"vehicle", #"hash_fe9047d38261a46", player_vehicle, seatid, target, undefined, 1 );
            }
            
            if ( !var_e91b2b195e994ecf )
            {
                target skydive_interrupt();
                target setstance( "crouch", 1, 1 );
                target val::set( "ai_worm_grab", "freezecontrols", 1 );
                target thread link_to_mouth( self );
            }
            
            target hidelegs();
            target val::set( "zm_deathworm", "allow_toggle_third_person", 0 );
            
            if ( target getcamerathirdperson() )
            {
                target.was_third_person = 1;
                target setcamerathirdperson( 0 );
            }
            
            target utility::function_32b24db3127bff40( "deathwormVFX", "swallowed" );
            target vision_utility::function_89d3efe42060754c( "zm_jup_death_worm", 0.05 );
            screenshake_for_player( target, 1 );
        }
        else if ( isai( target ) )
        {
            target linktoblendtotag( self, "j_inner_jaw", 0 );
            target utility::function_32b24db3127bff40( "base", "base_off" );
        }
    }
    
    /#
        burrow_print( "<dev string:xbe>" + target getentitynumber() + "<dev string:xc7>", target.origin + ( 0, 0, 70 ) );
    #/
    
    return swallowed;
}

// Namespace namespace_473bdc208d3e708a
// Params 1, eflags: 0x4
// Checksum 0xe29e913f, Offset: 0x1fbd
// Size: 0x27, Type: bool
function private function_a920418c9153d2d8( damage )
{
    return self.health <= damage && self.armorhealth <= 0;
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0x8866469a, Offset: 0x1fed
// Size: 0x150
function private function_caa1a13e3a472941()
{
    self endon( #"death" );
    self endon( #"hash_7e728bca1bfaa8f8" );
    self.var_efb9a8da17df5f6d = [];
    
    while ( true )
    {
        foreach ( target in self.var_42c5553074544fc8 )
        {
            if ( arraycontains( self.var_efb9a8da17df5f6d, target ) )
            {
                continue;
            }
            
            var_7465e60e9fd89489 = self gettagorigin( "tag_fx_mouth_inner_player" );
            
            if ( distance2d( var_7465e60e9fd89489, target.origin ) > 200 || abs( target.origin[ 2 ] - var_7465e60e9fd89489[ 2 ] - 200 ) > 200 )
            {
                continue;
            }
            
            self.var_efb9a8da17df5f6d[ self.var_efb9a8da17df5f6d.size ] = target;
            target skydive_interrupt();
            target setstance( "crouch", 1, 1 );
            target val::set( "ai_worm_grab", "freezecontrols", 1 );
            target thread link_to_mouth( self, 1 );
        }
        
        waitframe();
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 2, eflags: 0x4
// Checksum 0x540bab28, Offset: 0x2145
// Size: 0x6d
function private link_to_mouth( var_f39d8960915f9a15, immediate )
{
    var_f39d8960915f9a15 endon( #"death" );
    self endon( #"death" );
    
    if ( !immediate )
    {
        wait 0.1;
    }
    
    var_f54f782be41e73c3 = getdvarfloat( @"hash_4339234d5690eaf8", 20 );
    self playerlinkto( var_f39d8960915f9a15, "tag_fx_mouth_inner_player", 1, 0, 0, var_f54f782be41e73c3, -1 * var_f54f782be41e73c3 );
}

// Namespace namespace_473bdc208d3e708a
// Params 2, eflags: 0x4
// Checksum 0x8e244326, Offset: 0x21ba
// Size: 0x122
function private function_a4d4d319b9976483( player, var_f39d8960915f9a15 )
{
    player endon( #"death" );
    var_f39d8960915f9a15 endon( #"death" );
    allow_fall_damage = level.var_85e1bb3816730b4;
    level.var_85e1bb3816730b4 = 0;
    
    while ( isalive( player ) && !player isonground() && !player isswimming() )
    {
        if ( player isparachuting() )
        {
            player skydive_setdeploymentstatus( 1 );
            player val::reset( "ai_worm_grab", "freezecontrols" );
            level.var_85e1bb3816730b4 = allow_fall_damage;
            return;
        }
        
        waitframe();
    }
    
    if ( isalive( player ) && ( player isonground() || player isswimming() ) )
    {
        screenshake_for_player( player );
        
        if ( !player.inlaststand )
        {
            player dodamage( 250, var_f39d8960915f9a15.origin, var_f39d8960915f9a15, var_f39d8960915f9a15, "MOD_IMPACT", undefined, undefined, undefined, 65536 );
        }
        
        player skydive_setdeploymentstatus( 1 );
        player val::reset( "ai_worm_grab", "freezecontrols" );
    }
    
    level.var_85e1bb3816730b4 = allow_fall_damage;
}

// Namespace namespace_473bdc208d3e708a
// Params 2, eflags: 0x4
// Checksum 0x92ad486f, Offset: 0x22e4
// Size: 0x54
function private screenshake_for_player( player, var_d30ffadceb6e5bde )
{
    player playrumbleonentity( var_d30ffadceb6e5bde ? "heavy_3s" : "heavy_1s" );
    player earthquakeforplayer( 0.5, var_d30ffadceb6e5bde ? 3 : 1, player.origin, 500 );
}

// Namespace namespace_473bdc208d3e708a
// Params 1, eflags: 0x4
// Checksum 0x22038dad, Offset: 0x2340
// Size: 0xb4
function private set_perfect_awareness( is_enabled )
{
    if ( is_enabled )
    {
        utility::ent_flag_set( "perfect_awareness" );
        self function_fa32376aaa88a7a2( self.origin, 2000 );
        function_9e813eb869251264( 0 );
        
        /#
            if ( debug_burrow() )
            {
                utility::draw_circle( self.origin, 2000, ( 1, 0, 0 ), 1, 1, 5 );
                burrow_print( "<dev string:xd1>", get_home_pos() );
            }
        #/
        
        return;
    }
    
    utility::ent_flag_clear( "perfect_awareness" );
    self function_9f3a37eb7b4ca06f();
    self clearenemy();
    function_9e813eb869251264( 1 );
    
    /#
        burrow_print( "<dev string:xea>", get_home_pos() );
    #/
}

// Namespace namespace_473bdc208d3e708a
// Params 1, eflags: 0x4
// Checksum 0xe973335e, Offset: 0x23fc
// Size: 0x83
function private function_9e813eb869251264( is_enabled )
{
    if ( !is_enabled )
    {
        self function_32c1ccfe09636874( "gunshot" );
        self function_32c1ccfe09636874( "footstep_sprint" );
        self function_32c1ccfe09636874( "gunshot_impact" );
        self function_32c1ccfe09636874( "explosion" );
        self function_32c1ccfe09636874( "decoy_grenade" );
        return;
    }
    
    self addaieventlistener( "gunshot" );
    self addaieventlistener( "footstep_sprint" );
    self addaieventlistener( "gunshot_impact" );
    self addaieventlistener( "explosion" );
    self addaieventlistener( "decoy_grenade" );
}

// Namespace namespace_473bdc208d3e708a
// Params 1, eflags: 0x4
// Checksum 0xeb9673d3, Offset: 0x2487
// Size: 0x22
function private function_91cb4362245baa84( event )
{
    if ( !utility::ent_flag( "perfect_awareness" ) )
    {
        thread function_50fc0ff43554804b();
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0xc
// Checksum 0x4f4629d0, Offset: 0x24b1
// Size: 0x4a
function private function_50fc0ff43554804b()
{
    self notify( #"hash_8fd93fbbec859819" );
    self endon( #"hash_8fd93fbbec859819" );
    self endon( #"death" );
    self endon( #"leave_underground" );
    self endon( #"start_emerge" );
    wait 5;
    function_9e813eb869251264( 1 );
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0x1bace054, Offset: 0x2503
// Size: 0x24c
function private function_93617273acd11edf()
{
    var_9c18eb30cf6a1214 = [[ self.var_3c8a8a999d3d0d2e ]]();
    is_player_sprinting = isplayer( self.var_59bf24d70026a084 ) && self.var_59bf24d70026a084 issprinting();
    has_perfect_awareness = isdefined( self.var_59bf24d70026a084 ) && gettime() < self.var_da953d63dbd6053a;
    use_lethal_chase = isplayer( self.var_59bf24d70026a084 ) && self.use_lethal_attacks && var_9c18eb30cf6a1214 > 0.5 && self.var_6005157a6615b97f > 3;
    target_pos = undefined;
    valid_monkey_bomb = undefined;
    
    if ( level.var_643e99d5a18faa82.size > 0 )
    {
        closest_monkey_bomb = function_47c86977a18df38b( level.var_643e99d5a18faa82, self.origin );
        
        if ( isdefined( closest_monkey_bomb ) && function_6164d2bd8f96f003( closest_monkey_bomb.origin ) )
        {
            valid_monkey_bomb = closest_monkey_bomb;
        }
    }
    
    if ( isdefined( valid_monkey_bomb ) )
    {
        target_pos = valid_monkey_bomb.origin;
        self.var_eec4b26e434824fc = target_pos;
        
        /#
            burrow_print( "<dev string:x106>", target_pos );
        #/
    }
    else if ( is_player_sprinting || has_perfect_awareness || use_lethal_chase )
    {
        can_chase_directly = function_6164d2bd8f96f003( self.var_59bf24d70026a084.origin );
        
        if ( can_chase_directly )
        {
            target_pos = self.var_59bf24d70026a084.origin;
            self.var_eec4b26e434824fc = target_pos;
            
            /#
                burrow_print( "<dev string:x11a>", target_pos );
            #/
        }
    }
    
    if ( !isdefined( target_pos ) && isvector( self.var_eec4b26e434824fc ) )
    {
        target_pos = self.var_eec4b26e434824fc;
        
        /#
            burrow_print( "<dev string:x139>", target_pos );
        #/
    }
    
    if ( !isdefined( target_pos ) )
    {
        return;
    }
    
    target_pos_on_navmesh = getclosestpointonnavmesh( target_pos );
    
    if ( !isdefined( target_pos_on_navmesh ) )
    {
        /#
            burrow_print( "<dev string:x154>", target_pos_on_navmesh );
        #/
        
        return;
    }
    
    if ( callback::exists_any( "validate_death_worm_emerge_position" ) && !callback::response( 2, "validate_death_worm_emerge_position", { #pos:target_pos_on_navmesh } ) )
    {
        /#
            burrow_print( "<dev string:x16c>", target_pos_on_navmesh );
        #/
        
        return;
    }
    
    return target_pos_on_navmesh;
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0xc
// Checksum 0xad76e9b7, Offset: 0x2758
// Size: 0x3b7
function private listen_for_player_events()
{
    self notify( #"hash_e2dd2fcc335b5ba2" );
    self endon( #"hash_e2dd2fcc335b5ba2" );
    self endon( #"death" );
    
    while ( utility::ent_flag( "is_underground" ) )
    {
        self waittill( #"ai_events", events );
        
        if ( utility::ent_flag( "ignore_events" ) )
        {
            waitframe();
            continue;
        }
        
        foreach ( event in events )
        {
            if ( issentient( event.entity ) && ( event.entity.ignoreme || event.entity.notarget ) )
            {
                continue;
            }
            
            var_4b00435da3b7b921 = event.origin;
            
            if ( event.type == "gunshot_impact" )
            {
                gunshot_radius = 2000;
                
                if ( distance2dsquared( event.entity.origin, self.origin ) < squared( gunshot_radius ) )
                {
                    var_4b00435da3b7b921 = event.entity.origin;
                }
            }
            
            can_chase_directly = function_6164d2bd8f96f003( var_4b00435da3b7b921 );
            
            if ( !can_chase_directly )
            {
                if ( utility::ent_flag( "chasing_directly" ) )
                {
                    continue;
                }
                
                throttle::throttle_wait_in_queue( self.var_205c771cbff58dbe, self );
                var_9e727c8fd7ee75f9 = function_4a4a3abdc931f1b7( var_4b00435da3b7b921, getdvarfloat( @"hash_5eb7fc0533e937ba", 500 ), self.var_17f45fd4407379ae, 1 );
                
                /#
                    var_dc5cdccee3e9cefb = function_93b6d3e8b4c58539( var_9e727c8fd7ee75f9 );
                    burrow_print( "<dev string:x191>" + var_dc5cdccee3e9cefb, var_9e727c8fd7ee75f9.origin + ( 0, 0, 40 ) );
                #/
                
                if ( function_dd8bbd755733417a( var_9e727c8fd7ee75f9, 1 ) )
                {
                    var_4b00435da3b7b921 = var_9e727c8fd7ee75f9.origin;
                }
                else
                {
                    var_4b00435da3b7b921 = get_home_pos();
                }
            }
            else
            {
                utility::ent_flag_set( "chasing_directly" );
            }
            
            if ( event.type == "gunshot" )
            {
                function_142d6d5f227ada4a( event.entity, undefined, var_4b00435da3b7b921 );
                
                /#
                    burrow_print( "<dev string:x1b6>", event.entity.origin );
                #/
                
                continue;
            }
            
            if ( event.type == "footstep_sprint" )
            {
                function_142d6d5f227ada4a( event.entity, getdvarfloat( @"hash_c5c4bd7b0332e15", 500 ), var_4b00435da3b7b921 );
                
                /#
                    burrow_print( "<dev string:x1c5>", event.entity.origin );
                #/
                
                continue;
            }
            
            if ( event.type == "gunshot_impact" )
            {
                burrow_chase_pos( var_4b00435da3b7b921 );
                
                /#
                    burrow_print( "<dev string:x1d5>", event.origin );
                #/
                
                continue;
            }
            
            if ( event.type == "explosion" )
            {
                burrow_chase_pos( var_4b00435da3b7b921 );
                
                /#
                    burrow_print( "<dev string:x1eb>", event.origin );
                #/
                
                continue;
            }
            
            if ( event.type == "decoy_grenade" )
            {
                burrow_chase_pos( var_4b00435da3b7b921 );
                
                /#
                    burrow_print( "<dev string:x1fc>", event.origin );
                #/
            }
        }
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 1, eflags: 0x4
// Checksum 0x76dc0086, Offset: 0x2b17
// Size: 0xea
function private function_6164d2bd8f96f003( pos )
{
    can_chase_directly = 1;
    dist_to_pos = distance( self.origin, pos );
    var_41865e01755235a4 = distance( get_home_pos(), pos );
    var_22602874834b650 = 5000;
    
    if ( dist_to_pos > var_22602874834b650 || var_41865e01755235a4 > var_22602874834b650 )
    {
        can_chase_directly = 0;
    }
    else
    {
        closest_tacpoint = findclosesttacpoint( pos );
        
        if ( isdefined( closest_tacpoint ) )
        {
            dist = distance( pos, closest_tacpoint.origin );
            
            if ( dist < 200 )
            {
                can_chase_directly = function_dd8bbd755733417a( closest_tacpoint, 0 );
            }
            else
            {
                can_chase_directly = 1;
            }
        }
        
        if ( can_chase_directly )
        {
            if ( function_9073d5c7012a71b6( pos ) )
            {
                can_chase_directly = 0;
                
                /#
                    burrow_print( "<dev string:x211>", pos + ( 0, 0, 40 ) );
                #/
            }
        }
    }
    
    return can_chase_directly;
}

// Namespace namespace_473bdc208d3e708a
// Params 2, eflags: 0x4
// Checksum 0x3a1d6735, Offset: 0x2c0a
// Size: 0x283
function private function_dd8bbd755733417a( tacpoint, var_eede18c5b70edadd )
{
    can_unburrow = 1;
    
    if ( isdefined( self.var_17f45fd4407379ae ) && self.var_17f45fd4407379ae != tacpoint.roomindex )
    {
        can_unburrow = 0;
        
        /#
            burrow_print( "<dev string:x23d>", tacpoint.origin + ( 0, 0, 20 ) );
        #/
    }
    else
    {
        var_482fafa39cd8bd94 = function_93b6d3e8b4c58539( tacpoint );
        
        if ( var_482fafa39cd8bd94 < ( isai( self ) ? self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_bb271de51ba65cb6 ?? 0.5 : 0.5 ) )
        {
            can_unburrow = 0;
            
            /#
                burrow_print( "<dev string:x25e>" + var_482fafa39cd8bd94, tacpoint.origin + ( 0, 0, 20 ) );
            #/
        }
        else
        {
            var_599e581852972aa2 = function_f1f8a8f5f26409b5( tacpoint );
            
            if ( var_599e581852972aa2 <= 300 )
            {
                can_unburrow = 0;
                
                /#
                    burrow_print( "<dev string:x281>" + var_599e581852972aa2, tacpoint.origin + ( 0, 0, 20 ) );
                #/
            }
        }
    }
    
    if ( can_unburrow && var_eede18c5b70edadd )
    {
        if ( function_9073d5c7012a71b6( tacpoint.origin ) )
        {
            can_unburrow = 0;
            
            /#
                burrow_print( "<dev string:x2aa>", tacpoint.origin + ( 0, 0, 20 ) );
            #/
        }
    }
    
    if ( can_unburrow )
    {
        differential_radius = 300;
        drop_height = 100;
        angle = 0;
        
        while ( angle < 360 )
        {
            forward = anglestoforward( ( 0, angle, 0 ) );
            var_90065b363463cef7 = tacpoint.origin + forward * differential_radius;
            ground_pos = utility::drop_to_ground( var_90065b363463cef7, 200, drop_height * -1 );
            
            /#
                if ( debug_burrow() )
                {
                    if ( isdefined( ground_pos ) )
                    {
                        line( var_90065b363463cef7, ground_pos, ( 1, 1, 0 ) );
                        line( ground_pos, var_90065b363463cef7 + ( 0, 0, drop_height * -1 ), ( 1, 0, 0 ) );
                    }
                }
            #/
            
            if ( !isdefined( ground_pos ) || ground_pos == var_90065b363463cef7 || ground_pos == var_90065b363463cef7 + ( 0, 0, drop_height * -1 ) )
            {
                can_unburrow = 0;
                
                /#
                    burrow_print( "<dev string:x2d9>", var_90065b363463cef7 );
                #/
                
                break;
            }
            
            angle += 120;
        }
    }
    
    return can_unburrow;
}

// Namespace namespace_473bdc208d3e708a
// Params 3, eflags: 0x4
// Checksum 0x233b7e93, Offset: 0x2e96
// Size: 0x10d
function private function_142d6d5f227ada4a( ent, var_f702c93939288e4e, target_pos )
{
    assert( isdefined( target_pos ) );
    var_236010ed3482cd45 = gettime() < self.var_da953d63dbd6053a && isdefined( self.var_59bf24d70026a084 );
    
    if ( var_236010ed3482cd45 )
    {
        if ( distancesquared( self.var_59bf24d70026a084.origin, self.origin ) < distancesquared( ent.origin, self.origin ) )
        {
            /#
                burrow_print( "<dev string:x305>", ent.origin + ( 0, 0, 20 ) );
            #/
            
            return;
        }
    }
    
    self setstealthstate( "combat" );
    self.worm_underground_ent setscriptablepartstate( "chase_audio", "chase" );
    self.var_59bf24d70026a084 = ent;
    self.var_eec4b26e434824fc = target_pos;
    
    if ( isdefined( var_f702c93939288e4e ) )
    {
        self.var_da953d63dbd6053a = gettime() + var_f702c93939288e4e;
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 1, eflags: 0x4
// Checksum 0x5384e41f, Offset: 0x2fab
// Size: 0x48
function private burrow_chase_pos( pos )
{
    assert( isdefined( pos ) );
    self setstealthstate( "combat" );
    self.var_eec4b26e434824fc = pos;
    self.worm_underground_ent setscriptablepartstate( "chase_audio", "chase" );
}

// Namespace namespace_473bdc208d3e708a
// Params 2, eflags: 0x4
// Checksum 0x4d76dac5, Offset: 0x2ffb
// Size: 0x9e
function private function_bf098f0ff7c9c383( player, damage_point )
{
    knockback_magnitude = 1800;
    var_9362b2e99d92a93e = player.origin - damage_point - ( 0, 0, 100 );
    player utility::knockback_flat( var_9362b2e99d92a93e, knockback_magnitude );
    player playrumbleonentity( "heavy_1s" );
    player earthquakeforplayer( 0.5, 1, player.origin, 500 );
    player dodamage( 60, self.origin, self, self, "MOD_IMPACT", undefined, undefined, undefined, 65536 );
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0xb243be35, Offset: 0x30a1
// Size: 0x3a
function private function_3559e36ecd5987e0()
{
    var_1f6e450ba7409b8d = self.worm_underground_ent;
    var_1f6e450ba7409b8d setscriptablepartstate( "ambient_audio", "on" );
    thread function_d77a0d9ebb169190( var_1f6e450ba7409b8d );
    thread function_dabc216dbe069961( var_1f6e450ba7409b8d );
}

// Namespace namespace_473bdc208d3e708a
// Params 1, eflags: 0x4
// Checksum 0x99784f80, Offset: 0x30e3
// Size: 0x8c
function private function_d77a0d9ebb169190( var_1f6e450ba7409b8d )
{
    self endon( #"death" );
    var_1f6e450ba7409b8d endon( #"death" );
    self endon( #"start_emerge" );
    var_1f6e450ba7409b8d.origin = self.origin;
    var_1f6e450ba7409b8d utility::function_32b24db3127bff40( "dust_kickup", "dust_light" );
    wait 0.25;
    var_1f6e450ba7409b8d utility::function_32b24db3127bff40( "dust_kickup", "off" );
    wait 5;
    set_perfect_awareness( 0 );
    wait 55;
    utility::ent_flag_set( "return_home" );
}

// Namespace namespace_473bdc208d3e708a
// Params 1, eflags: 0x4
// Checksum 0x28c96c5c, Offset: 0x3177
// Size: 0x8b7
function private function_dabc216dbe069961( var_1f6e450ba7409b8d )
{
    self endon( #"death" );
    var_1f6e450ba7409b8d endon( #"death" );
    var_956c1fab341d0053 = getdvarfloat( @"hash_9232b53fc181491b", 20 );
    max_speed = getdvarfloat( @"hash_534fcc249dc33a8e", 60 );
    current_speed = var_956c1fab341d0053;
    current_yaw = self.angles[ 2 ];
    var_1f6e450ba7409b8d.var_c0b52854ad46edcd = 1;
    self.var_cc747d516e89a9a9 = 0;
    var_121423597bb042b0 = self.health < self.maxhealth * 0.5;
    initial_pause_time = var_121423597bb042b0 ? getdvarfloat( @"hash_78e585c859d13a37", 0.5 ) : getdvarfloat( @"hash_78e585c859d13a37", 1 );
    var_9c18eb30cf6a1214 = [[ self.var_3c8a8a999d3d0d2e ]]();
    
    if ( getdvarfloat( @"hash_6f56a8007c2ae785", -1 ) > 0 )
    {
        ignore_events_time = getdvarfloat( @"hash_6f56a8007c2ae785", -1 );
    }
    else if ( var_9c18eb30cf6a1214 > 0.5 && self.var_6005157a6615b97f > 3 )
    {
        ignore_events_time = 2;
    }
    else if ( var_121423597bb042b0 || self.var_87f2acda8758bab9 <= 0 )
    {
        ignore_events_time = 5;
    }
    else
    {
        ignore_events_time = 10;
    }
    
    utility::ent_flag_set( "ignore_events" );
    thread utility::ent_flag_clear_delayed( "ignore_events", ignore_events_time );
    wait initial_pause_time;
    var_2a8e8d1311aa6892 = 1;
    var_d48aa2fcfcd9eb96 = 0;
    
    while ( utility::ent_flag( "is_underground" ) )
    {
        var_c2955070f2375e26 = function_93617273acd11edf();
        
        if ( isdefined( var_c2955070f2375e26 ) )
        {
            if ( !var_d48aa2fcfcd9eb96 )
            {
                var_d48aa2fcfcd9eb96 = 1;
                var_1f6e450ba7409b8d.var_c0b52854ad46edcd = 1;
                pause_time = getdvarfloat( @"hash_103d12cb4e26ffcb", 1 );
                
                if ( distance2dsquared( var_c2955070f2375e26, self.origin ) < 500 )
                {
                    pause_time *= 0.5;
                }
                
                earthquake( 0.5, 0.75, var_1f6e450ba7409b8d.origin, 3000 );
                wait pause_time;
                current_yaw = vectortoyaw( var_c2955070f2375e26 - var_1f6e450ba7409b8d.origin );
                continue;
            }
            
            set_underground_state( 1 );
            var_1f6e450ba7409b8d.var_c0b52854ad46edcd = 0;
            var_f616bfe1ab880e6e = distance2d( var_1f6e450ba7409b8d.origin, var_c2955070f2375e26 );
            var_8db035ee80620882 = 1 - clamp( math::remap( var_f616bfe1ab880e6e, 200, 1000, 0, 1 ), 0, 1 );
            
            /#
                burrow_print( "<dev string:x326>" + var_8db035ee80620882 + "<dev string:x338>" + var_f616bfe1ab880e6e, var_1f6e450ba7409b8d.origin + ( 0, 0, 80 ) );
            #/
            
            var_2a8e8d1311aa6892 = 8 + var_8db035ee80620882 * 12;
            current_yaw = math::function_5cf1e88395e33eba( var_1f6e450ba7409b8d.origin, var_c2955070f2375e26, var_2a8e8d1311aa6892, current_yaw );
            angles = ( 0, current_yaw, 0 );
            forward_vec = anglestoforward( angles );
            chase_base_speed = math::lerp( var_956c1fab341d0053, max_speed, 0.75 );
            current_speed = math::lerp( chase_base_speed, max_speed, var_8db035ee80620882 );
            var_1f6e450ba7409b8d.origin += forward_vec * current_speed;
            var_1f6e450ba7409b8d.angles = angles;
            var_f616bfe1ab880e6e = distance2d( var_1f6e450ba7409b8d.origin, var_c2955070f2375e26 );
            
            if ( var_f616bfe1ab880e6e < 250 )
            {
                var_1f6e450ba7409b8d.origin = var_c2955070f2375e26;
                utility::ent_flag_set( "can_emerge" );
                utility::ent_flag_set( "can_emerge_attack" );
                var_42c5553074544fc8 = function_67d71a6a52806b3b( var_c2955070f2375e26 );
                
                if ( var_42c5553074544fc8.size > 0 )
                {
                    utility::ent_flag_set( "can_emerge_attack_swallow" );
                    self.var_42c5553074544fc8 = var_42c5553074544fc8;
                }
                
                break;
            }
        }
        else if ( function_40ec5fb0d9724ecc() || should_return_home() )
        {
            var_1f6e450ba7409b8d.var_c0b52854ad46edcd = 0.5;
            var_c2dcda14eade6ae0 = get_home_pos();
            var_f616bfe1ab880e6e = distance2d( var_1f6e450ba7409b8d.origin, var_c2dcda14eade6ae0 );
            
            if ( var_f616bfe1ab880e6e < 100 )
            {
                var_1f6e450ba7409b8d.origin = var_c2dcda14eade6ae0;
                
                if ( function_40ec5fb0d9724ecc() )
                {
                    set_underground_state( 2 );
                    
                    if ( !utility::ent_flag( "healing" ) )
                    {
                        utility::ent_flag_set( "healing" );
                        thread function_d81cbc035c8079dc();
                        self function_e8726d980fa12944();
                    }
                    
                    var_d5feb6372fff34e6 = self function_f017e352a29a57a1( var_1f6e450ba7409b8d.origin, 1000, 1 );
                    
                    if ( var_d5feb6372fff34e6.size > 0 )
                    {
                        utility::ent_flag_set( "can_emerge" );
                        break;
                    }
                }
                else
                {
                    utility::ent_flag_set( "can_emerge" );
                }
            }
            else
            {
                current_yaw = math::function_5cf1e88395e33eba( var_1f6e450ba7409b8d.origin, var_c2dcda14eade6ae0, 10, current_yaw );
                forward_vec = anglestoforward( ( 0, current_yaw, 0 ) );
                current_speed = var_956c1fab341d0053;
                var_1f6e450ba7409b8d.origin += forward_vec * current_speed;
            }
        }
        else if ( should_return_home() )
        {
        }
        else
        {
            set_underground_state( 3 );
            var_88306326856792c7 = getdvarfloat( @"hash_b76c567afef49143", 0.05 );
            var_c9faf90af6dd07cd = getdvarfloat( @"hash_1f58bf41db502871", 2 );
            var_f3e7bc16650a8bae = getdvarfloat( @"hash_426bdc9deb50e6a2", 3 );
            var_58d407a8194fcb0f = sin( gettime() * var_88306326856792c7 );
            
            /#
                burrow_print( "<dev string:x344>" + var_58d407a8194fcb0f, var_1f6e450ba7409b8d.origin + ( 0, 0, 80 ) );
            #/
            
            var_cabdd61079e0360c = var_1f6e450ba7409b8d.origin - get_home_pos();
            var_16078a5f8472ebf0 = -1 * var_cabdd61079e0360c;
            forward_vec = anglestoforward( ( 0, current_yaw, 0 ) );
            var_55573d7924b89555 = vectordot( vectornormalize( var_cabdd61079e0360c ), forward_vec ) > -0.5;
            var_6cdbb95f6e3ccc32 = distance2d( var_1f6e450ba7409b8d.origin, get_home_pos() );
            var_b83cd6480c36a7c2 = math::remap( var_6cdbb95f6e3ccc32, 0, 2000, 0, 1 );
            
            /#
                if ( var_55573d7924b89555 )
                {
                    burrow_print( "<dev string:x358>" + var_b83cd6480c36a7c2, var_1f6e450ba7409b8d.origin + ( 0, 0, 120 ) );
                }
            #/
            
            var_2a8e8d1311aa6892 = var_f3e7bc16650a8bae;
            
            if ( var_b83cd6480c36a7c2 > 0.75 )
            {
                if ( var_55573d7924b89555 )
                {
                    var_2a8e8d1311aa6892 += var_b83cd6480c36a7c2 * var_c9faf90af6dd07cd;
                    var_a267d4944fd1d78 = math::function_84e592007021cc09( var_16078a5f8472ebf0, forward_vec );
                    var_58d407a8194fcb0f = abs( var_58d407a8194fcb0f ) * ( var_a267d4944fd1d78 ? -1 : 1 );
                }
            }
            
            var_2a8e8d1311aa6892 *= var_58d407a8194fcb0f;
            current_yaw += var_2a8e8d1311aa6892;
            forward_vec = anglestoforward( ( 0, current_yaw, 0 ) );
            depth_base_speed = getdvarfloat( @"hash_3b38a28674d7a6fd", 0.05 );
            var_bfa2d9ee87604e39 = ( sin( gettime() * depth_base_speed ) + 1 ) * 0.5;
            var_1f6e450ba7409b8d.var_c0b52854ad46edcd = math::remap( var_bfa2d9ee87604e39, 0, 1, 0.2, 1 );
            var_7cbf1eb0b4e91808 = 0;
            
            if ( self.var_83911c99c3fcc262 != 2 )
            {
                var_7cbf1eb0b4e91808 = 0.3;
            }
            
            var_e075b0cef52b2b46 = math::remap( var_bfa2d9ee87604e39, 0, 1, 0, var_7cbf1eb0b4e91808 ) * ( max_speed - var_956c1fab341d0053 );
            current_speed = var_956c1fab341d0053 + var_e075b0cef52b2b46;
            var_1f6e450ba7409b8d.origin += forward_vec * current_speed;
        }
        
        drop_limit = 200;
        var_b8e96748d1861011 = utility::drop_to_ground( var_1f6e450ba7409b8d.origin, drop_limit, -100 );
        
        if ( isdefined( var_b8e96748d1861011 ) )
        {
            if ( var_b8e96748d1861011[ 2 ] < var_1f6e450ba7409b8d.origin[ 2 ] - drop_limit + 10 )
            {
                /#
                    if ( debug_burrow() )
                    {
                        utility::draw_arrow( var_1f6e450ba7409b8d.origin, var_b8e96748d1861011, ( 0, 0, 1 ) );
                        sphere( var_b8e96748d1861011, 10, ( 1, 1, 0 ) );
                        burrow_print( "<dev string:x36c>", var_b8e96748d1861011 );
                        println( "<dev string:x382>" );
                    }
                #/
                
                var_1f6e450ba7409b8d.origin = get_home_pos();
                self forceteleport( get_home_pos(), self.angles );
            }
            else
            {
                /#
                    if ( debug_burrow() )
                    {
                        utility::draw_arrow( var_1f6e450ba7409b8d.origin, var_b8e96748d1861011, ( 1, 0, 0 ) );
                        sphere( var_b8e96748d1861011, 10, ( 1, 0, 0 ) );
                    }
                #/
                
                var_1f6e450ba7409b8d.origin = var_b8e96748d1861011;
                self forceteleport( var_b8e96748d1861011, self.angles );
            }
        }
        
        waitframe();
    }
    
    var_1f6e450ba7409b8d.burrow_target = undefined;
}

// Namespace namespace_473bdc208d3e708a
// Params 1, eflags: 0x4
// Checksum 0x7ce7416b, Offset: 0x3a36
// Size: 0x3b
function private set_underground_state( state )
{
    if ( self.var_cc747d516e89a9a9 != state )
    {
        if ( utility::ent_flag( "healing" ) )
        {
            function_6d96c980e89bc817();
        }
    }
    
    self.var_cc747d516e89a9a9 = state;
}

// Namespace namespace_473bdc208d3e708a
// Params 1, eflags: 0x4
// Checksum 0x746d2582, Offset: 0x3a79
// Size: 0x3e9
function private update_screenshake( var_1f6e450ba7409b8d )
{
    self endon( #"death" );
    var_1f6e450ba7409b8d endon( #"death" );
    var_1f6e450ba7409b8d.var_c0b52854ad46edcd = 0;
    screenshake_time = 0.5;
    
    while ( utility::ent_flag( "is_underground" ) )
    {
        players = namespace_9d8e359c3b1041e5::getplayersinradiussharedfunc( var_1f6e450ba7409b8d.origin, 3000 );
        
        if ( utility::ent_flag( "healing" ) )
        {
            var_1f6e450ba7409b8d utility::function_32b24db3127bff40( "dust_kickup", "healing" );
            earthquake( 0.15, screenshake_time, var_1f6e450ba7409b8d.origin, 3000 );
            
            foreach ( player in players )
            {
                player playrumbleonpositionforclient( "rumble_zombie_deathworm_dust_light", var_1f6e450ba7409b8d.origin );
            }
        }
        else if ( var_1f6e450ba7409b8d.var_c0b52854ad46edcd < 0.2 )
        {
            var_1f6e450ba7409b8d utility::function_32b24db3127bff40( "dust_kickup", "dust_heavy" );
            earthquake( 0.25, screenshake_time, var_1f6e450ba7409b8d.origin, 3000 );
            
            foreach ( player in players )
            {
                player playrumbleonpositionforclient( "rumble_zombie_deathworm_dust_heavy", var_1f6e450ba7409b8d.origin );
            }
        }
        else if ( var_1f6e450ba7409b8d.var_c0b52854ad46edcd < 0.3 )
        {
            var_1f6e450ba7409b8d utility::function_32b24db3127bff40( "dust_kickup", "dust_medium" );
            earthquake( 0.2, screenshake_time, var_1f6e450ba7409b8d.origin, 3000 );
            
            foreach ( player in players )
            {
                player playrumbleonpositionforclient( "rumble_zombie_deathworm_dust_medium", var_1f6e450ba7409b8d.origin );
            }
        }
        else if ( var_1f6e450ba7409b8d.var_c0b52854ad46edcd < 0.95 )
        {
            var_1f6e450ba7409b8d utility::function_32b24db3127bff40( "dust_kickup", "dust_light" );
            earthquake( 0.175, screenshake_time, var_1f6e450ba7409b8d.origin, 3000 );
            
            foreach ( player in players )
            {
                player playrumbleonpositionforclient( "rumble_zombie_deathworm_dust_light", var_1f6e450ba7409b8d.origin );
            }
        }
        else
        {
            var_1f6e450ba7409b8d utility::function_32b24db3127bff40( "dust_kickup", "off" );
            var_1f6e450ba7409b8d utility::function_32b24db3127bff40( "dust_kickup_audio", "off" );
        }
        
        /#
            burrow_print( "<dev string:x3a3>" + var_1f6e450ba7409b8d.var_c0b52854ad46edcd, var_1f6e450ba7409b8d.origin + ( 0, 0, 160 ) );
        #/
        
        wait screenshake_time * 0.5;
    }
    
    var_1f6e450ba7409b8d utility::function_32b24db3127bff40( "dust_kickup", "off" );
    var_1f6e450ba7409b8d utility::function_32b24db3127bff40( "dust_kickup_audio", "off" );
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0x8a61e35b, Offset: 0x3e6a
// Size: 0x80, Type: bool
function private function_40ec5fb0d9724ecc()
{
    if ( self.var_83911c99c3fcc262 != 2 )
    {
        return false;
    }
    
    if ( self.health > self.maxhealth * 0.99 )
    {
        return false;
    }
    
    var_2d7f69132651dd3e = function_8e9c938af5a3d49a();
    var_50ef2678eb843cdb = var_2d7f69132651dd3e.size;
    var_28755b2381cf7597 = int( self.maxhealth / 6 * var_50ef2678eb843cdb );
    
    if ( self.health >= var_28755b2381cf7597 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0xb7876ba3, Offset: 0x3ef3
// Size: 0x1be
function private function_d81cbc035c8079dc()
{
    self endon( #"death" );
    
    while ( utility::ent_flag( "healing" ) )
    {
        var_5140e7c28262a11d = self.maxhealth - self.health;
        var_a32dca02fb15d0eb = int( max( var_5140e7c28262a11d * 0.025, self.maxhealth * 0.01 ) );
        var_2d7f69132651dd3e = function_8e9c938af5a3d49a();
        var_50ef2678eb843cdb = var_2d7f69132651dd3e.size;
        var_28755b2381cf7597 = self.maxhealth / 6 * var_50ef2678eb843cdb;
        var_cc8d6439ddd2a313 = min( var_28755b2381cf7597 - self.health, var_a32dca02fb15d0eb );
        self.health += int( var_cc8d6439ddd2a313 );
        lowest_gill = undefined;
        var_baa07ba9079f0a08 = undefined;
        
        foreach ( var_dc342e0ce4689ca6 in var_2d7f69132651dd3e )
        {
            health = metabone::get_metabone_health( var_dc342e0ce4689ca6, "open" );
            
            if ( !isdefined( var_baa07ba9079f0a08 ) || health <= var_baa07ba9079f0a08 )
            {
                var_baa07ba9079f0a08 = health;
                lowest_gill = var_dc342e0ce4689ca6;
            }
        }
        
        var_f8af9e74698202a2 = self.var_55e1606d1eb021c5 - var_baa07ba9079f0a08;
        assert( var_f8af9e74698202a2 >= 0 );
        metabone::function_dbe4a2c3b0797294( lowest_gill, min( var_f8af9e74698202a2, int( var_cc8d6439ddd2a313 ) ), "open" );
        wait 1;
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0x9c2e2bf9, Offset: 0x40b9
// Size: 0x25, Type: bool
function private should_return_home()
{
    if ( self.var_83911c99c3fcc262 == 2 )
    {
        return false;
    }
    
    if ( utility::ent_flag( "return_home" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0xd71c28c6, Offset: 0x40e7
// Size: 0x25
function private function_6d96c980e89bc817()
{
    utility::ent_flag_clear( "healing" );
    utility::function_32b24db3127bff40( "healing", "off" );
    self invisiblenotsolid();
}

/#

    // Namespace namespace_473bdc208d3e708a
    // Params 0
    // Checksum 0x3d5dc58e, Offset: 0x4114
    // Size: 0xa3, Type: dev
    function function_e59323980bee407()
    {
        devgui::function_9082edeb5db93280( "<dev string:x3b3>" );
        devgui::add_devgui_func( "<dev string:x3cf>", "<dev string:x3dc>", &force_burrow );
        devgui::add_devgui_func( "<dev string:x3e9>", "<dev string:x3f6>", &function_e62155d4dc90cd20 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x403>", "<dev string:x425>", &function_c2bd455103722f63 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x437>", "<dev string:x45b>", &function_c2bd455103722f63 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x46d>", "<dev string:x492>", &function_c2bd455103722f63 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4a4>", "<dev string:x4c8>", &function_c2bd455103722f63 );
        devgui::function_77df7fe7dd273e10();
        thread function_bcf012df94a8f326();
    }

    // Namespace namespace_473bdc208d3e708a
    // Params 0, eflags: 0x4
    // Checksum 0x2669bdeb, Offset: 0x41bf
    // Size: 0x48, Type: dev
    function private force_burrow()
    {
        var_79481b4b9f445f8f = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x4da>" );
        
        if ( !isdefined( var_79481b4b9f445f8f ) )
        {
            return;
        }
        
        var_79481b4b9f445f8f function_786bb6aa1b76c7ee( "<dev string:x4eb>", 1 );
    }

    // Namespace namespace_473bdc208d3e708a
    // Params 0, eflags: 0x4
    // Checksum 0x62113ec3, Offset: 0x420f
    // Size: 0x16, Type: dev
    function private debug_burrow()
    {
        return getdvarint( @"hash_9fd387aebcb22387", 0 ) > 0;
    }

    // Namespace namespace_473bdc208d3e708a
    // Params 1, eflags: 0x4
    // Checksum 0x6e81ced9, Offset: 0x422d
    // Size: 0xe4, Type: dev
    function private function_c2bd455103722f63( params )
    {
        var_f39d8960915f9a15 = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x4da>" );
        
        if ( !isdefined( var_f39d8960915f9a15 ) )
        {
            return;
        }
        
        state_index = int( params[ 0 ] );
        
        if ( state_index == 0 )
        {
            var_f39d8960915f9a15.worm_underground_ent utility::function_7c10ea82c1e305b8( "<dev string:x4f5>", "<dev string:x501>" );
        }
        
        if ( state_index == 1 )
        {
            var_f39d8960915f9a15.worm_underground_ent utility::function_7c10ea82c1e305b8( "<dev string:x4f5>", "<dev string:x505>" );
        }
        
        if ( state_index == 2 )
        {
            var_f39d8960915f9a15.worm_underground_ent utility::function_7c10ea82c1e305b8( "<dev string:x4f5>", "<dev string:x510>" );
        }
        
        if ( state_index == 3 )
        {
            var_f39d8960915f9a15.worm_underground_ent utility::function_7c10ea82c1e305b8( "<dev string:x4f5>", "<dev string:x51c>" );
        }
    }

    // Namespace namespace_473bdc208d3e708a
    // Params 0, eflags: 0x4
    // Checksum 0x1f387688, Offset: 0x4319
    // Size: 0x1a, Type: dev
    function private function_e62155d4dc90cd20()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x527>", @"hash_9fd387aebcb22387" );
    }

    // Namespace namespace_473bdc208d3e708a
    // Params 2, eflags: 0x4
    // Checksum 0x3cdfc999, Offset: 0x433b
    // Size: 0x6d, Type: dev
    function private burrow_print( text, pos )
    {
        if ( !isai( self ) && !isdefined( pos ) )
        {
            return;
        }
        
        if ( debug_burrow() )
        {
            if ( !isdefined( pos ) )
            {
                pos = self.origin + ( 0, 0, 70 );
            }
            
            print3d( pos, "<dev string:x53e>" + text, ( 1, 0, 0 ) );
        }
    }

    // Namespace namespace_473bdc208d3e708a
    // Params 0, eflags: 0x4
    // Checksum 0xc84f6f06, Offset: 0x43b0
    // Size: 0xad, Type: dev
    function private function_bcf012df94a8f326()
    {
        self endon( #"death" );
        
        while ( true )
        {
            if ( !debug_burrow() )
            {
                waitframe();
                continue;
            }
            
            var_f39d8960915f9a15 = self;
            
            if ( isdefined( var_f39d8960915f9a15 ) )
            {
                var_aaf3810410e21411 = ( 1, 0.2, 0.2 );
                sphere( var_f39d8960915f9a15.worm_underground_ent.origin, 30, var_aaf3810410e21411, 1, 1 );
                print3d( var_f39d8960915f9a15.worm_underground_ent.origin + ( 0, 0, -10 ), "<dev string:x551>", var_aaf3810410e21411, 0.8, 0.5 );
            }
            
            waitframe();
        }
    }

    // Namespace namespace_473bdc208d3e708a
    // Params 0, eflags: 0x4
    // Checksum 0x951c4982, Offset: 0x4465
    // Size: 0x316, Type: dev
    function private function_fc0e1deee9cb3d5e()
    {
        self endon( #"death" );
        
        while ( true )
        {
            if ( !debug_burrow() )
            {
                waitframe();
                continue;
            }
            
            if ( level.players.size > 0 && isalive( level.players[ 0 ] ) )
            {
                var_f39d8960915f9a15 = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x4da>" );
                
                if ( !isdefined( var_f39d8960915f9a15 ) )
                {
                    var_f39d8960915f9a15 = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x56d>" );
                }
                
                if ( !isdefined( var_f39d8960915f9a15 ) )
                {
                    var_f39d8960915f9a15 = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x583>" );
                }
                
                closest_tacpoint = findclosesttacpoint( level.players[ 0 ].origin );
                
                if ( isdefined( closest_tacpoint ) )
                {
                    color = function_dd8bbd755733417a( closest_tacpoint, 0 ) ? ( 0, 1, 0 ) : ( 1, 0, 0 );
                    printtoscreen2d( 400, 400, "<dev string:x598>" + function_93b6d3e8b4c58539( closest_tacpoint ), color );
                    printtoscreen2d( 400, 450, "<dev string:x5c1>" + function_f1f8a8f5f26409b5( closest_tacpoint ), color );
                    
                    if ( distance( level.players[ 0 ].origin, closest_tacpoint.origin ) > 200 )
                    {
                        var_8d5dfdb169217742 = function_9073d5c7012a71b6( level.players[ 0 ].origin );
                        printtoscreen2d( 400, 500, "<dev string:x5f3>" + ( var_8d5dfdb169217742 ? "<dev string:x620>" : "<dev string:x63b>" ), var_8d5dfdb169217742 ? ( 0, 1, 0 ) : ( 1, 0, 0 ) );
                    }
                }
                
                roomindex = undefined;
                
                if ( isdefined( var_f39d8960915f9a15 ) && isdefined( var_f39d8960915f9a15.var_17f45fd4407379ae ) )
                {
                    roomindex = var_f39d8960915f9a15.var_17f45fd4407379ae;
                }
                
                if ( isdefined( roomindex ) )
                {
                    tacpoint = function_4a4a3abdc931f1b7( level.players[ 0 ].origin, getdvarfloat( @"hash_5eb7fc0533e937ba", 500 ), roomindex, 1 );
                    
                    if ( isdefined( tacpoint ) )
                    {
                        color = function_dd8bbd755733417a( tacpoint, 0 ) ? ( 0, 1, 0 ) : ( 1, 0, 0 );
                        sphere( tacpoint.origin, 20, color );
                        print3d( tacpoint.origin, "<dev string:x656>" + function_93b6d3e8b4c58539( tacpoint ), color );
                    }
                }
                
                if ( var_f39d8960915f9a15 && var_f39d8960915f9a15 tagexists( "<dev string:x673>" ) )
                {
                    mouth_tag_origin = var_f39d8960915f9a15 gettagorigin( "<dev string:x673>" );
                    cylinder( mouth_tag_origin - ( 0, 0, 200 ), mouth_tag_origin + ( 0, 0, 200 ), 200, ( 1, 1, 0 ), 0, 1 );
                }
            }
            
            waitframe();
        }
    }

#/
