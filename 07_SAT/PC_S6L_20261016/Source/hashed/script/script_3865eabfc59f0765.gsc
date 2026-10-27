// script_3865eabfc59f0765  (hash_3865eabfc59f0765.gscc) (size: 5103 Bytes / 0x13ef / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa8aba5b9 (2829821369)
// size ...... 5103 (0x13ef)
// includes .. 6   (offset: 0x1323)
// strings ... 11  (offset: 0x1353)
// dev strs .. 0   (offset: 0x13ef)
// exports ... 13  (offset: 0xabb)
// cseg ...... 0xf6 + 0x9c5 (0xabb)
// imports ... 55  (offset: 0xcc3)
// animtree1 . 0   (offset: 0x13ef)
// animtree2 . 0   (offset: 0x13ef)
#using script_16555c1140262e45;
#using scripts\asm\asm;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\interaction;

#namespace dawg_pet_asm;

// Namespace dawg_pet_asm
// Params 0
// Checksum 0xdd9991c8, Offset: 0x114
// Size: 0x2c
function dawg_init()
{
    callback::add( #"player_death", &function_d04f99b55a2756e );
    callback::add( #"player_laststand", &function_9788e8f60433a9dc );
}

// Namespace dawg_pet_asm
// Params 0
// Checksum 0x3faf5348, Offset: 0x148
// Size: 0xd9
function function_d88a4895de88fa18()
{
    if ( isalive( self ) && !self.pet_interact_spawned )
    {
        self.pet_interact = interaction::register_interact( self.origin, 26, &on_pet_interact );
        self.pet_interact interaction::set_interact_hint_callback( &pet_interact_per_player_hint );
        self.pet_interact linkto( self, "tag_origin", ( 42, 0, 45 ), ( 0, 0, 0 ) );
        self.pet_interact.var_5a1a15178b1060b3 = "dawg";
        self.pet_interact.var_69c82d94dce882a5 = 1;
        thread utility::delete_on_death( self.pet_interact );
        self.pet_interact_spawned = 1;
        self.pet_interact.dawg = self;
    }
}

// Namespace dawg_pet_asm
// Params 0
// Checksum 0xb5447ca0, Offset: 0x229
// Size: 0x4c
function function_c9779b57c42e7d09()
{
    self.being_pet = undefined;
    
    if ( isdefined( self.cinematicent ) )
    {
        self.cinematicent delete();
    }
    
    if ( isdefined( self.pet_interact ) )
    {
        self.pet_interact_spawned = 0;
        self.pet_interact delete();
    }
}

// Namespace dawg_pet_asm
// Params 1, eflags: 0x4
// Checksum 0xae983b02, Offset: 0x27d
// Size: 0x41
function private on_pet_interact( player )
{
    if ( !can_pet_interact( player ) )
    {
        return;
    }
    
    self.dawg function_786bb6aa1b76c7ee( "petting", 1 );
    player thread function_3b4023a072e16fff( self.dawg, self );
}

// Namespace dawg_pet_asm
// Params 2
// Checksum 0x8c51ab46, Offset: 0x2c6
// Size: 0x281
function function_3b4023a072e16fff( dawg, interact )
{
    level endon( #"game_ended" );
    self setstance( "stand", 1, 1, 1 );
    interact disableplayeruseforallplayers();
    dawg.being_pet = 1;
    level notify( #"dawg_pet" );
    var_6c61d6f6ea7c3e11 = utility::spawn_model( "tag_origin", dawg.origin, ( 0, 0, 0 ) );
    var_6c61d6f6ea7c3e11 linkto( dawg, "tag_origin", ( 51, 0, -1 ), ( 0, 180, 0 ) );
    dawg.cinematicent = var_6c61d6f6ea7c3e11;
    
    if ( isplayer( self ) )
    {
        self.petting_dawg = 1;
        self playerlinktoblend( var_6c61d6f6ea7c3e11, "tag_origin", 0.1, 0.1, 0.05 );
    }
    
    if ( dawg.turret )
    {
        dawg.turret.var_e2110bc672e50237 = dawg.turret getturretconvergencetime( 0 );
        dawg.turret setturretconvergencetime( 700, 0 );
        dawg.turret dawg_turret::dawg_turret_reset_turret();
    }
    
    wait 0.65;
    
    if ( isalive( dawg ) )
    {
        dawg thread asm::function_7256f5ba459c840b( "pet_mode_in" );
        dawg thread pet_finish_time( 3 );
    }
    
    time = 3;
    
    if ( isplayer( self ) )
    {
        self freezecontrols( 1 );
        time = self playviewmodelanim( "sat_con_van_pet_vm", 1 );
        time *= 0.001;
        self playanimscriptsceneevent( "scripted_scene", "sat_zm_con_dog_pet" );
    }
    
    var_6c61d6f6ea7c3e11 utility::delaycall( 0.05, &unlink );
    dawg utility::waittill_notify_or_timeout( "death", time );
    
    if ( isplayer( self ) )
    {
        function_258a9822f079c48a();
    }
    
    if ( isdefined( interact ) )
    {
        interact enableplayeruseforallplayers();
    }
    
    if ( isdefined( var_6c61d6f6ea7c3e11 ) )
    {
        var_6c61d6f6ea7c3e11 delete();
    }
    
    if ( isdefined( dawg ) )
    {
        dawg.being_pet = undefined;
        dawg notify( #"petting_finished" );
    }
    
    if ( dawg.turret )
    {
        dawg.turret setturretconvergencetime( dawg.turret.var_e2110bc672e50237, 0 );
        dawg.turret.var_e2110bc672e50237 = undefined;
        dawg.turret dawg_turret::function_609516267ed6c6b3();
        dawg.turret dawg_turret::function_1943eb45c441101d();
    }
}

// Namespace dawg_pet_asm
// Params 1
// Checksum 0xdedb6fe0, Offset: 0x54f
// Size: 0x2a
function pet_finish_time( time )
{
    self endon( #"death" );
    wait 2.3;
    self function_786bb6aa1b76c7ee( "petting", 0 );
}

// Namespace dawg_pet_asm
// Params 2, eflags: 0x4
// Checksum 0xab03a7c9, Offset: 0x581
// Size: 0xb1
function private pet_interact_per_player_hint( usable, player )
{
    if ( isdefined( player ) && isdefined( usable ) )
    {
        if ( !usable can_pet_interact( player ) )
        {
            return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
        }
        
        return { #var_26bbd300351fde34:0, #string:&"ai/dawg_pet_hint", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
}

// Namespace dawg_pet_asm
// Params 1, eflags: 0x4
// Checksum 0x345c2f85, Offset: 0x63b
// Size: 0x1fc, Type: bool
function private can_pet_interact( player )
{
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    if ( !player isstanceallowed( "stand" ) )
    {
        return false;
    }
    
    if ( player.var_6b5c16c263b6b7ac )
    {
        return false;
    }
    
    movementdir = vectornormalize( player getvelocity() );
    playerismoving = movementdir != ( 0, 0, 0 );
    
    if ( playerismoving )
    {
        return false;
    }
    
    if ( isdefined( player.origin ) && isdefined( self.dawg.origin ) )
    {
        interact_diff = abs( player.origin[ 2 ] - self.dawg.origin[ 2 ] );
        
        if ( interact_diff > 6 )
        {
            return false;
        }
    }
    
    if ( !player isonground() )
    {
        return false;
    }
    
    if ( !isalive( self.dawg ) )
    {
        return false;
    }
    
    if ( self.dawg.being_pet )
    {
        return false;
    }
    
    if ( player.inlaststand )
    {
        return false;
    }
    
    player_forward = anglestoforward( player.angles );
    dog_forward = anglestoforward( self.dawg.angles );
    dot = vectordot( player_forward, dog_forward );
    
    if ( dot > 0 )
    {
        return false;
    }
    else if ( abs( dot ) < 0.8 )
    {
        return false;
    }
    
    if ( player is_pet_blocked( self.dawg ) )
    {
        return false;
    }
    
    if ( player isreloading() || player isgestureplaying() || player isviewmodelanimplaying() || !isnullweapon( player.highpriorityweapon ) )
    {
        return false;
    }
    
    petting_pos = self.dawg.origin;
    ground_pos = getgroundposition( petting_pos, 15 );
    return true;
}

// Namespace dawg_pet_asm
// Params 1, eflags: 0x4
// Checksum 0xc1d20c5b, Offset: 0x840
// Size: 0x20b, Type: bool
function private is_pet_blocked( dog )
{
    var_7259e1e041d483a0 = vectornormalize( dog.origin - self.origin );
    nearbyai = getplayersandaiarrayinradius( dog.origin, 100 );
    
    foreach ( ent in nearbyai )
    {
        if ( ent == self || ent == dog )
        {
            continue;
        }
        
        dot = vectordot( vectornormalize( ent.origin - self.origin ), var_7259e1e041d483a0 );
        
        if ( isplayer( ent ) && dot > 0.5 )
        {
            if ( !ent.is_petting )
            {
                return true;
            }
            
            continue;
        }
        
        if ( isagent( ent ) && dot > 0.5 )
        {
            if ( ent.being_pet )
            {
                return true;
            }
        }
    }
    
    forward = vectornormalize( anglestoforward( self.angles ) );
    forward *= 32;
    backward = forward * -1;
    var_82f0fb6dc1c89261 = self getcentroid();
    end_back_pos = var_82f0fb6dc1c89261 + backward;
    end_forward_pos = var_82f0fb6dc1c89261 + forward;
    ignore_ents = [ 1:dog, 0:self ];
    contents = trace::create_contents( 0, 1, 1, 0, 0, 0, 1, 0, 0, 0 );
    passed_backwards = trace::sphere_trace_passed( var_82f0fb6dc1c89261, end_back_pos, 32, ignore_ents, contents );
    passed_forwards = trace::sphere_trace_passed( var_82f0fb6dc1c89261, end_forward_pos, 32, ignore_ents, contents );
    
    if ( !passed_backwards || !passed_forwards )
    {
        return true;
    }
    
    return false;
}

// Namespace dawg_pet_asm
// Params 0
// Checksum 0x37fd75b7, Offset: 0xa54
// Size: 0x19
function function_258a9822f079c48a()
{
    self.petting_dawg = undefined;
    self freezecontrols( 0 );
    self unlink();
}

// Namespace dawg_pet_asm
// Params 1
// Checksum 0xec244c58, Offset: 0xa75
// Size: 0x1f
function function_d04f99b55a2756e( sparams )
{
    if ( self.petting_dawg )
    {
        function_258a9822f079c48a();
    }
}

// Namespace dawg_pet_asm
// Params 1
// Checksum 0x88cc649, Offset: 0xa9c
// Size: 0x1f
function function_9788e8f60433a9dc( sparams )
{
    if ( self.petting_dawg )
    {
        function_258a9822f079c48a();
    }
}

