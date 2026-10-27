// scripts\mp\animation_suite.gsc  (hash_036e9988c3be2565.gscc) (size: 5869 Bytes / 0x16ed / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaba6abaa (2879826858)
// size ...... 5869 (0x16ed)
// includes .. 3   (offset: 0x1599)
// strings ... 22  (offset: 0x15b1)
// dev strs .. 3   (offset: 0x16c9)
// exports ... 17  (offset: 0xea9)
// cseg ...... 0x260 + 0xc49 (0xea9)
// imports ... 34  (offset: 0x1151)
// animtree1 . 0   (offset: 0x16ed)
// animtree2 . 0   (offset: 0x16ed)
#using scripts\common\utility;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\game_utility;

#namespace animation_suite;

// Namespace animation_suite
// Params 0
// Checksum 0xa74e31c, Offset: 0x27e
// Size: 0x163
function animationsuite()
{
    while ( !game[ "gamestarted" ] )
    {
        waitframe();
    }
    
    animatedobjs = getentarray( "animObj", #targetname );
    assert( animatedobjs.size < 200, animatedobjs.size + "<dev string:x24>" );
    groups = gathergroups( animatedobjs );
    setupvfxobjs( animatedobjs );
    setupsfxobjs( animatedobjs );
    
    foreach ( obj in animatedobjs )
    {
        if ( game_utility::islargemap() )
        {
            obj forcenetfieldhighlod( 1 );
        }
        
        if ( isdefined( obj.script_animation_type ) )
        {
            switch ( obj.script_animation_type )
            {
                case #"hash_7bbd660a0ef1a992":
                case #"hash_dac7d62cc377c033":
                    obj thread animsuite_rotation( obj.script_animation_type );
                    break;
                case #"hash_2fc0e960a17f77d0":
                case #"hash_cb20eda5e00181ef":
                    obj thread animsuite_translation( obj.script_animation_type );
                    break;
            }
        }
    }
}

// Namespace animation_suite
// Params 1
// Checksum 0xd48273a9, Offset: 0x3e9
// Size: 0x134
function setupvfxobjs( objects )
{
    foreach ( obj in objects )
    {
        if ( isdefined( obj.script_noteworthy ) && isstartstr( obj.script_noteworthy, "vfx_" ) )
        {
            model = obj utility::spawn_tag_origin();
            model show();
            model linkto( obj );
            assert( isdefined( level._effect[ obj.script_noteworthy ] ), obj.script_noteworthy + "<dev string:x8f>" );
            waitframe();
            
            if ( !isvalidanimsuiteentity( "setupVFXObjs(): obj", obj ) )
            {
                continue;
            }
            
            if ( !isvalidanimsuiteentity( "setupVFXObjs(): model", model ) )
            {
                continue;
            }
            
            thread delayfxcall( utility::getfx( obj.script_noteworthy ), model, "tag_origin" );
        }
    }
}

// Namespace animation_suite
// Params 3
// Checksum 0xa214ae23, Offset: 0x525
// Size: 0x3c
function delayfxcall( fx, model, tag )
{
    wait 5;
    
    if ( !isvalidanimsuiteentity( "delayFXCall()", model ) )
    {
        return;
    }
    
    playfxontag( fx, model, tag );
}

// Namespace animation_suite
// Params 1
// Checksum 0xccabc915, Offset: 0x569
// Size: 0xb6
function setupsfxobjs( objects )
{
    foreach ( obj in objects )
    {
        if ( isdefined( obj.script_noteworthy ) && isstartstr( obj.script_noteworthy, "sfx_" ) )
        {
            obj setmodel( "tag_origin" );
            obj thread utility::play_loop_sound_on_entity( "mp_quarry_lg_crane_loop" );
        }
    }
}

// Namespace animation_suite
// Params 0
// Checksum 0xf92056a5, Offset: 0x627
// Size: 0x34
function debug_temp_sphere()
{
    while ( true )
    {
        debug::drawsphere( self.origin, 32, 0.1, ( 0, 0, 255 ) );
        wait 0.1;
    }
}

// Namespace animation_suite
// Params 1
// Checksum 0x80ba9377, Offset: 0x663
// Size: 0x1e3
function gathergroups( objects )
{
    groups = [];
    groupssorted = [];
    
    foreach ( obj in objects )
    {
        if ( isdefined( obj.script_noteworthy ) && issubstr( obj.script_noteworthy, "group" ) )
        {
            groups[ groups.size ] = obj;
        }
    }
    
    foreach ( item in groups )
    {
        if ( !isdefined( groupssorted[ item.script_noteworthy ] ) )
        {
            groupssorted[ item.script_noteworthy ] = [];
        }
        
        groupssorted[ item.script_noteworthy ][ groupssorted[ item.script_noteworthy ].size ] = item;
    }
    
    foreach ( group in groupssorted )
    {
        parent = animsuite_getparentobject( group );
        animsuite_linkchildrentoparentobject( parent, group );
    }
    
    return groupssorted;
}

// Namespace animation_suite
// Params 1
// Checksum 0x82f9c19e, Offset: 0x84f
// Size: 0x87
function animsuite_getparentobject( group )
{
    foreach ( entry in group )
    {
        if ( isdefined( entry.script_linkname ) )
        {
            return entry;
        }
    }
}

// Namespace animation_suite
// Params 2
// Checksum 0x44e5981d, Offset: 0x8de
// Size: 0x9c
function animsuite_linkchildrentoparentobject( parent, group )
{
    if ( isdefined( parent ) && isdefined( group ) )
    {
        foreach ( entry in group )
        {
            if ( entry == parent )
            {
                continue;
            }
            
            entry linkto( parent );
        }
    }
}

// Namespace animation_suite
// Params 1
// Checksum 0xbbab9a87, Offset: 0x982
// Size: 0x36
function animsuite_translation( translation_type )
{
    if ( issubstr( translation_type, "pingpong" ) )
    {
        thread animsuite_translation_pingpong();
    }
    
    if ( issubstr( translation_type, "once" ) )
    {
        thread animsuite_translation_once();
    }
}

// Namespace animation_suite
// Params 0
// Checksum 0xa160bec3, Offset: 0x9c0
// Size: 0x198
function animsuite_translation_pingpong()
{
    level endon( #"game_ended" );
    translationamt = ( 0, 90, 0 );
    translationtime = 5;
    pause = 0.5;
    start = undefined;
    stop = undefined;
    
    if ( isdefined( self.script_translation_amount ) )
    {
        translationamt = self.script_translation_amount;
    }
    
    if ( isdefined( self.script_translation_time ) )
    {
        translationtime = self.script_translation_time;
    }
    
    if ( isdefined( self.script_audio_parameters ) )
    {
        if ( issubstr( self.script_audio_parameters, "start" ) )
        {
            start = "mp_quarry_lg_crane_start";
        }
        
        if ( issubstr( self.script_audio_parameters, "stop" ) )
        {
            stop = "mp_quarry_lg_crane_stop";
        }
    }
    
    while ( true )
    {
        firstpos = self.origin;
        self moveto( self.origin + translationamt, translationtime[ 0 ], translationtime[ 1 ], translationtime[ 2 ] );
        
        if ( isdefined( stop ) )
        {
            thread animsuite_playthreadedsound( translationtime[ 0 ], stop );
        }
        
        wait translationtime[ 0 ] + pause;
        
        if ( !isvalidanimsuiteentity( "animSuite_Translation_PingPong()", self ) )
        {
            return;
        }
        
        if ( isdefined( start ) )
        {
            playsoundatpos( self.origin, start );
        }
        
        self moveto( firstpos, translationtime[ 0 ], translationtime[ 1 ], translationtime[ 2 ] );
        
        if ( isdefined( stop ) )
        {
            thread animsuite_playthreadedsound( translationtime[ 0 ], stop );
        }
        
        wait translationtime[ 0 ] + pause;
        
        if ( !isvalidanimsuiteentity( "animSuite_Translation_PingPong()", self ) )
        {
            return;
        }
        
        if ( isdefined( start ) )
        {
            playsoundatpos( self.origin, start );
        }
    }
}

// Namespace animation_suite
// Params 2
// Checksum 0x1fb415af, Offset: 0xb60
// Size: 0x39
function animsuite_playthreadedsound( waittime, alias )
{
    wait waittime;
    
    if ( !isvalidanimsuiteentity( "animSuite_playThreadedSound()", self ) )
    {
        return;
    }
    
    playsoundatpos( self.origin, alias );
}

// Namespace animation_suite
// Params 0
// Checksum 0x2262d9cd, Offset: 0xba1
// Size: 0x8e
function animsuite_translation_once()
{
    level endon( #"game_ended" );
    translationamt = ( 0, 90, 0 );
    translationtime = 5;
    
    if ( isdefined( self.script_translation_amount ) )
    {
        translationamt = self.script_translation_amount;
    }
    
    if ( isdefined( self.script_translation_time ) )
    {
        translationtime = length( self.script_translation_time );
    }
    
    while ( true )
    {
        self rotateby( translationamt, translationtime, 0, 0 );
        wait translationtime;
        
        if ( !isvalidanimsuiteentity( "animSuite_Translation_Once()", self ) )
        {
            return;
        }
    }
}

// Namespace animation_suite
// Params 1
// Checksum 0x7f3ca143, Offset: 0xc37
// Size: 0x36
function animsuite_rotation( rotation_type )
{
    if ( issubstr( rotation_type, "pingpong" ) )
    {
        thread animsuite_rotation_pingpong();
    }
    
    if ( issubstr( rotation_type, "continuous" ) )
    {
        thread animsuite_rotation_continuous();
    }
}

// Namespace animation_suite
// Params 0
// Checksum 0x1804bde, Offset: 0xc75
// Size: 0x14c
function animsuite_rotation_pingpong()
{
    level endon( #"game_ended" );
    rotateamt = ( 0, 90, 0 );
    rotatetime = ( 5, 0, 0 );
    rotatepause = 0;
    start = undefined;
    stop = undefined;
    
    if ( isdefined( self.script_rotation_amount ) )
    {
        rotateamt = self.script_rotation_amount;
    }
    
    if ( isdefined( self.script_rotation_speed ) )
    {
        rotatetime = self.script_rotation_speed;
    }
    
    while ( true )
    {
        self rotateby( rotateamt, rotatetime[ 0 ], rotatetime[ 1 ], rotatetime[ 2 ] );
        
        if ( isdefined( stop ) )
        {
            thread animsuite_playthreadedsound( rotatetime[ 0 ] * 0.9, stop );
        }
        
        wait rotatetime[ 0 ] + rotatepause;
        
        if ( !isvalidanimsuiteentity( "animSuite_Rotation_PingPong()", self ) )
        {
            return;
        }
        
        if ( isdefined( start ) )
        {
            playsoundatpos( self.origin, start );
        }
        
        self rotateby( rotateamt * -1, rotatetime[ 0 ], rotatetime[ 1 ], rotatetime[ 2 ] );
        
        if ( isdefined( stop ) )
        {
            thread animsuite_playthreadedsound( rotatetime[ 0 ] * 0.9, stop );
        }
        
        wait rotatetime[ 0 ] + rotatepause;
        
        if ( !isvalidanimsuiteentity( "animSuite_Rotation_PingPong()", self ) )
        {
            return;
        }
        
        if ( isdefined( start ) )
        {
            playsoundatpos( self.origin, start );
        }
    }
}

// Namespace animation_suite
// Params 0
// Checksum 0xa487d075, Offset: 0xdc9
// Size: 0xa7
function animsuite_rotation_continuous()
{
    level endon( #"game_ended" );
    rotateamt = ( 0, 90, 0 );
    rotatetime = ( 5, 0, 0 );
    
    if ( isdefined( self.script_rotation_amount ) )
    {
        rotateamt = self.script_rotation_amount;
    }
    
    if ( isdefined( self.script_rotation_speed ) )
    {
        rotatetime = self.script_rotation_speed;
    }
    
    while ( 1 && rotatetime[ 0 ] > 0 )
    {
        self rotateby( rotateamt, rotatetime[ 0 ], rotatetime[ 1 ], rotatetime[ 2 ] );
        wait rotatetime[ 0 ];
        
        if ( !isvalidanimsuiteentity( "animSuite_Rotation_Continuous()", self ) )
        {
            return;
        }
    }
}

// Namespace animation_suite
// Params 2
// Checksum 0x74a90f3c, Offset: 0xe78
// Size: 0x30, Type: bool
function isvalidanimsuiteentity( funcname, ent )
{
    if ( !isdefined( ent ) )
    {
        assertmsg( funcname + "<dev string:xad>" );
        return false;
    }
    
    return true;
}

