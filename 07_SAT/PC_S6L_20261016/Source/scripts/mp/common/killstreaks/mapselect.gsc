// scripts\mp\common\killstreaks\mapselect.gsc  (hash_6ecce26a00447bae.gscc) (size: 8562 Bytes / 0x2172 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc57e3fb2 (3313385394)
// size ...... 8562 (0x2172)
// includes .. 10  (offset: 0x1eb6)
// strings ... 32  (offset: 0x1f06)
// dev strs .. 3   (offset: 0x214e)
// exports ... 23  (offset: 0x14f2)
// cseg ...... 0x2ee + 0x1204 (0x14f2)
// imports ... 54  (offset: 0x188a)
// animtree1 . 0   (offset: 0x2172)
// animtree2 . 0   (offset: 0x2172)
#using script_16ea1b94f0f381b3;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\emp_debuff;
#using scripts\mp\hostmigration;

#namespace mapselect;

// Namespace mapselect
// Params 0
// Checksum 0xe54a6956, Offset: 0x30c
// Size: 0x9
function init()
{
    function_b3b7241c1e94e3b1();
}

// Namespace mapselect
// Params 0
// Checksum 0x1dd8ac63, Offset: 0x31d
// Size: 0x122
function function_b3b7241c1e94e3b1()
{
    if ( namespace_9d8e359c3b1041e5::function_f67fae8ef25c92b9() )
    {
        val::group_register( "map_select", [ "usability", "killstreaks", "supers", "fire", "weapon_switch", "allow_jump", "mantle" ] );
        return;
    }
    
    if ( namespace_9d8e359c3b1041e5::function_cfb5f8c2e930a89b() )
    {
        val::group_register( "map_select", [ "usability", "killstreaks", "supers", "fire", "weapon_switch", "allow_movement", "allow_jump", "mantle" ] );
        return;
    }
    
    val::group_register( "map_select", [ "usability", "killstreaks", "supers", "gesture", "fire", "weapon_switch", "allow_movement", "offhand_weapons", "allow_jump", "mantle" ] );
}

// Namespace mapselect
// Params 0
// Checksum 0x317407dc, Offset: 0x447
// Size: 0x7
function mapselect_getweapon()
{
    return "ks_remote_map_mp";
}

