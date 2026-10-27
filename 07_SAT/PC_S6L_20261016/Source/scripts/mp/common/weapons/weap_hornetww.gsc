// scripts\mp\common\weapons\weap_hornetww.gsc  (hash_1aa6440d18c26cf6.gscc) (size: 21368 Bytes / 0x5378 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa9ab1a9e (2846562974)
// size ...... 21368 (0x5378)
// includes .. 12  (offset: 0x4dc4)
// strings ... 77  (offset: 0x4e24)
// dev strs .. 7   (offset: 0x5300)
// exports ... 50  (offset: 0x3590)
// cseg ...... 0x844 + 0x2d4c (0x3590)
// imports ... 128 (offset: 0x3d60)
// animtree1 . 0   (offset: 0x5354)
// animtree2 . 2   (offset: 0x5354)
#using scripts\anim\dialogue;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\weapons\ww_shared;

#namespace weap_hornetww;

// Namespace weap_hornetww
// Params 0, eflags: 0x5
// Checksum 0x89fa450, Offset: 0x862
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"weap_hornetww", undefined, &pre_main, &post_main );
}

// Namespace weap_hornetww
// Params 0, eflags: 0x4
// Checksum 0x33e85896, Offset: 0x887
// Size: 0x2
function private pre_main()
{
    
}

