// scripts\common\notetrack.gsc  (hash_7b165416c1291173.gscc) (size: 11335 Bytes / 0x2c47 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb909aad9 (3104418521)
// size ...... 11335 (0x2c47)
// includes .. 3   (offset: 0x28c3)
// strings ... 33  (offset: 0x28db)
// dev strs .. 21  (offset: 0x2b3b)
// exports ... 26  (offset: 0x1d0b)
// cseg ...... 0x273 + 0x1a98 (0x1d0b)
// imports ... 62  (offset: 0x211b)
// animtree1 . 0   (offset: 0x2c47)
// animtree2 . 0   (offset: 0x2c47)
#using scripts\anim\face;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace notetrack;

// Namespace notetrack
// Params 0
// Checksum 0x738b0d00, Offset: 0x291
// Size: 0xa
function function_b25e047f92f346cb()
{
    level thread function_8046f9dfc11eaffe();
}

// Namespace notetrack
// Params 2
// Checksum 0x145eb524, Offset: 0x2a3
// Size: 0xd6
function agent_notetrack_redirect( guy, msg )
{
    guy endon( #"stop_sequencing_notetracks" );
    guy endon( #"death" );
    guy endon( #"stop_agent_notetrack_redirect" );
    
    while ( true )
    {
        self waittill( #"animscripted", notetracks );
        self notify( msg, notetracks );
        
        foreach ( note in notetracks )
        {
            if ( note == "end" )
            {
                return;
            }
        }
    }
}

// Namespace notetrack
// Params 6
// Checksum 0x858f1bea, Offset: 0x381
// Size: 0x57
function start_notetrack_wait( guy, anim_string, anime, animname, animation, var_17eaf0218e9cb200 )
{
    guy notify( #"stop_sequencing_notetracks" );
    thread notetrack_wait( guy, anim_string, self, anime, animname, animation, var_17eaf0218e9cb200 );
}

// Namespace notetrack
// Params 7
// Checksum 0xee80a8d1, Offset: 0x3e0
// Size: 0x431
function notetrack_wait( guy, msg, tag_entity, anime, animname_override, animation, var_17eaf0218e9cb200 )
{
    guy endon( #"stop_sequencing_notetracks" );
    guy endon( #"death" );
    
    if ( var_17eaf0218e9cb200 )
    {
        thread agent_notetrack_redirect( guy, msg );
    }
    
    if ( isdefined( tag_entity ) )
    {
        tag_owner = tag_entity;
    }
    else
    {
        tag_owner = self;
    }
    
    animname = undefined;
    
    if ( isdefined( animname_override ) )
    {
        animname = animname_override;
    }
    else
    {
        animname = guy.animname;
    }
    
    dialogue_array = spawnstruct();
    dialogue_array.dialog = [];
    scripted_notetracks = [];
    
    if ( isdefined( animname ) && isdefined( anime ) && isdefined( level.scr_notetrack[ animname ] ) )
    {
        if ( isdefined( level.scr_notetrack[ animname ][ anime ] ) )
        {
            scripted_notetracks[ anime ] = level.scr_notetrack[ animname ][ anime ];
        }
        
        if ( isdefined( level.scr_notetrack[ animname ][ "any" ] ) )
        {
            scripted_notetracks[ "any" ] = level.scr_notetrack[ animname ][ "any" ];
        }
    }
    
    foreach ( anime_key, _ in scripted_notetracks )
    {
        foreach ( notetrack_array in level.scr_notetrack[ animname ][ anime_key ] )
        {
            foreach ( scr_notetrack in notetrack_array )
            {
                if ( isdefined( scr_notetrack[ "dialog" ] ) )
                {
                    dialogue_array.dialog[ scr_notetrack[ "dialog" ] ] = 1;
                }
            }
        }
    }
    
    did_start_notetrack = 0;
    has_start_notetrack = 0;
    
    while ( true )
    {
        dialogue_array.dialoguenotetrack = 0;
        notetrack = undefined;
        
        if ( !did_start_notetrack && isdefined( animname ) && isdefined( anime ) )
        {
            did_start_notetrack = 1;
            start_notetrack = undefined;
            has_start_notetrack = isdefined( level.scr_notetrack[ animname ] ) && isdefined( level.scr_notetrack[ animname ][ anime ] ) && isdefined( level.scr_notetrack[ animname ][ anime ][ "start" ] );
            
            if ( !has_start_notetrack )
            {
                continue;
            }
            
            notetracks = [ "start" ];
        }
        else
        {
            guy waittill( msg, notetracks );
        }
        
        if ( !isarray( notetracks ) )
        {
            notetracks = [ notetracks ];
        }
        
        guy printnotetracks( notetracks );
        validatenotetracks( msg, notetracks, animation );
        end = undefined;
        
        foreach ( note in notetracks )
        {
            notetrack_handler( guy, anime, note, animname, scripted_notetracks, tag_owner, dialogue_array );
            
            if ( note == "end" )
            {
                end = 1;
            }
        }
        
        if ( isdefined( end ) )
        {
            break;
        }
    }
    
    if ( var_17eaf0218e9cb200 )
    {
        guy notify( #"stop_agent_notetrack_redirect" );
    }
}

// Namespace notetrack
// Params 0
// Checksum 0x6c7971c6, Offset: 0x819
// Size: 0x9
function function_99610fbefbbd9c80()
{
    thread function_92c116716f721e33();
}

// Namespace notetrack
// Params 0
// Checksum 0x967074af, Offset: 0x82a
// Size: 0xdf
function function_92c116716f721e33()
{
    self endon( #"entitydeleted" );
    noteflag = "scriptable";
    
    while ( true )
    {
        self waittill( noteflag, notetracks );
        printnotetracks( notetracks );
        validatenotetracks( noteflag, notetracks );
        end = undefined;
        
        foreach ( note in notetracks )
        {
            notetrack_handler( self, undefined, note );
            
            if ( note == "end" )
            {
                end = 1;
            }
        }
        
        if ( isdefined( end ) )
        {
            break;
        }
    }
}

// Namespace notetrack
// Params 7
// Checksum 0x2bfdba4e, Offset: 0x911
// Size: 0x1d6
function notetrack_handler( guy, anime, notetrack, animname, scripted_notetracks, tag_owner, dialogue_array )
{
    /#
        if ( getdvar( @"animsound" ) == "<dev string:x24>" )
        {
            guy thread animsound_tracker( anime, notetrack, animname );
        }
    #/
    
    if ( notetrack == "end" )
    {
        if ( isdefined( anim.callbacks[ "EntityHandleNotetrackAnimEnd" ] ) )
        {
            [[ anim.callbacks[ "EntityHandleNotetrackAnimEnd" ] ]]( guy, notetrack );
        }
        
        return 1;
    }
    
    if ( isdefined( scripted_notetracks ) )
    {
        foreach ( anime_key, _ in scripted_notetracks )
        {
            if ( isdefined( level.scr_notetrack[ animname ][ anime_key ][ notetrack ] ) )
            {
                foreach ( scr_notetrack in level.scr_notetrack[ animname ][ anime_key ][ notetrack ] )
                {
                    [[ anim.callbacks[ "AnimHandleNotetrack" ] ]]( scr_notetrack, guy, dialogue_array, tag_owner );
                }
            }
        }
    }
    
    if ( isdefined( anim.callbacks[ "EntityHandleNotetrack" ] ) )
    {
        [[ anim.callbacks[ "EntityHandleNotetrack" ] ]]( guy, notetrack );
    }
}

// Namespace notetrack
// Params 4
// Checksum 0x8046c518, Offset: 0xaef
// Size: 0x2ee
function anim_handle_notetrack( scr_notetrack, guy, dialogue_array, tag_owner )
{
    if ( isdefined( scr_notetrack[ "function" ] ) )
    {
        self thread [[ scr_notetrack[ "function" ] ]]( guy );
    }
    
    if ( isdefined( scr_notetrack[ "notify" ] ) )
    {
        level notify( scr_notetrack[ "notify" ] );
    }
    
    if ( isdefined( scr_notetrack[ "attach model" ] ) )
    {
        if ( isdefined( scr_notetrack[ "selftag" ] ) )
        {
            guy attach( scr_notetrack[ "attach model" ], scr_notetrack[ "selftag" ] );
            return;
        }
        
        tag_owner attach( scr_notetrack[ "attach model" ], scr_notetrack[ "tag" ] );
        return;
    }
    
    if ( isdefined( scr_notetrack[ "detach model" ] ) )
    {
        if ( isdefined( scr_notetrack[ "selftag" ] ) )
        {
            guy detach( scr_notetrack[ "detach model" ], scr_notetrack[ "selftag" ] );
        }
        else
        {
            tag_owner detach( scr_notetrack[ "detach model" ], scr_notetrack[ "tag" ] );
        }
    }
    
    if ( !dialogue_array.dialoguenotetrack )
    {
        if ( isdefined( scr_notetrack[ "dialog" ] ) && isdefined( dialogue_array.dialog[ scr_notetrack[ "dialog" ] ] ) )
        {
            guy face::sayspecificdialogue( scr_notetrack[ "dialog" ] );
            dialogue_array.dialog[ scr_notetrack[ "dialog" ] ] = undefined;
            dialogue_array.dialoguenotetrack = 1;
        }
    }
    
    if ( isdefined( scr_notetrack[ "create model" ] ) )
    {
        anim_addmodel( guy, scr_notetrack );
    }
    else if ( isdefined( scr_notetrack[ "delete model" ] ) )
    {
        anim_removemodel( guy, scr_notetrack );
    }
    
    if ( isdefined( scr_notetrack[ "selftag" ] ) )
    {
        if ( isdefined( scr_notetrack[ "effect" ] ) )
        {
            level thread notetrack_effect( guy, scr_notetrack );
        }
        
        if ( isdefined( scr_notetrack[ "stop_effect" ] ) )
        {
            stopfxontag( level._effect[ scr_notetrack[ "stop_effect" ] ], guy, scr_notetrack[ "selftag" ] );
        }
        
        if ( isdefined( scr_notetrack[ "swap_part_to_efx" ] ) )
        {
            playfxontag( level._effect[ scr_notetrack[ "swap_part_to_efx" ] ], guy, scr_notetrack[ "selftag" ] );
            guy hidepart( scr_notetrack[ "selftag" ] );
        }
        
        if ( isdefined( scr_notetrack[ "trace_part_for_efx" ] ) )
        {
            water_effect = undefined;
            effect = utility::getfx( scr_notetrack[ "trace_part_for_efx" ] );
            
            if ( isdefined( scr_notetrack[ "trace_part_for_efx_water" ] ) )
            {
                water_effect = utility::getfx( scr_notetrack[ "trace_part_for_efx_water" ] );
            }
            
            deletedepth = 0;
            
            if ( isdefined( scr_notetrack[ "trace_part_for_efx_delete_depth" ] ) )
            {
                deletedepth = scr_notetrack[ "trace_part_for_efx_delete_depth" ];
            }
            
            guy thread trace_part_for_efx( scr_notetrack[ "selftag" ], effect, water_effect, deletedepth );
        }
        
        if ( isdefined( scr_notetrack[ "trace_part_for_efx_canceling" ] ) )
        {
            guy thread trace_part_for_efx_cancel( scr_notetrack[ "selftag" ] );
        }
    }
    
    if ( isdefined( scr_notetrack[ "tag" ] ) && isdefined( scr_notetrack[ "effect" ] ) )
    {
        playfxontag( level._effect[ scr_notetrack[ "effect" ] ], tag_owner, scr_notetrack[ "tag" ] );
    }
    
    if ( isdefined( scr_notetrack[ "selftag" ] ) && isdefined( scr_notetrack[ "effect_looped" ] ) )
    {
        playfxontag( level._effect[ scr_notetrack[ "effect_looped" ] ], guy, scr_notetrack[ "selftag" ] );
    }
}

// Namespace notetrack
// Params 2
// Checksum 0xf3a51b4e, Offset: 0xde5
// Size: 0xd3
function anim_addmodel( guy, array )
{
    if ( !isdefined( guy.scriptmodel ) )
    {
        guy.scriptmodel = [];
    }
    
    index = guy.scriptmodel.size;
    guy.scriptmodel[ index ] = spawn( "script_model", ( 0, 0, 0 ) );
    guy.scriptmodel[ index ] setmodel( array[ "create model" ] );
    guy.scriptmodel[ index ].origin = guy gettagorigin( array[ "selftag" ] );
    guy.scriptmodel[ index ].angles = guy gettagangles( array[ "selftag" ] );
}

// Namespace notetrack
// Params 2
// Checksum 0x923f2a49, Offset: 0xec0
// Size: 0x120
function anim_removemodel( guy, array )
{
    /#
        if ( !isdefined( guy.scriptmodel ) )
        {
            assertmsg( "<dev string:x27>" + guy.animname );
        }
    #/
    
    for ( i = 0; i < guy.scriptmodel.size ; i++ )
    {
        if ( isdefined( array[ "explosion" ] ) )
        {
            forward = anglestoforward( guy.scriptmodel[ i ].angles );
            forward *= 120;
            forward += guy.scriptmodel[ i ].origin;
            playfx( level._effect[ array[ "explosion" ] ], guy.scriptmodel[ i ].origin );
            radiusdamage( guy.scriptmodel[ i ].origin, 350, 700, 50 );
        }
        
        guy.scriptmodel[ i ] delete();
    }
}

// Namespace notetrack
// Params 2
// Checksum 0xdf2f1a5a, Offset: 0xfe8
// Size: 0x6a
function notetrack_effect( guy, scr_notetrack )
{
    var_8444edc1fad6b55e = isdefined( scr_notetrack[ "moreThanThreeHack" ] );
    
    if ( var_8444edc1fad6b55e )
    {
        utility::lock( "moreThanThreeHack" );
    }
    
    playfxontag( level._effect[ scr_notetrack[ "effect" ] ], guy, scr_notetrack[ "selftag" ] );
    
    if ( var_8444edc1fad6b55e )
    {
        utility::unlock( "moreThanThreeHack" );
    }
}

// Namespace notetrack
// Params 1
// Checksum 0x800a52c8, Offset: 0x105a
// Size: 0x17
function trace_part_for_efx_cancel( part )
{
    self notify( "cancel_trace_for_part_" + part );
}

// Namespace notetrack
// Params 4
// Checksum 0x88b7f299, Offset: 0x1079
// Size: 0x18e
function trace_part_for_efx( part, effect, water_effect, delete_depth )
{
    lock_string = "trace_part_for_efx";
    self endon( "cancel_trace_for_part_" + part );
    last_pos = self gettagorigin( part );
    hit_water = 0;
    struct = spawnstruct();
    struct.last_pos = self gettagorigin( part );
    struct.hit_surface = 0;
    struct.part = part;
    struct.hit_water = 0;
    struct.effect = effect;
    struct.stationary = 0;
    struct.last_motion_time = gettime();
    
    while ( isdefined( self ) && !struct.hit_surface )
    {
        utility::lock( lock_string );
        test_trace_tag( struct );
        utility::unlock_wait( lock_string );
        
        if ( struct.stationary == 1 && gettime() - struct.last_motion_time > 3000 )
        {
            return;
        }
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( water_effect ) && struct.hit_water )
    {
        effect = water_effect;
    }
    
    playfx( effect, struct.last_pos );
    
    if ( delete_depth == 0 )
    {
        self hidepart( part );
        return;
    }
    
    thread hidepartatdepth( struct.last_pos[ 2 ] - delete_depth, part );
}

// Namespace notetrack
// Params 2
// Checksum 0xaac1708d, Offset: 0x120f
// Size: 0x42
function hidepartatdepth( depth, part )
{
    self endon( #"entitydeleted" );
    
    while ( self gettagorigin( part )[ 2 ] > depth )
    {
        wait 0.05;
    }
    
    self hidepart( part );
}

// Namespace notetrack
// Params 1
// Checksum 0xdfb0d2d, Offset: 0x1259
// Size: 0x3a0
function test_trace_tag( struct )
{
    linecolor = undefined;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    struct.current_pos = self gettagorigin( struct.part );
    
    if ( struct.current_pos != struct.last_pos )
    {
        struct.last_motion_time = gettime();
        struct.stationary = 0;
        
        /#
            linecolor = ( 1, 1, 1 );
        #/
        
        if ( !trace::_bullet_trace_passed( struct.last_pos, struct.current_pos, 0, self ) )
        {
            trace = trace::_bullet_trace( struct.last_pos, struct.current_pos, 0, self );
            
            if ( trace[ "fraction" ] < 1 )
            {
                /#
                    linecolor = ( 1, 0, 0 );
                #/
                
                struct.last_pos = trace[ "position" ];
                struct.hit_water = trace[ "surfacetype" ] == "water";
                
                /#
                    if ( getdvarint( @"hash_b46df2b57cc019b" ) == 1 )
                    {
                        stringname = "<dev string:x77>";
                        
                        foreach ( key, value in level._effect )
                        {
                            if ( struct.effect != value )
                            {
                                continue;
                            }
                            
                            stringname = key;
                            break;
                        }
                        
                        print3d( _add_z( struct.last_pos, 6 ), "<dev string:x78>" + struct.part, ( 1, 1, 1 ), 1, 1, 100 );
                        print3d( struct.last_pos, "<dev string:x7e>" + stringname, ( 1, 1, 1 ), 1, 1, 100 );
                    }
                #/
                
                struct.hit_surface = 1;
                return;
            }
            else
            {
                /#
                    if ( getdvarint( @"hash_b46df2b57cc019b" ) == 1 )
                    {
                        if ( isdefined( trace[ "<dev string:x87>" ] ) )
                        {
                            print3d( _add_z( struct.last_pos, 6 ), "<dev string:x8e>" + trace[ "<dev string:x87>" ].classname, ( 0, 0, 1 ), 1, 1, 100 );
                        }
                    }
                #/
            }
        }
        
        /#
            if ( getdvarint( @"hash_b46df2b57cc019b" ) == 1 )
            {
                line( struct.last_pos, struct.current_pos, linecolor, 1, 0, 60 );
                sphere( struct.current_pos, 8, ( 0, 1, 0 ) );
                print3d( _add_z( struct.last_pos, 6 ), struct.part, ( 0, 1, 0 ), 1, 1, 1 );
            }
        #/
    }
    else
    {
        struct.stationary = 1;
        
        /#
            if ( getdvarint( @"hash_b46df2b57cc019b" ) == 1 )
            {
                print3d( struct.current_pos, "<dev string:x97>" + struct.part, ( 1, 0, 0 ) );
            }
        #/
    }
    
    struct.last_pos = struct.current_pos;
}

// Namespace notetrack
// Params 2
// Checksum 0x9629186d, Offset: 0x1601
// Size: 0x24
function _add_z( vec, zplus )
{
    return ( vec[ 0 ], vec[ 1 ], vec[ 2 ] + zplus );
}

// Namespace notetrack
// Params 3
// Checksum 0xea921443, Offset: 0x162e
// Size: 0x12c
function validatenotetracks( flagname, notes, animation )
{
    /#
        if ( isdefined( animation ) )
        {
            assert( notes.size <= 4, "<dev string:xa6>" + notes.size + "<dev string:xbc>" + getxhashsourcename( getanimname( animation ) ) );
        }
        else
        {
            assert( notes.size <= 4, "<dev string:xa6>" + notes.size + "<dev string:x103>" + flagname + "<dev string:x154>" );
        }
        
        for ( i = 0; i < notes.size ; i++ )
        {
            found = 0;
            
            for ( j = i + 1; j < notes.size ; j++ )
            {
                if ( notes[ i ] == notes[ j ] )
                {
                    found = 1;
                    
                    if ( isdefined( animation ) )
                    {
                        println( "<dev string:x156>" + getxhashsourcename( getanimname( animation ) ) + "<dev string:x16d>" + flagname + "<dev string:x17f>" + notes[ i ] + "<dev string:x1a2>" );
                    }
                    else
                    {
                        println( "<dev string:x1a4>" + flagname + "<dev string:x17f>" + notes[ i ] + "<dev string:x1a2>" );
                    }
                }
                
                if ( found )
                {
                    break;
                }
            }
        }
        
        notes = undefined;
    #/
}

// Namespace notetrack
// Params 1
// Checksum 0x5a299a44, Offset: 0x1762
// Size: 0x96
function printnotetracks( notes )
{
    /#
        if ( getdvarint( @"hash_a19781010239d2e6" ) != 1 && getdvarint( @"hash_a19781010239d2e6" ) != self getentitynumber() )
        {
            return;
        }
        
        msg = notes[ 0 ];
        
        for ( i = 1; i < notes.size ; i++ )
        {
            msg += "<dev string:x1c9>" + notes[ i ];
        }
        
        println( "<dev string:x1cc>" + gettime() + "<dev string:x1ce>" + self getentitynumber() + "<dev string:x1d1>" + msg );
    #/
}

// Namespace notetrack
// Params 2
// Checksum 0x50dda58f, Offset: 0x1800
// Size: 0x90
function animsound_start_tracker( anime, animname )
{
    add_to_animsound();
    newsound = spawnstruct();
    newsound.anime = anime;
    newsound.notetrack = "#" + anime;
    newsound.animname = animname;
    newsound.end_time = gettime() + 60000;
    
    if ( animsound_exists( anime, newsound.notetrack ) )
    {
        return;
    }
    
    add_animsound( newsound );
}

// Namespace notetrack
// Params 3
// Checksum 0x24b44f99, Offset: 0x1898
// Size: 0x9f
function animsound_start_tracker_loop( anime, loop, animname )
{
    add_to_animsound();
    anime = loop + anime;
    newsound = spawnstruct();
    newsound.anime = anime;
    newsound.notetrack = "#" + anime;
    newsound.animname = animname;
    newsound.end_time = gettime() + 60000;
    
    if ( animsound_exists( anime, newsound.notetrack ) )
    {
        return;
    }
    
    add_animsound( newsound );
}

// Namespace notetrack
// Params 3
// Checksum 0x13864a89, Offset: 0x193f
// Size: 0x9d
function animsound_tracker( anime, notetrack, animname )
{
    notetrack = tolower( notetrack );
    add_to_animsound();
    
    if ( notetrack == "end" )
    {
        return;
    }
    
    if ( animsound_exists( anime, notetrack ) )
    {
        return;
    }
    
    newtrack = spawnstruct();
    newtrack.anime = anime;
    newtrack.notetrack = notetrack;
    newtrack.animname = animname;
    newtrack.end_time = gettime() + 60000;
    add_animsound( newtrack );
}

// Namespace notetrack
// Params 2
// Checksum 0x27a5d91c, Offset: 0x19e4
// Size: 0xbe, Type: bool
function animsound_exists( anime, notetrack )
{
    notetrack = tolower( notetrack );
    keys = getarraykeys( self.animsounds );
    
    for ( i = 0; i < keys.size ; i++ )
    {
        key = keys[ i ];
        
        if ( self.animsounds[ key ].anime != anime )
        {
            continue;
        }
        
        if ( self.animsounds[ key ].notetrack != notetrack )
        {
            continue;
        }
        
        self.animsounds[ key ].end_time = gettime() + 60000;
        return true;
    }
    
    return false;
}

// Namespace notetrack
// Params 1
// Checksum 0x76d6954e, Offset: 0x1aab
// Size: 0xfa
function add_animsound( newsound )
{
    for ( i = 0; i < level.animsound_hudlimit ; i++ )
    {
        if ( isdefined( self.animsounds[ i ] ) )
        {
            continue;
        }
        
        self.animsounds[ i ] = newsound;
        return;
    }
    
    keys = getarraykeys( self.animsounds );
    index = keys[ 0 ];
    timer = self.animsounds[ index ].end_time;
    
    for ( i = 1; i < keys.size ; i++ )
    {
        key = keys[ i ];
        
        if ( self.animsounds[ key ].end_time < timer )
        {
            timer = self.animsounds[ key ].end_time;
            index = key;
        }
    }
    
    self.animsounds[ index ] = newsound;
}

// Namespace notetrack
// Params 0
// Checksum 0xeb03a0c1, Offset: 0x1bad
// Size: 0x7a
function add_to_animsound()
{
    if ( !isdefined( self.animsounds ) )
    {
        self.animsounds = [];
    }
    
    isinarray = 0;
    
    for ( i = 0; i < level.animsounds.size ; i++ )
    {
        if ( self == level.animsounds[ i ] )
        {
            isinarray = 1;
            break;
        }
    }
    
    if ( !isinarray )
    {
        level.animsounds[ level.animsounds.size ] = self;
    }
}

// Namespace notetrack
// Params 0
// Checksum 0x7289d6c4, Offset: 0x1c2f
// Size: 0xdc
function function_8046f9dfc11eaffe()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        vmnotetracks = [];
        self waittill( #"vm_sv_note", vmnotetracks );
        
        if ( vmnotetracks.size > 0 )
        {
            foreach ( notetrackinfo in vmnotetracks )
            {
                if ( notetrackinfo.size > 0 )
                {
                    notetrackname = notetrackinfo[ 1 ];
                    notetrackfunc = anim.notetracks[ notetrackname ];
                    
                    if ( isdefined( notetrackfunc ) )
                    {
                        [[ notetrackfunc ]]( notetrackname, undefined, notetrackinfo );
                    }
                }
            }
        }
    }
}

