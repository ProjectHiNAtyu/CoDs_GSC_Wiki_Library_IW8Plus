// scripts\mp\common\equipment\semtex.gsc  (hash_0583bd153c599983.gscc) (size: 3882 Bytes / 0xf2a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x16f29f26 (384999206)
// size ...... 3882 (0xf2a)
// includes .. 10  (offset: 0xe36)
// strings ... 11  (offset: 0xe86)
// dev strs .. 1   (offset: 0xf1e)
// exports ... 8   (offset: 0x7de)
// cseg ...... 0xf9 + 0x6e5 (0x7de)
// imports ... 45  (offset: 0x91e)
// animtree1 . 0   (offset: 0xf2a)
// animtree2 . 0   (offset: 0xf2a)
#using scripts\common\active_env\utility;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\weapons;

#namespace semtex;

// Namespace semtex
// Params 0, eflags: 0x5
// Checksum 0x619facd4, Offset: 0x117
// Size: 0x14
function private autoexec function_2e156f7b4a6033d3()
{
    level callback::add( "init_grenade", &init );
}

// Namespace semtex
// Params 1, eflags: 0x4
// Checksum 0xdf31b278, Offset: 0x133
// Size: 0x2e
function private init( params )
{
    weapons::registerusedcallback( "semtex", &semtex_used );
    weapons::function_2cd25260a11d5e40( "semtex", &semtex_pullback );
}

