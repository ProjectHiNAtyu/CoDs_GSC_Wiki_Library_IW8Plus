// scripts\mp\parachute.gsc  (hash_23a612ec3b88c093.gscc) (size: 19737 Bytes / 0x4d19 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x62bddbc2 (1656609730)
// size ...... 19737 (0x4d19)
// includes .. 10  (offset: 0x4a5d)
// strings ... 34  (offset: 0x4aad)
// dev strs .. 10  (offset: 0x4ca1)
// exports ... 52  (offset: 0x2f4d)
// cseg ...... 0x2ac + 0x2ca1 (0x2f4d)
// imports ... 147 (offset: 0x376d)
// animtree1 . 0   (offset: 0x4d19)
// animtree2 . 0   (offset: 0x4d19)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\omnvar_utility;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\flags;

#namespace parachute;

// Namespace parachute
// Params 0, eflags: 0x5
// Checksum 0x1ef52acb, Offset: 0x2ca
// Size: 0x2c
function private autoexec init()
{
    callback::add( #"player_connect", &onplayerconnect );
    callback::add( #"player_spawned", &onplayerspawned );
}

// Namespace parachute
// Params 1, eflags: 0x4
// Checksum 0xe4921c79, Offset: 0x2fe
// Size: 0x91
function private onplayerconnect( params )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isparachutegametype() )
    {
        return;
    }
    
    disableParachuteByDefault = isusingmatchrulesdata() && getmatchrulesdata( "commonOption", "disableParachuteByDefault" );
    
    if ( !disableParachuteByDefault )
    {
        return;
    }
    
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    
    if ( level.var_60df68ace0baea06 && !isdefined( self.parachuteid ) )
    {
        val::set( "parachute", "base_jumping", 0 );
    }
}