// Namespace weap_hornetww
// Params 0, eflags: 0x4
// Checksum 0xb888bf31, Offset: 0x891
// Size: 0x15a
function private post_main()
{
    level callback::add( #"player_weapon_change", &function_7cc28fd9819579a6 );
    level zombie_utils::function_dfae6a5bd222c586( &function_b11e158b20286a04 );
    level callback::add( "killed_body_cloned", &function_188e90d63e7d31bf );
    level callback::add( #"item_spawn_begin", &function_e9436de6576b5061 );
    level callback::add( #"item_weapon_drop", &function_f6f3a3b7680e70c8 );
    level callback::add( #"reload_start", &function_df78424314c3a01f );
    level._effect[ "vfx_t10_bio_aetheric_hand_cannon_wwp_bullet_impact_cyan_lg" ] = loadfxasset( "vfx_t10_bio_aetheric_hand_cannon_wwp_bullet_impact_cyan_lg" );
    level._effect[ "vfx_t10_bio_aetheric_hand_cannon_wwp_bullet_impact_green_lg" ] = loadfxasset( "vfx_t10_bio_aetheric_hand_cannon_wwp_bullet_impact_green_lg" );
    level._effect[ "vfx_sat_gameplay_zm_weapons_ww_hornet_zombie_despawning" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_ww_hornet_zombie_despawning" );
    level._effect[ "vfx_sat_gameplay_zm_weapons_ww_hornet_zombie_despawning_pap" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_ww_hornet_zombie_despawning_pap" );
    level._effect[ "vfx_sat_gameplay_zm_weapons_ww_hornet_cat_despawning" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_ww_hornet_cat_despawning" );
    level._effect[ "vfx_sat_gameplay_zm_weapons_ww_hornet_cat_despawning_pap" ] = loadfxasset( "vfx_sat_gameplay_zm_weapons_ww_hornet_cat_despawning_pap" );
    function_9b4624966e3115a6();
    
    if ( isdefined( level.hornetww_settings.weaponbasename ) )
    {
        level.var_f7d8c385fccc43b4[ level.hornetww_settings.weaponbasename ] = &function_d78bef54cdf54455;
    }
    
    /#
        initdevgui();
    #/
}

// Namespace weap_hornetww
// Params 1, eflags: 0x4
// Checksum 0x2a38df1e, Offset: 0x9f3
// Size: 0xc
function private init( weaponname )
{
    
}

// Namespace weap_hornetww
// Params 0, eflags: 0x4
// Checksum 0x89892c39, Offset: 0xa07
// Size: 0x342
function private function_9b4624966e3115a6()
{
    weaponname = utility::get_scripted_weapon_name( #"hash_42b246928818f1e0" );
    weaponobj = makeweapon( %"sat_ww_hornet_zm" );
    var_aa01a87b45ac522c = weaponobj.weaponcustomsettings;
    assert( isdefined( var_aa01a87b45ac522c ), "<dev string:x24>" );
    
    if ( !isdefined( level.hornetww_settings ) )
    {
        level.hornetww_settings = spawnstruct();
    }
    
    level.hornetww_settings.weaponbasename = weaponname;
    level.hornetww_settings.var_eadb663a1292c9e8 = %"sat_ww_hornet_zm";
    level.hornetww_settings.var_29d206d6922a3805 = var_aa01a87b45ac522c.var_d0eef22f2ee758b2 ?? 0;
    level.hornetww_settings.var_7d4f4c77bcd38756 = var_aa01a87b45ac522c.var_868cdad971d8b621 ?? 6;
    level.hornetww_settings.aftereffect_radius = var_aa01a87b45ac522c.aftereffectradius ?? 128;
    level.hornetww_settings.var_9493c4a580874e2 = var_aa01a87b45ac522c.var_74d9ade605377b15 ?? 112;
    level.hornetww_settings.var_7ace599a217147b7 = var_aa01a87b45ac522c.var_79031960f0790d70 ?? 48;
    level.hornetww_settings.var_1f224090544d1ff0 = var_aa01a87b45ac522c.var_d90ed53bda642d9f ?? 0;
    level.hornetww_settings.var_db56cf003806a5d6 = var_aa01a87b45ac522c.var_90bbb9d8a91b4b2d ?? 0.5;
    level.hornetww_settings.var_c00a886513d6c607 = var_aa01a87b45ac522c.var_7e159deb24bfc95c ?? 1000;
    level.hornetww_settings.var_5aa50488058a84f2 = var_aa01a87b45ac522c.var_eff72a217b0b6abd ?? 25;
    level.hornetww_settings.var_2d74ebbaf8d8443d = var_aa01a87b45ac522c.var_2a15eea52b756e9a ?? 0.3;
    level.hornetww_settings.var_2d74e8baf8d83da4 = var_aa01a87b45ac522c.var_2a15eda52b756c67 ?? 0.3;
    level.hornetww_settings.var_2d74e9baf8d83fd7 = var_aa01a87b45ac522c.var_2a15eca52b756a34 ?? 0.3;
    level.hornetww_settings.var_34955ac91ed75424 = var_aa01a87b45ac522c.var_e9b98383241516af ?? 20;
    level.hornetww_settings.var_14bd61c8c1999709 = var_aa01a87b45ac522c.var_c70ce4419a8e93b8 ?? 0.55;
    level.hornetww_settings.var_439dbdddc493e498 = var_aa01a87b45ac522c.var_b29c0255c5bfd9f3 ?? 5;
    level.hornetww_settings.var_834fc3a911cf2c81 = var_aa01a87b45ac522c.var_ef681d12adeee5a ?? 1;
    level.hornetww_settings.var_93ef5f95a3832b86 = var_aa01a87b45ac522c.var_c11cd84709f06a0f ?? 10;
    level.hornetww_settings.var_4b886b6679b02412 = getdvarint( @"hash_c799f4b904886667", 0 );
}

// Namespace weap_hornetww
// Params 1, eflags: 0x4
// Checksum 0xb5c9c3b5, Offset: 0xd51
// Size: 0x12f
function private function_b11e158b20286a04( params )
{
    if ( ishornetww( params.objweapon ) )
    {
        if ( params.idamage >= self.health )
        {
            if ( isplayer( params.eattacker ) )
            {
                player = params.eattacker;
                paplevel = player utility::callsharedfunc( #"zombie", #"get_pap_level", params.objweapon );
                var_43f1451c6ba5d1eb = function_669bc1fc06409313( paplevel, player );
            }
            
            if ( !var_43f1451c6ba5d1eb )
            {
                utility::ent_flag_set( "dissolve_purple_glow" );
            }
        }
        else if ( isdefined( params.smeansofdeath ) && isdefined( params.eattacker ) && params.smeansofdeath == "MOD_MELEE" && !utility::ent_flag( "hornetww_melee_subsequent_hits_started" ) )
        {
            utility::ent_flag_set( "hornetww_melee_subsequent_hits_started" );
            function_8436d4132bfa9e24( params.eattacker, params.shitloc );
        }
    }
    
    return params.idamage;
}

// Namespace weap_hornetww
// Params 1, eflags: 0x4
// Checksum 0x6a9b3ee6, Offset: 0xe89
// Size: 0x10a
function private function_188e90d63e7d31bf( params )
{
    if ( ishornetww( params.objweapon ) )
    {
        if ( utility::ent_flag( "dissolve_purple_glow" ) )
        {
            body = zombie_utils::function_4e99fb1239980783( params );
            
            if ( isdefined( body ) )
            {
                paplevel = params.eattacker utility::callsharedfunc( #"zombie", #"get_pap_level", params.objweapon );
                
                if ( paplevel )
                {
                    body utility::function_32b24db3127bff40( "dissipate_purple_pap", "on" );
                }
                else
                {
                    body utility::function_32b24db3127bff40( "dissipate_purple", "on" );
                }
                
                body utility::function_32b24db3127bff40( "reveal_death_purple_glow", "reveal_death_purple_glow" );
            }
        }
        
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

// Namespace weap_hornetww
// Params 1, eflags: 0x4
// Checksum 0xe0f39208, Offset: 0xf9b
// Size: 0x14b
function private function_7cc28fd9819579a6( params )
{
    var_c6b711dce59bf0a2 = params.lastweapon.basename == level.hornetww_settings.var_eadb663a1292c9e8;
    var_ba861cc20af9857b = params.weapon.basename == level.hornetww_settings.var_eadb663a1292c9e8;
    
    if ( !var_c6b711dce59bf0a2 && var_ba861cc20af9857b )
    {
        thread function_d336bed034e3319f();
        thread function_33e6a356f8b904ce();
        thread ww_shared::function_3472b693f638483a( "sat_ww_hornet", "ww_hornet_ambient", "on", "off" );
        thread function_683d22c5bdcc91b4();
        self.var_653219bf610c4f99 = &function_9c940b8c2e8201d3;
    }
    else if ( var_c6b711dce59bf0a2 && !var_ba861cc20af9857b )
    {
        thread ww_shared::function_50a43e11790d1a15( "sat_ww_hornet", "ww_hornet_ambient", "off" );
        utility::ent_flag_clear( "hornetww_alt_charging" );
        self notify( #"hash_75d480ee82ac915" );
        self notify( #"hash_9200a8b4c618cd9f" );
        self notify( #"hash_d23822125de385de" );
        
        if ( !self.inlaststand )
        {
            self.var_653219bf610c4f99 = undefined;
        }
    }
    
    if ( var_ba861cc20af9857b )
    {
        function_bcb852441042cc1d( params.weapon.basename );
    }
}

// Namespace weap_hornetww
// Params 1, eflags: 0x4
// Checksum 0x85a117af, Offset: 0x10ee
// Size: 0x20
function private function_fa4af58300f69a04( params )
{
    if ( isdefined( self.var_653219bf610c4f99 ) )
    {
        thread function_ffba21093df64bfa();
    }
}

// Namespace weap_hornetww
// Params 0, eflags: 0x4
// Checksum 0x5bfd0a7, Offset: 0x1116
// Size: 0x1d
function private function_ffba21093df64bfa()
{
    self endon( #"death_or_disconnect" );
    waitframe();
    self.var_653219bf610c4f99 = &function_9c940b8c2e8201d3;
}

// Namespace weap_hornetww
// Params 1, eflags: 0x4
// Checksum 0x403bf3a8, Offset: 0x113b
// Size: 0xc
function private function_d60591cf7244374a( params )
{
    
}

// Namespace weap_hornetww
// Params 1, eflags: 0x4
// Checksum 0x6721a3dd, Offset: 0x114f
// Size: 0x176
function private function_d78bef54cdf54455( dmg_struct )
{
    idamage = dmg_struct.idamage;
    
    if ( dmg_struct.smeansofdeath == "MOD_RIFLE_BULLET" )
    {
        loc = function_406f1f61c1e23012( dmg_struct.partname );
        
        if ( loc )
        {
            dmg_struct.shitloc = loc;
            dmg_struct.metabonename = metabone::get_metabone_name( dmg_struct.shitloc, dmg_struct.partname, dmg_struct.vpoint, dmg_struct.vdir );
            idamage = zombie_damage::function_f618f57aa5bae72a( dmg_struct );
            
            if ( dmg_struct.biscritical )
            {
                idamage *= 2.85;
            }
        }
    }
    
    if ( dmg_struct.biscritical && dmg_struct.smeansofdeath == "MOD_MELEE" )
    {
        idamage = idamage / 1.5 * 2;
    }
    
    if ( isplayer( dmg_struct.eattacker ) && dmg_struct.smeansofdeath == "MOD_MELEE" )
    {
        var_951c89546ec50477 = dmg_struct.eattacker utility::callsharedfunc( #"zombie", #"get_pap_level", dmg_struct.objweapon );
        
        if ( var_951c89546ec50477 )
        {
            idamage *= zombie_damage::function_dcee44724d9edddd( dmg_struct.objweapon, var_951c89546ec50477 );
        }
    }
    
    return idamage;
}

// Namespace weap_hornetww
// Params 1, eflags: 0x4
// Checksum 0x28efea46, Offset: 0x12ce
// Size: 0x1e6
function private function_406f1f61c1e23012( partname )
{
    if ( !level.var_a7c0079a79e955ea )
    {
        map = [];
        map[ #"j_head" ] = "head";
        map[ #"j_neck" ] = "neck";
        map[ #"j_neck2" ] = "neck";
        map[ #"hash_d7380f9cbc886f22" ] = "neck";
        map[ #"j_spinelower" ] = "torso_lower";
        map[ #"j_spinelower_2" ] = "torso_lower";
        map[ #"j_spine4" ] = "torso_lower";
        map[ #"j_spineupper" ] = "torso_upper";
        map[ #"j_spineupper_2" ] = "torso_upper";
        map[ #"j_clavicle_le" ] = "left_arm_upper";
        map[ #"j_shoulder_le" ] = "left_arm_upper";
        map[ #"j_elbow_le" ] = "left_arm_lower";
        map[ #"j_wrist_le" ] = "left_hand";
        map[ #"j_clavicle_ri" ] = "right_arm_upper";
        map[ #"j_shoulder_ri" ] = "right_arm_upper";
        map[ #"j_elbow_ri" ] = "right_arm_lower";
        map[ #"j_wrist_ri" ] = "right_hand";
        map[ #"j_hip_le" ] = "left_leg_upper";
        map[ #"j_knee_le" ] = "left_leg_lower";
        map[ #"j_ankle_le" ] = "left_foot";
        map[ #"j_ball_le" ] = "left_foot";
        map[ #"j_hip_ri" ] = "right_leg_upper";
        map[ #"j_knee_ri" ] = "right_leg_lower";
        map[ #"j_ankle_ri" ] = "right_foot";
        map[ #"j_ball_ri" ] = "right_foot";
        level.var_a7c0079a79e955ea = map;
    }
    
    return level.var_a7c0079a79e955ea[ partname ];
}

// Namespace weap_hornetww
// Params 1, eflags: 0x4
// Checksum 0x1d4c8452, Offset: 0x14bd
// Size: 0xd0
function private function_e9436de6576b5061( params )
{
    if ( isdefined( params.spawnoptions ) && ( isstruct( params.itembundle ) && isdefined( params.itembundle.ref ) && params.itembundle.ref == "sat_ww_hornet" || isdefined( params.spawnoptions.weapon ) && ishornetww( params.spawnoptions.weapon ) ) )
    {
        params.spawnoptions.var_8d4f327170228364 = 1;
        params.spawnoptions.var_fd47e835523b473f = 1;
    }
}

// Namespace weap_hornetww
// Params 1, eflags: 0x4
// Checksum 0xa5847982, Offset: 0x1595
// Size: 0xcb
function private function_f6f3a3b7680e70c8( params )
{
    if ( isdefined( params.objweapon ) && isdefined( params.instance.origin ) && ishornetww( params.objweapon ) )
    {
        if ( isdefined( params.instance.var_951c89546ec50477 ) && params.instance.var_951c89546ec50477 > 0 )
        {
            playfx( utility::getfx( "vfx_sat_gameplay_zm_weapons_ww_hornet_cat_despawning_pap" ), params.instance.origin );
            return;
        }
        
        playfx( utility::getfx( "vfx_sat_gameplay_zm_weapons_ww_hornet_cat_despawning" ), params.instance.origin );
    }
}

// Namespace weap_hornetww
// Params 1, eflags: 0x4
// Checksum 0x51a3fa60, Offset: 0x1668
// Size: 0x53
function private function_df78424314c3a01f( params )
{
    if ( isdefined( params.player ) && ishornetww( params.player getcurrentweapon() ) && randomint( 100 ) < 20 )
    {
        params.player thread playreloadvo();
    }
}

// Namespace weap_hornetww
// Params 1, eflags: 0x4
// Checksum 0x3594a144, Offset: 0x16c3
// Size: 0x32
function private function_7185245dd62fe997( params )
{
    if ( utility::ent_flag( "hornetww_reloadVO_playing" ) )
    {
        utility::ent_flag_clear( "hornetww_reloadVO_playing" );
        self notify( #"hash_dbbf941e120fd24" );
    }
}

// Namespace weap_hornetww
// Params 0, eflags: 0x4
// Checksum 0x8bcee6b5, Offset: 0x16fd
// Size: 0x7d
function private function_33e6a356f8b904ce()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_75d480ee82ac915" );
    
    while ( true )
    {
        self waittill( #"projectile_impact", objweapon, position, radius );
        
        if ( isdefined( position ) && isdefined( objweapon ) && ishornetww( objweapon ) )
        {
            thread function_66db211189de8a2a( position, objweapon );
        }
    }
}

// Namespace weap_hornetww
// Params 0, eflags: 0x4
// Checksum 0xdb15a09c, Offset: 0x1782
// Size: 0xbe
function private function_d336bed034e3319f()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_75d480ee82ac915" );
    
    while ( true )
    {
        self waittill( #"missile_fire", projectile, weapon );
        
        if ( isdefined( projectile ) && ishornetww( weapon ) && weapon.isalternate )
        {
            projectile thread watch_projectile_impact_ai( self, weapon );
        }
        
        if ( level.hornetww_settings.var_23366fc8363b2fd6 && !weapon.isalternate )
        {
            level thread [[ level.hornetww_settings.var_23366fc8363b2fd6 ]]( self, projectile );
        }
    }
}

// Namespace weap_hornetww
// Params 2, eflags: 0x4
// Checksum 0xdb28303f, Offset: 0x1848
// Size: 0xa7
function private watch_projectile_impact_ai( attacker, weapon )
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    
    if ( !isdefined( attacker.team ) )
    {
        return;
    }
    
    self waittill( #"projectile_impact_ai", ai );
    
    if ( ai.team == attacker.team )
    {
        return;
    }
    
    if ( isalive( ai ) )
    {
        enemycentroid = ai getcentroid();
        ai dodamage( 6000, enemycentroid, attacker, attacker, "MOD_ELEMENTAL_TOXIC", weapon, "torso_upper", undefined, 0 );
    }
}

// Namespace weap_hornetww
// Params 0, eflags: 0x4
// Checksum 0xdb8ac8fe, Offset: 0x18f7
// Size: 0x93
function private function_683d22c5bdcc91b4()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_75d480ee82ac915" );
    
    while ( true )
    {
        self waittill( #"hash_69562b0de38a064f", var_897f0094d6449e93 );
        
        switch ( var_897f0094d6449e93 )
        {
            case 0:
            case 1:
                utility::ent_flag_set( "hornetww_alt_charging" );
                break;
            case 2:
                utility::ent_flag_clear( "hornetww_alt_charging" );
                break;
        }
    }
}

// Namespace weap_hornetww
// Params 1, eflags: 0x4
// Checksum 0x3930813b, Offset: 0x1992
// Size: 0x1e
function private delay_endon( string )
{
    self waittill( string );
    waitframe();
    self notify( "delay_" + string );
}

// Namespace weap_hornetww
// Params 2, eflags: 0x4
// Checksum 0xeaa15146, Offset: 0x19b8
// Size: 0x27f
function private function_66db211189de8a2a( var_5af6b922a5f05e03, weapon )
{
    if ( !isdefined( var_5af6b922a5f05e03 ) )
    {
        return;
    }
    
    wait level.hornetww_settings.var_29d206d6922a3805;
    trace = trace::ray_trace( var_5af6b922a5f05e03, var_5af6b922a5f05e03 - ( 0, 0, 10000 ) );
    var_c1ec687a69da7cc = var_5af6b922a5f05e03;
    
    if ( isdefined( trace[ "position" ] ) && isdefined( trace[ "normal" ] ) && trace[ "fraction" ] < 0.99 )
    {
        var_c1ec687a69da7cc = trace[ "position" ];
    }
    
    var_b256fa75affad232 = spawnscriptable( "zm_sat_hornet_ww_after_effect", var_c1ec687a69da7cc );
    
    if ( var_b256fa75affad232 getscriptablehaspart( "spawn" ) )
    {
        paplevel = utility::callsharedfunc( #"zombie", #"get_pap_level", weapon );
        
        if ( paplevel && var_b256fa75affad232 getscriptableparthasstate( "spawn", "spawn_vfx_pap" ) )
        {
            var_b256fa75affad232 setscriptablepartstate( "spawn", "spawn_vfx_pap" );
        }
        else if ( var_b256fa75affad232 getscriptableparthasstate( "spawn", "spawn_vfx" ) )
        {
            var_b256fa75affad232 setscriptablepartstate( "spawn", "spawn_vfx" );
        }
    }
    
    if ( randomint( 100 ) < 50 )
    {
        thread function_c7334413b73ed832();
    }
    
    params = spawnstruct();
    params.origin = var_c1ec687a69da7cc;
    params.radius = level.hornetww_settings.aftereffect_radius;
    params.player = self;
    level callback::callback( #"hash_5858086109ce3b47", params );
    [ cylinderposition, cylinderhalfheight ] = function_177941a3f8934cee( var_c1ec687a69da7cc );
    var_b256fa75affad232 thread function_551c8162c2034901( weapon, self, cylinderposition, cylinderhalfheight );
    
    /#
        if ( level.hornetww_settings.var_4b886b6679b02412 )
        {
            debug::sphere( var_c1ec687a69da7cc, 5, ( 1, 1, 1 ), level.hornetww_settings.var_7d4f4c77bcd38756 );
            debug::cylinder( cylinderposition + ( 0, 0, cylinderhalfheight * -1 ), cylinderposition + ( 0, 0, cylinderhalfheight ), level.hornetww_settings.aftereffect_radius, ( 0.5, 0, 1 ), level.hornetww_settings.var_7d4f4c77bcd38756 );
        }
    #/
    
    wait level.hornetww_settings.var_7d4f4c77bcd38756;
    var_b256fa75affad232 thread function_f690ee04df03d050();
}

// Namespace weap_hornetww
// Params 0, eflags: 0x4
// Checksum 0xe1ce152c, Offset: 0x1c3f
// Size: 0x5b
function private function_c7334413b73ed832()
{
    level endon( #"game_ended" );
    wait 2;
    
    if ( !utility::ent_flag( "hornetww_alt_charging" ) && !level utility::flag( "hornetww_VO_substitution_cooldown" ) && !dialogue::is_speaking() )
    {
        thread function_262c3547b6ecaa22();
        dialogue::say( "dx_zm_nmta_ankm_nkmt_ainkmthgr", undefined, undefined, undefined, undefined, "global" );
    }
}

// Namespace weap_hornetww
// Params 4, eflags: 0x4
// Checksum 0xcfee8766, Offset: 0x1ca2
// Size: 0x1bc
function private function_551c8162c2034901( weapon, owningplayer, cylinderposition, cylinderhalfheight )
{
    level endon( #"game_ended" );
    
    if ( level.hornetww_settings.var_db56cf003806a5d6 <= 0 || level.hornetww_settings.var_c00a886513d6c607 <= 0 )
    {
        assertmsg( "<dev string:x58>" );
        return;
    }
    
    waitframe();
    wait level.hornetww_settings.var_1f224090544d1ff0;
    var_8eecb1c40b4c542b = [];
    
    while ( isdefined( self.origin ) )
    {
        enemies = function_51b8ce76eb43aed5( cylinderposition, level.hornetww_settings.aftereffect_radius, cylinderhalfheight, 1 );
        currenttime = gettime();
        
        foreach ( enemy in enemies )
        {
            if ( !isdefined( enemy.var_52129ac9f1901e7d ) || currenttime - enemy.var_52129ac9f1901e7d >= utility::function_4b74c15943231980( level.hornetww_settings.var_db56cf003806a5d6 ) )
            {
                enemy.var_52129ac9f1901e7d = currenttime;
                var_8eecb1c40b4c542b[ var_8eecb1c40b4c542b.size ] = enemy;
                continue;
            }
            
            enemies = arrayremove( enemies, enemy );
        }
        
        childthread function_29db4a3496b61d36( enemies, weapon, owningplayer );
        wait level.hornetww_settings.var_db56cf003806a5d6;
    }
}

// Namespace weap_hornetww
// Params 3, eflags: 0x4
// Checksum 0xe7e5420c, Offset: 0x1e66
// Size: 0x110
function private function_29db4a3496b61d36( enemies, weapon, owningplayer )
{
    var_7e159deb24bfc95c = level.hornetww_settings.var_c00a886513d6c607;
    var_15f4a7ac488c666e = level.hornetww_settings.var_db56cf003806a5d6 / 20;
    var_35738132b66457d7 = int( ceil( enemies.size / 20 ) );
    var_33e09dc01454f2a5 = 0;
    
    while ( var_33e09dc01454f2a5 < enemies.size )
    {
        for ( i = 0; i < var_35738132b66457d7 ; i++ )
        {
            if ( var_33e09dc01454f2a5 >= enemies.size )
            {
                break;
            }
            
            enemy = enemies[ var_33e09dc01454f2a5 ];
            
            if ( isai( enemy ) && isalive( enemy ) && isdefined( enemy.origin ) )
            {
                enemycentroid = enemy getcentroid();
                enemy dodamage( var_7e159deb24bfc95c, enemycentroid, owningplayer, owningplayer, "MOD_ELEMENTAL_TOXIC", weapon, "torso_upper", undefined, 1 );
            }
            
            var_33e09dc01454f2a5++;
        }
        
        wait var_15f4a7ac488c666e;
    }
}

// Namespace weap_hornetww
// Params 0, eflags: 0x4
// Checksum 0x6902f500, Offset: 0x1f7e
// Size: 0x29
function private function_f690ee04df03d050()
{
    level endon( #"game_ended" );
    waitframe();
    self notify( #"death" );
    
    if ( self getscriptableisreserved() )
    {
        self freescriptable();
    }
}

// Namespace weap_hornetww
// Params 0, eflags: 0x4
// Checksum 0xb272d58, Offset: 0x1faf
// Size: 0x76
function private function_1c32167b5997cf4f()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_9200a8b4c618cd9f" );
    
    while ( true )
    {
        self waittill( #"melee_fired", objweapon );
        
        if ( objweapon.basenamehash == level.hornetww_settings.var_eadb663a1292c9e8 )
        {
            function_8436d4132bfa9e24( self, "torso_upper" );
        }
    }
}

// Namespace weap_hornetww
// Params 2, eflags: 0x4
// Checksum 0x51e3057, Offset: 0x202d
// Size: 0x207
function private function_8436d4132bfa9e24( player, hitloc )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    self endon( #"death", #"entitydeleted" );
    level endon( #"hash_f5d3f78e8890bfd3" );
    weapon = player getcurrentweapon();
    var_8256172abbc54d07 = player function_61655f0f57ca09ff( weapon );
    wait level.hornetww_settings.var_2d74ebbaf8d8443d;
    
    if ( player )
    {
        fx_position = player.origin + anglestoforward( player.angles ) * 64;
        
        /#
            if ( level.hornetww_settings.var_4b886b6679b02412 )
            {
                debug::sphere( fx_position, 16, ( 1, 0.2, 0.2 ), 20 );
            }
        #/
        
        level thread melee_hit( player, player issprinting(), weapon, var_8256172abbc54d07, hitloc );
    }
    
    wait level.hornetww_settings.var_2d74e8baf8d83da4;
    
    if ( player )
    {
        fx_position = player.origin + anglestoforward( player.angles ) * 84;
        
        /#
            if ( level.hornetww_settings.var_4b886b6679b02412 )
            {
                debug::sphere( fx_position, 16, ( 0, 1, 0 ), 20 );
            }
        #/
        
        level thread melee_hit( player, player issprinting(), weapon, var_8256172abbc54d07, hitloc );
    }
    
    wait level.hornetww_settings.var_2d74e9baf8d83fd7;
    
    if ( player )
    {
        fx_position = player.origin + anglestoforward( player.angles ) * 104;
        
        /#
            if ( level.hornetww_settings.var_4b886b6679b02412 )
            {
                debug::sphere( fx_position, 16, ( 0, 0, 1 ), 20 );
            }
        #/
        
        level thread melee_hit( player, player issprinting(), weapon, var_8256172abbc54d07, hitloc );
    }
    
    waitframe();
    utility::ent_flag_clear( "hornetww_melee_subsequent_hits_started" );
}

// Namespace weap_hornetww
// Params 0, eflags: 0x4
// Checksum 0xb5a5599b, Offset: 0x223c
// Size: 0xb3
function private function_cd23086a9753e9f3()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    level endon( #"hash_d23822125de385de" );
    
    while ( true )
    {
        self waittill( #"hash_4e52ef1568567153" );
        
        if ( self )
        {
            fx_position = self.origin + anglestoforward( self.angles ) * 64;
            
            /#
                debug::sphere( fx_position, 16, ( 1, 0.2, 0.2 ), 20 );
            #/
            
            weapon = self getcurrentweapon();
            var_8256172abbc54d07 = self function_61655f0f57ca09ff( weapon );
            level thread melee_hit( self, self issprinting(), weapon, var_8256172abbc54d07 );
        }
    }
}

// Namespace weap_hornetww
// Params 0, eflags: 0x4
// Checksum 0xc2a277ea, Offset: 0x22f7
// Size: 0xb3
function private function_cd23076a9753e7c0()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    level endon( #"hash_d23822125de385de" );
    
    while ( true )
    {
        self waittill( #"hash_4e52ee1568566fa0" );
        
        if ( self )
        {
            fx_position = self.origin + anglestoforward( self.angles ) * 84;
            
            /#
                debug::sphere( fx_position, 16, ( 0, 1, 0 ), 20 );
            #/
            
            weapon = self getcurrentweapon();
            var_8256172abbc54d07 = self function_61655f0f57ca09ff( weapon );
            level thread melee_hit( self, self issprinting(), weapon, var_8256172abbc54d07 );
        }
    }
}

// Namespace weap_hornetww
// Params 0, eflags: 0x4
// Checksum 0x5bab3d75, Offset: 0x23b2
// Size: 0xb3
function private function_cd230a6a9753ee59()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    level endon( #"hash_d23822125de385de" );
    
    while ( true )
    {
        self waittill( #"hash_4e52f115685674b9" );
        
        if ( self )
        {
            fx_position = self.origin + anglestoforward( self.angles ) * 104;
            
            /#
                debug::sphere( fx_position, 16, ( 0, 0, 1 ), 20 );
            #/
            
            weapon = self getcurrentweapon();
            var_8256172abbc54d07 = self function_61655f0f57ca09ff( weapon );
            level thread melee_hit( self, self issprinting(), weapon, var_8256172abbc54d07 );
        }
    }
}

// Namespace weap_hornetww
// Params 5
// Checksum 0x33baaee0, Offset: 0x246d
// Size: 0xb1
function melee_hit( player, issprinting, weapon, var_8256172abbc54d07, hitloc )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    playerforward = anglestoforward( player getplayerangles() );
    trace_position_start = playerforward * 10 + player geteye();
    
    if ( issprinting )
    {
        trace_position_end = playerforward * 0 + player geteye();
    }
    else
    {
        trace_position_end = playerforward * 48 + player geteye();
    }
    
    level thread function_acad3993d7ef37c9( player, weapon, trace_position_start, trace_position_end, undefined, hitloc );
}

// Namespace weap_hornetww
// Params 6
// Checksum 0xe501e8ea, Offset: 0x2526
// Size: 0x44b
function function_acad3993d7ef37c9( player, weapon, trace_position, trace_position_end, var_32120addd78eb2d8, hitloc )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( var_32120addd78eb2d8 ) )
    {
        var_32120addd78eb2d8 = 30;
    }
    
    if ( !isdefined( trace_position_end ) )
    {
        trace_position_end = trace_position;
    }
    
    trace = trace::sphere_trace_get_all_results( trace_position, trace_position_end, var_32120addd78eb2d8, player, undefined, undefined, 1 );
    zombies = [];
    hit_players = [];
    hit_entities = [];
    hit_scriptables = [];
    
    foreach ( trace_result in trace )
    {
        if ( isplayer( trace_result[ "entity" ] ) && trace_result[ "entity" ].team != player.team )
        {
            hit_players[ hit_players.size ] = trace_result[ "entity" ];
            b_hit_anything = 1;
            continue;
        }
        
        if ( isai( trace_result[ "entity" ] ) && isalive( trace_result[ "entity" ] ) && !isdefined( trace_result[ "entity" ].var_bd22ba6c600a23a3 ) )
        {
            if ( trace_result[ "entity" ] val::get( "damage" ) )
            {
                zombies[ zombies.size ] = trace_result[ "entity" ];
                b_hit_anything = 1;
            }
            
            continue;
        }
        
        if ( isent( trace_result[ "entity" ] ) )
        {
            hit_entities[ hit_entities.size ] = trace_result[ "entity" ];
            b_hit_anything = 1;
            continue;
        }
        
        if ( isdefined( trace_result[ "scriptable" ] ) )
        {
            hit_scriptables[ hit_scriptables.size ] = trace_result[ "scriptable" ];
            b_hit_anything = 1;
        }
    }
    
    foreach ( hitplayer in hit_players )
    {
        if ( isalive( hitplayer ) )
        {
        }
    }
    
    foreach ( entity in hit_entities )
    {
        if ( isent( entity ) )
        {
        }
    }
    
    foreach ( scriptable in hit_scriptables )
    {
        if ( isdefined( scriptable ) )
        {
            scriptable scriptabledodamage( 100, player, player, undefined, undefined, "MOD_MELEE", weapon );
        }
    }
    
    if ( zombies.size <= 0 )
    {
        return;
    }
    
    zombies = utility::array_removedead_or_dying( zombies );
    enemy_zombies = [];
    
    foreach ( zombie in zombies )
    {
        if ( zombie zombie_utils::function_bf1464d09f4e4b40() || zombie.team == player.team )
        {
            continue;
        }
        
        enemy_zombies[ enemy_zombies.size ] = zombie;
    }
    
    zombies = enemy_zombies;
    
    if ( isplayer( player ) )
    {
        zombies = utility::get_array_of_closest( player.origin, zombies, undefined, undefined, 100 );
        var_f792509d72a84f58 = player function_a6b07e59fe0d8016( zombies );
    }
    
    level thread function_528fae578354c46a( var_f792509d72a84f58, player, trace_position, weapon, hitloc );
}

// Namespace weap_hornetww
// Params 1
// Checksum 0x389b3cf, Offset: 0x2979
// Size: 0x117
function function_a6b07e59fe0d8016( array )
{
    assert( isdefined( self.origin ) && isdefined( self.angles ) );
    closest_dot = -1;
    closest_object = undefined;
    
    if ( isplayer( self ) )
    {
        forward = anglestoforward( self getplayerangles() );
        
        foreach ( object in array )
        {
            dir = vectornormalize( ( object gettagorigin( "j_spine4", 1 ) ?? object.origin ) - self geteye() );
            dot = vectordot( forward, dir );
            
            if ( dot >= closest_dot )
            {
                closest_dot = dot;
                closest_object = object;
            }
        }
    }
    
    return closest_object;
}

// Namespace weap_hornetww
// Params 5
// Checksum 0x8be70a91, Offset: 0x2a99
// Size: 0x83
function function_528fae578354c46a( zombie, player, trace_position = undefined, weapon, hitloc )
{
    if ( isai( zombie ) && isalive( zombie ) && isdefined( zombie.subclass ) )
    {
        meleedamage = weapon function_a7bd968152df51af();
        zombie dodamage( meleedamage, trace_position, player, player, "MOD_MELEE", weapon, hitloc, undefined, 0 );
    }
}

// Namespace weap_hornetww
// Params 2, eflags: 0x4
// Checksum 0xc282dd0d, Offset: 0x2b24
// Size: 0xbc
function private function_669bc1fc06409313( paplevel, player )
{
    if ( !function_3d17693f0cc54c68() )
    {
        return;
    }
    
    var_43f1451c6ba5d1eb = ( !isdefined( level.var_7bc412eb0d83936e ) || level.var_7bc412eb0d83936e.size < level.hornetww_settings.var_93ef5f95a3832b86 ) && randomint( 100 ) < level.hornetww_settings.var_34955ac91ed75424;
    
    if ( var_43f1451c6ba5d1eb )
    {
        self.nocorpse = 1;
        v_origin = self.origin;
        v_angles = self.angles;
        thread function_348d980bb53417b7( v_origin, v_angles, paplevel, player );
    }
    
    return var_43f1451c6ba5d1eb;
}

// Namespace weap_hornetww
// Params 0, eflags: 0x4
// Checksum 0x1c3b7172, Offset: 0x2be9
// Size: 0x32, Type: bool
function private function_3d17693f0cc54c68()
{
    return isdefined( self.basearchetype ) && ( self.basearchetype == "zombie_base" || self.basearchetype == "zombie_hellhound" );
}

#using_animtree( "zm_sat_hornet_scriptables" );

// Namespace weap_hornetww
// Params 4, eflags: 0x4
// Checksum 0x8cf4da8, Offset: 0x2c24
// Size: 0x252
function private function_348d980bb53417b7( origin, angles, paplevel, player )
{
    level endon( #"game_ended" );
    tagposition = self gettagorigin( "j_spine4" );
    
    if ( paplevel )
    {
        playfx( utility::getfx( "vfx_sat_gameplay_zm_weapons_ww_hornet_zombie_despawning_pap" ), tagposition );
    }
    else
    {
        playfx( utility::getfx( "vfx_sat_gameplay_zm_weapons_ww_hornet_zombie_despawning" ), tagposition );
    }
    
    wait level.hornetww_settings.var_14bd61c8c1999709;
    trace = trace::ray_trace( tagposition, tagposition - ( 0, 0, 10000 ) );
    transformationposition = origin;
    
    if ( isdefined( trace[ "position" ] ) && isdefined( trace[ "normal" ] ) && trace[ "fraction" ] < 0.99 )
    {
        transformationposition = trace[ "position" ];
    }
    
    spawned_mdl = utility::spawn_model( %"hash_7f61b34b0eb45697", transformationposition, angles );
    spawned_mdl.owner = self;
    params = spawnstruct();
    params.transformed_ai = spawned_mdl;
    params.player = player;
    level callback::callback( "hornetww_enemy_transformed", params );
    
    if ( !isdefined( level.var_7bc412eb0d83936e ) )
    {
        level.var_7bc412eb0d83936e = [];
    }
    
    level.var_7bc412eb0d83936e[ level.var_7bc412eb0d83936e.size ] = spawned_mdl;
    spawned_mdl thread function_2e9f68e848c8e907( paplevel );
    spawned_mdl endon( #"hash_2ad46c614bd2d2fc" );
    spawned_mdl utility::function_32b24db3127bff40( "animation", "spawn" );
    animlength = getanimlength( %sat_fxanim_zm_hornet_transformation_drop_roar_01 );
    
    if ( isdefined( animlength ) )
    {
        wait animlength;
    }
    
    var_e01bcfa01bb4f68c = randomint( 3 );
    
    if ( var_e01bcfa01bb4f68c == 1 || var_e01bcfa01bb4f68c == 2 )
    {
        spawned_mdl utility::function_32b24db3127bff40( "animation", "circle" );
        animlength = getanimlength( %sat_fxanim_zm_hornet_transformation_circle_loop_02 );
        
        if ( isdefined( animlength ) )
        {
            wait animlength;
        }
    }
    
    if ( var_e01bcfa01bb4f68c == 2 )
    {
        spawned_mdl utility::function_32b24db3127bff40( "animation", "circle" );
        animlength = getanimlength( %sat_fxanim_zm_hornet_transformation_circle_loop_02 );
        
        if ( isdefined( animlength ) )
        {
            wait animlength;
        }
    }
    
    spawned_mdl utility::function_32b24db3127bff40( "animation", "sit" );
}

// Namespace weap_hornetww
// Params 1, eflags: 0x4
// Checksum 0xe8ede723, Offset: 0x2e7e
// Size: 0x10d
function private function_2e9f68e848c8e907( paplevel )
{
    level endon( #"game_ended" );
    self endon( #"death", #"entitydeleted" );
    var_2574a7923ac9fb40 = randomfloatrange( level.hornetww_settings.var_834fc3a911cf2c81 * -1, level.hornetww_settings.var_834fc3a911cf2c81 );
    timerduration = level.hornetww_settings.var_439dbdddc493e498 + var_2574a7923ac9fb40;
    utility::waittill_any_timeout( timerduration, "death" );
    self notify( #"hash_2ad46c614bd2d2fc" );
    tagposition = self gettagorigin( "tag_origin" );
    
    if ( paplevel )
    {
        playfx( utility::getfx( "vfx_sat_gameplay_zm_weapons_ww_hornet_cat_despawning_pap" ), tagposition );
    }
    else
    {
        playfx( utility::getfx( "vfx_sat_gameplay_zm_weapons_ww_hornet_cat_despawning" ), tagposition );
    }
    
    playsoundatpos( tagposition, #"hash_25b2334a431ab8e8" );
    level.var_7bc412eb0d83936e = arrayremove( level.var_7bc412eb0d83936e, self );
    self delete();
}

// Namespace weap_hornetww
// Params 1, eflags: 0x4
// Checksum 0x5dd47288, Offset: 0x2f93
// Size: 0x50, Type: bool
function private ishornetww( weapon )
{
    if ( !isweapon( weapon ) )
    {
        return false;
    }
    
    if ( !isdefined( weapon.basename ) )
    {
        return false;
    }
    
    if ( weapon.basename == level.hornetww_settings.var_eadb663a1292c9e8 )
    {
        return true;
    }
    
    return false;
}

// Namespace weap_hornetww
// Params 1, eflags: 0x4
// Checksum 0xccfe4e3f, Offset: 0x2fec
// Size: 0x95
function private function_177941a3f8934cee( var_5f8bc94d517962e4 )
{
    if ( !isdefined( var_5f8bc94d517962e4 ) )
    {
        return 0;
    }
    
    fullheight = level.hornetww_settings.var_9493c4a580874e2 + level.hornetww_settings.var_7ace599a217147b7;
    halfheight = fullheight >> 1;
    var_d44482976ac01481 = halfheight - level.hornetww_settings.var_7ace599a217147b7;
    centerposition = var_5f8bc94d517962e4 + ( 0, 0, var_d44482976ac01481 );
    return [ centerposition, halfheight ];
}

// Namespace weap_hornetww
// Params 1, eflags: 0x4
// Checksum 0x78bf66d8, Offset: 0x308a
// Size: 0x45
function private function_bcb852441042cc1d( weapon_name )
{
    key = weapon_name + "_tutorial_message_has_displayed";
    
    if ( !utility::ent_flag( key ) )
    {
        utility::ent_flag_set( key );
        thread ww_shared::show_hud_tutorial_message( &"hash_30172552445f352c" );
    }
}

// Namespace weap_hornetww
// Params 0, eflags: 0x4
// Checksum 0x90ce4118, Offset: 0x30d7
// Size: 0x84
function private playreloadvo()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_dbbf941e120fd24" );
    wait 0.65;
    
    if ( self isreloading() && !dialogue::is_speaking() && !level utility::flag( "hornetww_VO_substitution_cooldown" ) )
    {
        utility::ent_flag_set( "hornetww_reloadVO_playing" );
        thread function_262c3547b6ecaa22();
        dialogue::say( "dx_zm_nmta_ankm_nkmt_ainkmtrld", undefined, undefined, undefined, undefined, "global" );
        utility::ent_flag_clear( "hornetww_reloadVO_playing" );
        self notify( #"hash_dbbf941e120fd24" );
    }
}

// Namespace weap_hornetww
// Params 2, eflags: 0x4
// Checksum 0x2854becf, Offset: 0x3163
// Size: 0x329, Type: bool
function private function_9c940b8c2e8201d3( var_dfd3675a95b714ad, startdelay )
{
    if ( level utility::flag( "hornetww_VO_substitution_cooldown" ) || dialogue::is_speaking() )
    {
        return false;
    }
    
    if ( var_dfd3675a95b714ad == #"hash_2fc2f827b9e17ed4" )
    {
        thread function_262c3547b6ecaa22();
        function_904af5f8a88af91f( "dx_zm_nmta_ankm_nkmt_ainkmtppr", startdelay );
        return true;
    }
    
    if ( !( randomint( 100 ) < 65 ) )
    {
        return false;
    }
    
    if ( var_dfd3675a95b714ad == #"bc_general_kill_zombie_critical_kill" || var_dfd3675a95b714ad == #"hash_5b6919511550f5a1" )
    {
        thread function_262c3547b6ecaa22();
        function_904af5f8a88af91f( "dx_zm_nmta_ankm_nkmt_ainkmthkz", startdelay );
        return true;
    }
    
    if ( var_dfd3675a95b714ad == #"bc_general_kill_zombie_melee" || var_dfd3675a95b714ad == #"hash_bdff618d7762a5b4" )
    {
        thread function_262c3547b6ecaa22();
        function_904af5f8a88af91f( "dx_zm_nmta_ankm_nkmt_ainkmtmlkz", startdelay );
        return true;
    }
    
    if ( var_dfd3675a95b714ad == #"bc_status_player_last_stand" )
    {
        thread function_262c3547b6ecaa22();
        function_904af5f8a88af91f( "dx_zm_nmta_ankm_nkmt_ainkmtrvdw", startdelay );
        return true;
    }
    
    if ( var_dfd3675a95b714ad == #"bc_status_player_revived" || var_dfd3675a95b714ad == #"hash_1cdbd60dd7762adb" || var_dfd3675a95b714ad == #"hash_2b10a57e243777cc" || var_dfd3675a95b714ad == #"hash_3b3d167ed9ac2273" || var_dfd3675a95b714ad == #"hash_2a2e48cb51b87ebc" || var_dfd3675a95b714ad == #"hash_5e71f3aabde8a65" || var_dfd3675a95b714ad == #"hash_2e6cac7356cd7166" || var_dfd3675a95b714ad == #"hash_5a481e1108e32daf" || var_dfd3675a95b714ad == #"hash_68b280795d1896e" )
    {
        thread function_262c3547b6ecaa22();
        function_904af5f8a88af91f( "dx_zm_nmta_ankm_nkmt_ainkmtrvrv", startdelay );
        return true;
    }
    
    if ( var_dfd3675a95b714ad == #"bc_equipment_monkey_bomb_multikill" )
    {
        thread function_262c3547b6ecaa22();
        function_904af5f8a88af91f( "dx_zm_nmta_ankm_nkmt_ainkmtsembm", startdelay );
        return true;
    }
    
    if ( var_dfd3675a95b714ad == #"bc_scoreevent_zm_multikill" )
    {
        thread function_262c3547b6ecaa22();
        function_904af5f8a88af91f( "dx_zm_nmta_ankm_nkmt_ainkmtsem", startdelay );
        return true;
    }
    
    if ( var_dfd3675a95b714ad == #"bc_super_wiley_fox_success" )
    {
        thread function_262c3547b6ecaa22();
        function_904af5f8a88af91f( "dx_zm_nmta_ankm_nkmt_ainkmtsewfs", startdelay );
        return true;
    }
    
    if ( var_dfd3675a95b714ad == #"bc_super_tesla_storm_success" )
    {
        thread function_262c3547b6ecaa22();
        function_904af5f8a88af91f( "dx_zm_nmta_ankm_nkmt_ainkmtsetss", startdelay );
        return true;
    }
    
    if ( var_dfd3675a95b714ad == #"bc_super_frost_blast_success" )
    {
        thread function_262c3547b6ecaa22();
        function_904af5f8a88af91f( "dx_zm_nmta_ankm_nkmt_ainkmtsefbs", startdelay );
        return true;
    }
    
    if ( var_dfd3675a95b714ad == #"bc_super_energy_mine_success" )
    {
        thread function_262c3547b6ecaa22();
        function_904af5f8a88af91f( "dx_zm_nmta_ankm_nkmt_ainkmtseems", startdelay );
        return true;
    }
    
    if ( var_dfd3675a95b714ad == #"bc_super_frenzied_guard_success" )
    {
        thread function_262c3547b6ecaa22();
        function_904af5f8a88af91f( "dx_zm_nmta_ankm_nkmt_ainkmtsefgs", startdelay );
        return true;
    }
    
    if ( var_dfd3675a95b714ad == #"bc_super_toxic_growth_success" )
    {
        thread function_262c3547b6ecaa22();
        function_904af5f8a88af91f( "dx_zm_nmta_ankm_nkmt_ainkmtsetgs", startdelay );
        return true;
    }
    
    if ( var_dfd3675a95b714ad == #"bc_super_healing_aura_success" )
    {
        thread function_262c3547b6ecaa22();
        function_904af5f8a88af91f( "dx_zm_nmta_ankm_nkmt_ainkmtsehas", startdelay );
        return true;
    }
    
    if ( var_dfd3675a95b714ad == #"hash_157b2fd343c722f7" )
    {
        thread function_262c3547b6ecaa22();
        function_904af5f8a88af91f( "dx_zm_nmta_ankm_nkmt_ainkmtseash", startdelay );
        return true;
    }
    
    return false;
}

// Namespace weap_hornetww
// Params 2, eflags: 0x4
// Checksum 0x6375d323, Offset: 0x3495
// Size: 0x5b
function private function_904af5f8a88af91f( voname, waittime )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( waittime ) )
    {
        if ( !isdefined( waittime ) )
        {
            waittime = 0;
        }
    }
    
    waittime = utility::function_6f5d2e1f1ff70482( waittime );
    wait waittime;
    dialogue::say( voname, undefined, undefined, undefined, undefined, "global" );
}

// Namespace weap_hornetww
// Params 0, eflags: 0x4
// Checksum 0x1659b218, Offset: 0x34f8
// Size: 0x4a
function private function_262c3547b6ecaa22()
{
    level endon( #"game_ended" );
    assert( !level utility::flag( "<dev string:x102>" ), "<dev string:x124>" );
    
    if ( false )
    {
        return;
    }
    
    level utility::flag_set( "hornetww_VO_substitution_cooldown" );
    wait 45;
    level utility::flag_clear( "hornetww_VO_substitution_cooldown" );
}

/#

    // Namespace weap_hornetww
    // Params 0, eflags: 0x4
    // Checksum 0x12040e78, Offset: 0x354a
    // Size: 0x39, Type: dev
    function private initdevgui()
    {
        level.var_c26b18c1739db0c8 = 1;
        devgui::function_9082edeb5db93280( "<dev string:x16b>" );
        devgui::add_devgui_func( "<dev string:x181>", "<dev string:x196>", &function_4444624027aff259 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace weap_hornetww
    // Params 0, eflags: 0x4
    // Checksum 0x32ae241b, Offset: 0x358b
    // Size: 0x5, Type: dev
    function private function_4444624027aff259()
    {
        
    }

#/
