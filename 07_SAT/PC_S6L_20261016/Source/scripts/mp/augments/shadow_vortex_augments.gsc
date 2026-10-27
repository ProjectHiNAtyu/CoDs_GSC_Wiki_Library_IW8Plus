// scripts\mp\augments\shadow_vortex_augments.gsc  (hash_1774a1aa20349a63.gscc) (size: 3304 Bytes / 0xce8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf402734d (4093801293)
// size ...... 3304 (0xce8)
// includes .. 6   (offset: 0xc44)
// strings ... 9   (offset: 0xc74)
// dev strs .. 0   (offset: 0xce8)
// exports ... 6   (offset: 0x7dc)
// cseg ...... 0x127 + 0x6b5 (0x7dc)
// imports ... 30  (offset: 0x8cc)
// animtree1 . 0   (offset: 0xce8)
// animtree2 . 0   (offset: 0xce8)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\ammomods\shadowvortex;

#namespace shadow_vortex_augments;

// Namespace shadow_vortex_augments
// Params 0, eflags: 0x5
// Checksum 0xbd5dac84, Offset: 0x145
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"shadow_vortex_augments", undefined, &init_shadow_vortex_augments, undefined );
}

// Namespace shadow_vortex_augments
// Params 0
// Checksum 0x5e810449, Offset: 0x166
// Size: 0x88
function init_shadow_vortex_augments()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    level._effect[ "shadow_vortex_explosive" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_weapons_perk_pdh_explo" );
    level.var_e75bb34842f72ef0 = throttle::throttle_initialize( "shadow_vortex_explosive", 2, level.framedurationseconds ?? 0.1 );
    utility::registersharedfunc( #"zombie", #"shadow_vortex_zombie", &function_dec67658e57ac639 );
    level callback::add( "shadowvortex_zombiedropped", &explosive_rain );
    level thread function_e95305f3bac2ffa9();
}

// Namespace shadow_vortex_augments
// Params 0
// Checksum 0xdcb8d942, Offset: 0x1f6
// Size: 0x26
function function_e95305f3bac2ffa9()
{
    level endon( #"game_ended" );
    utility::flag_wait( "shadowvortex_ready" );
    shadowvortex::register_shadowvortex_result_func( &function_dec67658e57ac639 );
}

// Namespace shadow_vortex_augments
// Params 8
// Checksum 0xe42b4018, Offset: 0x224
// Size: 0x1c8
function function_dec67658e57ac639( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_b8f3721c1cf18fb7 )
{
    level endon( #"game_ended" );
    var_e5e377349bdef1e4 = 0;
    var_fb01fe2bccef07e4 = 0;
    
    if ( isplayer( attacker ) && attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"shadowvortex_supermassive" ) )
    {
        var_e5e377349bdef1e4 = level.zombie_augments[ #"shadowvortex_supermassive" ].var_d4499f19f417ddeb ?? 2;
        var_fb01fe2bccef07e4 = level.zombie_augments[ #"shadowvortex_supermassive" ].var_2f2042c254dc618e ?? 0.5;
    }
    
    btargeted = 0;
    var_d0cdbed8690f0d14 = 0;
    
    if ( isplayer( attacker ) && attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"shadowvortex_topple_danger" ) )
    {
        var_d0cdbed8690f0d14 = 1;
    }
    
    if ( isplayer( attacker ) && attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"shadowvortex_targeted" ) )
    {
        btargeted = 1;
    }
    
    if ( isplayer( attacker ) && attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"shadowvortex_blackhole" ) )
    {
        shadowvortex::function_c07a5519180aa421( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_e5e377349bdef1e4, var_fb01fe2bccef07e4, var_d0cdbed8690f0d14, btargeted );
        return;
    }
    
    shadowvortex::function_7ebadea72ea922fb( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_e5e377349bdef1e4, var_fb01fe2bccef07e4, var_d0cdbed8690f0d14, btargeted, var_b8f3721c1cf18fb7 );
}

// Namespace shadow_vortex_augments
// Params 1
// Checksum 0xf3b0e7ed, Offset: 0x3f4
// Size: 0x3e8
function explosive_rain( sparams )
{
    if ( isplayer( sparams.player ) && sparams.player utility::callsharedfunc( #"zombie", #"player_has_augment", #"shadowvortex_explosive_rain" ) )
    {
        if ( isdefined( sparams.agent ) )
        {
            var_d0a9d177707a4448 = sparams.agent.origin;
            zombie_health_bundle = level.gametypebundle.var_e039e3d3a8e46ee6 ?? "health_zombie_base";
            roundnumber = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( var_d0a9d177707a4448 );
            base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_bb9b98eb7368a15a( zombie_health_bundle, roundnumber );
            var_8d2325a3c1b80415 = level.zombie_augments[ #"shadowvortex_explosive_rain" ].var_537ee52a679ca5b ?? 1;
            damage_radius = level.zombie_augments[ #"shadowvortex_explosive_rain" ].var_4a7891415c08a229 ?? 75;
            damage = base_zombie_maxhealth * var_8d2325a3c1b80415;
            fx = utility::getfx( "shadow_vortex_explosive" );
            playfx( fx, var_d0a9d177707a4448 );
            sparams.agent.var_f01e011f051b14b5 = 0;
            zombies = getaiarrayinradius( var_d0a9d177707a4448, damage_radius );
            
            foreach ( zombie in zombies )
            {
                if ( sparams.player && utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
                {
                    if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( sparams.player, zombie ) )
                    {
                        continue;
                    }
                }
                
                if ( isalive( zombie ) && !zombie.magic_bullet_shield && !zombie.damageshield )
                {
                    if ( zombie.health - damage <= 0 )
                    {
                        zombie.var_e797f68de73ece4e = "_svortex";
                    }
                    
                    if ( !zombie.magic_bullet_shield && !zombie.damageshield )
                    {
                        zombie dodamage( damage, var_d0a9d177707a4448, sparams.player, sparams.player, "MOD_ELEMENTAL_DARK", sparams.sweapon, "none", undefined, 65536 );
                    }
                    
                    if ( !isalive( zombie ) && sparams.agent.var_f01e011f051b14b5 < 5 && !zombie.var_33df89471a965163 )
                    {
                        zombie.var_33df89471a965163 = 1;
                        var_24ed309d808c077a = zombie getcorpseentity();
                        v_dir = vectornormalize( zombie.origin - var_d0a9d177707a4448 );
                        
                        if ( isdefined( var_24ed309d808c077a ) )
                        {
                            launchx = clamp( v_dir[ 0 ] * 5000, -5000, 5000 );
                            launchy = clamp( v_dir[ 1 ] * 5000, -5000, 5000 );
                            launchz = clamp( ( v_dir[ 2 ] + 150 ) * 5000, 0, 5000 );
                            v_launch = ( launchx, launchy, launchz );
                            var_24ed309d808c077a startragdollfromimpact( "torso_lower", v_launch );
                            sparams.agent.var_f01e011f051b14b5++;
                        }
                    }
                }
                
                throttle::throttle_wait_in_queue( level.var_e75bb34842f72ef0, zombie );
            }
        }
    }
}

