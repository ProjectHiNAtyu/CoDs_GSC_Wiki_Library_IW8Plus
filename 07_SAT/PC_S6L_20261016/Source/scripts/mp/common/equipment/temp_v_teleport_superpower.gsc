// scripts\mp\common\equipment\temp_v_teleport_superpower.gsc  (hash_5f81618c85a35cd3.gscc) (size: 4246 Bytes / 0x1096 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfd6b65fb (4251674107)
// size ...... 4246 (0x1096)
// includes .. 10  (offset: 0xf12)
// strings ... 24  (offset: 0xf62)
// dev strs .. 0   (offset: 0x1096)
// exports ... 11  (offset: 0x7b6)
// cseg ...... 0x22f + 0x587 (0x7b6)
// imports ... 50  (offset: 0x96e)
// animtree1 . 0   (offset: 0x1096)
// animtree2 . 0   (offset: 0x1096)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\equipment\temp_v;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\hud_message;
#using scripts\mp\supers;

#namespace temp_v_teleport_superpower;

// Namespace temp_v_teleport_superpower
// Params 0, eflags: 0x1
// Checksum 0x3f8f186, Offset: 0x24d
// Size: 0x9
function autoexec main()
{
    init();
}

// Namespace temp_v_teleport_superpower
// Params 0
// Checksum 0xc49cd1c7, Offset: 0x25e
// Size: 0x29
function init()
{
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_teleport_deploy", undefined, undefined, &superteleport_ongive, &function_cd0162316a36224b, undefined, undefined, undefined );
}

// Namespace temp_v_teleport_superpower
// Params 0
// Checksum 0xf4a3e257, Offset: 0x28f
// Size: 0x142, Type: bool
function superteleport_ongive()
{
    if ( !isalive( self ) || self isparachuting() || self isskydiving() || self isonladder() || self isonascender() || self isinexecutionattack() || self isinexecutionvictim() )
    {
        return false;
    }
    
    if ( self.inlaststand || isdefined( self.usingremote ) || self.isdeploying || self.usingascender || player_utility::function_cdedd9a19069ca4c( self ) || self.isjuggernaut || self.carryinghostage )
    {
        return false;
    }
    
    if ( isdefined( self.vehicle ) )
    {
        return false;
    }
    
    thread hud_message::showsplash( "super_teleport_deploy" + "_activate", undefined, self, undefined, undefined, undefined, 1 );
    self setclientomnvar( "ui_field_upgrade_use", 0 );
    perk::giveperk( "specialty_third_person" );
    function_70d533e6a80e82a3( 1 );
    self.plotarmor = 1;
    thread function_dbb006883bd085f4();
    utility::delaythread( getdvarfloat( @"hash_96dbd55b49ef1c2b", 0.1 ), &function_85c31b33cb97267d, 1 );
    utility::delaythread( getdvarfloat( @"scr_teleport_superpower_hide_time", 0.2 ), &superteleport_hide, 1 );
    thread function_1f143a75d66792a3();
    return true;
}

// Namespace temp_v_teleport_superpower
// Params 2
// Checksum 0xe0aae9a, Offset: 0x3da
// Size: 0x17, Type: bool
function function_cd0162316a36224b( fromdeath, attacker )
{
    return true;
}

// Namespace temp_v_teleport_superpower
// Params 1
// Checksum 0x135c0b99, Offset: 0x3fa
// Size: 0x3a
function superteleport_hide( shouldhide )
{
    if ( shouldhide )
    {
        player_utility::function_dbe5a52a6654a982();
        player_utility::function_9d378d725bb4831e( "temp_v_teleport_superpower::superTeleport_hide()" );
        return;
    }
    
    player_utility::function_b54a1e23734ef07();
    player_utility::function_4688d689820ff1ed( "temp_v_teleport_superpower::superTeleport_hide()" );
}

