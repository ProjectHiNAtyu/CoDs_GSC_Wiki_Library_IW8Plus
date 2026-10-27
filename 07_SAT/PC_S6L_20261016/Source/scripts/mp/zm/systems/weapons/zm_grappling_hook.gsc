// scripts\mp\zm\systems\weapons\zm_grappling_hook.gsc  (hash_6ede66b00b8f3c33.gscc) (size: 9294 Bytes / 0x244e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x12d403b4 (315884468)
// size ...... 9294 (0x244e)
// includes .. 15  (offset: 0x215a)
// strings ... 41  (offset: 0x21d2)
// dev strs .. 3   (offset: 0x2426)
// exports ... 21  (offset: 0x133a)
// cseg ...... 0x38c + 0xfae (0x133a)
// imports ... 93  (offset: 0x1682)
// animtree1 . 0   (offset: 0x244e)
// animtree2 . 0   (offset: 0x244e)
#using scripts\common\ai\aitypes\shared\zombie\zombie_dismemberment;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\equipment\grappling_hook;
#using scripts\mp\common\weapons\ww_shared;
#using scripts\mp\equipment;
#using scripts\mp\loot\common_item;
#using scripts\mp\weapons;
#using scripts\mp\zm\systems\zm_livingworld;

#namespace zm_grappling_hook;

// Namespace zm_grappling_hook
// Params 0, eflags: 0x5
// Checksum 0x44da21ef, Offset: 0x3aa
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"zm_grappling_hook", #"grappling_hook", undefined, &post_main );
}

// Namespace zm_grappling_hook
// Params 0, eflags: 0x4
// Checksum 0xe317fbcc, Offset: 0x3d3
// Size: 0xa
function private post_main()
{
    level thread init();
}

