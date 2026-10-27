// scripts\mp\common\utility\dialog_utility.gsc  (hash_5c71abbf7c9f54bc.gscc) (size: 6994 Bytes / 0x1b52 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4b323e96 (1261584022)
// size ...... 6994 (0x1b52)
// includes .. 3   (offset: 0x1972)
// strings ... 23  (offset: 0x198a)
// dev strs .. 9   (offset: 0x1ae2)
// exports ... 21  (offset: 0x11da)
// cseg ...... 0x22e + 0xfac (0x11da)
// imports ... 35  (offset: 0x1522)
// animtree1 . 0   (offset: 0x1b52)
// animtree2 . 0   (offset: 0x1b52)
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\hostmigration;

#namespace dialog_utility;

// Namespace dialog_utility
// Params 1, eflags: 0x4
// Checksum 0xf6bc0413, Offset: 0x24c
// Size: 0x5f, Type: bool
function private function_2ae9409f7b464b0f( deftype )
{
    if ( !isdefined( deftype ) )
    {
        return false;
    }
    
    switch ( deftype )
    {
        case #"hash_1ffc0efa5ad2a952":
        case #"hash_3ba2e9bad3b576e6":
        case #"hash_6129c50ada7bcca3":
        case #"hash_6f6034fb855eddca":
        case #"hash_7d493ed7181c2fae":
            return false;
    }
    
    return true;
}

// Namespace dialog_utility
// Params 2, eflags: 0x4
// Checksum 0x22717215, Offset: 0x2b4
// Size: 0x66, Type: bool
function private function_b5b9585bd5e11b3d( parentref, deftype )
{
    if ( !isdefined( parentref ) || parentref == "" && deftype != "Character" )
    {
        return false;
    }
    
    tokens = strtok( parentref, "_" );
    
    if ( tokens.size == 0 || tokens[ 0 ] == "mp" )
    {
        return true;
    }
    
    return false;
}

// Namespace dialog_utility
// Params 3, eflags: 0x4
// Checksum 0x34c8214, Offset: 0x323
// Size: 0x1a1, Type: bool
function private function_5aff4ec2b2c43d1d( longname, deftype, parentref )
{
    if ( !isdefined( longname ) || longname == "" )
    {
        return false;
    }
    
    switch ( deftype )
    {
        case #"hash_174c0a6c9c845cf1":
            tokens = strtok( longname, "_" );
            
            if ( tokens.size > 0 && isdefined( tokens[ 1 ] ) && ( tokens[ 1 ] == "killstreak" || tokens[ 1 ] == "fieldupgrade" || tokens[ 1 ] == "equipment" ) )
            {
                return true;
            }
            
            break;
        case #"hash_c75355ed41b5bc53":
            if ( isdefined( parentref ) )
            {
                tokens = strtok( parentref, "_" );
                
                if ( tokens.size > 0 && isdefined( tokens[ 1 ] ) && ( tokens[ 1 ] == "killstreak" || tokens[ 1 ] == "fieldupgrade" || tokens[ 1 ] == "equipment" ) )
                {
                    return true;
                }
            }
            
            break;
        case #"hash_fa9a9f82be7c7750":
            tokens = strtok( longname, " " );
            
            if ( tokens.size > 0 && ( isdefined( tokens[ 0 ] ) && function_57c828aa1fdae86f( tokens[ 0 ] ) || isdefined( tokens[ 1 ] ) && tokens[ 1 ] == "Team" ) )
            {
                return true;
            }
            
            break;
        case #"hash_6f8dfe52d0c03fdf":
            tokens = strtok( longname, "_" );
            
            if ( tokens.size > 0 && isdefined( tokens[ 2 ] ) && ( tokens[ 2 ] == "leader" || tokens[ 2 ] == "operator" ) )
            {
                return true;
            }
            
            break;
    }
    
    return false;
}

