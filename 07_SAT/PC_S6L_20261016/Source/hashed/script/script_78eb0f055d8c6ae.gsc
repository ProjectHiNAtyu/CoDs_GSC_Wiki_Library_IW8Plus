// script_78eb0f055d8c6ae  (hash_078eb0f055d8c6ae.gscc) (size: 5738 Bytes / 0x166a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc9e43cb8 (3387178168)
// size ...... 5738 (0x166a)
// includes .. 10  (offset: 0x1562)
// strings ... 10  (offset: 0x15b2)
// dev strs .. 4   (offset: 0x163a)
// exports ... 14  (offset: 0xd6a)
// cseg ...... 0x14c + 0xc1e (0xd6a)
// imports ... 51  (offset: 0xf9a)
// animtree1 . 0   (offset: 0x166a)
// animtree2 . 0   (offset: 0x166a)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_health_bar;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_hazard_enemy_spawner;

// Namespace ztron_hazard_enemy_spawner
// Params 0, eflags: 0x5
// Checksum 0x61e47a63, Offset: 0x16a
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_hazard_enemy_spawner", #"ztron_hazards", undefined, &init );
}

// Namespace ztron_hazard_enemy_spawner
// Params 0
// Checksum 0xb56900cd, Offset: 0x193
// Size: 0x4f
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"enemy_spawner", #"create", &create_enemy_spawner );
    ztron_hazard::function_6f661fac5fd31f1( #"enemy_spawner", #"arenaspawn", &function_32e9dc5ac240b43d );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_enemy_spawner_blow_up", "evt_ztron_hazard_beehive_explode" );
}

// Namespace ztron_hazard_enemy_spawner
// Params 0
// Checksum 0xc5bc0ca6, Offset: 0x1ea
// Size: 0xca
function function_32e9dc5ac240b43d()
{
    if ( !isdefined( level.ztron.active_arena ) )
    {
        return;
    }
    
    level.ztron.var_a72952d4684b663d = [];
    traps = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "enemy_spawner" );
    
    foreach ( trap in traps )
    {
        create_enemy_spawner( trap );
    }
}

// Namespace ztron_hazard_enemy_spawner
// Params 2
// Checksum 0x85bcd7f3, Offset: 0x2bc
// Size: 0x59
function create_enemy_spawner( trap, paged = 0 )
{
    if ( paged )
    {
        level.ztron.var_a72952d4684b663d[ level.ztron.var_a72952d4684b663d.size ] = trap;
        return;
    }
    
    function_9bd296853bbdeb4( trap );
}

// Namespace ztron_hazard_enemy_spawner
// Params 2, eflags: 0x4
// Checksum 0xe03c810f, Offset: 0x31d
// Size: 0x1ed
function private function_9bd296853bbdeb4( trap, paged = 0 )
{
    if ( !isdefined( trap ) )
    {
        return;
    }
    
    assert( isdefined( trap.script_parameters ), "<dev string:x24>" );
    args = strtok( trap.script_parameters, ";" );
    assert( args.size >= 3, "<dev string:x50>" );
    spawnparams = spawnstruct();
    spawnparams.aitype = args[ 0 ];
    spawnparams.spawncount = int( args[ 1 ] );
    spawnparams.spawninterval = int( args[ 2 ] );
    spawnparams.spawnradius = args.size >= 4 ? int( args[ 3 ] ) : 60;
    spawnparams.var_b4b3f1f4bbab5553 = args.size >= 5 ? int( args[ 4 ] ) : 20;
    spawnparams.modelname = args.size >= 6 ? args[ 5 ] : "sat_zm_ztron_props_bee_hive_round";
    spawnparams.onnavmesh = args.size >= 7 ? int( args[ 6 ] ) : 1;
    spawnparams.isemptymodel = spawnparams.modelname == "empty_model";
    
    if ( spawnparams.var_b4b3f1f4bbab5553 >= spawnparams.spawnradius )
    {
        spawnparams.var_b4b3f1f4bbab5553 = 0;
    }
    
    trap.spawnparams = spawnparams;
    trap.spawnedenemies = [];
    var_4d080f710fb8349e = trap function_12e1e4266eeef9ea( spawnparams.modelname, trap.origin, trap.angles );
    trap.script_model = var_4d080f710fb8349e;
    trap.paged = paged;
    return trap;
}

