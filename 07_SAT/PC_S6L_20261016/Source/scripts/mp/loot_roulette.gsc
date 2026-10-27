// scripts\mp\loot_roulette.gsc  (hash_632a4a0e85065673.gscc) (size: 8644 Bytes / 0x21c4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe082d0fc (3766669564)
// size ...... 8644 (0x21c4)
// includes .. 8   (offset: 0x2014)
// strings ... 13  (offset: 0x2054)
// dev strs .. 16  (offset: 0x20fc)
// exports ... 21  (offset: 0x1648)
// cseg ...... 0x162 + 0x14e6 (0x1648)
// imports ... 56  (offset: 0x1990)
// animtree1 . 0   (offset: 0x21c4)
// animtree2 . 0   (offset: 0x21c4)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\loot\common_item;

#namespace loot_roulette;

// Namespace loot_roulette
// Params 0, eflags: 0x5
// Checksum 0x66aa476c, Offset: 0x180
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"loot_roulette", undefined, undefined, &init_loot_roulette );
}

// Namespace loot_roulette
// Params 0, eflags: 0x4
// Checksum 0xbd6eb3c8, Offset: 0x1a1
// Size: 0xba
function private init_loot_roulette()
{
    mapinfo = getactivemapinfobundle();
    
    if ( isdefined( mapinfo.var_7541116ec628cc98 ) && mapinfo.var_7541116ec628cc98 != %"" )
    {
        level.var_65153800cb31d1b0 = getscriptbundle( mapinfo.var_7541116ec628cc98 );
        level.var_af377340b04ddc72 = [];
        thread function_f9625cc265a33f0a();
        function_9773f598d53d6b4();
        val::group_register( "roulette_ai_spawn", [ "damage", "show_healthbar" ] );
        scriptable::scriptable_adddamagedcallback( &function_3e8015831332f8cd );
        
        /#
            function_eb862349e4ef2b17();
        #/
        
        utility::flag_set( "loot_roulette_initialized" );
        return;
    }
    
    utility::flag_set( "loot_roulette_disabled" );
}

// Namespace loot_roulette
// Params 1
// Checksum 0x49d5e271, Offset: 0x263
// Size: 0x39
function function_4f3a09596afa4f87( func )
{
    if ( isfunction( func ) && isdefined( level.var_65153800cb31d1b0 ) )
    {
        level.var_65153800cb31d1b0.var_61826bd231df0d2e = func;
    }
}

// Namespace loot_roulette
// Params 1
// Checksum 0x1c489704, Offset: 0x2a4
// Size: 0x39
function function_47afcf44bce6fa8a( func )
{
    if ( isfunction( func ) && isdefined( level.var_65153800cb31d1b0 ) )
    {
        level.var_65153800cb31d1b0.var_140fc00cb15d587c = func;
    }
}

// Namespace loot_roulette
// Params 2
// Checksum 0x3e6675f5, Offset: 0x2e5
// Size: 0x60
function function_c3a86702e1e2b176( func, var_cf7d69dcd8e4c57 = 0 )
{
    if ( isfunction( func ) && isdefined( level.var_65153800cb31d1b0 ) )
    {
        level.var_65153800cb31d1b0.var_88fb959eef3c065c = func;
        level.var_65153800cb31d1b0.var_cd185b758ac9e5 = var_cf7d69dcd8e4c57;
    }
}

