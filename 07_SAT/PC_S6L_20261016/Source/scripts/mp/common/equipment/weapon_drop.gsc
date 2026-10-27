// scripts\mp\common\equipment\weapon_drop.gsc  (hash_7349d2e65d470f3b.gscc) (size: 4791 Bytes / 0x12b7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2ce79a92 (753375890)
// size ...... 4791 (0x12b7)
// includes .. 6   (offset: 0x1193)
// strings ... 19  (offset: 0x11c3)
// dev strs .. 0   (offset: 0x12b7)
// exports ... 16  (offset: 0x933)
// cseg ...... 0x1f8 + 0x73b (0x933)
// imports ... 52  (offset: 0xbb3)
// animtree1 . 0   (offset: 0x12b7)
// animtree2 . 0   (offset: 0x12b7)
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\equipment\ammo_box;
#using scripts\mp\common\killstreaks\helper_drone;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\killstreak_utility;

#namespace weapon_drop;

// Namespace weapon_drop
// Params 0
// Checksum 0x7b8cff85, Offset: 0x216
// Size: 0x1b
function weapondrop_init()
{
    level._effect[ "weapon_drop_impact" ] = loadfxasset( "vfx_iw9_strk_smoke_signal_carepkg_landing_dust" );
}

// Namespace weapon_drop
// Params 0
// Checksum 0xfc1184ff, Offset: 0x239
// Size: 0xb, Type: bool
function weapondrop_beginsuper()
{
    thread weapondrop_givedropweapon();
    return true;
}