// Namespace ztron_hazard_enemy_spawner
// Params 3, eflags: 0x4
// Checksum 0xf31e21ce, Offset: 0x513
// Size: 0x1c6
function private function_12e1e4266eeef9ea( model, origin, angles )
{
    var_4d080f710fb8349e = utility::spawn_model( model, origin, angles );
    
    if ( !isdefined( var_4d080f710fb8349e ) )
    {
        return;
    }
    
    var_4d080f710fb8349e.hazardtype = "enemy_spawner";
    
    if ( !self.spawnparams.isemptymodel )
    {
        var_4d080f710fb8349e setcandamage( 1 );
        var_4d080f710fb8349e.health = 100000;
        var_4d080f710fb8349e.maxhealth = 100000;
        var_4d080f710fb8349e solid();
        var_4d080f710fb8349e enableaimassist();
        var_4d080f710fb8349e disconnectpaths();
        var_4d080f710fb8349e.team = zm_utility::get_zombie_team();
        var_4d080f710fb8349e.var_d62ad5bfd64ba592 = "tag_origin";
        var_4d080f710fb8349e.objective = var_4d080f710fb8349e objidpoolmanager::createobjective( "hud_icon_minimap_player_enemy_ai", zm_utility::get_zombie_team(), undefined, 1, 1 );
        objidpoolmanager::function_9d4895ed38151e46( var_4d080f710fb8349e.objective, 1 );
        var_4d080f710fb8349e.healthmodel = utility::spawn_model( "empty_model", var_4d080f710fb8349e.origin, var_4d080f710fb8349e.angles );
        var_4d080f710fb8349e.healthmodel.health = 1000;
        var_4d080f710fb8349e.healthmodel.maxhealth = 1000;
        var_4d080f710fb8349e.healthmodel.var_63c94fe1b2260b34 = 1;
        var_4d080f710fb8349e.healthmodel.var_36dfdbd7ab796f0f = 4;
        var_4d080f710fb8349e.healthmodel.var_818c06f9a89fb0ba = 2;
        var_4d080f710fb8349e.healthmodel thread ztron_util::function_f7544bfa701db406( var_4d080f710fb8349e );
    }
    
    thread function_44b935fa75a34f25( 0, var_4d080f710fb8349e );
    return var_4d080f710fb8349e;
}

// Namespace ztron_hazard_enemy_spawner
// Params 1, eflags: 0x4
// Checksum 0x836c2887, Offset: 0x6e2
// Size: 0x48
function private enemy_spawner_damage_callback( params )
{
    if ( isdefined( params.eattacker ) && params.eattacker.team == zm_utility::get_zombie_team() )
    {
        return 0;
    }
    
    return params.idamage;
}