// Namespace temp_v_teleport_superpower
// Params 1
// Checksum 0xefad3719, Offset: 0x43c
// Size: 0xa7
function function_70d533e6a80e82a3( isteleporting )
{
    if ( isteleporting )
    {
        blockedvalues = [ "ads", "weapon_switch", "weapon_pickup", "weapon_switch_clip", "reload", "allow_jump", "usability", "vehicle_use", "execution_attack", "execution_victim" ];
        player::_freezecontrols( 1 );
        val::set_array( "teleport_superpower", blockedvalues, 0 );
        return;
    }
    
    player::_freezecontrols( 0 );
    val::reset_all( "teleport_superpower" );
}

// Namespace temp_v_teleport_superpower
// Params 0
// Checksum 0xd2eebd11, Offset: 0x4eb
// Size: 0x9b
function function_1f143a75d66792a3()
{
    var_904684246d746a16 = getdvarfloat( @"scr_teleport_superpower_transition_time", 1 );
    wait var_904684246d746a16;
    game_utility::fadetoblackforplayer( self, 1, 0.25 );
    perk::removeperk( "specialty_third_person" );
    self setorigin( function_e9d0930e62e09fb7() );
    self skydive_beginfreefall();
    utility::delaythread( 0.15, &superteleport_hide, 0 );
    utility::delaythread( 0.2, &function_85c31b33cb97267d, 0 );
    self.plotarmor = undefined;
    function_70d533e6a80e82a3( 0 );
    game_utility::fadetoblackforplayer( self, 0, 0.25 );
    temp_v::function_6fde086c9d1330d9();
}

// Namespace temp_v_teleport_superpower
// Params 0
// Checksum 0x2ae42737, Offset: 0x58e
// Size: 0x175
function function_e9d0930e62e09fb7()
{
    initialstart = self.origin + ( 0, 0, getdvarint( @"hash_6607bd90c44f0838", 5000 ) );
    caststart = initialstart;
    cachedposition = self.origin;
    safeheight = 1000;
    mapcenter = level.mapcenter;
    num_casts = 0;
    
    while ( true )
    {
        if ( num_casts > 20 )
        {
            position = cachedposition;
            break;
        }
        
        castend = caststart + ( 0, 0, -2000 );
        trace = trace::ray_trace( caststart, castend, self, trace::create_default_contents( 1 ) );
        positionsafe = 0;
        position = caststart;
        dist = distance( caststart, trace[ "position" ] );
        
        if ( dist >= 1000 )
        {
            positionsafe = 1;
        }
        
        if ( canspawn( position ) )
        {
            if ( positionsafe )
            {
                break;
            }
            else
            {
                cachedposition = position;
            }
        }
        
        dir = utility::flatten_vector( vectornormalize( mapcenter - caststart ) );
        caststart += dir * randomintrange( 250, 1000 );
        
        if ( !positionsafe )
        {
            caststart = ( caststart.x, caststart.y, initialstart.z );
            caststart += ( 0, 0, safeheight - dist );
        }
        
        waitframe();
    }
    
    return position;
}

// Namespace temp_v_teleport_superpower
// Params 1
// Checksum 0x23face34, Offset: 0x70c
// Size: 0x3e
function function_85c31b33cb97267d( isout )
{
    if ( isout )
    {
        playfx( utility::getfx( "superPower_teleportOut" ), self.origin );
        return;
    }
    
    self setscriptablepartstate( "superpowers", "teleportIn", 0 );
}

// Namespace temp_v_teleport_superpower
// Params 0
// Checksum 0xb58fc71f, Offset: 0x752
// Size: 0x64
function function_dbb006883bd085f4()
{
    self setscriptablepartstate( "superpowers", "teleportOut", 0 );
    soundorigin = self.origin + ( 0, 0, 15 );
    soundent = spawn( "script_origin", soundorigin );
    soundent playsound( "br_the_boys_teleport_out_npc", self, soundent );
    wait 2;
    soundent delete();
}

