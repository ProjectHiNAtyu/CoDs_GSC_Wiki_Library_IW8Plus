// script_4a6364dec53eef6a  (hash_4a6364dec53eef6a.gscc) (size: 2536 Bytes / 0x9e8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5c43a315 (1547936533)
// size ...... 2536 (0x9e8)
// includes .. 4   (offset: 0x8e0)
// strings ... 17  (offset: 0x900)
// dev strs .. 0   (offset: 0x9e8)
// exports ... 9   (offset: 0x54c)
// cseg ...... 0x188 + 0x3c4 (0x54c)
// imports ... 18  (offset: 0x6b4)
// animtree1 . 0   (offset: 0x9e8)
// animtree2 . 0   (offset: 0x9e8)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\flags;
#using scripts\mp\stationary_notes;

#namespace br_sidequest_qwe_storyline;

// Namespace br_sidequest_qwe_storyline
// Params 0, eflags: 0x5
// Checksum 0x77eafe0c, Offset: 0x1a6
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"br_sidequest_qwe_storyline", #"br_interact_sidequest", &pre_main, undefined );
}

// Namespace br_sidequest_qwe_storyline
// Params 0
// Checksum 0x14962db3, Offset: 0x1cf
// Size: 0x68
function pre_main()
{
    utility::registersharedfunc( #"interact_sidequest", getxhash( "qwe_storyline" + "_on_infil" ), &on_infil );
    utility::registersharedfunc( #"interact_sidequest", getxhash( "qwe_storyline" ), &on_complete );
    utility::registersharedfunc( #"interact_sidequest", getxhash( "qwe_storyline" + "_on_disabled" ), &on_disabled );
}

// Namespace br_sidequest_qwe_storyline
// Params 0
// Checksum 0x38b5e599, Offset: 0x23f
// Size: 0x10
function on_disabled()
{
    thread disablestationarynotes();
    thread function_c597f0e0dec3819a();
}

// Namespace br_sidequest_qwe_storyline
// Params 0
// Checksum 0x1c52171a, Offset: 0x257
// Size: 0x9
function on_infil()
{
    thread on_infil_thread();
}

// Namespace br_sidequest_qwe_storyline
// Params 0
// Checksum 0x54841906, Offset: 0x268
// Size: 0xb9
function on_infil_thread()
{
    lockeddoors = getentitylessscriptablearray( "qwe_storyline_door", "script_noteworthy" );
    self.lockeddoors = lockeddoors;
    flags::function_2f3408423ccc9b2e( "qwe_storyline" + "_interactScriptables_spawned" );
    waitframe();
    
    foreach ( keypad in self.interactscriptables )
    {
        keypad setscriptablepartstate( "vfx", "off" );
    }
}

// Namespace br_sidequest_qwe_storyline
// Params 1
// Checksum 0x2b0e5f2b, Offset: 0x329
// Size: 0x119
function on_complete( player )
{
    if ( isdefined( self.lockeddoors ) )
    {
        foreach ( door in self.lockeddoors )
        {
            door setscriptablepartstate( "base", "opening" );
        }
    }
    
    foreach ( keypad in self.interactscriptables )
    {
        keypad setscriptablepartstate( "vfx", "on" );
    }
}

// Namespace br_sidequest_qwe_storyline
// Params 0
// Checksum 0xcdb1cec6, Offset: 0x44a
// Size: 0x4e
function disablestationarynotes()
{
    utility::flag_wait( "scriptables_ready" );
    notestruct = utility::getstruct( "sierra_sidequest_note_qwe_storyline_keycard", "targetname" );
    stationary_notes::function_a35cbe30981a01bb( notestruct );
    notestruct = utility::getstruct( "sierra_sidequest_note_qwe_storyline_room", "targetname" );
    stationary_notes::function_a35cbe30981a01bb( notestruct );
}

// Namespace br_sidequest_qwe_storyline
// Params 0
// Checksum 0x717988ce, Offset: 0x4a0
// Size: 0xac
function function_c597f0e0dec3819a()
{
    utility::flag_wait( "scriptables_ready" );
    caches = getentitylessscriptablearray( undefined, undefined, ( 28600, 126, -609 ), 220, "body" );
    
    foreach ( cache in caches )
    {
        cache setscriptablepartstate( "body", "hidden" );
    }
}