// Namespace parachute
// Params 1, eflags: 0x4
// Checksum 0x63c55e8f, Offset: 0x397
// Size: 0x93
function private onplayerspawned( params )
{
    if ( !params.revivespawn || !params.player )
    {
        return;
    }
    
    level endon( #"game_ended" );
    params.player endon( #"disconnect" );
    waitframe();
    
    if ( level.var_60df68ace0baea06 && !isdefined( params.player.parachuteid ) )
    {
        params.player val::set( "parachute", "base_jumping", 0 );
    }
}

/#

    // Namespace parachute
    // Params 0
    // Checksum 0xb601e946, Offset: 0x432
    // Size: 0x107, Type: dev
    function function_df3c18e7faa052bd()
    {
        projectbundle = level.projectbundle;
        
        if ( !isdefined( projectbundle.parachutelist ) )
        {
            return;
        }
        
        if ( projectbundle.parachutelist == %"" )
        {
            return;
        }
        
        var_e1de41502f6840b1 = getscriptbundle( projectbundle.parachutelist );
        
        if ( !isdefined( var_e1de41502f6840b1 ) )
        {
            return;
        }
        
        parachutelist = var_e1de41502f6840b1.parachute_list;
        devgui::add_devgui_command( "<dev string:x24>", "<dev string:x48>", 1 );
        
        for ( i = 0; i < parachutelist.size ; i++ )
        {
            parachute = parachutelist[ i ];
            
            if ( isdefined( parachute.parachutedata ) )
            {
                sourcename = getxhashsourcename( parachute.parachutedata );
                index = i + 1 + 1;
                devgui::add_devgui_command( "<dev string:x63>" + sourcename, "<dev string:x80>" + sourcename, index );
            }
        }
    }

    // Namespace parachute
    // Params 0
    // Checksum 0x9e9192be, Offset: 0x541
    // Size: 0xf4, Type: dev
    function function_6415318ce8a62753()
    {
        projectbundle = level.projectbundle;
        
        if ( !isdefined( projectbundle.contraillist ) )
        {
            return;
        }
        
        if ( projectbundle.contraillist == %"" )
        {
            return;
        }
        
        var_e503f1e42b6098a = getscriptbundle( projectbundle.contraillist );
        
        if ( !isdefined( var_e503f1e42b6098a ) )
        {
            return;
        }
        
        contraillist = var_e503f1e42b6098a.contrail_list;
        
        for ( i = 0; i < contraillist.size ; i++ )
        {
            contrail = contraillist[ i ];
            
            if ( isdefined( contrail.contraildata ) )
            {
                sourcename = getxhashsourcename( contrail.contraildata );
                index = i + 1 + 1;
                devgui::add_devgui_command( "<dev string:x97>" + sourcename, "<dev string:xb3>" + sourcename, index );
            }
        }
    }

#/

// Namespace parachute
// Params 0
// Checksum 0xb9186f72, Offset: 0x63d
// Size: 0x3bf
function initparachutedvars()
{
    setdvarifuninitialized( @"scr_parachute_redeploy_min_height", 256 );
    setdvarifuninitialized( @"scr_parachute_redeploy_input_type", 0 );
    setdvarifuninitialized( @"scr_parachute_auto_kick_map_center", ( 0, 0, 0 ) );
    setdvarifuninitialized( @"scr_parachute_camera_transition_mode", 2 );
    setdvarifuninitialized( @"scr_parachute_ffsm_enabled", 1 );
    setdvarifuninitialized( @"scr_parachute_hint_enabled", 1 );
    setdvarifuninitialized( @"scr_parachute_hint_zdrop", 0.5 );
    setdvarifuninitialized( @"scr_parachute_hint_zoffset", 0 );
    setdvarifuninitialized( @"scr_parachute_hint_zvelscale", 0 );
    setdvarifuninitialized( @"scr_parachute_hint_zlimit", 5000 );
    setdvarifuninitialized( @"scr_parachute_hint_xyvelscale_high", 10 );
    setdvarifuninitialized( @"scr_parachute_hint_xyvelscale_low", 2 );
    setdvarifuninitialized( @"scr_parachute_hint_xyvelscale_maxheight", 10000 );
    setdvarifuninitialized( @"scr_parachute_hint_xylimit", 7500 );
    setdvarifuninitialized( @"scr_parachute_hint_falling_xyratio", -2 );
    level.parachutecancutautodeploy = getdvarint( @"hash_ff604c5295c4e36c", 1 );
    level.parachutecancutparachute = getdvarint( @"scr_parachute_cut", 1 );
    level.var_189e173f52be62cf = getdvarint( @"hash_b99e3b3c6154ced8", 1 );
    level.parachuteinitfinished = 1;
    level.activeparachuters = [];
    
    if ( !isdefined( level.dontshootwhileparachuting ) )
    {
        level.dontshootwhileparachuting = 1;
    }
    
    if ( !isdefined( level.freefallstartcb ) )
    {
        level.freefallstartcb = &freefallstartdefault;
    }
    
    if ( !isdefined( level.parachuteopencb ) )
    {
        level.parachuteopencb = &parachuteopendefault;
    }
    
    if ( !isdefined( level.parachutecompletecb ) )
    {
        level.parachutecompletecb = &parachutecompletedefault;
    }
    
    if ( !isdefined( level.parachutetakeweaponscb ) )
    {
        level.parachutetakeweaponscb = &leaveweaponsdefaultfunc;
    }
    
    if ( !isdefined( level.parachuterestoreweaponscb ) )
    {
        level.parachuterestoreweaponscb = &norestoreweaponsdefaultfunc;
    }
    
    if ( !isdefined( level.parachuteprelaststandfunc ) )
    {
        level.parachuteprelaststandfunc = &parachuteprelaststandfunction;
    }
    
    level.skydivestreamhintdvars = spawnstruct();
    level.skydivestreamhintdvars.streamhintenabled = getdvarint( @"scr_parachute_hint_enabled", 1 );
    level.skydivestreamhintdvars.xyvelscale_high = getdvarfloat( @"scr_parachute_hint_xyvelscale_high", 0 );
    level.skydivestreamhintdvars.xyvelscale_low = getdvarfloat( @"scr_parachute_hint_xyvelscale_low", 0 );
    level.skydivestreamhintdvars.xyvelscale_maxheight = getdvarfloat( @"scr_parachute_hint_xyvelscale_maxheight", 0 );
    level.skydivestreamhintdvars.xylimit = getdvarfloat( @"scr_parachute_hint_xylimit", 0 );
    level.skydivestreamhintdvars.zdrop = getdvarfloat( @"scr_parachute_hint_zdrop", 0 );
    level.skydivestreamhintdvars.zoffset = getdvarfloat( @"scr_parachute_hint_zoffset", 0 );
    level.skydivestreamhintdvars.zvelscale = getdvarfloat( @"scr_parachute_hint_zvelscale", 0 );
    level.skydivestreamhintdvars.zlimit = getdvarfloat( @"scr_parachute_hint_zlimit", 0 );
    level.skydivestreamhintdvars.falling_xyratio = getdvarfloat( @"scr_parachute_hint_falling_xyratio", 0 );
    
    /#
        function_df3c18e7faa052bd();
        function_6415318ce8a62753();
    #/
}

// Namespace parachute
// Params 6
// Checksum 0x32e723ac, Offset: 0xa04
// Size: 0x25e
function startfreefall( falltime, popinstant, var_eb5df45877fde599, startingvelocity, isgulagrespawn, takeweapons )
{
    self.freefallstarttime = gettime();
    self.haslanded = 0;
    
    if ( getdvarint( @"scr_parachute_ffsm_enabled", 0 ) )
    {
        thread freefallfromplanestatemachine( falltime, popinstant, var_eb5df45877fde599, startingvelocity, isgulagrespawn, takeweapons );
        return;
    }
    
    self endon( #"death_or_disconnect" );
    thread parachutemidairdeathwatcher();
    self skydive_interrupt();
    
    /#
        if ( getdvarint( @"scr_parachute_debug", 0 ) == 1 )
        {
            thread function_e78c8e5f124be2fc();
        }
    #/
    
    if ( !isdefined( takeweapons ) )
    {
        takeweapons = 1;
    }
    
    if ( !level.parachuteinitfinished )
    {
        initparachutedvars();
    }
    
    if ( !isdefined( level.dontshootwhileparachuting ) )
    {
        level.dontshootwhileparachuting = 1;
    }
    
    if ( !isdefined( level.freefallstartcb ) )
    {
        level.freefallstartcb = &freefallstartdefault;
    }
    
    if ( !isdefined( level.parachuteopencb ) )
    {
        level.parachuteopencb = &parachuteopendefault;
    }
    
    if ( !isdefined( level.parachutecompletecb ) )
    {
        level.parachutecompletecb = &parachutecompletedefault;
    }
    
    if ( !isdefined( level.parachutetakeweaponscb ) )
    {
        level.parachutetakeweaponscb = &leaveweaponsdefaultfunc;
    }
    
    if ( !isdefined( level.parachuterestoreweaponscb ) )
    {
        level.parachuterestoreweaponscb = &norestoreweaponsdefaultfunc;
    }
    
    if ( !isdefined( falltime ) )
    {
        falltime = 4;
    }
    
    if ( takeweapons )
    {
        self [[ level.parachutetakeweaponscb ]]();
    }
    
    self [[ level.freefallstartcb ]]();
    
    if ( isparachutegametype() )
    {
        omnvar_utility::function_58bd31d56367a73d( "ui_br_altimeter_state", 1 );
    }
    
    if ( !isdefined( var_eb5df45877fde599 ) )
    {
        self notifyonplayercommand( "open_parachute", "+gostand" );
    }
    
    self animscriptsetinputparamreplicationstatus( 1 );
    
    if ( isdefined( startingvelocity ) )
    {
        self setvelocity( startingvelocity );
    }
    
    self skydive_beginfreefall();
    
    if ( getdvarint( @"scr_parachute_camera_transition_mode", 1 ) != 2 )
    {
        self skydive_setforcethirdpersonstatus( 1 );
    }
    
    var_ac6b78ec22334b3e = namespace_9d8e359c3b1041e5::isfeatureenabledsharedfunc( #"infilparachutevfx" );
    
    if ( isbrgamemode() && ( !isgulagrespawn || var_ac6b78ec22334b3e ) && level.var_189e173f52be62cf )
    {
        thread infilparachutevfx( getdvarint( @"hash_96e4167dd77b8cee", 1 ) == 1 && var_ac6b78ec22334b3e );
    }
    
    if ( !popinstant )
    {
        wait falltime;
    }
    
    thread pullchute( var_eb5df45877fde599, popinstant );
}

// Namespace parachute
// Params 3
// Checksum 0x62b9603, Offset: 0xc6a
// Size: 0x199
function infilparachutevfx( endonground, showcontrail = 1, isinfil = 1 )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player = self;
    wait 1;
    
    if ( utility::issharedfuncdefined( #"ftue", #"player_action" ) )
    {
        player [[ utility::getsharedfunc( #"ftue", #"player_action" ) ]]( "br_ftue_parachute" );
    }
    
    player setshowcontrail( showcontrail );
    player setisinfilskydive( isinfil );
    wait 2;
    
    while ( isalive( player ) && !player shoulddisableskydivevfx() )
    {
        wait 0.25;
    }
    
    if ( endonground )
    {
        while ( isalive( player ) )
        {
            var_4c8494b2d9f8a060 = istrue( player.inlaststand );
            bisland = player isonground() || player isswimming() || player ishanging();
            var_90941ad50be28a34 = player isonladder();
            bisdead = !player::isreallyalive( player );
            binvehicle = player isvehicleactive();
            var_acb2dbcbe6e06a68 = player isonascender();
            
            if ( var_4c8494b2d9f8a060 || bisland || var_90941ad50be28a34 || bisdead || binvehicle || var_acb2dbcbe6e06a68 )
            {
                break;
            }
            
            wait 0.25;
        }
    }
    
    player setshowcontrail( 0 );
    player setisinfilskydive( 0 );
}

// Namespace parachute
// Params 2
// Checksum 0xdb72ef84, Offset: 0xe0b
// Size: 0x8d
function riotshield_attach_parachute( onarm, modelshield )
{
    tagattach = undefined;
    
    if ( onarm )
    {
        assert( !isdefined( self.riotshieldmodel ), "<dev string:xce>" );
        self.riotshieldmodel = modelshield;
        tagattach = "tag_weapon_right";
    }
    else
    {
        assert( !isdefined( self.riotshieldmodelstowed ), "<dev string:x122>" );
        self.riotshieldmodelstowed = modelshield;
        tagattach = "tag_shield_back";
    }
    
    self.hasriotshield = riotshield_hasweapon_parachute();
}

// Namespace parachute
// Params 0
// Checksum 0x1bd902a3, Offset: 0xea0
// Size: 0x7
function riotshield_getmodel_parachute()
{
    return "weapon_wm_riotshield";
}

// Namespace parachute
// Params 0
// Checksum 0x8819fa6e, Offset: 0xeb0
// Size: 0x99
function riotshield_hasweapon_parachute()
{
    result = 0;
    weaponlist = self getweaponslistprimaries();
    
    foreach ( weapon in weaponlist )
    {
        if ( isriotshield_parachute( weapon ) )
        {
            result = 1;
            break;
        }
    }
    
    return result;
}

// Namespace parachute
// Params 1
// Checksum 0x25bfdb21, Offset: 0xf52
// Size: 0x35, Type: bool
function isriotshield_parachute( weapon )
{
    weaponobj = utility::function_64003742d8f5c781( weapon );
    
    if ( !isdefined( weaponobj ) )
    {
        return false;
    }
    
    return weapontype( weaponobj ) == "riotshield";
}

// Namespace parachute
// Params 0
// Checksum 0x6f04b0f5, Offset: 0xf90
// Size: 0x10c, Type: bool
function isparachutegametype()
{
    matchrulesenabled = isusingmatchrulesdata() && getmatchrulesdata( "commonOption", "allowParachute" );
    
    if ( matchrulesenabled )
    {
        return true;
    }
    
    if ( !isdefined( level.isparachutegametype ) )
    {
        level.isparachutegametype = level.gametype == "ob" || level.gametype == "arm" || level.gametype == "bigctf" || level.gametype == "conflict" || level.gametype == "risk" || level.gametype == "war" || level.gametype == "missions" || level.gametype == "trial" || level.gametype == "brtdm" || level.gametype == "wm";
    }
    
    return isbrgamemode() || level.isparachutegametype;
}

// Namespace parachute
// Params 0
// Checksum 0xd893f3c, Offset: 0x10a5
// Size: 0x3d
function getc130height()
{
    if ( isdefined( level.br_level ) && isdefined( level.br_level.c130_heightoverride ) )
    {
        return level.br_level.c130_heightoverride;
    }
    
    return 24000;
}

// Namespace parachute
// Params 0
// Checksum 0xf9c27140, Offset: 0x10eb
// Size: 0x23
function getc130airdropheight()
{
    var_7237854e3be197ca = level.c130airdrop_heightoverride;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return 24000;
}

// Namespace parachute
// Params 0
// Checksum 0x7f110, Offset: 0x1117
// Size: 0x3d
function getc130sealevel()
{
    if ( isdefined( level.br_level ) && isdefined( level.br_level.c130_sealeveloverride ) )
    {
        return level.br_level.c130_sealeveloverride;
    }
    
    return 650;
}

// Namespace parachute
// Params 1
// Checksum 0x82845780, Offset: 0x115d
// Size: 0x70
function steerfalling( var_4ac2049263fb6a8b )
{
    controlentity = spawn( "script_model", self.origin );
    controlentity.angles = self.angles;
    controlentity setmodel( "viewhands_base_iw8" );
    controlentity hide();
    self playerlinktodelta( controlentity, "tag_player" );
    steerfallinginternal( controlentity, var_4ac2049263fb6a8b );
    controlentity delete();
}

// Namespace parachute
// Params 2
// Checksum 0xe98f5a7e, Offset: 0x11d5
// Size: 0x386
function steerfallinginternal( controlentity, var_4ac2049263fb6a8b )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"freefall_complete" );
    self endon( #"parachute_complete" );
    self notify( #"hash_e2be654bb6d6a1ca" );
    self endon( #"hash_e2be654bb6d6a1ca" );
    gravscale = 13.8;
    airdrag = 0.0001;
    var_22f3cf611c071f2b = -1350;
    horizontalaccel = 1400;
    var_3a8375d8a34355c9 = 1600;
    var_b8bd84c201eb1404 = -100;
    
    if ( level.gametype == "arm" || level.gametype == "conflict" || level.gametype == "bigctf" )
    {
        var_22f3cf611c071f2b = -1750;
        horizontalaccel = 400;
        var_3a8375d8a34355c9 = 400;
    }
    
    if ( isdefined( var_4ac2049263fb6a8b ) )
    {
        horizontalaccel *= var_4ac2049263fb6a8b;
        var_3a8375d8a34355c9 *= var_4ac2049263fb6a8b;
    }
    
    airresistance = level.framedurationseconds * airdrag;
    controlentity.vel = ( 0, 0, var_b8bd84c201eb1404 );
    waitframe();
    gamegravity = getdvarfloat( @"bg_gravity" );
    horizontalvel = ( 0, 0, 0 );
    
    while ( true )
    {
        movementinput = self getnormalizedmovement();
        var_9c3923d8345f310b = movementinput[ 0 ];
        var_9c3922d8345f2ed8 = movementinput[ 1 ];
        playerangles = self getplayerangles( 1 );
        axisy = anglestoforward( playerangles ) * var_9c3923d8345f310b;
        axisx = anglestoright( playerangles ) * var_9c3922d8345f2ed8;
        inputvector = axisx + axisy;
        targetvel = vectornormalize( inputvector ) * var_3a8375d8a34355c9;
        horizontalvel += vectornormalize( targetvel - horizontalvel ) * level.framedurationseconds * horizontalaccel;
        horizontalvel -= horizontalvel * length( horizontalvel ) * airresistance;
        downspeed = controlentity.vel[ 2 ] - gravscale * 39.37 * level.framedurationseconds;
        downspeed = max( var_22f3cf611c071f2b, downspeed );
        downvel = ( 0, 0, downspeed );
        controlentity.vel = downvel + horizontalvel;
        controlentity.origin += level.framedurationseconds * controlentity.vel;
        speed2d = sqrt( controlentity.vel[ 0 ] * controlentity.vel[ 0 ] + controlentity.vel[ 1 ] * controlentity.vel[ 1 ] );
        vspeed = veltomph( controlentity.vel[ 2 ] * -1 );
        hspeed = veltomph( speed2d );
        altitudepct = min( 1, ( self.origin[ 2 ] - getc130sealevel() ) / ( getc130height() - getc130sealevel() ) );
        
        if ( isparachutegametype() )
        {
            self setclientomnvar( "ui_br_altimeter_height", altitudepct );
            self setclientomnvar( "ui_br_altimeter_vertical_speed", int( vspeed ) );
            self setclientomnvar( "ui_br_altimeter_horizontal_speed", int( hspeed ) );
        }
        
        waitframe();
    }
}

// Namespace parachute
// Params 1
// Checksum 0x8e5c71dc, Offset: 0x1563
// Size: 0x22
function veltomph( v )
{
    mph = v * 0.05682;
    return mph;
}

// Namespace parachute
// Params 1
// Checksum 0xc16bce1c, Offset: 0x158e
// Size: 0x70
function steerparachuting( var_4ac2049263fb6a8b )
{
    controlentity = spawn( "script_model", self.origin );
    controlentity.angles = self.angles;
    controlentity setmodel( "viewhands_base_iw8" );
    controlentity hide();
    self playerlinktodelta( controlentity, "tag_player" );
    steerparachutinginternal( controlentity, var_4ac2049263fb6a8b );
    controlentity delete();
}

// Namespace parachute
// Params 2
// Checksum 0xb744ee3, Offset: 0x1606
// Size: 0x498
function steerparachutinginternal( controlentity, var_4ac2049263fb6a8b )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"freefall_complete" );
    self endon( #"parachute_landed" );
    self notify( #"hash_e2be654bb6d6a1ca" );
    self endon( #"hash_e2be654bb6d6a1ca" );
    basethrust = 100;
    minthrust = -200;
    maxthrust = 600;
    forwardaccel = 240;
    backaccel = 120;
    thrustdecay = 60;
    var_aad70ecbd3476cb8 = 48;
    maxpitch = 35;
    maxstrafe = 700;
    var_e25c79fb63a622b = 100;
    strafeaccel = 600;
    strafedecay = 300;
    var_3fd963ef43324f20 = 100;
    var_1310c1236007a5c2 = -150;
    
    if ( level.gametype == "arm" || level.gametype == "bigctf" || level.gametype == "conflict" )
    {
        var_1310c1236007a5c2 = -200;
    }
    
    if ( isdefined( var_4ac2049263fb6a8b ) )
    {
        basethrust *= var_4ac2049263fb6a8b;
        minthrust *= var_4ac2049263fb6a8b;
        maxthrust *= var_4ac2049263fb6a8b;
        forwardaccel *= var_4ac2049263fb6a8b;
        backaccel *= var_4ac2049263fb6a8b;
        thrustdecay *= var_4ac2049263fb6a8b;
        maxstrafe *= var_4ac2049263fb6a8b;
        strafeaccel *= var_4ac2049263fb6a8b;
        strafedecay *= var_4ac2049263fb6a8b;
        var_3fd963ef43324f20 *= var_4ac2049263fb6a8b;
    }
    
    thrustspeed = 100;
    thrustpitch = 0;
    strafespeed = 0;
    controlentity.vel = ( 0, 0, 0 );
    
    while ( true )
    {
        movementinput = self getnormalizedmovement();
        var_9c3923d8345f310b = movementinput[ 0 ];
        var_9c3922d8345f2ed8 = movementinput[ 1 ];
        playerangles = self getplayerangles( 1 );
        playerforward = anglestoforward( playerangles );
        playerright = anglestoright( playerangles );
        thrustaccel = var_9c3923d8345f310b > 0 ? forwardaccel : backaccel;
        thrustspeed += var_9c3923d8345f310b * thrustaccel * level.framedurationseconds;
        thrustspeed += thrustdecay * level.framedurationseconds * utility::sign( basethrust - thrustspeed );
        thrustspeed = clamp( thrustspeed, minthrust, maxthrust );
        var_b20c98ad544c62e9 = -1 * var_9c3923d8345f310b * maxpitch;
        thrustpitch += utility::sign( var_b20c98ad544c62e9 - thrustpitch ) * var_aad70ecbd3476cb8 * level.framedurationseconds;
        thrustdirection = rotatepointaroundvector( playerright, playerforward, thrustpitch );
        thrustvel = thrustspeed * thrustdirection;
        var_50d473e1d514472e = playerforward * var_3fd963ef43324f20 + ( 0, 0, var_1310c1236007a5c2 );
        strafespeed += strafeaccel * level.framedurationseconds * var_9c3922d8345f2ed8;
        strafespeed -= strafedecay * level.framedurationseconds * utility::sign( strafespeed );
        strafespeed = clamp( strafespeed, -1 * maxstrafe, maxstrafe );
        strafevel = strafespeed * playerright;
        strafedown = var_e25c79fb63a622b * abs( var_9c3922d8345f2ed8 );
        strafevel += ( 0, 0, -1 * strafedown );
        controlentity.vel = thrustvel + strafevel + var_50d473e1d514472e;
        controlentity.origin += controlentity.vel * level.framedurationseconds;
        speed2d = sqrt( controlentity.vel[ 0 ] * controlentity.vel[ 0 ] + controlentity.vel[ 1 ] * controlentity.vel[ 1 ] );
        vspeed = max( 0, veltomph( controlentity.vel[ 2 ] * -1 ) );
        hspeed = max( 0, veltomph( speed2d ) );
        altitudepct = min( 1, ( self.origin[ 2 ] - getc130sealevel() ) / ( getc130height() - getc130sealevel() ) );
        
        if ( isparachutegametype() )
        {
            self setclientomnvar( "ui_br_altimeter_height", altitudepct );
            self setclientomnvar( "ui_br_altimeter_vertical_speed", int( vspeed ) );
            self setclientomnvar( "ui_br_altimeter_horizontal_speed", int( hspeed ) );
        }
        
        waitframe();
    }
}

// Namespace parachute
// Params 0
// Checksum 0xa8dbd502, Offset: 0x1aa6
// Size: 0x1e, Type: bool
function isskydivestatedisabled()
{
    return self.ffsm_state == 5 || self.ffsm_state == 6;
}

// Namespace parachute
// Params 1
// Checksum 0x9461c11e, Offset: 0x1acd
// Size: 0x88
function enablemanualpullchute( waitsec )
{
    self endon( #"death_or_disconnect" );
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_cd6eb06ea3ed8b9f" ) && utility::callsharedfunc( #"gametype", #"hash_cd6eb06ea3ed8b9f", self ) )
    {
        return;
    }
    
    if ( waitsec > 0 )
    {
        self skydive_setdeploymentstatus( 0 );
        self skydive_setbasejumpingstatus( 0 );
        wait waitsec;
    }
    
    if ( isdefined( self ) )
    {
        if ( isskydivestatedisabled() )
        {
            return;
        }
        
        self skydive_setdeploymentstatus( 1 );
        self skydive_setbasejumpingstatus( 1 );
    }
}

// Namespace parachute
// Params 3
// Checksum 0xd3601d9d, Offset: 0x1b5d
// Size: 0x8b
function pullchute( var_eb5df45877fde599, popinstant, autoopen )
{
    self endon( #"death_or_disconnect" );
    thread enablemanualpullchute( 3 );
    self waittill( #"skydive_deployparachute" );
    self skydive_setdeploymentstatus( 0 );
    self notify( #"freefall_complete" );
    
    if ( isparachutegametype() )
    {
        omnvar_utility::function_58bd31d56367a73d( "ui_br_altimeter_state", 2 );
    }
    
    if ( !level.dontshootwhileparachuting )
    {
        self [[ level.parachuteopencb ]]();
    }
    
    thread startparachute();
}

// Namespace parachute
// Params 1
// Checksum 0x8f29cc5e, Offset: 0x1bf0
// Size: 0x12f
function parachutedamagemonitor( parachute )
{
    self endon( #"death_or_disconnect" );
    self endon( #"parachute_complete" );
    parachute endon( #"death" );
    parachute setcandamage( 1 );
    damage = undefined;
    attacker = undefined;
    direction_vec = undefined;
    meansofdeath = undefined;
    modelname = undefined;
    tagname = undefined;
    partname = undefined;
    idflags = undefined;
    objweapon = undefined;
    origin = undefined;
    angles = undefined;
    normal = undefined;
    inflictor = undefined;
    parachute.shotstaken = 0;
    
    while ( true )
    {
        parachute waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isdefined( meansofdeath ) )
        {
            if ( utility::isbulletdamage( meansofdeath ) )
            {
                parachute.shotstaken++;
            }
        }
    }
}

// Namespace parachute
// Params 0
// Checksum 0x6a080ffc, Offset: 0x1d27
// Size: 0xdc
function startparachute()
{
    self endon( #"death_or_disconnect" );
    
    if ( getdvarint( @"scr_parachute_camera_transition_mode", 1 ) == 1 )
    {
        self skydive_setforcethirdpersonstatus( 0 );
    }
    
    self waittill( #"skydive_end" );
    self.ignorefalldamagetime = gettime() + 5000;
    
    if ( self.delayswaploadout )
    {
        self.delayswaploadout = 0;
    }
    
    waitframe();
    self [[ level.parachuterestoreweaponscb ]]();
    
    if ( level.dontshootwhileparachuting )
    {
        self [[ level.parachutecompletecb ]]();
    }
    
    self notify( #"parachute_landed" );
    self skydive_setforcethirdpersonstatus( 0 );
    self notify( #"parachute_complete" );
    self animscriptsetinputparamreplicationstatus( 0 );
    
    if ( isparachutegametype() )
    {
        omnvar_utility::function_58bd31d56367a73d( "ui_br_altimeter_state", 0 );
        
        if ( isdefined( level.onfirstlandcallback ) )
        {
            self [[ level.onfirstlandcallback ]]( self );
        }
    }
}

// Namespace parachute
// Params 0
// Checksum 0xb2b8f9a0, Offset: 0x1e0b
// Size: 0x31
function parachutemidairdeathwatcher()
{
    self endon( #"parachute_complete" );
    self waittill( #"death" );
    
    if ( isparachutegametype() )
    {
        omnvar_utility::function_58bd31d56367a73d( "ui_br_altimeter_state", 0 );
    }
}

// Namespace parachute
// Params 0
// Checksum 0xa20c5c1a, Offset: 0x1e44
// Size: 0x8
function freefallstartdefault()
{
    self disableusability();
}

// Namespace parachute
// Params 0
// Checksum 0x3348b9c8, Offset: 0x1e54
// Size: 0x1d
function parachuteopendefault()
{
    callback::callback( #"parachute_opened", { #player:self } );
}

// Namespace parachute
// Params 0
// Checksum 0xd6f1298c, Offset: 0x1e79
// Size: 0x2c
function parachutecompletedefault()
{
    self enableusability();
    
    if ( isdefined( level.modespecificparachutecompletecb ) )
    {
        self [[ level.modespecificparachutecompletecb ]]();
    }
    
    self.jumptype = undefined;
}

// Namespace parachute
// Params 0
// Checksum 0x805d5887, Offset: 0x1ead
// Size: 0x7
function getautodeploynorm()
{
    return 0.25;
}

// Namespace parachute
// Params 0
// Checksum 0xd2f7c608, Offset: 0x1ebd
// Size: 0xd
function spawnorbitcamera()
{
    self cameraset( "camera_custom_orbit_0_noremote" );
}

// Namespace parachute
// Params 0
// Checksum 0xcc20161e, Offset: 0x1ed2
// Size: 0x8
function removeorbitcamera()
{
    self cameradefault();
}

// Namespace parachute
// Params 0
// Checksum 0xe2fa388c, Offset: 0x1ee2
// Size: 0x2
function leaveweaponsdefaultfunc()
{
    
}

// Namespace parachute
// Params 0
// Checksum 0x3bae4850, Offset: 0x1eec
// Size: 0x2
function norestoreweaponsdefaultfunc()
{
    
}

// Namespace parachute
// Params 0
// Checksum 0xfaa7e63, Offset: 0x1ef6
// Size: 0x138
function takeweaponsdefaultfunc()
{
    if ( isdefined( self.primaryweaponobj ) )
    {
        self.primaryweaponclipammo = self getweaponammoclip( self.primaryweaponobj );
        self.primaryweaponstockammo = self getweaponammostock( self.primaryweaponobj );
    }
    
    if ( isdefined( self.secondaryweaponobj ) )
    {
        self.secondaryweaponclipammo = self getweaponammoclip( self.secondaryweaponobj );
        self.secondaryweaponstockammo = self getweaponammostock( self.secondaryweaponobj );
    }
    
    gunless = level.defaultfist;
    weapnone = makeweapon( "none" );
    self.weaponlist = self.primaryweapons;
    self clearaccessory();
    
    if ( !self hasweapon( gunless ) )
    {
        inventory_utility::_giveweapon( gunless, undefined, undefined, 1 );
    }
    
    for ( i = 0; i < self.weaponlist.size ; i++ )
    {
        weapon = self.weaponlist[ i ];
        
        if ( isdefined( weapon ) && !issameweapon( gunless, weapon ) && !issameweapon( weapnone, weapon ) )
        {
            self takeweapon( weapon );
        }
    }
    
    inventory_utility::domonitoredweaponswitch( gunless, 1 );
}

// Namespace parachute
// Params 0
// Checksum 0x1f62f95a, Offset: 0x2036
// Size: 0x14b
function restoreweaponsdefaultfunc()
{
    self takeweapon( self.weaponlist[ 0 ] );
    self clearaccessory();
    
    if ( isdefined( self.primaryweaponobj ) )
    {
        inventory_utility::_giveweapon( self.primaryweaponobj, undefined, undefined, 0 );
        
        if ( isdefined( self.primaryweaponclipammo ) )
        {
            self setweaponammoclip( self.primaryweaponobj, self.primaryweaponclipammo );
            self setweaponammostock( self.primaryweaponobj, self.primaryweaponstockammo );
        }
    }
    
    if ( isdefined( self.secondaryweaponobj ) )
    {
        inventory_utility::_giveweapon( self.secondaryweaponobj, undefined, undefined, 1 );
        
        if ( isdefined( self.primaryweaponclipammo ) )
        {
            self setweaponammoclip( self.secondaryweaponobj, self.secondaryweaponclipammo );
            self setweaponammostock( self.secondaryweaponobj, self.secondaryweaponstockammo );
        }
    }
    
    self.weaponlist = self getweaponslistprimaries();
    
    if ( isdefined( self.weaponlist[ 0 ] ) )
    {
        inventory_utility::domonitoredweaponswitch( self.weaponlist[ 0 ] );
    }
    
    if ( isdefined( self.weaponlist[ 0 ] ) )
    {
        self.primaryweaponobj = self.weaponlist[ 0 ];
    }
    
    if ( isdefined( self.weaponlist[ 1 ] ) )
    {
        self.secondaryweaponobj = self.weaponlist[ 1 ];
    }
}

// Namespace parachute
// Params 0
// Checksum 0x42c85755, Offset: 0x2189
// Size: 0x4b, Type: bool
function canredeploy()
{
    if ( !self.redeployenabled )
    {
        return false;
    }
    
    if ( self isonground() )
    {
        return false;
    }
    
    if ( !player::isreallyalive() )
    {
        return false;
    }
    
    if ( self isskydiving() )
    {
        return false;
    }
    
    if ( self islinked() )
    {
        return false;
    }
    
    if ( self.carrying )
    {
        return false;
    }
    
    return true;
}

// Namespace parachute
// Params 0
// Checksum 0x4a74736a, Offset: 0x21dd
// Size: 0x1a7
function playerwatchforredeploy()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    redeployheight = getdvarfloat( @"scr_parachute_redeploy_min_height", 256 );
    var_68f75614c0b6adb0 = 0;
    self.redeployenabled = 1;
    
    while ( true )
    {
        if ( canredeploy() )
        {
            inputvalid = 0;
            
            switch ( getdvarint( @"scr_parachute_redeploy_input_type", 0 ) )
            {
                case 0:
                    if ( var_68f75614c0b6adb0 == 0 && self jumpbuttonpressed() )
                    {
                        inputvalid = 1;
                    }
                    
                    break;
                case 1:
                    if ( self jumpbuttonpressed() && var_68f75614c0b6adb0 + 500 < gettime() )
                    {
                        inputvalid = 1;
                    }
                    
                    break;
                case 2:
                    if ( !isdefined( self.doublejumpdetected ) )
                    {
                        thread watchfordoublejump();
                    }
                    
                    if ( self.doublejumpdetected )
                    {
                        inputvalid = 1;
                    }
                    
                    break;
                default:
                    break;
            }
            
            if ( inputvalid )
            {
                gpos = utility::groundpos( self.origin );
                var_d24ad7fcbfed8975 = self.origin[ 2 ] - gpos[ 2 ];
                
                /#
                    redeployheight = getdvarfloat( @"scr_parachute_redeploy_min_height", 256 );
                #/
                
                if ( var_d24ad7fcbfed8975 > redeployheight )
                {
                    self notify( #"skydive_deployparachute" );
                    self skydive_deployparachute();
                }
            }
        }
        
        if ( isdefined( self ) && player::isreallyalive() )
        {
            if ( !self jumpbuttonpressed() )
            {
                var_68f75614c0b6adb0 = 0;
            }
            else if ( var_68f75614c0b6adb0 == 0 )
            {
                var_68f75614c0b6adb0 = gettime();
            }
        }
        else
        {
            var_68f75614c0b6adb0 = 0;
        }
        
        waitframe();
    }
}

// Namespace parachute
// Params 0
// Checksum 0xe5050eac, Offset: 0x238c
// Size: 0xf3
function watchfordoublejump()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.doublejumpdetected = 0;
    
    while ( true )
    {
        if ( self jumpbuttonpressed() )
        {
            presstime = gettime();
            releasetime = 0;
            waitframe();
            
            while ( true )
            {
                if ( !self jumpbuttonpressed() )
                {
                    if ( gettime() < presstime + 500 && !self isonground() )
                    {
                        releasetime = gettime();
                    }
                    
                    break;
                }
                
                if ( gettime() > presstime + 500 )
                {
                    break;
                }
                
                waitframe();
            }
            
            if ( releasetime == 0 )
            {
                continue;
            }
            
            waitframe();
            
            while ( true )
            {
                if ( self jumpbuttonpressed() )
                {
                    if ( gettime() < releasetime + 500 && !self isonground() )
                    {
                        self.doublejumpdetected = 1;
                        waitframe();
                        self.doublejumpdetected = 0;
                    }
                    
                    break;
                }
                
                if ( gettime() > releasetime + 500 )
                {
                    break;
                }
                
                waitframe();
            }
        }
        
        waitframe();
    }
}

/#

    // Namespace parachute
    // Params 0
    // Checksum 0xcd63774b, Offset: 0x2487
    // Size: 0xe4, Type: dev
    function function_e78c8e5f124be2fc()
    {
        self endon( #"death_or_disconnect" );
        self endon( #"parachute_complete" );
        
        while ( true )
        {
            thread debug_utility::drawangles( self.origin, self.angles, 0.05, 5 );
            velocity = self getvelocity();
            mag = length( velocity );
            thread debug_utility::drawline( self.origin, self.origin + vectornormalize( velocity ) * mag, 0.05, ( 1, 0, 1 ) );
            printtoscreen2d( 750, 800, "<dev string:x172>" + vectornormalize( velocity ), ( 1, 0, 1 ), 2 );
            printtoscreen2d( 750, 825, "<dev string:x17d>" + mag, ( 1, 0, 1 ), 2 );
            waitframe();
        }
    }

#/

// Namespace parachute
// Params 0
// Checksum 0x759521e2, Offset: 0x2573
// Size: 0x49
function parachuteprelaststandfunction()
{
    player = self;
    
    if ( player.ffsm_state == 1 || player.ffsm_state == 2 )
    {
        player ffsm_landed_stateenter();
        player.ffsm_state = 3;
    }
}

// Namespace parachute
// Params 0
// Checksum 0x8e7dac9d, Offset: 0x25c4
// Size: 0x1f8
function updateparachutestreamhint()
{
    player = self;
    velocity = player getvelocity();
    xyvelscale_ratio = clamp( player.origin[ 2 ], 0, level.skydivestreamhintdvars.xyvelscale_maxheight ) / level.skydivestreamhintdvars.xyvelscale_maxheight;
    xyvelscale = level.skydivestreamhintdvars.xyvelscale_low + ( level.skydivestreamhintdvars.xyvelscale_high - level.skydivestreamhintdvars.xyvelscale_low ) * xyvelscale_ratio;
    xyvel = velocity * ( 1, 1, 0 );
    xylength = length( xyvel );
    xyhint = xyvel * xyvelscale;
    var_fa8d688452c8ad18 = xylength * xyvelscale;
    
    if ( var_fa8d688452c8ad18 > level.skydivestreamhintdvars.xylimit )
    {
        xyhint *= level.skydivestreamhintdvars.xylimit / var_fa8d688452c8ad18;
    }
    
    zhint = 0;
    zhint -= player.origin[ 2 ] * level.skydivestreamhintdvars.zdrop;
    zhint += level.skydivestreamhintdvars.zoffset;
    zhint += velocity[ 2 ] * level.skydivestreamhintdvars.zvelscale;
    zhint = clamp( zhint, -1 * level.skydivestreamhintdvars.zlimit, 0 );
    viewmode = 1;
    
    if ( xylength < level.skydivestreamhintdvars.falling_xyratio * velocity[ 2 ] )
    {
        viewmode = 2;
    }
    
    player setadditionalstreamposuntilcleared( player.origin + ( xyhint[ 0 ], xyhint[ 1 ], zhint ), viewmode );
}

// Namespace parachute
// Params 6
// Checksum 0xa8fdc462, Offset: 0x27c4
// Size: 0x36b
function freefallfromplanestatemachine( falltime, popinstant, var_eb5df45877fde599, startingvelocity, isgulagrespawn, takeweapons )
{
    self notify( #"hash_b39715aebe10579a" );
    self endon( #"hash_b39715aebe10579a" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    player = self;
    player.ffsm_state = 1;
    player.ffsm_isgulagrespawn = istrue( isgulagrespawn );
    player.ffsm_nextstreamhinttime = 0;
    player ffsm_introsetup( falltime, popinstant, var_eb5df45877fde599, startingvelocity, takeweapons );
    player ffsm_skydive_stateenter();
    starttime = gettime();
    
    while ( true )
    {
        if ( player isskydiving() || starttime + 2000 < gettime() || player isskydivestatedisabled() )
        {
            break;
        }
        
        waitframe();
    }
    
    while ( true )
    {
        currenttime = gettime();
        
        if ( level.skydivestreamhintdvars.streamhintenabled && player.ffsm_nextstreamhinttime < currenttime )
        {
            player updateparachutestreamhint();
            player.ffsm_nextstreamhinttime = currenttime + 500;
        }
        
        if ( player.ffsm_state != 1 && player isinfreefall() )
        {
            player ffsm_skydive_stateenter();
            player.ffsm_state = 1;
        }
        else if ( player.ffsm_state != 2 && player isparachuting() )
        {
            player ffsm_parachuteopen_stateenter();
            player.ffsm_state = 2;
        }
        else if ( player.ffsm_state == 5 || player.ffsm_state != 3 && player.ffsm_state != 4 && player.ffsm_state != 6 && !player isskydiving() )
        {
            player ffsm_landed_stateenter();
            
            if ( player.ffsm_state != 5 )
            {
                player.ffsm_state = 3;
            }
            else
            {
                assert( player.ffsm_state == 5 );
                player.ffsm_state = 6;
            }
        }
        
        var_4c8494b2d9f8a060 = istrue( player.inlaststand );
        bisland = ( player isonground() || player isswimming() || player ishanging() ) && ( player.ffsm_state == 3 || player isskydivestatedisabled() );
        var_90941ad50be28a34 = player isonladder();
        bisdead = !player::isreallyalive( player );
        binvehicle = player isvehicleactive();
        var_acb2dbcbe6e06a68 = player isonascender();
        
        if ( var_4c8494b2d9f8a060 || bisland || var_90941ad50be28a34 || bisdead || binvehicle || var_acb2dbcbe6e06a68 )
        {
            player utility::callsharedfunc( #"hud", #"ftue_trigger_landed_hint" );
            player ffsm_onground_stateenter();
            player.ffsm_state = undefined;
            player.ffsm_isgulagrespawn = undefined;
            player.ffsm_nextstreamhinttime = undefined;
            
            if ( var_90941ad50be28a34 )
            {
                player skydive_interrupt();
            }
            
            return;
        }
        
        waitframe();
    }
}

// Namespace parachute
// Params 5
// Checksum 0x674de0bb, Offset: 0x2b37
// Size: 0x17d
function ffsm_introsetup( falltime, popinstant, var_eb5df45877fde599, startingvelocity, takeweapons )
{
    /#
        if ( getdvarint( @"scr_parachute_debug", 0 ) == 1 )
        {
            thread function_e78c8e5f124be2fc();
        }
    #/
    
    self skydive_interrupt();
    
    if ( !level.parachuteinitfinished )
    {
        initparachutedvars();
    }
    
    if ( !isdefined( falltime ) )
    {
        falltime = 4;
    }
    
    if ( !isdefined( takeweapons ) )
    {
        takeweapons = 1;
    }
    
    if ( takeweapons && !isbrgamemode() )
    {
        self [[ level.parachutetakeweaponscb ]]();
    }
    
    self [[ level.freefallstartcb ]]();
    
    if ( !isdefined( var_eb5df45877fde599 ) )
    {
        self notifyonplayercommand( "open_parachute", "+gostand" );
    }
    
    self animscriptsetinputparamreplicationstatus( 1 );
    
    if ( isdefined( startingvelocity ) )
    {
        self setvelocity( startingvelocity );
    }
    
    self skydive_beginfreefall();
    
    if ( getdvarint( @"scr_parachute_camera_transition_mode", 1 ) != 2 )
    {
        self skydive_setforcethirdpersonstatus( 1 );
    }
    
    var_ac6b78ec22334b3e = namespace_9d8e359c3b1041e5::isfeatureenabledsharedfunc( #"infilparachutevfx" );
    
    if ( isbrgamemode() && ( !self.ffsm_isgulagrespawn || var_ac6b78ec22334b3e ) && level.var_189e173f52be62cf )
    {
        thread infilparachutevfx( getdvarint( @"hash_96e4167dd77b8cee", 1 ) == 1 && var_ac6b78ec22334b3e );
    }
    
    if ( popinstant )
    {
        thread enablemanualpullchute( 0 );
    }
    else
    {
        thread enablemanualpullchute( falltime );
    }
    
    self [[ level.parachuterestoreweaponscb ]]();
}

// Namespace parachute
// Params 0
// Checksum 0xbadcb314, Offset: 0x2cbc
// Size: 0x3f
function ffsm_skydive_stateenter()
{
    if ( isparachutegametype() )
    {
        omnvar_utility::function_58bd31d56367a73d( "ui_br_altimeter_state", 1 );
        level.activeparachuters[ self getxuid() ] = self;
    }
    
    if ( !self.ffsm_isgulagrespawn )
    {
        self setshowcontrail( 1 );
    }
}

// Namespace parachute
// Params 0
// Checksum 0x3530e5cf, Offset: 0x2d03
// Size: 0x87
function ffsm_parachuteopen_stateenter()
{
    self notify( #"freefall_complete" );
    
    if ( utility::issharedfuncdefined( #"br", #"hash_6273eabc6f3c9c58" ) )
    {
        [[ utility::getsharedfunc( #"br", #"hash_6273eabc6f3c9c58" ) ]]( self );
    }
    
    level.activeparachuters[ self getxuid() ] = self;
    
    if ( isparachutegametype() )
    {
        omnvar_utility::function_58bd31d56367a73d( "ui_br_altimeter_state", 2 );
    }
    
    if ( !level.dontshootwhileparachuting )
    {
        self [[ level.parachuteopencb ]]();
    }
}

// Namespace parachute
// Params 1
// Checksum 0xbae80ce4, Offset: 0x2d92
// Size: 0xc2
function ffsm_landed_stateenter( var_83ef718a53f0875c )
{
    self.ignorefalldamagetime = gettime() + 5000;
    
    if ( self.delayswaploadout )
    {
        self.delayswaploadout = 0;
    }
    
    if ( level.dontshootwhileparachuting )
    {
        self [[ level.parachutecompletecb ]]();
    }
    
    self notify( #"parachute_landed" );
    self skydive_setforcethirdpersonstatus( 0 );
    
    if ( !isskydivestatedisabled() )
    {
        self skydive_setbasejumpingstatus( 1 );
    }
    
    if ( self.restoreriotshieldonland )
    {
        riotshield_attach_parachute( self.restoreriotshieldonland == 1, riotshield_getmodel_parachute() );
        self.restoreriotshieldonland = undefined;
    }
    
    level.activeparachuters[ self getxuid() ] = undefined;
    self notify( #"parachute_complete" );
    self animscriptsetinputparamreplicationstatus( 0 );
}

// Namespace parachute
// Params 0
// Checksum 0x3bf1b63, Offset: 0x2e5c
// Size: 0x77
function ffsm_onground_stateenter()
{
    self.haslanded = 1;
    
    if ( level.skydivestreamhintdvars.streamhintenabled )
    {
        self clearadditionalstreampos();
    }
    
    if ( isparachutegametype() )
    {
        level.activeparachuters[ self getxuid() ] = undefined;
        omnvar_utility::function_58bd31d56367a73d( "ui_br_altimeter_state", 0 );
        thread playlandingbreath();
        
        if ( isdefined( level.onfirstlandcallback ) )
        {
            self [[ level.onfirstlandcallback ]]( self );
        }
    }
    
    self setshowcontrail( 0 );
}

// Namespace parachute
// Params 0
// Checksum 0x22e5b83, Offset: 0x2edb
// Size: 0x35
function playlandingbreath()
{
    self endon( #"death_or_disconnect" );
    wait 0.3;
    
    if ( player::isreallyalive( self ) )
    {
        self playlocalsound( "plr_breath_land_parachute", self );
        self playsoundonmovingent( "breath_land_parachute_npc" );
    }
}

// Namespace parachute
// Params 0
// Checksum 0xf74a4f67, Offset: 0x2f18
// Size: 0x35
function parachutecleanup()
{
    player = self;
    player skydive_interrupt();
    
    if ( isdefined( player.parachute ) )
    {
        player.parachute delete();
    }
}

