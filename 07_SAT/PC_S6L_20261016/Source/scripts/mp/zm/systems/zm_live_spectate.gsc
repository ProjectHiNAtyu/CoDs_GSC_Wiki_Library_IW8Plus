// scripts\mp\zm\systems\zm_live_spectate.gsc  (hash_624f77d7a820da87.gscc) (size: 2758 Bytes / 0xac6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7508bcb0 (1963506864)
// size ...... 2758 (0xac6)
// includes .. 5   (offset: 0xa16)
// strings ... 5   (offset: 0xa3e)
// dev strs .. 5   (offset: 0xa8a)
// exports ... 10  (offset: 0x4fe)
// cseg ...... 0xb7 + 0x447 (0x4fe)
// imports ... 31  (offset: 0x68e)
// animtree1 . 0   (offset: 0xac6)
// animtree2 . 0   (offset: 0xac6)
#using scripts\common\devgui;
#using scripts\common\values;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;

#namespace zm_live_spectate;

/#

    // Namespace zm_live_spectate
    // Params 0
    // Checksum 0xd57113e2, Offset: 0xd5
    // Size: 0xd, Type: dev
    function function_fbde45a76358209f()
    {
        level thread function_a7b158e0d1eadded();
    }

#/

// Namespace zm_live_spectate
// Params 0
// Checksum 0x34ac8aa2, Offset: 0xea
// Size: 0xb0, Type: bool
function function_5647f60a40d71849()
{
    assert( isplayer( self ) );
    
    if ( self.sessionstate != "playing" )
    {
        return false;
    }
    
    self.game_extrainfo |= 8192;
    self setclientomnvar( "ui_live_spectating", 1 );
    player::updatesessionstate( "playing_but_spectating" );
    val::set( "live_spectator", "freezecontrols", 1 );
    self playerhide();
    self.live_spectator_data = { #last_weapon:self getcurrentweapon(), #exit_angles:self.angles, #var_cda33ecbacfadce1:self.origin };
    thread function_ba27f9651266040a();
    return true;
}

// Namespace zm_live_spectate
// Params 0, eflags: 0x4
// Checksum 0x3968273d, Offset: 0x1a3
// Size: 0x73
function private function_ba27f9651266040a()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_f4dbe727257d1899" );
    level thread game_utility::fadetoblackforplayerkeepui( self, 1, 0 );
    thread function_3a3af80cb6be411();
    
    while ( true )
    {
        self waittill( #"spectating_cycle_start", var_78c287b7f36f9491 );
        
        if ( isalive( var_78c287b7f36f9491 ) )
        {
            thread monitor_spectating_cycle( var_78c287b7f36f9491 );
            continue;
        }
        
        if ( !self getspectatingplayer() )
        {
            thread function_794d0c5793d9aed3();
        }
    }
}

// Namespace zm_live_spectate
// Params 0, eflags: 0x4
// Checksum 0x8769d964, Offset: 0x21e
// Size: 0x26
function private function_3a3af80cb6be411()
{
    self endon( #"death_or_disconnect" );
    self waittill( #"hash_f4dbe727257d1899" );
    level thread game_utility::fadetoblackforplayerkeepui( self, 0, 0 );
}

// Namespace zm_live_spectate
// Params 1, eflags: 0xc
// Checksum 0xa9c0ab62, Offset: 0x24c
// Size: 0x99
function private monitor_spectating_cycle( var_78c287b7f36f9491 )
{
    self notify( #"hash_40f5e21aaf013a5e" );
    self endon( #"hash_40f5e21aaf013a5e" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_f4dbe727257d1899" );
    var_78c287b7f36f9491 endon( #"death_or_disconnect" );
    self waittill( #"spectating_cycle" );
    
    if ( !self.live_spectator_data.spectate_client )
    {
        level thread game_utility::fadetoblackforplayerkeepui( self, 0, 0.25 );
    }
    
    self.live_spectator_data.spectate_client = var_78c287b7f36f9491;
    thread function_ce53dc56c1ce0d4c();
}

// Namespace zm_live_spectate
// Params 0, eflags: 0xc
// Checksum 0xd2b3aeca, Offset: 0x2ed
// Size: 0x74
function private function_ce53dc56c1ce0d4c()
{
    self notify( #"hash_8a028f98a4a0ddc8" );
    self endon( #"hash_8a028f98a4a0ddc8" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_f4dbe727257d1899" );
    self.live_spectator_data.spectate_client waittill( #"death_or_disconnect" );
    self.live_spectator_data.spectate_client = undefined;
    level thread game_utility::fadetoblackforplayerkeepui( self, 1, 1 );
}

// Namespace zm_live_spectate
// Params 0
// Checksum 0x22b0f48f, Offset: 0x369
// Size: 0xe6
function function_794d0c5793d9aed3()
{
    assert( isplayer( self ) );
    self notify( #"hash_f4dbe727257d1899" );
    
    if ( self.sessionstate != "playing_but_spectating" )
    {
        return;
    }
    
    if ( self isspectatinganyone() )
    {
        stopspectateplayer( self getentitynumber(), 1, 0 );
    }
    
    self.game_extrainfo &= ~8192;
    self setclientomnvar( "ui_live_spectating", 0 );
    player::updatesessionstate( "playing" );
    val::reset_all( "live_spectator" );
    self playershow();
    inventory_utility::forcevalidweapon( self.live_spectator_data.last_weapon );
    
    if ( self.live_spectator_data )
    {
        self setorigin( self.live_spectator_data.var_cda33ecbacfadce1 );
        self setplayerangles( self.live_spectator_data.exit_angles );
        self.live_spectator_data = undefined;
    }
}

/#

    // Namespace zm_live_spectate
    // Params 0, eflags: 0x4
    // Checksum 0xa4b61e49, Offset: 0x457
    // Size: 0x46, Type: dev
    function private function_a7b158e0d1eadded()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x38>", "<dev string:x3e>", &function_2f9a5ce4a324d87a, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x50>", "<dev string:x55>", &function_2f9a5ce4a324d87a, 0 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_live_spectate
    // Params 1, eflags: 0x4
    // Checksum 0x2cda1dd, Offset: 0x4a5
    // Size: 0x59, Type: dev
    function private function_2f9a5ce4a324d87a( params )
    {
        player = level.players[ 0 ];
        
        if ( !player )
        {
            return;
        }
        
        is_entering = istrue( int( params[ 0 ] ) );
        
        if ( is_entering )
        {
            player function_5647f60a40d71849();
            return;
        }
        
        player function_794d0c5793d9aed3();
    }

#/
