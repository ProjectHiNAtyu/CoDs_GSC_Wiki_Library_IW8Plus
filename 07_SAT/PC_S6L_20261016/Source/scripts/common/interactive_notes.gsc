// scripts\common\interactive_notes.gsc  (hash_213d03d2e07274e2.gscc) (size: 3808 Bytes / 0xee0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x90f81340 (2432176960)
// size ...... 3808 (0xee0)
// includes .. 5   (offset: 0xdc4)
// strings ... 8   (offset: 0xdec)
// dev strs .. 10  (offset: 0xe64)
// exports ... 14  (offset: 0x7f0)
// cseg ...... 0x105 + 0x6eb (0x7f0)
// imports ... 32  (offset: 0xa20)
// animtree1 . 0   (offset: 0xee0)
// animtree2 . 0   (offset: 0xee0)
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\scripted_widgets;
#using scripts\common\system;
#using scripts\common\utility;

#namespace interactive_notes;

// Namespace interactive_notes
// Params 0, eflags: 0x5
// Checksum 0x30588da1, Offset: 0x123
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"interactive_note", undefined, &init, undefined );
}

// Namespace interactive_notes
// Params 0, eflags: 0x4
// Checksum 0xdf43d7e9, Offset: 0x144
// Size: 0x3b
function private init()
{
    if ( !getdvar( @"hash_47192afdab9964dd", 1 ) )
    {
        return;
    }
    
    scriptable::scriptable_addusedcallbackbypart( "note_interaction", &function_4e290d29dbffab1b );
    level.interactive_notes = { #cooldowns:[] };
}

// Namespace interactive_notes
// Params 4
// Checksum 0xfce105cc, Offset: 0x187
// Size: 0x54
function create_note_data( ref, scriptable, variant, fields )
{
    return { #fields:fields, #variant:variant, #scriptable:scriptable, #ref:ref };
}

// Namespace interactive_notes
// Params 2
// Checksum 0x911fa9cb, Offset: 0x1e4
// Size: 0x4b
function open_note( note_data, note_origin )
{
    if ( player_is_on_cooldown() )
    {
        return;
    }
    
    level.interactive_notes.cooldown[ self getentitynumber() ] = gettime() + 1000;
    thread function_261d6427468274fd( note_data, note_origin );
}

// Namespace interactive_notes
// Params 2, eflags: 0x4
// Checksum 0x3c207252, Offset: 0x237
// Size: 0x1ab
function private function_261d6427468274fd( note_data, note_origin )
{
    self endon( #"disconnect" );
    
    if ( scripted_widgets::is_active( "interactive_note" ) )
    {
        close_note();
    }
    
    widget = scripted_widgets::function_8871b3ec93b79cd0( "scripted_widget_interactive_note", note_data.ref );
    
    if ( !widget )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x4a>" + "<dev string:x7c>" + "<dev string:x9d>" + note_data.ref );
        return;
    }
    
    position = note_data.position ?? { #vertical_anchor:1, #horizontal_anchor:1, #top:0, #left:0 };
    widget_struct = { #position:position, #param:note_data.variant };
    scripted_widgets::create( "interactive_note", widget, widget_struct, 1 );
    
    if ( !scripted_widgets::is_active( "interactive_note" ) )
    {
        return;
    }
    
    if ( note_data.fields )
    {
        scripted_widgets::function_dd7a63eea5bde0dc( "interactive_note", note_data.fields, 1 );
    }
    
    if ( note_origin )
    {
        thread function_3975a25a5a990478( note_origin );
    }
    
    utility::waittill_any_ents( self, "close_interactive_note", self, "death", self, "last_stand_enter", level, "game_ended" );
    params = { #player:self, #note_data:note_data };
    level callback::callback( #"hash_192d68b28556705b", params );
    scripted_widgets::destroy( "interactive_note" );
}

// Namespace interactive_notes
// Params 0
// Checksum 0xc9c64a41, Offset: 0x3ea
// Size: 0xe
function close_note()
{
    scripted_widgets::destroy( "interactive_note" );
}

// Namespace interactive_notes
// Params 3
// Checksum 0xfea20c2f, Offset: 0x400
// Size: 0xb6
function spawn_note( data, origin, angles )
{
    assert( data, "<dev string:x9f>" + "<dev string:xbd>" );
    assert( data.ref, "<dev string:x9f>" + "<dev string:xf1>" );
    
    if ( !isdefined( data.scriptable ) )
    {
        data.scriptable = "interactive_note_default";
    }
    
    note = spawnscriptable( data.scriptable, origin, angles );
    note.note_data = data;
    note.note_data.parent_scriptable = note;
    return note;
}

// Namespace interactive_notes
// Params 1
// Checksum 0xd5599801, Offset: 0x4bf
// Size: 0x9d
function function_b7cdebfdcdda364d( struct )
{
    note_data = { #variant:struct.variant ?? struct.script_string, #scriptable:struct.scriptable ?? struct.script_label, #ref:struct.ref ?? struct.script_noteworthy };
    return spawn_note( note_data, struct.origin, struct.angles );
}

// Namespace interactive_notes
// Params 1
// Checksum 0xa58c7370, Offset: 0x565
// Size: 0x90
function function_9f7caaa88c34fab2( struct_array )
{
    spawned_notes = [];
    
    foreach ( struct in struct_array )
    {
        spawned_notes[ spawned_notes.size ] = function_b7cdebfdcdda364d( struct );
    }
    
    return spawned_notes;
}

// Namespace interactive_notes
// Params 6, eflags: 0x4
// Checksum 0x993b87d0, Offset: 0x5fe
// Size: 0x9d
function private function_4e290d29dbffab1b( instance, part, state, player, bautouse, usestring )
{
    assert( instance.note_data, "<dev string:x124>" + "<dev string:x148>" + instance getscriptableindex() + "<dev string:x170>" );
    
    if ( player player_is_on_cooldown() )
    {
        return;
    }
    
    level.interactive_notes.cooldown[ player getentitynumber() ] = gettime() + 1000;
    player thread function_eb6cebe3853dec50( instance );
}

// Namespace interactive_notes
// Params 1, eflags: 0x4
// Checksum 0x6f609a1, Offset: 0x6a3
// Size: 0x86
function private function_eb6cebe3853dec50( instance )
{
    level endon( #"game_ended" );
    instance endon( #"death" );
    self endon( #"disconnect" );
    instance callback::callback( #"interactive_note_scriptable_used", { #player:self, #instance:instance } );
    instance disablescriptableplayeruse( self );
    function_261d6427468274fd( instance.note_data, instance.origin );
    instance enablescriptableplayeruse( self );
}

// Namespace interactive_notes
// Params 1, eflags: 0x4
// Checksum 0x78212b9d, Offset: 0x731
// Size: 0x83
function private function_3975a25a5a990478( note_origin )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"close_interactive_note" );
    distance_sqr = 40000;
    
    do
    {
        wait 0.5;
        
        if ( distance2dsquared( note_origin, self.origin ) > distance_sqr )
        {
            self notify( #"close_interactive_note" );
            wait 1;
        }
    }
    while ( scripted_widgets::is_active( "interactive_note" ) );
}

// Namespace interactive_notes
// Params 0, eflags: 0x4
// Checksum 0x83a476d1, Offset: 0x7bc
// Size: 0x33, Type: bool
function private player_is_on_cooldown()
{
    var_dc63e8ad4522b6f7 = level.interactive_notes.cooldown[ self getentitynumber() ] ?? -1;
    return gettime() < var_dc63e8ad4522b6f7;
}

