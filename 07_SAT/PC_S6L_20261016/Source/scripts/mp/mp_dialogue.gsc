// scripts\mp\mp_dialogue.gsc  (hash_2ad704f5066d8674.gscc) (size: 4836 Bytes / 0x12e4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa3e56b34 (2749721396)
// size ...... 4836 (0x12e4)
// includes .. 5   (offset: 0x11b0)
// strings ... 19  (offset: 0x11d8)
// dev strs .. 0   (offset: 0x12e4)
// exports ... 11  (offset: 0x9cc)
// cseg ...... 0x13e + 0x88e (0x9cc)
// imports ... 54  (offset: 0xb84)
// animtree1 . 0   (offset: 0x12e4)
// animtree2 . 0   (offset: 0x12e4)
#using scripts\anim\dialogue;
#using scripts\asm\asm;
#using scripts\asm\shared\utility;
#using scripts\common\utility;
#using scripts\mp\common\utility\player_utility;

#namespace mp_dialogue;

// Namespace mp_dialogue
// Params 0
// Checksum 0x722bb04c, Offset: 0x15c
// Size: 0x44
function main()
{
    level.dialogue_playing = 0;
    level.current_dialogue = "";
    level.vo_playsoundfunc = &function_211912730ac7cee1;
    level.var_417561f3a462d6c3 = &function_98f8ec111ca1327;
    level.var_8e07c78f18ec732d = &function_6afd2adca8432d75;
}

// Namespace mp_dialogue
// Params 4
// Checksum 0x7266f43, Offset: 0x1a8
// Size: 0x7b
function function_98f8ec111ca1327( origin, radius, desiredteam, excludeents )
{
    if ( isdefined( excludeents ) && !isarray( excludeents ) )
    {
        excludeents = [ excludeents ];
    }
    
    if ( level.var_f8f564d5b2b09e05 ?? utility::function_645a77750f1850b5() )
    {
        return getentitiesinradiusfrompartitiongrid( origin, radius, createentitytypemask( [ "etype_player" ] ), excludeents, desiredteam );
    }
    
    return player_utility::script_getplayersinradius( origin, radius, desiredteam, excludeents );
}

// Namespace mp_dialogue
// Params 4
// Checksum 0xfd3eecff, Offset: 0x22c
// Size: 0xa1
function function_6afd2adca8432d75( origin, radius, desiredteam, excludeents )
{
    if ( isdefined( excludeents ) && !isarray( excludeents ) )
    {
        excludeents = [ excludeents ];
    }
    
    if ( level.var_f8f564d5b2b09e05 ?? utility::function_645a77750f1850b5() )
    {
        return getentitiesinradiusfrompartitiongrid( origin, radius, createentitytypemask( [ "etype_ai" ] ), excludeents, desiredteam );
    }
    
    if ( isdefined( excludeents ) && excludeents.size )
    {
        return arrayremove( getaiarrayinradius( origin, radius, desiredteam ), excludeents );
    }
    
    if ( isdefined( desiredteam ) )
    {
        return getaiarrayinradius( origin, radius, desiredteam );
    }
    
    return getaiarrayinradius( origin, radius );
}

