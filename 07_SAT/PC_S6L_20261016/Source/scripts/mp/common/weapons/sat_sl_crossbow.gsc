// scripts\mp\common\weapons\sat_sl_crossbow.gsc  (hash_5fb1666801a8934d.gscc) (size: 4163 Bytes / 0x1043 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3dc86262 (1036542562)
// size ...... 4163 (0x1043)
// includes .. 7   (offset: 0xf73)
// strings ... 12  (offset: 0xfab)
// dev strs .. 0   (offset: 0x1043)
// exports ... 11  (offset: 0x88f)
// cseg ...... 0x183 + 0x70c (0x88f)
// imports ... 45  (offset: 0xa47)
// animtree1 . 0   (offset: 0x1043)
// animtree2 . 0   (offset: 0x1043)
#using scripts\common\ai;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\weapons;

#namespace sat_sl_crossbow;

// Namespace sat_sl_crossbow
// Params 0, eflags: 0x5
// Checksum 0x4fda3710, Offset: 0x1a1
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"sat_sl_crossbow", undefined, undefined, &post_main );
}

// Namespace sat_sl_crossbow
// Params 0, eflags: 0x4
// Checksum 0xeb8a7a8, Offset: 0x1c2
// Size: 0x8d
function private post_main()
{
    crossbow_weapon_name = utility::get_scripted_weapon_name( #"crossbow" );
    
    if ( !isdefined( crossbow_weapon_name ) )
    {
        return;
    }
    
    rootname = weapon::getweaponrootname( crossbow_weapon_name );
    weapons::function_e143510ea2d98f60( rootname, &crossbow_used );
    weapons::function_622fd25a029f07c9( getxhashasset( crossbow_weapon_name ) );
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"hash_5c15fd29ca6d7906" ) )
    {
        utility::callsharedfunc( #"zombie_damage", #"hash_5c15fd29ca6d7906", "sat_sl_crossbow_explosive_bolt", rootname );
    }
}

