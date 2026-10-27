// scripts\mp\stamina.gsc  (hash_4a1e368cf6485e85.gscc) (size: 2779 Bytes / 0xadb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4e15ec6 (81878726)
// size ...... 2779 (0xadb)
// includes .. 1   (offset: 0xa8f)
// strings ... 5   (offset: 0xa97)
// dev strs .. 0   (offset: 0xadb)
// exports ... 14  (offset: 0x5bf)
// cseg ...... 0xd7 + 0x4e8 (0x5bf)
// imports ... 23  (offset: 0x7ef)
// animtree1 . 0   (offset: 0xadb)
// animtree2 . 0   (offset: 0xadb)
#using scripts\common\callbacks;

#namespace stamina;

// Namespace stamina
// Params 0
// Checksum 0xf6945529, Offset: 0xf5
// Size: 0xe1
function init()
{
    level.gamemodebundle.staminaenabled = level.gamemodebundle.staminaenabled && !function_4042d2fbe6237835( #"hash_3d76532ba83c3ef6" );
    
    if ( !function_da3d7ff7d93437c0() )
    {
        return;
    }
    
    callback::add( #"player_spawned", &onplayerspawned );
    
    if ( isdefined( level.players ) )
    {
        foreach ( player in level.players )
        {
            player thread staminathink();
        }
    }
}

// Namespace stamina
// Params 0
// Checksum 0x59704c26, Offset: 0x1de
// Size: 0x69
function onweaponchange()
{
    if ( !function_da3d7ff7d93437c0() )
    {
        return;
    }
    
    if ( isdefined( self.perks[ "specialty_infinitestamina" ] ) )
    {
        function_bd1bc3ce73ea3e9a();
    }
    else
    {
        function_ce2b6b08ec01d2ec();
    }
    
    if ( isdefined( self.perks[ "specialty_loadout_fast" ] ) || isdefined( self.perks[ "specialty_loadout_veryfast" ] ) )
    {
        function_efae72d35b53f832();
        return;
    }
    
    function_70c1cad1d9d14544();
}

// Namespace stamina
// Params 0, eflags: 0x4
// Checksum 0xccbec037, Offset: 0x24f
// Size: 0x52
function private function_bd1bc3ce73ea3e9a()
{
    if ( !isdefined( self.stamina ) )
    {
        self.stamina = {};
    }
    
    if ( self.stamina.meterfadeout )
    {
        return;
    }
    
    self setclientomnvar( "ui_stamina_infinite", 1 );
    self.stamina.meterfadeout = 1;
}

// Namespace stamina
// Params 0, eflags: 0x4
// Checksum 0x875c00ba, Offset: 0x2a9
// Size: 0x39
function private function_ce2b6b08ec01d2ec()
{
    if ( !self.stamina.meterfadeout )
    {
        return;
    }
    
    self setclientomnvar( "ui_stamina_infinite", 0 );
    self.stamina.meterfadeout = undefined;
}

// Namespace stamina
// Params 0, eflags: 0x4
// Checksum 0xc9501834, Offset: 0x2ea
// Size: 0x3c
function private function_efae72d35b53f832()
{
    if ( self.stamina.var_577dcfe983f7faee )
    {
        return;
    }
    
    self setclientomnvar( "ui_stamina_high", 1 );
    self.stamina.var_577dcfe983f7faee = 1;
}

// Namespace stamina
// Params 0, eflags: 0x4
// Checksum 0x1a6b9d86, Offset: 0x32e
// Size: 0x39
function private function_70c1cad1d9d14544()
{
    if ( !self.stamina.var_577dcfe983f7faee )
    {
        return;
    }
    
    self setclientomnvar( "ui_stamina_high", 0 );
    self.stamina.var_577dcfe983f7faee = undefined;
}

// Namespace stamina
// Params 1, eflags: 0x4
// Checksum 0x37658282, Offset: 0x36f
// Size: 0x13
function private onplayerspawned( params )
{
    thread staminathink();
}

// Namespace stamina
// Params 0, eflags: 0x4
// Checksum 0xd718c246, Offset: 0x38a
// Size: 0x35
function private initplayer()
{
    if ( !isdefined( self.stamina ) )
    {
        self.stamina = {};
    }
    
    if ( self.stamina.staminafx )
    {
        function_89449c1c33ab049a();
    }
}

// Namespace stamina
// Params 0, eflags: 0x4
// Checksum 0xb27a87b2, Offset: 0x3c7
// Size: 0xae
function private staminathink()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    initplayer();
    staminafx = 0;
    didcallback = 0;
    
    while ( true )
    {
        sprintfrac = self getsprintmeterfraction();
        
        if ( didcallback )
        {
            didcallback = sprintfrac <= 0.1;
        }
        else if ( sprintfrac <= 0.1 )
        {
            callback::callback( #"no_stamina", {} );
            didcallback = 1;
        }
        
        if ( self issupersprinting() )
        {
            if ( !staminafx )
            {
                childthread function_ec12ee28842f7c5e();
                staminafx = 1;
            }
        }
        else if ( staminafx )
        {
            childthread function_89449c1c33ab049a();
            staminafx = 0;
        }
        
        waitframe();
    }
}

// Namespace stamina
// Params 0
// Checksum 0x4393707f, Offset: 0x47d
// Size: 0xb4
function function_ec12ee28842f7c5e()
{
    if ( !function_174a99892dc20502() )
    {
        return;
    }
    
    self endon( #"hash_cc58b033916abce" );
    self notify( #"hash_e300327a96aadc0" );
    var_44bcc52360c4a0f4 = 0;
    self.stamina.staminafx = 1;
    
    while ( true )
    {
        sprintfrac = self getsprintmeterfraction();
        
        if ( sprintfrac >= 0.75 && !var_44bcc52360c4a0f4 )
        {
            self modifybasefov( 66.7, 0.4, 0, 0.2 );
            var_44bcc52360c4a0f4 = 1;
        }
        else if ( sprintfrac < 0.75 && var_44bcc52360c4a0f4 )
        {
            self modifybasefov( 65, 1 );
            var_44bcc52360c4a0f4 = 0;
        }
        
        waitframe();
    }
}

// Namespace stamina
// Params 0
// Checksum 0x59d77e22, Offset: 0x539
// Size: 0x4f
function function_89449c1c33ab049a()
{
    if ( !function_174a99892dc20502() )
    {
        return;
    }
    
    self endon( #"hash_e300327a96aadc0" );
    self notify( #"hash_cc58b033916abce" );
    self.stamina.staminafx = undefined;
    self modifybasefov( 65, 0.5, 0.15, 0.35 );
}

// Namespace stamina
// Params 0, eflags: 0x4
// Checksum 0xa3acdeda, Offset: 0x590
// Size: 0x15
function private function_da3d7ff7d93437c0()
{
    return level.gamemodebundle.staminaenabled;
}

// Namespace stamina
// Params 0, eflags: 0x4
// Checksum 0xd3f0a4f6, Offset: 0x5ae
// Size: 0x10
function private function_174a99892dc20502()
{
    return getdvarint( @"scr_stamina_fx", 0 );
}

