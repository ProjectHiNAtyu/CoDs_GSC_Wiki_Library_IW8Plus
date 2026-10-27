// script_652df41e2fd0fe80  (hash_652df41e2fd0fe80.gscc) (size: 10542 Bytes / 0x292e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa10687a4 (2701559716)
// size ...... 10542 (0x292e)
// includes .. 24  (offset: 0x2616)
// strings ... 46  (offset: 0x26d6)
// dev strs .. 0   (offset: 0x292e)
// exports ... 13  (offset: 0x1906)
// cseg ...... 0x38b + 0x157b (0x1906)
// imports ... 94  (offset: 0x1b0e)
// animtree1 . 0   (offset: 0x292e)
// animtree2 . 0   (offset: 0x292e)
#using script_12c13822ade2c7b7;
#using script_16ea1b94f0f381b3;
#using script_3233cd241127112b;
#using script_359c9cda9983c8fc;
#using script_3a014b542599e1e;
#using script_3d224bcd5ba96094;
#using script_670486d63d6d8151;
#using script_675ee9e46245ef85;
#using script_69e82e1f2f6d8101;
#using script_7b4d6e13aa956aac;
#using script_afb92aa9b64cf81;
#using script_afbad667a4b21ca;
#using scripts\asm\asm_bb;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\agents\nearby_player_scaling;
#using scripts\mp\common\utility\player;

#namespace zombie_triton;

// Namespace zombie_triton
// Params 2
// Checksum 0xe309a4db, Offset: 0x3a9
// Size: 0x58
function precache( classname, aitypescriptbundle )
{
    var_4b4d72d84afd1ebd = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( var_4b4d72d84afd1ebd ) )
    {
        utility::add_fx( "zombie_triton_damage_impact_weakspot", var_4b4d72d84afd1ebd.var_2bf4dfb07dd1dd28 );
        zombie_triton_foot_stomp::function_b003b34aadc2c3a0( var_4b4d72d84afd1ebd );
        zombie_triton_leap_slam::function_5b0ef362924bacb0( var_4b4d72d84afd1ebd );
    }
}

// Namespace zombie_triton
// Params 1, eflags: 0x4
// Checksum 0x738eb155, Offset: 0x409
// Size: 0x83
function private function_e7a558259e9b4ef3( params )
{
    zombie_boss_healthbar::function_f50a10314e72caa1();
    zombie_triton_targeting::function_4116d6da87f957b8();
    zombie_triton_impact::init_zombie_triton_impact_global();
    zombie_triton_foot_stomp::function_199685f339d4c809();
    zombie_triton_ground_slam::function_32e09d850510adf2();
    zombie_triton_leap_slam::function_8c574e3645d9a0d7();
    zombie_triton_lava_toss::function_866c3345b46d0129();
    zombie_triton_hibernation::function_55532305c3a5adc4();
    zombie_triton_audio::function_de4b52c5108673f3();
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    
    /#
        namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_e3e0353328bd5372", &namespace_af6379f1aba0301c::function_7b1238de9631111a );
    #/
}

// Namespace zombie_triton
// Params 1
// Checksum 0xb32e98f3, Offset: 0x494
// Size: 0x190
function function_2d7ed0e5caf24240( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ) );
    callback::add( "on_first_ai_init", &function_e7a558259e9b4ef3 );
    self function_10006c8216ad87fd( "focus_behaviors", "fsm", "no_focus" );
    val::set( "zombie_triton_init", "high_net_lod", 1 );
    self function_43a971093c992365( 1 );
    self enabletraversals( 0 );
    self pushplayer( 1 );
    self disableaimassist();
    zombie_utils::function_dfae6a5bd222c586( &function_de228bb88cf576a3 );
    nearby_player_scaling::init_nearby_player_scaling();
    self.script_noragdoll = 1;
    self.allowfriendlyfire = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self function_786bb6aa1b76c7ee( "in_armor_break", 0 );
    self.spawnorigin = self.origin;
    self.spawnangles = self.angles;
    zombie_boss_healthbar::init_zombie_boss_healthbar();
    namespace_af6379f1aba0301c::init_metabones();
    
    if ( getdvarint( @"hash_1d00233aa37ac01b", 1 ) )
    {
        zombie_triton_targeting::init_zombie_triton_targeting();
    }
    
    zombie_triton_foot_stomp::init_triton_foot_stomp();
    zombie_triton_ground_slam::init_zombie_triton_ground_slam();
    zombie_triton_leap_slam::function_b992691c4ad426f();
    zombie_triton_lava_toss::function_832c001e69ef9a55();
    zombie_triton_audio::init_zombie_triton_audio();
    zombie_triton_scaling::init_zombie_triton_scaling();
    zombie_triton_lava_bomb::function_a680f6c9f2a4f64c( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ed3ff13b37e9bb5b );
    thread function_5bb420501eda5158();
    thread initscriptable();
    return anim.success;
}

