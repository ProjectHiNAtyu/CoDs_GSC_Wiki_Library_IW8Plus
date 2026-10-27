// scripts\mp\zm\systems\loot_drops.gsc  (hash_1f7b0304d26d6272.gscc) (size: 7552 Bytes / 0x1d80 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x39c6a588 (969319816)
// size ...... 7552 (0x1d80)
// includes .. 10  (offset: 0x1b94)
// strings ... 14  (offset: 0x1be4)
// dev strs .. 17  (offset: 0x1ca8)
// exports ... 13  (offset: 0x12ac)
// cseg ...... 0x112 + 0x119a (0x12ac)
// imports ... 59  (offset: 0x14b4)
// animtree1 . 0   (offset: 0x1d80)
// animtree2 . 0   (offset: 0x1d80)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\zm_utility;

#namespace loot_drops;

// Namespace loot_drops
// Params 0
// Checksum 0x21454328, Offset: 0x130
// Size: 0xc5
function init_loot_drops()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    if ( level.gametypebundle.var_e8959b0d5b7cafad )
    {
        return;
    }
    
    level callback::add( #"on_ai_killed", &on_ai_killed );
    
    /#
        level callback::add( #"game_ended", &on_game_end_debug );
        namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_634526d7cfc0c517", &function_78f8115ada83c397 );
    #/
    
    level.var_b6c3ca068782a9cb = &function_984c034cc4b2a414;
    level.var_3836af4596707c8c = &soldier_drop_weapon;
    level.var_597f31ee570896c0 = &init_per_player_spawn_options;
    level.var_9e6b9c9a1515f9d1 = getdvarint( @"hash_4d9223ca9923751d", 512 );
    level.var_3327cc6ea7faa2ba = getdvarint( @"hash_1e0497d9069b47db", 0 ) == 1;
}

// Namespace loot_drops
// Params 1
// Checksum 0xa8e25eb1, Offset: 0x1fd
// Size: 0x504
function on_ai_killed( params )
{
    if ( self.var_a13bed1ac47e1b2c || self.b_in_spawn_closet || level.var_3327cc6ea7faa2ba )
    {
        return;
    }
    
    var_9a7a06cefa6b7c15 = weapon::iskillstreakweapon( params.sweapon );
    
    if ( var_9a7a06cefa6b7c15 )
    {
        return;
    }
    
    if ( params.einflictor.var_ebfff1f89798fefb || params.eattacker.var_ebfff1f89798fefb )
    {
        return;
    }
    
    if ( params.einflictor vehicle::is_vehicle() && vehicle::has_data( params.einflictor.bundlename ) )
    {
        data = vehicle::get_data( params.einflictor.bundlename );
        
        if ( data.interact.var_ccde6b39658cd648 && utility::percent_chance( data.interact.var_ccde6b39658cd648 ) )
        {
            return;
        }
    }
    
    if ( !isdefined( level.loot_drop_killed_throttle ) )
    {
        level.loot_drop_killed_throttle = throttle::throttle_initialize( "loot_drop_killed", 1, level.framedurationseconds );
    }
    
    loot_drop_event = spawnstruct();
    
    if ( isdefined( self.var_50c96a5c56dab386 ) )
    {
        droplist_params = [[ self.var_50c96a5c56dab386 ]]();
    }
    else if ( self.type == "zombie" )
    {
        droplist_params = get_zombie_droplist_params();
    }
    else if ( self.type == "human" )
    {
        itembundle = function_1fa69e8c7540c2af();
        
        if ( !itembundle )
        {
            return;
        }
        
        droplist_params = function_c1b86bc825200338();
        
        if ( !self.alreadydroppedweapon )
        {
            throttle::throttle_wait_in_queue( level.loot_drop_killed_throttle, loot_drop_event );
            
            if ( isdefined( level.var_3836af4596707c8c ) && isdefined( itembundle.baseweapon ) )
            {
                self [[ level.var_3836af4596707c8c ]]( itembundle, droplist_params );
            }
            else
            {
                soldier_drop_weapon( itembundle, droplist_params );
            }
        }
    }
    
    /#
        if ( getdvar( @"scr_force_item_list", "<dev string:x24>" ) != "<dev string:x24>" )
        {
            level.var_e8fac090b872dded = getdvar( @"scr_force_item_list" );
        }
    #/
    
    if ( level.var_e8fac090b872dded )
    {
        droplist_params.droplist = level.var_e8fac090b872dded;
    }
    
    playerdamagelist = self.a_n_player_damage;
    throttle::throttle_wait_in_queue( level.loot_drop_killed_throttle, loot_drop_event );
    
    if ( isdefined( droplist_params.droplist ) && isdefined( droplist_params.dropquantity ) && isdefined( droplist_params.droppos ) )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( droplist_params.droppos );
        
        if ( isdefined( level.var_597f31ee570896c0 ) )
        {
            self [[ level.var_597f31ee570896c0 ]]( spawnoptions, playerdamagelist, self.origin );
        }
        
        var_f0110ccab3f4a8a6 = common_item::function_38cde6a6acb68ea6( droplist_params.droplist, droplist_params.dropquantity, spawnoptions );
        
        /#
            if ( var_f0110ccab3f4a8a6.size > 0 )
            {
                function_804dbb3463f72d1b( var_f0110ccab3f4a8a6 );
            }
        #/
        
        if ( isdefined( level.var_5681a2a9991ea212 ) )
        {
            self [[ level.var_5681a2a9991ea212 ]]( var_f0110ccab3f4a8a6 );
        }
    }
    else if ( !isdefined( droplist_params.droplist ) )
    {
        assertmsg( "<dev string:x25>" );
    }
    else if ( !isdefined( droplist_params.droppos ) )
    {
        assertmsg( "<dev string:x4a>" );
    }
    
    if ( self.type == "zombie" )
    {
        var_436166def74e7611 = params.sweapon;
        
        if ( var_436166def74e7611 issilenced() )
        {
            if ( utility::percent_chance( 3 ) )
            {
                droppoint = getclosestpointonnavmesh( self.origin );
                droppeditem = common_item::function_47324f290423b2d1( %"itemspawnentry:zm_t10_item_salvage_green", self.origin, droppoint );
                
                /#
                    function_804dbb3463f72d1b( droppeditem );
                #/
            }
        }
        
        if ( isdefined( level.var_a3ae2cc77a6db23 ) )
        {
            foreach ( func in level.var_a3ae2cc77a6db23 )
            {
                var_ac3ca41b628b86b1 = [[ func ]]( params );
                
                if ( var_ac3ca41b628b86b1 )
                {
                    if ( isdefined( droplist_params.droplist ) && isdefined( droplist_params.dropquantity ) && isdefined( droplist_params.droppos ) )
                    {
                        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( droplist_params.droppos );
                        var_f0110ccab3f4a8a6 = common_item::function_38cde6a6acb68ea6( droplist_params.droplist, 1, spawnoptions );
                    }
                }
            }
        }
    }
}

