// scripts\mp\common\perks\carepackage_boobytrap.gsc  (hash_3248423a626adca0.gscc) (size: 2169 Bytes / 0x879 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1b5154c3 (458314947)
// size ...... 2169 (0x879)
// includes .. 2   (offset: 0x85d)
// strings ... 1   (offset: 0x86d)
// dev strs .. 0   (offset: 0x879)
// exports ... 7   (offset: 0x525)
// cseg ...... 0x7b + 0x4aa (0x525)
// imports ... 18  (offset: 0x63d)
// animtree1 . 0   (offset: 0x879)
// animtree2 . 0   (offset: 0x879)
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace carepackage_boobytrap;

// Namespace carepackage_boobytrap
// Params 0, eflags: 0x1
// Checksum 0x8c878092, Offset: 0x99
// Size: 0x98
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_34292592f6ad91a4 );
    
    if ( !isdefined( level.sharedfuncs[ #"blackhat" ][ #"boobytrapcrate" ] ) )
    {
        utility::registersharedfunc( #"blackhat", #"boobytrapcrate", &boobytrapcrate );
    }
    
    if ( !isdefined( level.sharedfuncs[ #"blackhat" ][ #"hash_3b864e571f199211" ] ) )
    {
        utility::registersharedfunc( #"blackhat", #"hash_3b864e571f199211", &function_e84326d26a4a2488 );
    }
}

// Namespace carepackage_boobytrap
// Params 1
// Checksum 0x96392e0, Offset: 0x139
// Size: 0x37
function function_34292592f6ad91a4( params )
{
    if ( isfunction( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_carepackage_boobytrap", &function_a2c76cb8c48ece7d );
    }
}

// Namespace carepackage_boobytrap
// Params 0
// Checksum 0x9928fe8a, Offset: 0x178
// Size: 0x94
function function_a2c76cb8c48ece7d()
{
    /#
        setdvarifuninitialized( @"hash_a0537dfed15cb647", 0 );
    #/
    
    if ( !isdefined( level.sharedfuncs[ #"perk" ][ #"boobytrapcrate" ] ) )
    {
        utility::registersharedfunc( #"perk", #"boobytrapcrate", &boobytrapcrate );
    }
    
    if ( !isdefined( level.sharedfuncs[ #"perk" ][ #"hash_3b864e571f199211" ] ) )
    {
        utility::registersharedfunc( #"perk", #"hash_3b864e571f199211", &function_e84326d26a4a2488 );
    }
}

// Namespace carepackage_boobytrap
// Params 1
// Checksum 0x39a5fa62, Offset: 0x214
// Size: 0x1e1
function boobytrapcrate( var_d36594454b12f04f )
{
    self.var_bb6b1a90c3f77d0 = var_d36594454b12f04f;
    trapperteam = undefined;
    
    if ( isplayer( var_d36594454b12f04f ) )
    {
        self setentityowner( var_d36594454b12f04f );
        trapperteam = var_d36594454b12f04f.team;
    }
    
    if ( self.useteammodels )
    {
        foreach ( player in level.players )
        {
            if ( player.team == trapperteam )
            {
                self.var_88accb953478a622 hidefromplayer( player );
                self.var_36e300d147bf6f25 showtoplayer( player );
            }
        }
    }
    
    self setscriptablepartstate( #"boobytrap", #"armed" );
    
    if ( isdefined( trapperteam ) )
    {
        var_2ad199a3a6ea8bd1 = isdefined( self.useobject );
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !isdefined( player.team ) )
            {
                continue;
            }
            
            if ( trapperteam != player.team )
            {
                continue;
            }
            
            self disableplayeruse( player );
            
            if ( var_2ad199a3a6ea8bd1 )
            {
                self.useobject disableplayeruse( player );
            }
        }
        
        self.var_9d00a9e419829084 = &function_65bbf87307466eb5;
    }
}

// Namespace carepackage_boobytrap
// Params 1
// Checksum 0x54f045fc, Offset: 0x3fd
// Size: 0x8a, Type: bool
function function_65bbf87307466eb5( player )
{
    /#
        if ( getdvarint( @"hash_a0537dfed15cb647", 0 ) != 0 )
        {
            return true;
        }
    #/
    
    if ( !isdefined( self.var_bb6b1a90c3f77d0 ) )
    {
        return true;
    }
    
    if ( !isdefined( self.var_bb6b1a90c3f77d0.team ) )
    {
        return true;
    }
    
    if ( !isdefined( player.team ) )
    {
        return true;
    }
    
    if ( self.var_bb6b1a90c3f77d0.team != player.team )
    {
        return true;
    }
    
    return false;
}

// Namespace carepackage_boobytrap
// Params 0
// Checksum 0x33c410d9, Offset: 0x490
// Size: 0x95
function function_e84326d26a4a2488()
{
    attacker = self.var_bb6b1a90c3f77d0;
    
    if ( isplayer( attacker ) )
    {
        self setscriptabledamageowner( attacker );
    }
    
    self.var_88529b256d95a199 = 1;
    self setscriptablepartstate( #"boobytrap", #"tripped" );
    
    if ( !isdefined( self.var_53caaa320dbae415 ) )
    {
        wait 0.5;
    }
    
    if ( isdefined( self ) )
    {
        self.owner = undefined;
        self setscriptablepartstate( #"boobytrap", #"detonate" );
        self notify( #"carepackage_detonated" );
    }
}

