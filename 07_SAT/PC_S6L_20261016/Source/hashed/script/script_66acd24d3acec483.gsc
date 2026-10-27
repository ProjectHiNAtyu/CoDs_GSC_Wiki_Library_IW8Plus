// script_66acd24d3acec483  (hash_66acd24d3acec483.gscc) (size: 7312 Bytes / 0x1c90 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc6f7bdc3 (3338124739)
// size ...... 7312 (0x1c90)
// includes .. 6   (offset: 0x1b38)
// strings ... 1   (offset: 0x1b68)
// dev strs .. 22  (offset: 0x1b74)
// exports ... 22  (offset: 0x11f0)
// cseg ...... 0x78 + 0x1178 (0x11f0)
// imports ... 50  (offset: 0x1560)
// animtree1 . 0   (offset: 0x1c90)
// animtree2 . 0   (offset: 0x1c90)
#using scripts\common\callbacks;
#using scripts\common\dev;
#using scripts\common\utility;
#using scripts\mp\class;
#using scripts\mp\common\utility\player;
#using scripts\mp\hud_util;

#namespace specialty_specialist_builder;

// Namespace specialty_specialist_builder
// Params 0, eflags: 0x1
// Checksum 0x5a547098, Offset: 0x96
// Size: 0x44
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
    level callback::add( #"player_death", &onplayerkilled );
    level callback::add( #"player_laststand", &function_def1e1d24ede9b70 );
}

// Namespace specialty_specialist_builder
// Params 1
// Checksum 0xdbffb1a2, Offset: 0xe2
// Size: 0x52
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_specialist_builder", &setspecialty, &unsetspecialty, [] );
    }
    
    /#
        dev::devcommandwatcher( @"scr_specialist_builder", &handledevcommand );
    #/
}