// Namespace zombie_triton
// Params 0, eflags: 0x4
// Checksum 0x8ee3be19, Offset: 0x62d
// Size: 0x375
function private function_5bb420501eda5158()
{
    self endon( #"death" );
    var_368a0327c24e0f06 = 3000;
    var_8f3033e1e8426f7f = spawnstruct();
    var_8f3033e1e8426f7f.var_648e381b1cc3faa8 = squared( 1255 );
    var_8f3033e1e8426f7f.var_84b4702a5f911a03 = 0.225;
    var_8f3033e1e8426f7f.var_507a1f539e74362 = 0.125;
    var_8f3033e1e8426f7f.earthquakeradius = 3000;
    var_7a9084c17d0209d3 = spawnstruct();
    var_7a9084c17d0209d3.var_648e381b1cc3faa8 = squared( 900 );
    var_7a9084c17d0209d3.var_84b4702a5f911a03 = 0.175;
    var_7a9084c17d0209d3.var_507a1f539e74362 = 0.1;
    var_7a9084c17d0209d3.earthquakeradius = 3000;
    
    while ( true )
    {
        footstepsize = utility::waittill_any_return( "rightFootstepLarge", "leftFootstepLarge", "rightfootstepSmall", "leftfootstepSmall" );
        
        if ( !isdefined( self.nearbyplayers ) )
        {
            nearbyplayers = namespace_9d8e359c3b1041e5::getplayersinradiussharedfunc( self.origin, var_368a0327c24e0f06 );
        }
        else
        {
            nearbyplayers = self.nearbyplayers;
        }
        
        foreach ( nearbyplayer in nearbyplayers )
        {
            if ( ( isalive( nearbyplayer ) || player::isinlaststand( nearbyplayer ) ) && isdefined( nearbyplayer.origin ) )
            {
                var_d1e5bd06007b76c1 = distancesquared( nearbyplayer.origin, self.origin );
                
                switch ( footstepsize )
                {
                    case #"hash_89ff0e369b777f22":
                    case #"hash_919c93f08f32763e":
                        foottag = "j_ball_ri";
                        break;
                    case #"hash_7b9104fee587c45":
                    case #"hash_b06790d14e4c2021":
                        foottag = "j_ball_ri";
                        break;
                }
                
                switch ( footstepsize )
                {
                    case #"hash_919c93f08f32763e":
                    case #"hash_b06790d14e4c2021":
                        var_a9e6352b74faa839 = math::lerp_fraction( var_8f3033e1e8426f7f.var_648e381b1cc3faa8, 0, var_d1e5bd06007b76c1 );
                        earthquakescale = math::lerp( var_8f3033e1e8426f7f.var_507a1f539e74362, var_8f3033e1e8426f7f.var_84b4702a5f911a03, var_a9e6352b74faa839 );
                        earthquakeradius = var_8f3033e1e8426f7f.earthquakeradius;
                        
                        if ( var_a9e6352b74faa839 < 0.5 )
                        {
                            rumblestr = "light_1s";
                        }
                        else
                        {
                            rumblestr = "heavy_1s";
                        }
                        
                        break;
                    case #"hash_7b9104fee587c45":
                    case #"hash_89ff0e369b777f22":
                        var_a9e6352b74faa839 = math::lerp_fraction( var_7a9084c17d0209d3.var_648e381b1cc3faa8, 0, var_d1e5bd06007b76c1 );
                        earthquakescale = math::lerp( var_7a9084c17d0209d3.var_507a1f539e74362, var_7a9084c17d0209d3.var_84b4702a5f911a03, var_a9e6352b74faa839 );
                        earthquakeradius = var_7a9084c17d0209d3.earthquakeradius;
                        
                        if ( var_a9e6352b74faa839 < 0.65 )
                        {
                            rumblestr = "light_1s";
                        }
                        else
                        {
                            rumblestr = "heavy_1s";
                        }
                        
                        break;
                }
                
                if ( earthquakescale > 0 )
                {
                    nearbyplayer earthquakeforplayer( earthquakescale, 0.1, self gettagorigin( foottag ), earthquakeradius );
                }
                
                nearbyplayer playrumbleonentity( rumblestr );
            }
        }
    }
}

// Namespace zombie_triton
// Params 1, eflags: 0x4
// Checksum 0xdcdbce55, Offset: 0x9aa
// Size: 0x6e9
function private function_de228bb88cf576a3( params )
{
    self.killondamage = undefined;
    
    if ( self.var_fa202e3c1b788e39 )
    {
        return 0;
    }
    
    damage = params.idamage;
    
    if ( issubstr( params.objweapon.modifier, "12g_db_sh_uncle12" ) )
    {
        damage *= getdvarfloat( @"hash_e202fad6d69167ee", 1.45 );
    }
    
    if ( self.var_16d41b4722b48383 )
    {
        if ( params.metabonename == "armored_chest" && ( params.shitloc == "torso_upper" || params.shitloc == "torso_lower" || params.shitloc == "head" ) )
        {
            damage *= 0.05;
        }
    }
    
    weakspotdata = metabone::get_metabone_metadata( params.metabonename, "Types_Weakspot" );
    armordata = metabone::get_metabone_metadata( params.metabonename, "Types_Armor" );
    
    if ( isdefined( params.objweapon.basename ) )
    {
        israygun = issubstr( params.objweapon.basename, "raygun" );
        var_5075758afdd20d2d = israygun && !issubstr( params.objweapon.basename, "raygunmark2" );
        var_86a3a7773aac14db = issubstr( params.objweapon.basename, "raygunmark2p" );
        var_86a3a9773aac1941 = issubstr( params.objweapon.basename, "raygunmark2r" );
        var_86a3ac773aac1fda = issubstr( params.objweapon.basename, "raygunmark2w" );
        var_2e9685815f9f202e = !var_86a3a7773aac14db && !var_86a3a9773aac1941 && !var_86a3ac773aac1fda;
    }
    
    if ( israygun )
    {
        if ( var_5075758afdd20d2d )
        {
            if ( !isdefined( weakspotdata ) )
            {
                damage *= 12.5;
            }
            else
            {
                damage *= 1.5;
            }
        }
        else if ( var_2e9685815f9f202e )
        {
            if ( isdefined( armordata ) )
            {
                damage *= 1.1;
            }
            
            if ( isdefined( weakspotdata ) )
            {
                damage *= 1.65;
            }
            else
            {
                damage *= 1.65;
            }
        }
        else if ( var_86a3a7773aac14db )
        {
            if ( isdefined( weakspotdata ) )
            {
                damage *= 0.55;
            }
            else if ( !isdefined( armordata ) )
            {
                damage *= 0.6;
            }
        }
        else if ( var_86a3a9773aac1941 )
        {
            if ( isdefined( armordata ) )
            {
                damage *= 0.47;
            }
            
            if ( isdefined( weakspotdata ) )
            {
                damage *= 0.45;
            }
            else
            {
                damage *= 0.65;
            }
        }
        else if ( var_86a3ac773aac1fda )
        {
            if ( isdefined( armordata ) )
            {
                damage *= 0.9;
            }
            
            if ( isdefined( weakspotdata ) )
            {
                damage *= 0.25;
            }
            else
            {
                damage *= 0.26;
            }
        }
    }
    
    if ( issubstr( params.objweapon.basename, "dark_flare" ) )
    {
        damage *= 0.5;
    }
    
    var_db9d3dfa3b12549e = 0.00345;
    
    if ( self._blackboard.var_606bf8ea1f70975d > 0 )
    {
        if ( self._blackboard.var_606bf8ea1f70975d > 0 && self._blackboard.var_606bf8ea1f70975d <= 0.34 )
        {
            var_db9d3dfa3b12549e *= 0.75;
        }
        else if ( self._blackboard.var_606bf8ea1f70975d > 0.34 && self._blackboard.var_606bf8ea1f70975d <= 0.67 )
        {
            var_db9d3dfa3b12549e *= 0.5;
        }
        else
        {
            var_db9d3dfa3b12549e *= 0.25;
        }
    }
    
    var_ac2bf8e60df88a4e = issubstr( params.objweapon.basename, "bloodstone" ) && params.smeansofdeath == "MOD_PROJECTILE";
    
    if ( ( weapon::iswonderweapon( params.objweapon ) || var_ac2bf8e60df88a4e ) && !israygun )
    {
        if ( isdefined( armordata ) )
        {
            damage = getdvarfloat( @"hash_89db3882db5e8f42", 15000 );
        }
        else
        {
            damage = self.maxhealth * getdvarfloat( @"hash_291b58c1979a529", var_db9d3dfa3b12549e );
        }
    }
    else if ( params.objweapon.ismelee )
    {
        if ( isdefined( armordata ) )
        {
            damage *= getdvarfloat( @"hash_7e5db6ed9beca397", 0.1 );
        }
        else if ( !isdefined( weakspotdata ) )
        {
            damage *= getdvarfloat( @"hash_c229e4935c2dd33b", 0.05 );
            damage = min( damage, self.maxhealth * getdvarfloat( @"hash_291b58c1979a529", var_db9d3dfa3b12549e ) );
        }
    }
    else if ( params.biscritical )
    {
        if ( isdefined( weakspotdata ) )
        {
            if ( params.metabonename == "armored_chest" && metabone::get_metabone_state_name( "armored_chest" ) == "weakspot" )
            {
                utility::function_32b24db3127bff40( "amulet_impact", "weakpoint_impact" );
            }
            else
            {
                playfx( utility::getfx( "zombie_triton_damage_impact_weakspot" ), params.vpoint );
            }
        }
        
        if ( params.sweapon.classname == "grenade" )
        {
            damage *= 0.4;
        }
        
        criticalreduction = getdvarfloat( @"hash_dde8e94220f78c47", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_172eab5623e71394 ) ?? 0.6;
        damage *= criticalreduction;
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) && isdefined( params.sweapon ) && isplayer( params.eattacker ) )
    {
        paplevel = params.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( params.sweapon );
        
        if ( paplevel >= 2 )
        {
            switch ( params.sweapon.classname )
            {
                case #"hash_690c0d6a821b42e":
                    damage *= 0.55;
                    break;
                case #"hash_fa24dff6bd60a12d":
                    damage *= 0.9;
                    break;
                case #"hash_6191aaef9f922f96":
                    damage *= 0.6;
                    break;
            }
            
            if ( paplevel >= 3 )
            {
                if ( self._blackboard.var_606bf8ea1f70975d > 0 )
                {
                    damage *= 0.9;
                }
            }
        }
    }
    
    return damage;
}