// Namespace sat_sl_crossbow
// Params 2
// Checksum 0x7ec62b84, Offset: 0x257
// Size: 0x357
function crossbow_used( missile, objweapon )
{
    self endon( #"disconnect" );
    missile endon( #"death" );
    
    if ( !objweapon hasattachment( "sat_ammo_crossbow_bolt_explode" ) )
    {
        missile.trophy_system_should_ignore = 1;
        missile thread function_6023516fceee51dd();
        thread function_219afb71a1098712( missile, objweapon );
        return;
    }
    
    stuckdata = spawnstruct();
    childthread function_d164551305416c10( missile, stuckdata );
    missile waittill( #"missile_stuck", stuckto, stuckpart, surfacetype, velocity, position, normal );
    waittillframeend();
    self notify( #"hash_c5f349a613d28cf" );
    missile hide();
    stuckposition = position + normal;
    grenade = "sat_sl_crossbow_explosive_bolt_mp";
    
    if ( objweapon hasattachment( "sat_zm_sl_crossbow_pack" ) )
    {
        grenade = "sat_sl_crossbow_explosive_bolt_pap";
    }
    else if ( objweapon hasattachment( "sat_zm_sl_crossbow_pack4" ) )
    {
        grenade = "sat_sl_crossbow_explosive_bolt_pap4";
    }
    
    var_fd924e81eafb5cbd = weapon::_launchgrenade( weapon::buildweapon( grenade, undefined, undefined, undefined, objweapon.variantid ?? 0 ), stuckposition, velocity );
    weapons::grenadeinitialize( var_fd924e81eafb5cbd, weapon::buildweapon( grenade, undefined, undefined, undefined, objweapon.variantid ?? 0 ) );
    var_fd924e81eafb5cbd.angles = missile.angles;
    var_fd924e81eafb5cbd.glgrenadeparent = objweapon;
    var_fd924e81eafb5cbd.stuckdata = stuckdata;
    
    if ( isdefined( stuckto ) )
    {
        if ( isplayer( stuckto ) || isagent( stuckto ) )
        {
            if ( stuckto player::isreallyalive() )
            {
                if ( isplayer( stuckto ) )
                {
                    weapons::grenadestuckto( var_fd924e81eafb5cbd, stuckto, 1 );
                    
                    if ( hasomnvar( o"ui_grenade_stuck_notify" ) )
                    {
                        stuckto setclientomnvar( o"ui_grenade_stuck_notify", gettime() );
                    }
                }
                
                if ( isdefined( stuckpart ) && stuckto tagexists( stuckpart ) )
                {
                    var_fd924e81eafb5cbd linkto( stuckto, stuckpart );
                }
                else
                {
                    var_fd924e81eafb5cbd linkto( stuckto, "j_spine4" );
                }
                
                stuckto playlocalsound( #"eqp_semtex_sat_warning" );
            }
            
            if ( isdefined( level.battlechatter ) && isagent( stuckto ) )
            {
                addbattlechatternotify( stuckto, undefined, "semtex_stuck" );
            }
            
            if ( isagent( stuckto ) && stuckto.health > 0 && !stuckto.var_2f7b28254901f8d6 )
            {
                if ( !isdefined( stuckto.var_f424a6135c1dd01f ) )
                {
                    stuckto.var_f424a6135c1dd01f = [];
                }
                else
                {
                    stuckto.var_f424a6135c1dd01f = function_46f9072493651dc9( stuckto.var_f424a6135c1dd01f );
                }
                
                stuckto.var_f424a6135c1dd01f[ stuckto.var_f424a6135c1dd01f.size ] = var_fd924e81eafb5cbd;
                ai::function_9b5d55d642edff87( var_fd924e81eafb5cbd, stuckto );
            }
        }
        
        var_fd924e81eafb5cbd.stuckdata.stuckto = stuckto;
        var_fd924e81eafb5cbd thread function_299398447facbe9a( stuckto );
    }
    
    var_fd924e81eafb5cbd thread watchunlink();
    
    if ( var_fd924e81eafb5cbd isscriptable() && var_fd924e81eafb5cbd getscriptableparthasstate( "state", "warning" ) )
    {
        var_fd924e81eafb5cbd setscriptablepartstate( "state", "warning" );
    }
    
    utility::function_969f9f5596dba07a( var_fd924e81eafb5cbd, &on_crushed );
    missile delete();
}

// Namespace sat_sl_crossbow
// Params 0, eflags: 0x4
// Checksum 0xb5b844d8, Offset: 0x5b6
// Size: 0x8
function private on_crushed()
{
    self delete();
}

// Namespace sat_sl_crossbow
// Params 2, eflags: 0x4
// Checksum 0xb293a2b9, Offset: 0x5c6
// Size: 0x49
function private function_d164551305416c10( missile, stuckdata )
{
    self endon( #"hash_c5f349a613d28cf" );
    missile waittill( #"hash_c167e145cfc24a47", scriptablereturned );
    stuckdata.var_4ca36b89aa230d40 = scriptablereturned;
}

// Namespace sat_sl_crossbow
// Params 0, eflags: 0x4
// Checksum 0xf0ba384f, Offset: 0x617
// Size: 0x41
function private watchunlink()
{
    level endon( #"game_ended" );
    self endon( #"explode" );
    self endon( #"death" );
    self waittill( #"unlinkgrenade" );
    
    if ( self islinked() )
    {
        self unlink();
    }
}

// Namespace sat_sl_crossbow
// Params 1, eflags: 0x4
// Checksum 0x31d3ae3a, Offset: 0x660
// Size: 0x46
function private function_299398447facbe9a( stuckto )
{
    level endon( #"game_ended" );
    self endon( #"explode" );
    self endon( #"death" );
    
    while ( isdefined( stuckto ) )
    {
        waitframe();
    }
    
    self notify( #"unlinkgrenade" );
}

// Namespace sat_sl_crossbow
// Params 0, eflags: 0x4
// Checksum 0x4e5e61c8, Offset: 0x6ae
// Size: 0xe8
function private function_b03adef181897f38()
{
    level endon( #"game_ended" );
    self endon( #"explode" );
    self endon( #"death" );
    
    if ( isdefined( self.stuckdata ) && isdefined( self.stuckdata.var_4ca36b89aa230d40 ) && self.stuckdata.var_4ca36b89aa230d40 scriptableisdoor() )
    {
        var_5e216732175e8f7d = self.stuckdata.var_4ca36b89aa230d40 scriptabledoorangle();
        
        while ( true )
        {
            wait 0.1;
            
            if ( !isdefined( self.stuckdata.var_4ca36b89aa230d40 ) )
            {
                break;
            }
            
            doordegrees = self.stuckdata.var_4ca36b89aa230d40 scriptabledoorangle();
            
            if ( doordegrees != var_5e216732175e8f7d )
            {
                break;
            }
        }
        
        self notify( #"unlinkgrenade" );
    }
}

// Namespace sat_sl_crossbow
// Params 0
// Checksum 0x5760fcf0, Offset: 0x79e
// Size: 0x24
function function_6023516fceee51dd()
{
    self endon( #"death" );
    utility::function_969f9f5596dba07a( self, &on_crushed );
    wait 8;
    self delete();
}

// Namespace sat_sl_crossbow
// Params 2, eflags: 0x4
// Checksum 0xc00762cb, Offset: 0x7ca
// Size: 0xc5
function private function_219afb71a1098712( missile, objweapon )
{
    self endon( #"disconnect" );
    missile endon( #"death" );
    missile waittill( #"missile_stuck", stuckto, stuckpart, surfacetype, velocity, position, normal );
    waittillframeend();
    
    if ( stuckto && stuckto isscriptable() && !isplayer( stuckto ) && !isagent( stuckto ) && position )
    {
        self radiusdamage( position, 2, 5, 5, self, "MOD_IMPACT", objweapon, 1 );
        missile delete();
    }
}

