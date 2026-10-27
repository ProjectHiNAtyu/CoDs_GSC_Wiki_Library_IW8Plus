// scripts\mp\zm\systems\zm_afk_check.gsc  (hash_30fcac5a4265cc8c.gscc) (size: 3494 Bytes / 0xda6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe7e2ad22 (3890392354)
// size ...... 3494 (0xda6)
// includes .. 6   (offset: 0xcd2)
// strings ... 11  (offset: 0xd02)
// dev strs .. 2   (offset: 0xd8e)
// exports ... 10  (offset: 0x756)
// cseg ...... 0xf5 + 0x661 (0x756)
// imports ... 34  (offset: 0x8e6)
// animtree1 . 0   (offset: 0xda6)
// animtree2 . 0   (offset: 0xda6)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\hud_message;
#using scripts\mp\zm\zm_player;

#namespace zm_afk_check;

// Namespace zm_afk_check
// Params 0, eflags: 0x5
// Checksum 0xecd22845, Offset: 0x113
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_afk_check", undefined, undefined, &init );
}

// Namespace zm_afk_check
// Params 0
// Checksum 0x441aef20, Offset: 0x134
// Size: 0x4c
function init()
{
    level callback::add( #"on_ai_killed", &on_zombie_killed );
    level callback::add( #"hash_57a74c8771bf7e7", &callback_ignore_afk );
    utility::registersharedfunc( #"zm_afk_check", #"afk_timer", &function_596f84457d061cb8 );
}

// Namespace zm_afk_check
// Params 0
// Checksum 0x65c9337, Offset: 0x188
// Size: 0x2be
function function_596f84457d061cb8()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"quit_afk" );
    self.var_bfa8f8754293e4e4 = 0;
    thread handle_quit_afk();
    
    while ( true )
    {
        wait 1;
        
        if ( callback_ignore_afk() )
        {
            continue;
        }
        else
        {
            self.var_bfa8f8754293e4e4++;
        }
        
        /#
            iprintlnbold( self.name + "<dev string:x24>" + self.var_bfa8f8754293e4e4 + "<dev string:x34>" );
        #/
        
        var_b413c58f18506d6c = getdvarfloat( @"hash_981c3a80d1b38618", 135 );
        var_c4c151ea3191ab6e = getdvarfloat( @"hash_9b021a914d34e114", 750 );
        var_abdd0f7620bd9b46 = getdvarfloat( @"hash_4eeeea0f0f54b8c7", 60 );
        var_60085a92aaf76d1d = getdvarfloat( @"hash_ecbfaa1eb7fc1336", 180 );
        var_57101dc0e2ff9e26 = self.var_bfa8f8754293e4e4;
        
        if ( self issplitscreenplayer() )
        {
            var_1f0d6d55fe7c62ec = self getothersplitscreenplayer();
            var_a2941534a1b2d61f = var_1f0d6d55fe7c62ec.var_bfa8f8754293e4e4 ?? 0;
            var_57101dc0e2ff9e26 = min( var_57101dc0e2ff9e26, var_a2941534a1b2d61f );
        }
        
        if ( !self.var_e9aae5c3052b7ddc && var_57101dc0e2ff9e26 > var_b413c58f18506d6c )
        {
            self.var_e9aae5c3052b7ddc = 1;
            self setclientomnvar( "ui_afk_warning", 1 );
        }
        
        if ( self.var_bfa8f8754293e4e4 > var_60085a92aaf76d1d )
        {
            var_3dbb192a7d6a1736 = 0;
            
            if ( level.players.size > 1 && self.var_bfa8f8754293e4e4 < var_c4c151ea3191ab6e )
            {
                foreach ( player in level.players )
                {
                    if ( !isdefined( player.var_bfa8f8754293e4e4 ) || player.var_bfa8f8754293e4e4 < var_60085a92aaf76d1d )
                    {
                        var_3dbb192a7d6a1736 = 1;
                        break;
                    }
                }
            }
            
            if ( self issplitscreenplayer() )
            {
                var_1f0d6d55fe7c62ec = self getothersplitscreenplayer();
                is_other_player_afk = ( var_1f0d6d55fe7c62ec.var_bfa8f8754293e4e4 ?? 0 ) > var_60085a92aaf76d1d;
                
                if ( !is_other_player_afk )
                {
                    var_3dbb192a7d6a1736 = 1;
                }
            }
            
            if ( var_3dbb192a7d6a1736 )
            {
                continue;
            }
            
            thread function_34130406909ae325();
            return;
        }
        
        if ( self.var_bfa8f8754293e4e4 > var_abdd0f7620bd9b46 )
        {
            self.timeplayed[ "total" ]--;
            
            if ( !self.b_disable_xp )
            {
                self.b_disable_xp = 1;
            }
        }
    }
}

// Namespace zm_afk_check
// Params 0, eflags: 0x4
// Checksum 0x3f348515, Offset: 0x44e
// Size: 0x6d
function private function_34130406909ae325()
{
    self endon( #"disconnect" );
    self setclientdvar( @"ui_opensummary", 1 );
    self setclientomnvar( "post_game_state", 5 );
    thread hud_message::teamoutcomenotify( self.team, 0, game[ "end_reason" ][ "inactive" ] );
    wait 5;
    
    if ( isdefined( self ) )
    {
        function_fdd9a71f819fd6d6( self );
        kick( self getentitynumber(), &"EXE/PLAYERKICKED_INACTIVE" );
    }
}

// Namespace zm_afk_check
// Params 1
// Checksum 0x3a134244, Offset: 0x4c3
// Size: 0xf1, Type: bool
function callback_ignore_afk( params )
{
    if ( !isplayer( self ) )
    {
        return true;
    }
    
    if ( !utility::flag( "begin_round_logic" ) && level.gametypebundle.zmroundbased )
    {
        return true;
    }
    
    if ( self isplayingxcam() || utility::ent_flag( "scene_active" ) )
    {
        return true;
    }
    
    if ( self.inlaststand )
    {
        if ( level.var_3acde862d09b75da )
        {
            utility::callsharedfunc( #"player", #"hash_2becc11335863433" );
        }
        
        return true;
    }
    
    if ( utility::isusingremote() )
    {
        if ( level.var_32b698a4c113bd8 )
        {
            utility::callsharedfunc( #"player", #"hash_2becc11335863433" );
        }
        
        return true;
    }
    
    if ( val::get( "ignore_afk" ) )
    {
        return true;
    }
    
    if ( !isalive( self ) || self.sessionstate == "spectator" )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_afk_check
// Params 1
// Checksum 0xf7673af8, Offset: 0x5bd
// Size: 0x8e
function on_zombie_killed( params )
{
    if ( isplayer( params.eattacker ) )
    {
        if ( !params.eattacker.var_c535e46596d008da )
        {
            params.eattacker.var_c535e46596d008da = 1;
            params.eattacker thread function_3831c5c0ccbe13be();
        }
        
        params.eattacker.var_952d105ca1c0d4fe = 0;
        params.eattacker notify( #"quit_afk" );
    }
}

// Namespace zm_afk_check
// Params 0
// Checksum 0xe66ccb51, Offset: 0x653
// Size: 0x33
function function_3831c5c0ccbe13be()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"disconnect" );
    wait 60;
    self.var_c535e46596d008da = 0;
}

// Namespace zm_afk_check
// Params 0
// Checksum 0xe0efc0ed, Offset: 0x68e
// Size: 0x96
function handle_quit_afk()
{
    self endon( #"disconnect" );
    utility::waittill_any( "death", "quit_afk" );
    self.b_disable_xp = undefined;
    self.var_bfa8f8754293e4e4 = undefined;
    
    if ( self.var_e9aae5c3052b7ddc )
    {
        self.var_e9aae5c3052b7ddc = 0;
        self setclientomnvar( "ui_afk_warning", 0 );
    }
    
    if ( self issplitscreenplayer() )
    {
        var_1f0d6d55fe7c62ec = self getothersplitscreenplayer();
        
        if ( var_1f0d6d55fe7c62ec.var_e9aae5c3052b7ddc )
        {
            var_1f0d6d55fe7c62ec.var_e9aae5c3052b7ddc = 0;
            var_1f0d6d55fe7c62ec setclientomnvar( "ui_afk_warning", 0 );
        }
    }
}

// Namespace zm_afk_check
// Params 1, eflags: 0x4
// Checksum 0xd0a641d4, Offset: 0x72c
// Size: 0x2a
function private function_fdd9a71f819fd6d6( player )
{
    if ( getdvarint( @"hash_ea3a7654c4104f28", 1 ) <= 0 )
    {
        return;
    }
    
    zm_player::save_player_loadout( player );
}