// Namespace loot_roulette
// Params 0, eflags: 0x4
// Checksum 0x461a78a1, Offset: 0x34d
// Size: 0x34b
function private function_f9625cc265a33f0a()
{
    level endon( #"game_ended" );
    waitframe();
    var_e49b4f339a30d352 = utility::getstructarray( "loot_roulette_spawnpoint", "targetname" );
    level.var_65153800cb31d1b0.var_e49b4f339a30d352 = var_e49b4f339a30d352;
    
    foreach ( var_35ad5768244120ee in level.var_65153800cb31d1b0.var_e49b4f339a30d352 )
    {
        if ( var_35ad5768244120ee.target )
        {
            clip = getent( var_35ad5768244120ee.target, #targetname );
            
            if ( clip )
            {
                var_35ad5768244120ee.clip = clip;
                var_35ad5768244120ee.clip connectpaths();
                var_35ad5768244120ee.clip notsolid();
            }
        }
    }
    
    function_5ef9cdf7352c2f10( var_e49b4f339a30d352 );
    
    for ( index = 0; index < level.var_65153800cb31d1b0.var_fd497d083c96f814.size ; index++ )
    {
        filter = level.var_65153800cb31d1b0.var_fd497d083c96f814[ index ].var_64e8328c7944334b;
        var_8412f95215fbbd9b = level.var_65153800cb31d1b0.var_fd497d083c96f814[ index ].var_ab72a674d7da990c;
        selected_spawns = var_e49b4f339a30d352;
        
        if ( isdefined( filter ) )
        {
            selected_spawns = level.var_65153800cb31d1b0.var_2425b5dc0dc5550[ filter ];
            
            if ( !isdefined( selected_spawns ) || !selected_spawns.size > 0 )
            {
                print( "<dev string:x24>" + filter + "<dev string:x7b>" + level.var_65153800cb31d1b0.var_fd497d083c96f814[ index ].var_ebd2dd7b596f3157 + "<dev string:x8d>" );
                continue;
            }
        }
        
        if ( var_8412f95215fbbd9b < var_e49b4f339a30d352.size )
        {
            selected_spawns = utility::array_random_slice( var_e49b4f339a30d352, var_8412f95215fbbd9b );
        }
        
        foreach ( spawn_struct in selected_spawns )
        {
            function_8e62c29e7ebfc461( level.var_65153800cb31d1b0.var_fd497d083c96f814[ index ], spawn_struct );
        }
        
        if ( level.var_65153800cb31d1b0.var_fd497d083c96f814[ index ].respawnsettings.var_3b4e2a0e167c95a0 )
        {
            if ( level.var_65153800cb31d1b0.var_fd497d083c96f814[ index ].respawnsettings.var_131777b5bec04f3c )
            {
                level thread function_5989b66ea884f9ca( level.var_65153800cb31d1b0.var_fd497d083c96f814[ index ] );
                continue;
            }
            
            assertmsg( "<dev string:xbd>" );
        }
    }
    
    utility::flag_set( "loot_roulette_spawns_initialized" );
}

// Namespace loot_roulette
// Params 1, eflags: 0x4
// Checksum 0xc983612, Offset: 0x6a0
// Size: 0x123
function private function_5ef9cdf7352c2f10( spawn_struct_array )
{
    level.var_65153800cb31d1b0.var_2425b5dc0dc5550 = [];
    
    foreach ( spawn_struct in spawn_struct_array )
    {
        if ( !isdefined( spawn_struct.script_noteworthy ) )
        {
            continue;
        }
        
        if ( !isdefined( level.var_65153800cb31d1b0.var_2425b5dc0dc5550[ spawn_struct.script_noteworthy ] ) )
        {
            level.var_65153800cb31d1b0.var_2425b5dc0dc5550[ spawn_struct.script_noteworthy ] = [];
        }
        
        level.var_65153800cb31d1b0.var_2425b5dc0dc5550[ spawn_struct.script_noteworthy ][ level.var_65153800cb31d1b0.var_2425b5dc0dc5550[ spawn_struct.script_noteworthy ].size ] = spawn_struct;
    }
}

// Namespace loot_roulette
// Params 0, eflags: 0x4
// Checksum 0xab187c81, Offset: 0x7cb
// Size: 0x86
function private function_9773f598d53d6b4()
{
    level.var_65153800cb31d1b0.var_8a24cc82efa077d0 = [];
    
    for ( index = 0; index < level.var_65153800cb31d1b0.var_fd497d083c96f814.size ; index++ )
    {
        object = level.var_65153800cb31d1b0.var_fd497d083c96f814[ index ];
        level.var_65153800cb31d1b0.var_8a24cc82efa077d0[ object.var_ebd2dd7b596f3157 ] = index;
    }
}

// Namespace loot_roulette
// Params 2, eflags: 0x4
// Checksum 0x803a2287, Offset: 0x859
// Size: 0x214
function private function_8e62c29e7ebfc461( var_c84004a6513142fa, spawn_struct )
{
    if ( spawn_struct.clip )
    {
        spawn_struct.clip disconnectpaths();
        spawn_struct.clip solid();
    }
    
    object = spawnscriptable( var_c84004a6513142fa.var_ebd2dd7b596f3157, spawn_struct.origin, spawn_struct.angles ?? ( 0, 0, 0 ) );
    
    if ( !isdefined( var_c84004a6513142fa.var_b76f4d33f5fc1281 ) )
    {
        var_c84004a6513142fa.var_b76f4d33f5fc1281 = 1;
    }
    
    object.health = var_c84004a6513142fa.var_b76f4d33f5fc1281;
    object.properties = var_c84004a6513142fa;
    object.var_c3686191f47fb946 = 1;
    object.spawn_struct = spawn_struct;
    object.spawn_struct.in_use = 1;
    object.spawn_type = object function_3361de35a2d7e88c( var_c84004a6513142fa );
    
    if ( var_c84004a6513142fa.var_b7c734a541462cbd && object.spawn_type == "ai" )
    {
        assert( var_c84004a6513142fa.var_acf595d236d66202 > 0, "<dev string:x125>" );
        trigger_radius = var_c84004a6513142fa.var_acf595d236d66202;
        object.prox_trigger = spawn( "noent_volume_trigger_radius", object.origin, 0, trigger_radius, trigger_radius );
        object thread function_fb168c4bf59209f6( var_c84004a6513142fa );
    }
    
    if ( !isdefined( level.var_af377340b04ddc72[ object.properties.var_ebd2dd7b596f3157 ] ) )
    {
        level.var_af377340b04ddc72[ object.properties.var_ebd2dd7b596f3157 ] = [];
    }
    
    level.var_af377340b04ddc72[ object.properties.var_ebd2dd7b596f3157 ][ level.var_af377340b04ddc72[ object.properties.var_ebd2dd7b596f3157 ].size ] = object;
}

// Namespace loot_roulette
// Params 1, eflags: 0x4
// Checksum 0x8c39df1e, Offset: 0xa75
// Size: 0xd4
function private function_3361de35a2d7e88c( var_c2497854768656de )
{
    itemlist_weight = self.properties.var_bec89967fb0d6b6b;
    aispawn_weight = self.properties.var_29d79935ebaaaa49;
    
    if ( !isdefined( aispawn_weight ) && isdefined( itemlist_weight ) )
    {
        type = "item";
    }
    else if ( !isdefined( itemlist_weight ) && isdefined( aispawn_weight ) )
    {
        type = "ai";
    }
    else if ( isdefined( itemlist_weight ) && isdefined( aispawn_weight ) )
    {
        max_weight = itemlist_weight + aispawn_weight;
        var_ad430148a3718ad6 = randomint( max_weight );
        
        if ( var_ad430148a3718ad6 < itemlist_weight )
        {
            type = "item";
        }
        else
        {
            type = "ai";
        }
    }
    else
    {
        assertmsg( "<dev string:x175>" );
    }
    
    return type;
}

// Namespace loot_roulette
// Params 1, eflags: 0x4
// Checksum 0x8adb2dda, Offset: 0xb52
// Size: 0x209
function private function_5989b66ea884f9ca( var_a5bdced62e7cdbef )
{
    level endon( #"game_ended" );
    max_objects = var_a5bdced62e7cdbef.respawnsettings.var_2b25de799b2cd474;
    var_30336335a16594eb = var_a5bdced62e7cdbef.respawnsettings.var_e03a99ad4a55ef65;
    object_type = var_a5bdced62e7cdbef.var_ebd2dd7b596f3157;
    assert( var_30336335a16594eb > 0, "<dev string:x1b5>" );
    
    while ( true )
    {
        level waittill( var_a5bdced62e7cdbef.respawnsettings.var_e5e5b5d137dd7a8 );
        curr_count = level.var_af377340b04ddc72[ object_type ].size;
        var_26b1ad3b9aa21c1d = max_objects - curr_count;
        
        if ( var_26b1ad3b9aa21c1d > var_30336335a16594eb )
        {
            var_26b1ad3b9aa21c1d = var_30336335a16594eb;
        }
        
        if ( var_26b1ad3b9aa21c1d > 0 )
        {
            var_e49b4f339a30d352 = level.var_65153800cb31d1b0.var_e49b4f339a30d352;
            function_5ef9cdf7352c2f10( var_e49b4f339a30d352 );
            filter = var_a5bdced62e7cdbef.var_64e8328c7944334b;
            selected_spawns = var_e49b4f339a30d352;
            
            if ( isdefined( filter ) )
            {
                selected_spawns = level.var_65153800cb31d1b0.var_2425b5dc0dc5550[ filter ];
                
                if ( !selected_spawns.size > 0 )
                {
                    assertmsg( "<dev string:x1fa>" + filter + "<dev string:x7b>" + var_a5bdced62e7cdbef.var_ebd2dd7b596f3157 + "<dev string:x8d>" );
                    continue;
                }
            }
            
            valid_spawns = function_8d6c3043c5b842ec( selected_spawns );
            
            if ( var_26b1ad3b9aa21c1d < valid_spawns.size )
            {
                valid_spawns = utility::array_random_slice( valid_spawns, var_26b1ad3b9aa21c1d );
            }
            
            foreach ( spawn_struct in valid_spawns )
            {
                function_8e62c29e7ebfc461( var_a5bdced62e7cdbef, spawn_struct );
            }
            
            continue;
        }
        
        waitframe();
    }
}

// Namespace loot_roulette
// Params 1, eflags: 0x4
// Checksum 0x50872148, Offset: 0xd63
// Size: 0x98
function private function_8d6c3043c5b842ec( a_all_spawns )
{
    a_valid_spawns = [];
    
    foreach ( spawn_point in a_all_spawns )
    {
        if ( !spawn_point.in_use )
        {
            a_valid_spawns[ a_valid_spawns.size ] = spawn_point;
        }
    }
    
    return a_valid_spawns;
}

// Namespace loot_roulette
// Params 1, eflags: 0x4
// Checksum 0x82516417, Offset: 0xe04
// Size: 0xc7
function private function_fb168c4bf59209f6( var_c84004a6513142fa )
{
    self endon( #"destroyed" );
    assert( isdefined( var_c84004a6513142fa.var_fa17bdf157100ed6 ), "<dev string:x242>" );
    var_d60fa92d9bbbab6c = isdefined( var_c84004a6513142fa.var_78a20d06ed957757 );
    
    while ( true )
    {
        self.prox_trigger waittill( #"trigger", ent );
        
        if ( !isplayer( ent ) )
        {
            continue;
        }
        
        if ( utility::percent_chance( var_c84004a6513142fa.var_fa17bdf157100ed6 ) && !self.destroyed )
        {
            self.destroyed = 1;
            thread function_29df77a45ea3d30d();
            return;
        }
        
        if ( var_d60fa92d9bbbab6c )
        {
            wait var_c84004a6513142fa.var_78a20d06ed957757;
            continue;
        }
        
        waitframe();
    }
}

// Namespace loot_roulette
// Params 11, eflags: 0x4
// Checksum 0xfd881e8d, Offset: 0xed3
// Size: 0xfa
function private function_3e8015831332f8cd( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    index = level.var_65153800cb31d1b0.var_8a24cc82efa077d0[ instance.type ];
    
    if ( !isdefined( index ) || instance.destroyed || !instance.var_c3686191f47fb946 )
    {
        return;
    }
    
    instance.health -= idamage;
    
    if ( instance.health < 0 )
    {
        instance.destroyed = 1;
        instance thread function_29df77a45ea3d30d( eattacker );
    }
}

// Namespace loot_roulette
// Params 1, eflags: 0x4
// Checksum 0xe89eae32, Offset: 0xfd5
// Size: 0x2b3
function private function_29df77a45ea3d30d( eattacker )
{
    level endon( #"game_ended" );
    
    if ( isplayer( eattacker ) )
    {
        level thread utility::callsharedfunc( #"zombie", #"hash_26befc250486510c", self.origin, self.angles, eattacker );
    }
    
    if ( self.spawn_struct && self.spawn_struct.clip )
    {
        self.spawn_struct.clip connectpaths();
        self.spawn_struct.clip notsolid();
    }
    
    part = self.properties.var_b441f377102938a;
    state = self.properties.var_aa4e990f2aca7c0b;
    object_type = self.properties.var_ebd2dd7b596f3157;
    earthquake_enabled = self.properties.var_3611c49e1020e5e6;
    deletion_enabled = self.properties.var_c5530c0aa8936e5e;
    self setscriptablepartstate( part, state );
    
    if ( earthquake_enabled )
    {
        earthquake( 0.15, 1, self.origin, 100 );
    }
    
    if ( isdefined( level.var_65153800cb31d1b0.var_88fb959eef3c065c ) )
    {
        if ( level.var_65153800cb31d1b0.var_cd185b758ac9e5 )
        {
            waitframe();
        }
        
        if ( !self [[ level.var_65153800cb31d1b0.var_88fb959eef3c065c ]]() )
        {
            self.spawn_type = "invalid";
        }
    }
    
    switch ( self.spawn_type )
    {
        case #"hash_fa18b9f6bd576aff":
            function_ec3ba401ef5626f0();
            break;
        case #"hash_924e034e98c9dc46":
            function_c2af06724f4338b9();
            break;
        case #"hash_f43afb7b1b11f010":
            print( "<dev string:x295>" );
            break;
        default:
            assertmsg( "<dev string:x2c7>" );
            break;
    }
    
    self notify( #"destroyed" );
    self.spawn_struct.in_use = 0;
    level.var_af377340b04ddc72[ object_type ] = arrayremove( level.var_af377340b04ddc72[ object_type ], self );
    
    if ( deletion_enabled )
    {
        var_1483b9a2b1084e0a = self.properties.var_831fd0ad5450e75;
        
        if ( isdefined( self.prox_trigger ) )
        {
            self.prox_trigger delete();
        }
        
        if ( isdefined( var_1483b9a2b1084e0a ) )
        {
            wait var_1483b9a2b1084e0a;
            self freescriptable();
        }
    }
}

// Namespace loot_roulette
// Params 1, eflags: 0x4
// Checksum 0x2cecb56d, Offset: 0x1290
// Size: 0x12b
function private function_c2af06724f4338b9( index )
{
    level endon( #"game_ended" );
    itemlist_ref = self.properties.var_c970d8f257f4a0af;
    itementry_ref = self.properties.var_b8291fcdf6956de1;
    var_12b5fc88de8d408d = self.properties.var_180832c0d70eb34c;
    waitframe();
    
    if ( self.properties.var_84355a22a9b1c87e == 1 )
    {
        itemlist_ref = function_e821a82c23055033();
    }
    
    if ( isdefined( itemlist_ref ) )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
        common_item::function_38cde6a6acb68ea6( itemlist_ref, var_12b5fc88de8d408d, spawnoptions );
        return;
    }
    
    if ( isdefined( itementry_ref ) )
    {
        itembundle = getscriptbundle( itementry_ref );
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
        spawnoptions.var_90cdc5dbcd319e5d = 1;
        
        for ( i = 0; i < var_12b5fc88de8d408d ; i++ )
        {
            common_item::function_61c2c0251e742ffd( itembundle, undefined, spawnoptions );
        }
    }
}

// Namespace loot_roulette
// Params 0, eflags: 0x4
// Checksum 0xbfa1e750, Offset: 0x13c3
// Size: 0x49
function private function_e821a82c23055033()
{
    assert( isdefined( level.var_65153800cb31d1b0.var_140fc00cb15d587c ), "<dev string:x2ea>" );
    var_5a29e36445c377f2 = [[ level.var_65153800cb31d1b0.var_140fc00cb15d587c ]]();
    return var_5a29e36445c377f2;
}

// Namespace loot_roulette
// Params 1, eflags: 0x4
// Checksum 0x84cd8210, Offset: 0x1415
// Size: 0x117
function private function_ec3ba401ef5626f0( index )
{
    subclass = self.properties.var_540880e62664b815;
    var_e22515fa4eb37b17 = self.properties.var_2491579333e2c35e;
    aidrop_disabled = self.properties.var_dbe35a1cd8d7dc4a;
    position = self.origin;
    angles = self.angles;
    
    if ( isfunction( level.var_65153800cb31d1b0.var_61826bd231df0d2e ) )
    {
        [[ level.var_65153800cb31d1b0.var_61826bd231df0d2e ]]( subclass, position, angles, var_e22515fa4eb37b17, aidrop_disabled, index );
    }
    else
    {
        for ( i = 0; i < var_e22515fa4eb37b17 ; i++ )
        {
            namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( subclass, position, angles );
        }
    }
    
    level callback::callback( "loot_roulette_ai_spawned", { #var_e22515fa4eb37b17:var_e22515fa4eb37b17, #subclass:subclass, #scriptable:self } );
}

/#

    // Namespace loot_roulette
    // Params 0, eflags: 0x4
    // Checksum 0x31c6f090, Offset: 0x1534
    // Size: 0xdd, Type: dev
    function private function_3e8d0fc2ca740ae6()
    {
        if ( isdefined( level.var_65153800cb31d1b0.var_e49b4f339a30d352 ) && isdefined( level.var_65153800cb31d1b0.var_fd497d083c96f814[ 0 ] ) )
        {
            foreach ( spawn_struct in level.var_65153800cb31d1b0.var_e49b4f339a30d352 )
            {
                function_8e62c29e7ebfc461( level.var_65153800cb31d1b0.var_fd497d083c96f814[ 0 ], spawn_struct );
            }
            
            return;
        }
        
        assertmsg( "<dev string:x345>" );
    }

    // Namespace loot_roulette
    // Params 0, eflags: 0x4
    // Checksum 0xf3272bb, Offset: 0x1619
    // Size: 0x2f, Type: dev
    function private function_eb862349e4ef2b17()
    {
        devgui::function_9082edeb5db93280( "<dev string:x395>" );
        devgui::add_devgui_func( "<dev string:x3aa>", "<dev string:x3cc>", &function_3e8d0fc2ca740ae6, 0 );
        devgui::function_77df7fe7dd273e10();
    }

#/
