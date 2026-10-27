// scripts\mp\common\utility\lower_message.gsc  (hash_0d661692006989e6.gscc) (size: 3936 Bytes / 0xf60 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4212ee2b (1108536875)
// size ...... 3936 (0xf60)
// includes .. 0   (offset: 0xee4)
// strings ... 5   (offset: 0xee4)
// dev strs .. 3   (offset: 0xf3c)
// exports ... 14  (offset: 0xa00)
// cseg ...... 0xae + 0x952 (0xa00)
// imports ... 23  (offset: 0xc30)
// animtree1 . 0   (offset: 0xf60)
// animtree2 . 0   (offset: 0xf60)
#namespace lower_message;

// Namespace lower_message
// Params 3
// Checksum 0x2332a6d8, Offset: 0xcc
// Size: 0x7b
function setlowermessageomnvar( ref, timer, var_df6a9abe5e74f401 )
{
    omnvarindex = game[ "lowerMessageIndex" ][ ref ];
    
    if ( !isdefined( omnvarindex ) )
    {
        assertmsg( "<dev string:x24>" + ref );
        return;
    }
    
    self setclientomnvar( "ui_lower_message", omnvarindex );
    
    if ( isdefined( timer ) )
    {
        self setclientomnvar( "ui_lower_message_time", timer );
    }
    
    if ( isdefined( var_df6a9abe5e74f401 ) )
    {
        thread clearomnvarsaftertime( var_df6a9abe5e74f401 );
    }
}

