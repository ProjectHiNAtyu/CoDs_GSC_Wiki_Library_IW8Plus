// scripts\mp\stationary_notes.gsc  (hash_304f476283f6d36e.gscc) (size: 8346 Bytes / 0x209a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x66b61af3 (1723210483)
// size ...... 8346 (0x209a)
// includes .. 7   (offset: 0x1f2a)
// strings ... 18  (offset: 0x1f62)
// dev strs .. 3   (offset: 0x2076)
// exports ... 29  (offset: 0x1356)
// cseg ...... 0x237 + 0x111f (0x1356)
// imports ... 64  (offset: 0x17de)
// animtree1 . 0   (offset: 0x209a)
// animtree2 . 0   (offset: 0x209a)
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\flags;

#namespace stationary_notes;

// Namespace stationary_notes
// Params 0, eflags: 0x5
// Checksum 0x7d362091, Offset: 0x255
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_6707069c88c25a2d", undefined, &snote_pre_main, undefined );
}

// Namespace stationary_notes
// Params 0, eflags: 0x4
// Checksum 0xd29a7be5, Offset: 0x276
// Size: 0x2a
function private snote_pre_main()
{
    level.snotes = { #spawnedscriptables:[], #var_468519311ceab380:[], #var_f15f69becfd47dd:[] };
}

// Namespace stationary_notes
// Params 0
// Checksum 0xef55d8a4, Offset: 0x2a8
// Size: 0x191
function snote_init()
{
    if ( getdvarint( @"scr_snote_system", 1 ) == 0 )
    {
        return;
    }
    
    utility::flag_init( "snote_init" );
    
    if ( utility::flag_exist( "create_script_initialized" ) )
    {
        utility::flag_wait( "create_script_initialized" );
    }
    
    wait 1;
    scriptable::scriptable_addusedcallbackbypart( "stationary_note", &snote_onuse );
    utility::registersharedfunc( #"stationary_note", #"hash_860b59eaf1145faf", &function_a00bdf6db2844306 );
    utility::registersharedfunc( #"stationary_note", #"hash_e640049ec08a4763", &function_300cd20324af67f4 );
    utility::registersharedfunc( #"stationary_note", #"hash_8ff3de17d5325e1a", &function_6635a3159203eb6b );
    utility::registersharedfunc( #"stationary_note", #"hash_b4b77c610a16479", &function_a4aafd00314826fc );
    function_ef53fa0bce20504e();
    snotelocs = utility::getstructarray( "stationary_note", "script_noteworthy" );
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    waitframe();
    
    foreach ( loc in snotelocs )
    {
        if ( !isdefined( loc.targetname ) )
        {
            continue;
        }
        
        function_1678b39fffacc68e( loc );
        function_d7be0460e18916b7( loc );
    }
    
    utility::flag_set( "snote_init" );
}

// Namespace stationary_notes
// Params 0, eflags: 0x4
// Checksum 0x443ac654, Offset: 0x441
// Size: 0x152
function private function_ef53fa0bce20504e()
{
    mapinfobundle = getactivemapinfobundle();
    
    if ( !isdefined( mapinfobundle.stationarynotelist ) )
    {
        return;
    }
    
    stationarynotes = getscriptbundlefieldvalue( mapinfobundle.stationarynotelist, #"stationarynotelist" );
    
    if ( !isdefined( stationarynotes ) || stationarynotes.size == 0 )
    {
        return;
    }
    
    if ( !isdefined( level.snotes.bundledata ) )
    {
        level.snotes.bundledata = [];
    }
    
    foreach ( index, note in stationarynotes )
    {
        if ( isdefined( note.stationarynotetype ) )
        {
            level.snotes.bundledata[ note.stationarynotetype ] = getscriptbundle( note.stationarynotetype );
            level.snotes.bundledata[ note.stationarynotetype ].index = index;
        }
    }
}

// Namespace stationary_notes
// Params 1
// Checksum 0x264fc4b5, Offset: 0x59b
// Size: 0x54, Type: bool
function function_1678b39fffacc68e( location )
{
    noteid = function_a00bdf6db2844306( location.targetname );
    
    if ( !isdefined( noteid ) || getdvarint( hashcat( @"hash_edfea81b4d377fe", noteid ) ) )
    {
        function_a35cbe30981a01bb( location );
        return false;
    }
    
    return true;
}

// Namespace stationary_notes
// Params 1
// Checksum 0x7a299419, Offset: 0x5f8
// Size: 0x1a
function function_a35cbe30981a01bb( location )
{
    location.nospawn = 1;
}

// Namespace stationary_notes
// Params 1
// Checksum 0xc122ed93, Offset: 0x61a
// Size: 0x137
function function_89899e6d44ef9b0( loc )
{
    if ( level.snotes.var_468519311ceab380[ loc.targetname ] )
    {
        return level.snotes.var_468519311ceab380[ loc.targetname ];
    }
    
    scriptable = function_dbd0f7557e0808a8( loc.targetname );
    
    if ( scriptable )
    {
        return scriptable;
    }
    
    if ( isdefined( loc.script_label ) )
    {
        switch ( loc.script_label )
        {
            case #"hash_2733f40fe0971ec8":
            case #"hash_7e9f9bd1b795e50f":
            case #"hash_b5afd08c3473356c":
                return loc.script_label;
        }
    }
    
    switch ( loc.targetname )
    {
        case #"hash_3eeac6c8aeddd4c9":
            return "stationary_note_computer";
    }
    
    if ( !isdefined( loc.model ) )
    {
        return "stationary_note_paper";
    }
    
    switch ( loc.model )
    {
        case #"hash_5dcc1e3a006a7e07":
            return "stationary_note_paper";
        default:
            return "stationary_note_paper";
    }
}

// Namespace stationary_notes
// Params 2
// Checksum 0xab3144d6, Offset: 0x759
// Size: 0x2d
function function_2862b36e46b40121( targetname, scriptableref )
{
    level.snotes.var_468519311ceab380[ targetname ] = scriptableref;
}

// Namespace stationary_notes
// Params 2
// Checksum 0x536ffb4f, Offset: 0x78e
// Size: 0x2d
function function_87d14bbfa2eabb88( key, noteref )
{
    level.snotes.var_f15f69becfd47dd[ key ] = noteref;
}

// Namespace stationary_notes
// Params 1
// Checksum 0xce035672, Offset: 0x7c3
// Size: 0xcc
function function_a00bdf6db2844306( noteref )
{
    if ( !isdefined( level.snotes.bundledata ) )
    {
        return;
    }
    
    hashref = getxhash( noteref );
    
    foreach ( note in level.snotes.bundledata )
    {
        if ( note.ref == hashref )
        {
            return note.id;
        }
    }
}

// Namespace stationary_notes
// Params 1
// Checksum 0x78b338df, Offset: 0x898
// Size: 0xcc
function function_dbd0f7557e0808a8( noteref )
{
    if ( !isdefined( level.snotes.bundledata ) )
    {
        return;
    }
    
    hashref = getxhash( noteref );
    
    foreach ( note in level.snotes.bundledata )
    {
        if ( note.ref == hashref )
        {
            return note.scriptable;
        }
    }
}

// Namespace stationary_notes
// Params 1
// Checksum 0x3daf3047, Offset: 0x96d
// Size: 0x148
function function_d7be0460e18916b7( loc )
{
    if ( loc.nospawn )
    {
        return;
    }
    
    noteref = loc.targetname;
    
    if ( isdefined( level.snotes.var_f15f69becfd47dd[ noteref ] ) )
    {
        noteref = level.snotes.var_f15f69becfd47dd[ noteref ];
    }
    
    scriptablename = function_89899e6d44ef9b0( loc );
    
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, 0, 0 );
    }
    
    noteid = function_a00bdf6db2844306( noteref );
    
    if ( isdefined( noteid ) )
    {
        scriptable = spawnscriptable( scriptablename, loc.origin, loc.angles + ( 90, 0, 0 ) );
        scriptable.noteid = noteid;
        
        if ( isdefined( loc.challenge ) )
        {
            scriptable.challenge = loc.challenge;
        }
        
        level.snotes.spawnedscriptables[ level.snotes.spawnedscriptables.size ] = scriptable;
    }
}

// Namespace stationary_notes
// Params 6
// Checksum 0x7126777f, Offset: 0xabd
// Size: 0x48
function snote_onuse( instance, part, state, player, bautouse, usestring )
{
    thread function_f4973cf88e4e6a01( instance, part, state, player, bautouse, usestring );
}

// Namespace stationary_notes
// Params 1
// Checksum 0x8e719d35, Offset: 0xb0d
// Size: 0x33
function function_a4aafd00314826fc( origin )
{
    note = function_47c86977a18df38b( level.snotes.spawnedscriptables, origin );
    return note;
}

// Namespace stationary_notes
// Params 6, eflags: 0x4
// Checksum 0xa8573ff9, Offset: 0xb49
// Size: 0x111
function private function_f4973cf88e4e6a01( instance, part, state, player, bautouse, usestring )
{
    level endon( #"game_ended" );
    instance endon( #"entitydeleted" );
    player endon( #"disconnect" );
    level callback::callback( #"stationary_note_read", { #player:player, #instance:instance } );
    level thread function_44d0cf0e7933a730( instance );
    
    if ( instance.type == "stationary_note_computer" )
    {
        challenges::function_37e945722d6497f3( player, "pmc_read_email", 1 );
    }
    
    challenges::function_37e945722d6497f3( player, instance.challenge, 1, 1 );
    function_6635a3159203eb6b( instance, player );
    waitframe();
    player setclientomnvar( "ui_immovable_note", instance.noteid );
    instance thread function_d2ff91002c7769b2( player );
    instance thread function_316f23bb0b9c5a83( player );
    waitframe();
    player setclientomnvar( "ui_immovable_note", 0 );
}

// Namespace stationary_notes
// Params 1, eflags: 0x4
// Checksum 0x99ff7cfa, Offset: 0xc62
// Size: 0xb4
function private function_d2ff91002c7769b2( player )
{
    level endon( #"game_ended" );
    self endon( #"entitydeleted" );
    player endon( #"disconnect" );
    player endon( #"note_closed" );
    self disablescriptableplayeruse( player );
    
    for ( ;; )
    {
        player waittill( #"luinotifyserver", message, value );
        
        if ( message == "exit_immovable_note" )
        {
            level callback::callback( #"stationary_note_closed", { #player:player, #instance:self } );
            self enablescriptableplayeruse( player );
            player notify( #"note_closed" );
        }
    }
}

// Namespace stationary_notes
// Params 1, eflags: 0x4
// Checksum 0x67cb270d, Offset: 0xd1e
// Size: 0x7e
function private function_316f23bb0b9c5a83( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"note_closed" );
    position = self.origin;
    
    for ( ;; )
    {
        if ( !isdefined( self ) || distance2dsquared( position, player.origin ) >= 15625 )
        {
            player setclientomnvar( "ui_immovable_note", -1 );
            return;
        }
        
        wait 0.1;
    }
}

// Namespace stationary_notes
// Params 1, eflags: 0x4
// Checksum 0x68d5a3ee, Offset: 0xda4
// Size: 0xbb
function private function_44d0cf0e7933a730( instance )
{
    position = ( 0, 0, 0 );
    
    if ( isdefined( instance ) && isdefined( instance.origin ) )
    {
        position = instance.origin;
    }
    
    eventparams = [ "pos_x", position[ 0 ], "pos_y", position[ 1 ], "pos_z", position[ 2 ], "time_since_match_start_ms", game_utility::gettimepassed(), "id", instance.noteid ];
    dlog_recordevent( "dlog_event_br_snote_used", eventparams );
}

// Namespace stationary_notes
// Params 2, eflags: 0x4
// Checksum 0xd581b658, Offset: 0xe67
// Size: 0x82
function private function_300cd20324af67f4( origin, number_input )
{
    if ( !( isdefined( origin ) && isdefined( level.snotes.spawnedscriptables ) ) )
    {
        /#
            logprint( "<dev string:x24>" + origin );
        #/
        
        return;
    }
    
    snote = function_47c86977a18df38b( level.snotes.spawnedscriptables, origin, 256 );
    
    if ( !isdefined( snote ) )
    {
        return;
    }
    
    snote.number_input = number_input;
}

// Namespace stationary_notes
// Params 2, eflags: 0x4
// Checksum 0x9a0f9a7a, Offset: 0xef1
// Size: 0x165
function private function_6635a3159203eb6b( var_d497cdb3c911937e, player )
{
    instance = var_d497cdb3c911937e;
    
    if ( isvector( var_d497cdb3c911937e ) )
    {
        instance = function_47c86977a18df38b( level.snotes.spawnedscriptables, var_d497cdb3c911937e, 256 );
    }
    
    if ( isdefined( instance.number_input ) )
    {
        if ( player function_5c766d1d0140b86( "ui_note_num_input" ) )
        {
            numlength = 0;
            code = 0;
            var_882400b3c3db879b = 0;
            
            if ( isarray( instance.number_input ) )
            {
                numlength = instance.number_input.size;
                code = "";
                
                for ( i = 0; i < instance.number_input.size ; i++ )
                {
                    code += instance.number_input[ i ];
                }
                
                code = int( code );
            }
            else if ( isint( instance.number_input ) )
            {
                tempstring = string( instance.number_input );
                numlength = tempstring.size;
                code = instance.number_input;
            }
            
            player function_48827064235eb1cc( numlength );
            player function_20f1805e9e28a79a( code );
        }
        
        return;
    }
    
    if ( player function_5c766d1d0140b86( "ui_note_num_input" ) )
    {
        player function_48827064235eb1cc( 0 );
        player function_20f1805e9e28a79a( 0 );
    }
}

// Namespace stationary_notes
// Params 0
// Checksum 0xd6600e1a, Offset: 0x105e
// Size: 0x10
function function_c45a81c206cafbee()
{
    return playerunpackdatafromomnvar( "ui_note_num_input", 0, 4 );
}

// Namespace stationary_notes
// Params 0
// Checksum 0x39e188d5, Offset: 0x1077
// Size: 0x11
function function_3456c512ef6d7ae4()
{
    return playerunpackdatafromomnvar( "ui_note_num_input", 4, 27 );
}

// Namespace stationary_notes
// Params 1
// Checksum 0xbaa17ec1, Offset: 0x1091
// Size: 0x16
function function_48827064235eb1cc( lengthindex )
{
    function_2790b22c4ec63081( 0, lengthindex );
}

// Namespace stationary_notes
// Params 1
// Checksum 0xca66293a, Offset: 0x10af
// Size: 0x17
function function_20f1805e9e28a79a( digitsindex )
{
    function_2790b22c4ec63081( 1, digitsindex );
}

// Namespace stationary_notes
// Params 2
// Checksum 0x1e55b1c0, Offset: 0x10ce
// Size: 0x80
function function_2790b22c4ec63081( dataref, value )
{
    assert( isplayer( self ) );
    [ bitoffset, bitwidth, var_48646764f8a928fa, value ] = function_f68229fcaae10ba8( dataref, value );
    
    if ( var_48646764f8a928fa == "" )
    {
        return;
    }
    
    playerpackdataintoomnvar( var_48646764f8a928fa, value, bitoffset, bitwidth );
}

// Namespace stationary_notes
// Params 2
// Checksum 0x8c42ae2c, Offset: 0x1156
// Size: 0xf5
function function_f68229fcaae10ba8( dataref, value )
{
    bitoffset = 0;
    bitwidth = 0;
    var_48646764f8a928fa = "";
    
    switch ( dataref )
    {
        case 0:
            [ bitoffset, bitwidth ] = [ 0, 4 ];
            var_48646764f8a928fa = "ui_note_num_input";
            break;
        case 1:
            [ bitoffset, bitwidth ] = [ 4, 27 ];
            var_48646764f8a928fa = "ui_note_num_input";
            break;
        default:
            assertmsg( "<dev string:x64>" + dataref + "<dev string:x73>" );
            break;
    }
    
    return [ bitoffset, bitwidth, var_48646764f8a928fa, value ];
}

// Namespace stationary_notes
// Params 4
// Checksum 0xaf7c9269, Offset: 0x1254
// Size: 0x98
function playerpackdataintoomnvar( var_48646764f8a928fa, value, bitoffset, bitwidth )
{
    mask = ( 1 << bitwidth ) - 1;
    shiftedvalue = ( value & mask ) << bitoffset;
    invertedmask = ~( mask << bitoffset );
    prevvalue = self getclientomnvar( var_48646764f8a928fa );
    cleanedbase = prevvalue & invertedmask;
    repackedvalue = cleanedbase | shiftedvalue;
    
    if ( repackedvalue != prevvalue )
    {
        self setclientomnvar( var_48646764f8a928fa, repackedvalue );
    }
}

// Namespace stationary_notes
// Params 3
// Checksum 0x353dd69c, Offset: 0x12f4
// Size: 0x61
function playerunpackdatafromomnvar( var_48646764f8a928fa, var_8e0a517bef5fb5a9, var_53c51112e5802e4 )
{
    prevvalue = self getclientomnvar( var_48646764f8a928fa );
    var_cea83b4cc1899b3b = ( 1 << var_53c51112e5802e4 ) - 1;
    bitarray = prevvalue >> var_8e0a517bef5fb5a9;
    extractedvalue = var_cea83b4cc1899b3b & bitarray;
    return extractedvalue;
}