// Namespace zombie_triton
// Params 0, eflags: 0x4
// Checksum 0x67d84d99, Offset: 0x109c
// Size: 0x40
function private initscriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    utility::waittill_any_timeout( level.framedurationseconds, "post_spawn" );
    utility::function_32b24db3127bff40( "base", "base_on" );
}

// Namespace zombie_triton
// Params 1, eflags: 0x4
// Checksum 0x762bb214, Offset: 0x10e4
// Size: 0x14d
function private play_death_fx( params )
{
    var_28e65708aca9bc0e = 7.55;
    var_bf2830e4dbe7e911 = 5;
    params.body forcenetfieldhighlod( 1 );
    params.body function_dd258a3da9a2b4a1( var_28e65708aca9bc0e );
    var_37ae351672c6ada2 = params.body getcentroid();
    var_9e438df89431f17a = params.body.angles;
    wait var_28e65708aca9bc0e;
    
    if ( isdefined( params.body ) )
    {
        var_8e3f6b62befe7d5c = params.body getcentroid();
        var_b0b2f33c9c77f798 = params.body.angles;
        
        if ( isdefined( var_8e3f6b62befe7d5c ) && isdefined( var_b0b2f33c9c77f798 ) )
        {
            deathexplosion = spawnscriptable( "scriptable_zombie_triton_death_explosion", var_8e3f6b62befe7d5c, var_b0b2f33c9c77f798 );
        }
        else
        {
            deathexplosion = spawnscriptable( "scriptable_zombie_triton_death_explosion", var_37ae351672c6ada2, var_9e438df89431f17a );
        }
        
        if ( isdefined( deathexplosion ) )
        {
            deathexplosion setscriptablepartstate( "death", "death" );
        }
        
        params.body delete();
    }
    
    if ( isdefined( deathexplosion ) )
    {
        wait var_bf2830e4dbe7e911;
        deathexplosion setscriptablepartstate( "death", "off" );
        deathexplosion freescriptable();
    }
}

