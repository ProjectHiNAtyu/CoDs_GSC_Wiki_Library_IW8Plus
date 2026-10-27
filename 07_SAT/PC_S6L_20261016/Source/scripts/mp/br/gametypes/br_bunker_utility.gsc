// scripts\mp\br\gametypes\br_bunker_utility.gsc  (hash_3f84bc66c0578a76.gscc) (size: 17141 Bytes / 0x42f5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x53529539 (1397921081)
// size ...... 17141 (0x42f5)
// includes .. 9   (offset: 0x3de9)
// strings ... 75  (offset: 0x3e31)
// dev strs .. 5   (offset: 0x428d)
// exports ... 39  (offset: 0x2ca1)
// cseg ...... 0x789 + 0x2518 (0x2ca1)
// imports ... 88  (offset: 0x32b9)
// animtree1 . 1   (offset: 0x42c9)
// animtree2 . 2   (offset: 0x42d5)
#using script_16ea1b94f0f381b3;
#using scripts\common\anim;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_keypad_util;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\flags;
#using scripts\mp\loot\common_item;
#using scripts\mp\pickups_scriptable;

#namespace br_bunker_utility;

// Namespace br_bunker_utility
// Params 0
// Checksum 0x5ebe5290, Offset: 0x7a7
// Size: 0x32
function init()
{
    initbunkeranims();
    initbunkervfx();
    function_7e2e5e59c6f214cc();
    scriptable::scriptable_addusedcallbackbypart( "maphint_keypad_bunker_interior", &keypadscriptableused );
    level.bunker_doors = [];
}

#using_animtree( "animated_props" );

// Namespace br_bunker_utility
// Params 0
// Checksum 0xeabee2ad, Offset: 0x7e1
// Size: 0x52
function initbunkeranims()
{
    level.scr_animtree[ "bunker_door" ] = #animtree;
    level.scr_anim[ "bunker_door" ][ "door_open" ] = %mp_verdansk_bunkerdoor_open;
    level.scr_anim[ "bunker_door" ][ "door_open_puzzle" ] = %mp_verdansk_bunkerdoor_open_puzzle;
}

// Namespace br_bunker_utility
// Params 0
// Checksum 0x2b43f7c4, Offset: 0x83b
// Size: 0x115
function initbunkervfx()
{
    level._effect[ "vfx_br_bunker_open" ] = loadfxasset( "vfx_iw8_br_gameplay_bunker_open" );
    level._effect[ "vfx_br_bunker_open_2" ] = loadfxasset( "vfx_iw8_br_gameplay_bunker_open_2" );
    level._effect[ "vfx_br_bunker_open_puzzle" ] = loadfxasset( "vfx_iw8_br_gameplay_bunker_open_puzzle" );
    level._effect[ "vfx_br_bulb_lensflare_green" ] = loadfxasset( "vfx_iw8_br_gen_amb_bulb_lf_green" );
    level._effect[ "vfx_br_bulb_lensflare_red" ] = loadfxasset( "vfx_iw8_br_gen_amb_bulb_lf_red" );
    level._effect[ "vfx_br_bunker_screen_crashed" ] = loadfxasset( "vfx_iw8_br_gameplay_bunker_screen_crashed" );
    level._effect[ "vfx_br_bunker_screen_rebooting" ] = loadfxasset( "vfx_iw8_br_gameplay_bunker_screen_rebooting" );
    level._effect[ "vfx_br_bunker_screen_ready" ] = loadfxasset( "vfx_t10_gameplay_bunker_screen_ready_02" );
    level._effect[ "vfx_br_bunker_screen_crashed2" ] = loadfxasset( "vfx_iw8_br_gameplay_bunker_screen_crashed2" );
    level._effect[ "vfx_br_bunker_screen_rebooting2" ] = loadfxasset( "vfx_iw8_br_gameplay_bunker_screen_rebooting2" );
    level._effect[ "vfx_br_bunker_screen_countdown" ] = loadfxasset( "vfx_iw8_br_gameplay_bunker_screen_countdown" );
}

// Namespace br_bunker_utility
// Params 0
// Checksum 0x7dba32de, Offset: 0x958
// Size: 0x37
function function_7e2e5e59c6f214cc()
{
    if ( !isdefined( level.bunkervolumes ) )
    {
        level.bunkervolumes = arraycombine( getentarray( "DenyBunkerSpawnZone", "script_noteworthy" ), getnoentvolumearray( "DenyBunkerSpawnZone", "script_noteworthy" ) );
    }
}