// Namespace dialog_utility
// Params 1
// Checksum 0xce87acde, Offset: 0x4cd
// Size: 0xff
function function_57c828aa1fdae86f( ref )
{
    switch ( ref )
    {
        case #"hash_1f2f530b7da0d4ba":
        case #"hash_2892a50b525254f1":
        case #"hash_30f1996ee57c42bd":
        case #"hash_332a13e51c2db6b1":
        case #"hash_3a46650ad52c6c11":
        case #"hash_3b16a09f5f1b3166":
        case #"hash_3c2a798e47904879":
        case #"hash_5cf7a3d66f350a91":
        case #"hash_61d85e6b18faf229":
        case #"hash_6e4683d5f1bfa231":
        case #"hash_9915ff80cffdfc33":
        case #"hash_9b5058cbb64f5c19":
        case #"hash_ced4765484d765a9":
        case #"hash_f88271914675e646":
        case #"hash_fa73f1f6bd9f2642":
        case #"hash_faa2b3f6bdc39581":
        case #"hash_fab58df6bdd26439":
        case #"hash_fab8a3f6bdd4c572":
            return 1;
        default:
            return 0;
    }
}

// Namespace dialog_utility
// Params 3
// Checksum 0xb0311d96, Offset: 0x5d4
// Size: 0x11b
function function_b857dac241739eeb( typeref, var_b8f4471fe22db504, parentref )
{
    if ( !isdefined( level.dialogmap ) )
    {
        /#
            iprintln( "<dev string:x24>" );
        #/
        
        return;
    }
    
    var_2f40117570488a6a = level.dialogmap[ typeref ];
    
    if ( !isdefined( var_2f40117570488a6a ) )
    {
        /#
            iprintln( "<dev string:x5e>" + typeref );
        #/
    }
    
    aliascode = undefined;
    
    foreach ( dialoginfo in var_2f40117570488a6a )
    {
        if ( dialoginfo.longname != var_b8f4471fe22db504 )
        {
            continue;
        }
        
        if ( isdefined( parentref ) )
        {
            if ( dialoginfo.parent != parentref )
            {
                continue;
            }
        }
        
        aliascode = dialoginfo.shortname;
        break;
    }
    
    return aliascode;
}

// Namespace dialog_utility
// Params 5
// Checksum 0x71edcd1d, Offset: 0x6f8
// Size: 0x30
function createdialogalias( moderef, mapref, sceneref, characterref, eventref )
{
    
}

// Namespace dialog_utility
// Params 1
// Checksum 0xef40a880, Offset: 0x731
// Size: 0x2a
function function_8f16d04b74c7bcd1( team )
{
    teamref = function_d960812ed4930188( team );
    
    if ( !isdefined( teamref ) )
    {
        return;
    }
    
    return teamref;
}

// Namespace dialog_utility
// Params 1
// Checksum 0xf0b9cbec, Offset: 0x764
// Size: 0x1ba
function function_d960812ed4930188( team )
{
    validteam = isdefined( team ) && arraycontains( level.teamnamelist, team );
    
    if ( !validteam )
    {
        /#
            iprintln( "<dev string:x98>" );
        #/
        
        return;
    }
    
    teamfaction = undefined;
    gameteam = game[ team ] ?? #"unknown";
    
    switch ( gameteam )
    {
        case #"hash_6182550308f4c7e":
        case #"hash_aec089865f37db9e":
        case #"hash_d5db7454b6a73a3d":
            teamfaction = "RS";
            break;
        case #"hash_6151370d8d0dafbd":
        case #"hash_de67d44ee82442a5":
            teamfaction = "SA";
            break;
        case #"hash_16af78da11bad4f5":
        case #"hash_7e32e56cd23412de":
        case #"hash_d56d8529d86b9c8d":
            teamfaction = "UK";
            break;
        case #"hash_253aa9d445fc8bc7":
        case #"hash_7e4b9c6cd24727ab":
            teamfaction = "DE";
            break;
        case #"hash_e1df00fac0b78d5c":
            teamfaction = "Militia";
            break;
        case #"hash_2892a50b525254f1":
            teamfaction = "Navy Seals";
            break;
        case #"hash_9b5058cbb64f5c19":
            teamfaction = "OpFor";
            break;
        case #"hash_61d85e6b18faf229":
            teamfaction = "Rangers";
            break;
        case #"hash_f88271914675e646":
            teamfaction = "Spetsnaz";
            break;
        case #"hash_332a13e51c2db6b1":
            teamfaction = "TF141";
            break;
        default:
            /#
                iprintln( "<dev string:xc0>" );
            #/
            
            teamfaction = "UK";
            break;
    }
    
    return teamfaction;
}