// Namespace zombie_triton
// Params 2
// Checksum 0xf66aaaf1, Offset: 0x1239
// Size: 0xee
function movetospawnpoint( taskid, params )
{
    if ( isdefined( self.spawnorigin ) && !self.var_e30ba852102cf5a0 )
    {
        if ( self.var_8276841ec402381f == "sprint" )
        {
            var_68728ae7f4c7d185 = 250;
        }
        else
        {
            var_68728ae7f4c7d185 = 200;
        }
        
        if ( distancesquared( self.origin, self.spawnorigin ) <= squared( var_68728ae7f4c7d185 ) )
        {
            if ( self.goingToSpawnPoint )
            {
                self clearbtgoal( 2 );
                self.goingToSpawnPoint = undefined;
            }
            
            return anim.success;
        }
        
        if ( !self.goingToSpawnPoint )
        {
            self setbtgoalpos( 2, self.spawnorigin );
            self.goingToSpawnPoint = 1;
            self function_786bb6aa1b76c7ee( "goingToSpawnPoint", 1 );
            return anim.failure;
        }
    }
    
    return anim.failure;
}

// Namespace zombie_triton
// Params 2
// Checksum 0xbae2a907, Offset: 0x1330
// Size: 0x252
function function_7fe5ce90cce17e98( taskid, params )
{
    if ( self getaiblackboarddynamic( "triton_disable_move" ) )
    {
        return anim.success;
    }
    
    if ( getdvarfloat( @"hash_86956854eaf68a32", 0 ) > 0 )
    {
        return anim.success;
    }
    
    if ( !self getaiblackboarddynamic( "triton_ran_patrol" ) )
    {
        self function_786bb6aa1b76c7ee( "triton_ran_patrol", 1 );
    }
    
    var_d4e520db9bfb3a9c = squared( 150 );
    var_31939aa673b45135 = 500;
    var_803df3ec502db250 = 100;
    
    if ( !isdefined( self.var_d07c2879cd9491fc ) )
    {
        self.var_d07c2879cd9491fc = gettime() + var_31939aa673b45135;
    }
    
    if ( !isdefined( self.triton_last_pos ) )
    {
        self.triton_last_pos = self.origin;
    }
    
    if ( gettime() > self.var_d07c2879cd9491fc )
    {
        if ( distancesquared( self.origin, self.triton_last_pos ) <= var_803df3ec502db250 )
        {
            if ( isdefined( self.spawnorigin ) && distancesquared( self.origin, self.spawnorigin ) > var_d4e520db9bfb3a9c )
            {
                self setbtgoalpos( 2, self.spawnorigin );
                self.var_b37358fd5d7ce07a = self.spawnorigin;
            }
        }
        
        self.var_d07c2879cd9491fc = gettime() + var_31939aa673b45135;
        self.triton_last_pos = self.origin;
        return anim.success;
    }
    
    if ( self.var_c95b69fe681a8af2 && distancesquared( self.origin, self.var_b37358fd5d7ce07a ) > var_d4e520db9bfb3a9c )
    {
        return anim.running;
    }
    else
    {
        self.var_c95b69fe681a8af2 = 0;
    }
    
    self.var_b37358fd5d7ce07a = function_c6861d04ef1fe32c();
    
    if ( !isdefined( self.var_b37358fd5d7ce07a ) )
    {
        if ( isdefined( self.spawnorigin ) && distancesquared( self.origin, self.spawnorigin ) > var_d4e520db9bfb3a9c )
        {
            self setbtgoalpos( 2, self.spawnorigin );
            self.var_b37358fd5d7ce07a = self.spawnorigin;
        }
        
        return anim.success;
    }
    
    self setbtgoalpos( 2, self.var_b37358fd5d7ce07a );
    self.var_674e8ca4bc7a1981 = 0;
    self.var_c95b69fe681a8af2 = 1;
    return anim.success;
}

