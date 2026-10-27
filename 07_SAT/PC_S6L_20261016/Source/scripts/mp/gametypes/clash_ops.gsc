// scripts\mp\gametypes\clash_ops.gsc  (hash_308d18a9d4a726ba.gscc) (size: 10763 Bytes / 0x2a0b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x989d5a6f (2560449135)
// size ...... 10763 (0x2a0b)
// includes .. 28  (offset: 0x272b)
// strings ... 23  (offset: 0x280b)
// dev strs .. 14  (offset: 0x291f)
// exports ... 29  (offset: 0x16cb)
// cseg ...... 0x1e0 + 0x14eb (0x16cb)
// imports ... 101 (offset: 0x1b53)
// animtree1 . 0   (offset: 0x2a0b)
// animtree2 . 0   (offset: 0x2a0b)
#using script_16ea1b94f0f381b3;
#using script_2498b7c75f1dee2d;
#using script_298d21b2d733c498;
#using script_38b3a2dd00d469d7;
#using script_6c1eb3169ed7bfa8;
#using script_70fa7df687b2e3bf;
#using script_7c4db7d2697593e7;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\ammomods\brainrot;
#using scripts\mp\ammomods\deadwire;
#using scripts\mp\ammomods\lightray;
#using scripts\mp\ammomods\napalmburst;
#using scripts\mp\common\equipment\molotov;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\content_manager;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_util;
#using scripts\mp\spawnlogic;
#using scripts\mp\weaponmetadata;

#namespace clash_ops;

