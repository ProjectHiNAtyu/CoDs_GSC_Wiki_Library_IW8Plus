// script_33cd8a7250381109  (hash_33cd8a7250381109.gscc) (size: 3215 Bytes / 0xc8f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb3352a96 (3006605974)
// size ...... 3215 (0xc8f)
// includes .. 2   (offset: 0xbf7)
// strings ... 3   (offset: 0xc07)
// dev strs .. 6   (offset: 0xc47)
// exports ... 11  (offset: 0x833)
// cseg ...... 0x9c + 0x797 (0x833)
// imports ... 15  (offset: 0x9eb)
// animtree1 . 0   (offset: 0xc8f)
// animtree2 . 0   (offset: 0xc8f)
#using scripts\common\utility;
#using scripts\mp\hud_message;

#namespace namespace_ccc9a50b2d185e5;

// Namespace namespace_ccc9a50b2d185e5
// Params 0
// Checksum 0xfc62b4fc, Offset: 0xba
// Size: 0x14b
function function_2d60a8a96ff40a04()
{
    level.var_6ddf85e7b9d91d5a = getdvarint( @"hash_d66b1757d3104337", level.gametypebundle.var_82ed9ec5e897555b );
    level.var_230a580781a54b94 = getdvarint( @"hash_91d6d537e67d8471", level.gametypebundle.var_ba5d80ad61b9b5c );
    level.var_b2ca1f64a6378832 = getdvarint( @"hash_35c344d5617a8920", 0 );
    level.var_a1699a31b374fb6d = getdvarint( @"hash_da19834a28b5f3ef", level.gametypebundle.var_4933833080f33401 );
    level.var_a1468431b34e8353 = getdvarint( @"hash_d9f6714a288f84a1", level.gametypebundle.var_4956753081195cef );
    level.var_c8fc7ff374d4c141 = getdvarint( @"hash_57f2299c8c889830", level.gametypebundle.var_42e6a5d55222634d );
    level.var_c91f71f374faea2f = getdvarint( @"hash_57cf1f9c8c623a7a", level.gametypebundle.var_42c28fd551f9b833 );
    utility::registersharedfunc( #"gametype", #"onplayerentervehicle", &function_95e2e0bed125c242 );
    utility::registersharedfunc( #"gametype", #"hash_d4bfc76fc769af", &function_95e2e0bed125c242 );
}

// Namespace namespace_ccc9a50b2d185e5
// Params 0
// Checksum 0x10012ef4, Offset: 0x20d
// Size: 0x1b0, Type: bool
function function_89260e62e38ccc70()
{
    if ( getdvarint( @"hash_a7bd8df3c27a8390", 0 ) == 1 )
    {
        return true;
    }
    
    if ( !level.var_6ddf85e7b9d91d5a )
    {
        return false;
    }
    
    if ( !level.var_8cbc503650498bc7 )
    {
        var_ae5e80029110f0c4 = randomintrange( level.var_a1699a31b374fb6d, level.var_a1468431b34e8353 );
        level.var_8cbc503650498bc7 = gettime() + utility::function_4b74c15943231980( var_ae5e80029110f0c4 );
    }
    
    currenttime = gettime();
    
    if ( currenttime < level.var_8cbc503650498bc7 )
    {
        return false;
    }
    
    foreach ( var_318a88ee3a0b5e10 in level.var_85b177faa9935b2a.running )
    {
        foreach ( activity in var_318a88ee3a0b5e10 )
        {
            if ( activity.var_51f5a92414c2f4f8 )
            {
                /#
                    logstring( "<dev string:x24>" );
                #/
                
                return false;
            }
        }
    }
    
    /#
        logstring( "<dev string:x50>" + level.var_8cbc503650498bc7 + "<dev string:x84>" + currenttime + "<dev string:x90>" );
    #/
    
    return true;
}

// Namespace namespace_ccc9a50b2d185e5
// Params 0
// Checksum 0x51bd23b4, Offset: 0x3c6
// Size: 0x50
function function_d3531db6093ed727()
{
    randomcooldown = randomintrange( level.var_c8fc7ff374d4c141, level.var_c91f71f374faea2f );
    level.var_8cbc503650498bc7 = gettime() + utility::function_4b74c15943231980( randomcooldown );
    
    /#
        logstring( "<dev string:x92>" + randomcooldown + "<dev string:xb6>" );
    #/
}

// Namespace namespace_ccc9a50b2d185e5
// Params 2
// Checksum 0xf7133124, Offset: 0x41e
// Size: 0xae
function function_75e6074c25cd3167( player, trigger )
{
    if ( self.classname == "script_vehicle" )
    {
        foreach ( occupant in player.occupants )
        {
            function_bea4a383043f2244( occupant );
        }
        
        return;
    }
    
    function_bea4a383043f2244( player );
}

// Namespace namespace_ccc9a50b2d185e5
// Params 1, eflags: 0x4
// Checksum 0xb0f14f7a, Offset: 0x4d4
// Size: 0xac
function private function_bea4a383043f2244( player )
{
    player.var_bf516d5ed5a5050d = 1;
    
    if ( isplayer( player ) && !player.var_676a8a3ff688597c && !player.var_c17ff8f316ce1c39 )
    {
        player hud_message::function_78fedf6f526825f4( "skirmish_enter_heat_zone", level.gametypebundle.var_e662dd7f27d462eb );
        player.var_676a8a3ff688597c = 1;
        thread function_eb727702723d1f2c( player );
        player setclientomnvar( "ui_ctdm_buff_level", 4 );
        player thread function_b3d7ab4bb5f484cd();
        return;
    }
    
    if ( isplayer( player ) )
    {
        player setclientomnvar( "ui_ctdm_buff_level", 3 );
    }
}

// Namespace namespace_ccc9a50b2d185e5
// Params 2
// Checksum 0xd999e8a7, Offset: 0x588
// Size: 0xf2
function function_e6efed248e069b22( player, trigger )
{
    if ( player.classname == "script_vehicle" )
    {
        foreach ( occupant in player.occupants )
        {
            if ( occupant.var_c17ff8f316ce1c39 )
            {
                continue;
            }
            
            occupant.var_bf516d5ed5a5050d = 0;
            occupant setclientomnvar( "ui_ctdm_buff_level", 0 );
        }
        
        return;
    }
    
    if ( !player.var_c17ff8f316ce1c39 )
    {
        player.var_bf516d5ed5a5050d = 0;
        player setclientomnvar( "ui_ctdm_buff_level", 0 );
    }
}

// Namespace namespace_ccc9a50b2d185e5
// Params 1, eflags: 0x4
// Checksum 0x8eebe34e, Offset: 0x682
// Size: 0x47
function private function_eb727702723d1f2c( player )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    player endon( #"death" );
    wait 5;
    
    if ( player )
    {
        player.var_676a8a3ff688597c = 0;
    }
}

// Namespace namespace_ccc9a50b2d185e5
// Params 2, eflags: 0x4
// Checksum 0x6b817d79, Offset: 0x6d1
// Size: 0x1e
function private function_95e2e0bed125c242( vehicle, player )
{
    thread function_4d006984e722f6af( player );
}

// Namespace namespace_ccc9a50b2d185e5
// Params 1, eflags: 0x4
// Checksum 0xc00d7041, Offset: 0x6f7
// Size: 0x58
function private function_4d006984e722f6af( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player endon( #"death" );
    player.var_c17ff8f316ce1c39 = 1;
    wait 0.2;
    
    if ( player )
    {
        player.var_c17ff8f316ce1c39 = 0;
    }
}

// Namespace namespace_ccc9a50b2d185e5
// Params 0, eflags: 0x4
// Checksum 0x6b38339b, Offset: 0x757
// Size: 0xdc
function private function_b3d7ab4bb5f484cd()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    level endon( #"game_ended" );
    wait level.var_230a580781a54b94;
    
    if ( self.classname == "script_vehicle" )
    {
        foreach ( occupant in self.occupants )
        {
            occupant setclientomnvar( "ui_ctdm_buff_level", 3 );
        }
        
        return;
    }
    
    if ( self.var_bf516d5ed5a5050d )
    {
        self setclientomnvar( "ui_ctdm_buff_level", 3 );
    }
}