// Namespace zombie_triton
// Params 0, eflags: 0x4
// Checksum 0x3043e22e, Offset: 0x158b
// Size: 0x8d
function private function_c6861d04ef1fe32c()
{
    goal_pos = self getgoalpos();
    recalculate_dist = asm_bb::bb_movetyperequested( "sprint" ) ? 300 : 600;
    recalculate_dist = getdvarfloat( @"hash_8dfc20f9f3e473bd", recalculate_dist );
    
    if ( isdefined( goal_pos ) && self pathdisttogoal() > recalculate_dist && !self.var_674e8ca4bc7a1981 )
    {
        return;
    }
    
    goal_pos = function_290f8c14dbc57398( self );
    
    if ( goal_pos == self.origin )
    {
        self.var_f9a759bcc48cca8f = gettime();
    }
    
    return goal_pos;
}

// Namespace zombie_triton
// Params 2
// Checksum 0xe869a702, Offset: 0x1621
// Size: 0x2bd
function function_290f8c14dbc57398( ai_entity, var_cfb5dc6e8df2500f = asm_bb::bb_movetyperequested( "sprint" ) ? 600 : 800 )
{
    var_cfb5dc6e8df2500f = getdvarfloat( @"hash_74ca834f822d0b28", var_cfb5dc6e8df2500f );
    top_x = getdvarfloat( @"hash_8ec367e650f9ed89", 5 );
    max_bounces = getdvarfloat( @"hash_a5ed95f4655cfc32", 1 );
    var_e6ef1231966449aa = ai_entity.origin;
    base_angles = ai_entity.angles;
    forward_dir = anglestoforward( base_angles );
    
    for ( b = 0; b < max_bounces ; b++ )
    {
        trace_results = [];
        
        for ( i = 0; i < 8 ; i++ )
        {
            if ( i == 3 || i == 5 )
            {
                trace_results[ i ] = [ var_e6ef1231966449aa, -999999, -999999 ];
                continue;
            }
            
            test_yaw = base_angles[ 1 ] + i * 45;
            test_angles = ( base_angles[ 0 ], test_yaw, base_angles[ 2 ] );
            check_dir = anglestoforward( test_angles );
            check_end = var_e6ef1231966449aa + check_dir * var_cfb5dc6e8df2500f;
            nav_end = getclosestpointonnavmesh( check_end, ai_entity, 1, 1, 0, 0 );
            
            if ( !isdefined( nav_end ) || distance( nav_end, var_e6ef1231966449aa ) < 200 )
            {
                trace_results[ i ] = [ var_e6ef1231966449aa, -999999, -999999 ];
                continue;
            }
            
            distance_val = distance( var_e6ef1231966449aa, nav_end );
            dot_val = vectordot( forward_dir, check_dir );
            trace_results[ i ] = [ nav_end, distance_val, dot_val ];
        }
        
        sorted_results = arraysort( trace_results, undefined, &function_17d0c9b38758e5a8 );
        best_position = var_e6ef1231966449aa;
        found_valid = 0;
        max_candidates = min( top_x, sorted_results.size );
        
        while ( !found_valid )
        {
            var_e3eab751eefd3bd0 = -999999;
            best_dot_index = -1;
            
            for ( m = 0; m < max_candidates ; m++ )
            {
                dot_val = sorted_results[ m ][ 2 ];
                
                if ( dot_val > var_e3eab751eefd3bd0 )
                {
                    var_e3eab751eefd3bd0 = dot_val;
                    best_dot_index = m;
                }
            }
            
            if ( best_dot_index <= -1 )
            {
                break;
            }
            
            var_35b8f54c259f8b32 = sorted_results[ best_dot_index ][ 0 ];
            best_position = var_35b8f54c259f8b32;
            found_valid = 1;
        }
        
        if ( !found_valid || best_position == var_e6ef1231966449aa )
        {
            break;
        }
        
        var_e6ef1231966449aa = best_position;
    }
    
    return var_e6ef1231966449aa;
}

// Namespace zombie_triton
// Params 2, eflags: 0x4
// Checksum 0x9bd1b3cd, Offset: 0x18e7
// Size: 0x1e, Type: bool
function private function_17d0c9b38758e5a8( a, b )
{
    return a[ 1 ] >= b[ 1 ];
}

