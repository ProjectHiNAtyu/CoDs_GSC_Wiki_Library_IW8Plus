// scripts\mp\zm\ztron\ztron_item.gsc  (hash_27f04264fa1bb0cd.gscc) (size: 27352 Bytes / 0x6ad8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x83ef178c (2213484428)
// size ...... 27352 (0x6ad8)
// includes .. 20  (offset: 0x66d0)
// strings ... 48  (offset: 0x6770)
// dev strs .. 15  (offset: 0x6a1c)
// exports ... 75  (offset: 0x47e8)
// cseg ...... 0x369 + 0x447f (0x47e8)
// imports ... 158 (offset: 0x53a0)
// animtree1 . 0   (offset: 0x6ad8)
// animtree2 . 0   (offset: 0x6ad8)
#using scripts\anim\dialogue;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\scriptable;
#using scripts\common\scriptable_group;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\weapons\weap_jetgun;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_score;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_telemetry;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_item;

// Namespace ztron_item
// Params 0, eflags: 0x5
// Checksum 0xe27b3c3b, Offset: 0x387
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_item", #"common_item_database", undefined, &init );
}

// Namespace ztron_item
// Params 0
// Checksum 0x1a7042b3, Offset: 0x3b0
// Size: 0x2e0
function init()
{
    level endon( #"ztron_game_is_over" );
    
    if ( isdefined( level.ztron.itemdef ) )
    {
        return;
    }
    
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    utility::flag_wait( "common_items_init" );
    level.ztron.itemdef = spawnstruct();
    level.ztron.itemdef.itemdata = [];
    level.ztron.itemdef.var_39d92a893cb894dd = [];
    level.ztron.itemdef.itemcallbacks = [];
    level.ztron.itemdef.spawneditems = [];
    level.ztron.itemdef.var_a6fb8def3d6b72e9 = 1;
    level.ztron.itemdef.uniqueid = 0;
    level thread function_8adc4846bf5c0c7d();
    var_e08c496c40abc85b = getscriptbundlenames( #"hash_10380aaf6202145" );
    
    foreach ( dataname in var_e08c496c40abc85b )
    {
        itemdata = getscriptbundle( dataname );
        
        if ( isdefined( itemdata.itemspawnentry ) )
        {
            level.ztron.itemdef.itemdata[ itemdata.itemspawnentry ] = itemdata;
            itemdata.spawnbundle = getscriptbundle( itemdata.itemspawnentry );
        }
        
        if ( itemdata.ref )
        {
            level.ztron.itemdef.var_39d92a893cb894dd[ itemdata.ref ] = itemdata;
        }
    }
    
    level.var_97db93a6b414090d = 1;
    level callback::add( "scripted_item_used", &function_ce911f71cf00b85a );
    level callback::add( "scripted_item_can_autouse", &function_2ceef8dac4e8ac3f );
    level callback::add( #"player_spawned", &onplayerspawned );
    level callback::add( #"player_disconnect", &onplayerdisconnect );
    common_item::function_84174b793b5fe9a7( "generic", #"lootidfromitem", &function_4f0c0cd3a496e17a );
    scriptable::scriptable_adddamagedcallback( &function_b2fb825fb24a472f );
    level thread function_7d6c0168d1aa21f3();
    function_ec27cc3760663936();
    
    /#
        function_ac7ee3673d6e340d();
        thread function_fe7676e1e4514fdd();
        thread function_5f2503191e3b55ab();
    #/
}

// Namespace ztron_item
// Params 1, eflags: 0x4
// Checksum 0x7f591191, Offset: 0x698
// Size: 0xd, Type: bool
function private function_4f0c0cd3a496e17a( item )
{
    return false;
}

// Namespace ztron_item
// Params 0
// Checksum 0x5a33105a, Offset: 0x6ae
// Size: 0x26
function function_ec27cc3760663936()
{
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_default_despawn", "evt_ztron_pickup_default_despawn" );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_money_lp", "evt_ztron_pickup_money_lp", 1 );
}

// Namespace ztron_item
// Params 1
// Checksum 0xc9bf29b7, Offset: 0x6dc
// Size: 0x5f
function function_513c39aa9a1e334c( itemtype )
{
    switch ( itemtype )
    {
        case #"weapon":
        case #"gem":
        case #"money":
            return;
        case #"chicken":
            return "ztron_pickup_chicken_despawn";
        default:
            return "ztron_pickup_default_despawn";
    }
}

// Namespace ztron_item
// Params 0
// Checksum 0x8b0e5f84, Offset: 0x743
// Size: 0x2ce
function function_7d6c0168d1aa21f3()
{
    level utility::flag_wait_all( "ztron_system_start" );
    level callback::remove( #"reload", &item_ammo::function_bfcdd6e7049ff664 );
    level.ztron.var_c5f22b2665289fe = [ "ztron_gem_blue", "ztron_gem_red", "ztron_gem_green", "ztron_gem_yellow", "ztron_gem_white" ];
    level.ztron.gembundles = [];
    
    foreach ( var_e5c591558239cdf5 in level.ztron.var_c5f22b2665289fe )
    {
        level.ztron.gembundles[ var_e5c591558239cdf5 ] = function_71e133b37011bee6( var_e5c591558239cdf5 );
    }
    
    level.ztron.var_7833ff35a7f394ec = function_71e133b37011bee6( "ztron_gold_coin" );
    
    foreach ( itembundle in level.ztron.itemdef.itemdata )
    {
        category = itembundle.category;
        itemname = getscriptbundlefieldvalue( itembundle.itemspawnentry, #"ref" );
        itembundle.name = itemname;
        itembundle.count = 0;
        itembundle.lasttime = 0;
        itembundle.lastround = 0;
        
        if ( !isdefined( itembundle.cooldown ) )
        {
            itembundle.cooldown = 0;
        }
        
        if ( category == "" || category == "scripted" )
        {
            itembundle.typeflag = 1;
            continue;
        }
        
        if ( category == "treasure" )
        {
            itembundle.typeflag = 2;
            continue;
        }
        
        if ( category == "weapon" )
        {
            itembundle.typeflag = 4;
            continue;
        }
        
        if ( category == "special" )
        {
            itembundle.typeflag = 8;
            continue;
        }
        
        assertmsg( "<dev string:x24>" );
    }
    
    level thread function_4357c89290efcc5f();
}

// Namespace ztron_item
// Params 0
// Checksum 0xabaea884, Offset: 0xa19
// Size: 0x10b
function function_4357c89290efcc5f()
{
    level endon( #"ztron_game_is_over" );
    
    while ( true )
    {
        wait 1;
        
        if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
        {
            if ( utility::flag( "ztron_round_over" ) )
            {
                continue;
            }
        }
        else if ( ztron_main::function_4da200e9b8d58a3c() == 5 )
        {
            if ( !utility::flag( "ztron_slayer_active" ) )
            {
                continue;
            }
        }
        else
        {
            continue;
        }
        
        foreach ( item in level.ztron.itemdef.itemdata )
        {
            if ( item.cooldown > 0 )
            {
                item.cooldown -= 1;
            }
        }
    }
}

// Namespace ztron_item
// Params 4
// Checksum 0x6782777f, Offset: 0xb2c
// Size: 0xe2
function function_5844a9c240f7dc8d( itemtype, var_e8f16b9dd5957931, func, note )
{
    if ( !isdefined( level.ztron.itemdef.itemcallbacks ) )
    {
        return;
    }
    
    if ( !isdefined( level.ztron.itemdef.itemcallbacks[ itemtype ] ) )
    {
        level.ztron.itemdef.itemcallbacks[ itemtype ] = [];
    }
    
    level.ztron.itemdef.itemcallbacks[ itemtype ][ var_e8f16b9dd5957931 ] = func;
    
    if ( isdefined( note ) )
    {
        level.ztron.itemdef.itemcallbacks[ itemtype ][ "note" ] = note;
    }
}

// Namespace ztron_item
// Params 2
// Checksum 0x7bbd8f90, Offset: 0xc16
// Size: 0x5c
function function_230d60331b07b7da( itemtype, var_e8f16b9dd5957931 )
{
    if ( isdefined( level.ztron.itemdef.itemcallbacks[ itemtype ] ) )
    {
        return level.ztron.itemdef.itemcallbacks[ itemtype ][ var_e8f16b9dd5957931 ];
    }
}

// Namespace ztron_item
// Params 6
// Checksum 0xa116708e, Offset: 0xc7b
// Size: 0xe0
function requestspawnitem( bundlename, origin, offset = 0, spawnoptions = undefined, params = undefined, notifyalert )
{
    itemrequest = spawnstruct();
    itemrequest.bundlename = bundlename;
    itemrequest.origin = origin;
    itemrequest.offset = offset;
    itemrequest.spawnoptions = spawnoptions;
    itemrequest.params = params;
    itemrequest.notifyalert = notifyalert;
    level.ztron.itemrequests[ level.ztron.itemrequests.size ] = itemrequest;
}

// Namespace ztron_item
// Params 0
// Checksum 0x6448902b, Offset: 0xd63
// Size: 0x1a4
function function_8adc4846bf5c0c7d()
{
    self notify( #"hash_b030fff62d96687b" );
    self endon( #"hash_b030fff62d96687b" );
    level endon( #"ztron_game_is_over" );
    
    if ( !isdefined( level.ztron.itemrequests ) )
    {
        level.ztron.itemrequests = [];
    }
    
    while ( true )
    {
        waitframe();
        throttle = 5;
        dirty = 0;
        
        if ( level.ztron.itemrequests.size > 0 )
        {
            dirty = 1;
            
            for ( i = 0; i < level.ztron.itemrequests.size ; i++ )
            {
                itemrequested = level.ztron.itemrequests[ i ];
                level.ztron.itemrequests[ i ] = undefined;
                item = spawnitem( itemrequested.bundlename, itemrequested.origin, itemrequested.offset, itemrequested.spawnoptions, itemrequested.params );
                
                if ( isdefined( itemrequested.notifyalert ) && isdefined( item ) )
                {
                    level notify( itemrequested.notifyalert, { #entity:item } );
                }
                
                throttle--;
                
                if ( throttle <= 0 )
                {
                    break;
                }
            }
        }
        
        if ( dirty )
        {
            level.ztron.itemrequests = function_5713d46873b29625( level.ztron.itemrequests );
        }
    }
}

// Namespace ztron_item
// Params 5
// Checksum 0x5dee5d08, Offset: 0xf0f
// Size: 0x709
function spawnitem( bundlename, origin, offset = 0, itemspawnoptions = undefined, var_c1fa5c1e922e62d6 = undefined )
{
    profilestart();
    
    if ( !isdefined( origin ) )
    {
        profilestop();
        return;
    }
    
    if ( offset > 0 )
    {
        origin += ( randomintrange( offset * -1, offset ), randomintrange( offset * -1, offset ), 0 );
    }
    
    params = isdefined( var_c1fa5c1e922e62d6 ) ? structcopy( var_c1fa5c1e922e62d6 ) : spawnstruct();
    params = function_e40dc148ba189702( bundlename, params );
    
    if ( params.disablespawn )
    {
        profilestop();
        return;
    }
    
    if ( isdefined( params.var_6ad11e1ce5f9ee38 ) )
    {
        bundlename = params.var_6ad11e1ce5f9ee38;
    }
    
    spawnoptions = isdefined( itemspawnoptions ) ? structcopy( itemspawnoptions ) : common_item::function_bc5ff2958b71a708( origin );
    spawnoptions.var_18608bd8660b3a19 = 20;
    spawnoptions.overridelifetime = params.overridelifetime ?? undefined;
    spawnoptions.payload = params.payload ?? undefined;
    spawnoptions.cleanupdisabled = 1;
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.var_f35b5b18b029c493 = 0;
    
    if ( !spawnoptions.var_8d4f327170228364 )
    {
        spawnoptions.var_d72f168a0f299753 = 0;
        spawnoptions.var_d7522c8a0f500f6d = offset;
    }
    
    spawnbundle = level.ztron.itemdef.itemdata[ bundlename ].spawnbundle;
    linkedmodel = level.ztron.itemdef.itemdata[ bundlename ].linkedmodel;
    
    if ( isdefined( linkedmodel ) )
    {
        item = function_84bc48b0562d34c9( bundlename, spawnbundle, linkedmodel, origin, params, spawnoptions );
    }
    else
    {
        item = common_item::function_61c2c0251e742ffd( bundlename, undefined, spawnoptions );
    }
    
    if ( !isdefined( item ) )
    {
        profilestop();
        return;
    }
    
    item.spawnbundle = spawnbundle;
    item.var_8593f17418a81b6e = bundlename;
    item.fromground = 1;
    item.disable_dragged = params.disable_dragged ?? !level.ztron.itemdef.itemdata[ bundlename ].var_f134d2709745a94d;
    
    if ( isdefined( level.ztron.itemdef.itemdata[ bundlename ] ) )
    {
        if ( !isdefined( level.ztron.itemdef.itemdata[ bundlename ].count ) )
        {
            level.ztron.itemdef.itemdata[ bundlename ].count = 0;
        }
        
        level.ztron.itemdef.itemdata[ bundlename ].cooldown = level.ztron.var_293c4b94e80c822a * level.ztron.itemdef.itemdata[ bundlename ].cooldownduration;
        level.ztron.itemdef.itemdata[ bundlename ].count += 1;
        
        /#
            level.ztron.itemdef.itemdata[ bundlename ].var_da70ec7bd68f8687 = level.ztron.roundnumber;
            level.ztron.dev.var_9944015295c3734e++;
        #/
    }
    else
    {
        assertmsg( "<dev string:x31>" + getxhashsourcename( bundlename ) );
    }
    
    type = getscriptbundlefieldvalue( bundlename, #"genericstring" );
    
    if ( isdefined( level.ztron.itemdef.itemcallbacks[ type ][ "note" ] ) )
    {
        level notify( level.ztron.itemdef.itemcallbacks[ type ][ "note" ] );
    }
    
    level.ztron.itemdef.spawneditems[ level.ztron.itemdef.spawneditems.size ] = item;
    item thread itemdeathwatcher();
    item.despawnsound = function_513c39aa9a1e334c( type );
    
    if ( isdefined( params.overridestate ) && isdefined( item.type ) && item isscriptableinstance() && item getscriptableparthasstate( item.type, params.overridestate ) )
    {
        item setscriptablepartstate( item.type, params.overridestate );
    }
    
    shouldplayloopsound = params.playloopsound ?? 1;
    
    if ( shouldplayloopsound && item isscriptableinstance() && item getscriptableparthasstate( "loop_sound", "on" ) )
    {
        item setscriptablepartstate( "loop_sound", "on" );
    }
    
    lifetime = getscriptbundlefieldvalue( bundlename, #"lifetime" ) ?? 0;
    lifetime = params.overridelifetime ?? lifetime;
    
    if ( lifetime > 0 && lifetime != 9999 )
    {
        item thread function_6e31c5f4e9c2087a( lifetime );
    }
    
    needspin = params.modelspinning ?? 1;
    
    if ( needspin )
    {
        initdelay = spawnoptions.var_8d4f327170228364 ? 0 : 0.5;
        item thread function_4057fcdcce3f0af6( initdelay );
    }
    
    item function_352c5b96756f19cf();
    
    if ( isdefined( params.overrideangles ) && !isdefined( item.linkedparent ) )
    {
        item.angles = params.overrideangles;
    }
    
    if ( params.shootable )
    {
        item function_28cb6f43232442f0();
    }
    
    spawnitemfunc = function_230d60331b07b7da( type, #"postspawnitem" );
    
    if ( isdefined( spawnitemfunc ) )
    {
        thread [[ spawnitemfunc ]]( item, params );
    }
    
    /#
        ztron_debug::debugmsg( "<dev string:x49>" + getxhashsourcename( bundlename ) + "<dev string:x59>" + origin + "<dev string:x5e>" + offset + "<dev string:x6c>" + lifetime );
    #/
    
    profilestop();
    return item;
}

// Namespace ztron_item
// Params 1
// Checksum 0xddadf096, Offset: 0x1622
// Size: 0x4b
function function_41854e96b8bf4a06( origin )
{
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( origin );
    spawnoptions.var_8934e0ace9b7d996 = -180;
    spawnoptions.var_8958d2ace9e03584 = 180;
    spawnoptions.var_2321e933cbdf46d8 = 0;
    return spawnoptions;
}

// Namespace ztron_item
// Params 3
// Checksum 0xb87aad22, Offset: 0x1676
// Size: 0xb9
function function_2626d0cc607fd5d8( itemlist, number, origin )
{
    spawnoptions = function_41854e96b8bf4a06( origin );
    itemnames = common_item::items_selectfromlist( itemlist, number );
    
    foreach ( itemname in itemnames )
    {
        requestspawnitem( itemname, origin, 0, spawnoptions );
    }
}

// Namespace ztron_item
// Params 6
// Checksum 0xc17178de, Offset: 0x1737
// Size: 0x84
function clusteritemspawn( bundlename, origin, numitems = 10, offset = 256, spawnoptions = undefined, params = undefined )
{
    for ( i = 0; i < numitems ; i++ )
    {
        requestspawnitem( bundlename, origin, offset, spawnoptions, params );
    }
}

// Namespace ztron_item
// Params 6
// Checksum 0x627b764c, Offset: 0x17c3
// Size: 0x9c
function function_d3d82aa8c393b166( origin, numitems, offset = 256, spawnoptions = undefined, params = undefined, notifyalert )
{
    if ( !isdefined( spawnoptions ) )
    {
        spawnoptions = function_41854e96b8bf4a06( origin );
    }
    
    for ( i = 0; i < numitems ; i++ )
    {
        requestspawnitem( level.ztron.var_7833ff35a7f394ec, origin, offset, spawnoptions, params );
    }
}

// Namespace ztron_item
// Params 6
// Checksum 0xe42c5614, Offset: 0x1867
// Size: 0xf5
function function_e062f5021d53874e( origin, numitems, offset = 256, spawnoptions = undefined, params = undefined, notifyalert )
{
    if ( !isdefined( spawnoptions ) )
    {
        spawnoptions = function_41854e96b8bf4a06( origin );
    }
    
    itemnames = common_item::items_selectfromlist( %"hash_6882c0fd2e272829", numitems );
    
    foreach ( itemname in itemnames )
    {
        requestspawnitem( itemname, origin, offset, spawnoptions, params, notifyalert );
    }
}

// Namespace ztron_item
// Params 6
// Checksum 0xe32909fb, Offset: 0x1964
// Size: 0xde
function function_d0a061baefd87906( origin, numitems, offset = 256, spawnoptions = undefined, params = undefined, notifyalert )
{
    if ( !isdefined( params ) )
    {
        params = spawnstruct();
    }
    
    if ( !isdefined( params.launchforce ) )
    {
        params.launchforce = ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), 100 );
    }
    
    while ( numitems )
    {
        itembundlename = level.ztron.gembundles[ utility::array_random( level.ztron.var_c5f22b2665289fe ) ];
        requestspawnitem( itembundlename, origin, offset, spawnoptions, params, notifyalert );
        numitems--;
    }
}

// Namespace ztron_item
// Params 1
// Checksum 0x7ed90d81, Offset: 0x1a4a
// Size: 0x36
function function_f3613b119900d057( type = "" )
{
    items = function_bc08820cbb09b093( type );
    
    if ( isdefined( items ) )
    {
        return items[ 0 ];
    }
}

// Namespace ztron_item
// Params 2
// Checksum 0x2e7cf14d, Offset: 0x1a89
// Size: 0xcb
function function_bc08820cbb09b093( type = "", number = 1 )
{
    if ( type == "" )
    {
        return common_item::items_selectfromlist( %"hash_13af58a2d136ff8b", number );
    }
    
    if ( type == #"weapon" )
    {
        return common_item::items_selectfromlist( %"itemspawnlist:ztron_item_weapon_spawnlist", number );
    }
    
    if ( type == #"treasure" )
    {
        return common_item::items_selectfromlist( %"hash_6882c0fd2e272829", number );
    }
    
    if ( type == #"egg" )
    {
        return common_item::items_selectfromlist( %"hash_627e1c98b2e8ad05", number );
    }
    
    if ( type == #"golden_egg" )
    {
        return common_item::items_selectfromlist( %"hash_ee57ff307b404b", number );
    }
}

// Namespace ztron_item
// Params 1
// Checksum 0xe169c603, Offset: 0x1b5c
// Size: 0xac
function function_44d7d2feb29ee403( name )
{
    if ( !isdefined( name ) )
    {
        return;
    }
    
    foreach ( item in level.ztron.itemdef.itemdata )
    {
        if ( item.ref == name )
        {
            return item;
        }
    }
}

// Namespace ztron_item
// Params 1
// Checksum 0x2911956c, Offset: 0x1c11
// Size: 0x5a
function function_8a02cd53a42c0649( itembundle )
{
    if ( !isdefined( itembundle ) )
    {
        return;
    }
    
    if ( isxhashasset( itembundle ) )
    {
        itembundle = getscriptbundle( itembundle );
    }
    
    if ( isdefined( itembundle.genericstring ) )
    {
        return itembundle.genericstring;
    }
    
    itemtypestr = common_item::function_16e8c106491eeaca( itembundle );
    return getxhash( itemtypestr );
}

// Namespace ztron_item
// Params 1
// Checksum 0x5f8a51bb, Offset: 0x1c74
// Size: 0x4b
function function_cae9dc396fa32b79( itembundlename )
{
    itemdata = level.ztron.itemdef.itemdata[ itembundlename ];
    
    if ( isdefined( itemdata ) )
    {
        return itemdata.var_8b8dc2f3047eeb5c;
    }
    
    return 0;
}

// Namespace ztron_item
// Params 1
// Checksum 0x78bf1aa4, Offset: 0x1cc8
// Size: 0x6d, Type: bool
function function_9924f41a0c1a4649( itembundlename )
{
    itemdata = level.ztron.itemdef.itemdata[ itembundlename ];
    
    if ( !isdefined( itemdata ) )
    {
        assertmsg( "<dev string:x7b>" );
        return false;
    }
    
    if ( itemdata.cooldownduration == 0 )
    {
        return false;
    }
    
    return itemdata.cooldown > 0;
}

// Namespace ztron_item
// Params 4
// Checksum 0x6d2d1eb8, Offset: 0x1d3e
// Size: 0x10c, Type: bool
function canspawnitem( itembundlename, origin, type, ignorecooldown = 0 )
{
    if ( !isdefined( itembundlename ) )
    {
        return false;
    }
    
    if ( function_cae9dc396fa32b79( itembundlename ) > level.ztron.roundnumber )
    {
        return false;
    }
    
    if ( function_9924f41a0c1a4649( itembundlename ) && !ignorecooldown )
    {
        return false;
    }
    
    if ( isdefined( level.ztron.itemdef.itemcallbacks[ type ][ #"hash_2dbdd4400cffa8b8" ] ) )
    {
        params = spawnstruct();
        params.origin = origin;
        params.type = type;
        params.bundlename = itembundlename;
        
        if ( [[ level.ztron.itemdef.itemcallbacks[ type ][ #"hash_2dbdd4400cffa8b8" ] ]]( params ) == 0 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ztron_item
// Params 2
// Checksum 0x7d4651fb, Offset: 0x1e53
// Size: 0xa1
function function_6dc56ae0eba06de1( itemdefname, forced = 0 )
{
    profilestart();
    
    if ( !isdefined( level.ztron.special_item_spawn ) )
    {
        level.ztron.special_item_spawn = [];
    }
    
    item = spawnstruct();
    item.itemdefname = itemdefname;
    item.forced = forced;
    level.ztron.special_item_spawn[ level.ztron.special_item_spawn.size ] = item;
    profilestop();
}

// Namespace ztron_item
// Params 1
// Checksum 0xed54312c, Offset: 0x1efc
// Size: 0x40
function function_998f2b10462afbf4( bundle )
{
    bundlename = common_item::function_e044c3e813daec3a( bundle );
    return level.ztron.itemdef.itemdata[ bundlename ];
}

// Namespace ztron_item
// Params 1
// Checksum 0x58fd62d8, Offset: 0x1f45
// Size: 0x2b
function function_2f7a695f25056625( item )
{
    return isent( item ) ? item.var_8593f17418a81b6e : common_item::function_33a2c00e46263d99( item );
}

// Namespace ztron_item
// Params 1
// Checksum 0xb6fe9ba, Offset: 0x1f79
// Size: 0x36
function function_71e133b37011bee6( ref )
{
    return level.ztron.itemdef.var_39d92a893cb894dd[ ref ].itemspawnentry;
}

// Namespace ztron_item
// Params 1
// Checksum 0x2b030e17, Offset: 0x1fb8
// Size: 0x2c
function function_5f9b4e29dc93f4af( bundlename )
{
    return level.ztron.itemdef.itemdata[ bundlename ];
}

// Namespace ztron_item
// Params 0
// Checksum 0x5e2adec1, Offset: 0x1fed
// Size: 0x1f
function function_4b0636e7b2fc461f()
{
    return level.ztron.itemdef.var_a6fb8def3d6b72e9;
}

// Namespace ztron_item
// Params 6, eflags: 0x4
// Checksum 0x234ae7dd, Offset: 0x2015
// Size: 0x14c
function private function_84bc48b0562d34c9( bundlename, spawnbundle, model, origin, params, spawnoptions )
{
    if ( !spawnoptions.var_23d3495c57d61bdf && isdefined( params.availablezoffset ) )
    {
        origin += ( 0, 0, params.availablezoffset );
    }
    
    item = spawn( "script_model", origin );
    
    if ( isdefined( item ) )
    {
        if ( isdefined( params.scale ) )
        {
            item setscale( params.scale );
            item.scale = params.scale;
        }
        
        item setmodel( model );
        item.angles = ( spawnbundle.var_259a7b10279f7c55.x ?? 0, spawnbundle.var_259a7b10279f7c55.y ?? 0, spawnbundle.var_259a7b10279f7c55.z ?? 0 );
        
        if ( isdefined( spawnbundle.dropsfx ) )
        {
            playsoundatpos( item.origin, spawnbundle.dropsfx );
        }
    }
    
    return item;
}

// Namespace ztron_item
// Params 0, eflags: 0x4
// Checksum 0xe5c477f4, Offset: 0x216a
// Size: 0x3f
function private function_28cb6f43232442f0()
{
    if ( isent( self ) )
    {
        self setcandamage( 1 );
    }
    
    self.shootableitem = 1;
    
    if ( self getscriptableparthasstate( "health", "shootable" ) )
    {
        self setscriptablepartstate( "health", "shootable" );
    }
}

// Namespace ztron_item
// Params 11, eflags: 0x4
// Checksum 0x34c473da, Offset: 0x21b1
// Size: 0xc7
function private function_b2fb825fb24a472f( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !isplayer( eattacker ) )
    {
        return;
    }
    
    item = undefined;
    
    if ( instance.shootableitem )
    {
        item = instance;
    }
    else if ( instance.entity.shootableitem )
    {
        item = instance.entity;
    }
    
    if ( item )
    {
        item thread function_5dce405b07e4f28c( eattacker );
    }
}

// Namespace ztron_item
// Params 0, eflags: 0x4
// Checksum 0x5cab04db, Offset: 0x2280
// Size: 0x17
function private function_352c5b96756f19cf()
{
    if ( self.disable_dragged )
    {
        return;
    }
    
    weap_jetgun::function_50fafa4721732e7f( self );
}

// Namespace ztron_item
// Params 0, eflags: 0x4
// Checksum 0x4cec34ad, Offset: 0x229f
// Size: 0xd
function private function_59ff7bc8f83749c6()
{
    self.disable_dragged = 1;
}

// Namespace ztron_item
// Params 0, eflags: 0x4
// Checksum 0x759c0eca, Offset: 0x22b4
// Size: 0x4e
function private itemdeathwatcher()
{
    self waittill( #"death" );
    level.ztron.itemdef.spawneditems = function_5713d46873b29625( level.ztron.itemdef.spawneditems );
}

// Namespace ztron_item
// Params 1, eflags: 0x4
// Checksum 0xa72a2853, Offset: 0x230a
// Size: 0x5a
function private function_ce911f71cf00b85a( params )
{
    itemtype = params.bundle.genericstring;
    
    if ( isdefined( itemtype ) )
    {
        var_8f68bdf2157380d3 = function_230d60331b07b7da( itemtype, #"use" );
        
        if ( isdefined( var_8f68bdf2157380d3 ) )
        {
            thread [[ var_8f68bdf2157380d3 ]]( params );
        }
    }
}

// Namespace ztron_item
// Params 1, eflags: 0x4
// Checksum 0xccdc30bd, Offset: 0x236c
// Size: 0x88
function private onplayerspawned( params )
{
    if ( !isdefined( self.var_6f2c4e98502eac9b ) )
    {
        self.var_6f2c4e98502eac9b = spawn( "script_model", self.origin + ( 0, 0, 100 ) );
        self.var_6f2c4e98502eac9b setmodel( "tag_origin" );
        self.var_6f2c4e98502eac9b notsolid();
        self.var_6f2c4e98502eac9b linkto( self );
        self.var_6f2c4e98502eac9b.vo_audience = self;
    }
}

// Namespace ztron_item
// Params 1, eflags: 0x4
// Checksum 0x96454558, Offset: 0x23fc
// Size: 0x31
function private onplayerdisconnect( params )
{
    if ( isdefined( self.var_6f2c4e98502eac9b ) )
    {
        self.var_6f2c4e98502eac9b delete();
        self.var_6f2c4e98502eac9b = undefined;
    }
}

// Namespace ztron_item
// Params 1, eflags: 0x4
// Checksum 0xfe43d22b, Offset: 0x2435
// Size: 0x166
function private function_2f427f1391ecb18b( player )
{
    itemdata = level.ztron.itemdef.itemdata[ self.var_8593f17418a81b6e ];
    
    if ( itemdata.score )
    {
        gems = itemdata.gems;
        
        if ( isdefined( self.scale ) )
        {
            gems *= self.scale;
        }
        
        itemtype = self.spawnbundle.genericstring;
        player ztron_score::scorepickup( itemdata.score, gems, itemtype );
        
        if ( itemdata.gems )
        {
            rechargePoints = 1;
            player thread ztron_player_utility::function_9dbd11353321b474( undefined, rechargePoints );
        }
    }
    
    if ( itemdata.category != "treasure" )
    {
        if ( !isdefined( player.ztron.total_scripted_item_used ) )
        {
            player.ztron.total_scripted_item_used = 0;
        }
        
        player.ztron.total_scripted_item_used += 1;
        player stats::function_fe615555f60e88b9( player.ztron.total_scripted_item_used );
    }
}

// Namespace ztron_item
// Params 1, eflags: 0x4
// Checksum 0x56292c08, Offset: 0x25a3
// Size: 0xea
function private function_97ad3cdeaa446b75( player )
{
    if ( player.ztron.var_2360e803c32a15a7 == 0 )
    {
        return;
    }
    
    itemdata = level.ztron.itemdef.itemdata[ self.var_8593f17418a81b6e ];
    
    if ( itemdata.soundalias )
    {
        speaker = player.var_6f2c4e98502eac9b;
        itemtype = getscriptbundlefieldvalue( self.var_8593f17418a81b6e, #"genericstring" );
        
        if ( isdefined( itemtype ) )
        {
            var_8f68bdf2157380d3 = function_230d60331b07b7da( itemtype, #"hash_bf9815990d609ba5" );
            
            if ( isdefined( var_8f68bdf2157380d3 ) )
            {
                speaker = self [[ var_8f68bdf2157380d3 ]]( player );
            }
        }
        
        if ( isdefined( speaker ) )
        {
            speaker thread dialogue::say( itemdata.soundalias, 0, 0, 0 );
        }
    }
}

// Namespace ztron_item
// Params 1, eflags: 0x4
// Checksum 0xd73dbec1, Offset: 0x2695
// Size: 0x5c
function private function_2ceef8dac4e8ac3f( params )
{
    itemtype = params.bundle.genericstring;
    
    if ( isdefined( itemtype ) )
    {
        var_8f68bdf2157380d3 = function_230d60331b07b7da( itemtype, #"canautouse" );
        
        if ( isdefined( var_8f68bdf2157380d3 ) )
        {
            return [[ var_8f68bdf2157380d3 ]]( params );
        }
    }
    
    return 1;
}

// Namespace ztron_item
// Params 2, eflags: 0x4
// Checksum 0xb854edce, Offset: 0x26fa
// Size: 0x90
function private function_e40dc148ba189702( bundlename, params )
{
    var_f3bd463519f09f1d = isdefined( bundlename );
    assert( var_f3bd463519f09f1d, "<dev string:x93>" );
    
    if ( !var_f3bd463519f09f1d )
    {
        params.disablespawn = 1;
        return;
    }
    
    itemtype = getscriptbundlefieldvalue( bundlename, #"genericstring" );
    
    if ( isdefined( itemtype ) )
    {
        var_8f68bdf2157380d3 = function_230d60331b07b7da( itemtype, #"hash_3836c356bfe5bc30" );
        
        if ( isdefined( var_8f68bdf2157380d3 ) )
        {
            return [[ var_8f68bdf2157380d3 ]]( params );
        }
    }
    
    return params;
}

// Namespace ztron_item
// Params 1, eflags: 0x4
// Checksum 0x99fc3fae, Offset: 0x2793
// Size: 0xcd
function private function_6e31c5f4e9c2087a( lifetime )
{
    self endon( #"death" );
    self.lifetime = lifetime;
    blinktime = 11;
    waittime = lifetime - blinktime;
    waittime = waittime >= 0 ? waittime : 0;
    wait waittime;
    function_f3a14f9ecec2787a( "slow" );
    blinktime -= 7;
    wait 7;
    function_f3a14f9ecec2787a( "normal" );
    blinktime -= 2.5;
    wait 2.5;
    function_f3a14f9ecec2787a( "fast" );
    wait blinktime;
    self notify( #"hash_f28639cbcf419bd4" );
    
    if ( isdefined( self.despawnsound ) )
    {
        ztron_sound::ztron_playsound( self.despawnsound, self.origin );
    }
    
    waitframe();
    thread clearitem( self );
}

// Namespace ztron_item
// Params 1, eflags: 0x4
// Checksum 0x2ca17867, Offset: 0x2868
// Size: 0x45
function private function_f3a14f9ecec2787a( state )
{
    statename = "blinkshow_" + state;
    
    if ( self isscriptableinstance() && self getscriptableparthasstate( "body_state", statename ) )
    {
        self setscriptablepartstate( "body_state", statename );
    }
}

// Namespace ztron_item
// Params 1, eflags: 0x4
// Checksum 0xea5f0cc8, Offset: 0x28b5
// Size: 0x3c, Type: bool
function private function_c701cdf0cbd5d860( item )
{
    return distancesquared( self.origin, item.origin ) < squared( 1000 ) && !item.inuse;
}

// Namespace ztron_item
// Params 0
// Checksum 0xbd5d6366, Offset: 0x28fa
// Size: 0x102
function function_56cfc1fd654af986()
{
    if ( !isdefined( self.ztron.pickupupdate ) )
    {
        return;
    }
    
    time = gettime();
    
    if ( self.ztron.pickupupdate > time )
    {
        return;
    }
    
    if ( !self.ztron.isboosting )
    {
        self.ztron.pickupupdate = time + 250;
    }
    else
    {
        self.ztron.pickupupdate = time;
    }
    
    if ( level.ztron.itemdef.spawneditems )
    {
        self.ztron.localitems = utility::function_5fdf0884f9b2d470( level.ztron.itemdef.spawneditems, &function_c701cdf0cbd5d860 );
        return;
    }
    
    self.ztron.localitems = [];
}

// Namespace ztron_item
// Params 2
// Checksum 0x88357d8b, Offset: 0x2a04
// Size: 0x146
function function_b4d3dc5570de1aed( player, waitnote )
{
    self endon( #"item_cleared" );
    
    if ( isdefined( waitnote ) )
    {
        self waittill( waitnote );
    }
    
    self.inuse = 1;
    target = self;
    var_9e1a89b22e702898 = 32;
    height = target.origin[ 2 ];
    
    while ( isdefined( player ) && isdefined( target ) )
    {
        target.origin = ( player.origin[ 0 ], player.origin[ 1 ], height );
        diff = abs( height - player.origin[ 2 ] );
        
        if ( diff > var_9e1a89b22e702898 && height > player.origin[ 2 ] )
        {
            height -= var_9e1a89b22e702898;
        }
        else
        {
            break;
        }
        
        waitframe();
    }
    
    if ( !isdefined( player ) && isdefined( target ) )
    {
        target.origin = utility::drop_to_ground( target.origin, 64 );
        self.owner = undefined;
    }
    
    self notify( #"item_bombed" );
    self.inuse = 0;
    
    if ( isdefined( player ) )
    {
        thread function_5dce405b07e4f28c( player );
    }
}

// Namespace ztron_item
// Params 1
// Checksum 0x8f163d91, Offset: 0x2b52
// Size: 0x23b
function function_5dce405b07e4f28c( player )
{
    self notify( #"hash_d7e67cfec9da7b0b" );
    self endon( #"hash_d7e67cfec9da7b0b" );
    self endon( #"death" );
    player endon( #"death" );
    
    if ( self.inuse || !isplayer( player ) || player.inlaststand )
    {
        return;
    }
    
    if ( isent( self ) )
    {
        assert( self.spawnbundle );
        canusefunc = function_230d60331b07b7da( self.spawnbundle.genericstring, #"canautouse" );
        usefunc = function_230d60331b07b7da( self.spawnbundle.genericstring, #"use" );
        canuse = isdefined( canusefunc ) ? self [[ canusefunc ]]() : 1;
        
        if ( canuse && isdefined( usefunc ) )
        {
            if ( isdefined( self.spawnbundle.pickupsfx ) )
            {
                self playsoundonmovingent( self.spawnbundle.pickupsfx );
            }
            
            params = spawnstruct();
            params.scriptable = self;
            params.player = player;
            params.bundle = self.spawnbundle;
            player thread [[ usefunc ]]( params );
            quantityused = 1;
        }
        else
        {
            quantityused = 0;
        }
    }
    else
    {
        quantityused = player common_item::function_2b5e2ff57d5f392( self, 1 );
    }
    
    if ( quantityused > 0 )
    {
        self notify( #"picked_up" );
        function_2f427f1391ecb18b( player );
        function_97ad3cdeaa446b75( player );
        thread ztron_telemetry::itempickedup( player );
        
        if ( !self.inuse )
        {
            thread clearitem( self );
        }
        else if ( self.shootableitem && self getscriptableparthasstate( "health", "ignore_damage" ) )
        {
            self setscriptablepartstate( "health", "ignore_damage" );
        }
        
        return;
    }
    
    if ( self.shootableitem && self getscriptableparthasstate( "health", "shootable" ) )
    {
        self setscriptablepartstate( "health", "shootable" );
    }
}

// Namespace ztron_item
// Params 3
// Checksum 0x3728cb33, Offset: 0x2d95
// Size: 0xdb
function function_d2dd7af394ebdbdd( itemref, storebought = 0, waitnote )
{
    profilestart();
    var_88547c4c73c3ec02 = function_71e133b37011bee6( itemref );
    
    if ( !isdefined( var_88547c4c73c3ec02 ) )
    {
        profilestop();
        return;
    }
    
    pos = self.origin + ( 0, 0, 3000 );
    item = spawnitem( var_88547c4c73c3ec02, pos, 0, undefined, { #modelspinning:0, #disable_dragged:1 } );
    
    if ( isdefined( item ) )
    {
        item.owner = self;
        item.storebought = storebought;
        
        if ( self.inlaststand && !isdefined( waitnote ) )
        {
            waitnote = "self_respawned";
        }
        
        item thread function_b4d3dc5570de1aed( self, waitnote );
    }
    
    profilestop();
    return item;
}

// Namespace ztron_item
// Params 4
// Checksum 0x5f60d3ac, Offset: 0x2e7a
// Size: 0xf7
function function_bdebc9f850639d13( itemref, location, storebought = 0, params )
{
    profilestart();
    var_88547c4c73c3ec02 = function_71e133b37011bee6( itemref );
    
    if ( !isdefined( var_88547c4c73c3ec02 ) )
    {
        profilestop();
        return;
    }
    
    if ( !isdefined( location ) )
    {
        location = self.origin;
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( location );
    item = spawnitem( var_88547c4c73c3ec02, location, 0, spawnoptions );
    item.owner = self;
    item.storebought = storebought;
    item.params = params;
    
    if ( !arraycontains( self.ztron.localitems, item ) )
    {
        self.ztron.localitems[ self.ztron.localitems.size ] = item;
    }
    
    profilestop();
}

// Namespace ztron_item
// Params 0
// Checksum 0xc1bacf70, Offset: 0x2f79
// Size: 0x474
function function_4ccc2a210994178c()
{
    if ( !isdefined( self.ztron.localitems ) || self.ztron.localitems.size == 0 )
    {
        return;
    }
    
    playerx = self.origin[ 0 ];
    playery = self.origin[ 1 ];
    var_10f50841c4b80477 = self.origin[ 2 ];
    var_10f51a41c4b82c0d = 72;
    var_10f4fb41c4b7e7e0 = 25;
    
    if ( isdefined( self.ztron.vehicle ) )
    {
        var_10f51a41c4b82c0d = 70;
        var_10f4fb41c4b7e7e0 = 40;
        
        if ( self.ztron.vehicle vehicle::ishelicopter() )
        {
            var_10f50841c4b80477 += level.ztron.var_8e96854cca0f779c ?? -80;
            var_10f51a41c4b82c0d = level.ztron.var_6e99d2677d1c2965 ?? 160;
        }
    }
    
    playertop = var_10f50841c4b80477 + var_10f51a41c4b82c0d;
    playerleft = playerx - var_10f4fb41c4b7e7e0;
    playerright = playerx + var_10f4fb41c4b7e7e0;
    playerfront = playery - var_10f4fb41c4b7e7e0;
    playerback = playery + var_10f4fb41c4b7e7e0;
    
    foreach ( item in self.ztron.localitems )
    {
        bundlename = function_2f7a695f25056625( item );
        
        if ( isdefined( self.ztron.vehicle ) && !level.ztron.itemdef.itemdata[ bundlename ].var_9d69a047e6e29085 )
        {
            continue;
        }
        
        if ( ( self.ztron.usingmutant || self.ztron.var_c516f6d55a2165b4 ) && !level.ztron.itemdef.itemdata[ bundlename ].var_7033516b1ee46af0 )
        {
            continue;
        }
        
        if ( item.inuse )
        {
            continue;
        }
        
        if ( isdefined( item.owner ) && item.owner != self )
        {
            continue;
        }
        
        scale = item.scale ? item.scale : 1;
        boxscale = function_c35dc08d0caf06fa( scale );
        itemwidth = level.ztron.itemdef.itemdata[ bundlename ].width;
        var_45e8ae99ac742ba6 = level.ztron.itemdef.itemdata[ bundlename ].height;
        itemzoffset = level.ztron.itemdef.itemdata[ bundlename ].zoffset;
        var_45e8ae99ac742ba6 = ( var_45e8ae99ac742ba6 > 0 ? var_45e8ae99ac742ba6 : 72 ) * boxscale;
        itemz = item.origin[ 2 ] + itemzoffset * scale;
        
        if ( itemz + var_45e8ae99ac742ba6 < var_10f50841c4b80477 || itemz - var_45e8ae99ac742ba6 > playertop )
        {
            continue;
        }
        
        itemwidth = ( itemwidth > 0 ? itemwidth : 42 ) * boxscale;
        itemx = item.origin[ 0 ];
        minx = itemx - itemwidth;
        maxx = itemx + itemwidth;
        
        if ( maxx < playerleft || minx > playerright )
        {
            continue;
        }
        
        itemy = item.origin[ 1 ];
        miny = itemy - itemwidth;
        maxy = itemy + itemwidth;
        
        if ( maxy < playerfront || miny > playerback )
        {
            continue;
        }
        
        item thread function_5dce405b07e4f28c( self );
    }
}

// Namespace ztron_item
// Params 1, eflags: 0x4
// Checksum 0x528cc3bf, Offset: 0x33f5
// Size: 0x28
function private function_c35dc08d0caf06fa( scale )
{
    if ( scale > 1 )
    {
        scale = clamp( scale * 0.25, 1, scale );
    }
    
    return scale;
}

// Namespace ztron_item
// Params 1
// Checksum 0x93e5ce16, Offset: 0x3426
// Size: 0xaf
function clearitem( item )
{
    if ( !isdefined( item ) )
    {
        return;
    }
    
    level.ztron.itemdef.spawneditems = arrayremove( level.ztron.itemdef.spawneditems, item );
    item function_fc50a80f5784c3a6();
    
    if ( isdefined( item.group_instance_id ) )
    {
        scriptable_group::function_3359d6f82b103a4e( "common_items", item );
    }
    
    item notify( #"item_cleared" );
    item notify( #"death" );
    
    if ( isent( item ) )
    {
        item delete();
        return;
    }
    
    item freescriptable();
}

// Namespace ztron_item
// Params 0
// Checksum 0x99388afa, Offset: 0x34dd
// Size: 0xd2
function function_25f69b2b896fd56()
{
    foreach ( item in level.ztron.itemdef.spawneditems )
    {
        if ( !item.inuse )
        {
            thread clearitem( item );
        }
    }
    
    level.ztron.itemdef.spawneditems = [];
    level.ztron.var_cbceca19d7ef7c87 = 0;
}

// Namespace ztron_item
// Params 0
// Checksum 0xaf016c32, Offset: 0x35b7
// Size: 0xb8
function function_bae0ccef6b0adbca()
{
    self endon( #"death" );
    
    if ( !isdefined( self.org ) )
    {
        utility::scriptable_clearparententity();
        ent = spawn( "script_model", self.origin );
        
        if ( isdefined( ent ) )
        {
            ent setmodel( "tag_origin" );
            ent.angles = self.angles ?? ( 0, 0, 0 );
            self.org = ent;
            ent.childitem = self;
            ent thread function_5a53e8abb40115ff();
            waitframe();
            
            if ( isdefined( ent ) && !isdefined( self.linkedparent ) )
            {
                utility::scriptable_setparententity( ent );
            }
        }
    }
}

// Namespace ztron_item
// Params 0
// Checksum 0xc28d5e30, Offset: 0x3677
// Size: 0x44
function function_fc50a80f5784c3a6()
{
    if ( isdefined( self.org ) )
    {
        if ( self.org == self.linkedparent )
        {
            utility::scriptable_clearparententity();
        }
        
        self.org delete();
        self.org = undefined;
    }
}

// Namespace ztron_item
// Params 0
// Checksum 0x7a545b4a, Offset: 0x36c3
// Size: 0x3d
function getitemuniqueid()
{
    level.ztron.itemdef.uniqueid++;
    return level.ztron.itemdef.uniqueid;
}

// Namespace ztron_item
// Params 1
// Checksum 0x15818316, Offset: 0x3709
// Size: 0x3e
function function_863b1ea6b2c7cb07( notifyalert )
{
    level waittill( notifyalert, item );
    self.item = item.entity;
    self notify( #"item_spawned" );
}

// Namespace ztron_item
// Params 1
// Checksum 0x8ca16aae, Offset: 0x374f
// Size: 0x2d6
function function_6607be6e510e8f54( var_8260f0f996dc9927 = self.var_8260f0f996dc9927 )
{
    foreach ( point in var_8260f0f996dc9927 )
    {
        type = point.script_noteworthy;
        ref = point.script_label;
        num = -1;
        radius = 0;
        
        if ( isdefined( point.script_parameters ) )
        {
            tokens = strtok( point.script_parameters, ";" );
            num = isdefined( tokens[ 0 ] ) ? int( tokens[ 0 ] ) : 0;
            radius = isdefined( tokens[ 1 ] ) ? int( tokens[ 1 ] ) : 0;
            shootable = isdefined( tokens[ 2 ] ) ? int( tokens[ 2 ] ) == 1 : 0;
        }
        
        params = spawnstruct();
        params.overridelifetime = 9999;
        params.mapbased = 1;
        params.shootable = shootable;
        
        if ( num > 1 || type == "list" )
        {
            items = common_item::items_selectfromlist( ref, num );
            
            foreach ( item in items )
            {
                requestspawnitem( item, point.origin + ( 0, 0, 25 ), radius, undefined, params );
            }
            
            continue;
        }
        
        if ( type == "item" && !isdefined( point.item ) )
        {
            params.scale = point.itemscale ?? 1;
            params.modelspinning = 0;
            params.overrideangles = point.angles;
            bundlename = function_71e133b37011bee6( ref );
            notifyalert = "lootItem-" + getitemuniqueid();
            point thread function_863b1ea6b2c7cb07( notifyalert );
            requestspawnitem( bundlename, point.origin, 0, undefined, params, notifyalert );
        }
    }
}

// Namespace ztron_item
// Params 1, eflags: 0x4
// Checksum 0x5c5d7a34, Offset: 0x3a2d
// Size: 0xb3
function private function_4057fcdcce3f0af6( initdelay )
{
    self endon( #"death" );
    
    if ( initdelay > 0 )
    {
        wait initdelay;
    }
    
    if ( isent( self ) )
    {
        deltayaw = randomfloatrange( 2.5, 5.5 );
        
        if ( utility::cointoss() )
        {
            deltayaw *= -1;
        }
        
        while ( isdefined( self ) && !isdefined( self.linkedparent ) )
        {
            if ( isent( self ) )
            {
                self rotateyaw( deltayaw, level.framedurationseconds );
            }
            
            waitframe();
        }
        
        return;
    }
    
    if ( self isscriptableinstance() && self getscriptableparthasstate( "rotation", "random_rotation" ) )
    {
        self setscriptablepartstate( "rotation", "random_rotation" );
    }
}

// Namespace ztron_item
// Params 0, eflags: 0x4
// Checksum 0x8d0985fa, Offset: 0x3ae8
// Size: 0x2e
function private function_5a53e8abb40115ff()
{
    self endon( #"death" );
    self.childitem waittill( #"death" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace ztron_item
// Params 4
// Checksum 0x84514b51, Offset: 0x3b1e
// Size: 0x217
function function_f580915d21ddba69( player, endpos = undefined, time = 2, var_799e25f3799eedfc = undefined )
{
    self endon( #"item_cleared" );
    
    if ( isdefined( self ) )
    {
        function_59ff7bc8f83749c6();
        self.inuse = 1;
        target = self;
        
        if ( !isent( self ) )
        {
            function_fc50a80f5784c3a6();
            thread function_bae0ccef6b0adbca();
            target = self.org;
        }
        
        target notsolid();
        target function_b398682b38f521f5( 1 );
        function_f3a14f9ecec2787a( "restore" );
        
        if ( isdefined( var_799e25f3799eedfc ) )
        {
            [[ var_799e25f3799eedfc ]]( self );
        }
        
        if ( isdefined( level.ztron.var_f6a33d41e2af442c ) )
        {
            endpos = self [[ level.ztron.var_f6a33d41e2af442c ]]( player );
        }
        
        if ( !isdefined( endpos ) )
        {
            if ( isdefined( player ) )
            {
                x = 2000;
                y = 3000;
                z = 1000;
                
                if ( level.ztron.arenaCamFlip )
                {
                    x = 0 - x;
                    y = 0 - y;
                }
                
                if ( player.sessionuimemberindex == 1 )
                {
                    y = 0 - y;
                }
                else if ( player.sessionuimemberindex == 2 )
                {
                    x = 0 - x;
                }
                else if ( player.sessionuimemberindex == 3 )
                {
                    y = 0 - y;
                    x = 0 - x;
                }
                
                endpos = player.origin + ( x, y, z );
            }
            else
            {
                endpos = self.origin + ( 0, 0, 3000 );
            }
        }
        
        if ( level.ztron.var_2e9bbb5f5a0cd240 )
        {
            time = level.ztron.var_2e9bbb5f5a0cd240;
        }
        
        self.disable_dragged = 1;
        self notify( #"hash_2707519ad1e4d234" );
        target moveto( endpos, time );
        wait time;
        thread clearitem( self );
    }
}

// Namespace ztron_item
// Params 4
// Checksum 0x600256d2, Offset: 0x3d3d
// Size: 0x155
function function_8b0c01e93664327d( center_entity, var_5cb415ff1a6f5b0b, rotate_entity_array, yaw_rotation_speed = 180 )
{
    var_7c4d5294acdb33b4 = utility::spawn_model( "ztron_tag_origin_animate", center_entity.origin );
    var_7c4d5294acdb33b4 enablelinkto();
    var_7c4d5294acdb33b4 linktoignorerotation( center_entity, var_5cb415ff1a6f5b0b, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    foreach ( rotate_entity in rotate_entity_array )
    {
        link_offset = rotate_entity.origin - var_7c4d5294acdb33b4.origin;
        rotate_entity linkto( var_7c4d5294acdb33b4, "tag_origin_animate", link_offset, rotate_entity.angles );
    }
    
    anim_rate = math::round_float( yaw_rotation_speed / 180, 2 );
    var_7c4d5294acdb33b4 scriptmodelplayanim( %"sat_ztron_item_rotate_around_center_anim", "rotate", 0, anim_rate );
    return var_7c4d5294acdb33b4;
}

// Namespace ztron_item
// Params 6
// Checksum 0xde0d358b, Offset: 0x3e9b
// Size: 0xfd
function function_19da353cdad58904( center_entity, var_5cb415ff1a6f5b0b, rotate_entity, yaw_rotation_speed = 180, var_59362a2fb4457b76 = ( 0, 0, 0 ), var_32e23024ec877195 = ( 0, 0, 0 ) )
{
    var_7c4d5294acdb33b4 = utility::spawn_model( "ztron_tag_origin_animate", center_entity.origin );
    var_7c4d5294acdb33b4 enablelinkto();
    var_7c4d5294acdb33b4 linktoignorerotation( center_entity, var_5cb415ff1a6f5b0b, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    rotate_entity linkto( var_7c4d5294acdb33b4, "tag_origin_animate", var_59362a2fb4457b76, var_32e23024ec877195 );
    anim_rate = math::round_float( yaw_rotation_speed / 180, 2 );
    var_7c4d5294acdb33b4 scriptmodelplayanim( %"sat_ztron_item_rotate_around_center_anim", "rotate", 0, anim_rate );
    return var_7c4d5294acdb33b4;
}

// Namespace ztron_item
// Params 1
// Checksum 0x7b77647a, Offset: 0x3fa1
// Size: 0x7c
function function_21c3b4ab8aa7468d( var_801f80fa0af43838 )
{
    foreach ( var_20ef0bac1d93be6c in var_801f80fa0af43838 )
    {
        var_20ef0bac1d93be6c unlink();
    }
}

// Namespace ztron_item
// Params 1
// Checksum 0x55949354, Offset: 0x4025
// Size: 0x21
function function_39d7023e3666b11e( var_7c4d5294acdb33b4 )
{
    var_7c4d5294acdb33b4 scriptmodelclearanim();
    var_7c4d5294acdb33b4 unlink();
    var_7c4d5294acdb33b4 delete();
}

// Namespace ztron_item
// Params 1
// Checksum 0xc6458272, Offset: 0x404e
// Size: 0xc5
function function_4c047b50a640febf( spot )
{
    waittillframeend();
    pos = spot + ( 0, 0, 30 );
    spawnoptions = function_41854e96b8bf4a06( pos );
    qty = 1;
    clusteritemspawn( level.ztron.var_7833ff35a7f394ec, pos, qty, 36, spawnoptions );
    
    if ( !isdefined( level.ztron.slayer.treasuredropped ) )
    {
        level.ztron.slayer.treasuredropped = 0;
    }
    
    level.ztron.slayer.treasuredropped++;
}

// Namespace ztron_item
// Params 1
// Checksum 0xb53273e1, Offset: 0x411b
// Size: 0xbf
function debug_spawn_item( params )
{
    ref = params[ 0 ];
    var_88547c4c73c3ec02 = function_71e133b37011bee6( ref );
    
    if ( !isdefined( var_88547c4c73c3ec02 ) )
    {
        return;
    }
    
    viewangles = level.players[ 0 ] getplayerangles();
    vieweye = level.players[ 0 ] geteye();
    playerforward = anglestoforward( viewangles );
    pos = vieweye + playerforward * 140;
    pos = ztron_util::function_3fe38741460a4a49( pos ) + ( 0, 0, 20 );
    spawnoptions = common_item::function_bc5ff2958b71a708( pos );
    requestspawnitem( var_88547c4c73c3ec02, pos, 0, spawnoptions );
}

/#

    // Namespace ztron_item
    // Params 0, eflags: 0x4
    // Checksum 0xc7b9e18c, Offset: 0x41e2
    // Size: 0x1a3, Type: dev
    function private function_ac7ee3673d6e340d()
    {
        items = [];
        weapons = [];
        treasureitems = [];
        var_5a58df37fdc7e547 = [];
        
        foreach ( bundlename, data in level.ztron.itemdef.itemdata )
        {
            bundle = getscriptbundlefieldvalues( bundlename, [ #"ref", #"genericstring" ] );
            type = data.category;
            
            switch ( type )
            {
                case #"hash_27124c6c97ccffa1":
                    weapons[ weapons.size ] = bundle;
                    break;
                case #"hash_b51c5d96fa396084":
                    treasureitems[ treasureitems.size ] = bundle;
                    break;
                case #"hash_8c089e813083e510":
                    var_5a58df37fdc7e547[ var_5a58df37fdc7e547.size ] = bundle;
                    break;
                default:
                    items[ items.size ] = bundle;
                    break;
            }
        }
        
        assert( items.size < 50, "<dev string:xdd>" );
        assert( weapons.size < 20, "<dev string:x104>" );
        assert( treasureitems.size < 20, "<dev string:x12d>" );
        assert( var_5a58df37fdc7e547.size < 50, "<dev string:x15c>" );
    }

    // Namespace ztron_item
    // Params 1, eflags: 0x4
    // Checksum 0x5bfefcd, Offset: 0x438d
    // Size: 0xcf, Type: dev
    function private add_debug_item( items )
    {
        foreach ( bundle in items )
        {
            if ( isdefined( bundle.ref ) )
            {
                tokenname = removesubstr( bundle.ref, "<dev string:x18a>" );
                params = "<dev string:x191>" + bundle.ref;
                devgui::function_cd4e263c1f3018ae( tokenname, params, &debug_spawn_item );
            }
        }
    }

    // Namespace ztron_item
    // Params 0, eflags: 0x4
    // Checksum 0x954cdd65, Offset: 0x4464
    // Size: 0x2e2, Type: dev
    function private function_fe7676e1e4514fdd()
    {
        level endon( #"ztron_game_is_over" );
        level waittill( #"player_spawned", player );
        setdvarifuninitialized( @"hash_dea0fbb77df32d60", 0 );
        
        while ( isdefined( player ) )
        {
            if ( getdvarint( @"hash_dea0fbb77df32d60" ) == 0 )
            {
                wait 1;
                continue;
            }
            
            pos = player.origin;
            var_10f51a41c4b82c0d = 72;
            var_10f4fb41c4b7e7e0 = 25;
            
            if ( isdefined( player.ztron.vehicle ) )
            {
                var_10f51a41c4b82c0d = 70;
                var_10f4fb41c4b7e7e0 = 40;
                
                if ( player.ztron.vehicle vehicle::ishelicopter() )
                {
                    pos += ( 0, 0, level.ztron.var_8e96854cca0f779c ?? -80 );
                    var_10f51a41c4b82c0d = level.ztron.var_6e99d2677d1c2965 ?? 160;
                }
            }
            
            cylinder( pos, pos + ( 0, 0, var_10f51a41c4b82c0d ), var_10f4fb41c4b7e7e0, ( 0, 0, 255 ) );
            
            if ( getdvarint( @"hash_dea0fbb77df32d60" ) > 1 )
            {
                foreach ( item in player.ztron.localitems )
                {
                    scale = item.scale ? item.scale : 1;
                    boxscale = function_c35dc08d0caf06fa( scale );
                    bundlename = function_2f7a695f25056625( item );
                    itemwidth = level.ztron.itemdef.itemdata[ bundlename ].width;
                    itemwidth = ( itemwidth > 0 ? itemwidth : 42 ) * boxscale;
                    var_45e8ae99ac742ba6 = level.ztron.itemdef.itemdata[ bundlename ].height;
                    var_45e8ae99ac742ba6 = ( var_45e8ae99ac742ba6 > 0 ? var_45e8ae99ac742ba6 : 72 ) * boxscale;
                    itemzoffset = level.ztron.itemdef.itemdata[ bundlename ].zoffset;
                    orientedbox( item.origin + ( 0, 0, itemzoffset * scale ), ( itemwidth, itemwidth, var_45e8ae99ac742ba6 ), ( 0, 0, 0 ) );
                }
            }
            
            waitframe();
        }
    }

    // Namespace ztron_item
    // Params 0, eflags: 0x4
    // Checksum 0x62652047, Offset: 0x474e
    // Size: 0x9a, Type: dev
    function private function_5f2503191e3b55ab()
    {
        level endon( #"ztron_game_is_over" );
        level waittill( #"player_spawned", player );
        setdvarifuninitialized( @"hash_406dd8020399fdcf", "<dev string:x1a3>" );
        
        while ( true )
        {
            cmd = getdvar( @"hash_406dd8020399fdcf" );
            
            if ( cmd == "<dev string:x1a3>" )
            {
                wait 1;
                continue;
            }
            
            params = [];
            params[ 0 ] = cmd;
            debug_spawn_item( params );
            setdvar( @"hash_406dd8020399fdcf", "<dev string:x1a3>" );
        }
    }

#/
