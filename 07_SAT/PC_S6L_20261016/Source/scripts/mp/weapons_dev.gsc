// scripts\mp\weapons_dev.gsc  (hash_312b852644cff709.gscc) (size: 18924 Bytes / 0x49ec / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2559f3c1 (626652097)
// size ...... 18924 (0x49ec)
// includes .. 6   (offset: 0x44ec)
// strings ... 2   (offset: 0x451c)
// dev strs .. 84  (offset: 0x454c)
// exports ... 39  (offset: 0x2e40)
// cseg ...... 0x64 + 0x2ddc (0x2e40)
// imports ... 130 (offset: 0x3458)
// animtree1 . 0   (offset: 0x49ec)
// animtree2 . 0   (offset: 0x49ec)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\inventory_utility;

#namespace weapons_dev;

// Namespace weapons_dev
// Params 0
// Checksum 0x994efdc7, Offset: 0x82
// Size: 0x10a
function weapdev_init()
{
    if ( getbuildversion() != "SHIP" )
    {
        thread function_53c9fec4685894a8();
        setdvar( @"scr_giveweaponblueprintname", "" );
    }
    
    /#
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        if ( !isdefined( level.weapdev ) )
        {
            level.weapdev = spawnstruct();
        }
        
        thread weapdev_devgui_init();
        thread function_edc16b21cfd6ebd4();
        thread function_e497e457bfd53f9f();
        thread function_5007e34ad8f974e6();
        thread function_b7c56b4b095c7afa();
        level callback::add( #"player_connect", &weapdev_on_player_connect );
        level callback::add( #"player_disconnect", &weapdev_on_player_disconnect );
        level callback::add( #"player_weapon_change", &function_ae91286911ea949c );
        level callback::add( #"player_spawned", &weapdev_on_player_spawned );
        setdevdvar( @"hash_eab5f19fea65c5c2", "<dev string:x24>" );
        setdevdvar( @"hash_a1c77cb5b109ab77", "<dev string:x24>" );
        setdevdvar( @"hash_19234cfdaa9d6a8b", 0 );
    #/
}

// Namespace weapons_dev
// Params 0
// Checksum 0xd5731a4e, Offset: 0x194
// Size: 0x35
function function_53c9fec4685894a8()
{
    if ( getbuildversion() != "SHIP" )
    {
        for ( ;; )
        {
            if ( getdvar( @"scr_giveweaponblueprintname", "" ) != "" )
            {
                thread gui_giveweaponblueprintname();
            }
            
            waitframe();
        }
    }
}

// Namespace weapons_dev
// Params 0
// Checksum 0x16a4173c, Offset: 0x1d1
// Size: 0x1d2
function gui_giveweaponblueprintname()
{
    if ( getbuildversion() != "SHIP" )
    {
        blueprintname = getdvar( @"scr_giveweaponblueprintname" );
        weapon = weapon::getweaponrootname( blueprintname );
        weaponasset = undefined;
        
        if ( isdefined( level.weaponmapdata[ weapon ] ) )
        {
            weaponasset = level.weaponmapdata[ weapon ].assetname;
        }
        
        weaponblueprint = getxhashasset( blueprintname );
        
        if ( isdefined( weaponasset ) && isdefined( weaponblueprint ) )
        {
            foreach ( player in level.players )
            {
                var_dd2db255da3902ac = weapon::giveweaponblueprint( weaponasset, weaponblueprint );
                currentweapon = player.currentweapon;
                player.droppeddeathweapon = undefined;
                
                if ( utility::issharedfuncdefined( #"weapons", #"dropweaponfordeath" ) )
                {
                    player thread [[ utility::getsharedfunc( #"weapons", #"dropweaponfordeath" ) ]]( undefined, "" );
                }
                
                player.droppeddeathweapon = undefined;
                
                if ( player hasweapon( var_dd2db255da3902ac ) )
                {
                    player inventory_utility::_takeweapon( var_dd2db255da3902ac );
                }
                
                player giveweapon( var_dd2db255da3902ac );
                player setweaponammoclip( var_dd2db255da3902ac, weaponclipsize( var_dd2db255da3902ac ) );
                player setweaponammostock( var_dd2db255da3902ac, weaponmaxammo( var_dd2db255da3902ac ) );
                player inventory_utility::_switchtoweaponimmediate( var_dd2db255da3902ac );
                weapon::fixupplayerweapons( player, weapon );
            }
        }
        
        setdvar( @"scr_giveweaponblueprintname", "" );
    }
}

/#

    // Namespace weapons_dev
    // Params 1
    // Checksum 0x144cd49a, Offset: 0x3ab
    // Size: 0x14a, Type: dev
    function function_3fed1b5a7249c0ef( group )
    {
        class = undefined;
        
        if ( isdefined( group ) )
        {
            class = "<dev string:x25>";
            
            switch ( group )
            {
                case #"hash_8af0086b038622b5":
                    class = "<dev string:x39>";
                    break;
                case #"hash_dd616da0b395a0b0":
                    class = "<dev string:x55>";
                    break;
                case #"hash_47368bc0d2ef1565":
                    class = "<dev string:x6d>";
                    break;
                case #"hash_bef5ec0b3e197ae":
                    class = "<dev string:x7c>";
                    break;
                case #"hash_86b11ac21f992552":
                case #"hash_a1f27f97be15d620":
                    class = "<dev string:x9b>";
                    break;
                case #"hash_34340d457a63e7f1":
                    class = "<dev string:xaf>";
                    break;
                case #"hash_9d18adab1b65a661":
                    class = "<dev string:xc8>";
                    break;
                case #"hash_16cf6289ab06bd30":
                    class = "<dev string:xe0>";
                    break;
                case #"hash_ab10f9c080fe4faf":
                    class = "<dev string:xf3>";
                    break;
                case #"hash_c095d67337b1f5a1":
                    class = "<dev string:x105>";
                    break;
                case #"hash_2535634d8bb5c955":
                    class = "<dev string:x11a>";
                    break;
                case #"hash_cd7f87dc1cdeaa54":
                    class = "<dev string:x13a>";
                    break;
            }
        }
        
        return class;
    }

    // Namespace weapons_dev
    // Params 0
    // Checksum 0xfdf88ed0, Offset: 0x4fd
    // Size: 0x2ab, Type: dev
    function weapdev_devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x142>" + "<dev string:x150>" );
        sorted_weapons = arraysort( getarraykeys( level.weaponmapdata ), undefined, undefined, 0, undefined, 1 );
        
        for ( i = 0; i < sorted_weapons.size ; i++ )
        {
            data = level.weaponmapdata[ sorted_weapons[ i ] ];
            weaponclass = function_3fed1b5a7249c0ef( data.group );
            
            if ( isdefined( weaponclass ) )
            {
                devgui::add_devgui_command( weaponclass + "<dev string:x15f>" + data.assetname, "<dev string:x161>" + data.assetname );
                continue;
            }
            
            devgui::add_devgui_command( "<dev string:x196>" + data.assetname, "<dev string:x161>" + data.assetname );
        }
        
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x142>" + "<dev string:x1a5>" );
        
        for ( i = 0; i < sorted_weapons.size ; i++ )
        {
            data = level.weaponmapdata[ sorted_weapons[ i ] ];
            weaponclass = function_3fed1b5a7249c0ef( data.group );
            
            if ( !isdefined( weaponclass ) )
            {
                continue;
            }
            
            blueprints = getweaponblueprintnames( data.assetname );
            
            foreach ( entry, index in blueprints )
            {
                var_e3763051b410419c = getxhashsourcename( entry );
                devgui::add_devgui_command( weaponclass + "<dev string:x15f>" + data.assetname + "<dev string:x15f>" + var_e3763051b410419c, "<dev string:x1be>" + var_e3763051b410419c );
            }
        }
        
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x142>" + "<dev string:x1e2>" );
        devgui::add_devgui_command( "<dev string:x1f3>", "<dev string:x207>" );
        devgui::add_devgui_command( "<dev string:x22b>", "<dev string:x246>" );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x142>" );
        devgui::add_devgui_command( "<dev string:x270>", "<dev string:x288>", 7 );
        devgui::add_devgui_command( "<dev string:x2a9>", "<dev string:x2c4>", 8 );
        devgui::add_devgui_command( "<dev string:x2e1>", "<dev string:x2f8>", 9 );
        devgui::add_devgui_command( "<dev string:x31f>", "<dev string:x337>", 3 );
        devgui::add_devgui_command( "<dev string:x37a>", "<dev string:x392>", 4 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace weapons_dev
    // Params 5
    // Checksum 0xee4cb315, Offset: 0x7b0
    // Size: 0xe0, Type: dev
    function function_156bc0617974c0( dvar, defaultvalue, func, isthreaded, unarchived )
    {
        if ( !isdefined( level.weapdev.dvars ) )
        {
            level.weapdev.dvars = [];
        }
        
        setdvarifuninitialized( dvar, defaultvalue );
        struct = spawnstruct();
        struct.func = func;
        struct.dvar = dvar;
        struct.defaultvalue = defaultvalue;
        
        if ( isdefined( isthreaded ) )
        {
            struct.threaded = isthreaded;
        }
        
        if ( isdefined( unarchived ) )
        {
            struct.unarchived = unarchived;
        }
        
        level.weapdev.dvars[ dvar ] = struct;
    }

    // Namespace weapons_dev
    // Params 0
    // Checksum 0xb5caaaa3, Offset: 0x898
    // Size: 0x130, Type: dev
    function function_93a456a1c453c3c6()
    {
        if ( !isdefined( level.weapdev.dvars ) )
        {
            return;
        }
        
        for ( ;; )
        {
            foreach ( dvarstr, data in level.weapdev.dvars )
            {
                dvarval = undefined;
                
                if ( isdefined( data.unarchived ) )
                {
                    dvarval = getunarchiveddebugdvar( dvarstr );
                }
                else
                {
                    dvarval = getdvar( dvarstr );
                }
                
                if ( !isdefined( dvarval ) )
                {
                    continue;
                }
                
                if ( dvarval == data.defaultvalue )
                {
                    continue;
                }
                
                if ( isdefined( data.threaded ) )
                {
                    thread [[ data.func ]]( dvarval );
                }
                else
                {
                    [[ data.func ]]( dvarval );
                }
                
                setdvar( dvarstr, data.defaultvalue );
            }
            
            wait 0.2;
        }
    }

    // Namespace weapons_dev
    // Params 0
    // Checksum 0x4def5738, Offset: 0x9d0
    // Size: 0xec, Type: dev
    function function_edc16b21cfd6ebd4()
    {
        function_156bc0617974c0( @"hash_5a6ac095cce29d6a", "<dev string:x3b1>", &function_58d113b62185c59f, 0, 0 );
        function_156bc0617974c0( @"hash_b8fb8e495524a25c", "<dev string:x3b3>", &function_53427573125f0445, 0, 0 );
        function_156bc0617974c0( @"hash_5d287f84a6f89b43", "<dev string:x3b3>", &function_cb8b365f038e66ac, 0, 0 );
        function_156bc0617974c0( @"hash_61d2d8e5a629ef89", "<dev string:x3b1>", &function_b94d6f4bbb849350, 0, 0 );
        function_156bc0617974c0( @"hash_dba288284435008a", "<dev string:x3b1>", &function_1d66de57a6d2a6ed, 0, 0 );
        function_156bc0617974c0( @"hash_b72466ac81416f5a", "<dev string:x3b1>", &function_77396855a5d69ccd, 0, 0 );
        function_156bc0617974c0( @"weapdev_give_weapon", "<dev string:x24>", &function_a17738bafec31f2a, 0, 0 );
        function_156bc0617974c0( @"hash_c2957735560e95b2", "<dev string:x24>", &function_73fcc7f0bf876477, 0, 0 );
        thread function_93a456a1c453c3c6();
    }

    // Namespace weapons_dev
    // Params 1
    // Checksum 0xce375162, Offset: 0xac4
    // Size: 0x175, Type: dev
    function function_a17738bafec31f2a( weaponname )
    {
        weapnew = weaponname;
        variant = -1;
        toks = strtok( weaponname, "<dev string:x3b6>" );
        
        if ( toks.size > 1 )
        {
            weapnew = toks[ 0 ];
            variant = int( toks[ 1 ] );
        }
        
        if ( isdefined( weapnew ) )
        {
            var_f9d549c3e76fc2cc = weapon::getweaponrootname( weapnew );
            playerarray = function_4bf8fbed95838f12();
            
            foreach ( player in playerarray )
            {
                hasnvg = istrue( level.nightmap );
                var_dd2db255da3902ac = weapon::buildweapon( var_f9d549c3e76fc2cc, undefined, undefined, undefined, variant, undefined, undefined, undefined, hasnvg );
                
                if ( utility::issharedfuncdefined( #"dev", #"spawnweapon" ) )
                {
                    player [[ utility::getsharedfunc( #"dev", #"spawnweapon" ) ]]( var_dd2db255da3902ac, 1, undefined );
                    continue;
                }
                
                currentweapon = player.currentweapon;
                player function_a56eb9ae7659b798( currentweapon, var_dd2db255da3902ac, 0 );
            }
        }
    }

    // Namespace weapons_dev
    // Params 1
    // Checksum 0xd00b675e, Offset: 0xc41
    // Size: 0x21e, Type: dev
    function function_73fcc7f0bf876477( val )
    {
        if ( isdefined( val ) )
        {
            params = strtok( val, "<dev string:x3b8>" );
            weaponobj = undefined;
            attachmentname = undefined;
            
            if ( params.size > 1 )
            {
                var_f9d549c3e76fc2cc = weapon::getweaponrootname( params[ 0 ] );
                hasnvg = istrue( level.nightmap );
                weaponobj = weapon::buildweapon( var_f9d549c3e76fc2cc, undefined, undefined, undefined, undefined, undefined, undefined, undefined, hasnvg );
                attachmentname = params[ 1 ];
            }
            else
            {
                attachmentname = params[ 0 ];
            }
            
            if ( isdefined( attachmentname ) )
            {
                playerarray = function_4bf8fbed95838f12();
                
                foreach ( player in playerarray )
                {
                    currentweapon = player.currentweapon;
                    
                    if ( isdefined( currentweapon ) )
                    {
                        if ( !isdefined( weaponobj ) )
                        {
                            weaponobj = currentweapon;
                        }
                        else if ( currentweapon.var_1616e6fbba9a722d == weaponobj.var_1616e6fbba9a722d )
                        {
                            weaponobj = currentweapon;
                        }
                    }
                    
                    if ( !isdefined( weaponobj ) )
                    {
                        if ( !isbot( player ) )
                        {
                            player iprintlnbold( "<dev string:x3ba>" );
                        }
                        
                        continue;
                    }
                    
                    var_dd2db255da3902ac = function_198e4dddd15424e7( weaponobj, attachmentname );
                    
                    if ( !isdefined( var_dd2db255da3902ac ) )
                    {
                        if ( !isbot( player ) )
                        {
                            player iprintlnbold( "<dev string:x3d1>" + attachmentname + "<dev string:x3e6>" + weaponobj.basename + "<dev string:x3f5>" );
                        }
                        
                        continue;
                    }
                    
                    if ( utility::issharedfuncdefined( #"dev", #"spawnweapon" ) )
                    {
                        player [[ utility::getsharedfunc( #"dev", #"spawnweapon" ) ]]( var_dd2db255da3902ac, 1, undefined );
                        continue;
                    }
                    
                    player function_a56eb9ae7659b798( currentweapon, var_dd2db255da3902ac, 1 );
                }
                
                return;
            }
            
            iprintlnbold( "<dev string:x3f8>" );
        }
    }

    // Namespace weapons_dev
    // Params 2
    // Checksum 0xe9fc37d1, Offset: 0xe67
    // Size: 0x315, Type: dev
    function function_198e4dddd15424e7( weaponobj, attachmentname )
    {
        var_b864fe801fd30f7a = weaponobj getnoaltweapon();
        attachmenttoidmap = var_b864fe801fd30f7a.attachmentvarindices;
        attachments = [];
        
        foreach ( attachment, id in attachmenttoidmap )
        {
            attachments[ attachments.size ] = attachment;
        }
        
        failed = !var_b864fe801fd30f7a canuseattachment( attachmentname );
        
        if ( failed )
        {
            return;
        }
        
        attachments = weapon::weaponattachremoveextraattachments( attachments );
        var_c84cf1d3502a1321 = [];
        
        foreach ( idx, attachment in attachments )
        {
            var_c84cf1d3502a1321[ idx ] = attachmenttoidmap[ attachment ];
        }
        
        camo = var_b864fe801fd30f7a.camo;
        stickers = [];
        
        if ( isdefined( var_b864fe801fd30f7a.stickerslot0 ) )
        {
            stickers[ stickers.size ] = var_b864fe801fd30f7a.stickerslot0;
        }
        
        if ( isdefined( var_b864fe801fd30f7a.stickerslot1 ) )
        {
            stickers[ stickers.size ] = var_b864fe801fd30f7a.stickerslot1;
        }
        
        if ( isdefined( var_b864fe801fd30f7a.stickerslot2 ) )
        {
            stickers[ stickers.size ] = var_b864fe801fd30f7a.stickerslot2;
        }
        
        if ( isdefined( var_b864fe801fd30f7a.stickerslot3 ) )
        {
            stickers[ stickers.size ] = var_b864fe801fd30f7a.stickerslot3;
        }
        
        if ( isdefined( var_b864fe801fd30f7a.var_73762c7cb8b2063 ) )
        {
            stickers[ stickers.size ] = var_b864fe801fd30f7a.var_73762c7cb8b2063;
        }
        
        hasnvg = istrue( level.nightmap );
        attachment1slot = getattachmentslot( var_b864fe801fd30f7a, attachmentname );
        replaced = 0;
        
        foreach ( idx, a in attachments )
        {
            attachment2slot = getattachmentslot( var_b864fe801fd30f7a, attachments[ idx ] );
            
            if ( attachment1slot == attachment2slot )
            {
                attachments[ idx ] = attachmentname;
                var_c84cf1d3502a1321[ idx ] = 0;
                replaced = 1;
            }
        }
        
        if ( !replaced )
        {
            attachments[ attachments.size ] = attachmentname;
            var_c84cf1d3502a1321[ var_c84cf1d3502a1321.size ] = 0;
        }
        
        variantid = getweaponvariantindex( weaponobj );
        var_2b8dd15b4fd235fa = weapon::buildweapon( weapon::getweaponrootname( weaponobj ), attachments, camo, "<dev string:x40c>", variantid, var_c84cf1d3502a1321, undefined, stickers, hasnvg );
        return var_2b8dd15b4fd235fa;
    }

    // Namespace weapons_dev
    // Params 3
    // Checksum 0xb872f30d, Offset: 0x1184
    // Size: 0x11a, Type: dev
    function function_a56eb9ae7659b798( currentweapon, var_dd2db255da3902ac, giveammo )
    {
        player = self;
        
        if ( player hasweapon( var_dd2db255da3902ac ) )
        {
            player takeweapon( var_dd2db255da3902ac );
        }
        else if ( isdefined( currentweapon ) )
        {
            if ( utility::issharedfuncdefined( #"weapons", #"dropweaponfordeath" ) )
            {
                player.droppeddeathweapon = undefined;
                player thread [[ utility::getsharedfunc( #"weapons", #"dropweaponfordeath" ) ]]( undefined, "<dev string:x24>" );
                player.droppeddeathweapon = undefined;
            }
            else
            {
                player dropitem( currentweapon );
            }
        }
        
        player inventory_utility::_giveweapon( var_dd2db255da3902ac );
        
        if ( giveammo )
        {
            player setweaponammoclip( var_dd2db255da3902ac, weaponclipsize( var_dd2db255da3902ac ) );
            player setweaponammostock( var_dd2db255da3902ac, weaponmaxammo( var_dd2db255da3902ac ) );
        }
        
        if ( level.tertiaryweaponslotenabled && var_dd2db255da3902ac.ismelee && var_dd2db255da3902ac != level.defaultfist )
        {
            player assignweaponmeleeslot( var_dd2db255da3902ac );
        }
        
        player inventory_utility::_switchtoweaponimmediate( var_dd2db255da3902ac );
        weapon::fixupplayerweapons( player, var_dd2db255da3902ac );
    }

    // Namespace weapons_dev
    // Params 1
    // Checksum 0xfeb49ebc, Offset: 0x12a6
    // Size: 0x48, Type: dev
    function function_58d113b62185c59f( entnum )
    {
        host = function_7b72be42471b5133();
        target = host function_b8745e837d180bbd();
        
        if ( !isdefined( target ) )
        {
            return;
        }
        
        function_53427573125f0445( target getentitynumber() );
    }

    // Namespace weapons_dev
    // Params 1
    // Checksum 0x439d8812, Offset: 0x12f6
    // Size: 0xc7, Type: dev
    function function_53427573125f0445( entnum )
    {
        entnum = int( entnum );
        
        if ( !isdefined( level.players[ entnum ] ) )
        {
            iprintln( "<dev string:x411>" );
            return;
        }
        
        level.weapdev.var_ceefa46f8106bbca = spawnstruct();
        level.weapdev.var_ceefa46f8106bbca.entnum = entnum;
        level.weapdev.var_ceefa46f8106bbca.ent = level.players[ entnum ];
        iprintln( "<dev string:x428>" + level.weapdev.var_ceefa46f8106bbca.ent.name );
    }

    // Namespace weapons_dev
    // Params 1
    // Checksum 0x8c47c44e, Offset: 0x13c5
    // Size: 0x79, Type: dev
    function function_cb8b365f038e66ac( entnum )
    {
        entnum = int( entnum );
        level.weapdev.var_243b9e172963f2f0 = spawnstruct();
        level.weapdev.var_243b9e172963f2f0.entnum = entnum;
        level.weapdev.var_243b9e172963f2f0.ent = level.players[ entnum ];
    }

    // Namespace weapons_dev
    // Params 1
    // Checksum 0xe0fd793c, Offset: 0x1446
    // Size: 0x2c, Type: dev
    function function_b94d6f4bbb849350( dummy )
    {
        level.weapdev.var_ceefa46f8106bbca = undefined;
        iprintln( "<dev string:x438>" );
    }

    // Namespace weapons_dev
    // Params 1
    // Checksum 0xde0b92d8, Offset: 0x147a
    // Size: 0x64, Type: dev
    function function_1d66de57a6d2a6ed( dummy )
    {
        level.weapdev.var_6792629e6cc7466 = !level.weapdev.var_6792629e6cc7466;
        
        if ( level.weapdev.var_6792629e6cc7466 )
        {
            iprintln( "<dev string:x44f>" );
            return;
        }
        
        iprintln( "<dev string:x4a3>" );
    }

    // Namespace weapons_dev
    // Params 1
    // Checksum 0x561985e3, Offset: 0x14e6
    // Size: 0x64, Type: dev
    function function_77396855a5d69ccd( dummy )
    {
        level.weapdev.var_6c6c8577d1e758a5 = !level.weapdev.var_6c6c8577d1e758a5;
        
        if ( level.weapdev.var_6c6c8577d1e758a5 )
        {
            iprintln( "<dev string:x4c4>" );
            return;
        }
        
        iprintln( "<dev string:x50c>" );
    }

    // Namespace weapons_dev
    // Params 0
    // Checksum 0xa69ed1be, Offset: 0x1552
    // Size: 0x164, Type: dev
    function function_4bf8fbed95838f12()
    {
        if ( level.weapdev.var_6c6c8577d1e758a5 )
        {
            return level.players;
        }
        
        if ( isdefined( level.weapdev.var_243b9e172963f2f0 ) && isdefined( level.weapdev.var_243b9e172963f2f0.ent ) )
        {
            players = [ level.weapdev.var_243b9e172963f2f0.ent ];
            level.weapdev.var_243b9e172963f2f0 = undefined;
            return players;
        }
        
        if ( isdefined( level.weapdev.var_ceefa46f8106bbca ) && isdefined( level.weapdev.var_ceefa46f8106bbca.ent ) )
        {
            players = [ level.weapdev.var_ceefa46f8106bbca.ent ];
            return players;
        }
        
        if ( getdvarint( @"hash_13d8008e8edc58d5", -1 ) != -1 )
        {
            entnum = int( getdvar( @"hash_13d8008e8edc58d5" ) );
            setdvar( @"hash_13d8008e8edc58d5", "<dev string:x3b3>" );
            return [ utility::function_3bc2c606a1c39e2f( entnum ) ];
        }
        
        return level.players;
    }

    // Namespace weapons_dev
    // Params 0
    // Checksum 0xda3612ac, Offset: 0x16be
    // Size: 0x9d, Type: dev
    function function_7b72be42471b5133()
    {
        hostplayer = level.players[ 0 ];
        
        foreach ( player in level.players )
        {
            if ( player ishost() )
            {
                hostplayer = player;
                break;
            }
        }
        
        return hostplayer;
    }

    // Namespace weapons_dev
    // Params 0
    // Checksum 0x5234e111, Offset: 0x1763
    // Size: 0xa8, Type: dev
    function function_b8745e837d180bbd()
    {
        startpos = self geteye();
        viewangles = self getplayerangles();
        fwd = anglestoforward( viewangles );
        endpos = startpos + fwd * 10000;
        playercontent = [ "<dev string:x52d>" ];
        var_e1c801cb433b89d0 = physics_createcontents( playercontent );
        playertrace = trace::sphere_trace( startpos, endpos, 5, self, var_e1c801cb433b89d0, 0 );
        traceent = playertrace[ "<dev string:x54c>" ];
        
        if ( isplayer( traceent ) )
        {
            return traceent;
        }
        
        return;
    }

    // Namespace weapons_dev
    // Params 1
    // Checksum 0xd6453c37, Offset: 0x1813
    // Size: 0xf, Type: dev
    function weapdev_on_player_connect( params )
    {
        
    }

    // Namespace weapons_dev
    // Params 1
    // Checksum 0x12a9b7a5, Offset: 0x182a
    // Size: 0x2c, Type: dev
    function weapdev_on_player_spawned( params )
    {
        if ( level.weapdev.var_6792629e6cc7466 )
        {
            thread function_723a97c59eb1c766();
        }
    }

    // Namespace weapons_dev
    // Params 0
    // Checksum 0x21a0b4ea, Offset: 0x185e
    // Size: 0x13b, Type: dev
    function function_723a97c59eb1c766()
    {
        player = self;
        player utility::waittill_any_timeout( 1, "<dev string:x553>" );
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        if ( !isalive( player ) )
        {
            return;
        }
        
        if ( isdefined( level.weapdev ) )
        {
            if ( isdefined( level.weapdev.players ) )
            {
                entnum = self getentitynumber();
                
                if ( isdefined( level.weapdev.players[ entnum ] ) )
                {
                    if ( isdefined( level.weapdev.players[ entnum ].spawnweapon ) )
                    {
                        if ( utility::issharedfuncdefined( #"dev", #"spawnweapon" ) )
                        {
                            player [[ utility::getsharedfunc( #"dev", #"spawnweapon" ) ]]( level.weapdev.players[ entnum ].spawnweapon, 1, undefined );
                            return;
                        }
                        
                        player function_a56eb9ae7659b798( self.currentweapon, level.weapdev.players[ entnum ].spawnweapon, 1 );
                    }
                }
            }
        }
    }

    // Namespace weapons_dev
    // Params 1
    // Checksum 0xff052f22, Offset: 0x19a1
    // Size: 0x18, Type: dev
    function weapdev_on_player_disconnect( params )
    {
        function_8cd7608c8e337615( params );
    }

    // Namespace weapons_dev
    // Params 1
    // Checksum 0xdaeabbe, Offset: 0x19c1
    // Size: 0x18, Type: dev
    function function_ae91286911ea949c( params )
    {
        function_8cd7608c8e337615( params );
    }

    // Namespace weapons_dev
    // Params 1
    // Checksum 0x308766d0, Offset: 0x19e1
    // Size: 0x7f7, Type: dev
    function function_8cd7608c8e337615( params )
    {
        player = self;
        entnum = player getentitynumber();
        
        if ( !isdefined( level.weapdev.players ) )
        {
            level.weapdev.players = [];
        }
        
        if ( entnum != 0 )
        {
            return;
        }
        
        totalbots = 0;
        totalplayers = 0;
        
        foreach ( idx, devplayer in level.weapdev.players )
        {
            var_fa3cf494395ea9e5 = level.players[ idx ];
            
            if ( entnum != idx )
            {
                if ( isbot( var_fa3cf494395ea9e5 ) )
                {
                    totalbots++;
                }
                
                totalplayers++;
            }
        }
        
        if ( totalbots > 2 || totalplayers > 5 )
        {
            return;
        }
        
        var_d3f1f0f9cfae0fc8 = undefined;
        spawnweapon = undefined;
        
        if ( isdefined( level.weapdev.players[ entnum ] ) )
        {
            if ( isdefined( level.weapdev.players[ entnum ].var_dc909bd2150544fd ) )
            {
                var_d3f1f0f9cfae0fc8 = level.weapdev.players[ entnum ].var_dc909bd2150544fd;
            }
            
            if ( isdefined( level.weapdev.players[ entnum ].spawnweapon ) )
            {
                spawnweapon = level.weapdev.players[ entnum ].spawnweapon;
            }
        }
        
        if ( !isdefined( player ) || player.isdisconnecting )
        {
            level.weapdev.players[ entnum ] = undefined;
            
            if ( isdefined( var_d3f1f0f9cfae0fc8 ) )
            {
                pathtoremove = "<dev string:x142>" + "<dev string:x56a>" + var_d3f1f0f9cfae0fc8;
                cmd = "<dev string:x57d>" + pathtoremove + "<dev string:x58d>";
                adddebugcommand( cmd + "<dev string:x58f>" );
            }
            
            return;
        }
        
        if ( !( isdefined( params ) && isdefined( params.weapon ) ) || !isweapon( params.weapon ) || isnullweapon( params.weapon ) )
        {
            return;
        }
        
        level.weapdev.players[ entnum ] = undefined;
        var_dc909bd2150544fd = player.name;
        
        if ( isdefined( var_d3f1f0f9cfae0fc8 ) && var_dc909bd2150544fd != var_d3f1f0f9cfae0fc8 )
        {
            pathtoremove = "<dev string:x142>" + "<dev string:x56a>" + var_d3f1f0f9cfae0fc8;
            cmd = "<dev string:x57d>" + pathtoremove + "<dev string:x58d>";
            adddebugcommand( cmd + "<dev string:x58f>" );
        }
        
        prevweapon = weapon::getweaponrootname( params.lastweapon );
        curweapon = weapon::getweaponrootname( params.weapon );
        followweapon = weapon::getweaponrootname( spawnweapon );
        level.weapdev.players[ entnum ] = spawnstruct();
        level.weapdev.players[ entnum ].var_dc909bd2150544fd = var_dc909bd2150544fd;
        level.weapdev.players[ entnum ].spawnweapon = params.weapon;
        
        if ( !isdefined( level.weapdev.attaches ) )
        {
            level.weapdev.attaches = [];
        }
        
        devgui::function_9082edeb5db93280( "<dev string:x142>" + "<dev string:x56a>" );
        
        if ( isdefined( spawnweapon ) && curweapon != followweapon )
        {
            if ( level.weapdev.attaches.size > 0 )
            {
                foreach ( path in level.weapdev.attaches )
                {
                    path = "<dev string:x142>" + "<dev string:x56a>" + path;
                    cmd = "<dev string:x57d>" + path + "<dev string:x58d>";
                    adddebugcommand( cmd + "<dev string:x58f>" );
                }
            }
        }
        
        if ( !isnullweapon( player.currentweapon ) )
        {
            noaltweapon = player.currentweapon getnoaltweapon();
            defaultattachments = getweapondefaultattachments( player.currentweapon );
            
            if ( isdefined( level.attachmentslotarray ) )
            {
                var_1c6cd63de98ba7ee = arraycopy( level.attachmentslotarray );
                var_1c6cd63de98ba7ee[ var_1c6cd63de98ba7ee.size ] = "<dev string:x591>";
                
                foreach ( slot in var_1c6cd63de98ba7ee )
                {
                    attachments = function_2e5ecdd8ac47f308( noaltweapon, slot, 1 );
                    
                    foreach ( attachmentname in attachments )
                    {
                        attachmentdataname = hashcat( %"hash_3c2c9813bb16552f", attachmentname );
                        categorybundle = getscriptbundlefieldvalue( attachmentdataname, #"category" );
                        category = "<dev string:x24>";
                        isdefaultattachment = 0;
                        
                        if ( isdefined( categorybundle ) )
                        {
                            category = getscriptbundlefieldvalue( categorybundle, #"ref" );
                        }
                        
                        foreach ( attachment in defaultattachments )
                        {
                            if ( attachment == attachmentname )
                            {
                                isdefaultattachment = 1;
                                break;
                            }
                        }
                        
                        if ( category != "<dev string:x24>" )
                        {
                            if ( !arraycontains( level.weapdev.attaches, category ) )
                            {
                                level.weapdev.attaches[ level.weapdev.attaches.size ] = category;
                            }
                            
                            if ( isdefaultattachment )
                            {
                                path = category + "<dev string:x59a>" + attachmentname;
                            }
                            else
                            {
                                path = category + "<dev string:x15f>" + attachmentname;
                            }
                        }
                        else
                        {
                            if ( !arraycontains( level.weapdev.attaches, slot ) )
                            {
                                level.weapdev.attaches[ level.weapdev.attaches.size ] = slot;
                            }
                            
                            if ( isdefaultattachment )
                            {
                                path = slot + "<dev string:x59a>" + attachmentname;
                            }
                            else
                            {
                                path = slot + "<dev string:x59d>" + attachmentname;
                            }
                        }
                        
                        devgui::add_devgui_command( path, "<dev string:x5a4>" + entnum + "<dev string:x5e0>" + noaltweapon.basename + "<dev string:x3b8>" + attachmentname );
                    }
                }
            }
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace weapons_dev
    // Params 2
    // Checksum 0x654f050e, Offset: 0x21e0
    // Size: 0xd4, Type: dev
    function function_cfa6895b527cb550( weaponobj, attachmentname )
    {
        var_b864fe801fd30f7a = weaponobj getnoaltweapon();
        attachmenttoidmap = var_b864fe801fd30f7a.attachmentvarindices;
        attachments = [];
        
        foreach ( attachment, id in attachmenttoidmap )
        {
            attachments[ attachments.size ] = attachment;
        }
        
        hasattachment = 0;
        
        if ( arraycontains( attachments, attachmentname ) )
        {
            hasattachment = 1;
        }
        
        return hasattachment;
    }

    // Namespace weapons_dev
    // Params 1
    // Checksum 0x3e935eb2, Offset: 0x22bc
    // Size: 0x6e, Type: dev
    function function_6ac230339288f89b( entnum )
    {
        if ( !isdefined( level.weapdev.var_ceefa46f8106bbca ) )
        {
            return 0;
        }
        
        if ( !isdefined( level.weapdev.var_ceefa46f8106bbca.entnum ) )
        {
            return 0;
        }
        
        return entnum == level.weapdev.var_ceefa46f8106bbca.entnum;
    }

    // Namespace weapons_dev
    // Params 0
    // Checksum 0xc133338e, Offset: 0x2332
    // Size: 0x44, Type: dev
    function function_e497e457bfd53f9f()
    {
        for ( ;; )
        {
            if ( getdvar( @"hash_eab5f19fea65c5c2", "<dev string:x24>" ) != "<dev string:x24>" )
            {
                thread function_3db7a06bbdc83881();
            }
            
            if ( getdvarint( @"hash_19234cfdaa9d6a8b" ) != 0 )
            {
                thread function_d44b12f71684a627();
            }
            
            waitframe();
        }
    }

    // Namespace weapons_dev
    // Params 0
    // Checksum 0x86e82b77, Offset: 0x237e
    // Size: 0x349, Type: dev
    function function_b7c56b4b095c7afa()
    {
        projectbundle = level.projectbundle;
        
        if ( !isdefined( projectbundle.stickerslist ) )
        {
            return;
        }
        
        if ( projectbundle.stickerslist == %"" )
        {
            return;
        }
        
        var_593bb1a4ee823d3a = getscriptbundle( projectbundle.stickerslist );
        
        if ( !isdefined( var_593bb1a4ee823d3a ) )
        {
            return;
        }
        
        level.stickerlist = [];
        level.var_d7e82654d86e06cf = [];
        level.var_9e0705afb166646 = [];
        struct = spawnstruct();
        struct.stickerdata = %"hash_f6ae6ae94236408";
        level.stickerlist[ level.stickerlist.size ] = struct;
        struct = spawnstruct();
        struct.stickerdata = %"hash_f6ae6ae94236408";
        level.var_d7e82654d86e06cf[ level.var_d7e82654d86e06cf.size ] = struct;
        struct = spawnstruct();
        struct.stickerdata = %"hash_f6ae6ae94236408";
        level.var_9e0705afb166646[ level.var_9e0705afb166646.size ] = struct;
        
        foreach ( sticker in var_593bb1a4ee823d3a.stickerlist )
        {
            if ( !isdefined( sticker.stickerdata ) )
            {
                continue;
            }
            
            isvinyl = getscriptbundlefieldvalue( sticker.stickerdata, #"isvinyl" );
            
            if ( isvinyl )
            {
                isrectangular = getscriptbundlefieldvalue( sticker.stickerdata, #"isrectangular" );
                
                if ( isrectangular )
                {
                    level.var_9e0705afb166646[ level.var_9e0705afb166646.size ] = sticker;
                }
                else
                {
                    level.var_d7e82654d86e06cf[ level.var_d7e82654d86e06cf.size ] = sticker;
                }
                
                continue;
            }
            
            level.stickerlist[ level.stickerlist.size ] = sticker;
        }
        
        setdevdvarifuninitialized( @"hash_c10e79652a809463", 0, 0, level.var_9e0705afb166646.size - 1 );
        setdevdvarifuninitialized( @"hash_8493d125f1e3575e", 0, 0, level.var_d7e82654d86e06cf.size - 1 );
        setdevdvarifuninitialized( @"hash_d812bddb260ed940", 0, 0, level.stickerlist.size - 1 );
        setdevdvarifuninitialized( @"hash_d812c0db260edfd9", 0, 0, level.stickerlist.size - 1 );
        setdevdvarifuninitialized( @"hash_d812bfdb260edda6", 0, 0, level.stickerlist.size - 1 );
        devgui::function_9082edeb5db93280( "<dev string:x142>" + "<dev string:x5ff>" + "<dev string:x610>" );
        devgui::add_devgui_dvar( "<dev string:x625>", "<dev string:x642>" );
        devgui::add_devgui_dvar( "<dev string:x66c>", "<dev string:x684>" );
        devgui::add_devgui_dvar( "<dev string:x6a9>", "<dev string:x6ba>" );
        devgui::add_devgui_dvar( "<dev string:x6da>", "<dev string:x6eb>" );
        devgui::add_devgui_dvar( "<dev string:x70b>", "<dev string:x71c>" );
        devgui::function_77df7fe7dd273e10();
        thread function_c88894f707f81920();
    }

    // Namespace weapons_dev
    // Params 4
    // Checksum 0x155a42c2, Offset: 0x26cf
    // Size: 0x1cb, Type: dev
    function function_d95c3938e6e30b94( selecteddata, dvarname, list, slot )
    {
        var_ea6692103166b42c = getdvarint( dvarname );
        
        if ( var_ea6692103166b42c != selecteddata.currsticker )
        {
            var_dd3e840581dc216d = list;
            var_c20dd8e16c993df2 = var_dd3e840581dc216d[ var_ea6692103166b42c ].stickerdata;
            tokens = strtok( getxhashsourcename( var_c20dd8e16c993df2 ), "<dev string:x73c>" );
            selecteddata.stickername = tokens[ 1 ];
            materialname = "<dev string:x73e>" + selecteddata.stickername;
            
            if ( 0 == var_ea6692103166b42c )
            {
                var_c20dd8e16c993df2 = undefined;
                selecteddata.stickername = "<dev string:x40c>";
            }
            
            foreach ( player in level.players )
            {
                currentweapon = player.currentweapon;
                newweapon = currentweapon setsticker( slot, materialname );
                player dropitem( currentweapon );
                player inventory_utility::_giveweapon( newweapon );
                player setweaponammoclip( newweapon, weaponclipsize( newweapon ) );
                player setweaponammostock( newweapon, weaponmaxammo( newweapon ) );
                player inventory_utility::_switchtoweaponimmediate( newweapon );
                weapon::fixupplayerweapons( player, newweapon );
            }
            
            selecteddata.currsticker = var_ea6692103166b42c;
            iprintlnbold( "<dev string:x741>" + selecteddata.stickername );
        }
    }

    // Namespace weapons_dev
    // Params 0
    // Checksum 0x77a91b65, Offset: 0x28a2
    // Size: 0x110, Type: dev
    function function_c88894f707f81920()
    {
        selectordata = [];
        var_af3abc785c5b49f4 = 5;
        
        for ( i = 0; i < var_af3abc785c5b49f4 ; i++ )
        {
            selecteddata = spawnstruct();
            selecteddata.currsticker = 0;
            selecteddata.stickername = "<dev string:x40c>";
            selectordata[ selectordata.size ] = selecteddata;
        }
        
        while ( true )
        {
            function_d95c3938e6e30b94( selectordata[ 0 ], @"hash_c10e79652a809463", level.var_9e0705afb166646, 0 );
            function_d95c3938e6e30b94( selectordata[ 1 ], @"hash_8493d125f1e3575e", level.var_d7e82654d86e06cf, 1 );
            function_d95c3938e6e30b94( selectordata[ 2 ], @"hash_d812bddb260ed940", level.stickerlist, 2 );
            function_d95c3938e6e30b94( selectordata[ 3 ], @"hash_d812c0db260edfd9", level.stickerlist, 3 );
            function_d95c3938e6e30b94( selectordata[ 4 ], @"hash_d812bfdb260edda6", level.stickerlist, 4 );
            wait 0.1;
        }
    }

    // Namespace weapons_dev
    // Params 0
    // Checksum 0x553450f2, Offset: 0x29ba
    // Size: 0x151, Type: dev
    function function_5007e34ad8f974e6()
    {
        level.charmlist = [];
        struct = spawnstruct();
        struct.charmdata = %"weaponcharmsdata:";
        level.charmlist[ level.charmlist.size ] = struct;
        var_2d7f6fde86b5beb1 = getscriptbundle( level.projectbundle.charmslist ).charmlist;
        
        foreach ( charm in var_2d7f6fde86b5beb1 )
        {
            if ( isdefined( charm.charmdata ) )
            {
                level.charmlist[ level.charmlist.size ] = charm;
            }
        }
        
        setdevdvarifuninitialized( @"hash_b4dda58a659a339d", 0, 0, level.charmlist.size - 1 );
        devgui::function_9082edeb5db93280( "<dev string:x142>" + "<dev string:x5ff>" );
        devgui::add_devgui_dvar( "<dev string:x754>", "<dev string:x763>" );
        devgui::function_77df7fe7dd273e10();
        thread function_8c7a9cfdd076bd8c();
    }

    // Namespace weapons_dev
    // Params 0
    // Checksum 0x8f3f2501, Offset: 0x2b13
    // Size: 0x15f, Type: dev
    function function_8c7a9cfdd076bd8c()
    {
        currcharm = 0;
        charmname = "<dev string:x40c>";
        
        while ( true )
        {
            var_3da5fb72e156ceb0 = getdvarint( @"hash_b4dda58a659a339d" );
            
            if ( var_3da5fb72e156ceb0 != currcharm )
            {
                var_2d7f6fde86b5beb1 = level.charmlist;
                var_d09b52449f919e3e = var_2d7f6fde86b5beb1[ var_3da5fb72e156ceb0 ].charmdata;
                tokens = strtok( getxhashsourcename( var_d09b52449f919e3e ), "<dev string:x73c>" );
                charmname = tokens[ 1 ];
                
                if ( 0 == var_3da5fb72e156ceb0 )
                {
                    var_d09b52449f919e3e = undefined;
                    charmname = "<dev string:x40c>";
                }
                
                foreach ( player in level.players )
                {
                    player function_9e65167f78d5842( var_d09b52449f919e3e );
                }
                
                currcharm = var_3da5fb72e156ceb0;
            }
            
            if ( var_3da5fb72e156ceb0 > 0 )
            {
                printtoscreen2d( 10, 925, "<dev string:x780>", ( 1, 1, 1 ), 4 );
                printtoscreen2d( 10, 1000, charmname, ( 1, 1, 1 ), 4 );
            }
            
            waitframe();
        }
    }

    // Namespace weapons_dev
    // Params 1
    // Checksum 0xf4e3bf46, Offset: 0x2c7a
    // Size: 0x65, Type: dev
    function function_9e65167f78d5842( charm )
    {
        objweapon = self getcurrentweapon();
        
        if ( isnullweapon( objweapon ) )
        {
            return;
        }
        
        newweaponobj = objweapon withcharm( charm );
        
        if ( isnullweapon( newweaponobj ) || newweaponobj == objweapon )
        {
            return;
        }
        
        self giveweapon( newweaponobj );
        self takeweapon( objweapon );
        self switchtoweaponimmediate( newweaponobj );
    }

    // Namespace weapons_dev
    // Params 0
    // Checksum 0xb798d875, Offset: 0x2ce7
    // Size: 0xb9, Type: dev
    function function_3db7a06bbdc83881()
    {
        var_9e0a7c53714af77e = getdvar( @"hash_eab5f19fea65c5c2" );
        
        if ( isdefined( getscriptbundle( "<dev string:x791>" + var_9e0a7c53714af77e ) ) )
        {
            foreach ( player in level.players )
            {
                player function_9e65167f78d5842( var_9e0a7c53714af77e );
            }
        }
        
        setdevdvar( @"hash_eab5f19fea65c5c2", "<dev string:x24>" );
    }

    // Namespace weapons_dev
    // Params 0
    // Checksum 0x5fccfe18, Offset: 0x2da8
    // Size: 0x98, Type: dev
    function function_d44b12f71684a627()
    {
        foreach ( player in level.players )
        {
            if ( !player ishost() )
            {
                continue;
            }
            
            player forceweaponinspect();
        }
        
        setdevdvar( @"hash_19234cfdaa9d6a8b", 0 );
    }

#/
