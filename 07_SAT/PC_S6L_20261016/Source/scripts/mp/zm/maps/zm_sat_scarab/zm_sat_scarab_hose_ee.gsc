// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_hose_ee.gsc  (hash_0a3b4c41843af3da.gscc) (size: 14937 Bytes / 0x3a59 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe24e4b28 (3796781864)
// size ...... 14937 (0x3a59)
// includes .. 14  (offset: 0x3701)
// strings ... 44  (offset: 0x3771)
// dev strs .. 7   (offset: 0x3a05)
// exports ... 19  (offset: 0x26ed)
// cseg ...... 0x394 + 0x2359 (0x26ed)
// imports ... 106 (offset: 0x29e5)
// animtree1 . 0   (offset: 0x3a59)
// animtree2 . 0   (offset: 0x3a59)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\player_banter;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_rb;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_scarab_hose_ee;

// Namespace zm_sat_scarab_hose_ee
// Params 0, eflags: 0x5
// Checksum 0x50347302, Offset: 0x3b2
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_f766d26998febd75", undefined, undefined, &init );
}

// Namespace zm_sat_scarab_hose_ee
// Params 0
// Checksum 0x62b4864, Offset: 0x3d3
// Size: 0x374
function init()
{
    level endon( #"game_ended" );
    level utility::flag_wait_all( "zm_quest_initialized", "scriptables_ready" );
    
    if ( !getdvarint( @"hash_1339f37dad46cdfd", 0 ) )
    {
        return;
    }
    
    level.var_2b6982932b3afba3 = zm_quest::get_quest( #"hash_cf9b2fa99529bc3c" );
    level.var_2b6982932b3afba3.var_4cd01941158e784c = [];
    level.var_2b6982932b3afba3.e_painting = getent( "hose_p", #targetname );
    level.var_2b6982932b3afba3.e_painting thread function_1cae5fee0c4d1536();
    level.var_2b6982932b3afba3.e_painting.rotatetag = utility::spawn_tag_origin( level.var_2b6982932b3afba3.e_painting.origin + ( 0, 0, 28 ), level.var_2b6982932b3afba3.e_painting.angles );
    level.var_2b6982932b3afba3.e_painting.rotatetag show();
    level.var_2b6982932b3afba3.e_painting linkto( level.var_2b6982932b3afba3.e_painting.rotatetag );
    level.var_2b6982932b3afba3.e_painting.var_e7b887eec9312fb6 = getent( "hose_t", #targetname );
    
    if ( level.var_2b6982932b3afba3.e_painting.var_e7b887eec9312fb6 )
    {
        level.var_2b6982932b3afba3.e_painting.var_e7b887eec9312fb6 setcandamage( 0 );
    }
    
    level.var_2b6982932b3afba3.s_reward_struct = utility::getstruct( "hose_r", "targetname" );
    level.var_2b6982932b3afba3.s_reward_struct.soundsbl = spawnscriptable( "sat_zm_quest_scarab_hose_ee_sound", level.var_2b6982932b3afba3.s_reward_struct.origin, level.var_2b6982932b3afba3.s_reward_struct.angles );
    level utility::add_fx( "hose_shared_fx", "vfx_t10_gameplay_zm_powerup_glow_green" );
    level utility::add_fx( "hose_fx_float", "vfx_sat_levels_zm_scarab_super_ee_reward" );
    level.var_2b6982932b3afba3.var_6ed4a862674683dd = [ undefined, #"1", #"2", #"3", #"4" ].size - 1;
    level callback::add( "on_round_start", &function_6817cea94108c4f7 );
    level callback::add( "zone_changed", &function_df076a29f68b34b9 );
    level zm_quest::register_quest_step( #"hash_cf9b2fa99529bc3c", #"hash_678a7bd241731417", &function_7afd3f4509fbee16, &function_66dbc6276a8307f3 );
    level zm_save::function_1f44a48caae2acbf();
    var_5303d71c1189452 = level zm_quest::function_73720cdf21c3cfd7( #"hash_cf9b2fa99529bc3c", #"hash_70bfa3b8a6ae4da0" );
    
    if ( var_5303d71c1189452 )
    {
        level utility::flag_set( "c_sat_zmb_scarab_hose_ee_mask_mask_redeemed" );
    }
    
    level thread zm_quest::start_quest( #"hash_cf9b2fa99529bc3c" );
    
    /#
        level thread function_481db36d29ca48bf();
    #/
}

// Namespace zm_sat_scarab_hose_ee
// Params 0, eflags: 0x4
// Checksum 0x218fc73f, Offset: 0x74f
// Size: 0x3f1
function private function_1cae5fee0c4d1536()
{
    level endon( #"game_ended" );
    level.var_2b6982932b3afba3.e_painting.health = 100000;
    level.var_2b6982932b3afba3.e_painting setcandamage( 1 );
    var_f48780e24e9d11d1 = 0;
    
    do
    {
        level.var_2b6982932b3afba3.e_painting waittill( #"damage", idamage, eattacker, vdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon, origin, angles, normal, einflictor, eventid );
        level.var_2b6982932b3afba3.e_painting.health = 100000;
        
        if ( level.var_2b6982932b3afba3.e_painting utility::ent_flag( "is_closing" ) || level.var_2b6982932b3afba3.e_painting utility::ent_flag( "is_opening" ) )
        {
            continue;
        }
        
        if ( !isplayer( eattacker ) )
        {
            continue;
        }
        
        if ( smeansofdeath != "MOD_MELEE" )
        {
            continue;
        }
        
        var_a4eaa7ae35cd12f4 = 0;
        rewardstruct = level.var_2b6982932b3afba3.var_4cd01941158e784c[ eattacker getentitynumber() ][ 2 ];
        
        if ( rewardstruct.rewardtier >= [ undefined, #"1", #"2", #"3", #"4" ].size - 1 && !level utility::flag( "c_sat_zmb_scarab_hose_ee_mask_mask_redeemed" ) )
        {
            var_a4eaa7ae35cd12f4 = 1;
        }
        else if ( rewardstruct && !level.var_2b6982932b3afba3.e_painting utility::ent_flag( "is_open" ) )
        {
            if ( !isdefined( level.var_2b6982932b3afba3.var_4cd01941158e784c[ eattacker getentitynumber() ][ 3 ] ) )
            {
                level.var_2b6982932b3afba3.var_4cd01941158e784c[ eattacker getentitynumber() ][ 3 ] = 0;
            }
            
            if ( rewardstruct.rewardtier == var_f48780e24e9d11d1 )
            {
                level.var_2b6982932b3afba3.var_4cd01941158e784c[ eattacker getentitynumber() ][ 3 ]++;
            }
            else
            {
                level.var_2b6982932b3afba3.var_4cd01941158e784c[ eattacker getentitynumber() ][ 3 ] = 0;
            }
            
            if ( level.var_2b6982932b3afba3.var_4cd01941158e784c[ eattacker getentitynumber() ][ 3 ] >= 3 )
            {
                level thread function_6817cea94108c4f7( { #roundnumber:zm_utility::get_round_number() } );
            }
        }
        
        var_f48780e24e9d11d1 = rewardstruct.rewardtier;
        
        if ( level.var_2b6982932b3afba3.e_painting utility::ent_flag( "is_open" ) )
        {
            if ( eattacker utility::ent_flag( "perk_m_mod_active" ) )
            {
                playereyepos = eattacker geteye();
                endtracepos = playereyepos + anglestoforward( eattacker getplayerangles() ) * 10000;
                a_trace = trace::ray_trace_ents( playereyepos, endtracepos, level.var_2b6982932b3afba3.e_painting, undefined, undefined, undefined, 1 );
                
                if ( a_trace[ "hittype" ] != "hittype_entity" )
                {
                    continue;
                }
            }
            
            level thread close_painting( var_a4eaa7ae35cd12f4 );
            continue;
        }
        
        level.var_2b6982932b3afba3.e_painting thread function_f9fcd6557ea18dab( eattacker, var_a4eaa7ae35cd12f4 );
    }
    while ( true );
}

// Namespace zm_sat_scarab_hose_ee
// Params 2, eflags: 0x4
// Checksum 0x21b12be5, Offset: 0xb48
// Size: 0x26b
function private function_7afd3f4509fbee16( b_skipped, b_save_restored )
{
    foreach ( player in level.players )
    {
        if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player ) )
        {
            return;
        }
        
        navmeshpos = getclosestpointonnavmesh( player.origin );
        zone = zone_manager::function_90e5c3e2272b0130( navmeshpos );
        
        if ( !zm_sat_scarab_rb::function_95af7a773f7c57d1( zone.zone_name ) )
        {
            return;
        }
        
        var_28a0c73aa8cdb408 = level zm_quest::function_73720cdf21c3cfd7( #"hash_cf9b2fa99529bc3c", #"hash_8a35ae9dc24d329d" ) ?? zm_utility::get_round_number();
        level.var_2b6982932b3afba3.var_4cd01941158e784c[ player getentitynumber() ][ 1 ] = var_28a0c73aa8cdb408;
    }
    
    level utility::flag_wait( "init_pu_ee_models" );
    var_7d1749d76868cceb = utility::getstructarray( "pu_ee_spawn", "targetname" );
    
    foreach ( s_spawn in var_7d1749d76868cceb )
    {
        if ( s_spawn.script_noteworthy != "full_ammo" )
        {
            continue;
        }
        
        scriptable = s_spawn.scriptable;
        
        if ( !scriptable.origin )
        {
            continue;
        }
        
        if ( distancesquared( scriptable.origin, level.var_2b6982932b3afba3.e_painting.origin ) > squared( 300 ) )
        {
            continue;
        }
        
        if ( !isdefined( scriptable.var_d3160b7951e076d5 ) )
        {
            scriptable.var_d3160b7951e076d5 = [];
        }
        
        scriptable.var_d3160b7951e076d5[ scriptable.var_d3160b7951e076d5.size ] = &function_92a18c94f3757d52;
    }
    
    level waittill( #"never" );
}

// Namespace zm_sat_scarab_hose_ee
// Params 11, eflags: 0x4
// Checksum 0x52cce328, Offset: 0xdbb
// Size: 0x8e, Type: bool
function private function_92a18c94f3757d52( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( smeansofdeath == "MOD_MELEE" && isplayer( eattacker ) && instance getscriptablehaspart( "powerup_ee_model" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_scarab_hose_ee
// Params 1, eflags: 0x4
// Checksum 0x8a3b8074, Offset: 0xe52
// Size: 0x11a
function private function_df076a29f68b34b9( sparams )
{
    if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( self ) )
    {
        return;
    }
    
    if ( utility::ent_flag( "dance_ee_returning_to_safehouse" ) )
    {
        return;
    }
    
    previous_zone_struct = sparams.previous_zone_struct;
    new_zone_struct = sparams.zone_struct;
    
    if ( !zm_sat_scarab_rb::function_95af7a773f7c57d1( new_zone_struct.zone_name ) )
    {
        level.var_2b6982932b3afba3.var_4cd01941158e784c[ self getentitynumber() ] = undefined;
        level zm_quest::function_6265be8d0549e1b1( #"hash_cf9b2fa99529bc3c", #"hash_8a35ae9dc24d329d" );
        return;
    }
    
    if ( !zm_sat_scarab_rb::function_95af7a773f7c57d1( previous_zone_struct.zone_name ) )
    {
        var_28a0c73aa8cdb408 = level zm_quest::function_73720cdf21c3cfd7( #"hash_cf9b2fa99529bc3c", #"hash_8a35ae9dc24d329d" ) ?? zm_utility::get_round_number();
        level.var_2b6982932b3afba3.var_4cd01941158e784c[ self getentitynumber() ][ 1 ] = var_28a0c73aa8cdb408;
        level zm_quest::function_4eefe6de31f5ddab( #"hash_cf9b2fa99529bc3c", #"hash_8a35ae9dc24d329d", var_28a0c73aa8cdb408 );
    }
}

// Namespace zm_sat_scarab_hose_ee
// Params 1, eflags: 0x4
// Checksum 0x2cb27a1b, Offset: 0xf74
// Size: 0x2d5
function private function_6817cea94108c4f7( sparams )
{
    roundnumber = sparams.roundnumber;
    level.var_2b6982932b3afba3.var_6fcefdda23136b8e = 0;
    
    foreach ( player in level.players )
    {
        if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player ) )
        {
            continue;
        }
        
        if ( !level.var_2b6982932b3afba3.var_4cd01941158e784c[ player getentitynumber() ] )
        {
            continue;
        }
        
        if ( roundnumber < 5 )
        {
            continue;
        }
        
        var_b0359416dc7807d7 = max( level.var_2b6982932b3afba3.var_4cd01941158e784c[ player getentitynumber() ][ 1 ], 3 );
        roundspassed = roundnumber - var_b0359416dc7807d7;
        rewardtier = int( roundspassed / 2 );
        rewardtier = clamp( rewardtier, 0, [ undefined, #"1", #"2", #"3", #"4" ].size - 1 );
        
        if ( rewardtier < 1 || !rewardtier )
        {
            continue;
        }
        
        level.var_2b6982932b3afba3.var_6fcefdda23136b8e = max( level.var_2b6982932b3afba3.var_6fcefdda23136b8e, rewardtier );
        rerolltracker = level.var_2b6982932b3afba3.var_4cd01941158e784c[ player getentitynumber() ][ 3 ] ?? 0;
        var_d81c51556ec99a50 = level.var_2b6982932b3afba3.var_4cd01941158e784c[ player getentitynumber() ][ 2 ].rewardtier;
        
        if ( var_d81c51556ec99a50 >= rewardtier && rerolltracker < 3 )
        {
            continue;
        }
        
        level.var_2b6982932b3afba3.var_4cd01941158e784c[ player getentitynumber() ][ 3 ] = 0;
        var_a2df0c82c76f136f = get_reward_item( rewardtier );
        spawnoptions = get_spawn_options( var_a2df0c82c76f136f );
        level.var_2b6982932b3afba3.var_4cd01941158e784c[ player getentitynumber() ][ 2 ] = { #spawnoptions:spawnoptions, #var_a2df0c82c76f136f:var_a2df0c82c76f136f, #rewardtier:rewardtier };
        level.var_2b6982932b3afba3.s_reward_struct.soundsbl utility::function_32b24db3127bff40( "sfx", "loop" );
    }
}

// Namespace zm_sat_scarab_hose_ee
// Params 1
// Checksum 0x1a0ea31c, Offset: 0x1251
// Size: 0x78
function get_reward_item( rewardtier )
{
    if ( !isdefined( var_8b5270de14dff72e ) )
    {
        var_8b5270de14dff72e = zm_round_reward_bundle::function_8cbad2bff5b7cc1( %"hash_6cf7e4f22e034174", [ undefined, #"1", #"2", #"3", #"4" ][ rewardtier ] );
    }
    
    var_a2df0c82c76f136f = var_8b5270de14dff72e[ 0 ];
    return var_a2df0c82c76f136f;
}

// Namespace zm_sat_scarab_hose_ee
// Params 2
// Checksum 0xdfb786e3, Offset: 0x12d2
// Size: 0x96
function get_spawn_options( var_a2df0c82c76f136f, var_94266d263cb07c7e = 0 )
{
    spawnoffsets = function_207960beac5b1f9e( var_a2df0c82c76f136f, var_94266d263cb07c7e );
    spawnoptions = common_item::function_bc5ff2958b71a708( spawnoffsets.var_a8c6af7cb9b2202c, spawnoffsets.var_2eca63365db8f6e6 );
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.fxoriginoffset = spawnoffsets.fxoriginoffset;
    spawnoptions.var_8bd38228b6eddec7 = spawnoffsets.var_8bd38228b6eddec7;
    return spawnoptions;
}

// Namespace zm_sat_scarab_hose_ee
// Params 2, eflags: 0x4
// Checksum 0x1c58403a, Offset: 0x1371
// Size: 0x2a1
function private function_207960beac5b1f9e( var_a2df0c82c76f136f, var_94266d263cb07c7e = 0 )
{
    itembundle = undefined;
    itemtype = undefined;
    
    if ( !var_94266d263cb07c7e )
    {
        itembundle = getscriptbundle( var_a2df0c82c76f136f );
        itemtype = common_item::function_16e8c106491eeaca( itembundle );
    }
    
    var_a8c6af7cb9b2202c = level.var_2b6982932b3afba3.s_reward_struct.origin;
    var_2eca63365db8f6e6 = level.var_2b6982932b3afba3.s_reward_struct.angles;
    fxoriginoffset = undefined;
    var_8bd38228b6eddec7 = 0;
    
    if ( itemtype == "weapon" )
    {
        var_a8c6af7cb9b2202c += ( 4, 4, 6 );
        var_2eca63365db8f6e6 += ( -10, -90, 5 );
        fxoriginoffset = anglestoup( var_2eca63365db8f6e6 ) * 1;
        fxoriginoffset += anglestoforward( var_2eca63365db8f6e6 ) * 6;
    }
    else if ( itemtype == "revive" )
    {
        var_a8c6af7cb9b2202c += ( 0, 0, 10 );
        var_2eca63365db8f6e6 += ( -90, 0, 0 );
    }
    else if ( itemtype == "perk" )
    {
        var_a8c6af7cb9b2202c += ( 0, 0, 5 );
        var_2eca63365db8f6e6 += ( -10, 175, 5 );
    }
    else if ( itembundle.subtype == "aethertool" )
    {
        var_a8c6af7cb9b2202c += ( 0, 0, -4 );
        var_2eca63365db8f6e6 += ( 0, 90, 5 );
    }
    else if ( itemtype == "ammo" )
    {
        var_a8c6af7cb9b2202c += ( 0, 0, 6 );
    }
    else if ( itembundle.ref == "t10_aethercrystal2" || itembundle.ref == "t10_aethercrystal3" )
    {
        var_a8c6af7cb9b2202c += ( -4, 0, 12.15 );
        var_8bd38228b6eddec7 = 1;
    }
    else if ( itembundle.ref == "zm_dinj" )
    {
        var_a8c6af7cb9b2202c += ( 0, 0, 7 );
    }
    else if ( var_94266d263cb07c7e )
    {
        var_a8c6af7cb9b2202c += ( -4, 0, 40 ) + anglestoforward( level.var_2b6982932b3afba3.s_reward_struct.angles ) * 8;
        var_2eca63365db8f6e6 += ( 0, 90, 5 );
    }
    
    return { #var_8bd38228b6eddec7:var_8bd38228b6eddec7, #fxoriginoffset:fxoriginoffset, #var_2eca63365db8f6e6:var_2eca63365db8f6e6, #var_a8c6af7cb9b2202c:var_a8c6af7cb9b2202c };
}

// Namespace zm_sat_scarab_hose_ee
// Params 2, eflags: 0x4
// Checksum 0x16f954c3, Offset: 0x161b
// Size: 0x37f
function private function_f9fcd6557ea18dab( player, var_a4eaa7ae35cd12f4 = 0 )
{
    level endon( #"game_ended" );
    level.var_2b6982932b3afba3.e_painting endon( #"painting_closed" );
    
    if ( isdefined( player ) && player.interactions_disabled || !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player ) )
    {
        return;
    }
    
    if ( level.var_2b6982932b3afba3.e_painting utility::ent_flag( "is_closing" ) )
    {
        return;
    }
    
    if ( level.var_2b6982932b3afba3.e_painting utility::ent_flag( "is_open" ) )
    {
        return;
    }
    
    level.var_2b6982932b3afba3.e_painting utility::ent_flag_set( "is_open" );
    level.var_2b6982932b3afba3.e_painting utility::ent_flag_set( "is_opening" );
    
    if ( !isdefined( level.var_2b6982932b3afba3.var_e2372bf8baa9b078 ) )
    {
        level.var_2b6982932b3afba3.var_e2372bf8baa9b078 = [];
    }
    
    if ( !level.var_2b6982932b3afba3.var_723ffd063b6b8807 )
    {
        level.var_2b6982932b3afba3.var_723ffd063b6b8807 = 1;
        level thread namespace_f1b889ff795b541c::play_banter_vo( #"hash_e97d47e9bace091a", [ player ] );
    }
    
    rewardstruct = level.var_2b6982932b3afba3.var_4cd01941158e784c[ player getentitynumber() ][ 2 ];
    
    if ( rewardstruct )
    {
        if ( var_a4eaa7ae35cd12f4 )
        {
            var_a2df0c82c76f136f = get_reward_item( 4 );
            spawnoptions = get_spawn_options( var_a2df0c82c76f136f, 1 );
            spawneditem = common_item::function_61c2c0251e742ffd( var_a2df0c82c76f136f, undefined, spawnoptions );
            playsoundatpos( level.var_2b6982932b3afba3.s_reward_struct.soundsbl.origin, "evt_ee_complete_success_stinger" );
            spawneditem.var_94266d263cb07c7e = 1;
            spawneditem.var_54fed9d34b23024c = 0;
            fxoriginoffset = spawnoptions.fxoriginoffset;
        }
        else
        {
            spawneditem = common_item::function_61c2c0251e742ffd( rewardstruct.var_a2df0c82c76f136f, undefined, rewardstruct.spawnoptions );
            fxoriginoffset = rewardstruct.spawnoptions.fxoriginoffset;
            spawneditem.var_8bd38228b6eddec7 = rewardstruct.spawnoptions.var_8bd38228b6eddec7;
        }
        
        level.var_2b6982932b3afba3.var_e2372bf8baa9b078 = arraycombineunique( level.var_2b6982932b3afba3.var_e2372bf8baa9b078, [ spawneditem ] );
        spawneditem thread function_91837b2c3f32a056( player, var_a4eaa7ae35cd12f4, fxoriginoffset );
    }
    
    level.var_2b6982932b3afba3.e_painting.rotatetag rotateby( ( 0, 0, -65 ), 0.75, 0.6, 0.15 );
    level.var_2b6982932b3afba3.e_painting playsound( "evt_scarab_painting_open" );
    level.var_2b6982932b3afba3.e_painting utility::function_a9cdce367aa4fef5( "painting_close_uid", 10, [ "painting_closing", "painting_closed" ], &close_painting, var_a4eaa7ae35cd12f4 );
    wait 0.75;
    level.var_2b6982932b3afba3.e_painting utility::ent_flag_clear( "is_opening" );
}

// Namespace zm_sat_scarab_hose_ee
// Params 3, eflags: 0x4
// Checksum 0x7f0c4801, Offset: 0x19a2
// Size: 0x48e
function private function_91837b2c3f32a056( player, var_94266d263cb07c7e = 0, fxoriginoffset )
{
    level endon( #"game_ended" );
    level.var_2b6982932b3afba3.e_painting endon( #"painting_closed" );
    var_a36109cfe0380749 = self.origin;
    var_af9c373e57bc48d7 = self.angles;
    fxangles = level.var_2b6982932b3afba3.s_reward_struct.angles;
    self.var_8b185b8b9d102c9e = utility::spawn_tag_origin( var_a36109cfe0380749, fxangles );
    self.var_8b185b8b9d102c9e show();
    thread utility::delete_on_death( self.var_8b185b8b9d102c9e );
    var_1ffe676c20f1ab14 = rotatevectorinverted( var_a36109cfe0380749 - self.var_8b185b8b9d102c9e.origin, self.var_8b185b8b9d102c9e.angles );
    
    if ( fxoriginoffset )
    {
        var_1ffe676c20f1ab14 += fxoriginoffset;
    }
    
    var_fd2c51be9a30310e = combineanglesinverted( self.var_8b185b8b9d102c9e.angles, var_af9c373e57bc48d7 );
    
    if ( isent( self ) )
    {
        self linkto( self.var_8b185b8b9d102c9e, "tag_origin", var_1ffe676c20f1ab14, var_fd2c51be9a30310e );
    }
    else
    {
        utility::scriptable_setparententity( self.var_8b185b8b9d102c9e, var_1ffe676c20f1ab14, var_fd2c51be9a30310e );
    }
    
    playfxontag( utility::getfx( "hose_fx_float" ), self.var_8b185b8b9d102c9e, "tag_origin" );
    
    if ( var_94266d263cb07c7e )
    {
        foreach ( player_in_match in level.players )
        {
            if ( player_in_match == player )
            {
                continue;
            }
            
            self disablescriptableplayeruse( player_in_match );
        }
        
        var_90029e1a8839ea9c = self.var_8b185b8b9d102c9e.origin + ( 0, 0, -42 );
        self.var_8b185b8b9d102c9e moveto( var_90029e1a8839ea9c, 0.75 );
        wait 0.75;
        self.var_54fed9d34b23024c = 1;
    }
    else
    {
        thread function_d76273b09dea1897( player );
    }
    
    self.var_8b185b8b9d102c9e function_616378d7e5b22efb( anglestoup( fxangles ), 2, 5, 5 );
    self.var_35de80c7b58c9a95 = 1;
    self waittill( #"death" );
    stopfxontag( utility::getfx( "hose_fx_float" ), self.var_8b185b8b9d102c9e, "tag_origin" );
    
    if ( self.var_f8919af0abdb8361 )
    {
        stopfxontag( utility::getfx( "hose_shared_fx" ), self.var_f8919af0abdb8361, "tag_origin" );
    }
    
    level.var_2b6982932b3afba3.var_e2372bf8baa9b078 = arrayremove( level.var_2b6982932b3afba3.var_e2372bf8baa9b078, self );
    
    if ( self.pickedup )
    {
        level.var_2b6982932b3afba3.var_4cd01941158e784c[ player getentitynumber() ][ 1 ] = zm_utility::get_round_number();
        level.var_2b6982932b3afba3.var_4cd01941158e784c[ player getentitynumber() ][ 2 ] = undefined;
        level zm_quest::function_6265be8d0549e1b1( #"hash_cf9b2fa99529bc3c", #"hash_8a35ae9dc24d329d" );
        
        if ( var_94266d263cb07c7e )
        {
            level utility::flag_set( "c_sat_zmb_scarab_hose_ee_mask_mask_redeemed" );
            level zm_quest::function_4eefe6de31f5ddab( #"hash_cf9b2fa99529bc3c", #"hash_70bfa3b8a6ae4da0", 1 );
        }
    }
    
    if ( level.var_2b6982932b3afba3.var_e2372bf8baa9b078.size < 1 )
    {
        var_49718a47ac4b6e86 = function_bed4b3a4e4fa0d4();
        
        if ( level.var_2b6982932b3afba3.s_reward_struct.soundsbl utility::function_9f2c41c1dcc8c94( "sfx", "loop" ) && var_49718a47ac4b6e86 < 1 )
        {
            level.var_2b6982932b3afba3.s_reward_struct.soundsbl utility::function_32b24db3127bff40( "sfx", "off" );
        }
        
        level.var_2b6982932b3afba3.e_painting utility::function_a9cdce367aa4fef5( "painting_close_uid", 1.5, [ "painting_closing", "painting_closed" ], &close_painting, var_94266d263cb07c7e );
    }
    
    if ( self )
    {
        if ( isent( self ) )
        {
            self delete();
            return;
        }
        
        self freescriptable();
    }
}

// Namespace zm_sat_scarab_hose_ee
// Params 1, eflags: 0x4
// Checksum 0x5a44fae8, Offset: 0x1e38
// Size: 0x3b1
function private function_d76273b09dea1897( owner )
{
    level endon( #"game_ended" );
    level.var_2b6982932b3afba3.e_painting endon( #"painting_closed" );
    self endon( #"death" );
    owner endon( #"death_or_disconnect" );
    
    foreach ( player_in_match in level.players )
    {
        self disablescriptableplayeruse( player_in_match );
    }
    
    wait 0.75;
    
    foreach ( player_in_match in level.players )
    {
        if ( player_in_match == owner )
        {
            self enablescriptableplayeruse( player_in_match );
            continue;
        }
        
        self disablescriptableplayeruse( player_in_match );
    }
    
    level.var_2b6982932b3afba3.e_painting.var_e7b887eec9312fb6.health = 100000;
    level.var_2b6982932b3afba3.e_painting.var_e7b887eec9312fb6 setcandamage( 1 );
    
    do
    {
        level.var_2b6982932b3afba3.e_painting.var_e7b887eec9312fb6 waittill( #"damage", idamage, eattacker, vdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon, origin, angles, normal, einflictor, eventid );
    }
    while ( smeansofdeath != "MOD_MELEE" || eattacker != owner );
    
    level.var_2b6982932b3afba3.e_painting.var_e7b887eec9312fb6 setcandamage( 0 );
    stopfxontag( utility::getfx( "hose_fx_float" ), self.var_8b185b8b9d102c9e, "tag_origin" );
    self.var_f8919af0abdb8361 = utility::spawn_tag_origin( self.origin, level.var_2b6982932b3afba3.s_reward_struct.angles );
    self.var_f8919af0abdb8361 show();
    thread utility::delete_on_death( self.var_f8919af0abdb8361 );
    self.var_f8919af0abdb8361 linkto( self.var_8b185b8b9d102c9e );
    playfxontag( utility::getfx( "hose_shared_fx" ), self.var_f8919af0abdb8361, "tag_origin" );
    
    foreach ( player_in_match in level.players )
    {
        if ( player_in_match == owner )
        {
            continue;
        }
        
        self enablescriptableplayeruse( player_in_match );
    }
}

// Namespace zm_sat_scarab_hose_ee
// Params 0, eflags: 0x4
// Checksum 0x71cc1663, Offset: 0x21f1
// Size: 0xb1
function private function_bed4b3a4e4fa0d4()
{
    var_49718a47ac4b6e86 = 0;
    
    foreach ( player in level.players )
    {
        if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player ) )
        {
            continue;
        }
        
        if ( level.var_2b6982932b3afba3.var_4cd01941158e784c[ player getentitynumber() ][ 2 ] )
        {
            var_49718a47ac4b6e86++;
        }
    }
    
    return var_49718a47ac4b6e86;
}

// Namespace zm_sat_scarab_hose_ee
// Params 1, eflags: 0x4
// Checksum 0xce419f7, Offset: 0x22ab
// Size: 0x29c
function private close_painting( var_94266d263cb07c7e )
{
    if ( !level.var_2b6982932b3afba3.e_painting utility::ent_flag( "is_open" ) || level.var_2b6982932b3afba3.e_painting utility::ent_flag( "is_opening" ) || level.var_2b6982932b3afba3.e_painting utility::ent_flag( "is_closing" ) )
    {
        return;
    }
    
    level.var_2b6982932b3afba3.e_painting utility::ent_flag_set( "is_closing" );
    level.var_2b6982932b3afba3.e_painting.rotatetag rotateby( ( 0, 0, 65 ), 0.75, 0.6, 0.15 );
    level.var_2b6982932b3afba3.e_painting playsound( "evt_scarab_painting_close" );
    level.var_2b6982932b3afba3.e_painting utility::ent_flag_clear( "is_open" );
    level.var_2b6982932b3afba3.e_painting notify( #"painting_closing" );
    
    if ( !var_94266d263cb07c7e )
    {
        wait 0.75;
    }
    
    foreach ( spawneditem in level.var_2b6982932b3afba3.var_e2372bf8baa9b078 )
    {
        if ( spawneditem.var_94266d263cb07c7e || spawneditem.var_8bd38228b6eddec7 )
        {
            var_2e5a0a5ffebde714 = spawneditem.var_8b185b8b9d102c9e.origin + anglestoforward( level.var_2b6982932b3afba3.s_reward_struct.angles ) * 8 * -1;
            spawneditem.var_8b185b8b9d102c9e moveto( var_2e5a0a5ffebde714, 1 );
            wait 1;
        }
        
        if ( spawneditem )
        {
            if ( isent( spawneditem ) )
            {
                spawneditem delete();
                continue;
            }
            
            spawneditem freescriptable();
        }
    }
    
    level.var_2b6982932b3afba3.var_e2372bf8baa9b078 = [];
    level.var_2b6982932b3afba3.e_painting utility::ent_flag_clear( "is_closing" );
    level.var_2b6982932b3afba3.e_painting notify( #"painting_closed" );
}

// Namespace zm_sat_scarab_hose_ee
// Params 2, eflags: 0x4
// Checksum 0x1cbcb1d8, Offset: 0x254f
// Size: 0x15
function private function_66dbc6276a8307f3( b_skipped, b_save_restored )
{
    
}

/#

    // Namespace zm_sat_scarab_hose_ee
    // Params 0
    // Checksum 0xcab4d27e, Offset: 0x256c
    // Size: 0x5e, Type: dev
    function function_481db36d29ca48bf()
    {
        zm_quest::function_bc99f123a684344f( #"hash_cf9b2fa99529bc3c" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x24>", "<dev string:x36>", &set_reward_tier );
        devgui::function_cd4e263c1f3018ae( "<dev string:x48>", "<dev string:x5a>", &set_reward_tier );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6c>", "<dev string:x7e>", &set_reward_tier );
        zm_quest::function_394bdba74beda0aa();
    }

    // Namespace zm_sat_scarab_hose_ee
    // Params 1, eflags: 0x4
    // Checksum 0x98ba48b5, Offset: 0x25d2
    // Size: 0x11b, Type: dev
    function private set_reward_tier( sparams )
    {
        rewardtier = int( sparams[ 0 ] ?? 0 );
        
        foreach ( player in level.players )
        {
            if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player ) )
            {
                continue;
            }
            
            var_a2df0c82c76f136f = get_reward_item( rewardtier );
            
            /#
                iprintlnbold( "<dev string:x90>" + getxhashsourcename( var_a2df0c82c76f136f ) );
            #/
            
            spawnoptions = get_spawn_options( var_a2df0c82c76f136f );
            level.var_2b6982932b3afba3.var_4cd01941158e784c[ player getentitynumber() ][ 2 ] = { #spawnoptions:spawnoptions, #var_a2df0c82c76f136f:var_a2df0c82c76f136f, #rewardtier:rewardtier };
        }
    }

#/
