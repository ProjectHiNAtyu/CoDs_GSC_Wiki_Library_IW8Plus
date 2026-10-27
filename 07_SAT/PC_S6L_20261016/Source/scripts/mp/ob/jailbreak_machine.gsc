// scripts\mp\ob\jailbreak_machine.gsc  (hash_285497d06aec3901.gscc) (size: 18118 Bytes / 0x46c6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x706868fe (1885890814)
// size ...... 18118 (0x46c6)
// includes .. 19  (offset: 0x425e)
// strings ... 59  (offset: 0x42f6)
// dev strs .. 6   (offset: 0x467e)
// exports ... 31  (offset: 0x2fa2)
// cseg ...... 0x695 + 0x290d (0x2fa2)
// imports ... 108 (offset: 0x347a)
// animtree1 . 0   (offset: 0x46c6)
// animtree2 . 0   (offset: 0x46c6)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\save;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\gametypes\ob;
#using scripts\mp\hud_message;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\overlord;

#namespace jailbreak_machine;

// Namespace jailbreak_machine
// Params 0, eflags: 0x5
// Checksum 0x1a25e45f, Offset: 0x6b3
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"jailbreak_machine_debug", undefined, &jailbreak_machine_debug_init, undefined );
}

// Namespace jailbreak_machine
// Params 5
// Checksum 0x4028d6fe, Offset: 0x6d4
// Size: 0x1ac
function init( var_ed8905a751897e2f, rarity, var_f86aff2e377524e, allowedplayers, ischeat )
{
    assert( var_ed8905a751897e2f || rarity >= 1 && rarity <= 5, "<dev string:x24>" );
    
    if ( ob::nightmare() && !ischeat )
    {
        self setscriptablepartstate( "body", "off" );
        self setscriptablepartstate( "jailbreak_icon", "off" );
        self function_7653c765b6c7b815();
        return;
    }
    
    self.interact = interaction::register_scriptable_interact( self, &on_interact );
    self.interact interaction::set_interact_hint_callback( &jbm_per_player_hint );
    self.interact.var_9c7d8a932434abba = [];
    
    if ( level.var_bb86f77304f193c4.jailbreakpersist && isdefined( self.script_noteworthy ) )
    {
        missiondata = save::mission_get_data();
        var_e3ce483595d51c52 = missiondata.var_c7474a867aac7aeb[ self.script_noteworthy ];
        
        if ( isarray( var_e3ce483595d51c52 ) )
        {
            self.interact.var_9c7d8a932434abba = arraycopy( var_e3ce483595d51c52 );
        }
    }
    
    if ( !var_ed8905a751897e2f )
    {
        self.rarity = rarity;
    }
    else
    {
        region = region_difficulty_manager::function_f9fbb630598afdc7( self.origin );
        
        if ( isdefined( region ) )
        {
            self.rarity = region.difficultyint;
        }
    }
    
    if ( getdvarint( @"hash_1358a7d0601a94b3", 0 ) )
    {
        self.rarity = 5;
    }
    
    set_objective_complete( var_f86aff2e377524e, allowedplayers );
}

// Namespace jailbreak_machine
// Params 5
// Checksum 0xaa2e4951, Offset: 0x888
// Size: 0x237
function function_455ec409a27f78d9( origin, allowedplayers, lifetimesec, var_c1c7c26aa973a28e = 1, ischeat = 0 )
{
    groundpos = getclosestpointonnavmesh( origin );
    groundpos = getgroundposition( groundpos, 12 );
    yaw = 0;
    
    if ( var_c1c7c26aa973a28e )
    {
        numchecks = 4;
        angleit = 180 / numchecks;
        offset = 25;
        radius = 12;
        center = groundpos + ( 0, 0, 46 );
        collisioncontents = trace::create_contents( 0, 1, 1, 1, 1, 1, 1, 0, 1 );
        var_911356411b82de36 = 0;
        
        for ( i = 0; i < numchecks ; i++ )
        {
            checkyaw = i * angleit;
            offsetvec = ( cos( checkyaw ) * offset, sin( checkyaw ) * offset, 0 );
            clearpoints = 0;
            sign = -1;
            
            while ( sign <= 1 )
            {
                testcenter = center + offsetvec * sign;
                clear = trace::sphere_trace_passed( testcenter, testcenter, radius, level.players, collisioncontents );
                
                if ( clear )
                {
                    clearpoints++;
                }
                
                sign += 2;
            }
            
            if ( clearpoints > var_911356411b82de36 )
            {
                yaw = checkyaw;
                var_911356411b82de36 = clearpoints;
                
                if ( clearpoints == 2 )
                {
                    break;
                }
            }
        }
    }
    
    angles = ( 0, yaw, 0 );
    jailbreakentity = spawn( "script_model", groundpos );
    jailbreakentity.angles = angles;
    jailbreakentity setmodel( %"sat_electronics_exotic_upgrade_station" );
    jailbreakscriptable = jailbreakentity getlinkedscriptableinstance();
    jailbreakentity.unresolved_collision_func = &function_bc5dc6d06c63ab42;
    jailbreakscriptable init( 0, 5, 0, allowedplayers, ischeat );
    jailbreakscriptable.scriptable_index = jailbreakscriptable getscriptableindex();
    thread function_9231034cccec89ba( jailbreakentity, jailbreakscriptable, allowedplayers, lifetimesec );
    return jailbreakentity;
}

