// scripts\common\dev.gsc  (hash_1cfb12d324ab2623.gscc) (size: 5202 Bytes / 0x1452 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc96359e4 (3378731492)
// size ...... 5202 (0x1452)
// includes .. 1   (offset: 0x1336)
// strings ... 0   (offset: 0x133e)
// dev strs .. 18  (offset: 0x133e)
// exports ... 8   (offset: 0xe16)
// cseg ...... 0x58 + 0xdbe (0xe16)
// imports ... 30  (offset: 0xf56)
// animtree1 . 0   (offset: 0x1452)
// animtree2 . 0   (offset: 0x1452)
#using scripts\common\utility;

#namespace dev;

/#

    // Namespace dev
    // Params 0
    // Checksum 0x4e73787, Offset: 0x76
    // Size: 0x13, Type: dev
    function init()
    {
        initdvars();
        initthreads();
    }

    // Namespace dev
    // Params 0, eflags: 0x4
    // Checksum 0x82973cb3, Offset: 0x91
    // Size: 0x47, Type: dev
    function private initdvars()
    {
        setdevdvarifuninitialized( @"hash_ebdec3f29783ea70", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_c744a130cac039c1", 0, 0, 1 );
        setdevdvarifuninitialized( @"hash_95b6f5a816be82ab", 1, 0.1, 10 );
    }

    // Namespace dev
    // Params 0, eflags: 0x4
    // Checksum 0x58aa8b65, Offset: 0xe0
    // Size: 0x13, Type: dev
    function private initthreads()
    {
        thread function_1ffa2eadb547d71();
        thread function_2ea8dfc791bc9ae2();
    }

    // Namespace dev
    // Params 0, eflags: 0x4
    // Checksum 0x5c48e261, Offset: 0xfb
    // Size: 0x9a2, Type: dev
    function private function_1ffa2eadb547d71()
    {
        white = ( 1, 1, 1 );
        red = ( 1, 0, 0 );
        green = ( 0, 1, 0 );
        blue = ( 0, 0, 1 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_ebdec3f29783ea70" ) > 0 )
            {
                script_models = getentarray( "<dev string:x26>", #classname );
                script_origins = getentarray( "<dev string:x33>", #classname );
                scriptmovercounts = spawnstruct();
                scriptmovercounts.scriptmodeltargets = [];
                scriptmovercounts.scriptmodelnoteworthy = [];
                scriptmovercounts.scriptmodelmisc = 0;
                scriptmovercounts.scriptorigintargets = [];
                scriptmovercounts.scriptoriginnoteworthy = [];
                scriptmovercounts.scriptoriginmisc = 0;
                
                foreach ( ent in script_models )
                {
                    line( ent.origin, ent.origin + anglestoforward( ent.angles ) * 10, red );
                    line( ent.origin, ent.origin + anglestoright( ent.angles ) * 10, green );
                    line( ent.origin, ent.origin + anglestoup( ent.angles ) * 10, blue );
                    
                    if ( isdefined( ent.targetname ) )
                    {
                        color = white;
                        alpha = 1;
                        scale = 1;
                        print3d( ent.origin, ent.targetname, color, alpha, scale );
                        originstring = "<dev string:x41>" + ent.origin[ 0 ] + "<dev string:x43>" + ent.origin[ 1 ] + "<dev string:x43>" + ent.origin[ 2 ] + "<dev string:x46>";
                        print3d( ent.origin + ( 0, 0, -20 ), originstring, color, alpha, scale );
                        
                        if ( isdefined( scriptmovercounts.scriptmodeltargets[ ent.targetname ] ) )
                        {
                            scriptmovercounts.scriptmodeltargets[ ent.targetname ] += 1;
                        }
                        else
                        {
                            scriptmovercounts.scriptmodeltargets[ ent.targetname ] = 1;
                        }
                        
                        continue;
                    }
                    
                    if ( isdefined( ent.script_noteworthy ) )
                    {
                        if ( isdefined( scriptmovercounts.scriptmodelnoteworthy[ ent.script_noteworthy ] ) )
                        {
                            scriptmovercounts.scriptmodelnoteworthy[ ent.script_noteworthy ] += 1;
                        }
                        else
                        {
                            scriptmovercounts.scriptmodelnoteworthy[ ent.script_noteworthy ] = 1;
                        }
                        
                        continue;
                    }
                    
                    scriptmovercounts.scriptmodelmisc += 1;
                }
                
                foreach ( ent in script_origins )
                {
                    line( ent.origin, ent.origin + anglestoforward( ent.angles ) * 10, red );
                    line( ent.origin, ent.origin + anglestoright( ent.angles ) * 10, green );
                    line( ent.origin, ent.origin + anglestoup( ent.angles ) * 10, blue );
                    
                    if ( isdefined( ent.targetname ) )
                    {
                        color = white;
                        alpha = 1;
                        scale = 1;
                        
                        switch ( ent.targetname )
                        {
                            case #"hash_b1841f3499756c6a":
                                color = red;
                                scale = 3;
                                break;
                            case #"hash_18b8d1ddd9bd830d":
                            case #"hash_c7f2713f8146c2fe":
                                color = green;
                                scale = 3;
                                break;
                        }
                        
                        print3d( ent.origin, ent.targetname, color, alpha, scale );
                        originstring = "<dev string:x41>" + ent.origin[ 0 ] + "<dev string:x43>" + ent.origin[ 1 ] + "<dev string:x43>" + ent.origin[ 2 ] + "<dev string:x46>";
                        print3d( ent.origin + ( 0, 0, -20 ), originstring, color, alpha, scale );
                        
                        if ( isdefined( scriptmovercounts.scriptorigintargets[ ent.targetname ] ) )
                        {
                            scriptmovercounts.scriptorigintargets[ ent.targetname ] += 1;
                        }
                        else
                        {
                            scriptmovercounts.scriptorigintargets[ ent.targetname ] = 1;
                        }
                        
                        continue;
                    }
                    
                    if ( isdefined( ent.script_noteworthy ) )
                    {
                        if ( isdefined( scriptmovercounts.scriptoriginnoteworthy[ ent.script_noteworthy ] ) )
                        {
                            scriptmovercounts.scriptoriginnoteworthy[ ent.script_noteworthy ] += 1;
                        }
                        else
                        {
                            scriptmovercounts.scriptoriginnoteworthy[ ent.script_noteworthy ] = 1;
                        }
                        
                        continue;
                    }
                    
                    scriptmovercounts.scriptoriginmisc += 1;
                }
                
                screenposx = 400;
                screenposy = 50;
                screenposyspacing = 15;
                printtoscreen2d( screenposx, screenposy, "<dev string:x6e>" );
                screenposy += screenposyspacing;
                printtoscreen2d( screenposx, screenposy, "<dev string:x89>" );
                screenposy += screenposyspacing;
                printtoscreen2d( screenposx, screenposy, "<dev string:x98>" + scriptmovercounts.scriptmodelmisc );
                screenposy += screenposyspacing;
                printtoscreen2d( screenposx, screenposy, "<dev string:xa8>" );
                screenposy += screenposyspacing;
                
                foreach ( targetname, targetcount in scriptmovercounts.scriptmodeltargets )
                {
                    printtoscreen2d( screenposx, screenposy, targetname + "<dev string:xb0>" + targetcount );
                    screenposy += screenposyspacing;
                }
                
                printtoscreen2d( screenposx, screenposy, "<dev string:xb3>" );
                screenposy += screenposyspacing;
                
                foreach ( noteworthyname, noteworthycount in scriptmovercounts.scriptmodelnoteworthy )
                {
                    printtoscreen2d( screenposx, screenposy, noteworthyname + "<dev string:xb0>" + noteworthycount );
                    screenposy += screenposyspacing;
                }
                
                printtoscreen2d( screenposx, screenposy, "<dev string:xbf>" );
                screenposy += screenposyspacing;
                printtoscreen2d( screenposx, screenposy, "<dev string:x98>" + scriptmovercounts.scriptoriginmisc );
                screenposy += screenposyspacing;
                printtoscreen2d( screenposx, screenposy, "<dev string:xa8>" );
                screenposy += screenposyspacing;
                
                foreach ( targetname, targetcount in scriptmovercounts.scriptorigintargets )
                {
                    printtoscreen2d( screenposx, screenposy, targetname + "<dev string:xb0>" + targetcount );
                    screenposy += screenposyspacing;
                }
                
                printtoscreen2d( screenposx, screenposy, "<dev string:xb3>" );
                screenposy += screenposyspacing;
                
                foreach ( noteworthyname, noteworthycount in scriptmovercounts.scriptoriginnoteworthy )
                {
                    printtoscreen2d( screenposx, screenposy, noteworthyname + "<dev string:xb0>" + noteworthycount );
                    screenposy += screenposyspacing;
                }
            }
            
            wait 0.05;
        }
    }

    // Namespace dev
    // Params 2
    // Checksum 0xa70b9b34, Offset: 0xaa5
    // Size: 0xaa, Type: dev
    function devcommandwatcher( dvarname, commandhandlerfunc )
    {
        setdevdvar( dvarname, "<dev string:xcf>" );
        
        while ( true )
        {
            waitframe();
            dvarvalue = getdvar( dvarname );
            
            if ( dvarvalue == "<dev string:xcf>" )
            {
                continue;
            }
            
            setdevdvar( dvarname, "<dev string:xcf>" );
            tokens = strtok( dvarvalue, "<dev string:xd0>" );
            
            if ( !isdefined( tokens ) || tokens.size < 1 )
            {
                continue;
            }
            
            command = tokens[ 0 ];
            arglist = utility::array_slice( tokens, 1 );
            [[ commandhandlerfunc ]]( command, arglist );
        }
    }

    // Namespace dev
    // Params 0
    // Checksum 0x4ba7fc09, Offset: 0xb57
    // Size: 0x202, Type: dev
    function function_2ea8dfc791bc9ae2()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_c744a130cac039c1", 0 ) > 0 )
            {
                ai = getaiarray();
                scale = getdvarfloat( @"hash_95b6f5a816be82ab", 1 );
                
                if ( level.ismp )
                {
                    players = level.players;
                    
                    foreach ( player in players )
                    {
                        if ( player == level.player )
                        {
                            continue;
                        }
                        
                        if ( isalive( player ) )
                        {
                            if ( isdefined( player.operatorcustomization ) )
                            {
                                operator = getxhashsourcename( player.operatorcustomization.operatorref );
                                geartext = "<dev string:xd2>" + player getgeartype();
                                clothtext = "<dev string:xd9>" + player getclothtype();
                                player function_7cd2f6e3611cd389( operator, geartext, clothtext, scale );
                            }
                        }
                    }
                }
                
                foreach ( player in ai )
                {
                    operator = player.classname;
                    operator = removesubstr( operator, "<dev string:xe1>" );
                    geartext = "<dev string:xd2>" + player getgeartype();
                    clothtext = "<dev string:xd9>" + player getclothtype();
                    player function_7cd2f6e3611cd389( operator, geartext, clothtext, scale );
                }
            }
            
            wait 0.5;
        }
    }

    // Namespace dev
    // Params 4
    // Checksum 0xf115f68a, Offset: 0xd61
    // Size: 0xb5, Type: dev
    function function_7cd2f6e3611cd389( operator, geartext, clothtext, scale )
    {
        print3d( self.origin, geartext, ( 0, 1, 0 ), 1, scale, 30, 1 );
        print3d( self.origin + ( 0, 0, 30 ), clothtext, ( 0, 1, 0 ), 1, scale, 30, 1 );
        print3d( self.origin + ( 0, 0, 60 ), operator, ( 0, 1, 0 ), 1, scale, 30, 1 );
    }

#/