// Namespace dialog_utility
// Params 5
// Checksum 0x975a6b36, Offset: 0x927
// Size: 0x143
function function_7162cf91018ef73e( dialog, team, group, excludelist, forceplay )
{
    if ( !dialogueexists( dialog, team ) )
    {
        /#
            if ( isxhash( dialog ) )
            {
                dialog = getxhashsourcename( dialog );
            }
            
            println( "<dev string:xfd>" + dialog + "<dev string:x111>" );
        #/
        
        return;
    }
    
    if ( !isdefined( team ) )
    {
        println( "<dev string:x13b>" );
        return;
    }
    
    playerlist = undefined;
    
    if ( isdefined( team ) )
    {
        playerlist = teams::getteamdata( team, "players" );
    }
    
    if ( playerlist.size > 0 )
    {
        foreach ( player in playerlist )
        {
            if ( isdefined( excludelist ) && arraycontains( excludelist, player ) )
            {
                continue;
            }
            
            if ( player issplitscreenplayer() && !player issplitscreenplayerprimary() )
            {
                continue;
            }
            
            player function_c106996cffda95fe( dialog, group, forceplay );
        }
    }
}

// Namespace dialog_utility
// Params 3
// Checksum 0x106fa600, Offset: 0xa72
// Size: 0xaf
function function_c106996cffda95fe( dialog, group, forceplay )
{
    assert( isdefined( self ), "<dev string:x1b7>" );
    
    if ( !forceplay )
    {
        if ( level.disableannouncer )
        {
            return;
        }
        
        if ( isdefined( level.modeplayerskipdialog ) && self [[ level.modeplayerskipdialog ]]( dialog ) )
        {
            return;
        }
    }
    
    dialogentry = function_51c8a1c4bba55ed2( dialog, self.team );
    assert( isdefined( dialogentry ), "<dev string:x1ea>" + getxhashsourcename( dialog ) + "<dev string:x111>" );
    dialogonplayer( dialog, dialogentry, self.team, group );
}

// Namespace dialog_utility
// Params 1
// Checksum 0xf468ded5, Offset: 0xb29
// Size: 0x33
function function_e1a46131d485b5d4( dialog )
{
    dialogueentry = function_51c8a1c4bba55ed2( dialog, self.team );
    function_78b949128eb252eb( dialog, dialogueentry );
}

