// scripts\autotests\mp\autotests_utility_weapons.gsc  (hash_13ed6c5090be436c.gscc) (size: 11352 Bytes / 0x2c58 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd1bea93e (3518933310)
// size ...... 11352 (0x2c58)
// includes .. 7   (offset: 0x29b0)
// strings ... 20  (offset: 0x29e8)
// dev strs .. 29  (offset: 0x2af8)
// exports ... 27  (offset: 0x1cb0)
// cseg ...... 0x18e + 0x1b22 (0x1cb0)
// imports ... 69  (offset: 0x20e8)
// animtree1 . 0   (offset: 0x2c58)
// animtree2 . 0   (offset: 0x2c58)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\mp\autotests_utility_weapons;
#using scripts\common\weapon;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\loot\common_item_ammo;

#namespace autotests_utility_weapons;

// Namespace autotests_utility_weapons
// Params 0
// Checksum 0xb96ce44b, Offset: 0x1ac
// Size: 0x19, Type: bool
function get_assetlist()
{
    return level.autotests.assets ?? [];
}

// Namespace autotests_utility_weapons
// Params 2
// Checksum 0xb7b16211, Offset: 0x1ce
// Size: 0x8e, Type: bool
function function_e86f9992269514eb( var_77c9f87eda935ce, assetlist )
{
    foreach ( asset in assetlist )
    {
        if ( var_77c9f87eda935ce == getxhashasset( asset ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace autotests_utility_weapons
// Params 3
// Checksum 0x33bb1bb1, Offset: 0x265
// Size: 0x206
function function_e11d086c284153d1( weapons, var_9c82d4b5508ebfb9 = 1, assetlist = undefined )
{
    blueprintnames = [];
    
    if ( !weapons.size )
    {
        println( "<dev string:x24>" );
        return blueprintnames;
    }
    
    var_b8517747d73fc1f4 = assetlist.size > 0;
    
    foreach ( weapon in weapons )
    {
        rootname = weapon::getweaponrootname( weapon );
        
        if ( !rootname )
        {
            println( "<dev string:x68>" + weapon + "<dev string:x96>" );
            continue;
        }
        
        blueprints = getweaponblueprintnames( weapon );
        blueprintnames[ blueprintnames.size ] = rootname;
        
        if ( !var_9c82d4b5508ebfb9 )
        {
            continue;
        }
        
        var_dac4de1a054e611c = 0;
        
        foreach ( varianthash, variantid in blueprints )
        {
            if ( var_b8517747d73fc1f4 && !function_e86f9992269514eb( varianthash, assetlist ) )
            {
                continue;
            }
            
            hashstring = string( varianthash );
            
            if ( issubstr( hashstring, "#a" ) )
            {
                hashstring = function_dd224316964dad28( hashstring );
            }
            
            blueprintnames[ blueprintnames.size ] = hashstring;
            var_dac4de1a054e611c++;
        }
        
        println( "<dev string:xa3>" + var_dac4de1a054e611c + "<dev string:xaa>" + rootname + "<dev string:xc5>" );
    }
    
    println( "<dev string:xc7>" + blueprintnames.size );
    return blueprintnames;
}

// Namespace autotests_utility_weapons
// Params 1
// Checksum 0x344a27b4, Offset: 0x474
// Size: 0x23, Type: bool
function function_5b69f10049eb1449( weapon )
{
    ammotype = item_ammo::function_b162feeed34a4640( weapon );
    return isdefined( ammotype );
}

// Namespace autotests_utility_weapons
// Params 3, eflags: 0x4
// Checksum 0x3a23ffde, Offset: 0x4a0
// Size: 0x180
function private function_ba62824e82d0beae( weapons, desiredgroup, weapongroupmap )
{
    filteredweapons = [];
    uniquegroups = arrayremoveduplicates( weapongroupmap );
    println( "<dev string:xe4>" + uniquegroups );
    groupfound = 0;
    
    foreach ( group in uniquegroups )
    {
        if ( issubstr( group, desiredgroup ) )
        {
            groupfound = 1;
            break;
        }
    }
    
    if ( !groupfound )
    {
        println( "<dev string:xfb>" + desiredgroup + "<dev string:x112>" );
        println( "<dev string:x154>" + uniquegroups );
        return filteredweapons;
    }
    
    foreach ( weapon in weapons )
    {
        if ( weapongroupmap[ weapon ] && issubstr( weapongroupmap[ weapon ], desiredgroup ) )
        {
            filteredweapons[ weapon ] = weapon;
        }
    }
    
    return filteredweapons;
}

// Namespace autotests_utility_weapons
// Params 0, eflags: 0x4
// Checksum 0x713a5a6c, Offset: 0x629
// Size: 0xb2
function private function_45f84e904c1a7cdf()
{
    var_c90c9afe6d0dcc94 = [];
    
    if ( !isdefined( level.weaponmapdata ) )
    {
        return var_c90c9afe6d0dcc94;
    }
    
    foreach ( weaponref in level.weaponmapdata )
    {
        weaponname = weaponref.assetname;
        var_c90c9afe6d0dcc94[ weaponname ] = weapon::getweapongroup( weaponname );
    }
    
    return var_c90c9afe6d0dcc94;
}

// Namespace autotests_utility_weapons
// Params 1
// Checksum 0x3b55fb0, Offset: 0x6e4
// Size: 0x4e
function get_weapon_asset_name( weaponname )
{
    if ( weaponexists( weaponname ) || weapon::iskillstreakweapon( weaponname ) )
    {
        return weaponname;
    }
    
    weaponroot = weapon::getweaponrootname( weaponname );
    return level.weaponmapdata[ weaponroot ].assetname;
}

// Namespace autotests_utility_weapons
// Params 3
// Checksum 0x6ac80ca5, Offset: 0x73b
// Size: 0x30
function create_weapon( rootname, variantid, hasnvg )
{
    return weapon::buildweapon( rootname, undefined, undefined, undefined, variantid, undefined, undefined, undefined, hasnvg );
}

// Namespace autotests_utility_weapons
// Params 1, eflags: 0x4
// Checksum 0xb1e7ad7f, Offset: 0x774
// Size: 0x9c
function private function_d96f02da8ab756b7( anim_hash )
{
    if ( !anim_hash )
    {
        return;
    }
    
    curr_time = self getanimtime( anim_hash );
    prev_time = curr_time;
    reported_progress = 0;
    
    while ( prev_time <= 0.99 )
    {
        waitframe();
        curr_time = self getanimtime( anim_hash );
        
        if ( curr_time == prev_time )
        {
            break;
        }
        
        if ( !reported_progress )
        {
            autotests::report_info( "Animation {" + anim_hash + "} is progressing, waiting for it to finish..." );
            reported_progress = 1;
        }
        
        prev_time = curr_time;
    }
    
    if ( reported_progress )
    {
        autotests::report_info( "Animation {" + anim_hash + "} has finished." );
    }
}

// Namespace autotests_utility_weapons
// Params 4
// Checksum 0x868073f, Offset: 0x818
// Size: 0x1d2
function swap_to_weapon( weapon, video_marker = 0, delay = 0, var_f76294d59bd8b3f4 = 0 )
{
    anims_before = [];
    
    if ( video_marker && var_f76294d59bd8b3f4 )
    {
        foreach ( var_b2f04593d18c5ff8 in self getactiveanimations() )
        {
            if ( var_b2f04593d18c5ff8[ "animation" ] )
            {
                anims_before[ anims_before.size ] = var_b2f04593d18c5ff8[ "animation" ];
            }
        }
    }
    
    self takeallweapons();
    self giveweapon( weapon );
    
    if ( video_marker )
    {
        if ( delay > 0 )
        {
            wait delay;
        }
        
        if ( var_f76294d59bd8b3f4 )
        {
            waitframe();
            waitframe();
            waitframe();
            
            foreach ( var_b2f04593d18c5ff8 in self getactiveanimations() )
            {
                new_anim = var_b2f04593d18c5ff8[ "animation" ];
                
                if ( !new_anim || arraycontains( anims_before, new_anim ) )
                {
                    continue;
                }
                
                function_d96f02da8ab756b7( new_anim );
            }
            
            autotests::report_info( "Waiting for standing idle animation to finish..." );
            function_d96f02da8ab756b7( self getactiveanimations()[ 0 ][ "animation" ] );
        }
        
        autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "weapon" );
        waitframe();
        autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "weapon" );
    }
}

// Namespace autotests_utility_weapons
// Params 2
// Checksum 0x5629ea4, Offset: 0x9f2
// Size: 0xd0
function function_621215cb1817ee55( weaponname, variantid )
{
    if ( variantid == 0 )
    {
        return { #varianthash:0, #variantid:0 };
    }
    
    variants = getweaponblueprintnames( get_weapon_asset_name( weaponname ) );
    
    foreach ( varianthash, vid in variants )
    {
        if ( vid == variantid )
        {
            return { #varianthash:varianthash, #variantid:variantid };
        }
    }
}

// Namespace autotests_utility_weapons
// Params 1
// Checksum 0xadecdea1, Offset: 0xacb
// Size: 0xdd
function function_3d7814ac5020182( blueprintname )
{
    weaponname = weapon::getweaponrootname( blueprintname );
    
    if ( weaponname == blueprintname )
    {
        return function_621215cb1817ee55( weaponname, 0 );
    }
    
    variants = getweaponblueprintnames( get_weapon_asset_name( blueprintname ) );
    inputhash = getxhashasset( blueprintname );
    
    foreach ( varianthash, variantid in variants )
    {
        if ( inputhash == varianthash )
        {
            return { #varianthash:varianthash, #variantid:variantid };
        }
    }
}

// Namespace autotests_utility_weapons
// Params 1, eflags: 0x4
// Checksum 0xedff2049, Offset: 0xbb1
// Size: 0x1a
function private function_dd224316964dad28( hashstring )
{
    return getsubstr( hashstring, 3, hashstring.size - 1 );
}

// Namespace autotests_utility_weapons
// Params 0, eflags: 0x4
// Checksum 0x9a1c1341, Offset: 0xbd4
// Size: 0x154
function private function_f5a0d68ba44f714e()
{
    weaponlist = function_b1e78006d75ee4f3();
    var_dd01159ca20dc08d = [];
    
    foreach ( weapon in weaponlist )
    {
        rootname = weapon::getweaponrootname( weapon );
        assetname = get_weapon_asset_name( rootname );
        
        foreach ( varianthash, variantid in getweaponblueprintnames( weapon ) )
        {
            var_dd01159ca20dc08d[ varianthash ] = { #varianthash:varianthash, #variantid:variantid, #assetname:assetname, #weaponname:rootname };
        }
    }
    
    self.var_dd01159ca20dc08d = var_dd01159ca20dc08d;
    return var_dd01159ca20dc08d;
}

// Namespace autotests_utility_weapons
// Params 1, eflags: 0x4
// Checksum 0xe844bfd0, Offset: 0xd31
// Size: 0x32
function private function_9e822deed44d52d6( varianthash )
{
    var_dd01159ca20dc08d = self.var_dd01159ca20dc08d;
    
    if ( !isdefined( var_dd01159ca20dc08d ) )
    {
        var_dd01159ca20dc08d = function_f5a0d68ba44f714e();
    }
    
    return var_dd01159ca20dc08d[ varianthash ];
}

// Namespace autotests_utility_weapons
// Params 1
// Checksum 0x46479b3b, Offset: 0xd6c
// Size: 0xdb
function get_weapon_info( var_23986f5ff3f49f24 )
{
    if ( isxhashasset( var_23986f5ff3f49f24 ) )
    {
        return function_9e822deed44d52d6( var_23986f5ff3f49f24 );
    }
    else if ( issubstr( var_23986f5ff3f49f24, "#a" ) )
    {
        substring = function_dd224316964dad28( var_23986f5ff3f49f24 );
        xhash = getxhashasset( substring );
        return function_9e822deed44d52d6( xhash );
    }
    else if ( issubstr( var_23986f5ff3f49f24, "#x" ) )
    {
        xhash = getxhashasset( var_23986f5ff3f49f24 );
        return function_9e822deed44d52d6( xhash );
    }
    
    variant = function_3d7814ac5020182( var_23986f5ff3f49f24 );
    return { #varianthash:variant.varianthash, #variantid:variant.variantid, #assetname:get_weapon_asset_name( var_23986f5ff3f49f24 ), #weaponname:weapon::getweaponrootname( var_23986f5ff3f49f24 ) };
}

// Namespace autotests_utility_weapons
// Params 1
// Checksum 0xdb50f357, Offset: 0xe50
// Size: 0x5e
function get_assetname( weaponinfo )
{
    assetname = weaponinfo.assetname;
    
    if ( weaponinfo.variantid )
    {
        assetname = function_dd224316964dad28( string( weaponinfo.varianthash ) );
        
        /#
            assetname = getxhashsourcename( weaponinfo.varianthash );
        #/
    }
    
    return assetname;
}

// Namespace autotests_utility_weapons
// Params 2
// Checksum 0x9aead1f3, Offset: 0xeb7
// Size: 0x27a
function function_b1e78006d75ee4f3( validationfunction, desiredgroup )
{
    weapons = [];
    
    if ( !isdefined( level.weaponmapdata ) )
    {
        return weapons;
    }
    
    gametype = toupper( game_utility::getgametype() );
    var_f1c5fac94abfd027 = getdvarint( @"hash_a29d35a0c7f7307b", 1 );
    projectname = "";
    
    if ( var_f1c5fac94abfd027 )
    {
        projectname = autotests_utility::function_2da7d4694fda2fdd();
    }
    
    var_b5ac66ae22fbb45d = desiredgroup == "primary";
    var_79935c6ce681d93d = desiredgroup == "secondary";
    var_35494eb1b8fb41f5 = desiredgroup && desiredgroup != "all" && !var_b5ac66ae22fbb45d && !var_79935c6ce681d93d;
    
    foreach ( weaponref in level.weaponmapdata )
    {
        weaponname = weaponref.assetname;
        
        if ( projectname && !isstartstr( weaponname, projectname ) )
        {
            continue;
        }
        
        if ( !weaponexists( weaponname ) )
        {
            continue;
        }
        
        rootname = weapon::getweaponrootname( weaponname );
        
        if ( !level.weaponmapdata[ rootname ].assetname )
        {
            continue;
        }
        
        weaponobj = weapon::buildweapon( rootname );
        
        if ( !isdefined( weaponobj ) )
        {
            continue;
        }
        
        if ( validationfunction && ![[ validationfunction ]]( weaponobj ) )
        {
            continue;
        }
        
        if ( var_b5ac66ae22fbb45d && !weapon::iscacprimaryweapon( weaponobj ) )
        {
            continue;
        }
        
        if ( var_79935c6ce681d93d && !weapon::iscacsecondaryweapon( weaponobj ) )
        {
            continue;
        }
        
        gamemodes = weapon::function_c37ac3c4f987e506( weaponname, #"availablegamemodes" );
        
        if ( gamemodes )
        {
            gamemodelist = strtok( gamemodes, "," );
            
            if ( !function_f02c63b99c9614c9( gamemodelist, gametype ) )
            {
                continue;
            }
        }
        
        if ( weapon::function_c37ac3c4f987e506( weaponname, #"inventorytype" ) == "item" )
        {
            continue;
        }
        
        weapons[ weaponname ] = weaponname;
    }
    
    if ( var_35494eb1b8fb41f5 )
    {
        weapongroupmap = function_45f84e904c1a7cdf();
        weapons = function_ba62824e82d0beae( weapons, desiredgroup, weapongroupmap );
    }
    
    return weapons;
}

// Namespace autotests_utility_weapons
// Params 3
// Checksum 0xa51c5c9e, Offset: 0x113a
// Size: 0x205
function function_dc598beaf588c3d0( test_setup, validationfunction = undefined, testinglevel = undefined )
{
    if ( !isdefined( level.weaponmapdata ) )
    {
        println( "<dev string:x16e>" );
        return [];
    }
    
    weaponfilter = test_setup.var_875fc462a0bca171.named[ "weapon_filter" ] ? test_setup.var_875fc462a0bca171.named[ "weapon_filter" ] : "all";
    var_4194d7da13833440 = function_b1e78006d75ee4f3( validationfunction, weaponfilter );
    
    if ( testinglevel )
    {
        filteredweapons = [];
        
        foreach ( weaponname in var_4194d7da13833440 )
        {
            rootname = weapon::getweaponrootname( weaponname );
            weapontestinglevel = weapon::function_c37ac3c4f987e506( rootname, #"testinglevel", "All" );
            
            if ( !autotests_utility::function_16e4b52e47772eb5( { #testinglevel:weapontestinglevel }, testinglevel ) )
            {
                continue;
            }
            
            filteredweapons[ weaponname ] = weaponname;
        }
        
        var_4194d7da13833440 = filteredweapons;
    }
    
    if ( !var_4194d7da13833440.size )
    {
        println( "<dev string:x1ce>" + weaponfilter + "<dev string:x214>" );
        return [];
    }
    
    raw_all_blueprints = test_setup.var_875fc462a0bca171.named[ "all_blueprints" ];
    all_blueprints = !( raw_all_blueprints == "false" || raw_all_blueprints == "0" );
    println( "<dev string:x217>" + var_4194d7da13833440.size + "<dev string:x23a>" + all_blueprints );
    return function_e11d086c284153d1( var_4194d7da13833440, all_blueprints, get_assetlist() );
}

// Namespace autotests_utility_weapons
// Params 1
// Checksum 0x9c3cd1ba, Offset: 0x1348
// Size: 0x13b
function get_all_attachments( weaponname )
{
    all_slots = level.attachmentslotarray;
    attachments = [];
    
    foreach ( slot in all_slots )
    {
        slotattachments = function_9fc69cab0bc56f78( weaponname, slot );
        valid_attachments = [];
        
        foreach ( attachment in slotattachments )
        {
            if ( weapon::attachmentisselectable( weaponname, attachment ) )
            {
                valid_attachments[ valid_attachments.size ] = attachment;
            }
        }
        
        if ( valid_attachments.size != 0 )
        {
            attachments[ slot ] = valid_attachments;
        }
    }
    
    return attachments;
}

// Namespace autotests_utility_weapons
// Params 3
// Checksum 0x308e4833, Offset: 0x148c
// Size: 0x2f
function function_9fc69cab0bc56f78( weaponname, slot, includeall = 1 )
{
    return function_2e5ecdd8ac47f308( weaponname, slot, includeall );
}

// Namespace autotests_utility_weapons
// Params 3, eflags: 0x4
// Checksum 0x2aa50844, Offset: 0x14c4
// Size: 0xad, Type: bool
function private function_dda8da2f2622316f( weaponasset, blocker, target )
{
    var_4f1c71ddb91a0cb8 = getattachmentbasetypesblocked( weaponasset, blocker );
    
    if ( var_4f1c71ddb91a0cb8.size > 0 && arraycontains( var_4f1c71ddb91a0cb8, getattachmentbasetype( weaponasset, target ) ) )
    {
        return true;
    }
    
    targetslot = getattachmentslot( weaponasset, target );
    blockedslots = getattachmentslotsblocked( weaponasset, blocker );
    
    if ( blockedslots.size > 0 && arraycontains( blockedslots, targetslot ) )
    {
        return true;
    }
    
    blockedattachments = getattachmentsblocked( weaponasset, blocker );
    
    if ( blockedattachments.size > 0 && arraycontains( blockedattachments, target ) )
    {
        return true;
    }
    
    return false;
}

// Namespace autotests_utility_weapons
// Params 3, eflags: 0x4
// Checksum 0xcc45bf2, Offset: 0x157a
// Size: 0x36, Type: bool
function private attachments_conflict( weaponasset, atta, attb )
{
    return function_dda8da2f2622316f( weaponasset, atta, attb ) || function_dda8da2f2622316f( weaponasset, attb, atta );
}

// Namespace autotests_utility_weapons
// Params 3, eflags: 0x4
// Checksum 0xcc53ccd9, Offset: 0x15b9
// Size: 0x98, Type: bool
function private function_2beb64c09618727d( weaponasset, candidate, currentconfig )
{
    foreach ( existingattachment in currentconfig )
    {
        if ( attachments_conflict( weaponasset, candidate, existingattachment ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace autotests_utility_weapons
// Params 2
// Checksum 0xffbf4650, Offset: 0x165a
// Size: 0x3c5
function function_9ee3a17ef9d3b76b( weaponasset, var_e3444274e2b233fd )
{
    var_b8604eef8a85715f = [];
    
    foreach ( slot, var_2c74d92a16e02a86 in var_e3444274e2b233fd )
    {
        var_b8604eef8a85715f[ slot ] = arraycopy( var_2c74d92a16e02a86 );
    }
    
    configurations = [];
    
    foreach ( anchorslot, var_c36eb9d5b06e2483 in var_e3444274e2b233fd )
    {
        foreach ( anchorattachment in var_c36eb9d5b06e2483 )
        {
            if ( !arraycontains( var_b8604eef8a85715f[ anchorslot ], anchorattachment ) )
            {
                continue;
            }
            
            currentconfig = [ anchorattachment ];
            var_b8604eef8a85715f[ anchorslot ] = arrayremove( var_b8604eef8a85715f[ anchorslot ], anchorattachment );
            
            foreach ( fillslot, var_de219c9822c5c0f7 in var_e3444274e2b233fd )
            {
                if ( fillslot == anchorslot )
                {
                    continue;
                }
                
                foreach ( candidate in var_b8604eef8a85715f[ fillslot ] )
                {
                    if ( function_2beb64c09618727d( weaponasset, candidate, currentconfig ) )
                    {
                        continue;
                    }
                    
                    currentconfig[ currentconfig.size ] = candidate;
                    var_b8604eef8a85715f[ fillslot ] = arrayremove( var_b8604eef8a85715f[ fillslot ], candidate );
                    break;
                }
            }
            
            configurations[ configurations.size ] = currentconfig;
        }
    }
    
    /#
        allcovered = 1;
        
        foreach ( verifyslot, remaining in var_b8604eef8a85715f )
        {
            foreach ( uncovered in remaining )
            {
                println( "<dev string:x25c>" + uncovered + "<dev string:x28d>" + verifyslot + "<dev string:x297>" );
                allcovered = 0;
            }
        }
        
        if ( allcovered )
        {
            println( "<dev string:x2b4>" + weaponasset + "<dev string:x2c4>" + configurations.size + "<dev string:x2c8>" );
        }
    #/
    
    return configurations;
}

// Namespace autotests_utility_weapons
// Params 2
// Checksum 0x329c99b7, Offset: 0x1a28
// Size: 0x287
function function_dc93bcf214d1e2ab( blueprints, attachments_test_mode )
{
    test_cases = [];
    var_c57fafbd1f711bf1 = undefined;
    
    switch ( attachments_test_mode )
    {
        case #"hash_7f2623a6643aae70":
            var_c57fafbd1f711bf1 = &function_9ee3a17ef9d3b76b;
            break;
        case #"hash_582a3b8c6dc57f85":
            println( "<dev string:x2ea>" );
            return;
        default:
            println( "<dev string:x359>" + attachments_test_mode + "<dev string:x3a1>" );
            return;
    }
    
    if ( !isdefined( level.var_ac6454f7b690a35b ) )
    {
        level.var_ac6454f7b690a35b = [];
    }
    
    foreach ( blueprint in blueprints )
    {
        weaponinfo = get_weapon_info( blueprint );
        
        if ( !weaponinfo || !weaponinfo.assetname )
        {
            println( "<dev string:x3d7>" + blueprint + "<dev string:x40a>" );
            continue;
        }
        
        if ( !isdefined( level.var_ac6454f7b690a35b[ weaponinfo.assetname ] ) )
        {
            var_d192fcef1961dbc1 = get_all_attachments( weaponinfo.assetname );
            level.var_ac6454f7b690a35b[ weaponinfo.assetname ] = [[ var_c57fafbd1f711bf1 ]]( weaponinfo.assetname, var_d192fcef1961dbc1 );
            println( "<dev string:x42a>" + level.var_ac6454f7b690a35b[ weaponinfo.assetname ].size + "<dev string:x44a>" + weaponinfo.assetname + "<dev string:x214>" );
        }
        
        configs = level.var_ac6454f7b690a35b[ weaponinfo.assetname ];
        
        if ( !configs.size )
        {
            continue;
        }
        
        foreach ( index, _ in configs )
        {
            test_cases[ test_cases.size ] = blueprint + "$" + string( index );
        }
    }
    
    return test_cases;
}

