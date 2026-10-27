// script_44280f644740bac  (hash_044280f644740bac.gscc) (size: 2585 Bytes / 0xa19 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc943dcde (3376667870)
// size ...... 2585 (0xa19)
// includes .. 3   (offset: 0x961)
// strings ... 0   (offset: 0x979)
// dev strs .. 10  (offset: 0x979)
// exports ... 8   (offset: 0x5ed)
// cseg ...... 0x58 + 0x595 (0x5ed)
// imports ... 19  (offset: 0x72d)
// animtree1 . 0   (offset: 0xa19)
// animtree2 . 0   (offset: 0xa19)
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\gamelogic;

#namespace namespace_ec33f26de741e14e;

/#

    // Namespace namespace_ec33f26de741e14e
    // Params 0, eflags: 0x1
    // Checksum 0x43031e1b, Offset: 0x76
    // Size: 0x15, Type: dev
    function autoexec main()
    {
        thread commandwatcher( @"scr_mp" );
    }

    // Namespace namespace_ec33f26de741e14e
    // Params 1
    // Checksum 0x8582a4c9, Offset: 0x93
    // Size: 0xb7, Type: dev
    function function_5a52677cbdd3e5e5( categoryname )
    {
        utility::registersharedfunc( getxhash( categoryname ), #"hash_ed8804c722daecdb", &function_2edebc21eb304769 );
        utility::registersharedfunc( getxhash( categoryname ), #"registercommand", &registercommand );
        
        if ( !isdefined( level.var_6ee9e53b11ece9ae ) )
        {
            level.var_6ee9e53b11ece9ae = {};
        }
        
        if ( !isdefined( level.var_6ee9e53b11ece9ae.categories ) )
        {
            level.var_6ee9e53b11ece9ae.categories = [];
        }
        
        if ( !isdefined( level.var_6ee9e53b11ece9ae.categories[ categoryname ] ) )
        {
            level.var_6ee9e53b11ece9ae.categories[ categoryname ] = {};
        }
    }

    // Namespace namespace_ec33f26de741e14e
    // Params 1
    // Checksum 0x79e1e31a, Offset: 0x152
    // Size: 0x26, Type: dev
    function function_7fb3afaa98ee9eeb( categoryname )
    {
        return level.var_6ee9e53b11ece9ae.categories[ categoryname ];
    }

    // Namespace namespace_ec33f26de741e14e
    // Params 6
    // Checksum 0xe302a6ce, Offset: 0x180
    // Size: 0x12f, Type: dev
    function registercommand( name, categoryname, function, help, devguipath, var_b054babccc6dec6 )
    {
        if ( !isdefined( var_c97c1fa76d5f85fe ) )
        {
            var_c97c1fa76d5f85fe = "<dev string:x24>";
        }
        
        if ( !isdefined( var_b054babccc6dec6 ) )
        {
            var_b054babccc6dec6 = [];
        }
        
        category = function_7fb3afaa98ee9eeb( categoryname );
        
        if ( !isdefined( category.registeredcommands ) )
        {
            category.registeredcommands = [];
        }
        
        if ( isdefined( category.registeredcommands[ name ] ) )
        {
            newcommand = name + "<dev string:x25>" + function;
            existingcommand = name + "<dev string:x25>" + category.registeredcommands[ name ].function;
            assertmsg( "<dev string:x2e>" + newcommand + "<dev string:x58>" + existingcommand );
            return;
        }
        
        category.registeredcommands[ name ] = { #var_b054babccc6dec6:var_b054babccc6dec6, #help:help, #devguipath:devguipath, #function:function };
    }

    // Namespace namespace_ec33f26de741e14e
    // Params 2
    // Checksum 0xa4c241e4, Offset: 0x2b7
    // Size: 0x1b6, Type: dev
    function function_67acbc0c7e614803( devguiroot, categoryname )
    {
        wait 0.5;
        devgui::function_9082edeb5db93280( devguiroot + "<dev string:x5a>" );
        category = function_7fb3afaa98ee9eeb( categoryname );
        
        foreach ( name, commandentry in category.registeredcommands )
        {
            rawname = getxhashsourcename( name );
            path = commandentry.devguipath == "<dev string:x24>" ? "<dev string:x24>" : commandentry.devguipath + "<dev string:x5e>";
            var_456fbe1bbdc26c8c = path + rawname;
            args = "<dev string:x24>";
            
            foreach ( arg in commandentry.var_b054babccc6dec6 )
            {
                args = args + "<dev string:x60>" + arg;
            }
            
            devgui::add_devgui_command( var_456fbe1bbdc26c8c, "<dev string:x62>" + categoryname + "<dev string:x60>" + rawname + args );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_ec33f26de741e14e
    // Params 1, eflags: 0x4
    // Checksum 0xa8ce3e74, Offset: 0x475
    // Size: 0xbb, Type: dev
    function private commandwatcher( dvarname )
    {
        level notify( "<dev string:x6a>" + getxhashhexname( dvarname ) );
        level endon( "<dev string:x6a>" + getxhashhexname( dvarname ) );
        setdvar( dvarname, "<dev string:x24>" );
        
        while ( true )
        {
            waitframe();
            dvarvalue = getdvar( dvarname );
            
            if ( dvarvalue == "<dev string:x24>" )
            {
                continue;
            }
            
            setdvar( dvarname, "<dev string:x24>" );
            tokens = strtok( dvarvalue, "<dev string:x60>" );
            
            if ( !isdefined( tokens ) || tokens.size < 1 )
            {
                continue;
            }
            
            categoryname = tokens[ 0 ];
            level thread [[ utility::getsharedfunc( categoryname, #"hash_ed8804c722daecdb" ) ]]( tokens );
        }
    }

    // Namespace namespace_ec33f26de741e14e
    // Params 1, eflags: 0x4
    // Checksum 0xe4b95b4f, Offset: 0x538
    // Size: 0xb5, Type: dev
    function private function_2edebc21eb304769( args )
    {
        if ( args.size == 0 )
        {
            return;
        }
        
        categoryname = args[ 0 ];
        category = function_7fb3afaa98ee9eeb( categoryname );
        inputcommand = args[ 1 ];
        command = category.registeredcommands[ inputcommand ];
        
        if ( !isdefined( command.function ) )
        {
            assertmsg( "<dev string:x7a>" + inputcommand );
            return;
        }
        
        host = gamelogic_mp::gethostplayer();
        commandargs = utility::array_slice( args, 2 );
        [[ command.function ]]( host, commandargs );
    }

#/