// Namespace semtex
// Params 1
// Checksum 0xa07b3399, Offset: 0x169
// Size: 0x3f5
function semtex_used( grenade )
{
    self endon( #"disconnect" );
    grenade endon( #"death" );
    bundle = weapon::getequipmenttableinfo( "equip_semtex" ).bundle;
    
    if ( bundle.var_e36b84555e7df1d3 && grenade.weapon_object hasattachmenthash( bundle.var_e36b84555e7df1d3 ) )
    {
        foreach ( ent in self.var_e23d1c0d0e07a617 )
        {
            if ( ent getlinkedparent() == self )
            {
                ent unlink();
                ent linkto( grenade, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
                grenade.soundent = ent;
                grenade thread function_84ce07fc48f059();
                break;
            }
        }
        
        grenade setscriptablepartstate( #"state", #"warning_without_sound", 0 );
    }
    
    grenade.bundle = equipment_mp::getEquipmentBundleFromWeaponName( grenade.weapon_name );
    grenade thread weapons::delayshow( 0.05 );
    stuckinfo = grenade weapons::function_f38c6bdea2fb97f3( 1, grenade.bundle.var_21c82f0c7a81799c );
    
    if ( stuckinfo )
    {
        if ( stuckinfo.msg == "missile_stuck" )
        {
            stuckto = stuckinfo.param1;
            callbackparams = { #stuckto:stuckto, #equipmentref:"equip_semtex", #attacker:self };
            callback::callback( #"equipment_stuck", callbackparams );
        }
    }
    
    if ( !( bundle.var_e36b84555e7df1d3 && grenade.weapon_object hasattachmenthash( bundle.var_e36b84555e7df1d3 ) ) )
    {
        grenade setscriptablepartstate( #"state", #"warning", 0 );
    }
    
    if ( isplayer( stuckto ) || isagent( stuckto ) )
    {
        thread gamelogic_mp::threadedsetweaponstatbyname( grenade.weapon_object, 1, "special_hits" );
        
        if ( isplayer( stuckto ) && hasomnvar( o"ui_grenade_stuck_notify" ) )
        {
            stuckto setclientomnvar( o"ui_grenade_stuck_notify", gettime() );
        }
        
        var_7f3fdce4d25dd061 = weapon_utility::function_7f3fdce4d25dd061( grenade );
        
        if ( !( bundle.var_e36b84555e7df1d3 && grenade.weapon_object hasattachmenthash( bundle.var_e36b84555e7df1d3 ) ) )
        {
            stuckto playlocalsound( grenade.bundle.var_a65332982b86adce ?? #"hash_d0bafe992c88665d" );
        }
        
        weapons::grenadestuckto( grenade, stuckto, 0, var_7f3fdce4d25dd061 );
        
        if ( isagent( stuckto ) )
        {
            if ( level.battlechatter )
            {
                addbattlechatternotify( stuckto, undefined, "semtex_stuck" );
            }
            else
            {
                stuckto setbattlechatterflag( "semtex_stuck", 1, 3 );
            }
        }
        
        if ( isagent( stuckto ) && !stuckto.var_2f7b28254901f8d6 )
        {
            if ( !stuckto.var_f424a6135c1dd01f )
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
    
    level thread utility::function_f6d2b1924fca249( grenade );
}

// Namespace semtex
// Params 0, eflags: 0xc
// Checksum 0xa2eb7f3b, Offset: 0x566
// Size: 0x53
function private function_84ce07fc48f059()
{
    self notify( #"hash_9d2e84809285637f" );
    self endon( #"hash_9d2e84809285637f" );
    level endon( #"game_ended" );
    utility::waittill_any( "death", "explode" );
    
    if ( self.soundent )
    {
        self.soundent thread function_7d673aebc25b92b3();
    }
}

// Namespace semtex
// Params 1
// Checksum 0x1417fcad, Offset: 0x5c1
// Size: 0x156
function semtex_pullback( params )
{
    bundle = weapon::getequipmenttableinfo( "equip_semtex" ).bundle;
    
    if ( bundle.var_e36b84555e7df1d3 && equipment_mp::function_e6b75548c2c3c6cf( "equip_semtex", bundle.var_e36b84555e7df1d3 ) )
    {
        if ( !isdefined( self.var_e23d1c0d0e07a617 ) )
        {
            self.var_e23d1c0d0e07a617 = [];
        }
        
        semtexsoundent = spawn( "script_model", self.origin );
        semtexsoundent.owner = self;
        semtexsoundent linkto( self, "tag_weapon_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        self.var_e23d1c0d0e07a617[ semtexsoundent.entnum ?? utility::get_entity_number( semtexsoundent ) ] = semtexsoundent;
        thread function_85734e18b130499( semtexsoundent );
        wait 1.5;
        
        if ( self && player::isreallyalive( self ) )
        {
            if ( semtexsoundent )
            {
                soundalias = bundle.var_a65332982b86adce ?? #"hash_d0bafe992c88665d";
                semtexsoundent playsoundonmovingent( soundalias );
                semtexsoundent thread function_7d673aebc25b92b3( ( lookupsoundlength( soundalias ) ?? 1000 ) * 0.001 );
            }
            
            return;
        }
        
        if ( semtexsoundent )
        {
            semtexsoundent thread function_7d673aebc25b92b3();
        }
    }
}

// Namespace semtex
// Params 1, eflags: 0x4
// Checksum 0x3cea4e70, Offset: 0x71f
// Size: 0x43
function private function_85734e18b130499( soundent )
{
    level endon( #"game_ended" );
    self endon( #"grenade_fire", #"offhand_fired" );
    self waittill( #"offhand_end" );
    soundent thread function_7d673aebc25b92b3();
}

// Namespace semtex
// Params 1, eflags: 0xc
// Checksum 0x9679d04, Offset: 0x76a
// Size: 0x74
function private function_7d673aebc25b92b3( time )
{
    self notify( #"hash_23573921a36ecb47" );
    self endon( #"hash_23573921a36ecb47" );
    
    if ( time )
    {
        wait time;
    }
    
    if ( self )
    {
        self stopsounds();
        waitframe();
        
        if ( self )
        {
            if ( self.owner )
            {
                self.owner.var_e23d1c0d0e07a617[ self.entnum ?? utility::get_entity_number( self ) ] = undefined;
            }
            
            self delete();
        }
    }
}