// Namespace mp_dialogue
// Params 3
// Checksum 0x778c3465, Offset: 0x2d6
// Size: 0x122, Type: bool
function function_211912730ac7cee1( alias, audience, var_520a66d8d2b337d3 )
{
    speaker = self;
    
    if ( !isdefined( audience ) )
    {
        audience = self.vo_audience;
    }
    
    if ( isstruct( self ) && isdefined( self.vo_parent ) )
    {
        speaker = self.vo_parent;
    }
    
    self notify( #"stop_dialogue" );
    context = self.isradioemitter ? "dx_radio_3d" : undefined;
    speaker thread function_ebae15e127c1b107( alias, context, audience, var_520a66d8d2b337d3 );
    
    if ( !self.skip_face && ( isai( self ) || self.fakeactor_face_anim ) )
    {
        face_anim = dialogue::get_face_anim( alias );
        
        if ( isdefined( face_anim ) )
        {
            thread anim_facialanim( self, alias, face_anim );
        }
        else
        {
            intensity = get_intensity( alias );
            thread anim_facialfiller( "stop_facialFiller", undefined, 0, undefined, intensity );
        }
    }
    
    result = function_99504ea483ea8eb3( alias );
    self notify( #"stop_facialFiller" );
    return istrue( result );
}

// Namespace mp_dialogue
// Params 1
// Checksum 0xdaee9055, Offset: 0x401
// Size: 0x49, Type: bool
function function_99504ea483ea8eb3( alias )
{
    self endon( #"death" );
    self endon( #"stop_dialogue" );
    duration = lookupsoundlength( alias, istrue( level.var_34e2903bffd9b28b ) ) / 1000;
    wait duration;
    return true;
}

// Namespace mp_dialogue
// Params 1
// Checksum 0x48e49bc, Offset: 0x453
// Size: 0x71
function get_intensity( alias )
{
    var_7237854e3be197ca = self.var_b3a63e2f1f8cf95b;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    var_37138c1c61090afb = [ "sm", "sm", "md", "lg" ];
    intensity = soundgetintensity( alias ) ?? 0;
    return var_37138c1c61090afb[ intensity ];
}

// Namespace mp_dialogue
// Params 4
// Checksum 0x3618eab8, Offset: 0x4cd
// Size: 0x15b
function function_ebae15e127c1b107( alias, context, audience, var_520a66d8d2b337d3 )
{
    self stopsounds( 1 );
    self stopsoundchannel( "voice_bchatter_1_3d", 1 );
    waitframe();
    
    if ( utility::is_dead_or_dying( self ) )
    {
        return;
    }
    
    if ( isplayer( audience ) )
    {
        self playsoundtoplayer( alias, audience, self );
        return;
    }
    
    if ( isstring( audience ) )
    {
        if ( isplayer( self ) )
        {
            self playsoundtoteam( alias, audience, self, self );
        }
        else
        {
            self playsoundtoteam( alias, audience, undefined, self );
        }
        
        return;
    }
    
    if ( isarray( audience ) )
    {
        foreach ( player_or_team in audience )
        {
            thread function_ebae15e127c1b107( alias, context, player_or_team );
        }
        
        return;
    }
    
    if ( isdefined( context ) )
    {
        self playcontextsound( alias, "dx_type", context );
        return;
    }
    
    if ( isplayer( self ) || isagent( self ) )
    {
        self playsoundatviewheight( alias );
        return;
    }
    
    if ( var_520a66d8d2b337d3 )
    {
        self function_79b438d0acfbcc69( alias, undefined, self );
        return;
    }
    
    self playsound( alias, undefined, self );
}

// Namespace mp_dialogue
// Params 5
// Checksum 0xbbd34bc3, Offset: 0x630
// Size: 0x253
function anim_facialfiller( msg, looktarget, force, msg_ent, intensity = "sm" )
{
    self endon( #"death" );
    self notify( #"newfacialanim" );
    
    if ( !isdefined( msg_ent ) )
    {
        msg_ent = self;
    }
    
    if ( isai( self ) && !isalive( self ) )
    {
        return;
    }
    
    if ( !isai( self ) )
    {
        if ( !isdefined( self.fakeactor_face_anim ) )
        {
            return;
        }
        else if ( !self.fakeactor_face_anim || !isalive( self ) )
        {
            return;
        }
    }
    
    if ( self.nofacialfiller )
    {
        return;
    }
    
    if ( !force && !utility::isfacialstateallowed( "filler" ) )
    {
        return;
    }
    
    if ( self.unittype == "c6" || self.unittype == "c8" || self.unittype == "c12" )
    {
        return;
    }
    
    self notify( #"newlooktarget" );
    self endon( #"newlooktarget" );
    waittillframeend();
    
    if ( !isdefined( looktarget ) && isdefined( self.bc_looktarget ) )
    {
        looktarget = self.bc_looktarget;
    }
    
    archetype = utility::function_18bf04f16702b9b2();
    talkanim = self.defaulttalk;
    headknob = self.scriptedtalkingknob;
    assert( isalive( self ) );
    utility::setfacialstate( "filler" );
    
    if ( archetype != "" )
    {
        if ( isai( self ) )
        {
            self setfacialindex( "talk_" + intensity );
        }
        else if ( self.var_2eb71d32b982e8a4 )
        {
            utility::function_be1ba362de53a104( "talk_" + intensity );
        }
        else
        {
            utility::setfacialindexfornonai( "talk_" + intensity );
        }
    }
    else
    {
        self setanimknoblimitedrestart( talkanim, 1, 0, 1 );
        self setanim( headknob, 5, 0.267 );
    }
    
    msg_ent waittill( msg );
    
    if ( archetype != "" && isai( self ) )
    {
        self setfacialindex( "none" );
    }
    else if ( self.var_2eb71d32b982e8a4 && isdefined( self.capanimset ) )
    {
        utility::function_be1ba362de53a104( "none" );
    }
    
    utility::clearfacialstate( "filler" );
}

// Namespace mp_dialogue
// Params 3
// Checksum 0xad286151, Offset: 0x88b
// Size: 0xc6
function anim_facialanim( guy, anime, faceanim )
{
    guy endon( #"death" );
    self endon( anime );
    guy notify( #"newlooktarget" );
    guy notify( #"newfacialanim" );
    utility::disabledefaultfacialanims();
    waittillframeend();
    
    if ( !isdefined( self.scriptedtalkingknob ) )
    {
        self.scriptedtalkingknob = asm::asm_getxanim( "knobs", asm::asm_lookupanimfromalias( "knobs", "scripted_talking" ) );
    }
    
    animflag = "scripted_face_" + anime;
    guy setanim( self.scriptedtalkingknob, 1, 0.2 );
    guy setflaggedanimknobrestart( animflag, faceanim, 1, 0, 1 );
    thread clearfaceanimonanimdone( guy, animflag, anime );
}

// Namespace mp_dialogue
// Params 3
// Checksum 0x9f46805d, Offset: 0x959
// Size: 0x73
function clearfaceanimonanimdone( guy, animflag, anime )
{
    guy endon( #"death" );
    guy endon( #"newfacialanim" );
    guy waittillmatch( animflag, #"end" );
    guy notify( #"scripted_face_done" );
    guy clearanim( self.scriptedtalkingknob, 0.2 );
    utility::disabledefaultfacialanims( 0 );
}