// Namespace zm_grappling_hook
// Params 0, eflags: 0x4
// Checksum 0xf3d3b5f0, Offset: 0x3e5
// Size: 0x19a
function private init()
{
    level endon( #"game_ended" );
    utility::flag_wait( "equipment_initialized" );
    common_item::function_84174b793b5fe9a7( "tactical", #"hash_9e49dfaa7c147654", &can_pickup_equipment );
    callback::add( #"hash_db23ebf23acc8885", &function_4c2d79c84db07f32 );
    callback::add( #"equipment_use", &function_99b96c8d67053c9c );
    callback::add( "on_grapple_pulling_end", &on_grapple_pulling_end );
    callback::add( "on_grapple_pulling_start", &on_grapple_pulling_start );
    callback::add( #"player_aerial", &function_5279393aafd8bd3e );
    callback::add( #"hash_6391eced0d5aa525", &function_99e722e8f727f28d );
    callback::add( #"equipment_given", &function_233588fa71e62c8e );
    thread utility::callsharedfunc( #"analytics", #"hash_eb9d0dae8f38111f", { #var_e7d8089975495767:1, #equipref:"equip_grappling_hook_upgraded" } );
    equipment_mp::function_a48e87b7ec89821e( "equip_grappling_hook_upgraded", "onFired", &grappling_hook::function_a92bfec42428dd70 );
    equipment_mp::function_a48e87b7ec89821e( "equip_grappling_hook_upgraded", "onGive", &grappling_hook::function_7a5b1311066d3641 );
    equipment_mp::function_a48e87b7ec89821e( "equip_grappling_hook_upgraded", "onTake", &grappling_hook::function_df33581394706eaf );
    equipment_mp::function_a48e87b7ec89821e( "equip_grappling_hook_upgraded", "onDestroyedByTrophy", &grappling_hook::function_7188af2d1400239a );
    level._effect[ "vfx_sat_equip_grappling_hook_imp_green" ] = loadfxasset( "vfx_sat_equip_grappling_hook_imp_green" );
    level._effect[ "vfx_sat_equip_grappling_hook_imp_red" ] = loadfxasset( "vfx_sat_equip_grappling_hook_imp_red" );
    waitframe();
    weapons::deregisterusedcallback( "grappling_hook" );
    weapons::registerusedcallback( "grappling_hook", &function_a1fe625060f3617d );
}

// Namespace zm_grappling_hook
// Params 1, eflags: 0x4
// Checksum 0xbe09c9e1, Offset: 0x587
// Size: 0x2b
function private function_a1fe625060f3617d( grenade )
{
    self.grapple_projectile = grenade;
    self.grapple_impact_data = undefined;
    grenade thread watch_grapple_impact( self );
}

// Namespace zm_grappling_hook
// Params 1, eflags: 0x4
// Checksum 0xcae85727, Offset: 0x5ba
// Size: 0xa2
function private watch_grapple_impact( player )
{
    self endon( #"death" );
    self waittill( #"missile_stuck", var_90ec0886f9ccf215, part_name, var_b4aecda982428c96, velocity, position, normal );
    
    if ( !isplayer( player ) || player.grapple_projectile != self )
    {
        return;
    }
    
    player.grapple_impact_data = { #normal:normal, #position:position };
}

// Namespace zm_grappling_hook
// Params 1, eflags: 0x4
// Checksum 0x358a8330, Offset: 0x664
// Size: 0xa5
function private function_233588fa71e62c8e( params )
{
    item_ref = params.ref;
    
    if ( !isdefined( item_ref ) )
    {
        return;
    }
    
    if ( item_ref != "equip_grappling_hook" && item_ref != "equip_grappling_hook_upgraded" )
    {
        return;
    }
    
    var_ce20e516dc44ca97 = item_ref == "equip_grappling_hook_upgraded";
    self.var_1c02451065a994b2 = item_ref;
    self.var_79594805ae36acb4 = var_ce20e516dc44ca97 ? &"hash_5517280e6afcde7f" : &"hash_558bc617a8fbd65a";
    self.var_83103a2afee46f87 = var_ce20e516dc44ca97 ? "zm_grappling_hook_upgraded_tutorial_message_has_displayed" : "zm_grappling_hook_tutorial_message_has_displayed";
    thread function_362ec3e7e7bcf192();
}

// Namespace zm_grappling_hook
// Params 0, eflags: 0x4
// Checksum 0xffb8730c, Offset: 0x711
// Size: 0xaa
function private function_362ec3e7e7bcf192()
{
    self endon( #"death_or_disconnect" );
    
    if ( !( isdefined( self.var_79594805ae36acb4 ) && isdefined( self.var_83103a2afee46f87 ) ) )
    {
        return;
    }
    
    utility::waittill_any_timeout( 0.75, "weapon_raise_code", "death_or_disconnect" );
    
    if ( equipment_mp::getcurrentequipment( "secondary" ) != self.var_1c02451065a994b2 )
    {
        return;
    }
    
    if ( !utility::ent_flag( self.var_83103a2afee46f87 ) )
    {
        utility::ent_flag_set( self.var_83103a2afee46f87 );
        thread ww_shared::show_hud_tutorial_message( self.var_79594805ae36acb4 );
    }
    
    self.var_1c02451065a994b2 = undefined;
    self.var_79594805ae36acb4 = undefined;
    self.var_83103a2afee46f87 = undefined;
}

// Namespace zm_grappling_hook
// Params 4, eflags: 0x4
// Checksum 0x4b1ba7c4, Offset: 0x7c3
// Size: 0x67, Type: bool
function private can_pickup_equipment( itembundle, item, autouse, allowswap )
{
    currentequipment = equipment_mp::getcurrentequipment( "secondary" );
    
    if ( currentequipment == "equip_grappling_hook" || currentequipment == "equip_grappling_hook_upgraded" )
    {
        return false;
    }
    
    if ( self.var_7a1bba3b82189d4c )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_grappling_hook
// Params 1, eflags: 0x4
// Checksum 0x2766f2e7, Offset: 0x833
// Size: 0x1dc
function private function_4c2d79c84db07f32( params )
{
    retrieved_entity = params.entity;
    retrieved_scriptable = params.scriptable;
    hit_position = params.position;
    
    /#
        if ( getdvarint( @"grapple_debug", 0 ) )
        {
            if ( retrieved_entity )
            {
                entity_num = retrieved_entity getentitynumber();
                iprintln( "<dev string:x24>" + self getentitynumber() + "<dev string:x2c>" + entity_num );
            }
            else if ( retrieved_scriptable )
            {
                scriptable_index = retrieved_scriptable getscriptableindex();
                iprintln( "<dev string:x24>" + self getentitynumber() + "<dev string:x43>" + scriptable_index );
            }
        }
    #/
    
    if ( isagent( retrieved_entity ) && isalive( retrieved_entity ) && !retrieved_entity.var_990324c31d3215c5 )
    {
        if ( retrieved_entity.team != self.team )
        {
            zombie = retrieved_entity;
            
            if ( zombie.aicategory == "normal" )
            {
                chest_position = zombie tagexists( "j_spine4" ) ? zombie gettagorigin( "j_spine4" ) : zombie getcentroid();
                
                if ( !isdefined( hit_position ) )
                {
                    hit_position = chest_position;
                }
                
                player_position = self tagexists( "j_wrist_le" ) ? self gettagorigin( "j_wrist_le" ) : self geteye();
                direction = vectornormalize( player_position - hit_position );
                
                if ( !function_e1a654e500af6545( zombie, hit_position, chest_position, direction, params.speed ) )
                {
                    function_f71e0282600c77fa( zombie, chest_position, direction, params.speed );
                }
                
                return;
            }
            
            if ( zombie.aicategory == "special" )
            {
                function_95cd598cc8ac06a5( zombie );
            }
        }
    }
}

// Namespace zm_grappling_hook
// Params 1, eflags: 0x4
// Checksum 0xf512a239, Offset: 0xa17
// Size: 0xce
function private on_grapple_pulling_start( params )
{
    utility::function_32b24db3127bff40( "grappling_hook_speed_cam", "on" );
    pos = self.grapple_impact_data.position;
    
    if ( pos )
    {
        var_24dc036a2bd9a4e0 = equipment_mp::getcurrentequipment( "secondary" );
        impact_fx = var_24dc036a2bd9a4e0 == "equip_grappling_hook_upgraded" ? "vfx_sat_equip_grappling_hook_imp_red" : "vfx_sat_equip_grappling_hook_imp_green";
        impact_normal = self.grapple_impact_data.normal;
        self.grapplefx = playfx( utility::getfx( impact_fx ), pos, undefined, impact_normal, undefined, undefined, 1 );
    }
    
    self.grapple_impact_data = undefined;
    self.grapple_projectile = undefined;
    thread function_c637efd20dd61aa6();
}

// Namespace zm_grappling_hook
// Params 1, eflags: 0x4
// Checksum 0x3794c234, Offset: 0xaed
// Size: 0xab
function private on_grapple_pulling_end( params )
{
    if ( !isplayer( self ) || !isalive( self ) )
    {
        return;
    }
    
    utility::function_32b24db3127bff40( "grappling_hook_speed_cam", "off" );
    forward = vectornormalize( anglestoforward( self.angles ) );
    forward *= 32;
    knockdown_origin = self.origin + forward;
    zombie_utils::function_607ff821e430d594( knockdown_origin, 64, 3 );
    
    if ( self.grappled_elite )
    {
        self.grappled_elite callback::callback( "force_ride_loom", { #player:self } );
    }
    
    thread function_c1fbff5a01d93691();
}

// Namespace zm_grappling_hook
// Params 1, eflags: 0x4
// Checksum 0x97ef7271, Offset: 0xba0
// Size: 0x41
function private function_5279393aafd8bd3e( params )
{
    grapple_ent = self getgrappletargetentity();
    
    if ( grapple_ent )
    {
        if ( grapple_ent.aicategory == "elite" )
        {
            self.grappled_elite = grapple_ent;
        }
    }
}

// Namespace zm_grappling_hook
// Params 1, eflags: 0x4
// Checksum 0xd1e05d61, Offset: 0xbe9
// Size: 0x23
function private function_99e722e8f727f28d( params )
{
    if ( isplayer( self ) && self function_41360f0bcfc012aa() )
    {
        self cancelgrapple();
    }
}

// Namespace zm_grappling_hook
// Params 0, eflags: 0x4
// Checksum 0x93e30c2a, Offset: 0xc14
// Size: 0x56
function private function_c637efd20dd61aa6()
{
    self endon( #"death_or_disconnect" );
    grapplefxid = self.grapplefx;
    waitframe();
    
    while ( self function_41360f0bcfc012aa() )
    {
        zombie_utils::function_607ff821e430d594( self.origin, 64, 3 );
        wait 0.2;
    }
    
    if ( isdefined( grapplefxid ) )
    {
        function_10392a0d3005a35c( grapplefxid );
    }
}

// Namespace zm_grappling_hook
// Params 0, eflags: 0x4
// Checksum 0x4cf4e93b, Offset: 0xc72
// Size: 0x1e
function private function_c1fbff5a01d93691()
{
    self endon( #"disconnect" );
    wait 1;
    self.grappled_elite = undefined;
}

// Namespace zm_grappling_hook
// Params 4, eflags: 0x4
// Checksum 0x2209e722, Offset: 0xc98
// Size: 0x246
function private function_f71e0282600c77fa( zombie, chest_position, direction, speed )
{
    zombie val::set( "grappling_hook", "allow_give_point", 0 );
    zombie utility::callsharedfunc( #"zombie", #"hash_6c2d9080e508d382" );
    grapple_weapon_name = level.equipment.table[ "equip_grappling_hook" ].weaponname;
    grapple_weapon_object = makeweapon( grapple_weapon_name );
    zm_livingworld::livingworld_allow_dismember( zombie );
    
    if ( zombie zombie_dismemberment::is_dismemberment_allowed() )
    {
        zombie zombie_dismemberment::dismember_limb( 1, 31 );
    }
    
    impulse_force = speed ? 0.3 * speed : 256;
    impulse_vector = direction * impulse_force;
    function_df0d7efb44b35968( chest_position, 32, 32, impulse_vector );
    
    /#
        if ( getdvarint( @"grapple_debug", 0 ) )
        {
            line( chest_position, chest_position + impulse_vector, ( 0, 0, 1 ), 1, 0, 100 );
            sphere( chest_position, 32, ( 0, 0, 1 ), 1, 100 );
        }
    #/
    
    if ( zombie.is_living_world_ai && zombie utility::ent_flag( "scene_active" ) )
    {
        zombie val::nuke( "damage" );
        zombie val::nuke( "death" );
        zombie dodamage( zombie.health, zombie.origin );
    }
    else
    {
        zombie kill( zombie.origin, self, self, "MOD_UNKNOWN", grapple_weapon_object );
    }
    
    corpse = zombie getcorpseentity();
    
    if ( isdefined( corpse ) )
    {
        launchx = clamp( direction[ 0 ] * 9000, -12000, 12000 );
        launchy = clamp( direction[ 1 ] * 9000, -12000, 12000 );
        launchz = clamp( ( direction[ 2 ] + 150 ) * 1500, 0, 4000 );
        launch_impact = ( launchx, launchy, launchz );
        corpse startragdollfromimpact( "torso_upper", launch_impact );
        corpse playsound( #"hash_b1b7457eef342d59" );
    }
}

// Namespace zm_grappling_hook
// Params 5, eflags: 0x4
// Checksum 0x2bc98edd, Offset: 0xee6
// Size: 0x29f, Type: bool
function private function_e1a654e500af6545( zombie, hit_position, chest_position, direction, speed )
{
    var_2d19df60a9a657db = vectornormalize( chest_position - hit_position );
    hit_metabone = zombie metabone::function_2d9c443204521c97( hit_position, var_2d19df60a9a657db );
    
    if ( !hit_metabone )
    {
        character_contents = trace::create_contents( 1 );
        trace_results = trace::ray_trace_detail( hit_position, chest_position, self, character_contents );
        part_name = trace_results[ "partName" ];
        var_5beaff634c597287 = trace_results[ "hitLocation" ];
        
        if ( part_name )
        {
            hit_metabone = zombie metabone::function_927e17286f4e0a54( part_name, var_2d19df60a9a657db );
        }
        
        if ( !hit_metabone && var_5beaff634c597287 )
        {
            hit_metabone = zombie metabone::function_ddf2fd7b79c9d5b5( var_5beaff634c597287, var_2d19df60a9a657db );
        }
        
        /#
            if ( getdvarint( @"grapple_debug", 0 ) )
            {
                line( hit_position, chest_position, ( 1, 1, 0 ), 1, 0, 100 );
            }
        #/
    }
    
    if ( zombie metabone::is_metabone_armor( hit_metabone ) )
    {
        destroyed_armor = hit_metabone;
        
        /#
            if ( getdvarint( @"grapple_debug", 0 ) )
            {
                debugstar( hit_position, ( 1, 0, 0 ), 100, destroyed_armor, 0.25 );
            }
        #/
    }
    else
    {
        var_d906f3558dfa031f = zombie metabone::function_30d906ccb9fe2142( "Types_Armor" );
        
        if ( var_d906f3558dfa031f.size > 0 )
        {
            destroyed_armor = utility::array_random( var_d906f3558dfa031f );
            
            /#
                if ( getdvarint( @"grapple_debug", 0 ) )
                {
                    debugstar( hit_position, ( 1, 1, 0 ), 100, destroyed_armor, 0.25 );
                }
            #/
        }
    }
    
    if ( destroyed_armor )
    {
        zombie metabone::destroy_metabone( destroyed_armor, self, self, direction );
        impulse_force = speed ? 0.3 * speed : 256;
        impulse_vector = direction * impulse_force;
        function_df0d7efb44b35968( hit_position, 16, 16, impulse_vector );
        playsoundatpos( hit_position, #"hash_71bd127720dd9c11" );
        
        /#
            if ( getdvarint( @"grapple_debug", 0 ) )
            {
                line( hit_position, hit_position + impulse_vector, ( 0, 0, 1 ), 1, 0, 100 );
                sphere( hit_position, 16, ( 0, 0, 1 ), 1, 100 );
            }
        #/
        
        grapple_damage = zombie.maxhealth * 0.51;
        
        if ( grapple_damage < zombie.health )
        {
            zombie dodamage( grapple_damage, self.origin, self, self, "MOD_IMPACT", "<explicitweaponnone>", undefined, undefined, 65536 );
            return true;
        }
    }
    
    return false;
}

// Namespace zm_grappling_hook
// Params 1, eflags: 0x4
// Checksum 0x4c231277, Offset: 0x118e
// Size: 0xab
function private function_95cd598cc8ac06a5( zombie )
{
    current_time = gettime();
    
    if ( !zombie.var_5d3c11257b83dc0d || current_time >= zombie.var_5d3c11257b83dc0d + 10000 )
    {
        zombie.var_5d3c11257b83dc0d = gettime();
        zombie zombie_stun::stun_ai( 1 );
    }
    
    grapple_damage = zombie.maxhealth * 0.02;
    zombie dodamage( grapple_damage, self.origin, self, self, "MOD_IMPACT", "<explicitweaponnone>", undefined, undefined, 65536 );
    zombie playsound( #"hash_716326c0eba2fd81" );
}

// Namespace zm_grappling_hook
// Params 1, eflags: 0x4
// Checksum 0x73adfd8f, Offset: 0x1241
// Size: 0x93
function private function_99b96c8d67053c9c( params )
{
    if ( params.ref != "equip_grappling_hook" )
    {
        return;
    }
    
    if ( isplayer( params.player ) )
    {
        if ( params.player.ridingent )
        {
            params.player.ridingent callback::callback( "stop_riding", { #player:params.player } );
        }
        
        params.player thread function_16f8ef0747e5a78b();
    }
}

// Namespace zm_grappling_hook
// Params 0, eflags: 0x4
// Checksum 0x4e3d5f46, Offset: 0x12dc
// Size: 0x5e
function private function_16f8ef0747e5a78b()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_e8e0ec51826dda72" );
    val::set( "zm_grapple_cooldown", "offhand_secondary_weapons", 0 );
    var_afe8d3e3bd3b1bcc = getdvarfloat( @"hash_eafa968e6a0785af", 0.5 );
    wait var_afe8d3e3bd3b1bcc;
    val::reset( "zm_grapple_cooldown", "offhand_secondary_weapons" );
}

