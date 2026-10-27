// scripts\mp\common\weapons\ballisticknife.gsc  (hash_3ce52eb3aebd4d28.gscc) (size: 4550 Bytes / 0x11c6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdc8e2b58 (3700304728)
// size ...... 4550 (0x11c6)
// includes .. 8   (offset: 0x10e6)
// strings ... 13  (offset: 0x1126)
// dev strs .. 0   (offset: 0x11c6)
// exports ... 13  (offset: 0x98e)
// cseg ...... 0x130 + 0x85e (0x98e)
// imports ... 47  (offset: 0xb96)
// animtree1 . 0   (offset: 0x11c6)
// animtree2 . 0   (offset: 0x11c6)
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\player;
#using scripts\mp\damagefeedback;
#using scripts\mp\gamelogic;
#using scripts\mp\weapons;

#namespace ballisticknife;

// Namespace ballisticknife
// Params 0, eflags: 0x1
// Checksum 0x50494e81, Offset: 0x14e
// Size: 0x5a
function autoexec init_ballisticknife()
{
    ballisticknife_weapon_name = utility::get_scripted_weapon_name( #"ballisticknife" );
    
    if ( !isdefined( ballisticknife_weapon_name ) )
    {
        return;
    }
    
    rootname = weapon::getweaponrootname( ballisticknife_weapon_name );
    weapons::function_e143510ea2d98f60( rootname, &ballisticknife_used );
    callback::add( #"prematch_cleanup", &prematchcleanup );
}

// Namespace ballisticknife
// Params 2
// Checksum 0x4ea67fd9, Offset: 0x1b0
// Size: 0x1f5
function ballisticknife_used( projectile, objweapon )
{
    self endon( #"disconnect" );
    projectile endon( #"death" );
    projectile.trophy_system_should_ignore = 1;
    projectile waittill( #"missile_stuck", stuckto, stuckpart, surfacetype, velocity, position, normal );
    
    if ( isplayer( stuckto ) )
    {
        projectile.owner thread gamelogic_mp::threadedsetweaponstatbyname( objweapon, 1, "special_hits" );
    }
    
    if ( isdefined( position ) && objweapon.var_727203abf46db6d1 )
    {
        foreach ( player in level.players )
        {
            if ( player != projectile.owner && player::isinlaststand( player ) && distancesquared( player.origin, position ) < 6400 && player damageconetrace( position ) > 0 )
            {
                projectile.owner utility::callsharedfunc( #"weapon", #"hash_d69e4c0c46754e0e", objweapon, player );
            }
        }
    }
    
    if ( stuckto && stuckto isscriptable() && !isplayer( stuckto ) && !isagent( stuckto ) && position )
    {
        self radiusdamage( position, 2, 5, 5, self, "MOD_IMPACT", objweapon, 1 );
        
        if ( projectile islinked() )
        {
            projectile unlink();
        }
    }
    
    projectile makepickup();
}

// Namespace ballisticknife
// Params 0, eflags: 0x4
// Checksum 0x2eac2c91, Offset: 0x3ad
// Size: 0xfe
function private function_859f48a905e4b139()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"projectile_impact_ai", ai );
        
        if ( !isdefined( ai ) )
        {
            continue;
        }
        
        if ( isdefined( self.owner ) )
        {
            self.owner playsoundtoplayer( #"hash_19f6d9c85402ec89", self.owner, self );
        }
        
        foreach ( player in getplayersinradius( self.origin, 1500 ) )
        {
            if ( player != self.owner )
            {
                player playsoundtoplayer( #"hash_4c64eec87022f8c8", player, self );
            }
        }
    }
}

// Namespace ballisticknife
// Params 0, eflags: 0x4
// Checksum 0xf67ed5f6, Offset: 0x4b3
// Size: 0x16e
function private makepickup()
{
    self makeunusable();
    trigger = spawn( "trigger_radius", self.origin, 0, 50, 100 );
    trigger enablelinkto();
    trigger linkto( self );
    self.pickup_trigger = trigger;
    trigger thread watchgrenadedeath( self );
    
    if ( !isdefined( level.ballisticknife_pickups ) )
    {
        level.ballisticknife_pickups = [];
    }
    
    temparr = [ self ];
    ownerpickups = 0;
    
    foreach ( ballisticknife_pickup in level.ballisticknife_pickups )
    {
        if ( isdefined( ballisticknife_pickup ) )
        {
            if ( ballisticknife_pickup.owner == self.owner )
            {
                ownerpickups++;
            }
            
            if ( temparr.size >= 12 || ownerpickups >= 12 )
            {
                ballisticknife_pickup deletepickup();
                continue;
            }
            
            temparr[ temparr.size ] = ballisticknife_pickup;
        }
    }
    
    level.ballisticknife_pickups = temparr;
    self hudoutlineenableforclient( self.owner, "outlinefill_friendly_hvt" );
    thread watchpickup();
    thread watchpickuptimeout();
    utility::function_969f9f5596dba07a( self, &deletepickup );
}

// Namespace ballisticknife
// Params 1, eflags: 0x4
// Checksum 0xc2324978, Offset: 0x629
// Size: 0xa4
function private prematchcleanup( params )
{
    if ( !isdefined( level.ballisticknife_pickups ) )
    {
        return;
    }
    
    foreach ( ballisticknife_pickup in level.ballisticknife_pickups )
    {
        if ( isdefined( ballisticknife_pickup ) )
        {
            ballisticknife_pickup deletepickup();
        }
    }
    
    level.ballisticknife_pickups = [];
}

// Namespace ballisticknife
// Params 0, eflags: 0x4
// Checksum 0x48e975fb, Offset: 0x6d5
// Size: 0x2a
function private watchplayerdeath()
{
    self endon( #"death" );
    self.owner waittill( #"death" );
    deletepickup();
}

// Namespace ballisticknife
// Params 0, eflags: 0x4
// Checksum 0xa01f9374, Offset: 0x707
// Size: 0x147
function private watchpickup()
{
    self endon( #"death" );
    
    while ( true )
    {
        self.pickup_trigger waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( !player player::isreallyalive() )
        {
            continue;
        }
        
        if ( player != self.owner )
        {
            continue;
        }
        
        if ( !player hasweapon( self.weapon_object ) )
        {
            continue;
        }
        
        player_eye_pos = player geteye();
        
        if ( player_eye_pos[ 2 ] >= self.origin[ 2 ] )
        {
            offset = ( 0, 0, 10 );
        }
        else
        {
            offset = ( 0, 0, -6 );
        }
        
        trace = trace::ray_trace( player_eye_pos, self.origin + offset, self, undefined, 1 );
        
        if ( trace[ "hittype" ] != "hittype_entity" )
        {
            if ( trace[ "hittype" ] != "hittype_none" )
            {
                continue;
            }
        }
        
        if ( player trytopickup( self.weapon_object ) )
        {
            if ( !level.damagefeedbacknosound )
            {
                self setscriptablepartstate( "onPickup", "active", 0 );
            }
            
            waitframe();
            deletepickup();
        }
    }
}

// Namespace ballisticknife
// Params 1, eflags: 0x4
// Checksum 0xe9719de8, Offset: 0x856
// Size: 0x82, Type: bool
function private trytopickup( weapon )
{
    stockammo = self getweaponammostock( weapon );
    var_482e9999b75ed3d8 = istrue( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_pack_mule" ) );
    maxammo = utility::get_max_stock_ammo( weapon, var_482e9999b75ed3d8 );
    
    if ( stockammo < maxammo )
    {
        self setweaponammostock( weapon, stockammo + 1 );
        thread function_cec60ff7c3125975();
        return true;
    }
    
    return false;
}

// Namespace ballisticknife
// Params 0, eflags: 0x4
// Checksum 0xea76ec44, Offset: 0x8e1
// Size: 0x2b
function private function_cec60ff7c3125975()
{
    self endon( #"disconnect" );
    damagefeedback::hudicontype( "throwingknife" );
    waitframe();
    self setclientomnvar( "damage_feedback_other", "standard" );
}

// Namespace ballisticknife
// Params 0, eflags: 0x4
// Checksum 0x9a65481a, Offset: 0x914
// Size: 0x18
function private watchpickuptimeout()
{
    self endon( #"death" );
    wait 20;
    deletepickup();
}

// Namespace ballisticknife
// Params 0
// Checksum 0xd7d33c11, Offset: 0x934
// Size: 0x26
function deletepickup()
{
    if ( self.pickup_trigger )
    {
        self.pickup_trigger delete();
    }
    
    if ( self )
    {
        self delete();
    }
}

// Namespace ballisticknife
// Params 1, eflags: 0x4
// Checksum 0xd7ead2a3, Offset: 0x962
// Size: 0x2c
function private watchgrenadedeath( grenade )
{
    self endon( #"death" );
    grenade waittill( #"death" );
    self delete();
}

