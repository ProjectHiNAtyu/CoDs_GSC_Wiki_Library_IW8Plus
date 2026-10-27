// scripts\mp\maps\mp_sat_lm_avalon\mp_sat_lm_avalon_bridges.gsc  (hash_1bf28363845a6d52.gscc) (size: 3077 Bytes / 0xc05 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb376c39c (3010904988)
// size ...... 3077 (0xc05)
// includes .. 1   (offset: 0xbc1)
// strings ... 5   (offset: 0xbc9)
// dev strs .. 0   (offset: 0xc05)
// exports ... 5   (offset: 0x891)
// cseg ...... 0xe3 + 0x7ae (0x891)
// imports ... 20  (offset: 0x959)
// animtree1 . 0   (offset: 0xc05)
// animtree2 . 0   (offset: 0xc05)
#using scripts\common\utility;

#namespace mp_sat_lm_avalon_bridges;

// Namespace mp_sat_lm_avalon_bridges
// Params 0, eflags: 0x1
// Checksum 0xe647afb9, Offset: 0x101
// Size: 0x17
function autoexec _setup_bridges()
{
    level.draw_bridges = spawnstruct();
    level thread setup_bridges();
}

// Namespace mp_sat_lm_avalon_bridges
// Params 0
// Checksum 0x9c1a3313, Offset: 0x120
// Size: 0x417
function setup_bridges()
{
    level waittill( #"player_spawned" );
    level.draw_bridges.bridge_roots = getentarray( "drawbridge_root", #script_noteworthy );
    
    if ( !level.draw_bridges.bridge_roots.size )
    {
        return;
    }
    
    foreach ( bridge_root in level.draw_bridges.bridge_roots )
    {
        bridge_root setmoverantilagged( 1 );
        bridge_root setmoveroptimized( 1 );
        bridge_root.bridge_pieces = [];
        bridge_root.bridge_pieces = getentarray( bridge_root.targetname, #target );
        
        if ( !bridge_root.bridge_pieces.size )
        {
            return;
        }
        
        foreach ( bridge_piece in bridge_root.bridge_pieces )
        {
            if ( bridge_piece.script_label == bridge_root.script_label )
            {
                bridge_piece linkto( bridge_root );
                bridge_piece forcenetfieldhighlod( 1 );
                bridge_piece.moverdoesnotkill = 1;
                bridge_piece setmoverantilagged( 1 );
                bridge_piece setmoveroptimized( 1 );
                
                if ( bridge_piece.script_noteworthy == "bridge_clip_road" )
                {
                    bridge_root.clip_road = bridge_piece;
                    bridge_root.clip_road.var_1c2692052bde8ec1 = 1;
                    bridge_root.clip_road dockmovingplatform( undefined );
                    bridge_root.clip_road.docked = 1;
                    waitframe();
                }
                
                continue;
            }
            
            bridge_root.bridge_pieces = arrayremove( bridge_root.bridge_pieces, bridge_piece );
        }
        
        if ( bridge_root.angles[ 0 ] > -5 )
        {
            bridge_root.bridgedirection = #"down";
        }
        else
        {
            bridge_root.bridgedirection = #"up";
        }
        
        bridge_root.bridge_switches = getentitylessscriptablearray( bridge_root.targetname, #target );
        
        foreach ( bridge_switch in bridge_root.bridge_switches )
        {
            bridge_switch setscriptablepartstate( #"health_listener", #"disabled_no_notify" );
        }
        
        if ( utility::issharedfuncdefined( #"airdrop_scriptbundle", #"hash_8145eea3e9d095c" ) )
        {
            utility::callsharedfunc( #"airdrop_scriptbundle", #"hash_8145eea3e9d095c", bridge_root );
            
            foreach ( bridge_piece in bridge_root.bridge_pieces )
            {
                utility::callsharedfunc( #"airdrop_scriptbundle", #"hash_8145eea3e9d095c", bridge_piece );
            }
        }
        
        bridge_root thread function_b9a48dacecc9c657();
    }
    
    level utility::flag_set( "flag_bridge_setup_complete" );
}

// Namespace mp_sat_lm_avalon_bridges
// Params 0, eflags: 0x4
// Checksum 0x6afa3aaf, Offset: 0x53f
// Size: 0x99
function private function_b9a48dacecc9c657()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"activate", bridge_switch, e_user );
        
        if ( bridge_switch && self.bridge_in_action )
        {
            if ( bridge_switch getscriptablepartstate( #"arcwire_transmitter", undefined, 1 ) != #"blocked" )
            {
                bridge_switch setscriptablepartstate( #"arcwire_transmitter", #"blocked" );
            }
            
            continue;
        }
        
        _bridge_activate();
    }
}

// Namespace mp_sat_lm_avalon_bridges
// Params 0, eflags: 0x4
// Checksum 0xbc6798db, Offset: 0x5e0
// Size: 0x2b1
function private _bridge_activate()
{
    self endon( #"death" );
    
    foreach ( bridge_switch in self.bridge_switches )
    {
        bridge_switch setscriptablepartstate( #"arcwire_transmitter", #"activate" );
    }
    
    self.bridge_in_action = 1;
    
    if ( self.clip_road.docked )
    {
        self.clip_road undockmovingplatform( 0 );
        self.clip_road.docked = 0;
    }
    
    if ( self.bridgedirection == #"up" )
    {
        playsoundatpos( self.origin + ( 0, 0, 12 ), "emt_sat_avalon_drawbridge_lower" );
        
        while ( self.angles[ 0 ] <= 0 )
        {
            self.angles += ( 0.2, 0, 0 );
            waitframe();
        }
        
        self.bridgedirection = #"down";
    }
    else if ( self.bridgedirection == #"down" )
    {
        playsoundatpos( self.origin + ( 0, 0, 12 ), "emt_sat_avalon_drawbridge_raise" );
        self.var_fa9baa242f11c71 = self.angles;
        
        while ( self.angles[ 0 ] >= -25 )
        {
            self.angles += ( -0.2, 0, 0 );
            waitframe();
        }
        
        self.bridgedirection = #"up";
    }
    
    if ( !self.clip_road.docked )
    {
        self.clip_road dockmovingplatform( undefined );
        self.clip_road.docked = 1;
    }
    
    self.bridge_in_action = undefined;
    
    foreach ( bridge_switch in self.bridge_switches )
    {
        bridge_switch setscriptablepartstate( #"arcwire_transmitter", #"standby" );
    }
}