// Namespace mapselect
// Params 4
// Checksum 0x2cd091d6, Offset: 0x457
// Size: 0x1a9
function function_ec95e9f1b6d329fb( info, selectnum, directionalselection, var_dc92dfb129a68d17 )
{
    if ( !isdefined( info ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    issuper = self.super == info;
    val::group_set( "map_select", 0 );
    self setsoundsubmix( "mp_killstreak_overlay" );
    navmesh = 0;
    
    if ( isdefined( info.streakname ) )
    {
        if ( killstreak::isnavmeshkillstreak( info.streakname ) )
        {
            navmesh = 1;
        }
        
        bundle = killstreak_utility::function_f943c0602acdc2af( info.streakname );
    }
    
    if ( !isdefined( selectnum ) )
    {
        selectnum = 1;
    }
    
    if ( !isdefined( directionalselection ) )
    {
        directionalselection = 0;
    }
    
    thread function_69177d8b738592ac( info, issuper, var_dc92dfb129a68d17 );
    thread function_ca3543d35768c635();
    thread function_5b311b65301a42bf();
    thread function_3619065a1edee424();
    thread function_830301e42c450b64();
    mappointinfo = undefined;
    streakref = info.streakname;
    
    if ( issuper )
    {
        streakref = info.staticdata.ref;
    }
    
    killstreak_shared::starttabletscreen( streakref, 0.05 );
    mappointinfo = function_35ca097d25bb247c( info, selectnum, directionalselection );
    
    if ( isdefined( self ) )
    {
        time = bundle.var_12c7cf79dc02d806 ?? 0.75;
        
        if ( self.var_45ab03788f1a0a4d )
        {
            time = 0;
        }
        
        killstreak_shared::stoptabletscreen( streakref, time );
        
        if ( player::isreallyalive( self ) )
        {
            val::group_reset( "map_select" );
        }
        
        self clearsoundsubmix( "mp_killstreak_overlay" );
    }
    
    return mappointinfo;
}

// Namespace mapselect
// Params 3
// Checksum 0x54bc2940, Offset: 0x609
// Size: 0x326
function function_35ca097d25bb247c( info, selectnum, directionalselection )
{
    self endon( #"disconnect" );
    self notify( #"map_select_started" );
    usehints = 1;
    
    if ( selectnum <= 1 )
    {
        self setclientomnvar( "ui_map_select_uses", -1 );
        usehints = 0;
    }
    
    self.mapselectpickcounter = 0;
    self.previousmapselectioninfo = undefined;
    locationinfo = [];
    var_51fc6f0df6b32c0e = 1;
    
    if ( isdefined( info ) && isdefined( info.var_8e2398ebc25b545c ) )
    {
        var_51fc6f0df6b32c0e = info.var_8e2398ebc25b545c;
    }
    
    if ( var_51fc6f0df6b32c0e )
    {
        thread function_62eab80d224d780( info );
    }
    
    if ( usehints )
    {
        self setclientomnvar( "ui_map_select_uses", selectnum );
        self setclientomnvar( "ui_map_select_count", selectnum );
    }
    
    returninfo = undefined;
    self dlog_recordplayerevent( "dlog_event_killstreak_tablet", [ "file_line_info", "Before ui_map_select_uses" ] );
    streakbundle = level.streakglobals.streakbundles[ info.streakname ];
    
    while ( self.mapselectpickcounter < selectnum )
    {
        returninfo = function_7aa8aa7be2286f69();
        
        if ( !isdefined( returninfo ) || returninfo.string == "death" )
        {
            self.var_45ab03788f1a0a4d = 1;
            locationinfo = undefined;
            break;
        }
        else if ( returninfo.string == "cancel_location" )
        {
            locationinfo = undefined;
            var_d9b7bdd8a28490d1 = level.projectbundle.var_e76a983ae9b28b00 ? level.projectbundle.var_e76a983ae9b28b00 : "iw9_ks_tablet_ui_select_final_plr";
            self playlocalsound( streakbundle.var_4963939b443090a ?? var_d9b7bdd8a28490d1 );
            break;
        }
        
        var_3e6b5f079ea6ae9e = returninfo.location + ( 0, 0, 10000 );
        var_2ba7a759e251c071 = returninfo.location - ( 0, 0, 10000 );
        var_847f780b10d918e5 = level.activekillstreaks;
        contentoverride = trace::create_contents( 0, 1, 0, 1, 1 );
        locationtrace = trace::ray_trace( var_3e6b5f079ea6ae9e, var_2ba7a759e251c071, var_847f780b10d918e5, contentoverride, 0, 1 );
        returninfo.location = locationtrace[ "position" ];
        locationinfo[ locationinfo.size ] = returninfo;
        self.mapselectpickcounter++;
        var_291633f99eb4e62d = level.projectbundle.var_a9ba1289bff6b02c ? level.projectbundle.var_a9ba1289bff6b02c : "iw9_ks_tablet_ui_select_plr";
        self playlocalsound( streakbundle.var_2b0bbdf66f603816 ?? var_291633f99eb4e62d );
        
        if ( usehints )
        {
            self setclientomnvar( "ui_map_select_uses", selectnum - self.mapselectpickcounter );
        }
    }
    
    self dlog_recordplayerevent( "dlog_event_killstreak_tablet", [ "file_line_info", "After ui_map_select_uses" ] );
    self notify( #"map_select_exit", returninfo );
    return locationinfo;
}

// Namespace mapselect
// Params 0
// Checksum 0x6f2dfa32, Offset: 0x938
// Size: 0xfa
function function_7aa8aa7be2286f69()
{
    /#
        if ( isbot( self ) )
        {
            hostplayer = undefined;
            
            foreach ( player in level.players )
            {
                if ( player ishost() )
                {
                    hostplayer = player;
                    break;
                }
            }
            
            returninfo = spawnstruct();
            returninfo.location = hostplayer.origin;
            returninfo.angles = randomintrange( 0, 360 );
            returninfo.string = "<dev string:x59>";
            return returninfo;
        }
    #/
    
    return waittill_confirm_or_cancel( "confirm_location", "cancel_location", "death" );
}

// Namespace mapselect
// Params 1
// Checksum 0xfaec6f73, Offset: 0xa3b
// Size: 0x6f
function function_62eab80d224d780( info )
{
    self endon( #"map_select_exit" );
    weaponname = info.weaponname ?? "ks_remote_map_mp";
    
    while ( true )
    {
        currentweapon = self getcurrentweapon();
        
        if ( currentweapon.basename != weaponname )
        {
            self notify( #"cancel_location" );
            break;
        }
        
        waitframe();
    }
}

// Namespace mapselect
// Params 3
// Checksum 0xc9e94bbf, Offset: 0xab2
// Size: 0x5c
function function_69177d8b738592ac( info, issuper, var_dc92dfb129a68d17 )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self waittill( #"map_select_exit", exitinfo );
    function_ce397939dde8936c( info, issuper, exitinfo, var_dc92dfb129a68d17 );
}

// Namespace mapselect
// Params 0
// Checksum 0xd6e67797, Offset: 0xb16
// Size: 0x47
function function_ca3543d35768c635()
{
    self endon( #"disconnect" );
    self endon( #"map_select_exit" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( emp_debuff::is_empd() )
        {
            self notify( #"cancel_location" );
            break;
        }
        
        waitframe();
    }
}

// Namespace mapselect
// Params 0
// Checksum 0x7f87efb9, Offset: 0xb65
// Size: 0x4a
function function_5b311b65301a42bf()
{
    self endon( #"disconnect" );
    self endon( #"map_select_exit" );
    level endon( #"game_ended" );
    self waittill( #"meatshield_victim_grabbed" );
    self.var_45ab03788f1a0a4d = 1;
    self notify( #"cancel_location" );
}

// Namespace mapselect
// Params 0
// Checksum 0x738eb094, Offset: 0xbb7
// Size: 0x33
function function_3619065a1edee424()
{
    self endon( #"disconnect" );
    self endon( #"map_select_exit" );
    level waittill( #"game_ended" );
    self notify( #"cancel_location" );
}

// Namespace mapselect
// Params 0
// Checksum 0x414de32b, Offset: 0xbf2
// Size: 0x58
function function_830301e42c450b64()
{
    self endon( #"disconnect" );
    self endon( #"map_select_exit" );
    level endon( #"game_ended" );
    self setclientomnvar( "ui_location_selection_countdown", gettime() + 30000 );
    utility::waittill_any_timeout( 30, "death", "last_stand_enter" );
    self notify( #"cancel_location" );
}

// Namespace mapselect
// Params 10
// Checksum 0x9ca11be4, Offset: 0xc52
// Size: 0x1c3
function function_74e31405d43e142( navmesh, directionalselection, directionaltype, selectortype, info, selectorradius, var_a99f66222c6d27ff, var_a86b041c65e59e27, radarshowenemydirection, var_51fc6f0df6b32c0e )
{
    if ( !isdefined( self.pers[ "startedMapSelect" ] ) )
    {
        self.pers[ "startedMapSelect" ] = [];
        
        if ( !info.var_d53d8dea4a240bbc )
        {
            thread mapselect_watchdeath();
        }
    }
    
    if ( radarshowenemydirection )
    {
        info.var_aac388534ddaf898 = 1;
        info.var_80b8aead1e08d421 = self.radarshowenemydirection;
        self.radarshowenemydirection = radarshowenemydirection;
    }
    
    if ( isdefined( info ) )
    {
        thread function_46abfb247ace08cc( info, var_a86b041c65e59e27 );
    }
    
    if ( !isdefined( navmesh ) )
    {
        navmesh = 0;
    }
    
    if ( !isdefined( directionalselection ) )
    {
        directionalselection = 0;
    }
    
    if ( !isdefined( directionaltype ) )
    {
        directionaltype = "circle_marker";
    }
    
    if ( !isdefined( selectortype ) )
    {
        selectortype = 0;
    }
    
    if ( !isdefined( selectorradius ) )
    {
        selectorradius = 1000;
    }
    
    if ( !isdefined( var_a99f66222c6d27ff ) )
    {
        var_a99f66222c6d27ff = 0;
    }
    
    if ( !isdefined( var_51fc6f0df6b32c0e ) )
    {
        var_51fc6f0df6b32c0e = 1;
    }
    
    self dlog_recordplayerevent( "dlog_event_killstreak_tablet", [ "file_line_info", "Before BeginLocationSelection" ] );
    self beginlocationselection( navmesh, directionalselection, directionaltype, var_51fc6f0df6b32c0e, selectortype, selectorradius, var_a99f66222c6d27ff );
    self dlog_recordplayerevent( "dlog_event_killstreak_tablet", [ "file_line_info", "After BeginLocationSelection" ] );
    fallbackdeploysound = level.projectbundle.var_6427aafc6515c1f7 ? level.projectbundle.var_6427aafc6515c1f7 : "iw9_ks_tablet_ui_screen_plr";
    self playlocalsound( info.bundle.var_b3fb9f5453fca2ad ?? fallbackdeploysound );
}

// Namespace mapselect
// Params 2
// Checksum 0x687a5a5e, Offset: 0xe1d
// Size: 0x17a
function function_46abfb247ace08cc( info, var_a86b041c65e59e27 )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    info endon( #"killstreak_finished_with_deploy_weapon" );
    
    if ( !isdefined( info.var_82be507d9fedab93 ) )
    {
        info.var_82be507d9fedab93 = 0;
    }
    
    var_c9183273cee4c209 = mapselect_getid( info );
    
    if ( function_14311091c6300ba5( info ) || self.pers[ "startedMapSelect" ][ var_c9183273cee4c209 ].var_82be507d9fedab93 < var_a86b041c65e59e27 )
    {
        if ( !isdefined( self.pers[ "startedMapSelect" ][ var_c9183273cee4c209 ] ) )
        {
            self.pers[ "startedMapSelect" ][ var_c9183273cee4c209 ] = info;
        }
        
        if ( isdefined( info.streakname ) )
        {
            if ( !info.bundle.disableradaronuse )
            {
                if ( !isdefined( var_a86b041c65e59e27 ) )
                {
                    var_a86b041c65e59e27 = 1;
                }
                
                while ( self.pers[ "startedMapSelect" ][ var_c9183273cee4c209 ].var_82be507d9fedab93 < var_a86b041c65e59e27 )
                {
                    triggeroneoffradarsweep( self, info.bundle.var_4770547a59d815d4 );
                    self.pers[ "startedMapSelect" ][ var_c9183273cee4c209 ].var_82be507d9fedab93++;
                    
                    if ( self.pers[ "startedMapSelect" ][ var_c9183273cee4c209 ].var_82be507d9fedab93 < var_a86b041c65e59e27 )
                    {
                        wait getradarupdatetime( self ) / 1000;
                    }
                }
            }
        }
    }
}

// Namespace mapselect
// Params 4
// Checksum 0xf528db34, Offset: 0xf9f
// Size: 0x159
function function_ce397939dde8936c( info, issuper, exitinfo, var_dc92dfb129a68d17 )
{
    self.mapselectpickcounter = undefined;
    self.mapselectdircounter = undefined;
    self.previousmapselectioninfo = undefined;
    
    if ( info.var_aac388534ddaf898 )
    {
        info.var_aac388534ddaf898 = undefined;
        self.radarshowenemydirection = info.var_80b8aead1e08d421;
    }
    
    if ( player::isreallyalive( self ) )
    {
        if ( exitinfo.string != "cancel_location" && var_dc92dfb129a68d17 )
        {
        }
        else if ( issuper )
        {
            self notify( #"super_finished_with_deploy_weapon" );
        }
        else
        {
            info notify( #"killstreak_finished_with_deploy_weapon" );
        }
    }
    
    if ( exitinfo.string == "confirm_location" || exitinfo.string == "death" && !info.var_d53d8dea4a240bbc )
    {
        var_c9183273cee4c209 = mapselect_getid( info );
        self.pers[ "startedMapSelect" ][ var_c9183273cee4c209 ] = undefined;
    }
    
    hostmigration::waitlongdurationwithpause( 0.25 );
    
    if ( isdefined( self ) )
    {
        self endlocationselection();
        self setclientomnvar( "ui_map_select_count", -1 );
        
        if ( isdefined( info ) && info.var_c91cbd0522730b07 )
        {
            namespace_9d8e359c3b1041e5::function_f04bdccad87bc790();
        }
    }
}

// Namespace mapselect
// Params 1, eflags: 0x4
// Checksum 0x8baaa8b3, Offset: 0x1100
// Size: 0xb7, Type: bool
function private function_14311091c6300ba5( info )
{
    var_65552c0bb22aabe4 = self.pers[ "startedMapSelect" ];
    
    if ( isdefined( var_65552c0bb22aabe4 ) )
    {
        foreach ( instance in var_65552c0bb22aabe4 )
        {
            if ( !function_154739a8e4468691( instance, info ) )
            {
                return false;
            }
            
            if ( !function_313f3d12b0bca8bc( instance, info ) )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace mapselect
// Params 2, eflags: 0x4
// Checksum 0x12847a0d, Offset: 0x11c0
// Size: 0x80, Type: bool
function private function_154739a8e4468691( storedinfo, newinfo )
{
    if ( isdefined( storedinfo.staticdata ) && isdefined( newinfo.staticdata ) )
    {
        if ( storedinfo.staticdata.ref == newinfo.staticdata.ref && storedinfo.lifeid == newinfo.lifeid )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace mapselect
// Params 2, eflags: 0x4
// Checksum 0xb09cfc0d, Offset: 0x1249
// Size: 0x6c, Type: bool
function private function_313f3d12b0bca8bc( storedinfo, newinfo )
{
    if ( isdefined( storedinfo.streakname ) && isdefined( newinfo.streakname ) )
    {
        if ( storedinfo.streakname == newinfo.streakname && storedinfo.lifeid == newinfo.lifeid )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace mapselect
// Params 0, eflags: 0x4
// Checksum 0x9e784852, Offset: 0x12be
// Size: 0x40
function private mapselect_watchdeath()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"death" );
        self.pers[ "startedMapSelect" ] = [];
    }
}

// Namespace mapselect
// Params 1, eflags: 0x4
// Checksum 0xb720e163, Offset: 0x1306
// Size: 0x74
function private mapselect_getid( info )
{
    var_c9183273cee4c209 = undefined;
    
    if ( isdefined( info.staticdata ) )
    {
        var_c9183273cee4c209 = info.staticdata.ref;
    }
    else if ( isdefined( info.streakname ) )
    {
        var_c9183273cee4c209 = info.streakname;
    }
    
    if ( !isdefined( var_c9183273cee4c209 ) )
    {
        /#
            iprintln( "<dev string:x6a>" );
        #/
    }
    
    return var_c9183273cee4c209;
}

// Namespace mapselect
// Params 3
// Checksum 0x94c0d55b, Offset: 0x1383
// Size: 0x100
function waittill_confirm_or_cancel( confirmstring, cancelstring, endstring )
{
    if ( confirmstring != "death" && cancelstring != "death" && endstring != "death" )
    {
        self endon( #"death" );
    }
    
    ent = spawnstruct();
    
    if ( isdefined( confirmstring ) )
    {
        childthread waittill_return( confirmstring, ent );
    }
    
    if ( isdefined( cancelstring ) )
    {
        childthread waittill_return( cancelstring, ent );
    }
    
    if ( isdefined( endstring ) )
    {
        childthread waittill_return( endstring, ent );
    }
    
    ent waittill( #"returned", location, angle, string );
    ent notify( #"die" );
    returninfo = spawnstruct();
    returninfo.location = location;
    returninfo.angles = angle;
    returninfo.string = string;
    return returninfo;
}

// Namespace mapselect
// Params 2, eflags: 0x4
// Checksum 0x9e8b7aa8, Offset: 0x148c
// Size: 0x66
function private waittill_return( confirmstring, ent )
{
    if ( confirmstring != "death" )
    {
        self endon( #"death" );
    }
    
    ent endon( #"die" );
    self waittill( confirmstring, location, angle );
    ent notify( #"returned", location, angle, confirmstring );
}