// Namespace specialty_specialist_builder
// Params 0
// Checksum 0xb9f0f883, Offset: 0x13c
// Size: 0x155
function setspecialty()
{
    bundle = self.var_9842326056fd7207;
    
    if ( !self.var_7ea49a40becc89fa )
    {
        perks = getspecialistperks( bundle );
        self.var_7ea49a40becc89fa = { #data:{ #var_c64cb336c5684398:bundle.var_e90ebd23d057171c ?? 1, #var_e8d560f997696ac8:bundle.var_732921653b971ed4 ?? 1 }, #perklist:perks, #gainedperks:[] };
        return;
    }
    
    if ( self.var_7ea49a40becc89fa.gainedperks )
    {
        foreach ( perk in self.var_7ea49a40becc89fa.gainedperks )
        {
            if ( !isdefined( self.perks[ perk ] ) )
            {
                utility::callsharedfunc( #"perk", #"giveperk", perk );
            }
        }
        
        function_173a7a25c20d9891();
    }
}

// Namespace specialty_specialist_builder
// Params 0
// Checksum 0x47a2d4c0, Offset: 0x299
// Size: 0x25
function unsetspecialty()
{
    if ( !self.gettingloadout || !player::isreallyalive( self ) )
    {
        self.var_7ea49a40becc89fa = undefined;
    }
}

// Namespace specialty_specialist_builder
// Params 1
// Checksum 0x78860fe8, Offset: 0x2c6
// Size: 0x6a
function onplayerkilled( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    
    if ( attacker.var_7ea49a40becc89fa && attacker.team != victim.team )
    {
        attacker gainperks();
    }
}

// Namespace specialty_specialist_builder
// Params 1
// Checksum 0xe6fb66e6, Offset: 0x338
// Size: 0x3a
function function_def1e1d24ede9b70( deathdata )
{
    victim = deathdata.victim;
    
    if ( victim.var_7ea49a40becc89fa )
    {
        victim loseperks();
    }
}

// Namespace specialty_specialist_builder
// Params 0
// Checksum 0x57857c0e, Offset: 0x37a
// Size: 0x12c
function gainperks()
{
    gaincount = self.var_7ea49a40becc89fa.data.var_e8d560f997696ac8;
    randomized = arrayrandomize( self.var_7ea49a40becc89fa.perklist );
    
    for ( i = 0; i < gaincount ; i++ )
    {
        foreach ( perk in randomized )
        {
            if ( !isdefined( self.perks[ perk ] ) )
            {
                utility::callsharedfunc( #"perk", #"giveperk", perk );
                self.var_7ea49a40becc89fa.gainedperks[ self.var_7ea49a40becc89fa.gainedperks.size ] = perk;
                break;
            }
        }
    }
    
    function_173a7a25c20d9891();
}

// Namespace specialty_specialist_builder
// Params 0
// Checksum 0xd4660273, Offset: 0x4ae
// Size: 0x11b
function loseperks()
{
    losecount = self.var_7ea49a40becc89fa.data.var_c64cb336c5684398;
    
    for ( i = 0; i < losecount ; i++ )
    {
        if ( self.var_7ea49a40becc89fa.gainedperks )
        {
            if ( self.var_7ea49a40becc89fa.gainedperks.size <= 0 )
            {
                break;
            }
            
            index = self.var_7ea49a40becc89fa.gainedperks.size - 1;
            perk = self.var_7ea49a40becc89fa.gainedperks[ index ];
            
            if ( isdefined( self.perks[ perk ] ) )
            {
                utility::callsharedfunc( #"perk", #"removeperk", perk );
            }
            else
            {
                i--;
            }
            
            self.var_7ea49a40becc89fa.gainedperks = arrayremove( self.var_7ea49a40becc89fa.gainedperks, perk );
        }
    }
    
    function_173a7a25c20d9891();
}

// Namespace specialty_specialist_builder
// Params 0
// Checksum 0x89fdcb88, Offset: 0x5d1
// Size: 0xa9, Type: bool
function function_e7cc211e3c0135a2()
{
    if ( self.var_7ea49a40becc89fa.perklist )
    {
        foreach ( perk in self.var_7ea49a40becc89fa.perklist )
        {
            if ( !isdefined( self.perks[ perk ] ) )
            {
                return false;
            }
        }
        
        return true;
    }
    
    return false;
}

// Namespace specialty_specialist_builder
// Params 0
// Checksum 0xb2c673e6, Offset: 0x683
// Size: 0xb2
function function_7eed7b79095b6514()
{
    count = 0;
    
    if ( self.var_7ea49a40becc89fa.perklist )
    {
        foreach ( perk in self.var_7ea49a40becc89fa.perklist )
        {
            if ( isdefined( self.perks[ perk ] ) )
            {
                count++;
            }
        }
    }
    
    return count;
}

// Namespace specialty_specialist_builder
// Params 1
// Checksum 0x3048c87e, Offset: 0x73e
// Size: 0xdf
function getspecialistperks( bundle )
{
    specialistlist = getscriptbundle( bundle.var_c96d2a33b5c05ce7 );
    assert( specialistlist, "<dev string:x24>" );
    assert( specialistlist.perk_list.size > 0, "<dev string:x76>" );
    perkrefs = [];
    
    foreach ( entry in specialistlist.perk_list )
    {
        perkrefs[ perkrefs.size ] = entry.ref;
    }
    
    return perkrefs;
}

// Namespace specialty_specialist_builder
// Params 0
// Checksum 0x6b2f55df, Offset: 0x826
// Size: 0x87
function function_173a7a25c20d9891()
{
    /#
        if ( self.var_ac16dedf8ba45d3a )
        {
            foreach ( callback in self.var_ac16dedf8ba45d3a )
            {
                self [[ callback ]]();
            }
        }
    #/
}

// Namespace specialty_specialist_builder
// Params 0
// Checksum 0x5dce0b61, Offset: 0x8b5
// Size: 0xcc
function getloadoutperks()
{
    var_d729a2def84cf0f6 = [];
    defaultperks = class::function_c8d9816a5c9f1f97( self );
    
    if ( isdefined( self.loadoutperks ) )
    {
        foreach ( perk in self.loadoutperks )
        {
            if ( isdefined( level.cacperks[ perk ] ) && !arraycontains( defaultperks, perk ) && !arraycontains( var_d729a2def84cf0f6, perk ) )
            {
                var_d729a2def84cf0f6[ var_d729a2def84cf0f6.size ] = perk;
            }
        }
    }
    
    return var_d729a2def84cf0f6;
}

// Namespace specialty_specialist_builder
// Params 0
// Checksum 0xf5be4f1f, Offset: 0x98a
// Size: 0x15
function function_b4b24a5b2ff54ceb()
{
    return self.var_7ea49a40becc89fa.gainedperks;
}

/#

    // Namespace specialty_specialist_builder
    // Params 2, eflags: 0x4
    // Checksum 0xb9875542, Offset: 0x9a8
    // Size: 0xe5, Type: dev
    function private handledevcommand( command, args )
    {
        switch ( command )
        {
            case #"hash_847fdb37e5b1b2a4":
                if ( args && args.size > 0 )
                {
                    toggleon = args[ 0 ] != "<dev string:xdc>";
                    player = function_9970128b45efc7ef( args[ 1 ] );
                    
                    if ( toggleon )
                    {
                        if ( !player.var_5be1a1edb84b223d )
                        {
                            player function_511733006a8aed03();
                        }
                    }
                    else if ( player.var_5be1a1edb84b223d )
                    {
                        player function_d944ddb66c174a0a();
                    }
                }
                
                break;
            case #"hash_4086320cdb78dbf8":
                player = function_9970128b45efc7ef( args[ 0 ] );
                player gainperks();
                break;
            case #"hash_a50a5d1dfdd601aa":
                player = function_9970128b45efc7ef( args[ 0 ] );
                player loseperks();
                break;
        }
    }

    // Namespace specialty_specialist_builder
    // Params 0
    // Checksum 0x8ba7e674, Offset: 0xa95
    // Size: 0x189, Type: dev
    function function_511733006a8aed03()
    {
        self notify( #"hash_6527384ea7df482" );
        self endon( #"hash_6527384ea7df482" );
        
        if ( isdefined( self.var_5be1a1edb84b223d ) )
        {
            function_d944ddb66c174a0a();
        }
        
        fontscale = 1;
        xalign = "<dev string:xf4>";
        yalign = "<dev string:xf4>";
        xoffset = 150;
        yoffset = 25;
        height = int( level.fontheight * fontscale );
        elem = newclienthudelem( self );
        elem.x = 0;
        elem.y = 0;
        elem.alpha = 1;
        elem.height = height;
        elem.width = 0;
        elem.foreground = 1;
        elem.children = [];
        elem.elemtype = "<dev string:xfc>";
        elem.fontscale = fontscale;
        elem setdevtext( "<dev string:x104>" );
        elem hud_util::setparent( level.uiparent );
        elem hud_util::setpoint( xalign, yalign, xoffset, yoffset );
        self.var_5be1a1edb84b223d = elem;
        
        if ( !isdefined( self.var_ac16dedf8ba45d3a ) )
        {
            self.var_ac16dedf8ba45d3a = [];
        }
        
        self.var_ac16dedf8ba45d3a[ self.var_ac16dedf8ba45d3a.size ] = &function_5fc04a255bbf8854;
        function_5fc04a255bbf8854();
    }

    // Namespace specialty_specialist_builder
    // Params 0
    // Checksum 0xcd563b03, Offset: 0xc26
    // Size: 0x355, Type: dev
    function function_5fc04a255bbf8854()
    {
        self notify( #"hash_8eb08e00f3e60712" );
        self endon( #"hash_8eb08e00f3e60712" );
        
        if ( !isdefined( self.perks[ "<dev string:x10b>" ] ) )
        {
            perksvalue = "<dev string:x128>" + "<dev string:x10b>";
        }
        else
        {
            loadoutperks = function_e121a332a6bf802a( getloadoutperks() );
            lootperks = function_e121a332a6bf802a( utility::callsharedfunc( #"perk", #"hash_497188f48811df36" ) );
            var_2cda638646e809f = function_b4b24a5b2ff54ceb();
            var_37b5a9b147808ce3 = function_7eed7b79095b6514();
            var_45603fe4faf99a32 = self.var_7ea49a40becc89fa.perklist.size ?? 1;
            var_4a62b0f6788ba18e = var_37b5a9b147808ce3 / var_45603fe4faf99a32;
            var_5505b188ddaf0024 = [ { #header:"<dev string:x13d>" + var_37b5a9b147808ce3 + "<dev string:x153>" + var_45603fe4faf99a32 + "<dev string:x157>" + round( var_4a62b0f6788ba18e * 100, 0.1 ) + "<dev string:x15b>" }, { #perks:var_2cda638646e809f, #header:"<dev string:x15f>" } ];
            
            if ( loadoutperks && loadoutperks.size > 0 )
            {
                data = { #perks:loadoutperks, #header:"<dev string:x180>" };
                var_5505b188ddaf0024[ var_5505b188ddaf0024.size ] = data;
            }
            
            if ( lootperks && lootperks.size > 0 )
            {
                data = { #perks:lootperks, #header:"<dev string:x196>" };
                var_5505b188ddaf0024[ var_5505b188ddaf0024.size ] = data;
            }
            
            perksvalue = "<dev string:x104>";
            
            foreach ( pdata in var_5505b188ddaf0024 )
            {
                perksvalue += "<dev string:x1a9>" + pdata.header;
                
                if ( pdata.perks )
                {
                    foreach ( perk in pdata.perks )
                    {
                        bundle = level.perkbundles[ perk ];
                        isdupe = !arraycompare( pdata.perks, var_2cda638646e809f ) && arraycontains( var_2cda638646e809f, perk );
                        perksvalue += ( isdupe ? "<dev string:x1ac>" : "<dev string:x1a9>" ) + ( bundle.name ? debugtranslatestring( bundle.name ) : "<dev string:x1ba>" ) + "<dev string:x1c4>" + perk + "<dev string:x1c8>";
                        perksvalue += "<dev string:x1cb>";
                    }
                }
                
                perksvalue += "<dev string:x1cb>";
            }
        }
        
        self.var_5be1a1edb84b223d setdevtext( perksvalue );
    }

    // Namespace specialty_specialist_builder
    // Params 1
    // Checksum 0x7d2380b0, Offset: 0xf83
    // Size: 0xbf, Type: dev
    function function_e121a332a6bf802a( perkarr )
    {
        var_cebb6d333575f1ad = self.var_7ea49a40becc89fa.perklist;
        var_7251d275fa3749fe = [];
        
        if ( perkarr && var_cebb6d333575f1ad )
        {
            foreach ( perk in perkarr )
            {
                if ( arraycontains( var_cebb6d333575f1ad, perk ) )
                {
                    var_7251d275fa3749fe[ var_7251d275fa3749fe.size ] = perk;
                }
            }
        }
        
        return var_7251d275fa3749fe;
    }

    // Namespace specialty_specialist_builder
    // Params 0
    // Checksum 0x69f282b1, Offset: 0x104a
    // Size: 0x2c, Type: dev
    function function_d944ddb66c174a0a()
    {
        if ( !isdefined( self.var_5be1a1edb84b223d ) )
        {
            return;
        }
        
        self.var_5be1a1edb84b223d destroy();
        self.var_5be1a1edb84b223d = undefined;
    }

    // Namespace specialty_specialist_builder
    // Params 1
    // Checksum 0x9d7e5905, Offset: 0x107e
    // Size: 0xbd, Type: dev
    function function_9970128b45efc7ef( playername )
    {
        if ( playername )
        {
            var_7237854e3be197ca = devgetplayerbyname( playername );
            
            if ( isdefined( var_7237854e3be197ca ) )
            {
                return var_7237854e3be197ca;
            }
        }
        
        foreach ( player in level.players )
        {
            if ( player && !isbot( player ) && !player isplayerheadless() )
            {
                return player;
            }
        }
    }

    // Namespace specialty_specialist_builder
    // Params 1
    // Checksum 0x32ec9ad6, Offset: 0x1143
    // Size: 0xad, Type: dev
    function devgetplayerbyname( playername )
    {
        playername = tolower( playername );
        
        foreach ( player in level.players )
        {
            shortname = strtok( playername, "<dev string:x1cd>" )[ 0 ];
            
            if ( tolower( shortname ) == playername )
            {
                return player;
            }
        }
    }

#/
