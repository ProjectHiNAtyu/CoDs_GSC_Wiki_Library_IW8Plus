// scripts\mp\quickprompt.gsc  (hash_67605b5c43809ec1.gscc) (size: 5637 Bytes / 0x1605 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa1a95f1d (2712231709)
// size ...... 5637 (0x1605)
// includes .. 3   (offset: 0x15dd)
// strings ... 1   (offset: 0x15f5)
// dev strs .. 0   (offset: 0x1605)
// exports ... 25  (offset: 0xd0d)
// cseg ...... 0x73 + 0xc9a (0xd0d)
// imports ... 42  (offset: 0x10f5)
// animtree1 . 0   (offset: 0x1605)
// animtree2 . 0   (offset: 0x1605)
#using scripts\common\callbacks;
#using scripts\common\dev;
#using scripts\common\utility;

#namespace quickprompt;

// Namespace quickprompt
// Params 0, eflags: 0x5
// Checksum 0xe693633b, Offset: 0x91
// Size: 0x36
function private autoexec init()
{
    function_26f14061ae3ae15d();
    callback::add( #"player_laststand", &function_8353f9ce73d0b17b );
    
    /#
        thread dev::devcommandwatcher( @"hash_167d5f0e0436c3c4", &quickpromptdebug );
    #/
}

// Namespace quickprompt
// Params 0, eflags: 0x4
// Checksum 0xf6969166, Offset: 0xcf
// Size: 0x11c
function private function_26f14061ae3ae15d()
{
    if ( !isdefined( level.gamemodebundle.quickpromptlist ) )
    {
        return;
    }
    
    var_38eb13833b9988d0 = getscriptbundlefieldvalue( level.gamemodebundle.quickpromptlist, #"quickprompts" );
    
    if ( !isdefined( var_38eb13833b9988d0 ) || var_38eb13833b9988d0.size == 0 )
    {
        return;
    }
    
    if ( !isdefined( level.var_38eb13833b9988d0 ) )
    {
        level.var_38eb13833b9988d0 = [];
    }
    
    foreach ( index, prompt in var_38eb13833b9988d0 )
    {
        level.var_38eb13833b9988d0[ prompt.quickprompt ] = getscriptbundle( prompt.quickprompt );
        level.var_38eb13833b9988d0[ prompt.quickprompt ].index = index;
    }
}

// Namespace quickprompt
// Params 2, eflags: 0x4
// Checksum 0x62eefb1d, Offset: 0x1f3
// Size: 0x57
function private waitfornotify( waitobject, promptid )
{
    waitobject endon( #"end_wait" );
    result = undefined;
    
    while ( result != promptid )
    {
        self waittill( #"ok", result );
    }
    
    waitobject notify( #"end_wait", 1 );
}

// Namespace quickprompt
// Params 2, eflags: 0x4
// Checksum 0x78aba876, Offset: 0x252
// Size: 0x33
function private waitfortimeout( waitobject, timeout )
{
    waitobject endon( #"end_wait" );
    wait timeout;
    waitobject notify( #"end_wait", 0 );
}

// Namespace quickprompt
// Params 2, eflags: 0x4
// Checksum 0x74247554, Offset: 0x28d
// Size: 0x53
function private waitforconfirmation( promptid, timeout )
{
    waitobject = spawnstruct();
    childthread waitfornotify( waitobject, promptid );
    childthread waitfortimeout( waitobject, timeout );
    waitobject waittill( #"end_wait", var_7e8f0290e59def1b );
    return var_7e8f0290e59def1b;
}

// Namespace quickprompt
// Params 1, eflags: 0x4
// Checksum 0x52a9d098, Offset: 0x2e9
// Size: 0x53
function private playvoiceover( soundtype )
{
    assert( isplayer( self ) );
    
    if ( utility::issharedfuncdefined( #"sound", #"trysaylocalsound" ) )
    {
        level thread [[ utility::getsharedfunc( #"sound", #"trysaylocalsound" ) ]]( self, soundtype );
    }
}

// Namespace quickprompt
// Params 0, eflags: 0x4
// Checksum 0x6a28324, Offset: 0x344
// Size: 0x44
function private function_dd2e576ec7aa3108()
{
    if ( !isdefined( level.quickpromptnextid ) )
    {
        level.quickpromptnextid = 0;
    }
    
    promptid = level.quickpromptnextid;
    level.quickpromptnextid += 1;
    return promptid;
}

// Namespace quickprompt
// Params 0, eflags: 0x4
// Checksum 0x3f5c62dc, Offset: 0x391
// Size: 0x12
function private function_afa7b4cda009aaaf()
{
    return getdvarint( @"hash_923b34c4661bf18d", 500 );
}

// Namespace quickprompt
// Params 1, eflags: 0x4
// Checksum 0xbb55692b, Offset: 0x3ac
// Size: 0x38
function private getservertimeout( clienttimeout )
{
    var_293fea8bee0bf77 = 1000;
    var_cdc821802588755f = function_afa7b4cda009aaaf();
    return ( clienttimeout + var_293fea8bee0bf77 + var_cdc821802588755f ) / 1000;
}

// Namespace quickprompt
// Params 1
// Checksum 0xd337a21e, Offset: 0x3ed
// Size: 0x78
function function_811c31b8825a9d2b( timeout )
{
    defaulttimeout = 5000;
    
    if ( isdefined( timeout ) )
    {
        return ( timeout * 1000 );
    }
    
    resulttimeout = getdvarfloat( @"quickprompt_timeout", defaulttimeout );
    
    if ( level.gamemodebundle.quickprompttimeout && resulttimeout == defaulttimeout )
    {
        resulttimeout = level.gamemodebundle.quickprompttimeout;
    }
    
    return resulttimeout;
}

// Namespace quickprompt
// Params 1, eflags: 0x4
// Checksum 0x583be58c, Offset: 0x46e
// Size: 0x25
function private function_89180080bd809228( prompttype )
{
    if ( prompttype == 5 || prompttype == 6 )
    {
        return 0;
    }
    
    return 1;
}

// Namespace quickprompt
// Params 1, eflags: 0x4
// Checksum 0x63597226, Offset: 0x49b
// Size: 0x18, Type: bool
function private function_4b221754982b37a5( prompttype )
{
    if ( prompttype == 2 )
    {
        return true;
    }
    
    return false;
}

// Namespace quickprompt
// Params 1, eflags: 0x4
// Checksum 0x2dd8f3bb, Offset: 0x4bc
// Size: 0x1d
function private function_8353f9ce73d0b17b( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    quickpromptcancel();
}

// Namespace quickprompt
// Params 0
// Checksum 0xf1373b68, Offset: 0x4e1
// Size: 0x12, Type: bool
function function_b9b3aad14238043d()
{
    return istrue( getdvarint( @"hash_36c04ef69f54740d", 1 ) );
}

// Namespace quickprompt
// Params 0
// Checksum 0xa59fa993, Offset: 0x4fc
// Size: 0x12, Type: bool
function quickpromptisenabled()
{
    return istrue( getdvarint( @"quickprompt_enabled", 1 ) );
}

// Namespace quickprompt
// Params 0
// Checksum 0xbeedcc33, Offset: 0x517
// Size: 0x19, Type: bool
function function_106bde9d618791e9()
{
    assert( isplayer( self ) );
    return isdefined( self.quickprompt );
}

// Namespace quickprompt
// Params 1
// Checksum 0xb9ac64b0, Offset: 0x539
// Size: 0x48, Type: bool
function function_bb66d5fa916ff9d1( prompttype )
{
    assert( isplayer( self ) );
    prompttype = function_34974cec7d4d14eb( prompttype );
    
    if ( isdefined( self.quickprompt ) )
    {
        return ( self.quickprompt.type == prompttype );
    }
    
    return false;
}

// Namespace quickprompt
// Params 5
// Checksum 0xc73fa807, Offset: 0x58a
// Size: 0x334
function quickpromptshow( prompttype, timeout, callback, var_583bf49b2118746, lootid )
{
    assert( isplayer( self ) );
    
    if ( !quickpromptisenabled() || !prompttype )
    {
        return;
    }
    
    if ( callback::response( 1, #"hash_9a2e011b9a8406f0", {} ) )
    {
        return;
    }
    
    if ( isdefined( self.quickprompt ) && isdefined( self.quickprompt.allowoverride ) && !self.quickprompt.allowoverride )
    {
        return;
    }
    
    if ( !isxhashasset( prompttype ) && level.gamemodebundle.quickpromptlist )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    settings = function_cf3f7f2b697e78fe( prompttype );
    
    if ( !isdefined( timeout ) )
    {
        timeout = settings.timeout;
    }
    
    if ( !isdefined( lootid ) )
    {
        lootid = settings.lootid;
    }
    
    prompttype = function_34974cec7d4d14eb( prompttype );
    
    if ( lootid && hasomnvar( "ui_quick_prompt_loot_id" ) )
    {
        self setclientomnvar( "ui_quick_prompt_loot_id", lootid );
    }
    
    promptid = function_dd2e576ec7aa3108();
    prompttimeout = function_811c31b8825a9d2b( timeout );
    allowoverride = function_89180080bd809228( prompttype );
    var_4b221754982b37a5 = function_4b221754982b37a5( prompttype );
    function_84c95ccab46a031d( self, prompttype, promptid, int( prompttimeout ), var_4b221754982b37a5 );
    self.quickprompt = spawnstruct();
    self.quickprompt.allowoverride = allowoverride;
    self.quickprompt.callback = callback;
    self.quickprompt.type = prompttype;
    self.quickprompt.promptid = promptid;
    
    if ( settings.var_edf094f6f941163a && !getdvarint( @"hash_134714392f674bd9", 0 ) )
    {
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", settings.var_edf094f6f941163a, [ self ] );
    }
    
    servertimeout = getservertimeout( prompttimeout );
    var_7e8f0290e59def1b = waitforconfirmation( promptid, servertimeout );
    
    if ( var_7e8f0290e59def1b )
    {
        switch ( prompttype )
        {
            case 1:
            case 2:
            case 3:
            case 4:
                playvoiceover( #"hash_bc6037c23e669ee7" );
                break;
            default:
                break;
        }
    }
    
    if ( isdefined( self.quickprompt ) && isdefined( self.quickprompt.callback ) )
    {
        var_583bf49b2118746.lootid = lootid;
        self [[ self.quickprompt.callback ]]( { #var_583bf49b2118746:var_583bf49b2118746, #var_7e8f0290e59def1b:var_7e8f0290e59def1b } );
    }
    
    self.quickprompt = undefined;
}

// Namespace quickprompt
// Params 1
// Checksum 0xa9fc2081, Offset: 0x8c6
// Size: 0x5e
function quickpromptcancel( var_e30b7ce225aad904 )
{
    if ( isdefined( self.quickprompt ) )
    {
        if ( var_e30b7ce225aad904 && isdefined( self.quickprompt.callback ) )
        {
            self [[ self.quickprompt.callback ]]( 0 );
        }
        
        self.quickprompt = undefined;
        function_bb85f975008e7fc8( self );
    }
}

// Namespace quickprompt
// Params 6
// Checksum 0x3ae3b6c9, Offset: 0x92c
// Size: 0xc8
function function_661f2ac4b89488a1( prompttype, timeout, callback, var_583bf49b2118746, lootid, skipdelay )
{
    if ( !prompttype )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self notify( #"hash_8c043ecbb5c76f0a" );
    self endon( #"hash_8c043ecbb5c76f0a" );
    quickpromptcancel();
    
    if ( isdefined( self.quickprompt ) && level.gamemodebundle.quickpromptdelaytime && !skipdelay )
    {
        wait level.gamemodebundle.quickpromptdelaytime;
    }
    else
    {
        waitframe();
    }
    
    thread quickpromptshow( prompttype, timeout, callback, var_583bf49b2118746, lootid );
}

// Namespace quickprompt
// Params 1
// Checksum 0x91ef44c7, Offset: 0x9fc
// Size: 0x47
function function_34974cec7d4d14eb( prompttype )
{
    if ( !prompttype )
    {
        return;
    }
    
    if ( isdefined( level.var_38eb13833b9988d0[ prompttype ] ) && isxhashasset( prompttype ) )
    {
        prompttype = level.var_38eb13833b9988d0[ prompttype ].index;
    }
    
    return prompttype;
}

// Namespace quickprompt
// Params 1
// Checksum 0xf6f53e59, Offset: 0xa4c
// Size: 0x173
function function_cf3f7f2b697e78fe( prompttype )
{
    settings = {};
    
    if ( !isxhashasset( prompttype ) )
    {
        return settings;
    }
    
    if ( !level.var_38eb13833b9988d0 || !level.var_38eb13833b9988d0[ prompttype ] )
    {
        return settings;
    }
    
    settings = level.var_38eb13833b9988d0[ prompttype ];
    
    if ( !isdefined( settings.lootid ) && level.var_38eb13833b9988d0[ prompttype ].var_7f53c8afb35f0b22 && utility::issharedfuncdefined( #"game", #"hash_ca4103c28ac67fef" ) )
    {
        foreach ( entry in level.var_38eb13833b9988d0[ prompttype ].var_7f53c8afb35f0b22 )
        {
            if ( entry.var_456c58a9c2a7c979 )
            {
                ref = getscriptbundlefieldvalue( entry.var_456c58a9c2a7c979, #"ref" );
                settings.lootid = [[ utility::getsharedfunc( #"game", #"getlootidfromref" ) ]]( ref );
                break;
            }
        }
    }
    
    return settings;
}

// Namespace quickprompt
// Params 1
// Checksum 0xceac2a1, Offset: 0xbc8
// Size: 0x48, Type: bool
function function_7b73a63596c6effb( prompttype )
{
    if ( !prompttype || !self.quickprompt.type )
    {
        return false;
    }
    
    return function_34974cec7d4d14eb( prompttype ) == self.quickprompt.type;
}

/#

    // Namespace quickprompt
    // Params 2
    // Checksum 0xc8ec254, Offset: 0xc19
    // Size: 0xf4, Type: dev
    function quickpromptdebug( command, args )
    {
        switch ( command )
        {
            case #"hash_ca51c18a00a0a89c":
                if ( !isdefined( args[ 0 ] ) )
                {
                    break;
                }
                
                prompttype = int( args[ 0 ] );
                timeout = undefined;
                
                if ( isdefined( args[ 1 ] ) )
                {
                    timeout = int( args[ 1 ] );
                }
                
                foreach ( player in level.players )
                {
                    player thread quickpromptshow( prompttype, timeout );
                }
                
                break;
            default:
                break;
        }
    }

#/
