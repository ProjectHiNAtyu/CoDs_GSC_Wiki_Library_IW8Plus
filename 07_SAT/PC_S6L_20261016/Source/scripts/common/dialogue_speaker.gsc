// scripts\common\dialogue_speaker.gsc  (hash_3cc72a46f4854f82.gscc) (size: 3458 Bytes / 0xd82 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaa5cc037 (2858205239)
// size ...... 3458 (0xd82)
// includes .. 3   (offset: 0xcc2)
// strings ... 7   (offset: 0xcda)
// dev strs .. 2   (offset: 0xd6a)
// exports ... 14  (offset: 0x782)
// cseg ...... 0x123 + 0x65f (0x782)
// imports ... 26  (offset: 0x9b2)
// animtree1 . 0   (offset: 0xd82)
// animtree2 . 0   (offset: 0xd82)
#using scripts\common\scripted_widgets;
#using scripts\common\system;
#using scripts\common\utility;

#namespace dialogue_speaker;

// Namespace dialogue_speaker
// Params 0, eflags: 0x5
// Checksum 0xdcfbe0ad, Offset: 0x141
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"dialogue_speaker", undefined, undefined, &function_7d730f4c289e66fd );
}

// Namespace dialogue_speaker
// Params 0, eflags: 0x4
// Checksum 0x72192477, Offset: 0x162
// Size: 0xb9
function private function_7d730f4c289e66fd()
{
    level.dialogue_speaker_assets = [];
    dialogue_speakers = getscriptbundlenames( "dialoguespeaker" );
    test = [];
    
    if ( isdefined( dialogue_speakers ) )
    {
        dialogue_speaker_sorted_indices = tablesort( dialogue_speakers );
        
        foreach ( index, sorted_index in dialogue_speaker_sorted_indices )
        {
            level.dialogue_speaker_assets[ dialogue_speakers[ sorted_index ] ] = index;
        }
    }
}

// Namespace dialogue_speaker
// Params 1
// Checksum 0xc06f23db, Offset: 0x223
// Size: 0xa2
function add( asset_name )
{
    asset_name = check_asset( asset_name );
    level utility::flag_wait( "scripted_widgets_initialized" );
    
    foreach ( player in level.players )
    {
        if ( player )
        {
            player thread function_cae739e6055a5b15( asset_name );
        }
    }
}

// Namespace dialogue_speaker
// Params 1
// Checksum 0x46d4bc57, Offset: 0x2cd
// Size: 0x38
function add_for_player( asset_name )
{
    self endon( #"disconnect" );
    asset_name = check_asset( asset_name );
    level utility::flag_wait( "scripted_widgets_initialized" );
    thread function_cae739e6055a5b15( asset_name );
}

// Namespace dialogue_speaker
// Params 1
// Checksum 0xe5579566, Offset: 0x30d
// Size: 0x9a
function remove( var_8f504e21a91cd373 )
{
    if ( level utility::flag( "scripted_widgets_initialized" ) )
    {
        foreach ( player in level.players )
        {
            if ( player )
            {
                player remove_for_player( var_8f504e21a91cd373 );
            }
        }
    }
}

// Namespace dialogue_speaker
// Params 1
// Checksum 0x4c2286ab, Offset: 0x3af
// Size: 0x5a
function remove_for_player( var_8f504e21a91cd373 )
{
    if ( level utility::flag( "scripted_widgets_initialized" ) )
    {
        player = self;
        
        if ( !var_8f504e21a91cd373 || player.dialogue_speaker_asset == check_asset( var_8f504e21a91cd373 ) )
        {
            player.dialogue_speaker_asset = undefined;
            player thread function_f89cd2ec3f21c9cb();
        }
    }
}

// Namespace dialogue_speaker
// Params 0
// Checksum 0xf1bbc51, Offset: 0x411
// Size: 0x90
function add_streamer_hint()
{
    if ( level utility::flag( "scripted_widgets_initialized" ) )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player ) )
            {
                player function_5a819ae5d4855fc9();
            }
        }
    }
}

// Namespace dialogue_speaker
// Params 0
// Checksum 0xf2c27440, Offset: 0x4a9
// Size: 0x36
function function_5a819ae5d4855fc9()
{
    player = self;
    widget_asset = player scripted_widgets::function_652736891a41e948( "scripted_widget_dialogue_speaker" );
    player scripted_widgets::add_streamer_hint( "dialogue_speaker_streamer_hint", widget_asset );
}

// Namespace dialogue_speaker
// Params 0
// Checksum 0x6ae89859, Offset: 0x4e7
// Size: 0x90
function remove_streamer_hint()
{
    if ( level utility::flag( "scripted_widgets_initialized" ) )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player ) )
            {
                player function_720caf639e5c3038();
            }
        }
    }
}

// Namespace dialogue_speaker
// Params 0
// Checksum 0x99ead87a, Offset: 0x57f
// Size: 0x36
function function_720caf639e5c3038()
{
    player = self;
    widget_asset = player scripted_widgets::function_652736891a41e948( "scripted_widget_dialogue_speaker" );
    player scripted_widgets::remove_streamer_hint( "dialogue_speaker_streamer_hint", widget_asset );
}

// Namespace dialogue_speaker
// Params 0, eflags: 0xc
// Checksum 0xd902492b, Offset: 0x5bd
// Size: 0x78
function private function_f89cd2ec3f21c9cb()
{
    self notify( #"hash_111214ba64bba79c" );
    self endon( #"hash_111214ba64bba79c" );
    player = self;
    player endon( #"death_or_disconnect" );
    player endon( "scripted_widget_destroyed_" + "dialogue_speaker" );
    player endon( #"dialogue_speaker_added" );
    player scripted_widgets::set_state( "dialogue_speaker", #"hide" );
    wait 5;
    player scripted_widgets::destroy( "dialogue_speaker" );
}

// Namespace dialogue_speaker
// Params 1, eflags: 0xc
// Checksum 0xf8ab3b76, Offset: 0x63d
// Size: 0xe9
function private function_cae739e6055a5b15( asset_name )
{
    self notify( #"hash_b32ddbb9e5efde76" );
    self endon( #"hash_b32ddbb9e5efde76" );
    player = self;
    player.dialogue_speaker_asset = asset_name;
    player notify( #"dialogue_speaker_added" );
    
    if ( !player scripted_widgets::is_active( "dialogue_speaker" ) )
    {
        widget_asset = player scripted_widgets::function_652736891a41e948( "scripted_widget_dialogue_speaker" );
        player scripted_widgets::create( "dialogue_speaker", widget_asset );
        
        if ( !player scripted_widgets::is_active( "dialogue_speaker" ) )
        {
            return;
        }
        
        player notify( #"dialogue_speaker_added" );
    }
    
    fields = [];
    fields[ "dialogue_speaker_asset_index" ] = level.dialogue_speaker_assets[ asset_name ];
    player scripted_widgets::function_dd7a63eea5bde0dc( "dialogue_speaker", fields );
    player scripted_widgets::set_state( "dialogue_speaker", #"default" );
}

// Namespace dialogue_speaker
// Params 1, eflags: 0x4
// Checksum 0xdf380edd, Offset: 0x72e
// Size: 0x53
function private check_asset( asset_name )
{
    if ( !isxhashasset( asset_name ) )
    {
        asset_name = hashcat( %"hash_8c9a1917bb5c4a1", asset_name );
    }
    
    assert( isdefined( level.dialogue_speaker_assets[ asset_name ] ), "<dev string:x24>" + getxhashsourcename( asset_name ) + "<dev string:x50>" );
    return asset_name;
}

