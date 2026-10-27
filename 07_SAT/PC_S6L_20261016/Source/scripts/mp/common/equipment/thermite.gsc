// scripts\mp\common\equipment\thermite.gsc  (hash_5df505f989275021.gscc) (size: 6474 Bytes / 0x194a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5a5ae276 (1515905654)
// size ...... 6474 (0x194a)
// includes .. 15  (offset: 0x1786)
// strings ... 25  (offset: 0x17fe)
// dev strs .. 0   (offset: 0x194a)
// exports ... 16  (offset: 0xe3e)
// cseg ...... 0x1f3 + 0xc4b (0xe3e)
// imports ... 59  (offset: 0x10be)
// animtree1 . 0   (offset: 0x194a)
// animtree2 . 0   (offset: 0x194a)
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\common\weapons\underbarrel;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\scripted_weapons;
#using scripts\mp\shellshock;
#using scripts\mp\spawnlogic;
#using scripts\mp\weapons;

#namespace thermite;

// Namespace thermite
// Params 0, eflags: 0x1
// Checksum 0xf910a98f, Offset: 0x211
// Size: 0x33
function autoexec main()
{
    utility::flag_wait( "equipment_initialized" );
    utility::registersharedfunc( #"thermite", #"thermite_used", &thermite_used );
    thermite_init();
}

// Namespace thermite
// Params 0
// Checksum 0x8810059b, Offset: 0x24c
// Size: 0x42
function thermite_init()
{
    weapons::registerusedcallback( "thermite", &thermite_used );
    equipment_mp::registercallback( "equip_thermite", "onPlayerDamaged", &thermite_onplayerdamaged );
    underbarrel::function_ad8d55243cf37b5b( "specialty_ub_db", &thermite_used );
    level thread function_12b997f0a87c98d();
}

// Namespace thermite
// Params 0
// Checksum 0x6b087fc4, Offset: 0x296
// Size: 0xc5
function function_12b997f0a87c98d()
{
    level endon( #"game_ended" );
    utility::flag_wait( "loadEquipmentBundles_finished" );
    bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_thermite" );
    level.equipment_thermite = spawnstruct();
    level.equipment_thermite.bundle = bundle;
    level.equipment_thermite.equipref = "equip_thermite";
    level.equipment_thermite.weaponname = bundle.useweapon ?? "thermite_mp";
    damageweaponname = scripted_weapons::get_scripted_weapon_object( #"thermite_av" ).basenamehash;
    equipment_mp::function_e08050aec5516278( "equip_thermite", damageweaponname );
}

// Namespace thermite
// Params 3
// Checksum 0x4689886f, Offset: 0x363
// Size: 0x100
function thermite_used( grenade, isgl, objweapon )
{
    if ( isdefined( isgl ) )
    {
        grenade thread shellshock::grenade_earthquake();
        glgrenade = grenade;
        grenade = weapon::_launchgrenade( grenade.bundle.useweapon, glgrenade.origin, ( 0, 0, 0 ) );
        weapons::grenadeinitialize( grenade, makeweapon( grenade.bundle.useweapon ) );
        grenade.glgrenade = glgrenade;
        grenade.angles = glgrenade.angles;
        grenade.glgrenadeparent = objweapon;
        grenade linkto( glgrenade );
        grenade.exploding = 1;
        grenade setscriptablepartstate( "visibility", "hide", 0 );
    }
    
    grenade thread thermite_watchdisowned();
    grenade thread thermite_watchstuck( isgl );
}

// Namespace thermite
// Params 0
// Checksum 0x9d0e0562, Offset: 0x46b
// Size: 0x23
function function_537d1d3207fa18bc()
{
    self endon( #"entitydeleted" );
    flags::gameflagwait( "prematch_done" );
    thermite_destroy( 1 );
}

// Namespace thermite
// Params 1
// Checksum 0xa9cc904, Offset: 0x496
// Size: 0x54
function thermite_watchwater( grenade )
{
    grenade endon( #"missile_stuck" );
    thrownunderwater = 0;
    
    if ( player_utility::isswimmingunderwater() )
    {
        thrownunderwater = 1;
    }
    
    grenade waittill( #"missile_water_impact" );
    
    if ( !thrownunderwater )
    {
        grenade notify( #"missile_stuck" );
    }
}

// Namespace thermite
// Params 1
// Checksum 0x8d70da7b, Offset: 0x4f2
// Size: 0x368
function thermite_watchstuck( isgl )
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    self.owner endon( #"joined_team" );
    self.owner endon( #"joined_spectators" );
    stuckto = undefined;
    
    if ( isgl )
    {
        glstuck = thermite_watchglstuck();
        
        if ( !glstuck )
        {
            thread thermite_delete();
            return;
        }
        
        if ( isdefined( self.glgrenade ) )
        {
            self.glgrenade delete();
        }
    }
    else
    {
        self.owner thread thermite_watchwater( self );
        self waittill( #"missile_stuck", stuckto );
    }
    
    if ( !isgl )
    {
        if ( isdefined( stuckto ) )
        {
            if ( isplayer( stuckto ) || isagent( stuckto ) )
            {
                self.owner weapons::grenadestuckto( self, stuckto );
            }
            else
            {
                thread equipment_mp::function_2c8f51009c3dd68f( stuckto, &thermite_destroy, 0 );
            }
            
            callbackparams = { #stuckto:stuckto, #equipmentref:"equip_thermite", #attacker:self.owner };
            callback::callback( #"equipment_stuck", callbackparams );
        }
    }
    
    weaponobj = self.weapon_object;
    
    if ( isdefined( self.glgrenadeparent ) )
    {
        self.owner weapon_utility::function_502496613f00eb2a( weaponobj, self.glgrenadeparent );
    }
    
    thread thermite_watchstucktoterrain();
    
    if ( isdefined( self.weapon_object.attachmentblueprints[ "jup_equip_thermite_rec" ] ) && self.weapon_object.attachmentblueprints[ "jup_equip_thermite_rec" ].attachmentdata == "jup_equip_rec_thermite_v2083" )
    {
        self setscriptablepartstate( "effects", "impact_v1", 0 );
    }
    else
    {
        self setscriptablepartstate( "effects", "impact", 0 );
    }
    
    thermite_doradiusdamage( weaponobj );
    
    if ( !level.dangerzoneskipequipment && isdefined( self.owner.team ) )
    {
        self.dangerzoneid = spawnlogic::addspawninfluencer( #"equipment_thermite", self.origin, self.owner.team, self.owner );
    }
    
    wait self.bundle.thermite_tickinterval;
    var_1c62cef96fbdafca = scripted_weapons::get_scripted_weapon_object( #"thermite_ap" );
    var_1c62c8f96fbda298 = scripted_weapons::get_scripted_weapon_object( #"thermite_av" );
    
    if ( isdefined( self.glgrenadeparent ) )
    {
        self.owner weapon_utility::function_502496613f00eb2a( var_1c62c8f96fbda298, self.glgrenadeparent );
        self.owner weapon_utility::function_502496613f00eb2a( var_1c62cef96fbdafca, self.glgrenadeparent );
    }
    
    ticks = 1;
    
    while ( ticks <= self.bundle.thermite_tickcount )
    {
        curtick = ticks + 1;
        
        if ( curtick % 2 > 0 )
        {
            thermite_doradiusdamage( var_1c62c8f96fbda298 );
        }
        else
        {
            thermite_doradiusdamage( var_1c62cef96fbdafca );
        }
        
        ticks = curtick;
        wait self.bundle.thermite_tickinterval;
    }
    
    thread thermite_destroy();
}

// Namespace thermite
// Params 0
// Checksum 0x2863cf72, Offset: 0x862
// Size: 0x12f, Type: bool
function thermite_watchglstuck()
{
    self.glgrenade endon( #"death" );
    self.owner endon( #"disconnect" );
    self.owner endon( #"joined_team" );
    self.owner endon( #"joined_spectators" );
    self.glgrenade waittill( #"missile_stuck", stuckto, stuckpart, surfacetype, velocity, position, normal );
    
    if ( isdefined( stuckto ) )
    {
        if ( isplayer( stuckto ) || isagent( stuckto ) )
        {
            if ( stuckto player::isreallyalive() )
            {
                if ( isplayer( stuckto ) )
                {
                    self.owner weapons::grenadestuckto( self, stuckto );
                }
                
                if ( isdefined( stuckpart ) )
                {
                    self linkto( stuckto );
                }
                else
                {
                    self linkto( stuckto, "j_spine4", ( 0, 0, 0 ) );
                }
            }
        }
        else if ( isdefined( stuckpart ) )
        {
            self linkto( stuckto, stuckpart );
        }
        else
        {
            self linkto( stuckto );
        }
    }
    
    return true;
}

// Namespace thermite
// Params 0
// Checksum 0x2837cd77, Offset: 0x99a
// Size: 0x10a
function thermite_watchstucktoterrain()
{
    self endon( #"death" );
    stuckto = self getlinkedparent();
    
    while ( isdefined( stuckto ) )
    {
        self waittill( #"missile_stuck", stuckto );
    }
    
    if ( isdefined( level.var_3d90777bfb7fc504 ) )
    {
        self.badplace = function_30c25bea1909556f( self.origin, ( self.bundle.var_ffc4631ebc69340c, self.bundle.var_ffc4631ebc69340c, self.bundle.var_ffc4631ebc69340c ), ( 0, 0, 0 ), level.var_3d90777bfb7fc504 );
        return;
    }
    
    self.badplace = createnavbadplacebybounds( self.origin, ( self.bundle.var_ffc4631ebc69340c, self.bundle.var_ffc4631ebc69340c, self.bundle.var_ffc4631ebc69340c ), ( 0, 0, 0 ) );
}

// Namespace thermite
// Params 1
// Checksum 0xe8585a57, Offset: 0xaac
// Size: 0x175
function thermite_doradiusdamage( weaponobj )
{
    radius = self.bundle.var_ef4ffe68016798bb;
    innerdamage = self.bundle.var_8bb0a75423d5f1dd;
    outerdamage = self.bundle.var_afb09c2983880dd6;
    meansofdeath = "MOD_FIRE";
    
    if ( weaponobj.basename == self.bundle.useweapon )
    {
        radius = self.bundle.var_ffc4631ebc69340c;
        innerdamage = self.bundle.var_7b577d06db7cd2b4;
        outerdamage = self.bundle.var_565ef47cbce7d057;
    }
    
    stuckto = self.stuckenemyentity;
    
    if ( isdefined( stuckto ) )
    {
        if ( isplayer( stuckto ) && player::isreallyalive( stuckto ) )
        {
            stuckto dodamage( innerdamage, self.origin, self.owner, self, meansofdeath, weaponobj, "torso_upper" );
            stuckto damage_utility::adddamagemodifier( "thermiteStuck", 0, 0, &thermite_damagemodifierignorefunc );
        }
        else
        {
            stuckto = undefined;
        }
    }
    
    self radiusdamage( self.origin, radius, innerdamage, outerdamage, self.owner, meansofdeath, weaponobj );
    
    if ( isdefined( stuckto ) )
    {
        stuckto damage_utility::removedamagemodifier( "thermiteStuck", 0 );
    }
}

// Namespace thermite
// Params 7
// Checksum 0x5f319acb, Offset: 0xc29
// Size: 0x86, Type: bool
function thermite_damagemodifierignorefunc( inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc )
{
    if ( !isdefined( inflictor ) )
    {
        return true;
    }
    
    if ( inflictor.weapon_name != level.equipment_thermite.weaponname )
    {
        return true;
    }
    
    if ( inflictor.stuckenemyentity != victim )
    {
        return true;
    }
    
    return false;
}

// Namespace thermite
// Params 0
// Checksum 0x6a81a87, Offset: 0xcb8
// Size: 0x34
function thermite_watchdisowned()
{
    self endon( #"death" );
    self.owner utility::waittill_any( "joined_team", "joined_spectators", "disconnect" );
    thread thermite_destroy();
}

// Namespace thermite
// Params 1
// Checksum 0xb02f8c98, Offset: 0xcf4
// Size: 0x3c
function thermite_destroy( isimmediate )
{
    time = 5;
    
    if ( isimmediate )
    {
        time = undefined;
    }
    
    self setscriptablepartstate( "effects", "burnEnd", 0 );
    thread thermite_delete( time );
}

// Namespace thermite
// Params 1
// Checksum 0xc9037b91, Offset: 0xd38
// Size: 0x8b
function thermite_delete( deletiondelay )
{
    self notify( #"death" );
    self.exploding = 1;
    
    if ( isdefined( self.dangerzoneid ) )
    {
        spawnlogic::removespawninfluencer( self.dangerzoneid );
        self.dangerzoneid = undefined;
    }
    
    if ( isdefined( self.badplace ) )
    {
        destroynavobstacle( self.badplace );
        self.badplace = undefined;
    }
    
    self forcehidegrenadehudwarning( 1 );
    
    if ( isdefined( deletiondelay ) )
    {
        wait deletiondelay;
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace thermite
// Params 1
// Checksum 0x2c27d2b8, Offset: 0xdcb
// Size: 0x72, Type: bool
function thermite_onplayerdamaged( data )
{
    if ( data.meansofdeath == "MOD_IMPACT" )
    {
        return true;
    }
    
    data.victim.lastburntime = gettime();
    data.victim thread damage_effects::enableburnfxfortime( 0.6 );
    data.victim player::codcastersetplayerstatuseffect( "fire", 0.6 );
    return true;
}