// Namespace ztron_hazard_enemy_spawner
// Params 1, eflags: 0xc
// Checksum 0xc3db5587, Offset: 0x733
// Size: 0x1c3
function private function_38b9633cd59a9b4b( var_4d080f710fb8349e )
{
    self notify( #"hash_466fd14c7132e24" );
    self endon( #"hash_466fd14c7132e24" );
    self endon( #"death" );
    self endon( #"destroy_hazard" );
    
    while ( true )
    {
        var_4d080f710fb8349e waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, dflags, objweapon );
        var_4d080f710fb8349e.health = var_4d080f710fb8349e.maxhealth;
        
        if ( attacker && var_4d080f710fb8349e.team == attacker.team )
        {
            continue;
        }
        
        if ( damage > var_4d080f710fb8349e.healthmodel.health )
        {
            damage = var_4d080f710fb8349e.healthmodel.health;
        }
        
        if ( isdefined( attacker ) && damage >= 0 )
        {
            var_4d080f710fb8349e.healthmodel.health -= damage;
            ztron_util::function_eb8ba16055d6da7c( attacker, var_4d080f710fb8349e, "none", meansofdeath, objweapon, damage, point, undefined, undefined, 0, 0 );
        }
        
        if ( var_4d080f710fb8349e.healthmodel.health <= 0 )
        {
            var_4d080f710fb8349e.health = 0;
            var_4d080f710fb8349e.healthmodel.health = 0;
            self notify( #"destroy_hazard" );
        }
    }
}

// Namespace ztron_hazard_enemy_spawner
// Params 2, eflags: 0xc
// Checksum 0xb08a0897, Offset: 0x8fe
// Size: 0xbf
function private function_44b935fa75a34f25( damaged, var_4d080f710fb8349e )
{
    self notify( #"hash_809ff6882c28485" );
    self endon( #"hash_809ff6882c28485" );
    level endon( #"ztron_game_is_over" );
    self endon( #"death" );
    self endon( #"destroy_hazard" );
    thread function_336b074392cc657a();
    
    if ( !self.spawnparams.isemptymodel )
    {
        thread function_38b9633cd59a9b4b( var_4d080f710fb8349e );
    }
    
    ztron_util::function_2f4d27d87e05d778();
    
    while ( true )
    {
        if ( function_edcb1f73a882dbfd() )
        {
            thread spawnenemies();
            self.var_2d8041df79adb2db = gettime() + self.spawnparams.spawninterval * 1000;
        }
        
        wait 1;
    }
}

// Namespace ztron_hazard_enemy_spawner
// Params 0, eflags: 0xc
// Checksum 0x601c8065, Offset: 0x9c5
// Size: 0x153
function private spawnenemies()
{
    self notify( #"hash_8af19cba3721985e" );
    self endon( #"hash_8af19cba3721985e" );
    self endon( #"death" );
    params = self.spawnparams;
    aitypedef = ztron_enemy::function_96eea0d09d5640d1( params.aitype );
    minradius = params.var_b4b3f1f4bbab5553;
    radius = params.spawnradius;
    assert( isdefined( aitypedef ), "<dev string:x85>" + params.aitype + "<dev string:x8e>" );
    
    for ( i = 0; i < params.spawncount ; i++ )
    {
        pos = self.origin + anglestoforward( ( 0, randomfloat( 360 ), 0 ) ) * ( minradius + randomfloat( radius - minradius ) );
        
        if ( params.onnavmesh > 0 )
        {
            spawnpos = getclosestpointonnavmesh( pos );
        }
        else
        {
            spawnpos = pos;
        }
        
        enemy = ztron_enemy::function_acee91c445fafd29( aitypedef, spawnpos, undefined, undefined, 1, 1 );
        enemy thread function_c6c9ee17531aecd4( self );
        self.spawnedenemies[ self.spawnedenemies.size ] = enemy;
    }
}

// Namespace ztron_hazard_enemy_spawner
// Params 1, eflags: 0xc
// Checksum 0xc4413fe4, Offset: 0xb20
// Size: 0x66
function private function_c6c9ee17531aecd4( trap )
{
    self notify( #"hash_356001e2ab72aa5a" );
    self endon( #"hash_356001e2ab72aa5a" );
    level endon( #"ztron_game_is_over" );
    trap endon( #"destroy_hazard" );
    self waittill( #"death" );
    trap.spawnedenemies = arrayremove( trap.spawnedenemies, self );
}

// Namespace ztron_hazard_enemy_spawner
// Params 0, eflags: 0x4
// Checksum 0x5f302ada, Offset: 0xb8e
// Size: 0x5d, Type: bool
function private function_edcb1f73a882dbfd()
{
    if ( !isdefined( self.var_2d8041df79adb2db ) || !isdefined( self.spawnedenemies ) )
    {
        return true;
    }
    
    self.spawnedenemies = function_5713d46873b29625( self.spawnedenemies );
    
    if ( self.var_2d8041df79adb2db <= gettime() && self.spawnedenemies.size == 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace ztron_hazard_enemy_spawner
// Params 0, eflags: 0x4
// Checksum 0x18f8c8db, Offset: 0xbf4
// Size: 0x176
function private function_336b074392cc657a()
{
    self endon( #"death" );
    thread ztron_hazard::function_4d643b159a80c647( 0 );
    self waittill( #"destroy_hazard" );
    
    if ( isdefined( self.script_model ) )
    {
        if ( !self.spawnparams.isemptymodel )
        {
            self.script_model notsolid();
            self.script_model setcandamage( 0 );
            self.script_model disableaimassist();
            self.script_model.healthmodel.var_63c94fe1b2260b34 = 0;
            self.script_model.healthmodel ztron_health_bar::function_9388be3599d2c7a9( self.script_model.healthmodel );
            
            if ( isdefined( self.script_model.objective ) && !objidpoolmanager::function_1eca7bd1a3a49a4d( self.script_model.objective ) )
            {
                objidpoolmanager::objective_playermask_hidefromallplayers( self.script_model.objective );
                objidpoolmanager::returnobjectiveid( self.script_model.objective );
            }
            
            playfxontag( utility::getfx( "ztron_hazard_enemy_spawner_explode" ), self.script_model, "tag_origin" );
            ztron_sound::ztron_playsound( "ztron_hazard_enemy_spawner_blow_up", self.script_model.origin );
        }
        
        self.script_model thread ztron_util::deletemedelay( 2 );
    }
}