// Namespace loot_drops
// Params 0
// Checksum 0xbfaf8211, Offset: 0x709
// Size: 0x16f
function get_zombie_droplist_params()
{
    if ( self.aicategory == "normal" )
    {
        if ( isdefined( level.var_7b337816c6b398df ) )
        {
            zombie_droplist = [[ level.var_7b337816c6b398df ]]();
        }
        
        if ( isstartstr( self.subclass, "zombie_base_armored" ) )
        {
            if ( self.subclass == "zombie_base_armored_heavy" )
            {
                if ( isdefined( level.var_c078bdf00f887d4b ) )
                {
                    zombie_droplist = [[ level.var_c078bdf00f887d4b ]]();
                }
            }
            else if ( isdefined( level.var_276a6abf9e419a7a ) )
            {
                zombie_droplist = [[ level.var_276a6abf9e419a7a ]]();
            }
        }
    }
    else if ( self.aicategory == "special" && isdefined( level.var_d294be5cdc3a6077 ) )
    {
        zombie_droplist = [[ level.var_d294be5cdc3a6077 ]]();
    }
    else if ( ( self.aicategory == "elite" || self.aicategory == "hvt" ) && isdefined( level.var_768953ff5aba4257 ) )
    {
        zombie_droplist = [[ level.var_768953ff5aba4257 ]]();
    }
    
    var_245f1c4b1d5b3e81 = 1;
    zombie_droppos = self.origin;
    zombie_droplist_params = { #droppos:zombie_droppos ?? self.origin, #dropquantity:var_245f1c4b1d5b3e81 ?? 1, #droplist:zombie_droplist ?? "zm_t10_items_default_droplist" };
    return zombie_droplist_params;
}

// Namespace loot_drops
// Params 0
// Checksum 0x450cc694, Offset: 0x881
// Size: 0x10f
function function_c1b86bc825200338()
{
    if ( self.aicategory == "normal" )
    {
        if ( isdefined( level.var_30327e38d7e50c7f ) )
        {
            soldier_droplist = [[ level.var_30327e38d7e50c7f ]]();
        }
    }
    else if ( self.aicategory == "special" && isdefined( level.var_e330273c49dd0357 ) )
    {
        soldier_droplist = [[ level.var_e330273c49dd0357 ]]();
    }
    else if ( ( self.aicategory == "elite" || self.aicategory == "hvt" ) && isdefined( level.var_8302e83d8033cfb7 ) )
    {
        soldier_droplist = [[ level.var_8302e83d8033cfb7 ]]();
    }
    
    var_c318507bb4df069 = undefined;
    soldier_droppos = self.origin;
    var_32273be465dc12ff = { #droppos:soldier_droppos ?? self.origin, #dropquantity:var_c318507bb4df069 ?? undefined, #droplist:soldier_droplist ?? "zm_t10_items_default_droplist" };
    return var_32273be465dc12ff;
}

// Namespace loot_drops
// Params 0
// Checksum 0xa4912ee6, Offset: 0x999
// Size: 0xf0
function function_1fa69e8c7540c2af()
{
    if ( isdefined( level.var_b6c3ca068782a9cb ) )
    {
        weapon = [[ level.var_b6c3ca068782a9cb ]]();
    }
    else
    {
        weapon = function_984c034cc4b2a414();
    }
    
    weaponname = weapon.basename;
    n_round = zm_round_logic::get_rb_round_number();
    
    if ( n_round > 0 && n_round < 5 )
    {
        rarity = 0;
    }
    else if ( n_round >= 5 && n_round < 10 )
    {
        rarity = 1;
    }
    else if ( n_round >= 10 && n_round < 15 )
    {
        rarity = 2;
    }
    else if ( n_round >= 15 && n_round < 20 )
    {
        rarity = 3;
    }
    else
    {
        rarity = 4;
    }
    
    if ( isdefined( weaponname ) )
    {
        itembundlename = item_weapon::function_3da93a43aae4473d( weaponname, rarity );
    }
    
    if ( itembundlename )
    {
        itembundle = getscriptbundle( itembundlename );
    }
    
    return itembundle;
}

// Namespace loot_drops
// Params 0
// Checksum 0xaac7e732, Offset: 0xa92
// Size: 0x10c
function function_984c034cc4b2a414()
{
    if ( isdefined( self.lastweapon ) && ( arraycontains( strtok( self.lastweapon.basename, "_" ), "la" ) || arraycontains( strtok( self.lastweapon.basename, "_" ), "sn" ) ) )
    {
        return self.lastweapon;
    }
    
    if ( isdefined( self.primaryweapon ) && self.primaryweapon.basename != "none" )
    {
        return self.primaryweapon;
    }
    
    itembundle = getscriptbundle( %"itemspawnentry:zm_t10_item_weapon_pi_p13_usugar9" );
    
    if ( !( isdefined( itembundle ) && isdefined( itembundle.baseweapon ) ) )
    {
        assertmsg( "<dev string:x73>" + ( %"itemspawnentry:zm_t10_item_weapon_pi_p13_usugar9" ?? "<dev string:xd7>" ) + "<dev string:xe1>" );
        return;
    }
    
    return weapon::buildweapon( itembundle.baseweapon );
}

// Namespace loot_drops
// Params 2
// Checksum 0xe2f3fd35, Offset: 0xba6
// Size: 0xa1
function soldier_drop_weapon( itembundle, droplist_params )
{
    if ( isvector( droplist_params ) )
    {
        droplist_params = { #droppos:droplist_params };
    }
    
    if ( isweapon( itembundle ) )
    {
        itembundlename = item_weapon::function_3da93a43aae4473d( itembundle.basename );
        itembundle = common_item::function_90c3e0c1fd55d6b6( itembundlename );
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( droplist_params.droppos );
    item = common_item::function_61c2c0251e742ffd( itembundle, droplist_params.dropquantity, spawnoptions );
    self.droppedweapon = item;
}

// Namespace loot_drops
// Params 3
// Checksum 0xd4218ed7, Offset: 0xc4f
// Size: 0x6a
function init_per_player_spawn_options( spawnoptions, var_fd43b2ce283ab3f0, var_34acf07510a4e674 )
{
    spawnoptions.var_c580c0e8b49f1fcc = 1;
    playersinradius = isdefined( var_34acf07510a4e674 ) ? getplayersinradius( var_34acf07510a4e674, level.var_9e6b9c9a1515f9d1 ) : [];
    spawnoptions.var_4a4b419f66681601 = arraycombineunique( var_fd43b2ce283ab3f0 ?? [], playersinradius );
    return spawnoptions;
}

// Namespace loot_drops
// Params 1
// Checksum 0x504e4c3e, Offset: 0xcc2
// Size: 0x3f
function function_935f8b619d093b69( var_3c23c40c437d68a4 )
{
    if ( !isdefined( level.var_a3ae2cc77a6db23 ) )
    {
        level.var_a3ae2cc77a6db23 = [];
    }
    
    level.var_a3ae2cc77a6db23 = arraycombineunique( level.var_a3ae2cc77a6db23, [ var_3c23c40c437d68a4 ] );
}

/#

    // Namespace loot_drops
    // Params 1
    // Checksum 0xe5173445, Offset: 0xd09
    // Size: 0x16, Type: dev
    function on_game_end_debug( sparams )
    {
        function_78f8115ada83c397();
    }

    // Namespace loot_drops
    // Params 1, eflags: 0x4
    // Checksum 0x64d0080d, Offset: 0xd27
    // Size: 0x121, Type: dev
    function private function_804dbb3463f72d1b( items )
    {
        if ( !isarray( items ) )
        {
            items = [ items ];
        }
        
        round_number = zm_utility::get_round_number();
        
        if ( !isdefined( level.var_1961b2d302f249a9[ round_number ] ) )
        {
            level.var_1961b2d302f249a9[ round_number ] = [];
        }
        
        foreach ( item in items )
        {
            if ( !isdefined( level.var_1961b2d302f249a9[ round_number ][ item.type ] ) )
            {
                level.var_1961b2d302f249a9[ round_number ][ item.type ] = 0;
            }
            
            level.var_1961b2d302f249a9[ round_number ][ item.type ] += 1;
        }
    }

    // Namespace loot_drops
    // Params 1
    // Checksum 0xfb4734fd, Offset: 0xe50
    // Size: 0x45c, Type: dev
    function function_78f8115ada83c397( params )
    {
        item_type_map = level.var_1961b2d302f249a9;
        
        if ( !isdefined( item_type_map ) )
        {
            return 0;
        }
        
        var_131a63e634da8a90 = [];
        var_64d5e2beef109bfa = 0;
        
        foreach ( round_number, item_type_list in item_type_map )
        {
            foreach ( item, drops in item_type_list )
            {
                if ( !isdefined( var_131a63e634da8a90[ item ] ) )
                {
                    var_131a63e634da8a90[ item ] = var_64d5e2beef109bfa;
                    var_64d5e2beef109bfa++;
                }
            }
        }
        
        var_664dda53b3e8f906 = [];
        var_ae67b853e899c2bc = [];
        
        foreach ( round_number, item_type_list in item_type_map )
        {
            var_a37a6d32f64b3a26 = [];
            
            for ( item_i = 0; item_i < var_64d5e2beef109bfa ; item_i++ )
            {
                var_a37a6d32f64b3a26[ item_i ] = 0;
            }
            
            foreach ( item, drops in item_type_list )
            {
                var_a37a6d32f64b3a26[ var_131a63e634da8a90[ item ] ] = drops;
            }
            
            var_afec73b6a54579e8 = string( round_number ) + "<dev string:x106>";
            var_3489c5b7073b0352 = string( round_number ) + "<dev string:x108>";
            
            foreach ( count in var_a37a6d32f64b3a26 )
            {
                var_afec73b6a54579e8 += string( count ) + "<dev string:x106>";
                var_3489c5b7073b0352 += string( count ) + "<dev string:x10d>";
            }
            
            var_664dda53b3e8f906[ var_664dda53b3e8f906.size ] = var_afec73b6a54579e8;
            var_ae67b853e899c2bc[ var_ae67b853e899c2bc.size ] = var_3489c5b7073b0352;
        }
        
        var_234761f7f3a3cf59 = "<dev string:x110>";
        var_9f36dff792492e3f = "<dev string:x11e>";
        
        for ( column_i = 0; column_i < var_131a63e634da8a90.size ; column_i++ )
        {
            category = function_f02c63b99c9614c9( var_131a63e634da8a90, column_i );
            var_234761f7f3a3cf59 += category + "<dev string:x106>";
            var_9f36dff792492e3f += category + "<dev string:x12e>";
        }
        
        filenum = openfile( "<dev string:x130>", "<dev string:x145>" );
        fprintln( filenum, var_234761f7f3a3cf59 );
        
        foreach ( printed_line in var_664dda53b3e8f906 )
        {
            fprintln( filenum, printed_line );
        }
        
        closefile( filenum );
        logstring( "<dev string:x14b>" );
        logstring( var_9f36dff792492e3f );
        
        foreach ( printed_line in var_ae67b853e899c2bc )
        {
            logstring( printed_line );
        }
        
        logstring( "<dev string:x160>" );
        iprintlnbold( "<dev string:x196>" );
    }

#/
