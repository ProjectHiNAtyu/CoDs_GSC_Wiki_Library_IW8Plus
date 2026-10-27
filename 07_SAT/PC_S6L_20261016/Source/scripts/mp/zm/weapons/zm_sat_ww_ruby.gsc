// scripts\mp\zm\weapons\zm_sat_ww_ruby.gsc  (hash_7a31930dec384c2a.gscc) (size: 15681 Bytes / 0x3d41 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeded56f3 (3991754483)
// size ...... 15681 (0x3d41)
// includes .. 8   (offset: 0x3989)
// strings ... 53  (offset: 0x39c9)
// dev strs .. 7   (offset: 0x3ced)
// exports ... 43  (offset: 0x23c9)
// cseg ...... 0x37c + 0x204d (0x23c9)
// imports ... 122 (offset: 0x2a81)
// animtree1 . 0   (offset: 0x3d41)
// animtree2 . 0   (offset: 0x3d41)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\weapons\ww_shared;

#namespace ww_ruby;

// Namespace ww_ruby
// Params 0, eflags: 0x5
// Checksum 0x8acf7618, Offset: 0x39a
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"ww_ruby", undefined, &pre_main, &post_main );
}

// Namespace ww_ruby
// Params 0, eflags: 0x4
// Checksum 0x27804b8d, Offset: 0x3bf
// Size: 0x9
function private pre_main()
{
    init();
}

