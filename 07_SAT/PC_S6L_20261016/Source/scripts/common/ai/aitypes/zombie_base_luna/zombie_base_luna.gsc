// scripts\common\ai\aitypes\zombie_base_luna\zombie_base_luna.gsc  (hash_795bd561f18a6a00.gscc) (size: 8034 Bytes / 0x1f62 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7e83c14 (132660244)
// size ...... 8034 (0x1f62)
// includes .. 9   (offset: 0x1d3e)
// strings ... 27  (offset: 0x1d86)
// dev strs .. 0   (offset: 0x1f62)
// exports ... 12  (offset: 0x139e)
// cseg ...... 0x238 + 0x1166 (0x139e)
// imports ... 68  (offset: 0x157e)
// animtree1 . 0   (offset: 0x1f62)
// animtree2 . 0   (offset: 0x1f62)
#using script_16ea1b94f0f381b3;
#using script_214060780e647f61;
#using script_608016ec77eb8910;
#using scripts\common\ai\aitypes\shared\zombie\zombie_frost_aoe;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\status_effects\effect_frost;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_base_luna;

// Namespace zombie_base_luna
// Params 2
// Checksum 0x42ae9ec4, Offset: 0x256
// Size: 0xfb
function precache( classname, aitypescriptbundle )
{
    if ( utility::flag( "init_zombie_base_luna" ) )
    {
        return;
    }
    
    utility::flag_set( "init_zombie_base_luna" );
    specific_settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    element_info = namespace_10a0481b1db56804::register_elemental_storm( #"frost", specific_settings.var_f2aedb3acfdab4de, specific_settings.var_922929b1f3726d97, specific_settings.var_30f3be52bf2ad7e, specific_settings.var_9dab7b42c7392e86, &update_frost_storm, &function_4bd20e25c231f722 );
    element_info.damage = specific_settings.var_d4d20d6eae9a5504;
    element_info.tick_time_seconds = specific_settings.var_f5a3c83d5d3d9596;
    element_info.var_a57d5c336037ec4d = specific_settings.var_71ec21b8ca3420a3;
    callback::add( "on_" + aitypescriptbundle.subclass + "_spawned", &function_d84dc3343c2cd024 );
}

// Namespace zombie_base_luna
// Params 1, eflags: 0x4
// Checksum 0xe39fd3b8, Offset: 0x359
// Size: 0x181
function private function_d84dc3343c2cd024( params )
{
    if ( !level callback::exists( #"player_damaged", &function_59d32aeb813f48ba ) )
    {
        level callback::add( #"player_damaged", &function_59d32aeb813f48ba );
    }
    
    callback::add( "on_zombie_ai_killed", &function_88081eca94956113 );
    callback::add( "on_zombie_ai_damaged", &function_64f559b4dd120fcb );
    self.forceannihilate = 1;
    namespace_10a0481b1db56804::function_314bb0964f030c97( self, #"frost" );
    specific_settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( specific_settings.var_60930ceab02a469b == "super_sprint" || specific_settings.var_60930ceab02a469b == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && specific_settings.var_60930ceab02a469b == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && specific_settings.var_60930ceab02a469b == "sprint" ? "run" : specific_settings.var_60930ceab02a469b, "aitype_default", 0 );
    zombie_utils::function_dfae6a5bd222c586( &function_14161aa9687db72 );
}

// Namespace zombie_base_luna
// Params 1, eflags: 0x4
// Checksum 0x9884c98e, Offset: 0x4e2
// Size: 0x163
function private function_59d32aeb813f48ba( params )
{
    if ( params.eattacker.subclass === "zombie_base_luna" && params.smeansofdeath != "MOD_ELEMENTAL_COLD" && !self.var_48fc1f163fceea29 )
    {
        specific_struct = params.eattacker.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
        
        if ( !specific_struct.var_b464f392d1561a2e )
        {
            return;
        }
        
        var_fb482adaaa3d0f0 = 0;
        
        if ( !isdefined( self.luna_stacks ) )
        {
            self.luna_stacks = 0;
        }
        
        if ( self.var_77cd9d3c34be9e02 )
        {
            var_fb482adaaa3d0f0 = !utility::time_has_passed( self.var_77cd9d3c34be9e02, specific_struct.var_59410d77d0e2690c );
        }
        
        self.var_77cd9d3c34be9e02 = gettime();
        
        if ( var_fb482adaaa3d0f0 )
        {
            self.luna_stacks += 1;
        }
        else
        {
            self.luna_stacks = 1;
        }
        
        if ( specific_struct.var_8c3e32bd887071fb > 0 )
        {
            self.luna_stacks = min( self.luna_stacks, specific_struct.var_8c3e32bd887071fb );
        }
        
        if ( self.luna_stacks >= specific_struct.var_639bf129fc7bb9dc )
        {
            thread start_frost( params.eattacker, self );
        }
    }
}

// Namespace zombie_base_luna
// Params 2
// Checksum 0x12f46cfc, Offset: 0x64d
// Size: 0x13f
function start_frost( var_54efe4bf04430c1c, target )
{
    self notify( #"hash_749c5d087084bed0" );
    self endon( #"hash_749c5d087084bed0" );
    target endon( #"death" );
    specific_struct = var_54efe4bf04430c1c.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    var_54efe4bf04430c1c = undefined;
    
    if ( isplayer( target ) && isalive( target ) )
    {
        var_3c6e807ed3e7d6cd = specific_struct.var_591abf82fb3de952;
        additional_stacks = target.luna_stacks - specific_struct.var_639bf129fc7bb9dc;
        var_3c6e807ed3e7d6cd += additional_stacks * specific_struct.var_fed2b9e7c4769d22;
        target effect_frost::frost( "zombie_base_luna", var_3c6e807ed3e7d6cd );
    }
    
    if ( !target.luna_frost_attacker )
    {
        target.luna_frost_attacker = target utility::spawn_script_origin();
        target thread utility::delete_on_death( target.luna_frost_attacker );
    }
    
    process_frost( specific_struct, target );
    
    if ( isplayer( target ) )
    {
        target effect_frost::stop_frost( "zombie_base_luna" );
    }
    
    if ( target.luna_frost_attacker )
    {
        target.luna_frost_attacker delete();
    }
}

// Namespace zombie_base_luna
// Params 2, eflags: 0x4
// Checksum 0x86ffe1cf, Offset: 0x794
// Size: 0x197
function private process_frost( specific_struct, target )
{
    start_time = gettime();
    
    for ( last_health = target.health; true ; last_health = target.health )
    {
        target utility::ent_flag_waitopen_any( "luna_frost" );
        target utility::ent_flag_set( "luna_frost" );
        target thread utility::ent_flag_clear_delayed( "luna_frost", specific_struct.var_e128fdde30001981 );
        
        if ( target.health > last_health )
        {
            break;
        }
        
        if ( target.var_48fc1f163fceea29 )
        {
            break;
        }
        
        has_environmentalist = istrue( target utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_phd_flopper", #"phdflopper_safe_slide" ) );
        has_quick_revive = istrue( target utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_quickrevive" ) );
        time = specific_struct.var_19cc3c2e59f4bb;
        
        if ( has_environmentalist )
        {
            time *= specific_struct.var_d8c6689d49508792;
        }
        
        if ( has_quick_revive )
        {
            time *= specific_struct.var_9cbbbcf797be9cbc;
        }
        
        if ( utility::time_has_passed( start_time, time ) )
        {
            break;
        }
        
        damage = specific_struct.frostdamage;
        target dodamage( damage, target.origin, target.luna_frost_attacker, target.luna_frost_attacker, "MOD_ELEMENTAL_COLD" );
    }
}

// Namespace zombie_base_luna
// Params 1, eflags: 0x4
// Checksum 0x8e46cfb2, Offset: 0x933
// Size: 0x2b5
function private function_88081eca94956113( params )
{
    if ( val::get( "disable_elemental_effect" ) )
    {
        self.forceannihilate = undefined;
        return;
    }
    
    playsoundatpos( self.origin + ( 0, 0, 60 ), #"hash_7c6cc0664bab8626" );
    
    if ( !self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_6c7c89e4d3492f7b )
    {
        return;
    }
    
    var_46063ece3767f60b = self.origin;
    players = function_d63fe6a4c08ba6f5( var_46063ece3767f60b, self.var_d6894f01a36b4ff3.explosionradius, 200 );
    
    foreach ( player in players )
    {
        if ( self.var_d6894f01a36b4ff3.explosionshock )
        {
            player namespace_9d8e359c3b1041e5::shellshocksharedfunc( self.var_d6894f01a36b4ff3.explosionshock, #"damage", 0.35 );
        }
        
        player dodamage( self.var_d6894f01a36b4ff3.explosiondamage * ( self.var_fe048a2106d8ef00[ #"explosionattack" ] ?? 1 ), var_46063ece3767f60b, self, self, "MOD_EXPLOSIVE", undefined, "head" );
    }
    
    enemies = self function_f017e352a29a57a1( var_46063ece3767f60b, self.var_d6894f01a36b4ff3.explosionradius );
    ai_damage = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( var_46063ece3767f60b ) );
    
    foreach ( enemy in enemies )
    {
        if ( isai( enemy ) && !enemy zombie_utils::function_33a24849a0dfd13b() )
        {
            enemy dodamage( ai_damage, var_46063ece3767f60b, self, self, "MOD_EXPLOSIVE", undefined, "head", undefined, 1073741824 );
        }
    }
    
    if ( !self.var_368ce8ea173e338d )
    {
        thread zombie_frost_aoe::spawn_frost_aoe( self.owner ?? self, var_46063ece3767f60b, ( 0, 0, 0 ), "from_zombie_base_toxic", 10, self.var_d6894f01a36b4ff3.var_f5f521496718f0f1, 96 );
    }
}

// Namespace zombie_base_luna
// Params 1, eflags: 0x4
// Checksum 0x5f9c0f87, Offset: 0xbf0
// Size: 0x4e9
function private update_frost_storm( params )
{
    storm = params.storm;
    element_info = params.element_info;
    targets = function_51b8ce76eb43aed5( storm.source.origin, element_info.radius, element_info.height * 0.5, 1, 0, undefined, storm.team );
    damage_owner = params.cluster.valid_member;
    
    foreach ( target in targets )
    {
        has_environmentalist = istrue( target utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_phd_flopper", #"phdflopper_safe_slide" ) );
        var_dd1609612609230e = has_environmentalist && target issprintsliding();
        
        if ( target.var_48fc1f163fceea29 )
        {
            continue;
        }
        
        if ( !target utility::ent_flag( "frost_storm_damaged" ) )
        {
            target utility::ent_flag_set( "frost_storm_damaged" );
            target thread utility::ent_flag_clear_delayed( "frost_storm_damaged", element_info.tick_time_seconds );
            damage = element_info.damage * ( damage_owner.var_fe048a2106d8ef00[ #"frost_storm" ] ?? 1 );
            
            if ( !var_dd1609612609230e )
            {
                target dodamage( damage, storm.source.origin, damage_owner, storm.source, "MOD_ELEMENTAL_COLD", undefined, "none", undefined, 65536 );
            }
            
            if ( isplayer( target ) && isalive( target ) )
            {
                if ( !target utility::callsharedfunc( #"locust_ww", #"hash_5f2e6769ea79096e" ) && !level callback::response( 0, #"frost_protected", { #player:target } ) )
                {
                    target effect_frost::frost( "luna_frost_storm", element_info.var_a57d5c336037ec4d );
                }
                
                target thread utility::thread_on_notify( "frost_storm_damaged", &effect_frost::stop_frost, target, undefined, undefined, "luna_frost_storm" );
            }
        }
    }
    
    foreach ( ai in level.var_b6784f7a5cfd99a3 )
    {
        if ( !isalive( ai ) || ai.var_ce4d08748f6af2fa != #"frost" )
        {
            continue;
        }
        
        if ( ai val::get( "disable_elemental_effect" ) )
        {
            continue;
        }
        
        if ( distance2d( ai.origin, storm.source.origin ) > element_info.radius || abs( ai.origin[ 2 ] - storm.source.origin[ 2 ] ) > element_info.height * 0.5 )
        {
            continue;
        }
        
        ai.luna_frost_storm_last_update = gettime();
        
        if ( !ai.luna_frost_storm_buffed )
        {
            ai.luna_frost_storm_buffed = 1;
            specific_settings = ai.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
            ai zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( specific_settings.var_3b9378c3de2beac9 == "super_sprint" || specific_settings.var_3b9378c3de2beac9 == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && specific_settings.var_3b9378c3de2beac9 == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && specific_settings.var_3b9378c3de2beac9 == "sprint" ? "run" : specific_settings.var_3b9378c3de2beac9, "aitype_default", 0 );
            ai thread function_63d4442704c176f5();
        }
    }
}

// Namespace zombie_base_luna
// Params 0, eflags: 0xc
// Checksum 0xb85cb5da, Offset: 0x10e1
// Size: 0x15f
function private function_63d4442704c176f5()
{
    self notify( #"hash_b33465d9ee0f90b4" );
    self endon( #"hash_b33465d9ee0f90b4" );
    self endon( #"death" );
    specific_settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    
    while ( true )
    {
        waitframe();
        
        if ( utility::time_has_passed( self.luna_frost_storm_last_update, max( specific_settings.var_f5a3c83d5d3d9596 * 2, 0.25 ) ) )
        {
            self.luna_frost_storm_buffed = 0;
            zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( specific_settings.var_60930ceab02a469b == "super_sprint" || specific_settings.var_60930ceab02a469b == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && specific_settings.var_60930ceab02a469b == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && specific_settings.var_60930ceab02a469b == "sprint" ? "run" : specific_settings.var_60930ceab02a469b, "aitype_default", 0 );
            return;
        }
    }
}

// Namespace zombie_base_luna
// Params 1, eflags: 0x4
// Checksum 0xe16c5499, Offset: 0x1248
// Size: 0x5c
function private function_14161aa9687db72( params )
{
    if ( self.luna_frost_storm_buffed )
    {
        var_5d08975e4bdff18b = clamp( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_b22e32a2379569a9, 0, 1 );
        return ( params.idamage * ( 1 - var_5d08975e4bdff18b ) );
    }
    
    return -1;
}

// Namespace zombie_base_luna
// Params 1, eflags: 0x4
// Checksum 0xfd1dea41, Offset: 0x12ad
// Size: 0x9e
function private function_64f559b4dd120fcb( params )
{
    if ( params.var_5e5a2456deacd236 == "fire" || params.smeansofdeath == "MOD_FIRE" || params.smeansofdeath == "MOD_FIRE_BULLET" || params.smeansofdeath == "MOD_ELEMENTAL_FIRE" )
    {
        utility::ent_flag_set( "luna_fire_storm_immune" );
        thread utility::delaythreadendon( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_b18523ede6daa5de, "luna_fire_storm_immune", &utility::ent_flag_clear, "luna_fire_storm_immune" );
    }
}

// Namespace zombie_base_luna
// Params 1, eflags: 0x4
// Checksum 0x6e13e0e7, Offset: 0x1353
// Size: 0x4a, Type: bool
function private function_4bd20e25c231f722( ai )
{
    if ( ai.var_368ce8ea173e338d )
    {
        return false;
    }
    
    if ( ai utility::ent_flag( "luna_fire_storm_immune" ) )
    {
        return false;
    }
    
    if ( ai zombie_utils::function_bf1464d09f4e4b40() )
    {
        return false;
    }
    
    if ( ai mutant_injection_disciple_zombies::is_grabbed() )
    {
        return false;
    }
    
    return true;
}

