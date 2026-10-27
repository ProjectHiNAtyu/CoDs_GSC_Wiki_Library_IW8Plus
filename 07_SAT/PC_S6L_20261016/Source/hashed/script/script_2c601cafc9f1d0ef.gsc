// script_2c601cafc9f1d0ef  (hash_2c601cafc9f1d0ef.gscc) (size: 4664 Bytes / 0x1238 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2813c64a (672384586)
// size ...... 4664 (0x1238)
// includes .. 10  (offset: 0x1174)
// strings ... 5   (offset: 0x11c4)
// dev strs .. 3   (offset: 0x1214)
// exports ... 13  (offset: 0xa74)
// cseg ...... 0xaa + 0x9ca (0xa74)
// imports ... 44  (offset: 0xc7c)
// animtree1 . 0   (offset: 0x1238)
// animtree2 . 0   (offset: 0x1238)
#using script_ac28d65e8605696;
#using script_e92a9717969a5cd;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\equipment;
#using scripts\mp\loot\common_item;
#using scripts\mp\weapons;

#namespace europa_grenade;

// Namespace europa_grenade
// Params 0, eflags: 0x5
// Checksum 0x78b585f1, Offset: 0xc8
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"europa_grenade", undefined, undefined, &post_main );
}

// Namespace europa_grenade
// Params 0
// Checksum 0x89665b75, Offset: 0xe9
// Size: 0x36
function post_main()
{
    /#
        devgui_init();
    #/
    
    callback::add( #"europa_init", &on_init );
    callback::add( #"europa_activated", &on_activated );
}

// Namespace europa_grenade
// Params 1, eflags: 0x4
// Checksum 0x7b43c857, Offset: 0x127
// Size: 0x57
function private on_init( params )
{
    europa::register_cool_down( "kazimir", self.aisettings.specificaisettings.var_d956767e63bda0d2 );
    thread function_6885f0b949473cad();
    weapon = common_item::function_90c3e0c1fd55d6b6( %"grenadeweapon:sat_blackhole_bomb_zm" );
}

// Namespace europa_grenade
// Params 1
// Checksum 0x15f53307, Offset: 0x186
// Size: 0x3d
function on_activated( params )
{
    self.europa.grenadeammo = self.aisettings.specificaisettings.var_1dda095119818f16;
}

// Namespace europa_grenade
// Params 1
// Checksum 0x2935a98f, Offset: 0x1cb
// Size: 0x332
function function_6a60d15d10bd5883( target )
{
    self notify( #"hash_fb4c114c6993f831" );
    self endon( #"hash_fb4c114c6993f831" );
    level endon( #"game_ended" );
    self endon( #"death" );
    europa::function_47761cd429bc0244();
    targetpos = target.origin;
    settings = self.aisettings.specificaisettings;
    minrange = getdvarfloat( @"hash_c9bc8a3f583d2405", settings.var_5085ffe48e09a0e0 );
    maxrange = getdvarfloat( @"hash_f37c5e4da0721527", settings.var_31ed65b81db4012e );
    dir = vectornormalize( targetpos - self.origin );
    
    if ( distancesquared( self.origin, targetpos ) < minrange * minrange )
    {
        targetpos = self.origin + dir * minrange;
    }
    else if ( distancesquared( self.origin, targetpos ) > maxrange * maxrange )
    {
        targetpos = self.origin + dir * maxrange;
    }
    
    if ( !europa::is_pos_reachable( targetpos ) )
    {
        return;
    }
    
    self.europa.isthrowgrenade = 1;
    throwtime = 1.467;
    thread europa_asm::play_scripted_anim( "grenade_throw_short" );
    thread europa_asm::face_to_target( target, throwtime );
    throworigin = self gettagorigin( "tag_accessory_left", 1 );
    vecto = targetpos - self.origin;
    vecmid = self.origin + vecto * 0.5;
    dis = length( vecto );
    vectop = vecmid + ( 0, 0, dis * 0.3 );
    throwdir = vectornormalize( vectop - self.origin );
    throwforce = dis * settings.var_babfbb202da0161b;
    thread europa::play_vo( "kazimir" );
    wait 0.3;
    bundle = equipment_mp::getEquipmentBundleFromWeaponName( self.grenadeweapon.basename );
    model = utility::spawn_model( bundle.model );
    model linkto( self, "tag_accessory_left", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    wait throwtime;
    model unlink();
    model delete();
    grenade = magicgrenademanual( self.grenadeweapon, throworigin, throwdir * throwforce );
    grenade.owner = self;
    self notify( #"grenade_fire", grenade, self.grenadeweapon, 0, self );
    
    if ( self.europa.grenadeammo > 0 )
    {
        self.europa.grenadeammo--;
    }
    
    self.europa.isthrowgrenade = 0;
    self notify( #"hash_31e53c779f17ca7f" );
    grenade thread function_89d5d27e18461c0f();
    return 1;
}

// Namespace europa_grenade
// Params 0, eflags: 0x4
// Checksum 0x7944f119, Offset: 0x506
// Size: 0xc0
function private function_89d5d27e18461c0f()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"vortex_implode" );
    settings = self.owner.aisettings.specificaisettings;
    
    while ( true )
    {
        enemies = utility::callsharedfunc( #"zombie", #"get_round_enemies" );
        
        if ( self.var_be3ddb862deb0056 && enemies && enemies.size <= settings.var_826b4b3342bb784b )
        {
            utility::callsharedfunc( #"blackhole_bomb", #"hash_754b989869c9d2cf" );
            break;
        }
        
        wait 0.5;
    }
}

// Namespace europa_grenade
// Params 0, eflags: 0xc
// Checksum 0x4fc28083, Offset: 0x5ce
// Size: 0x9f
function private function_6885f0b949473cad()
{
    self notify( #"hash_bc82661459afa181" );
    self endon( #"hash_bc82661459afa181" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"grenade_fire", grenade, objweapon, tickpercent, originalowner );
        weapons::grenadeinitialize( grenade, objweapon, tickpercent, originalowner );
        weapons::grenadeused( grenade );
        europa::start_cool_down( "kazimir" );
        europa::start_cool_down( "skill_common" );
    }
}

// Namespace europa_grenade
// Params 1
// Checksum 0x95da8dbf, Offset: 0x675
// Size: 0x2e9
function function_4189b8455e9d7cd0( taskid )
{
    /#
        if ( getdvarint( @"hash_5505e9a27eb11977" ) )
        {
            return anim.failure;
        }
    #/
    
    if ( self.europa.grenadeammo <= 0 )
    {
        return anim.failure;
    }
    
    if ( !self.enemy )
    {
        return anim.failure;
    }
    
    if ( europa::is_script_animation() )
    {
        return anim.failure;
    }
    
    if ( europa::has_cool_down( "kazimir" ) || europa::has_cool_down( "skill_common" ) )
    {
        return anim.failure;
    }
    
    settings = self.aisettings.specificaisettings;
    enemies = utility::callsharedfunc( #"zombie", #"get_round_enemies" );
    
    if ( enemies )
    {
        if ( enemies.size <= settings.var_fc3b933b47d6d2d7 )
        {
            return anim.failure;
        }
    }
    
    targets = getaiarrayinradius( self.origin, settings.var_31ed65b81db4012e );
    enemycount = 0;
    distancesq = settings.var_5085ffe48e09a0e0 * settings.var_5085ffe48e09a0e0;
    minsq = -1;
    
    foreach ( target in targets )
    {
        if ( target.team == self.team || !isalive( target ) || !target val::get( "damage" ) || !europa::is_pos_reachable( target.origin ) )
        {
            continue;
        }
        
        enemycount++;
        
        if ( distancesquared( self.origin, target.origin ) > distancesq )
        {
            var_3052f02e0351fe19 = distancesquared( self.enemy.origin, target.origin );
            
            if ( minsq == -1 || var_3052f02e0351fe19 < minsq )
            {
                throwtarget = target;
            }
        }
    }
    
    if ( !throwtarget )
    {
        return anim.failure;
    }
    
    var_d321f07da41f6f00 = settings.var_d321f07da41f6f00 ?? 5;
    shoulduse = enemycount > var_d321f07da41f6f00;
    self.var_ea5190c6b9f30f19 = shoulduse;
    self.throwgrenadeatenemyasap = shoulduse;
    self.var_8dbc0d889bc68af5 = throwtarget;
    return shoulduse ? anim.success : anim.failure;
}

// Namespace europa_grenade
// Params 1
// Checksum 0x804a4bd6, Offset: 0x967
// Size: 0x25
function function_45d996706418d7f9( taskid )
{
    thread function_6a60d15d10bd5883( self.var_8dbc0d889bc68af5 );
    return anim.success;
}

// Namespace europa_grenade
// Params 1
// Checksum 0xc5870e89, Offset: 0x995
// Size: 0x59
function function_2c928847aab649ee( taskid )
{
    if ( !self.europa.isthrowgrenade )
    {
        if ( self.europa.throwgrenadesuccess )
        {
            return anim.success;
        }
        else
        {
            return anim.failure;
        }
    }
    
    return anim.running;
}

/#

    // Namespace europa_grenade
    // Params 0
    // Checksum 0x4d44e97, Offset: 0x9f7
    // Size: 0x2e, Type: dev
    function devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x35>", "<dev string:x4b>", &devgui_throw_grenade );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace europa_grenade
    // Params 0
    // Checksum 0x8cf597e4, Offset: 0xa2d
    // Size: 0x47, Type: dev
    function devgui_throw_grenade()
    {
        tgt = level.europa.enemy ?? level.player;
        
        if ( tgt )
        {
            level.europa thread function_6a60d15d10bd5883( tgt );
        }
    }

#/
