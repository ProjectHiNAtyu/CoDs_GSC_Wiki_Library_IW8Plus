// scripts\mp\common\field_upgrades\field_upgrades_frost_blast.gsc  (hash_4f810f8a8598fa95.gscc) (size: 23151 Bytes / 0x5a6f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5acae7fd (1523247101)
// size ...... 23151 (0x5a6f)
// includes .. 24  (offset: 0x53e3)
// strings ... 94  (offset: 0x54a3)
// dev strs .. 5   (offset: 0x5a33)
// exports ... 51  (offset: 0x364f)
// cseg ...... 0x947 + 0x2d08 (0x364f)
// imports ... 178 (offset: 0x3e47)
// animtree1 . 0   (offset: 0x5a6f)
// animtree2 . 0   (offset: 0x5a6f)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\status_effects\status_effects;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_tracking;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\field_upgrades\field_upgrades;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\equipmentroundscaling;
#using scripts\mp\supers;

#namespace field_upgrades_frost_blast;

// Namespace field_upgrades_frost_blast
// Params 0, eflags: 0x5
// Checksum 0xe66a0f07, Offset: 0x965
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"frost_blast", undefined, undefined, &init );
}

// Namespace field_upgrades_frost_blast
// Params 0
// Checksum 0x1e69579a, Offset: 0x986
// Size: 0x332
function init()
{
    superbundle = field_upgrades::function_1fcc83f10e7752e5( "super_frost_blast" );
    
    if ( !isdefined( superbundle ) )
    {
        return;
    }
    
    val::register( "stone_cold_blizzard", 0, 0 );
    level._effect[ "frost_blast_ice_limb" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_weapons_aat_cryofreeze_lvl1_slow_limb" );
    level._effect[ "frost_blast_aoe" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_fld_frost_blast" );
    level._effect[ "frost_blast_cast" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_fld_frost_blast_augment_tornado" );
    level._effect[ "frost_blast_ice_slick" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_fld_frost_blast_ice_slick" );
    level._effect[ "flash_freeze_shatter_fx" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_frost_blast_explo" );
    level._effect[ "frost_blast_base_decal" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_fld_frost_blast_base_tornado_decal" );
    level._effect[ "frost_blast_cast_decal" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_fld_frost_blast_augment_tornado_decal" );
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_frost_blast", &set_frost_blast, &unset_frost_blast, &begin_use_frost_blast, &function_637e85b58add66a3, undefined, &set_frost_blast );
    zombie_utils::function_dfae6a5bd222c586( &function_17fdfda41f9aa95a );
    agent_utils::register_soldier_damage_callback( &function_17fdfda41f9aa95a );
    callback::add( #"on_ai_killed", &on_ai_killed );
    level callback::add( #"player_death", &on_player_killed );
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_command( "<dev string:x3a>", "<dev string:x4b>" );
        devgui::add_devgui_command( "<dev string:x78>", "<dev string:x8c>" );
        devgui::function_77df7fe7dd273e10();
    #/
    
    sweapon = undefined;
    
    if ( isdefined( level.weaponmetadata[ %"frost_blast" ] ) )
    {
        if ( !isdefined( level.weaponmetadata[ %"frost_blast" ].weaponobj ) )
        {
            sweapon = makeweapon( level.weaponmetadata[ %"frost_blast" ].weapon );
            level.weaponmetadata[ %"frost_blast" ].weaponobj = sweapon;
        }
        else
        {
            sweapon = level.weaponmetadata[ %"frost_blast" ].weaponobj;
        }
    }
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) && isdefined( sweapon ) )
    {
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", sweapon.basename, &function_9c37dab83025b0c2 );
    }
    
    level callback::add( #"on_ai_killed_medal", &function_f24ca47ec442468f );
    
    if ( !isdefined( level.frost_blast_cast_contents ) )
    {
        content = [ "physicscontents_edge", "physicscontents_glass", "physicscontents_water", "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicleclip", "physicscontents_itemclip", "physicscontents_clipshot", "physicscontents_characterproxy", "physicscontents_playerclip", "physicscontents_vehicle" ];
        level.frost_blast_cast_contents = physics_createcontents( content );
    }
    
    supers_mp::function_19492daedcf2689a( "super_frost_blast", &get_use_time );
}

// Namespace field_upgrades_frost_blast
// Params 0
// Checksum 0x4d61b26c, Offset: 0xcc0
// Size: 0xef
function set_frost_blast()
{
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"frost_blast_high_capacity" ) && !isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) )
    {
        perk::giveperk( "specialty_overcharge_field_upgrade" );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"frost_blast_extension" ) )
    {
        base_duration = field_upgrades::function_5f728868b18ef0c0( "super_frost_blast", #"hash_66e98430fa91d10e" );
        
        if ( !isdefined( base_duration ) )
        {
            base_duration = 5;
        }
        
        self.var_87e9b1896b9a4e5f = base_duration;
        extend_amount = base_duration + base_duration * ( level.zombie_augments[ #"frost_blast_extension" ].var_b424f687fedb562a ?? 0 );
        self.super.staticdata.usetime = extend_amount;
    }
}

// Namespace field_upgrades_frost_blast
// Params 0
// Checksum 0x39e64bbc, Offset: 0xdb7
// Size: 0x7a
function unset_frost_blast()
{
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"frost_blast_high_capacity" ) && isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) )
    {
        perk::removeperk( "specialty_overcharge_field_upgrade" );
    }
    
    if ( isdefined( self.var_87e9b1896b9a4e5f ) )
    {
        self.super.staticdata.usetime = self.var_87e9b1896b9a4e5f;
    }
}

// Namespace field_upgrades_frost_blast
// Params 0
// Checksum 0xaa836d55, Offset: 0xe39
// Size: 0x4b, Type: bool
function can_use_frost_blast()
{
    if ( !self isonground() )
    {
        v_ground = getgroundposition( self.origin, 32 );
        var_2dc7498b24b43347 = distance( v_ground, self.origin );
        
        if ( var_2dc7498b24b43347 > 128 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace field_upgrades_frost_blast
// Params 0
// Checksum 0x8fb6e558, Offset: 0xe8d
// Size: 0x9a, Type: bool
function begin_use_frost_blast()
{
    if ( isdefined( level.field_upgrade_bundles[ "super_frost_blast" ] ) && can_use_frost_blast() )
    {
        var_85fcaceef0b646ea = level.field_upgrade_bundles[ "super_frost_blast" ].offhandweapon;
        deploysuccess = field_upgrades::field_upgrade_play_gesture( var_85fcaceef0b646ea, "super_frost_blast" );
        
        if ( deploysuccess )
        {
            currentweapon = self getcurrentweapon();
            
            if ( !currentweapon.isdualwield )
            {
                utility::function_7c10ea82c1e305b8( "wand_fx", "wand_on_fb" );
            }
            
            thread run_frost_blast();
            return true;
        }
    }
    
    return false;
}

// Namespace field_upgrades_frost_blast
// Params 2
// Checksum 0xbd27c34a, Offset: 0xf30
// Size: 0x93, Type: bool
function function_637e85b58add66a3( fromdeath, attacker )
{
    callback::callback( "field_upgrade_ended", { #ref:"super_frost_blast" } );
    utility::ent_flag_clear( "field_upgrade_in_use" );
    superbundle = field_upgrades::function_1fcc83f10e7752e5( "super_frost_blast" );
    
    if ( superbundle.var_8b9eade13fbfb044 )
    {
        assert( callback::exists( #"super_cancel", &frost_blast_cancel ) );
        callback::remove( #"super_cancel", &frost_blast_cancel );
    }
    
    return false;
}

// Namespace field_upgrades_frost_blast
// Params 0
// Checksum 0xba3ff827, Offset: 0xfcc
// Size: 0x84
function run_frost_blast()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    utility::ent_flag_set( "field_upgrade_in_use" );
    superbundle = field_upgrades::function_1fcc83f10e7752e5( "super_frost_blast" );
    
    if ( superbundle.var_8b9eade13fbfb044 )
    {
        assert( !callback::exists( #"super_cancel", &frost_blast_cancel ) );
        callback::add( #"super_cancel", &frost_blast_cancel );
    }
    
    thread function_d0a747fe71c60d71();
}

// Namespace field_upgrades_frost_blast
// Params 1, eflags: 0x4
// Checksum 0xa34a969f, Offset: 0x1058
// Size: 0x12f
function private clear_frost_blast( var_b15f9bba00be2aa9 )
{
    utility::waittill_any( "death_or_disconnect", "frost_blast_ended" );
    
    foreach ( player in level.players )
    {
        if ( isdefined( var_b15f9bba00be2aa9.ownerid ) )
        {
            player val::reset( "stone_cold_" + var_b15f9bba00be2aa9.ownerid, "stone_cold_blizzard" );
        }
    }
    
    if ( isdefined( var_b15f9bba00be2aa9 ) )
    {
        stopfxontag( utility::getfx( var_b15f9bba00be2aa9.fxid ), var_b15f9bba00be2aa9, "tag_origin" );
        
        if ( var_b15f9bba00be2aa9.scriptable )
        {
            var_b15f9bba00be2aa9.scriptable utility::function_7c10ea82c1e305b8( "audio", "deactivate" );
            waitframe();
            var_b15f9bba00be2aa9.scriptable freescriptable();
        }
        
        var_b15f9bba00be2aa9 utility::delaycallendon( 15, "death", &delete );
    }
}

// Namespace field_upgrades_frost_blast
// Params 1, eflags: 0x4
// Checksum 0x5bd7b719, Offset: 0x118f
// Size: 0x2b
function private frost_blast_cancel( params )
{
    self endon( #"frost_blast_cancel" );
    function_fc1234ab744d5860();
    supers_mp::reducesuperusepercent( 1 );
}

// Namespace field_upgrades_frost_blast
// Params 0, eflags: 0x4
// Checksum 0x4b0c46d0, Offset: 0x11c2
// Size: 0xb1
function private function_2d214da98ffdf7c()
{
    movingplatforminfo = utility::function_7c45b71b8e0d3cff();
    
    if ( isdefined( movingplatforminfo.groundent ) && isdefined( movingplatforminfo.localorigin ) && isdefined( movingplatforminfo.localangles ) )
    {
        if ( isdefined( self.linkedparent ) )
        {
            self.linkedparent linkto( movingplatforminfo.groundent, "", movingplatforminfo.localorigin, movingplatforminfo.localangles );
            return;
        }
        
        self linkto( movingplatforminfo.groundent, "", movingplatforminfo.localorigin, movingplatforminfo.localangles );
    }
}

// Namespace field_upgrades_frost_blast
// Params 0
// Checksum 0xd9362a97, Offset: 0x127b
// Size: 0xdbf
function function_d0a747fe71c60d71()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"frost_blast_cancel" );
    var_853f2fa3d548d7ec = 1;
    
    if ( self isonground() )
    {
        var_853f2fa3d548d7ec = 0;
    }
    
    radius = get_radius_value();
    damage_radius = get_damage_radius_value();
    duration = get_use_time();
    affectkfe = istrue( function_f017ccfa02112b98( "frost_blast_affect_KFE" ) );
    continuous_damage_enabled = istrue( function_f017ccfa02112b98( "frost_blast_continuous_damage_enabled" ) );
    var_9badfd9b34d86f93 = 0;
    var_1812d0dca73d1604 = 0;
    continuous_damage_wait_between_damage = function_f017ccfa02112b98( "frost_blast_continuous_damage_wait_between_damage" );
    var_303db862886066d4 = istrue( function_f017ccfa02112b98( "frost_blast_stun_soldiers" ) );
    var_f18dd74586dcd20e = 1;
    self.b_frost_blast_active = 1;
    area_position = self.origin;
    
    if ( function_f017ccfa02112b98( "frost_blast_drop_to_ground" ) )
    {
        area_position = utility::drop_to_ground( area_position, 10 );
    }
    
    area = utility::spawn_tag_origin( area_position, anglestoforward( self.angles ) );
    var_b14d2bcfce20c2e4 = anglestoforward( self.angles );
    var_b14d2bcfce20c2e4 = vectornormalize( var_b14d2bcfce20c2e4 );
    knockdown_chance = level.zombie_augments[ #"frost_blast_slick" ].var_405ab2676b843879 ?? 0.33;
    knockdown_chance = 100 * knockdown_chance;
    var_b6332731a26a97d7 = 1000 * ( level.zombie_augments[ #"frost_blast_flash_freeze" ].var_b24811966bad406a ?? 2 );
    var_c1a8540e9905d673 = level.zombie_augments[ #"frost_blast_flash_freeze" ].var_8072187504e7a6cf ?? 2;
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"frost_blast_slow_extend" ) )
    {
        area.frost_blast_slow_extend = 1;
    }
    
    area.var_fb887bff143cf353 = duration * 1000;
    area.last_update_time = gettime();
    area.var_958108e2da8154e7 = [];
    area.owner = self;
    area.ownerid = self getentitynumber();
    area.var_65d13e511653e91 = 1;
    self.var_b6723fb23a5db927 = [];
    waitframe();
    thread function_9c692fc7cbe96cb0( area );
    thread clear_frost_blast( area );
    var_5d04a74c75361ce2 = gettime();
    var_55d43f2e0ac9ed81 = gettime();
    var_846064346496c129 = istrue( utility::callsharedfunc( #"zombie", #"player_has_augment", #"frost_blast_cast" ) );
    
    while ( isdefined( area ) && area.var_fb887bff143cf353 > 0 )
    {
        /#
            if ( getdvarint( @"hash_f2c0c28cdc41146b", 0 ) == 1 )
            {
                level thread utility::draw_circle( area.origin, damage_radius, ( 0, 0, 1 ), 1 );
                level thread utility::draw_circle( area.origin, radius, ( 0, 1, 0 ), 1 );
            }
        #/
        
        cur_time = gettime();
        delta_time = cur_time - area.last_update_time;
        area.last_update_time = cur_time;
        area.var_fb887bff143cf353 -= delta_time;
        var_cadd794c0e343af2 = cur_time - var_55d43f2e0ac9ed81;
        var_6d1626d73fd4262f = cur_time - var_5d04a74c75361ce2;
        
        if ( var_846064346496c129 )
        {
            if ( !var_853f2fa3d548d7ec )
            {
                groundpos = getgroundposition( area.origin, 32 );
                area.origin = groundpos;
            }
            
            currentpos = area.origin;
            nextpos = area.origin + var_b14d2bcfce20c2e4;
            var_bf36dac3c73cefaa = getgroundposition( area.origin, 32 );
            testpos = ( var_bf36dac3c73cefaa[ 0 ], var_bf36dac3c73cefaa[ 1 ], var_bf36dac3c73cefaa[ 2 ] + 32 );
            var_ab26527ca6237708 = getaiarray();
            ignoreents = arraycombine( level.players, var_ab26527ca6237708 );
            traceresults = trace::sphere_trace( testpos, testpos, 16, ignoreents, level.frost_blast_cast_contents, undefined, 1 );
            
            if ( traceresults[ "fraction" ] < 1 )
            {
                area.origin = area.origin;
            }
            else
            {
                var_5d04a74c75361ce2 = cur_time;
                area.origin += var_b14d2bcfce20c2e4 * 100 / delta_time;
            }
        }
        
        a_ai_all_query = physics_querypoint( area.origin, radius, trace::create_character_contents(), undefined, "physicsquery_all" );
        nearby_ai_group = [];
        human_damage = function_f017ccfa02112b98( "frost_blast_players_damage" );
        near_humans = namespace_9d8e359c3b1041e5::getplayersinradiussharedfunc( area.origin, radius );
        
        if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"frost_blast_stone_cold_stronghold" ) )
        {
            foreach ( player in level.players )
            {
                can_affect = 1;
                
                if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
                {
                    can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( self, player );
                }
                
                if ( can_affect && arraycontains( near_humans, player ) && isdefined( area.ownerid ) )
                {
                    player val::set( "stone_cold_" + area.ownerid, "stone_cold_blizzard", 1 );
                    continue;
                }
                
                if ( isdefined( area.ownerid ) )
                {
                    player val::reset( "stone_cold_" + area.ownerid, "stone_cold_blizzard" );
                }
            }
        }
        
        if ( human_damage > 0 )
        {
            foreach ( human in near_humans )
            {
                can_affect = 1;
                
                if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
                {
                    can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( self, human );
                }
                
                if ( !can_affect )
                {
                    continue;
                }
                
                if ( player_utility::playersareenemies( self, human ) && !human vehicle::is_in_vehicle() )
                {
                    nearby_ai_group[ nearby_ai_group.size ] = human;
                }
            }
            
            self.var_ae2a8a0fc33c56a9 = near_humans;
        }
        
        foreach ( var_777f6f64f92fa683 in a_ai_all_query )
        {
            ai = var_777f6f64f92fa683[ "entity" ];
            
            if ( isalive( ai ) && isagent( ai ) )
            {
                can_affect = 1;
                
                if ( utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
                {
                    can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( self, ai );
                }
                
                if ( !can_affect )
                {
                    continue;
                }
                
                nearby_ai_group[ nearby_ai_group.size ] = ai;
                
                if ( ai.aicategory == "boss" )
                {
                    ai.var_37ff1092e1ba0507 = var_777f6f64f92fa683[ "position" ] + ( 0, 0, 48 );
                }
            }
        }
        
        foreach ( ai_data in area.var_958108e2da8154e7 )
        {
            ai = ai_data.ai;
            
            if ( !arraycontains( nearby_ai_group, ai ) )
            {
                if ( isdefined( ai ) )
                {
                    ai.frost_blast_time = undefined;
                    ai function_f258cca0d4e54dbd( area.frost_blast_slow_extend, area.owner );
                    ai function_22949439f6e193d0( 0 );
                }
                
                area.var_958108e2da8154e7 = arrayremove( area.var_958108e2da8154e7, ai_data );
            }
        }
        
        foreach ( current_ai in nearby_ai_group )
        {
            if ( !isalive( current_ai ) )
            {
                continue;
            }
            
            if ( current_ai.team == self.team )
            {
                continue;
            }
            
            if ( current_ai.var_2902ca09e32bd7d8 )
            {
                continue;
            }
            
            if ( !isdefined( current_ai.frost_blast_time ) )
            {
                current_ai.frost_blast_time = gettime();
            }
            
            if ( !current_ai utility::ent_flag( "frost_blast_active" ) )
            {
                callback::callback( "field_upgrade_stats_track", { #stats:"enemies_frozen", #ref:"super_frost_blast", #player:self } );
                sparams = spawnstruct();
                sparams.ammomod_name = "cryofreeze";
                sparams.sweapon = level.weaponmetadata[ %"frost_blast" ].weaponobj;
                sparams.victim = current_ai;
                callback::callback( "special_ammomod_proc", sparams );
            }
            
            current_ai function_22949439f6e193d0( 1, self );
            self.var_b6723fb23a5db927[ current_ai getentitynumber() ] = current_ai;
            
            if ( var_9badfd9b34d86f93 || !isdefined( area.var_958108e2da8154e7[ current_ai getentitynumber() ] ) )
            {
                if ( var_9badfd9b34d86f93 || var_f18dd74586dcd20e )
                {
                    n_damage_origin = current_ai.var_37ff1092e1ba0507 ?? current_ai.origin;
                    
                    if ( distancesquared( n_damage_origin, area.origin ) <= damage_radius * damage_radius )
                    {
                        current_ai function_c9bfcd9cf8117587( self );
                        
                        if ( !isalive( current_ai ) )
                        {
                            waitframe();
                            continue;
                        }
                    }
                }
                
                new_ai_data = spawnstruct();
                new_ai_data.ai = current_ai;
                new_ai_data.var_6afda5a4f193c5b8 = cur_time;
                area.var_958108e2da8154e7[ current_ai getentitynumber() ] = new_ai_data;
                var_9badfd9b34d86f93 = 0;
                var_1812d0dca73d1604 = gettime();
            }
            
            current_ai_data = area.var_958108e2da8154e7[ current_ai getentitynumber() ];
            var_6fab6266b5f636c3 = current_ai get_is_slowed();
            var_e5557a1483620915 = current_ai get_is_frozen();
            
            if ( !var_6fab6266b5f636c3 && !var_e5557a1483620915 )
            {
                slow_duration = area.var_fb887bff143cf353 / 1000;
                
                if ( var_846064346496c129 )
                {
                    if ( slow_duration < 5 )
                    {
                        slow_duration = 5;
                    }
                }
                
                current_ai thread function_46d612b0b9fb9736( self, slow_duration );
                
                if ( var_303db862886066d4 )
                {
                    current_ai stun_soldier( self, area.var_fb887bff143cf353 );
                }
                
                waitframe();
            }
            
            if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"frost_blast_slick" ) && !current_ai zombie_knockdown::function_19d6107cb6bdff5c() )
            {
                if ( var_cadd794c0e343af2 >= 1000 )
                {
                    if ( utility::percent_chance( knockdown_chance ) && current_ai val::get( "damage" ) )
                    {
                        current_ai thread stagger_knockdown( self, area.origin );
                    }
                }
            }
            
            if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"frost_blast_flash_freeze" ) && isdefined( current_ai.frost_blast_time ) )
            {
                if ( cur_time - current_ai.frost_blast_time >= var_b6332731a26a97d7 )
                {
                    if ( !var_e5557a1483620915 && area.var_65d13e511653e91 )
                    {
                        if ( current_ai get_can_freeze() )
                        {
                            current_ai function_f258cca0d4e54dbd( area.frost_blast_slow_extend, area.owner );
                            current_ai freeze_ai( var_c1a8540e9905d673, self );
                        }
                    }
                }
            }
        }
        
        var_f18dd74586dcd20e = 0;
        
        if ( var_cadd794c0e343af2 >= 1000 )
        {
            var_55d43f2e0ac9ed81 = cur_time;
        }
        
        if ( affectkfe )
        {
            function_7e978679c55791d3( area, radius );
        }
        
        if ( continuous_damage_enabled && isdefined( continuous_damage_wait_between_damage ) )
        {
            diff = gettime() - var_1812d0dca73d1604;
            
            if ( diff > continuous_damage_wait_between_damage )
            {
                var_9badfd9b34d86f93 = 1;
            }
        }
        
        waitframe();
    }
    
    function_fc1234ab744d5860( area.frost_blast_slow_extend, area.owner );
}

// Namespace field_upgrades_frost_blast
// Params 2, eflags: 0x4
// Checksum 0xf53b8681, Offset: 0x2042
// Size: 0xea
function private function_fc1234ab744d5860( frost_blast_slow_extend = 0, owner )
{
    self.b_frost_blast_active = undefined;
    
    if ( isarray( self.var_b6723fb23a5db927 ) )
    {
        foreach ( ai in self.var_b6723fb23a5db927 )
        {
            if ( frost_blast_slow_extend )
            {
                ai frost_blast_extend( owner );
                continue;
            }
            
            ai function_22949439f6e193d0( 0 );
        }
        
        self.var_b6723fb23a5db927 = undefined;
    }
    
    function_5ad1ea03cb3898ad();
    self.var_ae2a8a0fc33c56a9 = undefined;
    self notify( #"frost_blast_ended" );
}

// Namespace field_upgrades_frost_blast
// Params 0, eflags: 0x4
// Checksum 0x5a08aeae, Offset: 0x2134
// Size: 0x1b
function private get_radius_value()
{
    radius = function_f017ccfa02112b98( "frost_blast_base_radius" );
    return radius;
}

// Namespace field_upgrades_frost_blast
// Params 0, eflags: 0x4
// Checksum 0xddbf7314, Offset: 0x2158
// Size: 0x1b
function private get_damage_radius_value()
{
    radius = function_f017ccfa02112b98( "frost_blast_base_damage_radius" );
    return radius;
}

// Namespace field_upgrades_frost_blast
// Params 1, eflags: 0x4
// Checksum 0xc5ed1082, Offset: 0x217c
// Size: 0x71
function private get_use_time( super_info )
{
    duration = function_f017ccfa02112b98( "frost_blast_duration" );
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"frost_blast_extension" ) )
    {
        duration += duration * ( level.zombie_augments[ #"frost_blast_extension" ].var_b424f687fedb562a ?? 0 );
    }
    
    return duration;
}

// Namespace field_upgrades_frost_blast
// Params 2
// Checksum 0x8418ed2b, Offset: 0x21f6
// Size: 0x73
function stagger_knockdown( attacker, areaorigin )
{
    self endon( #"death" );
    randomwait = randomfloatrange( 0.1, 0.2 );
    wait randomwait;
    asm::function_d82cb83c9c260d49( 1 );
    playfx( utility::getfx( "frost_blast_ice_slick" ), self.origin );
    zombie_knockdown::function_6fc167d4a3590991( areaorigin );
    thread function_eeb8eb423c476885();
}

// Namespace field_upgrades_frost_blast
// Params 0, eflags: 0x4
// Checksum 0x6e65a5cb, Offset: 0x2271
// Size: 0x29
function private function_eeb8eb423c476885()
{
    self endon( #"death" );
    wait 0.2;
    
    if ( get_is_slowed() )
    {
        asm::function_d82cb83c9c260d49( 0.5 );
    }
}

// Namespace field_upgrades_frost_blast
// Params 2
// Checksum 0x45d1eb80, Offset: 0x22a2
// Size: 0xa2
function function_22949439f6e193d0( var_6fb860f7c9723d4e, e_attacker )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( self.var_6ec00cb739aad7d6 )
    {
        return;
    }
    
    if ( var_6fb860f7c9723d4e )
    {
        self.var_e957ff879042cc5f = e_attacker;
        utility::ent_flag_set( "frost_blast_active" );
        self.frost_blast_kill = 1;
        utility::function_32b24db3127bff40( "cryofreeze", "cryofreeze_on" );
        return;
    }
    
    self.frost_blast_time = undefined;
    self.var_e957ff879042cc5f = undefined;
    utility::ent_flag_clear( "frost_blast_active" );
    self.frost_blast_kill = 0;
    utility::function_32b24db3127bff40( "cryofreeze", "cryofreeze_shatter" );
}

// Namespace field_upgrades_frost_blast
// Params 1
// Checksum 0xb58d0390, Offset: 0x234c
// Size: 0x187
function function_9c692fc7cbe96cb0( area )
{
    area show();
    area function_2d214da98ffdf7c();
    var_846064346496c129 = istrue( utility::callsharedfunc( #"zombie", #"player_has_augment", #"frost_blast_cast" ) );
    var_9ad0f1c71fe9ef1e = self isonground() || function_f017ccfa02112b98( "frost_blast_drop_to_ground" );
    
    if ( var_9ad0f1c71fe9ef1e )
    {
        if ( var_846064346496c129 )
        {
            area.fxid = "frost_blast_cast_decal";
            playfxontag( utility::getfx( "frost_blast_cast_decal" ), area, "tag_origin" );
        }
        else
        {
            area.fxid = "frost_blast_base_decal";
            playfxontag( utility::getfx( "frost_blast_base_decal" ), area, "tag_origin" );
        }
    }
    else
    {
        area.fxid = "frost_blast_cast";
        playfxontag( utility::getfx( "frost_blast_cast" ), area, "tag_origin" );
    }
    
    scriptable = spawnscriptable( "super_frost_blast", area.origin );
    area.scriptable = scriptable;
    damage_radius = function_f017ccfa02112b98( "frost_blast_base_radius" );
    damage_amount = function_f017ccfa02112b98( "frost_blast_base_damage_amount" );
    self radiusdamage( self.origin, damage_radius, damage_amount, damage_amount, self, "MOD_EXPLOSIVE", undefined, 1 );
    waitframe();
    scriptable scriptablesetparententity( area );
    area.scriptable utility::function_7c10ea82c1e305b8( "audio", "on" );
}

// Namespace field_upgrades_frost_blast
// Params 1
// Checksum 0x677adaad, Offset: 0x24db
// Size: 0x30a
function function_c9bfcd9cf8117587( attacker )
{
    base_damage_percent = function_f017ccfa02112b98( "frost_blast_base_damage_percent" );
    var_578d71b7c00fc4ba = function_f017ccfa02112b98( "frost_blast_min_damage_amount" ) ?? 0;
    damage = 0;
    var_9d8e21d3683980ea = 0;
    
    if ( damage == 0 && self.type == "human" )
    {
        if ( self.type == "human" || self.unittype == "soldier" )
        {
            damage = function_f017ccfa02112b98( "frost_blast_ai_soldier_damage" );
        }
    }
    else
    {
        round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( attacker.origin );
        zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
        damage = int( zombie_base_health * base_damage_percent );
        var_9d8e21d3683980ea = 1;
    }
    
    if ( isplayer( self ) )
    {
        human_damage = function_f017ccfa02112b98( "frost_blast_players_damage" );
        
        if ( human_damage > 0 )
        {
            damage = human_damage;
        }
    }
    
    if ( damage == 0 && isdefined( self.aicategory ) )
    {
        var_38ef4250e4e2c082 = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
        var_ab98a896c3190bf9 = function_f017ccfa02112b98( "frost_blast_base_damage_amount" );
        damage = namespace_35d7a88a59082733::function_4a6cf9bafc91e53( var_ab98a896c3190bf9, var_38ef4250e4e2c082, "frag_grenade", self.aicategory, self.maxhealth, self.var_a03f571fe06a52b8 );
    }
    
    sweapon = "none";
    
    if ( isdefined( level.weaponmetadata[ %"frost_blast" ] ) )
    {
        if ( !isdefined( level.weaponmetadata[ %"frost_blast" ].weaponobj ) )
        {
            sweapon = makeweapon( level.weaponmetadata[ %"frost_blast" ].weapon );
            level.weaponmetadata[ %"frost_blast" ].weaponobj = sweapon;
        }
        else
        {
            sweapon = level.weaponmetadata[ %"frost_blast" ].weaponobj;
        }
    }
    
    if ( isagent( self ) && damage >= self.health )
    {
        effect_slow::slow( "frost_blast", 1, 1, attacker, &function_3d9014a4ca5e10d2, undefined, "cold" );
        zombie_emergence_spawning::function_80623a2279a4d888();
        val::set( "insta_kill", "kill_on_damage", 1 );
        val::set( "zm_allow_give_super_point", "allow_give_super_point", 0 );
    }
    
    if ( self.aicategory == "boss" )
    {
        shitloc = undefined;
    }
    else
    {
        shitloc = "none";
    }
    
    idflags = 65536 | ( var_9d8e21d3683980ea ? 1073741824 : 0 );
    
    if ( damage < var_578d71b7c00fc4ba )
    {
        damage = var_578d71b7c00fc4ba;
    }
    
    self dodamage( damage, self.var_37ff1092e1ba0507 ?? self.origin, attacker, attacker, "MOD_ELEMENTAL_COLD", sweapon, shitloc, undefined, idflags );
    self.var_37ff1092e1ba0507 = undefined;
}

// Namespace field_upgrades_frost_blast
// Params 2
// Checksum 0xff1a1eed, Offset: 0x27ed
// Size: 0x81
function function_46d612b0b9fb9736( attacker, duration )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( duration <= 0.1 )
    {
        return;
    }
    
    if ( self.aisettings.var_3dae55586fee0a61 )
    {
        var_d2a68d6e8de14258 = function_f017ccfa02112b98( "frost_blast_ai_slow_percentage" );
        effect_slow::slow( "frost_blast", var_d2a68d6e8de14258, duration, attacker, &function_3d9014a4ca5e10d2, undefined, "cold" );
    }
}

// Namespace field_upgrades_frost_blast
// Params 2
// Checksum 0x472ef0aa, Offset: 0x2876
// Size: 0x4e
function stun_soldier( attacker, var_835521bc7d4bae1f )
{
    if ( self.unittype == "soldier" )
    {
        self notify( #"flashbang", self.origin, 1, undefined, attacker, attacker.team, var_835521bc7d4bae1f );
    }
}

// Namespace field_upgrades_frost_blast
// Params 2, eflags: 0x40 variadic
// Checksum 0x150742a2, Offset: 0x28cc
// Size: 0x24
function function_30c6fd60777f9b70( ... )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    set_is_frozen( 0 );
}

// Namespace field_upgrades_frost_blast
// Params 2, eflags: 0x40 variadic
// Checksum 0xcfbd135c, Offset: 0x28f8
// Size: 0x1c
function function_3d9014a4ca5e10d2( ... )
{
    if ( !isdefined( self ) )
    {
        return;
    }
}

// Namespace field_upgrades_frost_blast
// Params 2, eflags: 0x40 variadic
// Checksum 0x9150a60e, Offset: 0x291c
// Size: 0x2e
function function_e9b2e8bbd8b58993( ... )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.var_6ec00cb739aad7d6 = undefined;
    function_22949439f6e193d0( 0 );
}

// Namespace field_upgrades_frost_blast
// Params 1
// Checksum 0x2507a586, Offset: 0x2952
// Size: 0x6f
function frost_blast_extend( owner )
{
    self.var_6ec00cb739aad7d6 = 1;
    duration = level.zombie_augments[ #"frost_blast_slow_extend" ].var_1bb32565dc093187 ?? 5;
    var_d2a68d6e8de14258 = function_f017ccfa02112b98( "frost_blast_ai_slow_percentage" );
    effect_slow::slow( "frost_blast", var_d2a68d6e8de14258, duration, owner, &function_e9b2e8bbd8b58993 );
}

// Namespace field_upgrades_frost_blast
// Params 2
// Checksum 0xcb388e48, Offset: 0x29c9
// Size: 0x4d
function function_f258cca0d4e54dbd( frost_blast_slow_extend = 0, owner )
{
    if ( get_is_slowed() )
    {
        if ( frost_blast_slow_extend && isplayer( owner ) )
        {
            frost_blast_extend( owner );
            return;
        }
        
        effect_slow::function_80a4bd13b5ba303a( "frost_blast" );
    }
}

// Namespace field_upgrades_frost_blast
// Params 0
// Checksum 0xfc9be621, Offset: 0x2a1e
// Size: 0x12
function get_is_slowed()
{
    return status_effects::function_fa35fc2723e956eb( "slow", "frost_blast" );
}

// Namespace field_upgrades_frost_blast
// Params 1
// Checksum 0xb8ec788d, Offset: 0x2a39
// Size: 0x6a
function function_17fdfda41f9aa95a( params )
{
    if ( utility::ent_flag( "frost_blast_active" ) && isdefined( params.eattacker ) )
    {
        return get_cold_damage( params.idamage, params.eattacker, params.smeansofdeath, params.shitloc, params.sweapon );
    }
    
    return -1;
}

// Namespace field_upgrades_frost_blast
// Params 5
// Checksum 0x52df4016, Offset: 0x2aac
// Size: 0x156
function get_cold_damage( idamage, eattacker, smeansofdeath, shitloc, sweapon )
{
    idamage = ( level.field_upgrade_bundles[ "super_frost_blast" ].damagemultiplier ?? 1 ) * idamage;
    
    if ( eattacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"frost_blast_frostbite" ) )
    {
        idamage = ( level.zombie_augments[ #"frost_blast_frostbite" ].var_eebb288fa7349d34 ?? 1 ) * idamage;
    }
    
    if ( self.is_frost_blast_frozen )
    {
        self.killondamage = 1;
        
        if ( self tagexists( "j_spine4" ) )
        {
            var_bc50e8b33eaaf83b = self gettagorigin( "j_spine4" );
            playfx( utility::getfx( "flash_freeze_shatter_fx" ), var_bc50e8b33eaaf83b );
        }
        else
        {
            var_bc50e8b33eaaf83b = self getcentroid();
            playfx( utility::getfx( "flash_freeze_shatter_fx" ), var_bc50e8b33eaaf83b );
        }
        
        self hide();
        self.nocorpse = 1;
    }
    
    is_iced = get_is_frozen() || get_is_slowed();
    
    if ( idamage >= self.health && is_iced )
    {
        utility::ent_flag_set( "frost_killed" );
    }
    
    return idamage;
}

// Namespace field_upgrades_frost_blast
// Params 2
// Checksum 0x520bc12b, Offset: 0x2c0b
// Size: 0x46
function freeze_ai( duration = 1, attacker )
{
    effect_slow::slow( "frost_blast_frozen", 0.0001, duration, attacker, &function_30c6fd60777f9b70, undefined, "cold" );
    set_is_frozen( 1 );
}

// Namespace field_upgrades_frost_blast
// Params 0
// Checksum 0x126f5c59, Offset: 0x2c59
// Size: 0x18, Type: bool
function get_can_freeze()
{
    if ( self.aicategory === "normal" )
    {
        return true;
    }
    
    return false;
}

// Namespace field_upgrades_frost_blast
// Params 0
// Checksum 0x948ecbca, Offset: 0x2c7a
// Size: 0xb
function get_is_frozen()
{
    return self.is_frost_blast_frozen;
}

// Namespace field_upgrades_frost_blast
// Params 1
// Checksum 0xe0300793, Offset: 0x2c8e
// Size: 0x17
function set_is_frozen( b_value )
{
    self.is_frost_blast_frozen = b_value;
}

// Namespace field_upgrades_frost_blast
// Params 1
// Checksum 0xe5191d37, Offset: 0x2cad
// Size: 0x19
function function_f017ccfa02112b98( var_92718a0fa1b5dcae )
{
    return field_upgrades::function_5f728868b18ef0c0( "super_frost_blast", var_92718a0fa1b5dcae );
}

// Namespace field_upgrades_frost_blast
// Params 4, eflags: 0x4
// Checksum 0x85a5b491, Offset: 0x2ccf
// Size: 0x166
function private function_9c37dab83025b0c2( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "frost_blast" );
        victim.var_579f1be20f9ad06e = 1;
    }
    
    victim.is_lethal_or_super_kill = 1;
    params = { #stats:"kills", #ref:"super_frost_blast", #field_upgrade:"frost_blast", #victim:victim, #player:self };
    callback::callback( "on_field_upgrade_kill_track", params );
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ "frost_blast" ] ) && self.rapidkill_data[ "frost_blast" ].rapidkill_count == 10 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_flashfreeze" );
            
            if ( utility::issharedfuncdefined( #"sound", #"play_scoreevent_vo", 0 ) )
            {
                utility::callsharedfunc( #"sound", #"play_scoreevent_vo", self, #"bc_super_frost_blast_success" );
            }
        }
    }
}

// Namespace field_upgrades_frost_blast
// Params 1, eflags: 0x4
// Checksum 0xfda9462a, Offset: 0x2e3d
// Size: 0x170
function private function_f24ca47ec442468f( params )
{
    if ( !params.victim.var_579f1be20f9ad06e )
    {
        if ( params.victim effect_slow::function_e91f0595ade60e84( params.attacker, "frost_blast" ) )
        {
            if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
            {
                params.attacker utility::callsharedfunc( #"medal", #"track_rapid_kill", "frost_blast" );
            }
            
            if ( isdefined( params.attacker.rapidkill_data ) )
            {
                if ( isdefined( params.attacker.rapidkill_data[ "frost_blast" ] ) && params.attacker.rapidkill_data[ "frost_blast" ].rapidkill_count == 10 )
                {
                    params.attacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_flashfreeze" );
                }
            }
            
            params = { #stats:"kills", #ref:"super_frost_blast", #field_upgrade:"frost_blast", #victim:params.victim, #player:params.attacker };
            callback::callback( "on_field_upgrade_kill_track", params );
        }
    }
}

// Namespace field_upgrades_frost_blast
// Params 2, eflags: 0x4
// Checksum 0xbd819358, Offset: 0x2fb5
// Size: 0x152
function private function_7e978679c55791d3( area, radius )
{
    if ( !isdefined( self.var_25a8b41f195e39b7 ) )
    {
        self.var_25a8b41f195e39b7 = [];
    }
    
    var_8b55843332ef58bd = function_58ec2d2f2ecbcddb( area.origin, radius );
    
    foreach ( kfe in self.var_25a8b41f195e39b7 )
    {
        if ( !arraycontains( var_8b55843332ef58bd, kfe ) )
        {
            function_3fee72a4b93ced11( kfe );
        }
    }
    
    foreach ( kfe in var_8b55843332ef58bd )
    {
        if ( !arraycontains( self.var_25a8b41f195e39b7, kfe ) )
        {
            frost_kfe( kfe );
        }
    }
    
    self.var_25a8b41f195e39b7 = var_8b55843332ef58bd;
}

// Namespace field_upgrades_frost_blast
// Params 2, eflags: 0x4
// Checksum 0x30d18002, Offset: 0x310f
// Size: 0xe6
function private function_58ec2d2f2ecbcddb( origin, radius )
{
    killstreakarray = level.activekillstreaks;
    equipmentarray = [[ level.getactiveequipmentarray ]]();
    aiarray = getaiarrayinradius( self.origin, radius );
    turrets = getentarray( "misc_turret", #classname );
    mines = weapon::function_3aafcaf7ff6dea9e();
    kfes = [];
    kfes = arraycombineunique( kfes, killstreakarray, equipmentarray, aiarray, turrets, mines );
    var_8b55843332ef58bd = function_da2764f3171e52a( origin, radius, kfes, &function_711e9ef2bcc58118 );
    vehiclearray = vehicle_tracking::function_5820a38c9873992e();
    var_f465cc52b4fad372 = function_da2764f3171e52a( origin, radius, vehiclearray, &function_83f7feb774d5b8d4 );
    return arraycombineunique( var_8b55843332ef58bd, var_f465cc52b4fad372 );
}

// Namespace field_upgrades_frost_blast
// Params 4, eflags: 0x4
// Checksum 0x52112e25, Offset: 0x31fe
// Size: 0xe1
function private function_da2764f3171e52a( origin, radius, var_27248d6c6d72c7e9, var_e437a7ca58cd79b7 )
{
    radiussq = radius * radius;
    result = [];
    
    foreach ( element in var_27248d6c6d72c7e9 )
    {
        if ( [[ var_e437a7ca58cd79b7 ]]( self, element ) )
        {
            continue;
        }
        
        dist = distancesquared( origin, element.origin );
        
        if ( dist <= radiussq )
        {
            result[ result.size ] = element;
        }
    }
    
    return result;
}

// Namespace field_upgrades_frost_blast
// Params 2, eflags: 0x4
// Checksum 0x3ce85b2f, Offset: 0x32e8
// Size: 0x1f, Type: bool
function private function_711e9ef2bcc58118( player, elem )
{
    return !player_utility::playersareenemies( player, elem );
}

// Namespace field_upgrades_frost_blast
// Params 2, eflags: 0x4
// Checksum 0x404a7e8b, Offset: 0x3310
// Size: 0x1e
function private function_83f7feb774d5b8d4( player, vehicle )
{
    return vehicle::is_friendly_to_player( vehicle, player );
}

// Namespace field_upgrades_frost_blast
// Params 0, eflags: 0x4
// Checksum 0x4d6092e, Offset: 0x3337
// Size: 0x94
function private function_5ad1ea03cb3898ad()
{
    if ( !isdefined( self.var_25a8b41f195e39b7 ) )
    {
        return;
    }
    
    foreach ( kfe in self.var_25a8b41f195e39b7 )
    {
        function_3fee72a4b93ced11( kfe );
    }
    
    self.var_25a8b41f195e39b7 = undefined;
}

// Namespace field_upgrades_frost_blast
// Params 1, eflags: 0x4
// Checksum 0x2bbf2439, Offset: 0x33d3
// Size: 0x53
function private function_3fee72a4b93ced11( kfe )
{
    if ( should_ignore_kfe( kfe ) )
    {
        return;
    }
    
    if ( kfe.streakname == "ground_drone_unit" )
    {
        kfe utility::callsharedfunc( #"ground_drone_unit", #"hash_6f529a6e863454a1" );
        return;
    }
    
    kfe emp_debuff::remove_emp();
}

// Namespace field_upgrades_frost_blast
// Params 1, eflags: 0x4
// Checksum 0x4270995b, Offset: 0x342e
// Size: 0xc6
function private frost_kfe( kfe )
{
    if ( should_ignore_kfe( kfe ) )
    {
        return;
    }
    
    if ( kfe.streakname == "ground_drone_unit" )
    {
        var_d2a68d6e8de14258 = function_f017ccfa02112b98( "frost_blast_ai_slow_percentage" );
        kfe utility::callsharedfunc( #"ground_drone_unit", #"freeze", self, var_d2a68d6e8de14258 );
        return;
    }
    
    if ( !kfe emp_debuff::is_empd() )
    {
        playerweapon = level.weaponmetadata[ %"frost_blast" ].weaponobj;
        data = damage_utility::packdamagedata( self, kfe, 1, playerweapon, "MOD_EXPLOSIVE", self, self.origin );
        emp_debuff::apply_emp_struct( data );
    }
}

// Namespace field_upgrades_frost_blast
// Params 1, eflags: 0x4
// Checksum 0x38f036bb, Offset: 0x34fc
// Size: 0x1d, Type: bool
function private should_ignore_kfe( kfe )
{
    return kfe.streakname == "dawg";
}

// Namespace field_upgrades_frost_blast
// Params 2, eflags: 0x4
// Checksum 0x60ea3e5e, Offset: 0x3522
// Size: 0x90
function private function_e8795559e0442cde( attacker, is_iced )
{
    if ( utility::ent_flag( "frost_blast_active" ) && isdefined( attacker ) )
    {
        if ( is_iced )
        {
            kill_scoreevent = function_f017ccfa02112b98( "frost_blast_kill_score_event" );
            
            if ( kill_scoreevent )
            {
                attacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( kill_scoreevent );
            }
            
            assist_scoreevent = function_f017ccfa02112b98( "frost_blast_assist_score_event" );
            
            if ( assist_scoreevent )
            {
                if ( self.var_e957ff879042cc5f != attacker )
                {
                    self.var_e957ff879042cc5f namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( assist_scoreevent );
                }
            }
        }
    }
}

// Namespace field_upgrades_frost_blast
// Params 1, eflags: 0x4
// Checksum 0x97a37d10, Offset: 0x35ba
// Size: 0x3c
function private on_ai_killed( params )
{
    is_iced = get_is_frozen() || get_is_slowed();
    function_e8795559e0442cde( params.eattacker, is_iced );
}

// Namespace field_upgrades_frost_blast
// Params 1, eflags: 0x4
// Checksum 0xf2ca5776, Offset: 0x35fe
// Size: 0x51
function private on_player_killed( params )
{
    attacker = params.attacker;
    
    if ( isdefined( attacker.var_ae2a8a0fc33c56a9 ) && arraycontains( attacker.var_ae2a8a0fc33c56a9, self ) )
    {
        function_e8795559e0442cde( attacker, 1 );
    }
}