// Namespace ww_ruby
// Params 0, eflags: 0x4
// Checksum 0x7589fb12, Offset: 0x3d0
// Size: 0x52
function private post_main()
{
    level.var_5c6a1be6410e35ff = [];
    utility::registersharedfunc( #"ww_ruby", #"hash_eacf089357dac29a", &function_5245c98dfe405b07 );
    utility::registersharedfunc( #"ww_ruby", #"hash_2bb2c25b0c628369", &function_ec45696ae0c9838a );
    
    /#
        function_e6db43c156bf5d9e();
    #/
}

// Namespace ww_ruby
// Params 1, eflags: 0x4
// Checksum 0x279c44d0, Offset: 0x42a
// Size: 0x62
function private function_5245c98dfe405b07( params )
{
    if ( !isent( params.obj ) && !params.obj isscriptable() )
    {
        assert( 0, "<dev string:x24>" );
        return;
    }
    
    level.var_5c6a1be6410e35ff[ level.var_5c6a1be6410e35ff.size ] = params.obj;
}

// Namespace ww_ruby
// Params 1, eflags: 0x4
// Checksum 0xe88f5c31, Offset: 0x494
// Size: 0x63
function private function_ec45696ae0c9838a( params )
{
    if ( !isent( params.obj ) && !params.obj isscriptable() )
    {
        assert( 0, "<dev string:x4d>" );
        return;
    }
    
    level.var_5c6a1be6410e35ff = arrayremove( level.var_5c6a1be6410e35ff, params.obj );
}

// Namespace ww_ruby
// Params 0, eflags: 0x4
// Checksum 0x572a05c9, Offset: 0x4ff
// Size: 0x113
function private init()
{
    if ( !isdefined( weapon_name ) )
    {
        weapon_name = utility::get_scripted_weapon_name( #"ufo_gun" );
    }
    
    level.var_ae556c4438969a6b = weapon_name;
    level callback::add( #"player_weapon_change", &rubyww_on_weapon_change );
    level callback::add( "killed_body_cloned", &clean_corpse );
    level zombie_utils::function_dfae6a5bd222c586( &function_3e84bb338b4e6617 );
    
    if ( !level callback::exists( #"item_weapon_picked_up", &on_pickup_wwruby ) )
    {
        level callback::add( #"item_weapon_picked_up", &on_pickup_wwruby );
    }
    
    if ( !level callback::exists( #"player_weapon_give", &on_give_wwruby ) )
    {
        level callback::add( #"player_weapon_give", &on_give_wwruby );
    }
    
    level.var_c06318765e19f55f = trace::create_contents( 0, 1, 0, 1 );
    level callback::add( "on_add_pap_attachments", &on_add_pap_attachments, weapon_name );
    callback::add( #"player_spawned", &on_player_spawned );
    callback::add( #"hash_eee96f780807d870", &function_b0f156fc0ed522a5 );
}

// Namespace ww_ruby
// Params 1, eflags: 0x4
// Checksum 0x91fbb943, Offset: 0x61a
// Size: 0x5d
function private on_player_spawned( params )
{
    self.var_36b82b69658ac2c6 = 1;
    
    if ( isweapon( params.weapon ) && params.weapon.basename != level.var_ae556c4438969a6b )
    {
        utility::function_7c10ea82c1e305b8( "ww_ruby_ambient", "off" );
    }
}

// Namespace ww_ruby
// Params 1, eflags: 0x4
// Checksum 0xd3d6a0fa, Offset: 0x67f
// Size: 0xa3
function private function_3e84bb338b4e6617( params )
{
    if ( params.eattacker && params.objweapon.basename == level.var_ae556c4438969a6b && params.idamage >= self.health )
    {
        if ( params.eattacker ww_shared::get_ww_player_data( level.var_ae556c4438969a6b ).is_pap )
        {
            utility::ent_flag_set( "glow_fade_away_pap" );
        }
        else
        {
            utility::ent_flag_set( "glow_fade_away" );
        }
    }
    
    return params.idamage;
}

// Namespace ww_ruby
// Params 1, eflags: 0x4
// Checksum 0x6aae1fea, Offset: 0x72b
// Size: 0x8b
function private clean_corpse( params )
{
    if ( params.eattacker.currentweapon.basename == level.var_ae556c4438969a6b )
    {
        if ( params.aicategory != "normal" )
        {
            return;
        }
        
        body = zombie_utils::function_4e99fb1239980783( params );
        
        if ( body )
        {
            body endon( #"corpse_deleted" );
            body function_dd258a3da9a2b4a1( 5 );
            wait 5;
            
            if ( body )
            {
                body delete();
            }
        }
    }
}

// Namespace ww_ruby
// Params 1, eflags: 0x4
// Checksum 0xd499c268, Offset: 0x7be
// Size: 0x35
function private function_b6759d5040e13258( str )
{
    return ww_shared::get_ww_player_data( level.var_ae556c4438969a6b ).is_pap ? str + "_pap" : str;
}

// Namespace ww_ruby
// Params 1, eflags: 0x4
// Checksum 0x91489694, Offset: 0x7fc
// Size: 0x142
function private rubyww_on_weapon_change( params )
{
    if ( !isweapon( params.weapon ) )
    {
        return;
    }
    
    if ( params.weapon.basename == level.var_ae556c4438969a6b )
    {
        thread function_3c44feb44bb45855();
        data = ww_shared::get_ww_player_data( level.var_ae556c4438969a6b );
        data.is_pap = utility::callsharedfunc( #"zombie", #"get_pap_level", params.weapon ) > 0;
        thread ww_shared::function_3472b693f638483a( level.var_ae556c4438969a6b, "ww_ruby_ambient", function_b6759d5040e13258( "on" ), "off", 0.9 );
        thread monitor_weapon_switch();
        
        if ( self.var_36b82b69658ac2c6 )
        {
            clip_size = weaponclipsize( params.weapon );
            self setweaponammoclip( params.weapon, clip_size );
            self.var_36b82b69658ac2c6 = 0;
        }
        
        return;
    }
    
    self notify( #"hash_55bd6ee279035ae9" );
    thread ww_shared::function_50a43e11790d1a15( level.var_ae556c4438969a6b, "ww_ruby_ambient", "off" );
    utility::function_32b24db3127bff40( "ww_ruby_replenish", "off" );
}

// Namespace ww_ruby
// Params 0, eflags: 0xc
// Checksum 0xd0a39fd8, Offset: 0x946
// Size: 0x59
function private monitor_weapon_switch()
{
    self notify( #"hash_184cd95a7e91a43e" );
    self endon( #"hash_184cd95a7e91a43e" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_55bd6ee279035ae9" );
    
    while ( true )
    {
        self waittill( #"weapon_switch_started" );
        utility::function_32b24db3127bff40( "ww_ruby_replenish", "off" );
        waitframe();
    }
}

// Namespace ww_ruby
// Params 1, eflags: 0x4
// Checksum 0x85cd049, Offset: 0x9a7
// Size: 0x54
function private function_b0f156fc0ed522a5( params )
{
    weaponobj = params.objweapon;
    
    if ( weaponobj.basename == level.var_ae556c4438969a6b )
    {
        clip_size = weaponclipsize( weaponobj );
        self setweaponammoclip( weaponobj, clip_size );
    }
}

// Namespace ww_ruby
// Params 1, eflags: 0x4
// Checksum 0x85e9fad6, Offset: 0xa03
// Size: 0x7a
function private on_pickup_wwruby( params )
{
    if ( params.item.weaponobj.basename == level.var_ae556c4438969a6b )
    {
        clip_size = weaponclipsize( params.item.weaponobj );
        self setweaponammoclip( params.item.weaponobj, clip_size );
    }
}

// Namespace ww_ruby
// Params 1, eflags: 0x4
// Checksum 0x7fa09585, Offset: 0xa85
// Size: 0x4c
function private on_give_wwruby( params )
{
    if ( isweapon( params.weapon ) && params.weapon.basename == level.var_ae556c4438969a6b )
    {
        self.var_36b82b69658ac2c6 = 1;
    }
}

// Namespace ww_ruby
// Params 3, eflags: 0x4
// Checksum 0x1f5e3841, Offset: 0xad9
// Size: 0x40
function private function_74a40eb437c0c86d( offset_foward, var_5daf71431dd688bf, offset_up )
{
    target_position = rotatevector( ( offset_foward, var_5daf71431dd688bf, offset_up ), self getplayerangles() );
    return self getvieworigin() + target_position;
}

// Namespace ww_ruby
// Params 0, eflags: 0x4
// Checksum 0x16ab9abc, Offset: 0xb22
// Size: 0x43
function private get_squadron_start_position()
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( self getcamerathirdperson() )
    {
        start = self gettagorigin( "tag_flash", 1 );
    }
    else
    {
        start = function_74a40eb437c0c86d( 50, -2, -3 );
    }
    
    return start;
}

// Namespace ww_ruby
// Params 0, eflags: 0xc
// Checksum 0x5a2663d6, Offset: 0xb6d
// Size: 0x159
function private function_3c44feb44bb45855()
{
    self notify( #"hash_1be158967896fe18" );
    self endon( #"hash_1be158967896fe18" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_55bd6ee279035ae9" );
    
    while ( true )
    {
        self waittill( #"weapon_fired", weapon );
        
        if ( weapon.basename == level.var_ae556c4438969a6b )
        {
            squadron = spawnstruct();
            position = get_squadron_start_position();
            
            if ( !position )
            {
                continue;
            }
            
            squadron.angles = self getplayerangles();
            squadron.entity = utility::spawn_model( %"wpn_sat_wm_ww_ruby_squadron", position, squadron.angles );
            squadron.target = undefined;
            squadron.owner = self;
            squadron.weapon = weapon;
            squadron.fov_start = self geteye();
            squadron.launch_origin = self.origin;
            
            if ( !isdefined( self.var_c4e968598d81f3a5 ) )
            {
                self.var_c4e968598d81f3a5 = [];
            }
            
            self.var_c4e968598d81f3a5[ self.var_c4e968598d81f3a5.size ] = squadron;
            squadron thread launch();
        }
    }
}

// Namespace ww_ruby
// Params 0, eflags: 0x4
// Checksum 0xa4241f47, Offset: 0xcce
// Size: 0x84
function private launch()
{
    level endon( #"game_ended" );
    self.owner endon( #"death_or_disconnect" );
    self.target = function_9b34148faddde308();
    reached_target = march();
    
    if ( reached_target )
    {
        if ( function_927d86585b9a5ff7( self.target ) )
        {
            attack();
        }
        else if ( function_d13816ca24711db7( self.target ) )
        {
            revolve();
        }
    }
    
    function_3725c7548be11ee4();
}

// Namespace ww_ruby
// Params 1, eflags: 0x4
// Checksum 0xbcc39316, Offset: 0xd5a
// Size: 0x1b
function private function_d13816ca24711db7( target )
{
    return arraycontains( level.var_5c6a1be6410e35ff, target );
}

// Namespace ww_ruby
// Params 1, eflags: 0x4
// Checksum 0x5b68b6a9, Offset: 0xd7e
// Size: 0x17f, Type: bool
function private function_927d86585b9a5ff7( target )
{
    if ( function_d13816ca24711db7( target ) )
    {
        return false;
    }
    
    if ( target.classname != "scriptable" )
    {
        if ( isagent( target ) && utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
        {
            if ( !utility::callsharedfunc( #"zm", #"hash_8e5cbc74839b479b", self.owner, target ) )
            {
                return false;
            }
        }
        else if ( isplayer( target ) && utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
        {
            if ( !utility::callsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4", self.owner, target ) )
            {
                return false;
            }
        }
    }
    
    if ( target.type == "zombie" )
    {
        if ( isalive( target ) && target.team != self.owner.team && !target.ignore_ufogun )
        {
            return true;
        }
    }
    else if ( isstartstr( target.type, "zm_loot_crystal" ) )
    {
        if ( target getscriptablepartstate( "loot_crystal" ) == "healthy" )
        {
            return true;
        }
    }
    else if ( target.type == "sat_zm_relic_event_mr_peeks" )
    {
        if ( target getscriptablepartstate( "damage" ) == "alive" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ww_ruby
// Params 1, eflags: 0x4
// Checksum 0xf4d417f9, Offset: 0xf06
// Size: 0x44
function private get_damage_source_position( target )
{
    if ( isent( target ) )
    {
        if ( target tagexists( "j_spine4" ) )
        {
            return target gettagorigin( "j_spine4" );
        }
        else
        {
            return target getcentroid();
        }
    }
    
    return target.origin;
}

// Namespace ww_ruby
// Params 1, eflags: 0x4
// Checksum 0xc26e7922, Offset: 0xf53
// Size: 0x34
function private function_f4cdb58d37033114( target )
{
    if ( !isent( target ) )
    {
        return;
    }
    
    if ( target tagexists( "j_spine4" ) )
    {
        return "j_spine4";
    }
    
    return "tag_origin";
}

// Namespace ww_ruby
// Params 0, eflags: 0x4
// Checksum 0xcc20aa71, Offset: 0xf8f
// Size: 0x259
function private march()
{
    reached_target = 0;
    self.entity utility::function_32b24db3127bff40( "form", self.owner function_b6759d5040e13258( "marching" ) );
    var_5f3ff598ed8f4108 = 50;
    var_b89ef3468d874c96 = squared( var_5f3ff598ed8f4108 );
    start_pos_snapshot = self.entity.origin;
    squadron_range = self.weapon.weaponcustomsettings.ufosquadron.range;
    
    while ( distancesquared( self.entity.origin, start_pos_snapshot ) < squadron_range * squadron_range )
    {
        if ( self.target )
        {
            if ( function_927d86585b9a5ff7( self.target ) || function_d13816ca24711db7( self.target ) )
            {
                squadron_pos = self.entity.origin;
                var_f3f6040025ee64ad = get_damage_source_position( self.target );
                
                if ( distancesquared( squadron_pos, var_f3f6040025ee64ad ) > var_b89ef3468d874c96 )
                {
                    move_distance = min( var_5f3ff598ed8f4108, distance( squadron_pos, var_f3f6040025ee64ad ) );
                    self.entity moveby( vectornormalize( var_f3f6040025ee64ad - squadron_pos ) * move_distance, 0.05 );
                }
                else
                {
                    if ( isent( self.target ) )
                    {
                        self.entity linkto( self.target, function_f4cdb58d37033114( self.target ) );
                    }
                    
                    reached_target = 1;
                    break;
                }
            }
            else
            {
                break;
            }
        }
        else
        {
            cast_start = self.entity.origin;
            forward = anglestoforward( self.angles );
            cast_end = cast_start + forward * var_5f3ff598ed8f4108;
            cast_results = physics_raycast( cast_start, cast_end, level.var_c06318765e19f55f, undefined, 0, "physicsquery_closest", 1 );
            
            if ( cast_results.size > 0 )
            {
                break;
            }
            
            self.entity moveby( forward * var_5f3ff598ed8f4108, 0.05 );
        }
        
        wait 0.05;
    }
    
    if ( !reached_target )
    {
        squadron_return();
    }
    
    return reached_target;
}

// Namespace ww_ruby
// Params 0, eflags: 0x4
// Checksum 0x4a44f402, Offset: 0x11f1
// Size: 0xac
function private revolve()
{
    if ( self.target )
    {
        self.target callback::callback( "ww_ruby_revolve_start", { #target:self.target } );
        self.entity utility::function_32b24db3127bff40( "form", self.owner function_b6759d5040e13258( "attacking_sm" ) );
        wait self.weapon.weaponcustomsettings.revolvetimelimit;
        self.target callback::callback( "ww_ruby_revolve_end", { #target:self.target } );
        squadron_return();
    }
}

// Namespace ww_ruby
// Params 5, eflags: 0x4
// Checksum 0x38eef160, Offset: 0x12a5
// Size: 0x205
function private function_437727a930b9d163( origin, radius, damage, attacker, weapon )
{
    if ( !isdefined( level.wwruby_damage_throttle ) )
    {
        level.wwruby_damage_throttle = throttle::throttle_initialize( "wwruby_damage", 4 );
    }
    
    ents = getaiarrayinradius( origin, radius );
    
    foreach ( ent in ents )
    {
        if ( !function_927d86585b9a5ff7( ent ) )
        {
            continue;
        }
        
        queue_entry = spawnstruct();
        throttle::throttle_wait_in_queue( level.wwruby_damage_throttle, queue_entry );
        
        if ( !function_927d86585b9a5ff7( ent ) )
        {
            continue;
        }
        
        ent dodamage( damage, get_damage_source_position( ent ), attacker, attacker, "MOD_RIFLE_BULLET", weapon, "torso_upper" );
    }
    
    if ( level.a_loot_crystals )
    {
        foreach ( var_d02ad6c664efd3e0 in level.a_loot_crystals )
        {
            if ( distancesquared( var_d02ad6c664efd3e0.origin, origin ) <= squared( radius ) )
            {
                var_d02ad6c664efd3e0 scriptabledodamage( damage );
            }
        }
    }
    
    if ( level.relic_mr_peeks )
    {
        if ( distancesquared( level.relic_mr_peeks.origin, origin ) <= squared( radius ) )
        {
            level.relic_mr_peeks scriptabledodamage( damage );
        }
    }
}

// Namespace ww_ruby
// Params 1, eflags: 0x4
// Checksum 0x74ef3f3a, Offset: 0x14b2
// Size: 0xd2
function private get_target_size( target )
{
    if ( !isent( target ) )
    {
        return "sm";
    }
    
    if ( target.aicategory == "boss" )
    {
        if ( target.subclass == "zombie_neptune" && target.model == "c_sat_zmb_neptune_3" )
        {
            return "xxl";
        }
        
        return "xl";
    }
    
    if ( target.aicategory == "hvt" || target.aicategory == "elite" || target.aicategory == "special" )
    {
        return "lg";
    }
    
    if ( target.aicategory == "normal" )
    {
        return "md";
    }
    
    return "sm";
}

// Namespace ww_ruby
// Params 0, eflags: 0x4
// Checksum 0x836f576f, Offset: 0x158c
// Size: 0x292
function private attack()
{
    target_size = get_target_size( self.target );
    
    if ( target_size == "xxl" )
    {
        self.entity utility::function_32b24db3127bff40( "form", self.owner function_b6759d5040e13258( "attacking_xxl" ) );
    }
    else if ( target_size == "xl" )
    {
        self.entity utility::function_32b24db3127bff40( "form", self.owner function_b6759d5040e13258( "attacking_xl" ) );
    }
    else if ( target_size == "lg" )
    {
        self.entity utility::function_32b24db3127bff40( "form", self.owner function_b6759d5040e13258( "attacking_lg" ) );
    }
    else if ( target_size == "md" )
    {
        self.entity utility::function_32b24db3127bff40( "form", self.owner function_b6759d5040e13258( "attacking_md" ) );
    }
    else
    {
        self.entity utility::function_32b24db3127bff40( "form", self.owner function_b6759d5040e13258( "attacking_sm" ) );
    }
    
    for ( i = 0; i < self.weapon.weaponcustomsettings.var_419d75552cb91d25 / self.weapon.weaponcustomsettings.var_5bb9f78b58ad63bd ; i++ )
    {
        if ( !self.owner )
        {
            break;
        }
        
        var_2cb9fba4482b9d09 = self.weapon.weaponcustomsettings.var_3238c5abe60ca7fe ?? 500;
        function_437727a930b9d163( self.target.origin, self.weapon.weaponcustomsettings.var_c86ed46ac4780eeb, var_2cb9fba4482b9d09, self.owner, self.weapon );
        
        if ( !function_927d86585b9a5ff7( self.target ) || distancesquared( self.entity.origin, get_damage_source_position( self.target ) ) > squared( self.weapon.weaponcustomsettings.ufosquadron.range ) )
        {
            squadron_return();
            return;
        }
        
        wait self.weapon.weaponcustomsettings.var_5bb9f78b58ad63bd;
    }
    
    squadron_return();
}

// Namespace ww_ruby
// Params 0, eflags: 0x4
// Checksum 0x888102c7, Offset: 0x1826
// Size: 0x274
function private squadron_return()
{
    self.owner endon( #"death_or_disconnect" );
    callback::callback( "ww_ruby_revolve_end", { #target:self.target } );
    
    if ( self.entity )
    {
        target_size = get_target_size( self.target );
        
        if ( target_size == "xxl" )
        {
            self.entity utility::function_32b24db3127bff40( "form", self.owner function_b6759d5040e13258( "disappearing_xxl" ) );
        }
        else if ( target_size == "xl" )
        {
            self.entity utility::function_32b24db3127bff40( "form", self.owner function_b6759d5040e13258( "disappearing_xl" ) );
        }
        else if ( target_size == "lg" )
        {
            self.entity utility::function_32b24db3127bff40( "form", self.owner function_b6759d5040e13258( "disappearing_lg" ) );
        }
        else if ( target_size == "md" )
        {
            self.entity utility::function_32b24db3127bff40( "form", self.owner function_b6759d5040e13258( "disappearing_md" ) );
        }
        else
        {
            self.entity utility::function_32b24db3127bff40( "form", self.owner function_b6759d5040e13258( "disappearing_sm" ) );
        }
        
        self.warp_back_entity = utility::spawn_model( %"wpn_sat_wm_ww_ruby_squadron", self.entity.origin, self.owner getplayerangles() + ( 0, 180, 0 ) );
        self.warp_back_entity utility::function_32b24db3127bff40( "form", self.owner function_b6759d5040e13258( "warping_back" ) );
        
        if ( self.owner getcamerathirdperson() && self.owner tagexists( "tag_flash" ) )
        {
            squadron_return_pos = self.owner gettagorigin( "tag_flash" );
        }
        else
        {
            squadron_return_pos = self.owner function_74a40eb437c0c86d( 0, 0, -2 );
        }
        
        warp_duration = self.weapon.weaponcustomsettings.var_1ab0f0de0762225b ?? 0.25;
        self.warp_back_entity moveto( squadron_return_pos, warp_duration );
        wait warp_duration;
        replenish();
    }
}

// Namespace ww_ruby
// Params 0, eflags: 0x4
// Checksum 0x61dfb2c9, Offset: 0x1aa2
// Size: 0xea
function private replenish()
{
    level endon( #"game_ended" );
    self.owner endon( #"death_or_disconnect" );
    data = self.owner ww_shared::get_ww_player_data( level.var_ae556c4438969a6b );
    
    if ( !data.is_switching )
    {
        self.owner utility::function_32b24db3127bff40( "ww_ruby_replenish", self.owner function_b6759d5040e13258( "on" ) );
    }
    
    wait self.weapon.weaponcustomsettings.landingtime + self.weapon.weaponcustomsettings.var_a942870dc311c4fc;
    self.owner setweaponammoclip( self.weapon, self.owner getweaponammoclip( self.weapon ) + 1 );
}

// Namespace ww_ruby
// Params 0, eflags: 0x4
// Checksum 0xa6fd5fb6, Offset: 0x1b94
// Size: 0x62
function private function_3725c7548be11ee4()
{
    self.owner.var_c4e968598d81f3a5 = arrayremove( self.owner.var_c4e968598d81f3a5, self );
    
    if ( self.entity )
    {
        self.entity delete();
    }
    
    if ( self.warp_back_entity )
    {
        self.warp_back_entity delete();
    }
}

// Namespace ww_ruby
// Params 2, eflags: 0x4
// Checksum 0x52db3756, Offset: 0x1bfe
// Size: 0xb2, Type: bool
function private is_reachable( ent, cos_fov )
{
    if ( !ent || !ent.origin )
    {
        return false;
    }
    
    if ( withinfov( self.fov_start, self.angles, ent.origin, cos_fov ) )
    {
        return true;
    }
    
    if ( self.entity )
    {
        var_5f3ff598ed8f4108 = 50;
        var_4da7970f239e053 = distancesquared( self.entity.origin, ent.origin );
        
        if ( var_4da7970f239e053 <= squared( var_5f3ff598ed8f4108 / 2 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ww_ruby
// Params 1, eflags: 0x4
// Checksum 0xb69ed640, Offset: 0x1cb9
// Size: 0x76, Type: bool
function private function_fd390314b2ed67af( ent )
{
    if ( !ent || !ent.origin )
    {
        return false;
    }
    
    if ( distancesquared( self.launch_origin, ent.origin ) > squared( 800 ) )
    {
        return false;
    }
    
    if ( withinfov( self.fov_start, self.angles, ent.origin, 0.996195 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ww_ruby
// Params 3, eflags: 0x4
// Checksum 0xe75355c, Offset: 0x1d38
// Size: 0x41
function private function_2ceeaa38e922cec( start, angles, fov )
{
    end_origin = self.origin;
    return withinfov2d( start, angles, end_origin, cos( fov ) );
}

// Namespace ww_ruby
// Params 2, eflags: 0x4
// Checksum 0x5524b8ab, Offset: 0x1d82
// Size: 0x26
function private function_33dc74eb3206973b( start_pos, target_ent )
{
    if ( !target_ent )
    {
        return 0;
    }
    
    return utility::can_trace_to_ai( start_pos, target_ent );
}

// Namespace ww_ruby
// Params 2, eflags: 0x4
// Checksum 0xb24b87f9, Offset: 0x1db1
// Size: 0xdf
function private function_d476f96e14f19495( radius, fov )
{
    ents = [];
    ents_in_radius = getaiarrayinradius( self.launch_origin, radius );
    
    foreach ( ent in ents_in_radius )
    {
        if ( ent function_2ceeaa38e922cec( self.fov_start, self.angles, fov ) && function_33dc74eb3206973b( self.fov_start, ent ) )
        {
            ents[ ents.size ] = ent;
        }
    }
    
    return ents;
}

// Namespace ww_ruby
// Params 2, eflags: 0x4
// Checksum 0x3410c9f5, Offset: 0x1e99
// Size: 0x26a
function private function_8eab07fb877fce9b( radius, fov )
{
    closest_target = undefined;
    closest_distance_squared = squared( radius );
    ents = function_d476f96e14f19495( radius, fov );
    cos_fov = abs( cos( fov ) );
    
    if ( isdefined( level.a_loot_crystals ) )
    {
        foreach ( var_d02ad6c664efd3e0 in level.a_loot_crystals )
        {
            if ( is_reachable( var_d02ad6c664efd3e0, cos_fov ) )
            {
                ents[ ents.size ] = var_d02ad6c664efd3e0;
            }
        }
    }
    
    if ( level.relic_mr_peeks )
    {
        if ( is_reachable( level.relic_mr_peeks, cos_fov ) )
        {
            ents[ ents.size ] = level.relic_mr_peeks;
        }
    }
    
    foreach ( var_61a33860ffa3d1a0 in level.var_5c6a1be6410e35ff )
    {
        if ( is_reachable( var_61a33860ffa3d1a0, cos_fov ) && function_fd390314b2ed67af( var_61a33860ffa3d1a0 ) )
        {
            ents[ ents.size ] = var_61a33860ffa3d1a0;
        }
    }
    
    foreach ( ent in ents )
    {
        if ( !function_927d86585b9a5ff7( ent ) && !arraycontains( level.var_5c6a1be6410e35ff, ent ) )
        {
            continue;
        }
        
        distance_squared = distancesquared( self.entity.origin, ent.origin );
        
        if ( distance_squared < closest_distance_squared )
        {
            closest_distance_squared = distance_squared;
            closest_target = ent;
        }
    }
    
    return closest_target;
}

// Namespace ww_ruby
// Params 0, eflags: 0x4
// Checksum 0xf6b859d1, Offset: 0x210c
// Size: 0xbf
function private function_9b34148faddde308()
{
    target = function_8eab07fb877fce9b( self.weapon.weaponcustomsettings.targetingcone.closeradius, self.weapon.weaponcustomsettings.targetingcone.closefov );
    
    if ( !isdefined( target ) )
    {
        target = function_8eab07fb877fce9b( self.weapon.weaponcustomsettings.targetingcone.normalradius, self.weapon.weaponcustomsettings.targetingcone.normalfov );
    }
    
    return target;
}

// Namespace ww_ruby
// Params 2, eflags: 0x4
// Checksum 0x54b021fe, Offset: 0x21d4
// Size: 0x109
function private on_add_pap_attachments( params, weapon_name )
{
    if ( !isweapon( params.weapon ) || params.weapon.basename != weapon_name )
    {
        return;
    }
    
    if ( params.weapon canuseattachment( "sat_rec_ww_ruby_pap" ) )
    {
        index = function_f02c63b99c9614c9( params.attachments, "sat_rec_ww_ruby" );
        
        if ( isdefined( index ) )
        {
            var_fd98dfe6f63a2c95 = params.var_f1614eef81f0bdd2[ "sat_rec_ww_ruby" ];
            params.attachments[ index ] = undefined;
            params.attachments = function_5713d46873b29625( params.attachments );
            params.attachments[ params.attachments.size ] = "sat_rec_ww_ruby_pap";
            params.var_f1614eef81f0bdd2[ "sat_rec_ww_ruby_pap" ] = var_fd98dfe6f63a2c95;
            params.var_f1614eef81f0bdd2[ "sat_rec_ww_ruby" ] = undefined;
        }
    }
}

/#

    // Namespace ww_ruby
    // Params 0
    // Checksum 0xdd9c9b93, Offset: 0x22e5
    // Size: 0x2e, Type: dev
    function function_e6db43c156bf5d9e()
    {
        devgui::function_9082edeb5db93280( "<dev string:x78>" );
        devgui::add_devgui_func( "<dev string:x8f>", "<dev string:xa1>", &function_366f34a5ed926517 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ww_ruby
    // Params 0
    // Checksum 0x6c4407ed, Offset: 0x231b
    // Size: 0x47, Type: dev
    function function_366f34a5ed926517()
    {
        if ( level.var_c9f24514dc9b3d )
        {
            level.var_c9f24514dc9b3d = 0;
        }
        else
        {
            level.var_c9f24514dc9b3d = 1;
        }
        
        iprintlnbold( level.var_c9f24514dc9b3d ? "<dev string:xba>" : "<dev string:xd1>" );
    }

    // Namespace ww_ruby
    // Params 2
    // Checksum 0xc1bc4aeb, Offset: 0x236a
    // Size: 0x5f, Type: dev
    function function_7d7e131b2a5b6fb8( msg, color )
    {
        if ( !level.var_c9f24514dc9b3d )
        {
            return;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        print3d( self.origin + ( 0, 0, 60 ), msg, color, 1, 1, 40 );
    }

#/
