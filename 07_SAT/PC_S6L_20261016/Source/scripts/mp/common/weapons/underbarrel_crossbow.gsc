// scripts\mp\common\weapons\underbarrel_crossbow.gsc  (hash_5268c2e3f7d199af.gscc) (size: 3071 Bytes / 0xbff / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x858ce608 (2240603656)
// size ...... 3071 (0xbff)
// includes .. 6   (offset: 0xb4b)
// strings ... 9   (offset: 0xb7b)
// dev strs .. 1   (offset: 0xbf3)
// exports ... 8   (offset: 0x64f)
// cseg ...... 0xf8 + 0x557 (0x64f)
// imports ... 33  (offset: 0x78f)
// animtree1 . 0   (offset: 0xbff)
// animtree2 . 0   (offset: 0xbff)
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\weapons\underbarrel;
#using scripts\mp\weapons;

#namespace underbarrel_crossbow;

// Namespace underbarrel_crossbow
// Params 0, eflags: 0x1
// Checksum 0xafe3110d, Offset: 0x116
// Size: 0x13
function autoexec init_underbarrel_crossbow()
{
    underbarrel::function_ad8d55243cf37b5b( "specialty_ub_crossbow", &function_266a4fc1520a6ecb );
}

// Namespace underbarrel_crossbow
// Params 3
// Checksum 0xc56056ed, Offset: 0x131
// Size: 0x336
function function_266a4fc1520a6ecb( glgrenade, isgl, objweapon )
{
    self endon( #"disconnect" );
    glgrenade endon( #"death" );
    stuckdata = spawnstruct();
    childthread function_d164551305416c10( glgrenade, stuckdata );
    glgrenade waittill( #"missile_stuck", stuckto, stuckpart, surfacetype, velocity, position, normal );
    waittillframeend();
    self notify( #"hash_fc421c521b974080" );
    glgrenade hide();
    stuckposition = position - normal;
    grenade = weapon::_launchgrenade( "t10_ub_crossbow_explosive_bolt_mp", stuckposition, ( 0, 0, 0 ) );
    weapons::grenadeinitialize( grenade, makeweapon( "t10_ub_crossbow_explosive_bolt_mp" ) );
    grenade.angles = glgrenade.angles;
    grenade.glgrenadeparent = objweapon;
    grenade.var_84944d70bd5e9c2d = 1;
    grenade.stuckdata = stuckdata;
    
    if ( isdefined( stuckto ) )
    {
        if ( isplayer( stuckto ) || isagent( stuckto ) )
        {
            if ( stuckto player::isreallyalive() )
            {
                if ( isplayer( stuckto ) )
                {
                    weapons::grenadestuckto( grenade, stuckto, 1 );
                }
                
                if ( isdefined( stuckpart ) )
                {
                    grenade linkto( stuckto, stuckpart );
                }
                else
                {
                    grenade linkto( stuckto, "j_spine4" );
                }
            }
            
            if ( isdefined( level.battlechatter ) && isagent( stuckto ) )
            {
                addbattlechatternotify( stuckto, undefined, "semtex_stuck" );
            }
            
            if ( isagent( stuckto ) && !stuckto.var_2f7b28254901f8d6 )
            {
                if ( !isdefined( stuckto.var_f424a6135c1dd01f ) )
                {
                    stuckto.var_f424a6135c1dd01f = [];
                }
                else
                {
                    stuckto.var_f424a6135c1dd01f = function_46f9072493651dc9( stuckto.var_f424a6135c1dd01f );
                }
                
                stuckto.var_f424a6135c1dd01f[ stuckto.var_f424a6135c1dd01f.size ] = grenade;
                assert( stuckto.health > 0, "<dev string:x24>" );
                ai::function_9b5d55d642edff87( grenade, stuckto );
            }
        }
        else if ( isdefined( stuckpart ) && stuckto.model != "" && stuckpart != "scriptbrushmodeldummy" && stuckto.classname != "script_brushmodel" )
        {
            grenade linkto( stuckto, stuckpart );
        }
        else
        {
            grenade linkto( stuckto );
        }
        
        grenade.stuckdata.stuckto = stuckto;
        grenade thread function_299398447facbe9a( stuckto );
    }
    else
    {
        staticlink = utility::spawn_script_origin( stuckposition, normal );
        grenade linkto( staticlink );
        staticlink thread utility::delete_after_delay( 3 );
    }
    
    grenade thread watchunlink();
    grenade thread function_b03adef181897f38();
    
    if ( grenade isscriptable() && grenade getscriptableparthasstate( "state", "warning" ) )
    {
        grenade setscriptablepartstate( "state", "warning" );
    }
    
    utility::function_969f9f5596dba07a( grenade, &on_crushed );
    glgrenade delete();
}

// Namespace underbarrel_crossbow
// Params 0, eflags: 0x4
// Checksum 0x4c57b29d, Offset: 0x46f
// Size: 0x8
function private on_crushed()
{
    self delete();
}

// Namespace underbarrel_crossbow
// Params 2, eflags: 0x4
// Checksum 0x5c26de1e, Offset: 0x47f
// Size: 0x49
function private function_d164551305416c10( glgrenade, stuckdata )
{
    self endon( #"hash_fc421c521b974080" );
    glgrenade waittill( #"hash_c167e145cfc24a47", scriptablereturned );
    stuckdata.var_4ca36b89aa230d40 = scriptablereturned;
}

// Namespace underbarrel_crossbow
// Params 0, eflags: 0x4
// Checksum 0x64a52ca7, Offset: 0x4d0
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

// Namespace underbarrel_crossbow
// Params 1, eflags: 0x4
// Checksum 0xa5ccbad2, Offset: 0x519
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

// Namespace underbarrel_crossbow
// Params 0, eflags: 0x4
// Checksum 0xb7b1978d, Offset: 0x567
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