// Namespace br_bunker_utility
// Params 1
// Checksum 0x91cbe796, Offset: 0x997
// Size: 0xa1, Type: bool
function function_5f3fda39a064e862( origin )
{
    if ( !isdefined( level.bunkervolumes ) )
    {
        return false;
    }
    
    foreach ( volume in level.bunkervolumes )
    {
        if ( isdefined( volume ) && ispointinvolume( origin, volume ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_bunker_utility
// Params 3
// Checksum 0x896be574, Offset: 0xa41
// Size: 0x1df
function initbunkerdoor( door, openable, var_704c8e44b4b18847 )
{
    if ( !door isscriptableinstance() )
    {
        if ( isdefined( door.target ) )
        {
            parts = getentarray( door.target, #targetname );
            
            foreach ( part in parts )
            {
                if ( part.script_noteworthy == "right_door_clip" )
                {
                    door.clipleft = part;
                    door.clipleft setnonstick( 1 );
                    continue;
                }
                
                if ( part.script_noteworthy == "left_door_clip" )
                {
                    door.clipright = part;
                    door.clipright setnonstick( 1 );
                }
            }
        }
        
        door.animname = "bunker_door";
        door animation::setanimtree();
        
        if ( !var_704c8e44b4b18847 )
        {
            level thread initbunkerdooreffects( door, openable );
        }
    }
    
    forward = anglestoforward( door.angles );
    patchposition = door.origin + ( 0, 0, -110 ) + forward * -128;
    patch = spawnscriptable( "clip256x256x256", patchposition, door.angles );
    door.addedcollision = patch;
    level.bunker_doors[ level.bunker_doors.size ] = door;
}

// Namespace br_bunker_utility
// Params 2
// Checksum 0x1d7b8b51, Offset: 0xc28
// Size: 0x95
function initbunkerdooreffects( door, openable )
{
    wait 10;
    forward = anglestoforward( door.angles );
    effectposition = door.origin + ( 0, 0, 109 ) + forward * 12.5;
    door.lightscriptable = spawnscriptable( "bunker_active_indicator_light", effectposition );
    
    if ( openable )
    {
        door.lightscriptable setscriptablepartstate( "bunker_active_indicator_light", "active" );
    }
}

// Namespace br_bunker_utility
// Params 4
// Checksum 0x142c9746, Offset: 0xcc5
// Size: 0x30c
function openbunkerdoor( door, var_c71bb443dc77debf, var_6aff7d489731ae35, overrideanim )
{
    if ( door isscriptableinstance() )
    {
        door setscriptablepartstate( "body", "open" );
        
        if ( isdefined( door.addedcollision ) )
        {
            door.addedcollision freescriptable();
        }
        
        return;
    }
    
    dooranim = overrideanim ?? "door_open";
    door thread animation::anim_single_solo( door, dooranim );
    
    if ( soundexists( "br_bunker_door_open_01" ) )
    {
        door playsound( "br_bunker_door_open_01" );
    }
    
    if ( var_c71bb443dc77debf && isdefined( var_6aff7d489731ae35 ) )
    {
        spawnbunkerloot( door.origin, var_6aff7d489731ae35 );
    }
    
    animlength = getanimlength( level.scr_anim[ "bunker_door" ][ dooranim ] );
    var_e4f49461e25ed002 = animlength - 8.1;
    var_741601a247f64cbf = spawnscriptable( "x1_bunker_door_01_anim_open", door.origin, door.angles );
    waitframe();
    
    if ( isdefined( door.clipleft ) && isdefined( door.clipright ) )
    {
        if ( isdefined( door.addedcollision ) )
        {
            door.addedcollision freescriptable();
        }
        
        wait 8;
        forward = anglestoforward( door.angles );
        door.clipleft.origin += forward * -3;
        door.clipright.origin += forward * -3;
        door.clipleft rotateto( door.clipleft.angles - ( 0, 90, 0 ), 5, 0.2, 0.8 );
        door.clipright rotateto( door.clipright.angles + ( 0, 90, 0 ), 5, 0.2, 0.8 );
        
        if ( soundexists( "br_bunker_door_open_02" ) )
        {
            door playsound( "br_bunker_door_open_02" );
        }
        
        wait var_e4f49461e25ed002;
        var_741601a247f64cbf setscriptablepartstate( "body", "enabled" );
        wait 0.1;
        door hide();
        door.clipleft delete();
        door.clipright delete();
        return;
    }
    
    wait 8;
    
    if ( soundexists( "br_bunker_door_open_02" ) )
    {
        door playsound( "br_bunker_door_open_02" );
    }
    
    wait var_e4f49461e25ed002;
    
    if ( isdefined( door.addedcollision ) )
    {
        door.addedcollision freescriptable();
    }
    
    var_741601a247f64cbf setscriptablepartstate( "body", "enabled" );
    wait 0.1;
    door hide();
}

// Namespace br_bunker_utility
// Params 1
// Checksum 0x64bd71, Offset: 0xfd9
// Size: 0x102
function function_570a0e83663d22a4( bunkerref )
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    stagedrewards = utility::getstructarray( bunkerref, "targetname" );
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    
    foreach ( rewardstruct in stagedrewards )
    {
        spawnoptions = common_item::function_bc5ff2958b71a708( rewardstruct.origin, rewardstruct.angles );
        spawnoptions.critical = 1;
        scriptable = common_item::items_spawnitemfromscriptable( rewardstruct.script_noteworthy, undefined, spawnoptions );
    }
}

// Namespace br_bunker_utility
// Params 2
// Checksum 0x66d0516f, Offset: 0x10e3
// Size: 0x5dc
function spawnbunkerloot( bunkerdoororigin, var_8cfffa654045dbb7 )
{
    if ( !isdefined( level.br_pickups ) )
    {
        return;
    }
    
    masterlootnode = getclosestmatchingmasterlootnode( bunkerdoororigin, var_8cfffa654045dbb7 );
    allloot = utility::getstructarray( masterlootnode.target, "targetname" );
    cache_lege = [];
    cache_basic = [];
    var_4717f8260cd3f891 = [];
    remainingloot = [];
    var_5aad8cd96cc5effd = getdvarint( @"hash_35a1a079b733daae", 3 );
    var_e8e9180d9cd05733 = getdvarint( @"hash_357e9279b70d742c", 5 );
    var_f39710f30b56434c = getdvarint( @"hash_76cd14e5d929a7a7", 3 );
    var_55d2ef2053578e5e = getdvarint( @"hash_76f002e5d94fc7c9", 5 );
    
    foreach ( item in allloot )
    {
        if ( item.script_noteworthy == "br_loot_cache_lege" )
        {
            cache_lege[ cache_lege.size ] = item;
            continue;
        }
        
        if ( item.script_noteworthy == "br_loot_cache" )
        {
            cache_basic[ cache_basic.size ] = item;
            continue;
        }
        
        if ( issubstr( item.script_noteworthy, "uniqueLootItem" ) )
        {
            var_4717f8260cd3f891[ var_4717f8260cd3f891.size ] = item;
            continue;
        }
        
        remainingloot[ remainingloot.size ] = item;
    }
    
    numtospawn = randomintrange( var_5aad8cd96cc5effd, var_e8e9180d9cd05733 );
    cache_lege = arrayrandomize( cache_lege );
    cache_basic = arrayrandomize( cache_basic );
    
    for ( i = 0; i < numtospawn ; i++ )
    {
        if ( isdefined( cache_lege[ i ] ) )
        {
            scriptable = spawnscriptable( cache_lege[ i ].script_noteworthy, cache_lege[ i ].origin, cache_lege[ i ].angles );
            pickups::registerscriptableinstance( scriptable );
        }
    }
    
    numtospawn = randomintrange( var_f39710f30b56434c, var_55d2ef2053578e5e );
    
    for ( i = 0; i < numtospawn ; i++ )
    {
        if ( isdefined( cache_basic[ i ] ) )
        {
            scriptable = spawnscriptable( cache_basic[ i ].script_noteworthy, cache_basic[ i ].origin, cache_basic[ i ].angles );
            pickups::registerscriptableinstance( scriptable );
        }
    }
    
    foreach ( index, item in var_4717f8260cd3f891 )
    {
        if ( isdefined( item.script_noteworthy ) )
        {
            var_ff8a64bbdcb0a928 = uniquelootitemlookup( item.script_noteworthy );
            count = getitemcount( var_ff8a64bbdcb0a928 );
            adjustedorigin = item.origin;
            adjustedangles = item.angles;
            
            if ( item.script_noteworthy == "uniqueLootItem_1" )
            {
                if ( level.mapname == "mp_bm_bunker01" )
                {
                    switch ( index )
                    {
                        case 0:
                            continue;
                        case 1:
                            adjustedorigin = ( 1969, 639, 68 );
                            adjustedangles = ( 0, 106.6, 75 );
                            break;
                        case 2:
                            adjustedorigin = ( 1962, 665, 68 );
                            adjustedangles = ( 0, 106.6, 75 );
                            break;
                    }
                }
                else if ( game_utility::isdonetskmap() )
                {
                    switch ( index )
                    {
                        case 0:
                            continue;
                        case 1:
                            adjustedorigin = ( -3858, 62596, 573 );
                            adjustedangles = ( 0, 106.6, 75 );
                            break;
                        case 2:
                            adjustedorigin = ( -3850, 62571, 573 );
                            adjustedangles = ( 0, 106.6, 75 );
                            break;
                    }
                }
            }
            
            spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( adjustedorigin, adjustedangles );
            scriptable = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( var_ff8a64bbdcb0a928, count, spawnoptions );
            
            if ( isdefined( scriptable ) )
            {
                scriptable.uniquelootitemid = item.script_noteworthy;
            }
        }
    }
    
    foreach ( item in remainingloot )
    {
        if ( isdefined( item.script_noteworthy ) )
        {
            var_a2df0c82c76f136f = item.script_noteworthy;
            
            if ( item.script_noteworthy == "jugg_minigun" )
            {
                if ( getdvarint( @"hash_7b80600d0cf3b471", 1 ) == 0 )
                {
                    continue;
                }
                
                var_a2df0c82c76f136f = "brloot_weapon_lm_dblmg_lege";
            }
            else if ( item.script_noteworthy == "jugg_minigun_chance" )
            {
                roll = randomintrange( 1, 100 );
                
                if ( roll > getdvarint( @"hash_aab4799a77e73a1d", 25 ) )
                {
                    continue;
                }
                else
                {
                    var_a2df0c82c76f136f = "brloot_weapon_lm_dblmg_lege";
                }
            }
            
            spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( item.origin, item.angles );
            count = getitemcount( var_a2df0c82c76f136f );
            namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( var_a2df0c82c76f136f, count, spawnoptions );
        }
    }
}

// Namespace br_bunker_utility
// Params 1
// Checksum 0x47f02c35, Offset: 0x16c7
// Size: 0x63
function getitemcount( var_a2df0c82c76f136f )
{
    if ( isdefined( level.br_lootiteminfo[ var_a2df0c82c76f136f ] ) )
    {
        return level.br_lootiteminfo[ var_a2df0c82c76f136f ].fullweaponobj.clipsize;
    }
    
    if ( isdefined( level.var_9a6a4b42eba220f6[ var_a2df0c82c76f136f ] ) )
    {
        return level.var_9a6a4b42eba220f6[ var_a2df0c82c76f136f ];
    }
    
    return 1;
}

// Namespace br_bunker_utility
// Params 1
// Checksum 0x2eef9679, Offset: 0x1732
// Size: 0x4c
function uniquelootitemlookup( index )
{
    switch ( index )
    {
        case #"hash_649fa7031bfd7683":
            return "brloot_weapon_bp_reward_sm_mpapa7_lege";
        case #"hash_649fa8031bfd7816":
            return "brloot_weapon_bp_reward_sm_mpapa7_lege";
        default:
            return "brloot_weapon_bp_reward_sm_mpapa7_lege";
    }
}

// Namespace br_bunker_utility
// Params 2
// Checksum 0x5f0ef346, Offset: 0x1786
// Size: 0xad
function getclosestmatchingmasterlootnode( bunkerdoororigin, var_8cfffa654045dbb7 )
{
    var_fff7db898f3b9bdf = utility::getstructarray( var_8cfffa654045dbb7, "targetname" );
    
    if ( isdefined( var_fff7db898f3b9bdf ) )
    {
        if ( var_fff7db898f3b9bdf.size == 1 )
        {
            return var_fff7db898f3b9bdf[ 0 ];
        }
        
        closestnode = undefined;
        closestdist = undefined;
        
        for ( i = 0; i < var_fff7db898f3b9bdf.size ; i++ )
        {
            dist = distance2dsquared( bunkerdoororigin, var_fff7db898f3b9bdf[ i ].origin );
            
            if ( !isdefined( closestdist ) || dist < closestdist )
            {
                closestdist = dist;
                closestnode = var_fff7db898f3b9bdf[ i ];
            }
        }
        
        return closestnode;
    }
}

// Namespace br_bunker_utility
// Params 1
// Checksum 0x8025bea, Offset: 0x183c
// Size: 0x133
function adjustuniqueitemposition( item )
{
    if ( iscloseto( item.angles[ 1 ], 106, 1 ) )
    {
        forward = anglestoforward( item.angles );
        return [ item.origin + forward * 30, ( item.angles[ 0 ], 106, 90 ) ];
    }
    else if ( iscloseto( item.angles[ 1 ], 90, 1 ) )
    {
        forward = anglestoforward( item.angles );
        return [ item.origin - forward * 10, item.angles ];
    }
    else if ( iscloseto( item.angles[ 1 ], 70, 1 ) )
    {
        return [ item.origin, ( item.angles[ 0 ], item.angles[ 1 ], 0 ) ];
    }
    
    return [ item.origin, item.angles ];
}

// Namespace br_bunker_utility
// Params 3
// Checksum 0xdefcbcbd, Offset: 0x1978
// Size: 0x29, Type: bool
function iscloseto( value1, value2, tolerance )
{
    return abs( value1 - value2 ) <= tolerance;
}

// Namespace br_bunker_utility
// Params 0
// Checksum 0x3bfb4174, Offset: 0x19aa
// Size: 0xde
function disablelootbunkercachelocations()
{
    diablecachesaroundorigin( ( -17923, -42192, -252 ) );
    diablecachesaroundorigin( ( -15045, 45467, -186 ) );
    diablecachesaroundorigin( ( 1992, 38955, 1378 ) );
    diablecachesaroundorigin( ( 49764, 34322, 206 ) );
    diablecachesaroundorigin( ( 52510, -32696, -119 ) );
    diablecachesaroundorigin( ( 47158, -10562, 131 ) );
    diablecachesaroundorigin( ( -39282, -2005, -78 ) );
    diablecachesaroundorigin( ( 41919, -41349, -580 ) );
    diablecachesaroundorigin( ( -38426, -19360, 403 ) );
    diablecachesaroundorigin( ( 21085, 16700, 246 ) );
    diablecachesaroundorigin( ( 17893, -34039, -561 ) );
}

// Namespace br_bunker_utility
// Params 0
// Checksum 0x7cf61460, Offset: 0x1a90
// Size: 0x16
function disablebunker11cachelocations()
{
    diablecachesaroundorigin( ( -4337, 62466, 580 ) );
}

// Namespace br_bunker_utility
// Params 1
// Checksum 0x50eb6527, Offset: 0x1aae
// Size: 0xb7
function diablecachesaroundorigin( origin )
{
    caches = getunusedlootcachepoints( origin, 2000, 0, 0 );
    
    foreach ( cacheloc in caches )
    {
        if ( iscloseto( origin[ 2 ], cacheloc.origin[ 2 ], 100 ) )
        {
            disablelootspawnpoint( cacheloc.index );
        }
    }
}

// Namespace br_bunker_utility
// Params 6
// Checksum 0xb8a9d2f2, Offset: 0x1b6d
// Size: 0x48
function keypadscriptableused( instance, part, state, player, bautouse, usestring )
{
    level thread _keypadscriptableused( instance, part, state, player, bautouse );
}

// Namespace br_bunker_utility
// Params 5
// Checksum 0xf0fb1bdf, Offset: 0x1bbd
// Size: 0x8f
function _keypadscriptableused( instance, part, state, player, bautouse )
{
    assert( part == "<dev string:x24>" || part == "<dev string:x43>" || part == "<dev string:x5a>" );
    instance setscriptablepartstate( part, "off" );
    player keypad_playerinteractwithkeypadloop( instance );
    
    if ( isdefined( player ) )
    {
        player br_keypad_util::playersetkeypadstateindex( 0 );
    }
    
    wait 1;
    instance setscriptablepartstate( part, "on" );
}

// Namespace br_bunker_utility
// Params 1
// Checksum 0xd199b57c, Offset: 0x1c54
// Size: 0x239
function keypad_playerinteractwithkeypadloop( instance )
{
    level endon( #"game_ended" );
    self endon( #"keypad_kickplayerfromkeypadmsg" );
    thread function_a189599b7bd1b7f0();
    thread keypad_damagedeathdisconnectwatch( instance );
    thread function_6a6dbaffde604974();
    thread keypad_playeridlewatch();
    thread function_1a9db30014f44d43();
    br_keypad_util::playersetkeypadstateindex( 1 );
    codelength = 8;
    
    if ( isdefined( instance.script_codelength ) )
    {
        codelength = instance.script_codelength;
    }
    
    br_keypad_util::playersetkeypadcodelengthindex( codelength );
    
    while ( isdefined( self ) && br_keypad_util::getkeypadstatefromomnvar() != 0 )
    {
        self waittill( #"luinotifyserver", message, value );
        
        if ( isdefined( message ) )
        {
            if ( message == "submit_br_keypad" )
            {
                if ( getdvarint( @"scr_br_bunker_keypad_refresh_idle_timer_on_try", 1 ) )
                {
                    thread keypad_playeridlewatch();
                }
                
                if ( isdefined( instance.code ) && iscodecorrect( instance, value, codelength ) )
                {
                    br_keypad_util::playersetkeypadstateindex( 2 );
                    self notify( #"hash_ae0075deb97de65d" );
                    instance.codestatus = 2;
                    
                    if ( !instance.var_f026366dba547f4c )
                    {
                        utility::waittill_any_timeout( 2, "luinotifyserver", "damage", "damage_armor" );
                    }
                    
                    if ( isdefined( instance.successfunction ) )
                    {
                        self [[ instance.successfunction ]]( instance );
                    }
                    
                    break;
                }
                else
                {
                    if ( soundexists( "br_keypad_deny" ) )
                    {
                        playsoundatpos( self.origin, "br_keypad_deny" );
                    }
                    
                    instance.codestatus = 3;
                    
                    if ( isdefined( instance.failfunction ) )
                    {
                        self [[ instance.failfunction ]]( instance );
                    }
                    
                    br_keypad_util::playersetkeypadstateindex( 3 );
                    msg = utility::waittill_any_timeout( 2, "luinotifyserver" );
                    
                    if ( isdefined( self ) )
                    {
                        if ( msg == "timeout" )
                        {
                            br_keypad_util::playersetkeypadstateindex( 1 );
                        }
                        else
                        {
                            br_keypad_util::playersetkeypadstateindex( 0 );
                        }
                    }
                }
                
                continue;
            }
            
            if ( message == "exit_br_keypad" )
            {
                instance.codestatus = 3;
                break;
            }
        }
    }
    
    self notify( #"hash_f9f3bfb2358365f1" );
    self notify( #"keypad_kickplayerfromkeypadmsg" );
}

// Namespace br_bunker_utility
// Params 1
// Checksum 0x5567d7c6, Offset: 0x1e95
// Size: 0xaa
function keypad_damagedeathdisconnectwatch( instance )
{
    self endon( #"keypad_kickplayerfromkeypadmsg" );
    self endon( #"hash_ae0075deb97de65d" );
    level endon( #"game_ended" );
    
    if ( isdefined( instance.waittilloverride ) )
    {
        if ( !isarray( instance.waittilloverride ) )
        {
            instance.waittilloverride = [ instance.waittilloverride ];
        }
        
        utility::waittill_any_in_array( instance.waittilloverride );
    }
    else
    {
        utility::waittill_any( "death", "disconnect", "damage", "damage_armor" );
    }
    
    self notify( #"keypad_kickplayerfromkeypadmsg" );
}

// Namespace br_bunker_utility
// Params 0
// Checksum 0x65c0e381, Offset: 0x1f47
// Size: 0x3f
function function_6a6dbaffde604974()
{
    self endon( #"keypad_kickplayerfromkeypadmsg" );
    self endon( #"hash_ae0075deb97de65d" );
    level endon( #"game_ended" );
    self waittill( #"last_stand_enter" );
    self notify( #"keypad_kickplayerfromkeypadmsg" );
}

// Namespace br_bunker_utility
// Params 0
// Checksum 0xb26f26ec, Offset: 0x1f8e
// Size: 0x4e
function keypad_playeridlewatch()
{
    self endon( #"keypad_kickplayerfromkeypadmsg" );
    self endon( #"hash_ae0075deb97de65d" );
    self notify( #"hash_343c9049cac50c34" );
    self endon( #"hash_343c9049cac50c34" );
    wait getdvarint( @"hash_778fef1bd71d5583", 30 );
    self notify( #"keypad_kickplayerfromkeypadmsg" );
}

// Namespace br_bunker_utility
// Params 0
// Checksum 0xb1d26633, Offset: 0x1fe4
// Size: 0x7c
function function_a189599b7bd1b7f0()
{
    self endon( #"keypad_kickplayerfromkeypadmsg" );
    self endon( #"hash_ae0075deb97de65d" );
    level endon( #"game_ended" );
    maxdistancesquared = getdvarint( @"hash_3da3490eb0d776c5", 2000 );
    origin = self.origin;
    
    while ( distance2dsquared( origin, self.origin ) < maxdistancesquared )
    {
        wait 1;
    }
    
    self notify( #"keypad_kickplayerfromkeypadmsg" );
}

// Namespace br_bunker_utility
// Params 0
// Checksum 0xe92579a2, Offset: 0x2068
// Size: 0x48
function function_1a9db30014f44d43()
{
    self endon( #"keypad_kickplayerfromkeypadmsg" );
    self endon( #"hash_ae0075deb97de65d" );
    level endon( #"game_ended" );
    utility::waittill_any( "meatshield_victim_grabbed", "execution_begin_victim", "enter_live_ragdoll" );
    self notify( #"keypad_kickplayerfromkeypadmsg" );
}

// Namespace br_bunker_utility
// Params 3
// Checksum 0x9da74d2, Offset: 0x20b8
// Size: 0xb5
function iscodecorrect( instance, value, codelength )
{
    if ( !isdefined( instance.code[ "string" ] ) )
    {
        return;
    }
    
    if ( isxhash( instance.code[ "string" ] ) )
    {
        for ( value = string( value ); value.size < codelength ; value = "0" + value )
        {
        }
        
        value = getxhash( value );
        var_da30b1e7f250b19f = instance.code[ "string" ];
    }
    else
    {
        var_da30b1e7f250b19f = int( instance.code[ "string" ] );
    }
    
    if ( value == var_da30b1e7f250b19f )
    {
        return 1;
    }
    
    return 0;
}

// Namespace br_bunker_utility
// Params 2
// Checksum 0x39931e94, Offset: 0x2176
// Size: 0x9a
function generatenumbercode_array( codelength, codestruct )
{
    numbers = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ];
    
    for ( i = 0; i < codelength ; i++ )
    {
        numbers = arrayrandomize( numbers );
        codestruct.code[ i ] = numbers[ 0 ];
        numbers = arrayremove( numbers, numbers[ 0 ] );
    }
}

// Namespace br_bunker_utility
// Params 4
// Checksum 0x2f5eeaab, Offset: 0x2218
// Size: 0x32a
function generatenumbercode( codelength, codestruct, var_71fe650fb28de5ec, var_17dc964f53444e27 )
{
    numbers = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ];
    codestruct.code = [];
    
    if ( !isdefined( var_71fe650fb28de5ec ) )
    {
        var_71fe650fb28de5ec = 0;
    }
    else
    {
        codestruct.code[ "doubles" ] = [];
    }
    
    if ( !isdefined( var_17dc964f53444e27 ) )
    {
        var_17dc964f53444e27 = 0;
    }
    else
    {
        codestruct.code[ "triples" ] = [];
    }
    
    var_a66513ea28c35b25 = codelength - var_71fe650fb28de5ec - var_17dc964f53444e27 * 2;
    assert( var_a66513ea28c35b25 > var_71fe650fb28de5ec + var_17dc964f53444e27, "<dev string:x70>" );
    numbers = arrayrandomize( numbers );
    
    for ( i = 0; i < var_a66513ea28c35b25 ; i++ )
    {
        codestruct.code[ "array" ][ i ] = numbers[ i ];
    }
    
    var_84c63112a61e13d2 = codestruct.code[ "array" ];
    
    for ( i = 0; i < var_71fe650fb28de5ec ; i++ )
    {
        var_b300a60c26eec3c6 = var_84c63112a61e13d2[ i ];
        codestruct.code[ "array" ][ codestruct.code[ "array" ].size ] = var_b300a60c26eec3c6;
        codestruct.code[ "doubles" ][ codestruct.code[ "doubles" ].size ] = var_b300a60c26eec3c6;
        var_84c63112a61e13d2 = arrayremove( var_84c63112a61e13d2, var_84c63112a61e13d2[ i ] );
    }
    
    for ( i = 0; i < var_17dc964f53444e27 ; i++ )
    {
        var_324963e21bb7d307 = var_84c63112a61e13d2[ i ];
        
        for ( x = 0; x < 2 ; x++ )
        {
            codestruct.code[ "array" ][ codestruct.code[ "array" ].size ] = var_324963e21bb7d307;
        }
        
        codestruct.code[ "triples" ][ codestruct.code[ "triples" ].size ] = var_324963e21bb7d307;
        var_84c63112a61e13d2 = arrayremove( var_84c63112a61e13d2, var_84c63112a61e13d2[ i ] );
    }
    
    codestruct.code[ "array" ] = arrayrandomize( codestruct.code[ "array" ] );
    codestruct.code[ "string" ] = "";
    
    foreach ( num in codestruct.code[ "array" ] )
    {
        newstring = string( num );
        codestruct.code[ "string" ] = codestruct.code[ "string" ] + newstring;
    }
}

// Namespace br_bunker_utility
// Params 4
// Checksum 0xc80cb31e, Offset: 0x254a
// Size: 0x260
function generatecodestoshow( code, var_5cf50a880c101f22, var_152ee830d62ac9e7, var_8b50a08f3b900b72 )
{
    assert( var_152ee830d62ac9e7 + var_8b50a08f3b900b72 <= 4, "<dev string:xb0>" );
    
    if ( var_152ee830d62ac9e7 > code[ "doubles" ].size )
    {
        var_152ee830d62ac9e7 = 0;
    }
    
    if ( var_8b50a08f3b900b72 > code[ "triples" ].size )
    {
        var_8b50a08f3b900b72 = 0;
    }
    
    var_67d80654dedf2374 = 0;
    var_37a31041cdd01c13 = 0;
    remainingnumbers = arrayremoveduplicates( code[ "array" ] );
    remainingnumbers = arrayrandomize( remainingnumbers );
    var_a7882e80db7923c1 = [];
    
    for ( i = 0; i < var_5cf50a880c101f22 ; i++ )
    {
        if ( var_67d80654dedf2374 < var_152ee830d62ac9e7 )
        {
            var_7b20c3c2aea2d3c9 = code[ "doubles" ][ var_67d80654dedf2374 ];
            var_67d80654dedf2374++;
        }
        else if ( var_37a31041cdd01c13 < var_8b50a08f3b900b72 )
        {
            var_7b20c3c2aea2d3c9 = code[ "triples" ][ var_37a31041cdd01c13 ];
            var_37a31041cdd01c13++;
        }
        else
        {
            var_7b20c3c2aea2d3c9 = remainingnumbers[ 0 ];
        }
        
        var_a7882e80db7923c1[ var_7b20c3c2aea2d3c9 ] = i + 1;
        remainingnumbers = arrayremove( remainingnumbers, var_7b20c3c2aea2d3c9 );
    }
    
    var_1361e7143657396d = [];
    var_691e18e2f63e0a60 = getarraykeys( var_a7882e80db7923c1 );
    
    foreach ( index, num in var_691e18e2f63e0a60 )
    {
        var_1361e7143657396d[ index ] = arraycopy( code[ "array" ] );
        var_2b4bc9426108065c = 0;
        
        foreach ( var_b771989ba1168801, codenum in var_1361e7143657396d[ index ] )
        {
            if ( codenum === num && var_2b4bc9426108065c )
            {
                var_1361e7143657396d[ index ][ var_b771989ba1168801 ] = "symbol" + var_a7882e80db7923c1[ num ];
                continue;
            }
            
            if ( codenum === num && !var_2b4bc9426108065c )
            {
                var_2b4bc9426108065c = 1;
                continue;
            }
            
            if ( arraycontains( var_691e18e2f63e0a60, codenum ) )
            {
                var_1361e7143657396d[ index ][ var_b771989ba1168801 ] = "symbol" + var_a7882e80db7923c1[ codenum ];
            }
        }
    }
    
    return var_1361e7143657396d;
}

// Namespace br_bunker_utility
// Params 2
// Checksum 0xf49e4445, Offset: 0x27b3
// Size: 0xb7
function assigncodecomputersdisplaycodes( computerarray, displaycodes )
{
    if ( !computerarray || !displaycodes )
    {
        return;
    }
    
    computerarray = arrayrandomize( computerarray );
    
    foreach ( i, computer in computerarray )
    {
        if ( i > displaycodes.size )
        {
            i = 0;
        }
        
        computer.scriptable.displaycodeindex = i;
    }
}

// Namespace br_bunker_utility
// Params 2
// Checksum 0xb77e713, Offset: 0x2872
// Size: 0x23
function getcodecomputerdisplaycode( codestruct, displaycodeindex )
{
    return codestruct.displaycodes[ displaycodeindex ];
}

// Namespace br_bunker_utility
// Params 1
// Checksum 0xa56a25b1, Offset: 0x289e
// Size: 0x96
function lockscriptabledoors( scriptable )
{
    if ( isdefined( scriptable.doors ) )
    {
        foreach ( door in scriptable.doors )
        {
            door scriptabledoorfreeze( 1 );
        }
    }
}

// Namespace br_bunker_utility
// Params 1
// Checksum 0xad746fce, Offset: 0x293c
// Size: 0x95
function unlockscriptabledoors( scriptable )
{
    if ( isdefined( scriptable.doors ) )
    {
        foreach ( door in scriptable.doors )
        {
            door scriptabledoorfreeze( 0 );
        }
    }
}

// Namespace br_bunker_utility
// Params 2
// Checksum 0x1ab6ad17, Offset: 0x29d9
// Size: 0xaf
function openscriptabledoors( scriptable, var_3216f5870364461 )
{
    foreach ( door in scriptable.doors )
    {
        door scriptabledooropen( "away", scriptable.origin );
    }
    
    if ( var_3216f5870364461 )
    {
        wait 1;
        lockscriptabledoors( scriptable );
    }
}

// Namespace br_bunker_utility
// Params 3
// Checksum 0x82ea5d53, Offset: 0x2a90
// Size: 0xb4
function closescriptabledoors( scriptable, var_3216f5870364461, notificationsuffix = "" )
{
    thread function_54c1fe92d7a84e5d( scriptable, var_3216f5870364461, notificationsuffix );
    
    foreach ( door in scriptable.doors )
    {
        door thread closescriptabledoor( door, var_3216f5870364461, notificationsuffix );
    }
}

// Namespace br_bunker_utility
// Params 3
// Checksum 0x6c5e041e, Offset: 0x2b4c
// Size: 0xde
function function_54c1fe92d7a84e5d( scriptable, var_3216f5870364461, notificationsuffix = "" )
{
    level endon( #"game_ended" );
    level endon( "closing_door_canceled" + notificationsuffix );
    wait 1;
    level notify( "closing_door_timeout" + notificationsuffix );
    
    if ( var_3216f5870364461 )
    {
        foreach ( door in scriptable.doors )
        {
            if ( !door scriptabledoorisclosed() )
            {
                closescriptabledoors( scriptable, var_3216f5870364461, notificationsuffix );
                break;
            }
        }
    }
}

// Namespace br_bunker_utility
// Params 3
// Checksum 0x76821e78, Offset: 0x2c32
// Size: 0x6f
function closescriptabledoor( door, var_3216f5870364461, notificationsuffix = "" )
{
    level endon( #"game_ended" );
    level endon( "closing_door_timeout" + notificationsuffix );
    level endon( "closing_door_canceled" + notificationsuffix );
    door scriptabledoorclose();
    
    if ( var_3216f5870364461 )
    {
        while ( !door scriptabledoorisclosed() )
        {
            waitframe();
        }
        
        door scriptabledoorfreeze( 1 );
    }
}