// Namespace dialog_utility
// Params 4
// Checksum 0xcf82ad9a, Offset: 0xb64
// Size: 0xa3
function function_78b949128eb252eb( dialog, dialogueentry, bypasscooldown, delaytime )
{
    if ( level.disableannouncer )
    {
        return;
    }
    
    assert( isplayer( self ) );
    
    if ( delaytime > 0 )
    {
        self endon( #"disconnect" );
        hostmigration::waitlongdurationwithpause( delaytime );
    }
    
    if ( !isdefined( self.currentdialog ) || bypasscooldown )
    {
        if ( !isstruct( dialogueentry ) )
        {
            return;
        }
        
        dialogonplayer( dialog, dialogueentry, self.team );
        self.currentdialog = dialog;
        thread function_22baec0172342df7( 5 );
    }
}

// Namespace dialog_utility
// Params 1, eflags: 0x4
// Checksum 0xe67223f0, Offset: 0xc0f
// Size: 0x4a
function private function_22baec0172342df7( delaytime )
{
    self endon( #"disconnect" );
    self notify( #"hash_ce544cef131519d" );
    self endon( #"hash_ce544cef131519d" );
    wait delaytime;
    
    if ( isdefined( self.currentdialog ) )
    {
        self.currentdialog = undefined;
    }
}

// Namespace dialog_utility
// Params 1, eflags: 0x4
// Checksum 0x62ad4ecb, Offset: 0xc61
// Size: 0x4f
function private function_9e551031e15eafb3( soundname )
{
    if ( !isxhash( soundname ) )
    {
        soundname = tolower( soundname );
    }
    
    dialogentry = { #aliases:[] };
    dialogentry.aliases[ 0 ] = { #alias:soundname };
}

// Namespace dialog_utility
// Params 2
// Checksum 0xe3319207, Offset: 0xcb9
// Size: 0x42
function function_4ecb0e9169d57eaa( dialog, aliasoverride )
{
    if ( !isdefined( aliasoverride ) )
    {
        return;
    }
    
    if ( isxhash( dialog ) )
    {
        dialog = getxhashhexname( dialog );
    }
    
    self queuedialogforplayer( #"queue1", aliasoverride, dialog, 2 );
}

// Namespace dialog_utility
// Params 7
// Checksum 0xd1d100cc, Offset: 0xd03
// Size: 0x1dd
function dialogonplayer( dialog, dialogentry, team, group, groupoverride, location, aliasindex = 0 )
{
    assert( isdefined( dialogentry ) );
    
    if ( !team_utility::isgameplayteam( team ) )
    {
        return;
    }
    
    if ( !isstruct( dialogentry ) )
    {
        dialogentry = function_9e551031e15eafb3( dialogentry );
    }
    
    if ( !isdefined( dialogentry.aliases.size ) || dialogentry.aliases.size == 0 )
    {
        return;
    }
    
    assert( aliasindex < dialogentry.aliases.size );
    soundname = dialogentry.aliases[ aliasindex ].alias;
    
    if ( !isdefined( soundname ) )
    {
        return;
    }
    
    queue = dialogentry.queue ?? #"queue1";
    intervaltimeout = dialogentry.interval ?? 2;
    
    if ( isxhash( dialog ) )
    {
        dialog = getxhashhexname( dialog );
    }
    
    if ( isdefined( dialogentry.response ) && isdefined( dialogentry.response.aliases[ aliasindex ].alias ) )
    {
        var_251f3314c75557e7 = dialogentry.response.aliases[ aliasindex ].alias;
        intervaltimeout += dialogentry.response.interval ?? 2;
        responsedelay = 0.5;
        self function_ca811b99779932ad( queue, soundname, var_251f3314c75557e7, dialog, responsedelay, intervaltimeout, group, groupoverride, location );
        return;
    }
    
    self queuedialogforplayer( queue, soundname, dialog, intervaltimeout, group, groupoverride, location );
}

// Namespace dialog_utility
// Params 6
// Checksum 0x51cc572a, Offset: 0xee8
// Size: 0x14c
function function_ab67da8d856d4d0e( olddialog, newdialogentry, team, group, location, aliasindex = 0 )
{
    assert( isdefined( newdialogentry ) );
    
    if ( team_utility::isgameplayteam( team ) )
    {
        queue = #"queue1";
        intervaltimeout = 2;
        
        if ( isstruct( newdialogentry ) )
        {
            if ( !isdefined( newdialogentry.aliases.size ) || newdialogentry.aliases.size == 0 )
            {
                return 0;
            }
            
            assert( aliasindex < newdialogentry.aliases.size );
            var_11a9893f4a69fbb8 = newdialogentry.aliases[ aliasindex ].alias;
            queue = newdialogentry.queue ?? #"queue1";
            intervaltimeout = newdialogentry.interval ?? 2;
            
            if ( !isdefined( var_11a9893f4a69fbb8 ) )
            {
                return 0;
            }
        }
        else
        {
            var_11a9893f4a69fbb8 = newdialogentry;
            
            if ( !isxhash( var_11a9893f4a69fbb8 ) )
            {
                var_11a9893f4a69fbb8 = tolower( var_11a9893f4a69fbb8 );
            }
        }
        
        if ( isxhash( olddialog ) )
        {
            olddialog = getxhashhexname( olddialog );
        }
        
        return self function_1d5c277727132848( queue, var_11a9893f4a69fbb8, olddialog, intervaltimeout, group, location );
    }
    
    return 0;
}

// Namespace dialog_utility
// Params 4, eflags: 0x4
// Checksum 0x6a19965a, Offset: 0x103d
// Size: 0xde
function private function_a99e709b204a14ee( dialogref, dialogset, var_7de9d0e850f0aa3b, var_7de9d1e850f0ac6e )
{
    if ( isdefined( dialogset ) )
    {
        if ( isdefined( var_7de9d0e850f0aa3b ) && isdefined( var_7de9d1e850f0ac6e ) )
        {
            if ( isdefined( game[ "dialog" ][ dialogset ][ var_7de9d0e850f0aa3b ][ var_7de9d1e850f0ac6e ] ) )
            {
                return game[ "dialog" ][ dialogset ][ var_7de9d0e850f0aa3b ][ var_7de9d1e850f0ac6e ][ dialogref ];
            }
            
            return;
        }
        else if ( isdefined( var_7de9d0e850f0aa3b ) )
        {
            if ( isdefined( game[ "dialog" ][ dialogset ][ var_7de9d0e850f0aa3b ] ) )
            {
                return game[ "dialog" ][ dialogset ][ var_7de9d0e850f0aa3b ][ dialogref ];
            }
            
            return;
        }
        
        if ( isdefined( game[ "dialog" ][ dialogref ] ) )
        {
            return game[ "dialog" ][ dialogref ];
        }
        else if ( isdefined( dialogset ) )
        {
            if ( isdefined( game[ "dialog" ][ dialogset ] ) )
            {
                return game[ "dialog" ][ dialogset ][ dialogref ];
            }
            
            return;
        }
        
        return;
    }
    
    if ( isdefined( game[ "dialog" ] ) )
    {
        return game[ "dialog" ][ dialogref ];
    }
}

// Namespace dialog_utility
// Params 4
// Checksum 0x684e09b5, Offset: 0x1124
// Size: 0x7d
function function_51c8a1c4bba55ed2( dialogref, dialogset, var_7de9d0e850f0aa3b, var_7de9d1e850f0ac6e )
{
    dialoghash = dialogref;
    
    if ( !isxhash( dialogref ) )
    {
        dialoghash = getxhash( dialogref );
    }
    
    entry = function_a99e709b204a14ee( dialoghash, dialogset, var_7de9d0e850f0aa3b, var_7de9d1e850f0ac6e );
    
    if ( isdefined( entry ) )
    {
        return entry;
    }
    
    if ( !isxhash( dialogref ) )
    {
        return function_a99e709b204a14ee( dialogref, dialogset, var_7de9d0e850f0aa3b, var_7de9d1e850f0ac6e );
    }
}

// Namespace dialog_utility
// Params 2
// Checksum 0xedb0ea20, Offset: 0x11aa
// Size: 0x2f, Type: bool
function dialogueexists( dialog, team )
{
    if ( !isdefined( dialog ) )
    {
        return false;
    }
    
    if ( isdefined( function_51c8a1c4bba55ed2( dialog, team ) ) )
    {
        return true;
    }
    
    return false;
}