// Namespace clash_ops
// Params 0
// Checksum 0xd6ed63a2, Offset: 0x1fe
// Size: 0x271
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    callback::add( #"player_spawned", &onspawnplayer );
    callback::add( #"player_damaged", &onplayerdamaged );
    callback::add( #"player_connect", &onplayerconnect );
    callback::add( #"player_disconnect", &onplayerdisconnect );
    utility::registersharedfunc( #"ai", #"getpowertier", &get_ai_power_tier );
    utility::registersharedfunc( #"combat_hologram", #"zombie_attractor_validator", &function_d0d8958d017bc54c );
    callback::add( #"player_death", &onplayerdeath );
    callback::add( #"hash_dd3cc659d7255154", &function_683dd7ac94a9dea1 );
    callback::add( #"hash_bc53f926031ea3f6", &function_aa8543911da326b5 );
    callback::add( "on_zombie_ai_spawned", &function_376056eb96b08d23 );
    callback::add( "on_zombie_ai_killed", &function_6ed4bb386145f46 );
    utility::registersharedfunc( #"zombie", #"health_scaling_get_starting_health", &namespace_775af9b7afedb6d1::function_28795222258b3cca );
    utility::registersharedfunc( #"zombie", #"health_scaling_get_subclass_health", &namespace_775af9b7afedb6d1::get_subclass_health );
    namespace_775af9b7afedb6d1::init_scaling_health();
    brainrot::register_brainrot_result_func( &function_4df2486b0448aa09 );
    deadwire::register_deadwire_result_func( &function_4bca50e7d85cbbbf );
    napalmburst::register_napalmburst_result_func( &function_9cb75b4ad1711865 );
    lightray::register_lightray_result_func( &function_29ceec023cbe66c4 );
    level.teambased = 1;
    level.ammo_mods_in_use = 1;
    level.zombie_augments_in_use = 1;
    level.zombie_perks_in_use = 1;
    level.var_cc3b9b1c8c9f3a68 = 1;
    level.var_c998633bab11f3f8 = 1;
    ammo_mod::init_ammo_mod();
    content_manager::init_content_manager();
    weaponmetadata::init_weaponmetadata();
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.var_4e147a96a4a5740d = game_utility_mp::function_4b7180ed8c2e9742( #"gametypebundle_clash_ops" );
    namespace_d2a47c879394e097::registertasks();
    namespace_9a55388c9191eb1b::init();
    clash_ops_punish::init();
}

// Namespace clash_ops
// Params 2, eflags: 0x4
// Checksum 0x62a08ead, Offset: 0x477
// Size: 0x26, Type: bool
function private function_d0d8958d017bc54c( attractor, ai )
{
    return ai.type == "zombie";
}

// Namespace clash_ops
// Params 1
// Checksum 0xb60b3c38, Offset: 0x4a6
// Size: 0x1e
function function_683dd7ac94a9dea1( params )
{
    function_5fa886c41380c071( params.struct );
}

// Namespace clash_ops
// Params 1
// Checksum 0xd8bf5fbf, Offset: 0x4cc
// Size: 0x1e
function function_aa8543911da326b5( params )
{
    function_5fa886c41380c071( params.struct );
}

// Namespace clash_ops
// Params 0
// Checksum 0xe7765c6e, Offset: 0x4f2
// Size: 0x166
function function_c3dc5100d5e2bea6()
{
    var_6472c2bfbb7ccd91 = level.var_4e147a96a4a5740d.var_6472c2bfbb7ccd91;
    var_47eb9bd0cfba65f5 = [ var_6472c2bfbb7ccd91.var_ec44c23eceaecc19, var_6472c2bfbb7ccd91.var_92027fc1cca34356, var_6472c2bfbb7ccd91.var_dbeb5ddd8a26cdbf ];
    defaultkillstreaks = [ [ { #killstreakref:"ray_gun" }, { #killstreakref:"ray_gun_mk2" } ], [ { #killstreakref:"combat_bow" }, { #killstreakref:"smart_gun" }, { #killstreakref:"death_machine_gun" }, { #killstreakref:"hand_cannon" }, { #killstreakref:"reaper_drone" }, { #killstreakref:"war_machine_launcher" } ], [ { #killstreakref:"zm_minj" } ] ];
    slotoptions = [];
    
    for ( i = 0; i < 3 ; i++ )
    {
        slotoptions[ i ] = var_47eb9bd0cfba65f5[ i ] && var_47eb9bd0cfba65f5[ i ].size > 0 ? var_47eb9bd0cfba65f5[ i ] : defaultkillstreaks[ i ];
    }
    
    return slotoptions;
}

// Namespace clash_ops
// Params 1
// Checksum 0x542b868e, Offset: 0x661
// Size: 0xd9
function function_5fa886c41380c071( classstruct )
{
    slotoptions = function_c3dc5100d5e2bea6();
    loadoutkillstreaks = [ classstruct.loadoutkillstreak1, classstruct.loadoutkillstreak2, classstruct.loadoutkillstreak3 ];
    
    for ( i = 0; i < 3 ; i++ )
    {
        var_954d04cb47086448 = utility::array_random( slotoptions[ i ] );
        
        if ( var_954d04cb47086448.killstreakref )
        {
            loadoutkillstreaks[ i ] = var_954d04cb47086448.killstreakref;
        }
    }
    
    classstruct.loadoutkillstreak1 = loadoutkillstreaks[ 0 ];
    classstruct.loadoutkillstreak2 = loadoutkillstreaks[ 1 ];
    classstruct.loadoutkillstreak3 = loadoutkillstreaks[ 2 ];
    function_ad263159be886314( loadoutkillstreaks );
}

// Namespace clash_ops
// Params 1
// Checksum 0x5f902c6a, Offset: 0x742
// Size: 0x141
function function_ad263159be886314( excluderefs = [] )
{
    options = [];
    
    foreach ( slot in function_c3dc5100d5e2bea6() )
    {
        foreach ( option in slot )
        {
            if ( option.killstreakref && !arraycontains( excluderefs, option.killstreakref ) )
            {
                options[ options.size ] = option.killstreakref;
            }
        }
    }
    
    if ( !options.size )
    {
        return;
    }
    
    self.var_8c6019c19fcca74c = utility::array_random( options );
}

// Namespace clash_ops
// Params 0
// Checksum 0x65b69436, Offset: 0x88b
// Size: 0x9
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
}

// Namespace clash_ops
// Params 0
// Checksum 0xaeaf31, Offset: 0x89c
// Size: 0x9
function updategametypedvars()
{
    common::updatecommongametypedvars();
}

// Namespace clash_ops
// Params 0
// Checksum 0x80a27dc0, Offset: 0x8ad
// Size: 0x57
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    game_utility_mp::setobjectivetext( "allies", &"hash_47c285b5ac092893" );
    game_utility_mp::setobjectivetext( "axis", &"hash_47c285b5ac092893" );
    initspawns();
    namespace_65703d98c062a7d0::start();
    
    /#
        level thread function_c32a5fade9085fbd();
        level thread function_a9b58ef6d486b677();
    #/
}

// Namespace clash_ops
// Params 0
// Checksum 0xa09fef35, Offset: 0x90c
// Size: 0xe2
function initspawns()
{
    if ( getdvarint( @"hash_742caa13b3c2e685" ) )
    {
        return;
    }
    
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"default" );
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_3cdbb94b81729d5f( spawnkey );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_tdm_spawn_allies_start", game[ "attackers" ] );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_tdm_spawn_axis_start", game[ "defenders" ] );
        spawnlogic::function_17e08e497a9b4136( #"primary", #"primary", "mp_tdm_spawn" );
        spawnlogic::function_17e08e497a9b4136( #"fallback", #"fallback", "mp_tdm_spawn_secondary", 1 );
    }
    
    spawnlogic::finalizemap();
}

// Namespace clash_ops
// Params 1
// Checksum 0x4b74cd7b, Offset: 0x9f6
// Size: 0x1b
function onplayerconnect( params )
{
    function_ad263159be886314();
    namespace_65703d98c062a7d0::function_33744750fdce2ce( self );
}

// Namespace clash_ops
// Params 0
// Checksum 0x29f645d7, Offset: 0xa19
// Size: 0x9
function getspawnpoint()
{
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace clash_ops
// Params 1
// Checksum 0x6d58675f, Offset: 0xa2b
// Size: 0x5c
function onspawnplayer( spawndata )
{
    namespace_65703d98c062a7d0::function_44ac26ccf8918a7( self, spawndata );
    clash_ops_punish::function_db8e8ff846f8004b( self );
    utility::callsharedfunc( #"zombie", #"hash_d99535fac86238ac", #"energy_mine_spire" );
    function_5fa886c41380c071( spawndata.player.classstruct );
}

// Namespace clash_ops
// Params 1
// Checksum 0xc2c9e08a, Offset: 0xa8f
// Size: 0x16
function onplayerdamaged( damagedata )
{
    namespace_65703d98c062a7d0::function_58ed6f42d666abc7( self, damagedata );
}

// Namespace clash_ops
// Params 1
// Checksum 0x934421b7, Offset: 0xaad
// Size: 0x16
function onplayerdisconnect( disconnectdata )
{
    namespace_65703d98c062a7d0::function_658cc6d2c8ec3d2( self, disconnectdata );
}

// Namespace clash_ops
// Params 1
// Checksum 0xa227cd78, Offset: 0xacb
// Size: 0x1f7
function onplayerdeath( data )
{
    namespace_65703d98c062a7d0::function_bff624d5c128c599( data );
    
    if ( !isplayer( data.attacker ) )
    {
        return;
    }
    
    if ( !isdefined( data.attacker.var_794a92e2ff5aad24 ) )
    {
        return;
    }
    
    if ( !data.attacker weapon::isprimaryweapon( data.objweapon ) )
    {
        return;
    }
    
    chancesuccess = 0.3;
    
    /#
        if ( getdvarint( @"hash_2ef7efa1f0f94fee", 0 ) > 0 )
        {
            chancesuccess = getdvarint( @"hash_2ef7efa1f0f94fee", 0 );
        }
    #/
    
    if ( randomfloat( 1 ) > chancesuccess )
    {
        return;
    }
    
    playersnearby = getplayersinradius( data.victim.origin, 200, undefined, undefined, data.victim, data.victim.team );
    zombiesnearby = getaiarrayinradius( data.victim.origin, 200 );
    
    foreach ( player in playersnearby )
    {
        player apply_ammo_mod( data );
    }
    
    foreach ( zombie in zombiesnearby )
    {
        zombie apply_ammo_mod( data );
    }
}

// Namespace clash_ops
// Params 1
// Checksum 0x242ff162, Offset: 0xcca
// Size: 0xa2
function apply_ammo_mod( data )
{
    ammo_mod::ammo_mod_response( 0, data.inflictor, data.attacker, 0, data.idflags, "MOD_PISTOL_BULLET", data.objweapon, self.origin, data.direction_vec, data.hitloc, data.psoffsettime, undefined, undefined, data.objweapon, 1, data.objweapon, 0, 1, data.attacker.var_794a92e2ff5aad24 );
}

// Namespace clash_ops
// Params 11
// Checksum 0xa881b781, Offset: 0xd74
// Size: 0xad
function function_4df2486b0448aa09( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, wasplague, var_ddd47269e5d6cd98, skip_augments, force )
{
    if ( isplayer( self ) )
    {
        ai = namespace_3047dff6a502386b::function_84fa91f471681f87( clash_ops_punish::function_b53a496d6d241505(), self.origin, ( 0, randomint( 360 ), 0 ), self.team );
        ai brainrot::function_2fa96fd205e9d8f7( attacker, sweapon );
    }
}

// Namespace clash_ops
// Params 8
// Checksum 0x2a53eec8, Offset: 0xe29
// Size: 0x78
function function_4bca50e7d85cbbbf( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_3459569f97557c2f )
{
    if ( isplayer( self ) )
    {
        shock_stick::function_8db896e6f63b004b( attacker, sweapon, undefined, 2.5 );
        return;
    }
    
    deadwire::function_96586ce690694a15( attacker, sweapon, death, mod, vpoint, shitloc, modelindex, var_3459569f97557c2f );
}

// Namespace clash_ops
// Params 8
// Checksum 0xc2c2ae1a, Offset: 0xea9
// Size: 0x78
function function_9cb75b4ad1711865( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, nospread )
{
    if ( isplayer( self ) )
    {
        thread molotov::molotov_burn_for_time( 2.5, attacker, attacker, attacker );
        return;
    }
    
    napalmburst::function_bda956d76cf76213( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, nospread );
}

// Namespace clash_ops
// Params 8
// Checksum 0x253092a1, Offset: 0xf29
// Size: 0x6c
function function_29ceec023cbe66c4( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_e0efbf29b9f2961d )
{
    lightray::function_1ffa747c8a87b592( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, undefined, undefined, 1, undefined, attacker.team );
}

// Namespace clash_ops
// Params 0
// Checksum 0x7d2d37da, Offset: 0xf9d
// Size: 0x4, Type: bool
function get_ai_power_tier()
{
    return true;
}

// Namespace clash_ops
// Params 1
// Checksum 0xa9b7ace6, Offset: 0xfaa
// Size: 0x4e
function function_376056eb96b08d23( params )
{
    zombie = self;
    zombie.spawninfluencer = spawnlogic::addspawninfluencer( #"hash_de4c5e46f803bae", zombie.origin, undefined, undefined, zombie );
    zombie namespace_9d8e359c3b1041e5::function_b739495605e4ba8a( 1 );
}

// Namespace clash_ops
// Params 1
// Checksum 0x508f34df, Offset: 0x1000
// Size: 0xfd
function function_6ed4bb386145f46( params )
{
    zombie = self;
    attacker = params.eattacker;
    spawnlogic::removespawninfluencer( zombie.spawninfluencer );
    
    if ( attacker && !isplayer( attacker ) && isplayer( attacker.owner ) )
    {
        attacker = attacker.owner;
    }
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    if ( zombie.specialproperties.var_7957a5f65931aaea && isdefined( level.var_4e147a96a4a5740d.var_6ae460ce91e4fd32 ) )
    {
        attacker thread points::doscoreevent( level.var_4e147a96a4a5740d.var_6ae460ce91e4fd32 );
        return;
    }
    
    if ( isdefined( level.gametypebundle.var_991982d965bdf89d ) )
    {
        attacker thread points::doscoreevent( level.gametypebundle.var_991982d965bdf89d );
    }
}

/#

    // Namespace clash_ops
    // Params 0
    // Checksum 0x5c1959e0, Offset: 0x1105
    // Size: 0x2e5, Type: dev
    function function_c32a5fade9085fbd()
    {
        level endon( #"game_ended" );
        
        for ( host = gamelogic_mp::gethostplayer(); !host ; host = gamelogic_mp::gethostplayer() )
        {
            wait 1;
        }
        
        titlehud = host hud_util::createfontstring( "<dev string:x24>", 1.5 );
        titlehud hud_util::setpoint( "<dev string:x2c>", "<dev string:x2c>", -20, 120 );
        titlehud.color = ( 1, 1, 0.4 );
        titlehud.alpha = 1;
        deschud = host hud_util::createfontstring( "<dev string:x24>", 1.1 );
        deschud hud_util::setpoint( "<dev string:x2c>", "<dev string:x2c>", -20, 142 );
        deschud.color = ( 0.8, 0.8, 0.8 );
        deschud.alpha = 1;
        progresshud = host hud_util::createfontstring( "<dev string:x24>", 1.2 );
        progresshud hud_util::setpoint( "<dev string:x2c>", "<dev string:x2c>", -20, 184 );
        progresshud.color = ( 1, 1, 1 );
        progresshud.alpha = 1;
        
        while ( true )
        {
            titletext = "<dev string:x35>";
            var_60da47521d472d38 = "<dev string:x35>";
            progresstext = "<dev string:x35>";
            
            if ( !getdvarint( @"hash_dd7332e6abc277f9", 1 ) )
            {
                titlehud setdevtext( titletext );
                deschud setdevtext( var_60da47521d472d38 );
                progresshud setdevtext( progresstext );
                wait 0.5;
                continue;
            }
            
            task = undefined;
            
            if ( level.var_1304fc1c8fb51e7b )
            {
                task = level.var_1304fc1c8fb51e7b.active;
            }
            
            if ( task )
            {
                titletext = task.title ?? "<dev string:x36>";
                var_60da47521d472d38 = task.description ?? "<dev string:x4d>";
                
                foreach ( team in level.teamnamelist )
                {
                    if ( progresstext != "<dev string:x35>" )
                    {
                        progresstext += "<dev string:x6a>";
                    }
                    
                    progresstext += team + "<dev string:x70>" + ( task.teamprogress[ team ] ?? 0 ) + "<dev string:x73>" + task.scoretarget;
                }
            }
            else
            {
                titletext = "<dev string:x77>";
            }
            
            titlehud setdevtext( titletext );
            deschud setdevtext( var_60da47521d472d38 );
            progresshud setdevtext( progresstext );
            wait 0.25;
        }
    }

    // Namespace clash_ops
    // Params 0
    // Checksum 0xf7561fa, Offset: 0x13f2
    // Size: 0x1a3, Type: dev
    function function_a9b58ef6d486b677()
    {
        level endon( #"game_ended" );
        
        for ( host = gamelogic_mp::gethostplayer(); !host ; host = gamelogic_mp::gethostplayer() )
        {
            wait 1;
        }
        
        titlehud = host hud_util::createfontstring( "<dev string:x24>", 1.4 );
        titlehud hud_util::setpoint( "<dev string:x91>", "<dev string:x91>", 10, -100 );
        titlehud.color = ( 1, 1, 0.4 );
        titlehud.alpha = 1;
        titlehud setdevtext( "<dev string:x9c>" );
        maxlines = 12;
        linespacing = 16;
        linehuds = [];
        
        for ( i = 0; i < maxlines ; i++ )
        {
            linehud = host hud_util::createfontstring( "<dev string:x24>", 1.1 );
            linehud hud_util::setpoint( "<dev string:x91>", "<dev string:x91>", 10, -100 - linespacing * ( i + 1 ) );
            linehud.color = ( 1, 1, 1 );
            linehud.alpha = 1;
            linehud setdevtext( "<dev string:x35>" );
            linehuds[ linehuds.size ] = linehud;
        }
        
        while ( true )
        {
            lines = function_c11f78b1a1d56e4e( host );
            
            for ( i = 0; i < maxlines ; i++ )
            {
                if ( i < lines.size )
                {
                    linehuds[ i ] setdevtext( lines[ i ] );
                    continue;
                }
                
                linehuds[ i ] setdevtext( "<dev string:x35>" );
            }
            
            wait 0.25;
        }
    }

    // Namespace clash_ops
    // Params 1
    // Checksum 0xa93fb24d, Offset: 0x159d
    // Size: 0x12e, Type: dev
    function function_c11f78b1a1d56e4e( host )
    {
        lines = [];
        
        if ( !host.team )
        {
            return lines;
        }
        
        perkrefs = level.var_b4f5d478cf93f9a3.var_9add203e4823ba3c[ host.team ];
        
        if ( perkrefs )
        {
            foreach ( perkref in perkrefs )
            {
                if ( perkref )
                {
                    lines[ lines.size ] = "<dev string:xae>" + perkref;
                }
            }
        }
        
        if ( host.var_794a92e2ff5aad24 )
        {
            lines[ lines.size ] = "<dev string:xb5>" + host.var_794a92e2ff5aad24;
        }
        
        if ( level.var_b4f5d478cf93f9a3.var_46a4974d63c4cbbc[ host.team ] == 1 )
        {
            lines[ lines.size ] = "<dev string:xc0>";
        }
        
        return lines;
    }

#/