// Namespace jailbreak_machine
// Params 4, eflags: 0x4
// Checksum 0x5c4750e8, Offset: 0xac8
// Size: 0x137
function private function_9231034cccec89ba( jailbreakentity, var_a9b0455fb65fdc37, allowedplayers, lifetimesec )
{
    level endon( #"game_ended" );
    var_a9b0455fb65fdc37 set_objective_complete( 1, allowedplayers );
    
    foreach ( player in allowedplayers )
    {
        if ( isdefined( player ) )
        {
            ping_id = player calloutmarkerping::function_920a63c06abdefe8( var_a9b0455fb65fdc37.scriptable_index );
            player calloutmarkerping_hide( ping_id );
            player calloutmarkerping_show( ping_id, player );
        }
    }
    
    if ( ( lifetimesec ?? 0 ) <= 0 )
    {
        return;
    }
    
    wait lifetimesec;
    
    if ( jailbreakentity )
    {
        jailbreakentity calloutmarkerping::function_608710c894185549();
        jailbreakentity setscriptablepartstate( "body", "on_to_off_exotic" );
        jailbreakentity function_7653c765b6c7b815();
    }
    
    if ( var_a9b0455fb65fdc37 )
    {
        var_a9b0455fb65fdc37.var_f1a75838ea8dbde3 = 1;
    }
    
    wait 4.5;
    
    if ( jailbreakentity )
    {
        jailbreakentity delete();
    }
}

// Namespace jailbreak_machine
// Params 1, eflags: 0x4
// Checksum 0xf0ed3123, Offset: 0xc07
// Size: 0x1fb
function private on_interact( player )
{
    if ( self.interact.var_f86aff2e377524e == 0 || self.interact.var_9c7d8a932434abba[ player.guid ] || self.interact.var_1987e444154a0fbb && !arraycontains( self.interact.var_1987e444154a0fbb, player.guid ) )
    {
        return;
    }
    
    weapon_obj = player getcurrentweapon();
    
    if ( !function_8d7fec91b2a97bf0( weapon_obj ) )
    {
        return;
    }
    
    if ( function_b27b4b472fafc7a5( player, weapon_obj ) )
    {
        return;
    }
    
    var_812e89c01f3a0131 = getdvarint( @"hash_eb23aa83565a73bc", 1 );
    
    if ( var_812e89c01f3a0131 )
    {
        self disablescriptableplayeruse( player );
    }
    
    weapondata = player item_weapon::function_92b8514cdacab7f9( weapon_obj );
    
    if ( !isdefined( weapondata.itembundlename ) )
    {
        logstring( "[OB Jailbreak] No item bundle name found for weapon [" + ( weapon_obj.basename ?? " " ) + "] in player weapon data." );
    }
    
    interactiontype = calc_interaction_type( player );
    
    if ( !isdefined( self.current_interaction_type ) )
    {
        self.current_interaction_type = [];
    }
    
    self.current_interaction_type[ player getguid() ] = interactiontype;
    
    switch ( interactiontype )
    {
        case 0:
            if ( self.rarity == 5 )
            {
                function_6d262e28d48033fd( player );
            }
            else
            {
                set_rarity( player );
            }
            
            break;
        case 1:
            function_395fbfe09aa064d0( player );
            break;
        case 2:
            function_a47171aaeeb7ecec( player );
            break;
        case 3:
            function_1fa8effb48bd714e( player );
            break;
        default:
            break;
    }
    
    if ( var_812e89c01f3a0131 )
    {
        self enablescriptableplayeruse( player );
    }
}

// Namespace jailbreak_machine
// Params 4, eflags: 0x4
// Checksum 0x58788d6e, Offset: 0xe0a
// Size: 0x2c7
function private finalize_upgrade( player, oldweaponobj, newweaponobj, var_4bf296ec45cb4519 )
{
    self notify( #"jbm_used" );
    player notify( #"jbm_used" );
    function_85d952527be976f9( player, oldweaponobj, newweaponobj );
    
    if ( !self.var_f1a75838ea8dbde3 )
    {
        switch ( self.rarity )
        {
            case 1:
                self setscriptablepartstate( "body", "active_scan_uncommon" );
                break;
            case 2:
                self setscriptablepartstate( "body", "active_scan_rare" );
                break;
            case 3:
                self setscriptablepartstate( "body", "active_scan_epic" );
                break;
            case 4:
                self setscriptablepartstate( "body", "active_scan_legendary" );
                break;
            case 5:
                self setscriptablepartstate( "body", "active_scan_exotic" );
                break;
        }
    }
    
    if ( self.rarity == 5 )
    {
        player thread hud_message::showsplash( "exotic_weapon_upgraded" );
    }
    
    if ( !var_4bf296ec45cb4519 )
    {
        self.interact.var_9c7d8a932434abba[ player.guid ] = 1;
        
        if ( isdefined( self.selected_attachments[ player.guid ] ) )
        {
            self.selected_attachments[ player.guid ] = undefined;
        }
        
        if ( isdefined( self.selected_mods[ player.guid ] ) )
        {
            self.selected_mods[ player.guid ] = undefined;
        }
        
        if ( isdefined( self.var_dc63dfd6702cb252[ player.guid ] ) )
        {
            self.var_dc63dfd6702cb252[ player.guid ] = undefined;
        }
    }
    else
    {
        if ( !isdefined( self.committed_weapon ) )
        {
            self.committed_weapon = [];
        }
        
        self.committed_weapon[ player.guid ] = newweaponobj.baseweaponlootid;
    }
    
    if ( level.var_bb86f77304f193c4.jailbreakpersist && isdefined( self.script_noteworthy ) )
    {
        missiondata = save::mission_get_data();
        
        if ( missiondata )
        {
            missiondata.var_c7474a867aac7aeb[ self.script_noteworthy ][ player.guid ] = 1;
        }
    }
    
    level thread overlord::playevent( "tacb_wcjailbreaksuccess", [ player ] );
    player playsoundtoplayer( "uin_jailbreak_upgrade_wpn_plr", player );
    level callback::callback( #"hash_91f2a0e70afebfe1", { #jailbreakmachine:self, #interactionevent:#"hash_51e40c907cc5dbce", #player:player } );
}

// Namespace jailbreak_machine
// Params 3, eflags: 0x4
// Checksum 0xb5a0c3c8, Offset: 0x10d9
// Size: 0xc7
function private function_85d952527be976f9( player, oldweaponobj, newweaponobj )
{
    clipsizenew = weaponclipsize( newweaponobj );
    var_606e326e67df2a95 = utility::get_max_stock_ammo( newweaponobj, 0 );
    oldammomod = player utility::callsharedfunc( #"ammo_mod", #"hash_cf1012c4d313de70", oldweaponobj );
    player takeweapon( oldweaponobj );
    player giveweapon( newweaponobj );
    player switchtoweapon( newweaponobj );
    player setweaponammoclip( newweaponobj, clipsizenew );
    player setweaponammostock( newweaponobj, var_606e326e67df2a95 );
    player utility::callsharedfunc( #"ammo_mod", #"hash_24f1a2cf1ed6660d", newweaponobj, oldammomod );
    
    if ( player weapon::function_6b74ecd475e99b4( newweaponobj ) )
    {
        player weapon::function_b4c9549dee5d0fc5( newweaponobj );
    }
}

// Namespace jailbreak_machine
// Params 1, eflags: 0x4
// Checksum 0x35583757, Offset: 0x11a8
// Size: 0x60
function private set_rarity( player )
{
    weaponobj = player getcurrentweapon();
    currentrarity = player item_weapon::function_fb81bd2fe070faa6( weaponobj );
    
    if ( currentrarity >= self.rarity )
    {
        return;
    }
    
    player item_weapon::function_40e1cbd0e1f47d1a( weaponobj, self.rarity );
    finalize_upgrade( player, weaponobj, weaponobj, 0 );
}

// Namespace jailbreak_machine
// Params 1, eflags: 0x4
// Checksum 0x10d7d5d9, Offset: 0x1210
// Size: 0x101
function private function_6d262e28d48033fd( player )
{
    weaponobj = player getcurrentweapon();
    currentrarity = player item_weapon::function_fb81bd2fe070faa6( weaponobj );
    
    if ( currentrarity >= self.rarity )
    {
        return;
    }
    
    itembundlename = item_weapon::function_3da93a43aae4473d( weaponobj.basename, self.rarity );
    itembundle = isdefined( itembundlename ) ? common_item::function_90c3e0c1fd55d6b6( itembundlename ) : undefined;
    
    if ( itembundle.rarity != self.rarity )
    {
        /#
            logstring( "<dev string:x77>" + weaponobj.basename + "<dev string:x9a>" + self.rarity );
        #/
    }
    else
    {
        choice = function_b6e3bbf5deb7e0a4( player, weaponobj, itembundlename, undefined );
        
        if ( choice != 0 )
        {
            return;
        }
    }
    
    player item_weapon::function_40e1cbd0e1f47d1a( weaponobj, self.rarity );
    finalize_upgrade( player, weaponobj, weaponobj, 0 );
}

// Namespace jailbreak_machine
// Params 1, eflags: 0x4
// Checksum 0x76038af, Offset: 0x1319
// Size: 0x268
function private function_a7fa55e9770deddb( player )
{
    weaponobj = player getcurrentweapon();
    var_984f6ed6dce715e6 = player utility::callsharedfunc( #"zombie", #"get_ammo_mod_name", weaponobj );
    
    if ( !isdefined( self.selected_mods ) )
    {
        self.selected_mods = [];
    }
    
    if ( !isdefined( self.selected_mods[ player.guid ] ) )
    {
        modkeys = getarraykeys( level.var_b7d9d7926154819d.ammomodbundles );
        randomidx = randomint( modkeys.size );
        mod = level.var_b7d9d7926154819d.ammomodbundles[ modkeys[ randomidx ] ];
        altmod = mod;
        
        if ( modkeys.size > 1 )
        {
            modkeys[ randomidx ] = modkeys[ modkeys.size - 1 ];
            randomidx = randomint( modkeys.size - 1 );
            altmod = level.var_b7d9d7926154819d.ammomodbundles[ modkeys[ randomidx ] ];
        }
        
        self.selected_mods[ player.guid ] = { #altmod:altmod.ammomodname, #mod:mod.ammomodname };
    }
    
    if ( var_984f6ed6dce715e6 == self.selected_mods[ player.guid ].mod )
    {
        var_3b92061d4f7b8516 = self.selected_mods[ player.guid ].altmod;
    }
    else
    {
        var_3b92061d4f7b8516 = self.selected_mods[ player.guid ].mod;
    }
    
    var_c85b040bac1cd110 = player utility::callsharedfunc( #"ammo_mod", #"hash_ddbe3f904027bd04", var_3b92061d4f7b8516 );
    var_5e345b7563120cc5 = { #new:{ #id:var_c85b040bac1cd110, #name:var_3b92061d4f7b8516 } };
    
    if ( var_984f6ed6dce715e6 != "" )
    {
        var_ab962fddd22e7b20 = player utility::callsharedfunc( #"ammo_mod", #"hash_ddbe3f904027bd04", var_984f6ed6dce715e6 );
        var_5e345b7563120cc5.current = { #id:var_ab962fddd22e7b20, #name:var_984f6ed6dce715e6 };
    }
    
    return var_5e345b7563120cc5;
}

// Namespace jailbreak_machine
// Params 1, eflags: 0x4
// Checksum 0x9f0b3820, Offset: 0x158a
// Size: 0x254
function private function_a8a18ea346b8948f( player )
{
    weaponobj = player getcurrentweapon();
    weapondata = player item_weapon::function_92b8514cdacab7f9( weaponobj );
    attachments = function_af10899d33befafb( weapondata.itembundlename );
    assert( attachments.size > 0, "<dev string:xa8>" + ( weaponobj.basename ?? "<dev string:x10e>" ) + "<dev string:x110>" );
    var_5bfcd810a4dc6d12 = function_41ae4a2d22dd1d2a( weaponobj );
    possibleattachments = attachments;
    
    if ( isdefined( var_5bfcd810a4dc6d12 ) )
    {
        possibleattachments = [];
        
        foreach ( attachment in attachments )
        {
            if ( attachment != var_5bfcd810a4dc6d12 )
            {
                possibleattachments[ possibleattachments.size ] = attachment;
            }
        }
    }
    
    var_5f429aeecb6159c4 = weaponobj.baseweaponlootid;
    
    if ( !isdefined( self.selected_attachments ) )
    {
        self.selected_attachments = [];
    }
    
    if ( !isdefined( self.selected_attachments[ player.guid ] ) )
    {
        self.selected_attachments[ player.guid ] = [];
    }
    
    if ( !isdefined( self.selected_attachments[ player.guid ][ var_5f429aeecb6159c4 ] ) || !arraycontains( possibleattachments, self.selected_attachments[ player.guid ][ var_5f429aeecb6159c4 ] ) )
    {
        self.selected_attachments[ player.guid ][ var_5f429aeecb6159c4 ] = possibleattachments[ randomint( possibleattachments.size ) ];
    }
    
    selectedattachment = self.selected_attachments[ player.guid ][ var_5f429aeecb6159c4 ];
    var_5e345b7563120cc5 = { #new:{ #lootid:loot::getlootidfromref( selectedattachment ), #name:selectedattachment } };
    
    if ( isdefined( var_5bfcd810a4dc6d12 ) )
    {
        var_5e345b7563120cc5.current = { #lootid:loot::getlootidfromref( var_5bfcd810a4dc6d12 ), #name:var_5bfcd810a4dc6d12 };
    }
    
    return var_5e345b7563120cc5;
}

// Namespace jailbreak_machine
// Params 3, eflags: 0x4
// Checksum 0xed301162, Offset: 0x17e7
// Size: 0x13a
function private function_ace198ee358447( player, weaponobj, var_e7c1bdbd7379deb3 )
{
    var_e96aeb2cd1740bd2 = player utility::callsharedfunc( #"ammo_mod", #"hash_cf1012c4d313de70", weaponobj );
    player utility::callsharedfunc( #"ammo_mod", #"hash_24f1a2cf1ed6660d", weaponobj, var_e7c1bdbd7379deb3 );
    var_4bf296ec45cb4519 = var_e96aeb2cd1740bd2 && var_e96aeb2cd1740bd2 != "";
    
    if ( var_4bf296ec45cb4519 )
    {
        if ( !isdefined( self.var_dc63dfd6702cb252 ) )
        {
            self.var_dc63dfd6702cb252 = [];
        }
        
        if ( !isdefined( self.var_dc63dfd6702cb252[ player.guid ] ) )
        {
            self.var_dc63dfd6702cb252[ player.guid ] = [];
        }
        
        self.var_dc63dfd6702cb252[ player.guid ][ weaponobj.baseweaponlootid ] = 2;
        
        if ( !isdefined( self.selected_mods ) )
        {
            self.selected_mods = [];
        }
        
        self.selected_mods[ player.guid ] = { #altmod:var_e96aeb2cd1740bd2, #mod:var_e96aeb2cd1740bd2 };
    }
    
    finalize_upgrade( player, weaponobj, weaponobj, var_4bf296ec45cb4519 );
}

// Namespace jailbreak_machine
// Params 4, eflags: 0x4
// Checksum 0xb60d94f, Offset: 0x1929
// Size: 0x13a
function private function_c123d55d1e3ccea2( player, weaponobj, var_d3cd957048c5102, var_13ad4accca7d3399 )
{
    newweaponobj = weaponobj;
    var_4bf296ec45cb4519 = 0;
    
    if ( var_13ad4accca7d3399 )
    {
        newweaponobj = newweaponobj withoutattachment( var_13ad4accca7d3399 );
        var_4bf296ec45cb4519 = 1;
        
        if ( !isdefined( self.var_dc63dfd6702cb252 ) )
        {
            self.var_dc63dfd6702cb252 = [];
        }
        
        if ( !isdefined( self.var_dc63dfd6702cb252[ player.guid ] ) )
        {
            self.var_dc63dfd6702cb252[ player.guid ] = [];
        }
        
        self.var_dc63dfd6702cb252[ player.guid ][ weaponobj.baseweaponlootid ] = 1;
        
        if ( !isdefined( self.selected_attachments ) )
        {
            self.selected_attachments = [];
        }
        
        if ( !isdefined( self.selected_attachments[ player.guid ] ) )
        {
            self.selected_attachments[ player.guid ] = [];
        }
        
        self.selected_attachments[ player.guid ][ weaponobj.baseweaponlootid ] = var_13ad4accca7d3399;
    }
    
    newweaponobj = newweaponobj withattachment( var_d3cd957048c5102 );
    finalize_upgrade( player, weaponobj, newweaponobj, var_4bf296ec45cb4519 );
}

// Namespace jailbreak_machine
// Params 1
// Checksum 0x9bd546ae, Offset: 0x1a6b
// Size: 0x167
function function_a47171aaeeb7ecec( player )
{
    weaponobj = player getcurrentweapon();
    weapondata = player item_weapon::function_92b8514cdacab7f9( weaponobj );
    modchanges = function_a7fa55e9770deddb( player );
    currentbundle = undefined;
    
    if ( isdefined( modchanges.new.id ) )
    {
        player setclientomnvar( "ui_ob_selectable_reward_ammo_mod_index_1", modchanges.new.id );
        player setclientomnvar( "ui_ob_selectable_reward_is_weapon_trait_1", 1 );
    }
    
    if ( isdefined( modchanges.current.id ) )
    {
        currentbundle = weapondata.itembundlename;
        player setclientomnvar( "ui_ob_selectable_reward_is_equipped_2", 1 );
        player setclientomnvar( "ui_ob_selectable_reward_ammo_mod_index_2", modchanges.current.id );
        player setclientomnvar( "ui_ob_selectable_reward_is_weapon_trait_2", 1 );
        player setclientomnvar( "ui_ob_selectable_reward_is_new_1", 1 );
    }
    
    player setclientomnvar( "ui_ob_selectable_reward_conversion_id_1", 0 );
    player setclientomnvar( "ui_ob_selectable_reward_conversion_id_2", 0 );
    choice = function_b6e3bbf5deb7e0a4( player, weaponobj, weapondata.itembundlename, currentbundle );
    
    if ( choice == 0 )
    {
        function_ace198ee358447( player, weaponobj, modchanges.new.name );
    }
}

// Namespace jailbreak_machine
// Params 1
// Checksum 0x564edaee, Offset: 0x1bda
// Size: 0x17e
function function_395fbfe09aa064d0( player )
{
    weaponobj = player getcurrentweapon();
    weapondata = player item_weapon::function_92b8514cdacab7f9( weaponobj );
    attachmentchanges = function_a8a18ea346b8948f( player );
    currentbundle = undefined;
    
    if ( isdefined( attachmentchanges.current.lootid ) )
    {
        currentbundle = weapondata.itembundlename;
        player setclientomnvar( "ui_ob_selectable_reward_is_equipped_2", 1 );
        player setclientomnvar( "ui_ob_selectable_reward_conversion_id_2", attachmentchanges.current.lootid );
        player setclientomnvar( "ui_ob_selectable_reward_is_weapon_trait_2", 1 );
        player setclientomnvar( "ui_ob_selectable_reward_is_new_1", 1 );
    }
    
    if ( isdefined( attachmentchanges.new.lootid ) )
    {
        player setclientomnvar( "ui_ob_selectable_reward_conversion_id_1", attachmentchanges.new.lootid );
        player setclientomnvar( "ui_ob_selectable_reward_is_weapon_trait_1", 1 );
    }
    
    player setclientomnvar( "ui_ob_selectable_reward_ammo_mod_index_1", -1 );
    player setclientomnvar( "ui_ob_selectable_reward_ammo_mod_index_2", -1 );
    choice = function_b6e3bbf5deb7e0a4( player, weaponobj, weapondata.itembundlename, currentbundle );
    
    if ( choice == 0 )
    {
        function_c123d55d1e3ccea2( player, weaponobj, attachmentchanges.new.name, attachmentchanges.current.name );
    }
}

// Namespace jailbreak_machine
// Params 1
// Checksum 0xb136582f, Offset: 0x1d60
// Size: 0x21f
function function_1fa8effb48bd714e( player )
{
    weaponobj = player getcurrentweapon();
    weapondata = player item_weapon::function_92b8514cdacab7f9( weaponobj );
    attachmentchanges = function_a8a18ea346b8948f( player );
    modchanges = function_a7fa55e9770deddb( player );
    
    if ( isdefined( modchanges.current.id ) )
    {
        player setclientomnvar( "ui_ob_selectable_reward_ammo_mod_index_1", modchanges.current.id );
        player setclientomnvar( "ui_ob_selectable_reward_is_weapon_trait_1", 1 );
    }
    
    player setclientomnvar( "ui_ob_selectable_reward_ammo_mod_index_2", -1 );
    
    if ( isdefined( attachmentchanges.current.lootid ) )
    {
        player setclientomnvar( "ui_ob_selectable_reward_conversion_id_2", attachmentchanges.current.lootid );
        player setclientomnvar( "ui_ob_selectable_reward_is_weapon_trait_2", 1 );
    }
    
    player setclientomnvar( "ui_ob_selectable_reward_conversion_id_1", 0 );
    choice = function_b6e3bbf5deb7e0a4( player, weaponobj, weapondata.itembundlename, weapondata.itembundlename );
    
    if ( choice == 0 )
    {
        if ( !isdefined( self.var_dc63dfd6702cb252 ) )
        {
            self.var_dc63dfd6702cb252 = [];
        }
        
        if ( !isdefined( self.var_dc63dfd6702cb252[ player.guid ] ) )
        {
            self.var_dc63dfd6702cb252[ player.guid ] = [];
        }
        
        self.var_dc63dfd6702cb252[ player.guid ][ weaponobj.baseweaponlootid ] = 2;
        function_a47171aaeeb7ecec( player );
        return;
    }
    
    if ( choice == 1 )
    {
        if ( !isdefined( self.var_dc63dfd6702cb252 ) )
        {
            self.var_dc63dfd6702cb252 = [];
        }
        
        if ( !isdefined( self.var_dc63dfd6702cb252[ player.guid ] ) )
        {
            self.var_dc63dfd6702cb252[ player.guid ] = [];
        }
        
        self.var_dc63dfd6702cb252[ player.guid ][ weaponobj.baseweaponlootid ] = 1;
        function_395fbfe09aa064d0( player );
    }
}

// Namespace jailbreak_machine
// Params 2, eflags: 0x4
// Checksum 0x168d07ef, Offset: 0x1f87
// Size: 0x412
function private jbm_per_player_hint( usable, player )
{
    weapon_obj = player getcurrentweapon();
    currentrarity = player item_weapon::function_fb81bd2fe070faa6( weapon_obj );
    
    switch ( usable.rarity )
    {
        case 1:
            player setclientomnvar( "ui_interact_jailbreak_rarity", 1 );
            break;
        case 2:
            player setclientomnvar( "ui_interact_jailbreak_rarity", 2 );
            break;
        case 3:
            player setclientomnvar( "ui_interact_jailbreak_rarity", 3 );
            break;
        case 4:
            player setclientomnvar( "ui_interact_jailbreak_rarity", 4 );
            break;
        case 5:
            player setclientomnvar( "ui_interact_jailbreak_rarity", 7 );
            break;
    }
    
    hintstring_obj = { #icon:undefined, #description:&"sat_ob/jailbreak_description", #title:&"sat_ob/jailbreak_title", #type:"HINT_GAMETYPE_SPECIFIC" };
    isexotic = usable.rarity == 5;
    
    if ( isexotic )
    {
        hintstring_obj.title = &"sat_ob/jailbreak_exotic_title";
        interactiontype = usable calc_interaction_type( player );
        
        switch ( interactiontype )
        {
            case 0:
                hintstring_obj.description = &"sat_ob/jailbreak_exotic_description";
                break;
            case 1:
                hintstring_obj.description = &"sat_ob/jailbreak_exotic_add_attachment_description";
                break;
            case 2:
                hintstring_obj.description = &"sat_ob/jailbreak_exotic_add_mod_description";
                break;
            case 3:
                hintstring_obj.description = &"sat_ob/jailbreak_exotic_reroll_description";
                break;
            default:
                hintstring_obj.description = &"sat_ob/jailbreak_exotic_description";
                break;
        }
    }
    
    if ( usable.interact.var_f86aff2e377524e == 0 || usable.interact.var_1987e444154a0fbb && !arraycontains( usable.interact.var_1987e444154a0fbb, player.guid ) )
    {
        player setclientomnvar( "ui_interact_jailbreak_is_locked", 1 );
        
        if ( usable.isexpired )
        {
            hintstring_obj.description = &"sat_ob/jailbreak_expired";
        }
        else
        {
            hintstring_obj.description = &"sat_ob/jailbreak_complete_to_use";
        }
    }
    else if ( usable.interact.var_9c7d8a932434abba[ player.guid ] )
    {
        player setclientomnvar( "ui_interact_jailbreak_is_locked", 1 );
        hintstring_obj.description = &"sat_ob/jailbreak_already_used";
    }
    else if ( !function_8d7fec91b2a97bf0( weapon_obj ) )
    {
        player setclientomnvar( "ui_interact_jailbreak_is_locked", 1 );
        hintstring_obj.description = &"sat_ob/jailbreak_cannot_upgrade_weapon";
    }
    else if ( currentrarity > usable.rarity && !isexotic )
    {
        player setclientomnvar( "ui_interact_jailbreak_is_locked", 1 );
        hintstring_obj.description = &"SHARED_HINTSTRINGS/CURRENT_WEAPON_RARITY_BETTER";
    }
    else if ( usable function_b27b4b472fafc7a5( player, weapon_obj ) )
    {
        player setclientomnvar( "ui_interact_jailbreak_is_locked", 1 );
        hintstring_obj.description = &"sat_ob/jailbreak_exotic_other_weapon_rerolled";
    }
    else if ( ( !isexotic || interactiontype == 0 ) && currentrarity == usable.rarity )
    {
        player setclientomnvar( "ui_interact_jailbreak_is_locked", 1 );
        hintstring_obj.description = &"SHARED_HINTSTRINGS/CURRENT_WEAPON_RARITY_SAME";
    }
    else
    {
        player setclientomnvar( "ui_interact_jailbreak_is_locked", 0 );
    }
    
    return hintstring_obj;
}

// Namespace jailbreak_machine
// Params 2
// Checksum 0xd6ec75f4, Offset: 0x23a2
// Size: 0x2b2
function set_objective_complete( var_72b41427ddd671e, players )
{
    self.interact.var_f86aff2e377524e = var_72b41427ddd671e;
    
    if ( players )
    {
        self.interact.var_1987e444154a0fbb = [];
        
        foreach ( player in players )
        {
            self.interact.var_1987e444154a0fbb[ self.interact.var_1987e444154a0fbb.size ] = player.guid;
        }
    }
    else
    {
        self.interact.var_1987e444154a0fbb = undefined;
    }
    
    if ( var_72b41427ddd671e )
    {
        switch ( self.rarity ?? 1 )
        {
            case 1:
                self setscriptablepartstate( "body", "off_to_on_uncommon" );
                self setscriptablepartstate( "jailbreak_icon", "on_uncommon" );
                break;
            case 2:
                self setscriptablepartstate( "body", "off_to_on_rare" );
                self setscriptablepartstate( "jailbreak_icon", "on_rare" );
                break;
            case 3:
                self setscriptablepartstate( "body", "off_to_on_epic" );
                self setscriptablepartstate( "jailbreak_icon", "on_epic" );
                break;
            case 4:
                self setscriptablepartstate( "body", "off_to_on_legendary" );
                self setscriptablepartstate( "jailbreak_icon", "on_legendary" );
                break;
            case 5:
                self setscriptablepartstate( "body", "off_to_on_exotic" );
                self setscriptablepartstate( "jailbreak_icon", "on_exotic" );
                break;
        }
        
        return;
    }
    
    switch ( self.rarity ?? 1 )
    {
        case 1:
            self setscriptablepartstate( "body", "off_uncommon" );
            break;
        case 2:
            self setscriptablepartstate( "body", "off_rare" );
            break;
        case 3:
            self setscriptablepartstate( "body", "off_epic" );
            break;
        case 4:
            self setscriptablepartstate( "body", "off_legendary" );
            break;
        case 5:
            self setscriptablepartstate( "body", "off_exotic" );
            break;
    }
}

// Namespace jailbreak_machine
// Params 1, eflags: 0x4
// Checksum 0xd2d31246, Offset: 0x265c
// Size: 0x148
function private calc_interaction_type( player )
{
    if ( self.rarity != 5 )
    {
        return 0;
    }
    
    weaponobj = player getcurrentweapon();
    weapondata = player item_weapon::function_92b8514cdacab7f9( weaponobj );
    currentrarity = weapondata.rarity ?? 0;
    
    if ( self.rarity > currentrarity )
    {
        return 0;
    }
    
    attachments = function_af10899d33befafb( weapondata.itembundlename );
    var_5fda1e1df5ebb63d = function_7619a0c096e8bf15( weaponobj, attachments );
    var_a2e85163e0d0c352 = function_50964d2b5aee6dc9( player, weaponobj );
    forcedchoice = self.var_dc63dfd6702cb252[ player.guid ][ weaponobj.baseweaponlootid ];
    
    if ( !var_5fda1e1df5ebb63d && !var_a2e85163e0d0c352 )
    {
        return 0;
    }
    
    if ( var_5fda1e1df5ebb63d && ( !isdefined( function_41ae4a2d22dd1d2a( weaponobj ) ) || !var_a2e85163e0d0c352 || forcedchoice == 1 ) )
    {
        return 1;
    }
    
    if ( var_a2e85163e0d0c352 && ( !player utility::callsharedfunc( #"zombie", #"has_ammo_mod", weaponobj ) || !var_5fda1e1df5ebb63d || forcedchoice == 2 ) )
    {
        return 2;
    }
    
    return 3;
}

// Namespace jailbreak_machine
// Params 1, eflags: 0x4
// Checksum 0x295e472b, Offset: 0x27ad
// Size: 0x3b, Type: bool
function private function_8d7fec91b2a97bf0( weaponobj )
{
    var_3f9b4d6dbd70e000 = weapon::isfistweaponobject( weaponobj ) || weapon::iskillstreakweapon( weaponobj ) || weapon::issuperweapon( weaponobj );
    return !var_3f9b4d6dbd70e000;
}

// Namespace jailbreak_machine
// Params 1, eflags: 0x4
// Checksum 0x24bc720f, Offset: 0x27f1
// Size: 0x1a0
function private function_af10899d33befafb( itembundlename )
{
    if ( !isdefined( itembundlename ) )
    {
        return [];
    }
    
    if ( !isdefined( level.var_a594deb7300556fc ) )
    {
        level.var_a594deb7300556fc = [];
    }
    
    if ( isdefined( level.var_a594deb7300556fc[ itembundlename ] ) )
    {
        return level.var_a594deb7300556fc[ itembundlename ];
    }
    
    level.var_a594deb7300556fc[ itembundlename ] = [];
    attachmentslots = getscriptbundlefieldvalue( itembundlename, #"attachmentslots" );
    
    foreach ( entry in attachmentslots )
    {
        if ( entry.slot == "conversionkit" )
        {
            if ( !entry.includeall )
            {
                foreach ( attachment in entry.includelist )
                {
                    level.var_a594deb7300556fc[ itembundlename ][ level.var_a594deb7300556fc[ itembundlename ].size ] = attachment.attachment;
                }
            }
            
            break;
        }
    }
    
    return level.var_a594deb7300556fc[ itembundlename ];
}

// Namespace jailbreak_machine
// Params 1, eflags: 0x4
// Checksum 0x88eca409, Offset: 0x299a
// Size: 0x17
function private function_41ae4a2d22dd1d2a( weaponobj )
{
    return weaponobj.conversionkit;
}

// Namespace jailbreak_machine
// Params 2, eflags: 0x4
// Checksum 0x917dc78f, Offset: 0x29ba
// Size: 0x7f, Type: bool
function private function_50964d2b5aee6dc9( player, weaponobj )
{
    if ( !player utility::callsharedfunc( #"ammo_mod", #"hash_4f3b91e6539bb512", weaponobj ) )
    {
        return false;
    }
    
    var_e13265c6a256eeec = player utility::callsharedfunc( #"zombie", #"has_ammo_mod", weaponobj ) ? 1 : 0;
    return level.var_b7d9d7926154819d.ammomodbundles.size > var_e13265c6a256eeec;
}

// Namespace jailbreak_machine
// Params 2, eflags: 0x4
// Checksum 0x2ed38b90, Offset: 0x2a42
// Size: 0x33, Type: bool
function private function_7619a0c096e8bf15( weaponobj, var_dc5bfc0be879cb95 )
{
    return var_dc5bfc0be879cb95.size > 1 || var_dc5bfc0be879cb95.size == 1 && !weaponobj hasattachment( var_dc5bfc0be879cb95[ 0 ] );
}

// Namespace jailbreak_machine
// Params 2, eflags: 0x4
// Checksum 0x5c00ba8b, Offset: 0x2a7e
// Size: 0x50, Type: bool
function private function_b27b4b472fafc7a5( player, weaponobj )
{
    return isdefined( self.committed_weapon[ player.guid ] ) && self.committed_weapon[ player.guid ] != weaponobj.baseweaponlootid;
}

// Namespace jailbreak_machine
// Params 4, eflags: 0x4
// Checksum 0x3db26e00, Offset: 0x2ad7
// Size: 0x25d
function private function_b6e3bbf5deb7e0a4( player, weaponobj, var_3325d0eb2231cf18, var_3325d3eb2231d5b1 )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    var_75385495715741fb = self;
    attachmentcount = 0;
    defaultattachments = getweapondefaultattachments( weaponobj );
    
    foreach ( attachment in weaponobj.attachments )
    {
        if ( "conversionkit" == getattachmentslot( weaponobj, attachment ) )
        {
            continue;
        }
        
        if ( arraycontains( defaultattachments, attachment ) )
        {
            continue;
        }
        
        if ( !utility::callsharedfunc( #"weapons", #"hash_35d31d8d23e44a0", weaponobj, attachment ) )
        {
            continue;
        }
        
        attachmentcount += 1;
    }
    
    player setclientomnvar( "ui_ob_selectable_reward_num_attachments_1", minint( 8, attachmentcount ) );
    player setclientomnvar( "ui_ob_selectable_reward_num_attachments_2", minint( 8, attachmentcount ) );
    player setclientomnvar( "ui_ob_selectable_reward_is_jailbreak", 1 );
    player thread function_2b2e5a0d4dff0567();
    choice = player ob_item_select::function_55bae6c0c5e50953( self, var_3325d0eb2231cf18, var_3325d3eb2231d5b1 );
    
    if ( isdefined( player ) )
    {
        player notify( #"hash_830996590df6bc4" );
        player setclientomnvar( "ui_ob_selectable_reward_is_jailbreak", 0 );
        
        for ( i = 0; i < 2 ; i++ )
        {
            j = i + 1;
            player setclientomnvar( "ui_ob_selectable_reward_id_" + j, 0 );
            player setclientomnvar( "ui_ob_selectable_reward_conversion_id_" + j, 0 );
            player setclientomnvar( "ui_ob_selectable_reward_ammo_mod_index_" + j, 0 );
            player setclientomnvar( "ui_ob_selectable_reward_is_loadout_weapon_" + j, 0 );
            player setclientomnvar( "ui_ob_selectable_reward_num_attachments_" + j, 0 );
            player setclientomnvar( "ui_ob_selectable_reward_is_equipped_" + j, 0 );
            player setclientomnvar( "ui_ob_selectable_reward_is_new_" + j, 0 );
            player setclientomnvar( "ui_ob_selectable_reward_is_weapon_trait_" + j, 0 );
        }
    }
    
    if ( !isdefined( player ) || !isdefined( var_75385495715741fb ) || weaponobj != player getcurrentweapon() )
    {
        return;
    }
    
    return choice;
}

// Namespace jailbreak_machine
// Params 0, eflags: 0x4
// Checksum 0x879bb3c6, Offset: 0x2d3d
// Size: 0x56
function private function_2b2e5a0d4dff0567()
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"hash_830996590df6bc4" );
    player waittill( #"weapon_change" );
    
    if ( isdefined( player ) )
    {
        player notify( #"deactivate_ob_reward_select" );
    }
}

// Namespace jailbreak_machine
// Params 0
// Checksum 0x7ba2aff8, Offset: 0x2d9b
// Size: 0x43
function jailbreak_machine_debug_init()
{
    var_2007867e0cbe557a = game_utility::getgametype() != "ob";
    
    if ( var_2007867e0cbe557a )
    {
        devgui::function_9082edeb5db93280( "OB/Exotic Machine/" );
        devgui::add_devgui_command( "Spawn Exotic Machine", "setsv cheat_ob_spawn_exotic_machine 1" );
        devgui::function_77df7fe7dd273e10();
    }
}

// Namespace jailbreak_machine
// Params 2, eflags: 0x4
// Checksum 0x9885bc69, Offset: 0x2de6
// Size: 0x5a
function private function_bc5dc6d06c63ab42( hitent, penetration )
{
    if ( isplayer( hitent ) && isalive( hitent ) )
    {
        position = hitent.origin;
        ground_pos = getgroundposition( position, 12 );
        hitent setorigin( ground_pos, 0 );
    }
}

// Namespace jailbreak_machine
// Params 2
// Checksum 0x2b6e83a1, Offset: 0x2e48
// Size: 0x159
function function_65beb4d48e86186c( player, var_db82bf22d6e9396a )
{
    weaponobj = player getcurrentweapon();
    
    if ( !function_8d7fec91b2a97bf0( weaponobj ) )
    {
        return;
    }
    
    weapondata = player item_weapon::function_92b8514cdacab7f9( weaponobj );
    attachments = function_af10899d33befafb( var_db82bf22d6e9396a ?? weapondata.itembundlename );
    var_5fda1e1df5ebb63d = function_7619a0c096e8bf15( weaponobj, attachments );
    
    if ( !var_5fda1e1df5ebb63d )
    {
        return;
    }
    
    var_ce5b60579efa91fe = 0;
    newweaponobj = weaponobj;
    var_5bfcd810a4dc6d12 = function_41ae4a2d22dd1d2a( weaponobj );
    
    if ( isdefined( var_5bfcd810a4dc6d12 ) )
    {
        foreach ( idx, attachment in attachments )
        {
            if ( attachment == var_5bfcd810a4dc6d12 )
            {
                var_ce5b60579efa91fe = ( idx + 1 ) % attachments.size;
                break;
            }
        }
        
        newweaponobj = weaponobj withoutattachment( var_5bfcd810a4dc6d12 );
    }
    
    newattachment = attachments[ var_ce5b60579efa91fe ];
    newweaponobj = newweaponobj withattachment( newattachment );
    function_85d952527be976f9( player, weaponobj, newweaponobj );
    return newweaponobj;
}