// Namespace weapon_drop
// Params 0
// Checksum 0xc39c6783, Offset: 0x24d
// Size: 0x10b
function weapondrop_givedropweapon()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    waitframe();
    streakinfo = killstreak_utility::createstreakinfo( "weapondrop", self );
    streakinfo.deployweaponobj = makeweapon( "deploy_weapondrop_mp" );
    val::set( "giveDropWeapon", "killstreaks", 0 );
    deployresult = killstreakdeploy::streakdeploy_doweaponfireddeploy( streakinfo, streakinfo.deployweaponobj, "grenade_fire" );
    val::reset_all( "giveDropWeapon" );
    
    if ( deployresult )
    {
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        
        if ( utility::issharedfuncdefined( #"supers", #"superusefinished" ) )
        {
            [[ utility::getsharedfunc( #"supers", #"superusefinished" ) ]]();
        }
        
        return;
    }
    
    if ( utility::issharedfuncdefined( #"supers", #"superusefinished" ) )
    {
        [[ utility::getsharedfunc( #"supers", #"superusefinished" ) ]]( 1 );
    }
}

// Namespace weapon_drop
// Params 1
// Checksum 0xf66e33a9, Offset: 0x360
// Size: 0x4c, Type: bool
function weapondrop_used( grenade )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    grenade waittill( #"explode", pos );
    grenade weapondrop_deploydrone( self, pos );
    return true;
}

// Namespace weapon_drop
// Params 2
// Checksum 0xe3e29bbc, Offset: 0x3b5
// Size: 0x104
function weapondrop_deploydrone( owner, pos )
{
    drone = owner helper_drone::deliverydrone_delivertopoint( pos, &weapondrop_dronedelivery );
    
    if ( isdefined( drone ) )
    {
        deliverybox = spawn( "script_model", drone.origin );
        deliverybox setmodel( "military_crate_field_upgrade_01" );
        deliverybox setotherent( owner );
        deliverybox.owner = owner;
        deliverybox.team = owner.team;
        deliverybox linkto( drone, "tag_origin", ( 0, 0, -15 ), ( 0, 0, 0 ) );
        deliverybox enableplayermarks( #"killstreak" );
        
        if ( level.teambased )
        {
            deliverybox filteroutplayermarks( owner.team );
        }
        else
        {
            deliverybox filteroutplayermarks( owner );
        }
        
        drone.deliverybox = deliverybox;
        drone thread weapondrop_createdropondeath( deliverybox );
    }
}

// Namespace weapon_drop
// Params 0
// Checksum 0x46880cb3, Offset: 0x4c1
// Size: 0x12
function weapondrop_dronedelivery()
{
    self.deliverybox weapondrop_createdrop();
}

// Namespace weapon_drop
// Params 1
// Checksum 0xf074e2ea, Offset: 0x4db
// Size: 0x54
function weapondrop_createdropondeath( deliverybox )
{
    level endon( #"game_ended" );
    level endon( #"prematch_cleanup" );
    deliverybox endon( #"hash_77cc00e6c30e82db" );
    deliverybox endon( #"death" );
    self waittill( #"death" );
    deliverybox thread weapondrop_createdrop();
}

// Namespace weapon_drop
// Params 0
// Checksum 0xd54be835, Offset: 0x537
// Size: 0x88
function weapondrop_createdrop()
{
    if ( self.hasdropped )
    {
        return;
    }
    
    self.hasdropped = 1;
    self notify( #"hash_77cc00e6c30e82db" );
    self unlink();
    cratephysicson();
    targetlocation = self.origin - ( 0, 0, 1000 );
    killstreak_utility::function_e6fc48237c0a5166( #"carepackage_drop", targetlocation, self.team, self.owner );
    thread watchcrateimpact();
    thread watchcratesettle();
}

// Namespace weapon_drop
// Params 0
// Checksum 0xb9547987, Offset: 0x5c7
// Size: 0xf
function deletecrate()
{
    cratephysicsoff();
    self delete();
}

// Namespace weapon_drop
// Params 0
// Checksum 0xfd7b058b, Offset: 0x5de
// Size: 0x71
function cratephysicson()
{
    if ( self.physicson )
    {
        return;
    }
    
    self.physicson = 1;
    self.unresolved_collision_kill = 1;
    self physicslaunchserver( ( 0, 0, 0 ), ( 0, 0, 0 ) );
    bodyid = self physics_getbodyid( 0 );
    physics_setbodycenterofmassnormal( bodyid, ( 0, 0, -0.75 ) );
    self physics_registerforcollisioncallback();
}

// Namespace weapon_drop
// Params 0
// Checksum 0xc8c22f3f, Offset: 0x657
// Size: 0x4e
function cratephysicsoff()
{
    if ( !self.physicson )
    {
        return;
    }
    
    self notify( #"hash_f044f0fe86fc111c" );
    self.physicson = undefined;
    self.unresolved_collision_kill = undefined;
    self physicsstopserver();
    self physics_unregisterforcollisioncallback();
    self stoploopsound( "mp_care_package_drop_lp" );
    killstreak_utility::function_43ef8750f44fafce();
}

// Namespace weapon_drop
// Params 0
// Checksum 0x1fa28057, Offset: 0x6ad
// Size: 0x6e
function watchcratesettle()
{
    self endon( #"hash_f044f0fe86fc111c" );
    watchcratesettleinternal();
    
    if ( utility::issharedfuncdefined( #"entity", #"touchingbadtrigger" ) )
    {
        if ( self [[ utility::getsharedfunc( #"entity", #"touchingbadtrigger" ) ]]() )
        {
            thread deletecrate();
            return;
        }
    }
    
    self.owner thread ammo_box::ammobox_settled( self );
    thread cratephysicsoff();
}

// Namespace weapon_drop
// Params 0
// Checksum 0xa0636fdb, Offset: 0x723
// Size: 0x59
function watchcratesettleinternal()
{
    wait 1;
    endtime = gettime() + 10000;
    
    while ( gettime() < endtime )
    {
        bodyid = self physics_getbodyid( 0 );
        velocity = physics_getbodylinvel( bodyid );
        
        if ( lengthsquared( velocity ) <= 0.5 )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace weapon_drop
// Params 1
// Checksum 0xc0f1eabb, Offset: 0x784
// Size: 0x124
function watchcrateimpact( delay )
{
    self endon( #"hash_f044f0fe86fc111c" );
    self playloopsound( "mp_care_package_drop_lp" );
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    var_a0dc21757f0d4d96 = 0;
    
    while ( true )
    {
        self waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
        
        if ( isdefined( ent ) && ent helper_drone::ishelperdrone() )
        {
            ent thread helper_drone::helperdrone_handledeathdamage();
        }
        
        if ( gettime() - var_a0dc21757f0d4d96 >= 200 )
        {
            var_a0dc21757f0d4d96 = gettime();
            surface = physics_getsurfacetypefromflags( flag1 );
            surfacetype = getsubstr( surface[ "name" ], 9 );
            
            if ( surfacetype == "user_terrain1" )
            {
                surfacetype = "user_terrain_1";
            }
            
            if ( surfacetype == "user_terrain5" )
            {
                surfacetype = "oil_puddle";
            }
            
            playcrateimpactfx( position, normal, impulse, surfacetype );
        }
    }
}

// Namespace weapon_drop
// Params 4
// Checksum 0xd86a8ba5, Offset: 0x8b0
// Size: 0x83
function playcrateimpactfx( position, normal, impulse, surfacetype )
{
    playfx( utility::getfx( "weapon_drop_impact" ), position, normal );
    
    if ( impulse < 150 )
    {
        self playsurfacesound( "mp_care_package_low_impact", surfacetype );
    }
    else if ( impulse < 300 )
    {
        self playsurfacesound( "mp_care_package_med_impact", surfacetype );
    }
    else
    {
        self playsurfacesound( "mp_care_package_high_impact", surfacetype );
    }
    
    self stoploopsound( "mp_care_package_drop_lp" );
}

