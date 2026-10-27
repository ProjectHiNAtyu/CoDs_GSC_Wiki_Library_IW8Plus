// scripts\mp\zm\systems\relics\zm_relic_ruby_ee_challenges.gsc  (hash_2647a0ca0d08b252.gscc) (size: 20571 Bytes / 0x505b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x86ec6271 (2263638641)
// size ...... 20571 (0x505b)
// includes .. 13  (offset: 0x4a1f)
// strings ... 91  (offset: 0x4a87)
// dev strs .. 4   (offset: 0x502b)
// exports ... 48  (offset: 0x349b)
// cseg ...... 0x6e5 + 0x2db6 (0x349b)
// imports ... 105 (offset: 0x3c1b)
// animtree1 . 0   (offset: 0x505b)
// animtree2 . 0   (offset: 0x505b)
#using script_3b6eb865087dc118;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\weapons\manglercannon_torpedo;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\zm\systems\relics\zm_relic_ruby_ee_challenges_cs;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_relic_ruby_ee_challenges;

// Namespace zm_relic_ruby_ee_challenges
// Params 0, eflags: 0x5
// Checksum 0xd83512ff, Offset: 0x703
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_relic_ruby_ee", undefined, undefined, &init );
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0x67185af6, Offset: 0x724
// Size: 0x1f3
function init()
{
    level thread function_487f9e5930842a56();
    level thread spawn_mars_hint();
    
    if ( !getdvarint( @"hash_70ef86ad43e08120", 0 ) && !level.var_8a98c33a6b47db4a )
    {
        return;
    }
    
    if ( game_utility::getgametype() == "zm_rb_r_mod_survival" )
    {
        return;
    }
    
    if ( getdvarint( @"hash_7df78affc339b8c1", 0 ) )
    {
        level.zm_relic_tier = getdvarint( @"hash_7df78affc339b8c1", 0 );
    }
    
    utility::waittill_any_timeout( 5, "create_script_initialized" );
    zm_relic_ruby_ee_challenges_cs::main();
    
    if ( !getdvarint( @"hash_be4855acac8d71e9", 0 ) )
    {
        level utility::flag_wait( "cursed_mode_validation_set" );
    }
    
    if ( !level.var_f504cb20a9eeb54c && !getdvarint( @"hash_307752bc7a505a1f", 0 ) )
    {
        return;
    }
    
    callback::add( "on_round_start", &function_5aea60ff18d0f508 );
    level utility::waittill_notify_or_timeout( "relic_level_set", 15 );
    callback::add( #"player_disconnect", &function_d9d0158e81d7faff );
    callback::add( #"on_ai_killed", &function_3d12d833cd3013a5 );
    level.relic_med = spawnstruct();
    level.relic_hard = spawnstruct();
    
    switch ( level.zm_relic_tier )
    {
        case 0:
            logstring( "[R_MOD] Ruby Relic EE's unlocked successfully, Tier 0" );
            break;
        case 1:
            function_463fd72850c2f91b();
            logstring( "[R_MOD] Ruby Relic EE's unlocked successfully, Tier 1" );
            break;
        case 2:
            function_463fd72850c2f91b();
            function_162ad694402905d0();
            logstring( "[R_MOD] Ruby Relic EE's unlocked successfully, Tier 2" );
            break;
        case 3:
            function_463fd72850c2f91b();
            function_162ad694402905d0();
            logstring( "[R_MOD] Ruby Relic EE's unlocked successfully, Tier 3" );
            break;
    }
    
    level utility::flag_set( "tiers_set_up" );
    callback::add( #"relic_challenge_started", &function_f7f8879b0284af5c );
    callback::add( #"relic_challenge_ended", &function_1ddd99ce98d6dab8 );
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0xf2a74d7f, Offset: 0x91f
// Size: 0x1a0
function function_487f9e5930842a56()
{
    level utility::flag_wait( "begin_round_logic" );
    callback::add( "zm_packed_weapon", &function_f4aaafa4b2210106 );
    level.relic_easy = spawnstruct();
    level.relic_easy.a_bulbs = [];
    level.relic_easy.var_4346057b7787551 = 0;
    a_s_lights = utility::getstructarray( "relic_light" );
    
    foreach ( var_158ef68da1e46a9c in a_s_lights )
    {
        sc_light = spawnscriptable( %"zm_relic_light", var_158ef68da1e46a9c.origin, var_158ef68da1e46a9c.angles );
        sc_light utility::function_7c10ea82c1e305b8( "model", "visible_off" );
        sc_light.s_fx = utility::getstruct( var_158ef68da1e46a9c.target );
        sc_light.sc_fx = spawnscriptable( %"zm_relic_ruby_fx", sc_light.s_fx.origin, sc_light.s_fx.angles );
        level.relic_easy.a_bulbs[ level.relic_easy.a_bulbs.size ] = sc_light;
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0x9aa97a6, Offset: 0xac7
// Size: 0xc
function function_463fd72850c2f91b()
{
    level.var_7a7698fb0ab518d0 = 0;
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0x73a09f4a, Offset: 0xadb
// Size: 0x40
function function_162ad694402905d0()
{
    callback::add( #"hash_9456270bf9577eb1", &on_phd_flop );
    callback::add( "damage_point", &function_5d031a8b3fa6cb3f );
    callback::add( "mangler_torpedo", &function_bd198523a4a60caf );
    candles_spawn();
}

// Namespace zm_relic_ruby_ee_challenges
// Params 1
// Checksum 0xe02071bf, Offset: 0xb23
// Size: 0xc8
function function_5aea60ff18d0f508( params )
{
    round_number = params.roundnumber;
    
    if ( round_number == 1 && getdvarint( @"spawn_all_portals", 0 ) )
    {
        level thread function_722147ca0a41401d();
    }
    
    switch ( round_number )
    {
        case 20:
            function_cbd9dd3a226ed4ff();
            break;
        case 40:
            function_9c595ed2d99d1855();
            break;
        case 60:
            function_e79f0c1a2068c143();
            break;
        default:
            break;
    }
    
    if ( round_number > 20 && zm_save::function_1dda3554974a999e() )
    {
        level utility::flag_wait( "tiers_set_up" );
        function_69fcd5bba8fd8309( round_number );
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 1
// Checksum 0xa03ba4cc, Offset: 0xbf3
// Size: 0x42
function function_69fcd5bba8fd8309( round )
{
    if ( zm_save::function_1dda3554974a999e() )
    {
        if ( round > 20 )
        {
            function_cbd9dd3a226ed4ff();
        }
        
        if ( round > 40 )
        {
            function_9c595ed2d99d1855();
        }
        
        if ( round > 60 )
        {
            function_e79f0c1a2068c143();
        }
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0xe3d0881, Offset: 0xc3d
// Size: 0x5c
function function_cbd9dd3a226ed4ff()
{
    if ( !level utility::flag( "rr_20_set" ) )
    {
        level utility::flag_set( "rr_20_set" );
        level thread function_60480f634311b6bc();
        callback::add( "on_zombie_ai_spawned", &function_103b067c96cd259a );
        
        if ( getdvarint( @"spawn_all_pistols", 0 ) )
        {
            level thread function_84614dbf2381b5ff();
            return;
        }
        
        level thread spawn_relic_weapon();
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0x43b5561b, Offset: 0xca1
// Size: 0xca
function function_9c595ed2d99d1855()
{
    if ( level.zm_relic_tier >= 1 && !level utility::flag( "rr_40_set" ) )
    {
        level utility::flag_set( "rr_40_set" );
        callback::add( #"player_spawned", &function_b39a479cbbedc8c4 );
        level utility::flag_set( "tier_1_start" );
        
        foreach ( player in level.players )
        {
            player thread function_5ad5a2e26f9fcf58();
        }
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0x5d4659b0, Offset: 0xd73
// Size: 0x44
function function_e79f0c1a2068c143()
{
    if ( level.zm_relic_tier >= 2 && !level utility::flag( "rr_60_set" ) )
    {
        level utility::flag_set( "rr_60_set" );
        candles_light();
        vehicle_lights();
        setup_candle_order();
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0x4569c8e1, Offset: 0xdbf
// Size: 0x91
function function_60480f634311b6bc()
{
    level endon( #"lighted", #"relic_gong" );
    
    while ( true )
    {
        level waittill( #"on_round_start" );
        var_6761390ea63cd7c0 = level.var_a009ab14ee0d3223.var_5c8829ccd69f3862;
        level.var_2d4868a946491c81 = undefined;
        level.var_5b64fd1d9acccb9b = 0;
        level.var_6e2cdbdcebdfc095 = randomintrange( int( var_6761390ea63cd7c0 * 0.25 ), int( var_6761390ea63cd7c0 * 0.85 ) );
        level waittill( #"on_round_end" );
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 1
// Checksum 0xd9299e83, Offset: 0xe58
// Size: 0x12d
function function_103b067c96cd259a( sparams )
{
    if ( level utility::flag( "relic_gong" ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_5b64fd1d9acccb9b ) || !isdefined( level.var_6e2cdbdcebdfc095 ) )
    {
        return;
    }
    
    level.var_5b64fd1d9acccb9b++;
    
    if ( level.var_5b64fd1d9acccb9b >= level.var_6e2cdbdcebdfc095 && !isdefined( level.var_2d4868a946491c81 ) && issubstr( self.subclass, "zombie_base" ) )
    {
        waitframe();
        
        if ( isalive( self ) )
        {
            level.var_2d4868a946491c81 = self;
            level.var_2d4868a946491c81 val::set( "lightning_rod", "ignore_cleanup", 1 );
            level.var_2d4868a946491c81 val::set( "lightning_rod", "allow_brot", 0 );
            level.var_2d4868a946491c81 val::set( "lightning_rod", "w_mod_ignore_target", 1 );
            level.var_2d4868a946491c81 thread attach_rod();
            level.var_2d4868a946491c81 thread rod_zombie_shock();
            level.var_2d4868a946491c81 thread rod_zombie_death();
            
            /#
                level.var_2d4868a946491c81 thread function_c6a858a2b2943227( "<dev string:x24>" );
            #/
        }
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0x7f3968cb, Offset: 0xf8d
// Size: 0xa3
function attach_rod()
{
    if ( isalive( self ) )
    {
        rod_loc = self gettagorigin( "j_spine4" );
        rod_offset = anglestoup( self.angles ) * 6 + anglestoforward( self.angles ) * 5.5 + ( 7, 0, 0 );
        level.var_b11b64f5583f0be3 = utility::spawn_model( %"t10_zm_weather_machine_rod_incline", rod_loc, self gettagangles( "j_spine4" ) );
        level.var_b11b64f5583f0be3 linkto( self, "j_spine4", rod_offset, ( 0, 0, 165 ) );
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0xfb075ff1, Offset: 0x1038
// Size: 0x2a
function rod_zombie_death()
{
    self waittill( #"death" );
    
    if ( isdefined( level.var_b11b64f5583f0be3 ) )
    {
        level.var_b11b64f5583f0be3 delete();
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0x8ee4fd5, Offset: 0x106a
// Size: 0x176
function rod_zombie_shock()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( utility::ent_flag( "tesla_storm_stunned" ) && utility::ent_flag( "deadwire_stunned" ) )
        {
            foreach ( bulb in level.relic_easy.a_bulbs )
            {
                if ( distance2dsquared( self.origin, bulb.origin ) <= 90000 && !isdefined( bulb.is_lit ) )
                {
                    bulb.is_lit = 1;
                    e_org = utility::spawn_model( "tag_origin", self getcentroid() );
                    e_org.sc_fx = spawnscriptable( %"zm_relic_ruby_fx", e_org.origin, e_org.angles );
                    e_org.sc_fx utility::function_7c10ea82c1e305b8( "vfx", "electric_arc" );
                    e_org.sc_fx utility::scriptable_setparententity( e_org );
                    e_org thread bulb_light( bulb );
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 1
// Checksum 0xf0680055, Offset: 0x11e8
// Size: 0x12b
function bulb_light( bulb )
{
    self endon( #"death" );
    self moveto( bulb.sc_fx.origin, 1 );
    self waittill( #"movedone" );
    waitframe();
    bulb utility::function_7c10ea82c1e305b8( "model", "visible_on" );
    bulb.sc_fx utility::function_7c10ea82c1e305b8( "vfx", "light_bulb" );
    level.relic_easy.var_4346057b7787551++;
    
    if ( level.relic_easy.var_4346057b7787551 == 3 )
    {
        level utility::flag_set( "relic_gong" );
        level utility::flag_set( "gp_already_spawned" );
        var_2153e39e051f5b91 = %"hash_4ad482a5c6749cc4";
        index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
        namespace_a6c33b614364964::function_9a0db59ed1b757d4( "easy" + "_" + index, level.green_portals[ index ], var_2153e39e051f5b91 );
    }
    
    wait 3;
    self.sc_fx freescriptable();
    waitframe();
    self delete();
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0xb94dc2f8, Offset: 0x131b
// Size: 0xe7
function spawn_relic_weapon()
{
    a_s_weapons = utility::getstructarray( "relic_weapon" );
    var_259cae2937df2cc8 = utility::array_random( a_s_weapons ).origin;
    var_944deecc7a4cdd82 = [ "atlas", "orion", "timir" ];
    str_pistol = utility::array_random( var_944deecc7a4cdd82 );
    var_8a61d4195b4b6e64 = getscriptbundle( "itemspawnentry:zm_sat_item_weapon_pi_" + str_pistol );
    spawnoptions = common_item::function_bc5ff2958b71a708( var_259cae2937df2cc8 );
    spawnoptions.var_fd47e835523b473f = 1;
    var_eb999eafdc7b2526 = item_weapon::function_b960bc85ea91de14( var_8a61d4195b4b6e64, spawnoptions );
    level.weapon_relic = var_eb999eafdc7b2526;
    callback::add( #"item_weapon_picked_up", &function_1e82ef459f135b2e );
    
    /#
        var_eb999eafdc7b2526 thread function_c6a858a2b2943227( "<dev string:x2c>" );
    #/
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0xa22601ca, Offset: 0x140a
// Size: 0x10a
function function_84614dbf2381b5ff()
{
    a_s_weapons = utility::getstructarray( "relic_weapon" );
    var_944deecc7a4cdd82 = [ "atlas", "orion", "timir" ];
    str_pistol = utility::array_random( var_944deecc7a4cdd82 );
    
    foreach ( var_fe68cd50dcda7fdc in a_s_weapons )
    {
        var_8a61d4195b4b6e64 = getscriptbundle( "itemspawnentry:zm_sat_item_weapon_pi_" + str_pistol );
        spawnoptions = common_item::function_bc5ff2958b71a708( var_fe68cd50dcda7fdc.origin );
        spawnoptions.var_fd47e835523b473f = 1;
        var_eb999eafdc7b2526 = item_weapon::function_b960bc85ea91de14( var_8a61d4195b4b6e64, spawnoptions );
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 1, eflags: 0x4
// Checksum 0x80955d64, Offset: 0x151c
// Size: 0x87
function private function_1e82ef459f135b2e( params )
{
    if ( params.item == level.weapon_relic )
    {
        if ( !isdefined( self.var_5ffe066648a00cfc ) )
        {
            level.weapon_relic = params.item.weaponobj;
            level.var_9d95a9c9def732bf = 0;
            self.var_5ffe066648a00cfc = 1;
            level.var_80c60aa32151eb2b = zm_utility::get_round_number();
            thread function_595a0d151a920dc8();
            level notify( #"hash_c30ba20273ca2096" );
        }
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 1
// Checksum 0xdd2629a9, Offset: 0x15ab
// Size: 0x38
function function_f4aaafa4b2210106( params )
{
    if ( level.weapon_relic === params.var_39044599845b54cf )
    {
        level.weapon_relic = params.var_101633ed971732ba;
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0x630016bc, Offset: 0x15eb
// Size: 0xaf
function function_595a0d151a920dc8()
{
    level endon( #"gp_already_spawned" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        level waittill( #"on_round_end" );
        
        if ( level utility::flag( "kills_reached" ) )
        {
            var_2153e39e051f5b91 = %"hash_26b2c58051238ef2";
            index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
            namespace_a6c33b614364964::function_9a0db59ed1b757d4( "easy" + "_" + index, level.green_portals[ index ], var_2153e39e051f5b91 );
            level utility::flag_set( "gp_already_spawned" );
            continue;
        }
        
        level.var_9d95a9c9def732bf = 0;
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 1
// Checksum 0xa92e00c8, Offset: 0x16a2
// Size: 0x20
function function_d9d0158e81d7faff( params )
{
    if ( isdefined( self.var_5ffe066648a00cfc ) )
    {
        spawn_relic_weapon();
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 1
// Checksum 0xb29803c3, Offset: 0x16ca
// Size: 0x2a
function function_eac8ed41579e05db( params )
{
    if ( isdefined( self.var_5ffe066648a00cfc ) )
    {
        self.var_5ffe066648a00cfc = undefined;
        spawn_relic_weapon();
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 1
// Checksum 0xc0b0a622, Offset: 0x16fc
// Size: 0x263
function function_3d12d833cd3013a5( params )
{
    if ( self.subclass === "zombie_galileo" && level utility::flag( "tier_1_start" ) && !level utility::flag( "oscar" ) )
    {
        if ( params.eattacker utility::ent_flag( "perk_m_mod_active" ) && params.smeansofdeath == "MOD_MELEE" && isdefined( params.eattacker.var_4fd5ac47a9bd8c18.locked_on_ent ) && self == params.eattacker.var_4fd5ac47a9bd8c18.locked_on_ent )
        {
            level utility::flag_set( "oscar" );
            level utility::flag_set( "yp_already_spawned" );
            var_2153e39e051f5b91 = %"hash_6621215695339627";
            index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
            namespace_a6c33b614364964::function_9a0db59ed1b757d4( "medium" + "_" + index, level.yellow_portals[ index ], var_2153e39e051f5b91 );
        }
    }
    
    if ( params.sweapon == level.weapon_relic )
    {
        level.var_9d95a9c9def732bf++;
        
        /#
            iprintlnbold( "<dev string:x39>" + level.var_9d95a9c9def732bf );
        #/
        
        if ( level.var_9d95a9c9def732bf == level.var_80c60aa32151eb2b )
        {
            if ( !level utility::flag( "kills_reached" ) )
            {
                level utility::flag_set( "kills_reached" );
            }
        }
        else if ( level.var_9d95a9c9def732bf > level.var_80c60aa32151eb2b )
        {
            level utility::flag_clear( "kills_reached" );
        }
    }
    
    if ( isdefined( self.is_in_triangle ) && params.einflictor.equipmentref == "equip_c4" )
    {
        level.var_7a7698fb0ab518d0++;
    }
    
    if ( params.sweapon.basename === "energy_mine" && isdefined( level.s_jump_start ) )
    {
        if ( distance2dsquared( self.origin, level.s_jump_start.origin ) <= squared( level.s_jump_start.radius ) )
        {
            level utility::flag_set( "jump_start" );
        }
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 1
// Checksum 0x6a2b2099, Offset: 0x1967
// Size: 0x13
function function_b39a479cbbedc8c4( params )
{
    thread function_5ad5a2e26f9fcf58();
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0x9bd64701, Offset: 0x1982
// Size: 0xeb
function function_5ad5a2e26f9fcf58()
{
    self notify( #"hash_6e15458a2a687536" );
    self endon( #"hash_6e15458a2a687536" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"detonate" );
        
        if ( self.c4s.size === 3 )
        {
            level.var_7a7698fb0ab518d0 = 0;
            a_pts = [];
            
            foreach ( c4 in self.c4s )
            {
                a_pts[ a_pts.size ] = c4.origin;
            }
            
            level thread function_35c4f3affdb366a5( a_pts );
        }
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 1
// Checksum 0xf72e7692, Offset: 0x1a75
// Size: 0x18a
function function_35c4f3affdb366a5( a_pts )
{
    s_center = utility::getstruct( "explosive_center" );
    a_zombies = getaiarrayinradius( s_center.origin, 2000, "team_two_hundred" );
    
    foreach ( zombie in a_zombies )
    {
        if ( function_18b5b72a42ab6361( a_pts, zombie.origin ) && distance2dsquared( s_center.origin, zombie.origin ) <= squared( s_center.radius ) )
        {
            zombie thread function_2fe8df6fd8c61df();
        }
    }
    
    wait 1;
    
    if ( level.var_7a7698fb0ab518d0 > 6 && !level utility::flag( "triangulated" ) )
    {
        level utility::flag_set( "triangulated" );
        level utility::flag_set( "yp_already_spawned" );
        var_2153e39e051f5b91 = %"hash_15105deb10ab92fe";
        index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
        namespace_a6c33b614364964::function_9a0db59ed1b757d4( "medium" + "_" + index, level.yellow_portals[ index ], var_2153e39e051f5b91 );
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0xce814ed0, Offset: 0x1c07
// Size: 0x2e
function function_2fe8df6fd8c61df()
{
    self endon( #"death" );
    self.is_in_triangle = 1;
    wait 1;
    
    if ( isalive( self ) )
    {
        self.is_in_triangle = undefined;
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 2
// Checksum 0x65d5376b, Offset: 0x1c3d
// Size: 0x86
function function_18b5b72a42ab6361( tri_pts, var_408e0c7d8bfc99ad )
{
    InvalidOpCode( 0x83, var_408e0c7d8bfc99ad[ 0 ], var_408e0c7d8bfc99ad[ 1 ] );
    // Unknown operator ( 0x83, t11, Black Ops 7 )
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0xdd5d2c3e, Offset: 0x1def
// Size: 0x8e
function spawn_mars_hint()
{
    level utility::flag_wait( "begin_round_logic" );
    a_s_hints = utility::getstructarray( "explosive_vertex" );
    
    for ( i = 0; i < a_s_hints.size ; i++ )
    {
        sc_hint = spawnscriptable( %"zm_relic_ruby_fx", a_s_hints[ i ].origin + ( 0, 0, 0.5 ), a_s_hints[ i ].angles );
        sc_hint thread function_a848f8d50a0c3a2d( i + 1 );
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 1
// Checksum 0xc1c2e880, Offset: 0x1e85
// Size: 0x3f
function function_a848f8d50a0c3a2d( n_index )
{
    level endon( #"game_ended" );
    utility::function_7c10ea82c1e305b8( "vfx", "mars_hint_" + n_index );
    level utility::flag_wait( "triangulated" );
    self freescriptable();
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0x846226a8, Offset: 0x1ecc
// Size: 0x2a4
function candles_spawn()
{
    level.relic_hard.var_a73c5b0a90e5e8de = utility::getstructarray( "relic_wax" );
    level.relic_hard.a_candles = [];
    level.relic_hard.a_candles_nw = [];
    level.relic_hard.a_candles_ne = [];
    level.relic_hard.a_candles_sw = [];
    level.relic_hard.a_candles_se = [];
    
    foreach ( var_caab5a17fd498f25 in level.relic_hard.var_a73c5b0a90e5e8de )
    {
        candle = spawnscriptable( %"zm_relic_ruby_candle", var_caab5a17fd498f25.origin, var_caab5a17fd498f25.angles );
        candle utility::function_7c10ea82c1e305b8( "visibility", "visible" );
        level.relic_hard.a_candles[ level.relic_hard.a_candles.size ] = candle;
        
        if ( var_caab5a17fd498f25.script_noteworthy == "nw" )
        {
            level.relic_hard.a_candles_nw[ level.relic_hard.a_candles_nw.size ] = candle;
            candle.str_dir = "nw";
            continue;
        }
        
        if ( var_caab5a17fd498f25.script_noteworthy == "ne" )
        {
            level.relic_hard.a_candles_ne[ level.relic_hard.a_candles_ne.size ] = candle;
            candle.str_dir = "ne";
            continue;
        }
        
        if ( var_caab5a17fd498f25.script_noteworthy == "se" )
        {
            level.relic_hard.a_candles_se[ level.relic_hard.a_candles_se.size ] = candle;
            candle.str_dir = "se";
            continue;
        }
        
        level.relic_hard.a_candles_sw[ level.relic_hard.a_candles_sw.size ] = candle;
        candle.str_dir = "sw";
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0x69c37d92, Offset: 0x2178
// Size: 0x19d
function candles_light()
{
    level.relic_hard.var_efa20c98cd837878 = [];
    candle_nw = utility::array_random( level.relic_hard.a_candles_nw );
    candle_nw utility::function_7c10ea82c1e305b8( "vfx", "on" );
    level.relic_hard.var_efa20c98cd837878[ level.relic_hard.var_efa20c98cd837878.size ] = candle_nw;
    candle_ne = utility::array_random( level.relic_hard.a_candles_ne );
    candle_ne utility::function_7c10ea82c1e305b8( "vfx", "on" );
    level.relic_hard.var_efa20c98cd837878[ level.relic_hard.var_efa20c98cd837878.size ] = candle_ne;
    candle_sw = utility::array_random( level.relic_hard.a_candles_sw );
    candle_sw utility::function_7c10ea82c1e305b8( "vfx", "on" );
    level.relic_hard.var_efa20c98cd837878[ level.relic_hard.var_efa20c98cd837878.size ] = candle_sw;
    candle_se = utility::array_random( level.relic_hard.a_candles_se );
    candle_se utility::function_7c10ea82c1e305b8( "vfx", "on" );
    level.relic_hard.var_efa20c98cd837878[ level.relic_hard.var_efa20c98cd837878.size ] = candle_se;
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0x98df74ef, Offset: 0x231d
// Size: 0x31e
function vehicle_lights()
{
    level.s_jump_start = utility::getstruct( "jump_start_loc" );
    level.relic_hard.a_lights = [];
    var_8ea12a9905cfe7f3 = utility::getstruct( "relic_h_l" );
    var_8ea1489905d029ed = utility::getstruct( "relic_h_r" );
    s_b_l = utility::getstruct( "relic_b_l" );
    s_b_r = utility::getstruct( "relic_b_r" );
    light = spawnscriptable( %"zm_relic_ruby_fx", var_8ea12a9905cfe7f3.origin, var_8ea12a9905cfe7f3.angles );
    light.str_dir = var_8ea12a9905cfe7f3.script_noteworthy;
    level.relic_hard.a_lights[ level.relic_hard.a_lights.size ] = light;
    light = spawnscriptable( %"zm_relic_ruby_fx", var_8ea1489905d029ed.origin, var_8ea1489905d029ed.angles );
    light.str_dir = var_8ea1489905d029ed.script_noteworthy;
    level.relic_hard.a_lights[ level.relic_hard.a_lights.size ] = light;
    light = spawnscriptable( %"zm_relic_ruby_fx", s_b_l.origin, s_b_l.angles );
    light.str_dir = s_b_l.script_noteworthy;
    level.relic_hard.a_lights[ level.relic_hard.a_lights.size ] = light;
    light = spawnscriptable( %"zm_relic_ruby_fx", s_b_r.origin, s_b_r.angles );
    light.str_dir = s_b_r.script_noteworthy;
    level.relic_hard.a_lights[ level.relic_hard.a_lights.size ] = light;
    
    foreach ( light in level.relic_hard.a_lights )
    {
        if ( light.str_dir == "nw" )
        {
            light.str_light = "headlight_l";
            continue;
        }
        
        if ( light.str_dir == "ne" )
        {
            light.str_light = "headlight_r";
            continue;
        }
        
        if ( light.str_dir == "sw" )
        {
            light.str_light = "brakelight_l";
            continue;
        }
        
        light.str_light = "brakelight_r";
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0x103874f, Offset: 0x2643
// Size: 0x153
function setup_candle_order()
{
    level.relic_hard.var_efa20c98cd837878 = arrayrandomize( level.relic_hard.var_efa20c98cd837878 );
    level.relic_hard.var_d5bf6d06be8ffaf0 = [];
    level.relic_hard.var_a2b7729b78ef1ef2 = 0;
    
    for ( i = 0; i < level.relic_hard.var_efa20c98cd837878.size ; i++ )
    {
        foreach ( light in level.relic_hard.a_lights )
        {
            if ( light.str_dir == level.relic_hard.var_efa20c98cd837878[ i ].str_dir )
            {
                level.relic_hard.var_d5bf6d06be8ffaf0[ i ] = light;
            }
        }
    }
    
    level.relic_hard thread light_sequence();
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0x5ecb0b93, Offset: 0x279e
// Size: 0x1df
function light_sequence()
{
    self endon( #"extinguished" );
    level utility::flag_wait( "jump_start" );
    wait 1;
    
    foreach ( light in level.relic_hard.var_d5bf6d06be8ffaf0 )
    {
        light thread lights_flash();
    }
    
    wait 1;
    
    while ( true )
    {
        for ( i = 0; i < level.relic_hard.var_d5bf6d06be8ffaf0.size ; i++ )
        {
            level.relic_hard.var_d5bf6d06be8ffaf0[ i ] utility::function_7c10ea82c1e305b8( "vfx", level.relic_hard.var_d5bf6d06be8ffaf0[ i ].str_light );
            wait 2;
            level.relic_hard.var_d5bf6d06be8ffaf0[ i ] utility::function_7c10ea82c1e305b8( "vfx", "off" );
            wait 2;
            
            if ( i == level.relic_hard.var_d5bf6d06be8ffaf0.size - 1 )
            {
                foreach ( light in level.relic_hard.var_d5bf6d06be8ffaf0 )
                {
                    light thread lights_flash();
                }
                
                wait 3;
            }
        }
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0x7cd547e1, Offset: 0x2985
// Size: 0x92
function lights_off()
{
    wait 1;
    
    foreach ( light in level.relic_hard.var_d5bf6d06be8ffaf0 )
    {
        light utility::function_7c10ea82c1e305b8( "vfx", "off" );
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0x893727d7, Offset: 0x2a1f
// Size: 0x5b
function lights_flash()
{
    self endon( #"extinguished" );
    
    for ( i = 0; i < 3 ; i++ )
    {
        utility::function_7c10ea82c1e305b8( "vfx", self.str_light );
        wait 0.25;
        utility::function_7c10ea82c1e305b8( "vfx", "off" );
        wait 0.25;
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 1
// Checksum 0x9e740588, Offset: 0x2a82
// Size: 0x229
function on_phd_flop( params )
{
    if ( level utility::flag( "candles" ) )
    {
        return;
    }
    
    foreach ( candle in level.relic_hard.var_efa20c98cd837878 )
    {
        if ( distance2dsquared( candle.origin, self.origin ) <= 90000 && !candle utility::function_9f2c41c1dcc8c94( "vfx", "off" ) )
        {
            candle utility::function_7c10ea82c1e305b8( "vfx", "off" );
            level.relic_hard.var_a2b7729b78ef1ef2++;
            
            if ( candle.str_dir === level.relic_hard.var_efa20c98cd837878[ 0 ].str_dir )
            {
                level.relic_hard.var_efa20c98cd837878 = arrayremove( level.relic_hard.var_efa20c98cd837878, candle );
            }
            
            if ( level.relic_hard.var_a2b7729b78ef1ef2 == 4 )
            {
                level.relic_hard notify( #"extinguished" );
                
                if ( !level.relic_hard.var_efa20c98cd837878.size )
                {
                    level utility::flag_set( "candles" );
                    level utility::flag_set( "rp_already_spawned" );
                    var_2153e39e051f5b91 = %"hash_5073e0f3120a904f";
                    index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
                    namespace_a6c33b614364964::function_9a0db59ed1b757d4( "hard" + "_" + index, level.red_portals[ index ], var_2153e39e051f5b91 );
                    continue;
                }
                
                lights_off();
                level waittill( #"on_round_start" );
                candles_light();
                setup_candle_order();
            }
        }
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 1
// Checksum 0xad240aaf, Offset: 0x2cb3
// Size: 0xe0
function function_bd198523a4a60caf( params )
{
    if ( level utility::flag( "mangler_cannon" ) || !level utility::flag( "rr_60_set" ) )
    {
        return;
    }
    
    params.torpedo endon( #"death" );
    params.torpedo_owner endon( #"death" );
    var_cfed68b2a2cacd4f = utility::getstruct( "mars_portal_pos" );
    
    while ( true )
    {
        if ( distancesquared( var_cfed68b2a2cacd4f.origin, params.torpedo.origin ) <= 10000 && !isdefined( level.var_af10d433c30b14e9 ) )
        {
            level.var_af10d433c30b14e9 = 1;
            params.torpedo_owner thread function_93f2c20c3bd2d73c( params.torpedo );
        }
        
        wait 0.1;
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 1
// Checksum 0xf5d2a1cf, Offset: 0x2d9b
// Size: 0x12e
function function_5d031a8b3fa6cb3f( params )
{
    if ( level utility::flag( "mangler_cannon" ) || !level utility::flag( "rr_60_set" ) )
    {
        return;
    }
    
    if ( isdefined( self.var_633fc819494a843f ) )
    {
        a_zombies = getaiarrayinradius( params.origin, 100, "team_two_hundred" );
        
        for ( i = 0; i < a_zombies.size ; i++ )
        {
            if ( issubstr( a_zombies[ i ].subclass, "zombie_base" ) )
            {
                a_zombies[ i ] kill( params.origin, self );
                
                if ( !level utility::flag( "mangler_cannon" ) )
                {
                    level utility::flag_set( "mangler_cannon" );
                    level utility::flag_set( "rp_already_spawned" );
                    var_2153e39e051f5b91 = %"hash_5a6c4616b6e7c93e";
                    index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
                    namespace_a6c33b614364964::function_9a0db59ed1b757d4( "hard" + "_" + index, level.red_portals[ index ], var_2153e39e051f5b91 );
                }
            }
            
            waitframe();
        }
    }
    
    self.var_633fc819494a843f = undefined;
}

// Namespace zm_relic_ruby_ee_challenges
// Params 1
// Checksum 0xe79dd564, Offset: 0x2ed1
// Size: 0x207
function function_93f2c20c3bd2d73c( torpedo )
{
    self notify( #"hash_81ecfcdee3d33a9" );
    self endon( #"hash_81ecfcdee3d33a9" );
    self endon( #"death_or_disconnect" );
    torpedo delete();
    wait 20;
    zone = zone_manager::function_90e5c3e2272b0130( self.origin );
    
    if ( zone.zone_name == "zone_orrery_lower" || zone.zone_name == "zone_orrery" || zone.zone_name == "zone_orrery_upper_floor" || zone.zone_name == "zone_orrery_close_to_courtyard" )
    {
        self.var_633fc819494a843f = 1;
        var_f59f629951d5c376 = utility::getstruct( "cannon_source" );
        torpedo_pos = var_f59f629951d5c376.origin;
        launch_direction = vectornormalize( self.origin - var_f59f629951d5c376.origin );
        target = self;
        target_pos = self.origin + ( 0, 0, 40 );
        detonationdist = 24;
        velocity = 700;
        moveintervaltime = 0.1;
        maxrange = 1500;
        var_f4b133aee924c98a = 20;
        torpedoradius = 60;
        blastradius = 100;
        var_563b2433865c9509 = 200;
        var_5618163386362e87 = 500;
        var_19c5437e89b71a4f = 1000;
        stun_elites = 1;
        var_deed69668835b4ea = 1;
        detonate_on_target = 1;
        manglercannon_torpedo::mangler_cannon_shoot_torpedo( torpedo_pos, launch_direction, target, target_pos, detonationdist, velocity, moveintervaltime, maxrange, var_f4b133aee924c98a, torpedoradius, blastradius, 1000, 1000, var_563b2433865c9509, var_5618163386362e87, var_19c5437e89b71a4f, stun_elites, var_deed69668835b4ea, detonate_on_target, "t10_la_mangler_cannon_mp", "tag_origin_mangler_cannon_torpedo" );
    }
    
    level.var_af10d433c30b14e9 = undefined;
}

// Namespace zm_relic_ruby_ee_challenges
// Params 1
// Checksum 0xd6c0de34, Offset: 0x30e0
// Size: 0x19
function function_f7f8879b0284af5c( params )
{
    level utility::flag_set( "relic_challenge_active" );
}

// Namespace zm_relic_ruby_ee_challenges
// Params 1
// Checksum 0xba3eadf6, Offset: 0x3101
// Size: 0xf1
function function_1ddd99ce98d6dab8( params )
{
    relic_challenge_type = params.relic_challenge_type;
    level utility::flag_clear( "relic_challenge_active" );
    
    switch ( relic_challenge_type )
    {
        case %"hash_4ad482a5c6749cc4":
            level utility::flag_clear( "gp_already_spawned" );
            break;
        case %"hash_26b2c58051238ef2":
            level utility::flag_clear( "gp_already_spawned" );
            break;
        case %"hash_6621215695339627":
            level utility::flag_clear( "yp_already_spawned" );
            break;
        case %"hash_15105deb10ab92fe":
            level utility::flag_clear( "yp_already_spawned" );
            break;
        case %"hash_5073e0f3120a904f":
            level utility::flag_clear( "rp_already_spawned" );
            break;
        case %"hash_5a6c4616b6e7c93e":
            level utility::flag_clear( "rp_already_spawned" );
            break;
        default:
            break;
    }
}

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0xab003158, Offset: 0x31fa
// Size: 0x8b
function relic_challenge_unlocked()
{
    foreach ( player in level.players )
    {
        player playlocalsound( "evt_relic_challenge_unlocked_mrpeeks_stinger" );
    }
    
    /#
        iprintlnbold( "<dev string:x41>" );
    #/
}

/#

    // Namespace zm_relic_ruby_ee_challenges
    // Params 1
    // Checksum 0xf09d70a6, Offset: 0x328d
    // Size: 0x54, Type: dev
    function function_c6a858a2b2943227( str_endon )
    {
        level endon( #"game_ended", str_endon );
        self endon( #"death" );
        
        while ( true )
        {
            sphere( self.origin, 64, ( 1, 0, 0 ), 0, 1 );
            wait 1;
        }
    }

#/

// Namespace zm_relic_ruby_ee_challenges
// Params 0
// Checksum 0x9e01d42b, Offset: 0x32e9
// Size: 0x1b2
function function_722147ca0a41401d()
{
    var_2153e39e051f5b91 = %"hash_4ad482a5c6749cc4";
    index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
    namespace_a6c33b614364964::function_9a0db59ed1b757d4( "easy" + "_" + index, level.green_portals[ index ], var_2153e39e051f5b91 );
    var_2153e39e051f5b91 = %"hash_26b2c58051238ef2";
    index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
    namespace_a6c33b614364964::function_9a0db59ed1b757d4( "easy" + "_" + index, level.green_portals[ index ], var_2153e39e051f5b91 );
    var_2153e39e051f5b91 = %"hash_6621215695339627";
    index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
    namespace_a6c33b614364964::function_9a0db59ed1b757d4( "medium" + "_" + index, level.yellow_portals[ index ], var_2153e39e051f5b91 );
    var_2153e39e051f5b91 = %"hash_15105deb10ab92fe";
    index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
    namespace_a6c33b614364964::function_9a0db59ed1b757d4( "medium" + "_" + index, level.yellow_portals[ index ], var_2153e39e051f5b91 );
    var_2153e39e051f5b91 = %"hash_5073e0f3120a904f";
    index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
    namespace_a6c33b614364964::function_9a0db59ed1b757d4( "hard" + "_" + index, level.red_portals[ index ], var_2153e39e051f5b91 );
    var_2153e39e051f5b91 = %"hash_5a6c4616b6e7c93e";
    index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
    namespace_a6c33b614364964::function_9a0db59ed1b757d4( "hard" + "_" + index, level.red_portals[ index ], var_2153e39e051f5b91 );
}