// Namespace lower_message
// Params 1, eflags: 0x4
// Checksum 0x511da2df, Offset: 0x14f
// Size: 0x3f
function private clearomnvarsaftertime( var_df6a9abe5e74f401 )
{
    self notify( #"message_cleared" );
    self endon( #"message_cleared" );
    self endon( #"death_or_disconnect" );
    wait var_df6a9abe5e74f401;
    self setclientomnvar( "ui_lower_message", 0 );
}

// Namespace lower_message
// Params 0
// Checksum 0xa7cdeb96, Offset: 0x196
// Size: 0x9f
function function_78d25b1b58140bc9()
{
    game[ "lowerMessageIndex" ] = [];
    numrows = tablelookupgetnumrows( "mp/hints.csv" );
    
    for ( index = 0; index < numrows ; index++ )
    {
        var_4b16a4c55857f0c0 = int( tablelookupbyrow( "mp/hints.csv", index, 0 ) );
        indexstr = tablelookupbyrow( "mp/hints.csv", index, 1 );
        
        if ( indexstr == "" )
        {
            continue;
        }
        
        assert( !isdefined( game[ "<dev string:x56>" ][ indexstr ] ), indexstr + "<dev string:x68>" );
        game[ "lowerMessageIndex" ][ indexstr ] = var_4b16a4c55857f0c0;
    }
}

// Namespace lower_message
// Params 10
// Checksum 0xf2c84db, Offset: 0x23d
// Size: 0xc3
function setlowermessage( name, text, time = 0, priority = 1, showtimer = 0, shouldfade = 0, fadetoalpha = 0.85, fadetoalphatime = 3, hidewhenindemo = 0, hidewheninmenu = 1 )
{
    addlowermessage( name, text, time, priority, showtimer, shouldfade, fadetoalpha, fadetoalphatime, hidewhenindemo, hidewheninmenu );
    updatelowermessage();
}

// Namespace lower_message
// Params 1
// Checksum 0x38571765, Offset: 0x308
// Size: 0x1c
function clearlowermessage( name )
{
    removelowermessage( name );
    updatelowermessage();
}

// Namespace lower_message
// Params 0
// Checksum 0x590a777f, Offset: 0x32c
// Size: 0x59
function clearlowermessages()
{
    if ( !( isdefined( self ) && isdefined( self.lowermessage ) && isdefined( self.lowermessages ) ) )
    {
        return;
    }
    
    for ( i = 0; i < self.lowermessages.size ; i++ )
    {
        self.lowermessages[ i ] = undefined;
    }
    
    updatelowermessage();
}

// Namespace lower_message
// Params 0
// Checksum 0xe70f6469, Offset: 0x38d
// Size: 0xb6
function sortlowermessages()
{
    for ( i = 1; i < self.lowermessages.size ; i++ )
    {
        message = self.lowermessages[ i ];
        priority = message.priority;
        
        for ( j = i - 1; j >= 0 && priority > self.lowermessages[ j ].priority ; j-- )
        {
            self.lowermessages[ j + 1 ] = self.lowermessages[ j ];
        }
        
        self.lowermessages[ j + 1 ] = message;
    }
}

// Namespace lower_message
// Params 10
// Checksum 0x7c0f0186, Offset: 0x44b
// Size: 0x1db
function addlowermessage( name, text, time, priority, showtimer, shouldfade, fadetoalpha, fadetoalphatime, hidewhenindemo, hidewheninmenu )
{
    newmessage = undefined;
    
    foreach ( message in self.lowermessages )
    {
        if ( message.name == name )
        {
            if ( message.text == text && message.priority == priority )
            {
                return;
            }
            
            newmessage = message;
            break;
        }
    }
    
    if ( !isdefined( newmessage ) )
    {
        newmessage = spawnstruct();
        self.lowermessages[ self.lowermessages.size ] = newmessage;
    }
    
    newmessage.name = name;
    newmessage.text = text;
    newmessage.time = time;
    newmessage.addtime = gettime();
    newmessage.priority = priority;
    newmessage.showtimer = showtimer;
    newmessage.shouldfade = shouldfade;
    newmessage.fadetoalpha = fadetoalpha;
    newmessage.fadetoalphatime = fadetoalphatime;
    newmessage.hidewhenindemo = hidewhenindemo;
    newmessage.hidewheninmenu = hidewheninmenu;
    sortlowermessages();
}

// Namespace lower_message
// Params 1
// Checksum 0xc79e08bc, Offset: 0x62e
// Size: 0xe3
function removelowermessage( name )
{
    if ( isdefined( self.lowermessages ) )
    {
        for ( i = self.lowermessages.size; i > 0 ; i-- )
        {
            if ( self.lowermessages[ i - 1 ].name != name )
            {
                continue;
            }
            
            message = self.lowermessages[ i - 1 ];
            
            for ( j = i; j < self.lowermessages.size ; j++ )
            {
                if ( isdefined( self.lowermessages[ j ] ) )
                {
                    self.lowermessages[ j - 1 ] = self.lowermessages[ j ];
                }
            }
            
            self.lowermessages[ self.lowermessages.size - 1 ] = undefined;
        }
        
        sortlowermessages();
    }
}

// Namespace lower_message
// Params 0
// Checksum 0x5a0ffb30, Offset: 0x719
// Size: 0x1c
function getlowermessage()
{
    if ( !isdefined( self.lowermessages ) )
    {
        return;
    }
    
    return self.lowermessages[ 0 ];
}

// Namespace lower_message
// Params 0
// Checksum 0x59b437eb, Offset: 0x73e
// Size: 0x221
function updatelowermessage()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    message = getlowermessage();
    
    if ( !isdefined( message ) )
    {
        if ( isdefined( self.lowermessage ) && isdefined( self.lowertimer ) )
        {
            self.lowermessage.alpha = 0;
            self.lowertimer.alpha = 0;
        }
        
        return;
    }
    
    self.lowermessage settext( message.text );
    self.lowermessage.alpha = 0.85;
    self.lowertimer.alpha = 1;
    self.lowermessage.hidewhenindemo = message.hidewhenindemo;
    self.lowermessage.hidewheninmenu = message.hidewheninmenu;
    
    if ( message.shouldfade )
    {
        self.lowermessage fadeovertime( min( message.fadetoalphatime, 60 ) );
        self.lowermessage.alpha = message.fadetoalpha;
    }
    
    if ( message.time > 0 && message.showtimer )
    {
        self.lowertimer settimer( max( message.time - ( gettime() - message.addtime ) / 1000, 0.1 ) );
        return;
    }
    
    if ( message.time > 0 && !message.showtimer )
    {
        self.lowertimer settext( "" );
        self.lowermessage fadeovertime( min( message.time, 60 ) );
        self.lowermessage.alpha = 0;
        thread clearondeath( message );
        thread clearafterfade( message );
        return;
    }
    
    self.lowertimer settext( "" );
}

// Namespace lower_message
// Params 1
// Checksum 0xdd5ed763, Offset: 0x967
// Size: 0x5b
function clearondeath( message )
{
    self notify( #"message_cleared" );
    self endon( #"message_cleared" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self waittill( #"death" );
    clearlowermessage( message.name );
}

// Namespace lower_message
// Params 1
// Checksum 0x75ade75a, Offset: 0x9ca
// Size: 0x36
function clearafterfade( message )
{
    wait message.time;
    clearlowermessage( message.name );
    self notify( #"message_cleared" );
}

