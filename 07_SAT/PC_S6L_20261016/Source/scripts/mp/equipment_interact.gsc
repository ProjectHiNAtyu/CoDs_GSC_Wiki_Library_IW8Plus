// scripts\mp\equipment_interact.gsc  (hash_58d07af23a255edd.gscc) (size: 9152 Bytes / 0x23c0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe70213e (242229566)
// size ...... 9152 (0x23c0)
// includes .. 11  (offset: 0x21b0)
// strings ... 25  (offset: 0x2208)
// dev strs .. 7   (offset: 0x236c)
// exports ... 28  (offset: 0x13a4)
// cseg ...... 0x1e2 + 0x11c2 (0x13a4)
// imports ... 82  (offset: 0x1804)
// animtree1 . 0   (offset: 0x23c0)
// animtree2 . 0   (offset: 0x23c0)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\equipment;

#namespace equipment_interact;

// Namespace equipment_interact
// Params 0
// Checksum 0xd2eadef4, Offset: 0x200
// Size: 0x96
function equipmentinteract_init()
{
    level.destroyableequipment = [];
    level.useobjs = [];
    utility::registersharedfunc( #"equipment", #"deployhacktablet", &deployhacktablet );
    utility::registersharedfunc( #"equipment", #"updateuseobj", &updateuseobj );
    scriptable::scriptable_addusedcallbackbypart( "hack_usable", &equipmentscriptableused );
    level callback::add( #"perk_set_gearhead", &function_9dd37d22184cd039 );
    level callback::add( #"player_connect", &on_player_connect );
    thread function_2e6f6c899a7de48c();
}

// Namespace equipment_interact
// Params 6
// Checksum 0x6a5d2f40, Offset: 0x29e
// Size: 0x5d
function equipmentscriptableused( instance, part, state, player, bautouse, usestring )
{
    assert( part == "<dev string:x24>" );
    equipmentuse( instance.entity, player );
}

// Namespace equipment_interact
// Params 2
// Checksum 0xefe29649, Offset: 0x303
// Size: 0xac
function equipmentuse( instance, player )
{
    equipment = instance;
    equipment.isbeingused = 1;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.hackingdevice ) )
    {
        assert( "<dev string:x30>" );
        return;
    }
    
    player.iscapturingcrate = 0;
    player.ishacking = 1;
    streakinfo = player killstreak_utility::createstreakinfo( "", player );
    streakinfo.interactstate = 0;
    player thread deployhacktablet( function_ca921a139af9fcc( equipment ), equipment, streakinfo );
}

// Namespace equipment_interact
// Params 0
// Checksum 0xbbe3b423, Offset: 0x3b7
// Size: 0x13a
function updateuseobj()
{
    object = self;
    var_e17ed604686cfef6 = object.isbeingused || level.gameended;
    
    foreach ( player in level.players )
    {
        if ( player.hackdistance && distancesquared( object.origin, player.origin ) < squared( player.hackdistance ) )
        {
            if ( var_e17ed604686cfef6 || !player_utility::playersareenemies( player, object.owner ) || !isdefined( player.perks[ "specialty_hack" ] ) || player emp_debuff::is_empd() || player namespace_9d8e359c3b1041e5::isjuggernautsharedfunc() )
            {
                object disablescriptableplayeruse( player );
                continue;
            }
            
            object enablescriptableplayeruse( player );
        }
    }
}

// Namespace equipment_interact
// Params 0, eflags: 0x4
// Checksum 0xe1ad2bf3, Offset: 0x4f9
// Size: 0x13d
function private function_2e6f6c899a7de48c()
{
    level endon( #"game_ended" );
    var_800ec7f2af0f5cb = 1000;
    frameduration = level.frameduration;
    var_508d69692d3b2918 = floor( var_800ec7f2af0f5cb / frameduration );
    
    while ( true )
    {
        objects = level.useobjs;
        var_4bedf0a8167e4989 = ceil( objects.size / var_508d69692d3b2918 );
        objectsupdated = 0;
        framesprocessed = 0;
        
        foreach ( object in objects )
        {
            if ( isdefined( object ) )
            {
                assert( object isscriptable(), "<dev string:xb4>" );
                object updateuseobj();
                objectsupdated++;
                
                if ( objectsupdated >= var_4bedf0a8167e4989 )
                {
                    objectsupdated = 0;
                    framesprocessed++;
                    waitframe();
                }
            }
        }
        
        waittime = max( 0, var_800ec7f2af0f5cb - framesprocessed * frameduration ) / 1000;
        wait waittime;
    }
}

// Namespace equipment_interact
// Params 3
// Checksum 0x1e4d46f7, Offset: 0x63e
// Size: 0x2c
function remoteinteractsetup( var_bc3be370eac48043, allowdefuse, allowhack )
{
    if ( allowhack )
    {
        thread _hacksetup( var_bc3be370eac48043 );
    }
}

// Namespace equipment_interact
// Params 1
// Checksum 0xee1dc12b, Offset: 0x672
// Size: 0xd9
function _hacksetup( remotedefusecallback )
{
    if ( level.perkbundles[ "specialty_gearhead" ].var_75c23be56964e043 )
    {
        return;
    }
    
    level.useobjs[ self getentitynumber() ] = self;
    assert( self isscriptable(), "<dev string:xfa>" );
    self setscriptablepartstate( "hack_usable", "on" );
    
    foreach ( player in level.players )
    {
        self disablescriptablepartplayeruse( "hack_usable", player );
    }
}

// Namespace equipment_interact
// Params 1
// Checksum 0x1ab40286, Offset: 0x753
// Size: 0xcb, Type: bool
function _processusethink( equipment )
{
    level endon( #"game_ended" );
    
    if ( isdefined( equipment ) )
    {
        equipment endon( #"death" );
        equipment endon( #"mine_triggered" );
    }
    
    self endon( #"death_or_disconnect" );
    self endon( #"emp_started" );
    self endon( #"chaff_started" );
    interactduration = ( getdvarfloat( @"perk_hack_equipment_time", 3 ) - getdvarfloat( @"perk_hack_equipment_success_time", 0.5 ) ) * 1000;
    var_7de431099925489a = gettime() + ( equipment.hack_time_override ?? interactduration );
    
    while ( var_7de431099925489a > gettime() )
    {
        if ( !self usebuttonpressed() )
        {
            return false;
        }
        
        waitframe();
    }
    
    return true;
}

// Namespace equipment_interact
// Params 2
// Checksum 0x51a12b76, Offset: 0x827
// Size: 0xde
function _startusethink( equipment, streakinfo )
{
    if ( isdefined( equipment ) )
    {
        equipment.isbeingused = 1;
    }
    
    self.iscapturingcrate = 1;
    self.ishacking = 1;
    streakinfo.interactstate = 0;
    self notify( #"interact_started" );
    result = istrue( _processusethink( equipment ) );
    
    if ( result )
    {
        streakinfo.interactstate = 2;
    }
    else
    {
        self notify( #"interact_cancelled" );
    }
    
    self notify( #"interact_finished" );
    
    if ( isdefined( equipment ) )
    {
        equipment.isbeingused = 0;
    }
    
    if ( isdefined( self ) )
    {
        self.iscapturingcrate = 0;
        self.ishacking = undefined;
        
        if ( !result )
        {
            return;
        }
        
        if ( isdefined( equipment ) )
        {
            equipment equipment_mp::hackequipment( self );
        }
    }
}

// Namespace equipment_interact
// Params 1
// Checksum 0x13e87e4e, Offset: 0x90d
// Size: 0x9a
function function_ca921a139af9fcc( equipment )
{
    index = -1;
    
    if ( isdefined( equipment.equipmentref ) )
    {
        equipmentinfo = equipment_mp::getequipmenttableinfo( equipment.equipmentref );
        
        if ( isdefined( equipmentinfo ) )
        {
            index = equipmentinfo.id;
        }
    }
    else if ( isdefined( equipment.streakinfo ) )
    {
        index = killstreak_utility::getkillstreakindex( equipment.streakinfo.streakname );
    }
    
    assert( index != -1, "<dev string:x13d>" );
    return index;
}

// Namespace equipment_interact
// Params 3
// Checksum 0x268691de, Offset: 0x9b0
// Size: 0xc1
function deployhacktablet( index, equipment, streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    weaponobj = makeweapon( self.hackingdevice );
    childthread function_e0170999677c381c( equipment );
    thread function_b3051fbfb2e26ba( index );
    self playlocalsound( "iw9_ks_tablet_foly_raise_plr" );
    switchresult = killstreakdeploy::switchtodeployweapon( weaponobj, streakinfo, &_waituntilinteractfinished, &_ontabletgiven, undefined, undefined, &_ontabletputaway );
    
    if ( switchresult )
    {
        thread _startusethink( equipment, streakinfo );
        return;
    }
    
    self notify( #"interact_cancelled" );
    
    if ( isdefined( equipment ) )
    {
        equipment.isbeingused = 0;
    }
}

// Namespace equipment_interact
// Params 0
// Checksum 0xe0d69fe, Offset: 0xa79
// Size: 0x33
function function_d5794740325fbfd4()
{
    level.useobjs[ self getentitynumber() ] = undefined;
    assert( self isscriptable(), "<dev string:x157>" );
    self setscriptablepartstate( "hack_usable", "off" );
}

// Namespace equipment_interact
// Params 0
// Checksum 0x47701c88, Offset: 0xab4
// Size: 0x23
function function_2e1b95de8d0440b9()
{
    level.destroyableequipment[ self getentitynumber() ] = undefined;
    self makeunusable();
    self notify( #"hash_5684470fa67bd062" );
}

// Namespace equipment_interact
// Params 5
// Checksum 0xeff81bcd, Offset: 0xadf
// Size: 0x297
function function_226793772d245e96( var_aacb78da5016573c, destroyrange, hintstring, equipmentteam, var_a3b9646adc323c10 )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    
    if ( !var_a3b9646adc323c10 )
    {
        var_167fdb444304f531 = 0;
        
        foreach ( teamname in level.teamnamelist )
        {
            if ( equipmentteam == teamname )
            {
                var_167fdb444304f531 = 1;
                break;
            }
        }
        
        assert( var_167fdb444304f531, "<dev string:x19d>" + equipmentteam );
    }
    
    level.destroyableequipment[ self getentitynumber() ] = self;
    duration = int( utility::function_4b74c15943231980( var_aacb78da5016573c ) );
    self makeusable();
    self setusepriority( -1 );
    self enablemissilehint( 1 );
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( hintstring );
    self setuserange( destroyrange );
    self sethintdisplayrange( destroyrange );
    self sethintdisplayfov( 360 );
    self setusefov( 360 );
    self setuseholdduration( duration );
    self sethinttag( "tag_use" );
    
    if ( !self.isdestroyed )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !player_utility::isfriendly( equipmentteam, player ) && !isdefined( player.perks[ "specialty_hack" ] ) )
            {
                self enableplayeruse( player );
                continue;
            }
            
            self disableplayeruse( player );
        }
    }
    
    childthread function_7f060835e49221a9( equipmentteam );
    
    while ( true )
    {
        self waittill( #"trigger", attacker );
        
        if ( !player_utility::isfriendly( equipmentteam, attacker ) )
        {
            break;
        }
    }
    
    function_2e1b95de8d0440b9();
    self dodamage( 10000, self.origin, attacker, undefined, "MOD_UNKNOWN" );
}

// Namespace equipment_interact
// Params 1, eflags: 0xc
// Checksum 0xaf794ea1, Offset: 0xd7e
// Size: 0xd0
function private function_7f060835e49221a9( equipmentteam )
{
    self notify( #"hash_58b1382b28afe159" );
    self endon( #"hash_58b1382b28afe159" );
    self endon( #"hash_5684470fa67bd062" );
    
    while ( true )
    {
        level waittill( #"player_joined_team", player );
        
        if ( self )
        {
            if ( !player.team || player.team == "spectator" || player.team == "codcaster" )
            {
                self disableplayeruse( player );
                continue;
            }
            
            if ( !player_utility::isfriendly( equipmentteam, player ) && !isdefined( player.perks[ "specialty_hack" ] ) )
            {
                self enableplayeruse( player );
                continue;
            }
            
            self disableplayeruse( player );
        }
    }
}

// Namespace equipment_interact
// Params 1
// Checksum 0x19864335, Offset: 0xe56
// Size: 0xa1
function function_9dd37d22184cd039( params )
{
    level thread function_396fa12954806da9();
    
    if ( params.disablehacking )
    {
        return;
    }
    
    foreach ( equipment in level.destroyableequipment )
    {
        if ( isdefined( equipment ) )
        {
            equipment disableplayeruse( self );
        }
    }
}

// Namespace equipment_interact
// Params 0
// Checksum 0x98275bd5, Offset: 0xeff
// Size: 0x36
function function_396fa12954806da9()
{
    self notify( #"hash_48be8b88db594dfa" );
    self endon( #"hash_48be8b88db594dfa" );
    wait 0.5;
    level.destroyableequipment = function_5713d46873b29625( level.destroyableequipment );
}

// Namespace equipment_interact
// Params 1
// Checksum 0x50981cb8, Offset: 0xf3d
// Size: 0x4a
function function_e0170999677c381c( equipment )
{
    self endon( #"interact_cancelled" );
    self endon( #"interact_finished" );
    
    if ( !equipment )
    {
        return;
    }
    
    equipment utility::waittill_any( "death", "makeExplosiveUnusable" );
    self notify( #"cancel_all_killstreak_deployments" );
}

// Namespace equipment_interact
// Params 1
// Checksum 0x2a64d12b, Offset: 0xf8f
// Size: 0x6c
function function_b3051fbfb2e26ba( hackindex )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self setclientomnvar( "ui_hack_index", hackindex );
    self playlocalsound( "iw9_spotter_perk_tablet_ui" );
    _updatehackprogressomnvar();
    self stoplocalsound( "iw9_spotter_perk_tablet_ui" );
    self setclientomnvar( "ui_hack_progress", 0 );
    wait 0.1;
    self setclientomnvar( "ui_hack_index", 0 );
}

// Namespace equipment_interact
// Params 0
// Checksum 0xdad70380, Offset: 0x1003
// Size: 0xf8
function _updatehackprogressomnvar()
{
    self endon( #"interact_cancelled" );
    self waittill( #"interact_started" );
    var_2127bdd64fad8f2b = 1000;
    var_d5331451e2d51b11 = 500;
    var_ff9cb466d1d7bcb9 = getdvarfloat( @"perk_hack_equipment_time", 3 ) * 1000;
    successduration = getdvarfloat( @"perk_hack_equipment_success_time", 0.5 ) * 1000;
    barduration = var_ff9cb466d1d7bcb9 - var_2127bdd64fad8f2b - successduration;
    var_7de431099925489a = gettime() + var_ff9cb466d1d7bcb9 + var_d5331451e2d51b11;
    var_16eda8c42a8ba276 = gettime() + var_2127bdd64fad8f2b;
    
    while ( true )
    {
        barprogress = ( gettime() - var_16eda8c42a8ba276 ) / barduration;
        barprogress = clamp( barprogress, 0, 1 );
        self setclientomnvar( "ui_hack_progress", barprogress );
        wait 0.05;
        
        if ( gettime() > var_7de431099925489a )
        {
            break;
        }
    }
}

// Namespace equipment_interact
// Params 2
// Checksum 0x2591fa79, Offset: 0x1103
// Size: 0x27, Type: bool
function _ontabletgiven( streakinfo, switchresult )
{
    _toggletabletallows( 1 );
    thread _cleanuptabletallows();
    return true;
}

// Namespace equipment_interact
// Params 1
// Checksum 0xb559245b, Offset: 0x1133
// Size: 0x52
function _cancelputawayonuseend( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    streakinfo endon( #"hash_98ad369312642743" );
    
    while ( true )
    {
        if ( !self usebuttonpressed() )
        {
            break;
        }
        
        waitframe();
    }
    
    self notify( #"cancel_all_killstreak_deployments" );
}

// Namespace equipment_interact
// Params 1
// Checksum 0x49dc2fc6, Offset: 0x118d
// Size: 0x18
function _ontabletputaway( streakinfo )
{
    self notify( #"tabletPutAway" );
}

// Namespace equipment_interact
// Params 1
// Checksum 0x8a11e81a, Offset: 0x11ad
// Size: 0x80
function _waituntilinteractfinished( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"interact_cancelled" );
    
    if ( streakinfo.interactstate != 0 )
    {
        return;
    }
    
    self waittill( #"interact_finished" );
    
    if ( streakinfo.interactstate == 2 )
    {
        successtime = getdvarfloat( @"perk_hack_equipment_success_time", 0.5 );
        wait successtime;
    }
}

// Namespace equipment_interact
// Params 0
// Checksum 0x3c9bec8a, Offset: 0x1235
// Size: 0x38
function _cleanuptabletallows()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    utility::waittill_any( "death", "tabletPutAway", "interact_cancelled" );
    _toggletabletallows( 0 );
}

// Namespace equipment_interact
// Params 1
// Checksum 0x3e6d4e18, Offset: 0x1275
// Size: 0xa3
function _toggletabletallows( var_69288d68276170de )
{
    force = var_69288d68276170de ? undefined : 1;
    player::_freezelookcontrols( var_69288d68276170de, force );
    
    if ( isalive( self ) )
    {
        if ( var_69288d68276170de )
        {
            val::set( "tablet", "allow_movement", 0 );
            val::set( "tablet", "allow_jump", 0 );
            val::set( "tablet", "usability", 0 );
            val::set( "tablet", "melee", 0 );
            val::set( "tablet", "offhand_weapons", 0 );
            return;
        }
        
        val::reset_all( "tablet" );
    }
}

// Namespace equipment_interact
// Params 1, eflags: 0x4
// Checksum 0x44f6a456, Offset: 0x1320
// Size: 0x84
function private on_player_connect( params )
{
    foreach ( useobj in level.useobjs )
    {
        useobj disablescriptableplayeruse( self );
    }
}

