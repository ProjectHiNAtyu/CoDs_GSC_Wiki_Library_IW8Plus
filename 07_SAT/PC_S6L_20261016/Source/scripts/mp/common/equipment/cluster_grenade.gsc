// scripts\mp\common\equipment\cluster_grenade.gsc  (hash_2f2c7246b4d702bc.gscc) (size: 3923 Bytes / 0xf53 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xed076778 (3976685432)
// size ...... 3923 (0xf53)
// includes .. 5   (offset: 0xebf)
// strings ... 6   (offset: 0xee7)
// dev strs .. 1   (offset: 0xf47)
// exports ... 9   (offset: 0x99b)
// cseg ...... 0xe6 + 0x8b5 (0x99b)
// imports ... 33  (offset: 0xb03)
// animtree1 . 0   (offset: 0xf53)
// animtree2 . 0   (offset: 0xf53)
#using script_13865ca76df87ea;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\equipment;
#using scripts\mp\weapons;

#namespace cluster_grenade;

// Namespace cluster_grenade
// Params 0, eflags: 0x5
// Checksum 0x3d4c26f6, Offset: 0x104
// Size: 0x36
function private autoexec preinit_cluster_grenade()
{
    level callback::add( "init_grenade", &cluster_init );
    
    if ( level.var_ee980b280f978ae )
    {
        level callback::add( #"player_damaged", &onplayerdamaged );
    }
}

// Namespace cluster_grenade
// Params 1
// Checksum 0xf6416242, Offset: 0x142
// Size: 0x7c
function cluster_init( params )
{
    weapons::registerusedcallback( "cluster_grenade", &cluster_used );
    equipment_mp::registercallback( "equip_cluster_grenade", "onDestroyedByTrophy", &cluster_trophy_delete );
    thread utility::callsharedfunc( #"analytics", #"hash_eb9d0dae8f38111f", { #customend:1, #customstart:1, #customhit:1, #equipref:"equip_cluster_grenade" } );
}

// Namespace cluster_grenade
// Params 0
// Checksum 0x5dc332f1, Offset: 0x1c6
// Size: 0x19
function cluster_trophy_delete()
{
    if ( !self )
    {
        return;
    }
    
    self stopsounds();
    waitframe();
    
    if ( self )
    {
        self delete();
    }
}

// Namespace cluster_grenade
// Params 1
// Checksum 0x10a98fec, Offset: 0x1e7
// Size: 0x431
function cluster_used( grenade )
{
    ref = equipment_mp::function_fdc4a655fbde0dec( grenade.weapon_object.basenamehash );
    grenade.tableinfo = equipment_mp::getequipmenttableinfo( ref );
    bundle = grenade.tableinfo.bundle;
    
    if ( !isdefined( level.var_1de668bdb367b433[ bundle.cluster_grenadesubmunition ] ) )
    {
        level.var_1de668bdb367b433[ bundle.cluster_grenadesubmunition ] = ref;
    }
    
    if ( !isdefined( grenade.tableinfo.bundle ) )
    {
        assertmsg( "<dev string:x24>" );
    }
    
    grenade_owner = grenade.owner;
    grenade setscriptablepartstate( #"visual", #"visible", 0 );
    var_454a54817babd12 = bundle.var_8a83c2cd856419ed ?? 6;
    max_launch_force = bundle.var_2a868527ab04ec81 ?? 350;
    min_launch_force = bundle.var_7ebf0ef44d0572b3 ?? 350;
    var_752d40aa4237b7ac = bundle.var_871189fe3242791f ?? 35;
    var_29aa529fc3f21896 = bundle.var_d26c1297928ce3a5 ?? 10;
    max_fuse_time = bundle.var_901b5f79af979eb2 ?? 5.5;
    min_fuse_time = bundle.var_81b2e9d4d16f1890 ?? 5;
    
    if ( bundle.var_c7709714d768097c && grenade.weapon_object hasattachmenthash( bundle.var_c7709714d768097c ) )
    {
        var_3d1bd1f3765592db = bundle.var_cac040ac7c3c098a ?? 2;
        var_454a54817babd12 += var_3d1bd1f3765592db;
    }
    
    grenadeid = grenade getentitynumber();
    var_5caa49c181d18e1c = grenade.birthtime;
    
    if ( level.var_ee980b280f978ae )
    {
        grenade thread function_6e09018aa2e60c03( grenadeid );
    }
    
    grenade waittill( #"explode", detonationposition );
    
    if ( !grenade_owner )
    {
        return;
    }
    
    submunitionweapon = namespace_de7b719e85d98dcc::function_59f0aef415632a71( grenade, "submunition_weapon" ) ?? makeweapon( bundle.cluster_grenadesubmunition );
    
    for ( i = 0; i < var_454a54817babd12 ; i++ )
    {
        launch_force = max_launch_force;
        
        if ( min_launch_force < max_launch_force )
        {
            launch_force = randomfloatrange( min_launch_force, max_launch_force );
        }
        
        launch_angle = var_752d40aa4237b7ac;
        
        if ( var_29aa529fc3f21896 < var_752d40aa4237b7ac )
        {
            launch_angle = randomfloatrange( var_29aa529fc3f21896, var_752d40aa4237b7ac );
        }
        
        launch_direction = ( cos( launch_angle ), 0, sin( launch_angle ) );
        launch_offset_position = launch_direction * 30;
        angle_progress = i / var_454a54817babd12;
        submunition_yaw = angle_progress * 6.28318 * 57.2958;
        submunition_direction = rotatevector( launch_direction, ( 0, submunition_yaw, 0 ) );
        launch_velocity = submunition_direction * launch_force;
        fuse_time = max_fuse_time;
        
        if ( min_fuse_time < max_fuse_time )
        {
            fuse_time = randomfloatrange( min_fuse_time, max_fuse_time );
        }
        
        submunition = magicgrenademanual( submunitionweapon, detonationposition + launch_offset_position, launch_velocity, fuse_time, grenade_owner );
        weapons::grenadeinitialize( submunition, submunitionweapon );
        submunition.var_a7803e45d8e63517 = grenadeid;
        submunition.equipmentref = "equip_cluster_grenade_submunition";
        submunition.eventid = grenade.eventid;
        submunition.var_de862ee85e3e2f42 = var_5caa49c181d18e1c;
        submunition setscriptablepartstate( #"visual", #"visible", 0 );
        submunition setcandamage( 0 );
        submunition thread function_bd2d58526614fa90( fuse_time );
        
        if ( !isdefined( submunitions ) )
        {
            submunitions = [];
        }
        
        submunitions[ submunitions.size ] = submunition;
    }
    
    if ( level.var_ee980b280f978ae )
    {
        thread function_bc39314fbfaf9317( submunitions, grenade.eventid );
    }
}

// Namespace cluster_grenade
// Params 1, eflags: 0x4
// Checksum 0x9b3b69ba, Offset: 0x620
// Size: 0x152
function private function_bd2d58526614fa90( fusetime )
{
    self endon( #"explode", #"death" );
    var_f8b4b4ba7a660e2 = 10;
    var_cdf5e322ac34c48 = 5;
    var_29aba6824ebd3969 = var_f8b4b4ba7a660e2 - var_cdf5e322ac34c48;
    var_11aec10861fb8f9e = 0.1;
    mintimefraction = var_11aec10861fb8f9e / fusetime;
    var_9d0b83be54d3a038 = 1 - mintimefraction * var_cdf5e322ac34c48;
    var_f6656d347387d035 = 0.05;
    var_a4c1deade4a45765 = var_9d0b83be54d3a038 / var_29aba6824ebd3969 + ( var_29aba6824ebd3969 - 1 ) * var_f6656d347387d035 / 2;
    var_d9474a2e98b48a62 = fusetime * var_a4c1deade4a45765;
    
    for ( var_c8e1c4fd0c8610fc = 0; true ; var_c8e1c4fd0c8610fc = 1 )
    {
        self setscriptablepartstate( #"ramp_up_fx", #"active", 0 );
        wait var_11aec10861fb8f9e / 2;
        self setscriptablepartstate( #"ramp_up_fx", #"inactive", 0 );
        wait var_11aec10861fb8f9e / 2;
        
        if ( !var_c8e1c4fd0c8610fc )
        {
            var_17f25bd7c6c4df1f = var_d9474a2e98b48a62 - var_11aec10861fb8f9e;
            
            if ( var_17f25bd7c6c4df1f <= 0 )
            {
                var_c8e1c4fd0c8610fc = 1;
            }
            else
            {
                wait var_17f25bd7c6c4df1f;
            }
            
            var_a4c1deade4a45765 -= var_f6656d347387d035;
            
            if ( var_a4c1deade4a45765 < mintimefraction )
            {
                var_a4c1deade4a45765 = mintimefraction;
                var_c8e1c4fd0c8610fc = 1;
            }
            
            var_d9474a2e98b48a62 = fusetime * var_a4c1deade4a45765;
            
            if ( var_d9474a2e98b48a62 < var_11aec10861fb8f9e )
            {
                var_d9474a2e98b48a62 = var_11aec10861fb8f9e;
            }
        }
    }
}

// Namespace cluster_grenade
// Params 1
// Checksum 0xba2b4287, Offset: 0x77a
// Size: 0x74
function function_6e09018aa2e60c03( grenadeid )
{
    eventdata = utility::callsharedfunc( #"analytics", #"hash_22a37c3ed1cf5035", { #equipref:"equip_cluster_grenade", #attacker:self.owner, #einflictor:self } );
    
    if ( eventdata )
    {
        self.eventid = eventdata.eventid;
    }
}

// Namespace cluster_grenade
// Params 1, eflags: 0x4
// Checksum 0x57b2de8c, Offset: 0x7f6
// Size: 0xfb
function private onplayerdamaged( params )
{
    if ( params.einflictor.equipmentref == "equip_cluster_grenade_submunition" || utility::callsharedfunc( #"equipment", #"getequipmentreffromweapon", params.objweapon ) == "equip_cluster_grenade" )
    {
        hitparams = { #armordamage:params.lightarmordamage, #healthdamage:params.healthdamage, #victim:params.victim, #attacker:params.eattacker, #equipref:"equip_cluster_grenade", #eventid:params.einflictor.eventid };
        thread utility::callsharedfunc( #"analytics", #"hash_c7076e2f7f3569a0", hitparams );
    }
}

// Namespace cluster_grenade
// Params 2, eflags: 0x4
// Checksum 0x7c4d26fe, Offset: 0x8f9
// Size: 0xa2
function private function_bc39314fbfaf9317( submunitions, eventid )
{
    var_53a3104f8dc56f17 = submunitions && isarray( submunitions ) ? arraycopy( submunitions ) : [];
    
    while ( var_53a3104f8dc56f17.size > 0 )
    {
        var_53a3104f8dc56f17 = function_5713d46873b29625( var_53a3104f8dc56f17 );
        wait 0.1;
    }
    
    thread utility::callsharedfunc( #"analytics", #"hash_e348d92f8fdade0c", { #position:self.origin, #equipref:"equip_cluster_grenade", #eventid:eventid, #owner:self } );
}

