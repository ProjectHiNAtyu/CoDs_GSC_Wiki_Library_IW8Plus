// scripts\mp\visibility_mode_mp.gsc  (hash_17ff8fa860ec88dc.gscc) (size: 4727 Bytes / 0x1277 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8dc30790 (2378368912)
// size ...... 4727 (0x1277)
// includes .. 7   (offset: 0x10af)
// strings ... 26  (offset: 0x10e7)
// dev strs .. 0   (offset: 0x1277)
// exports ... 14  (offset: 0xa0f)
// cseg ...... 0x2b5 + 0x75a (0xa0f)
// imports ... 40  (offset: 0xc3f)
// animtree1 . 0   (offset: 0x1277)
// animtree2 . 0   (offset: 0x1277)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\teams;

#namespace visibility_mode_mp;

// Namespace visibility_mode_mp
// Params 0
// Checksum 0xf67e5171, Offset: 0x2d3
// Size: 0x86
function function_fb0d6f33cb09e933()
{
    funcarray = [];
    funcarray[ "shouldRun" ] = &visibilitymode_shouldrun;
    funcarray[ "enableForClient" ] = &visibilitymode_enable;
    funcarray[ "disable" ] = &visibilitymode_disable;
    funcarray[ "checkForDataUpdates" ] = &function_4711e4a6b8fbdb41;
    funcarray[ "getADSWeaponDist" ] = &visibilitymode_getadsweapondist;
    funcarray[ "getTargetArray" ] = &visibilitymode_gettargetarray;
    funcarray[ "outlineOccluded" ] = &visibilitymode_outlineoccluded;
    funcarray[ "toggleDarkBackground" ] = &visibilitymode_toggledarkbackground;
    funcarray[ "updateUnpackValue" ] = &function_c299f6aae35ccaca;
    return funcarray;
}

// Namespace visibility_mode_mp
// Params 0
// Checksum 0x57e659bb, Offset: 0x362
// Size: 0x45
function visibilitymode_shouldrun()
{
    level endon( #"game_ended" );
    
    if ( game_utility_mp::ismlgmatch() || game_utility_mp::isanymlgmatch() )
    {
        return 0;
    }
    
    canrun = istrue( level.gametypebundle.var_cfff08369a1a9e4f );
    return canrun;
}

// Namespace visibility_mode_mp
// Params 3
// Checksum 0x62fec9c4, Offset: 0x3b0
// Size: 0x29
function visibilitymode_enable( client, assetname, prioritygroup )
{
    return outline::outlineenableforplayer( self, client, assetname, prioritygroup );
}

// Namespace visibility_mode_mp
// Params 1
// Checksum 0xc149ba2c, Offset: 0x3e2
// Size: 0x16
function visibilitymode_disable( id )
{
    outline::outlinedisable( id, self );
}

// Namespace visibility_mode_mp
// Params 0
// Checksum 0x8ef11cbd, Offset: 0x400
// Size: 0x29
function visibilitymode_getadsweapondist()
{
    weapon = self getcurrentweapon();
    
    if ( weaponclass( weapon ) == "sniper" )
    {
        return 8192;
    }
    
    return 2048;
}

// Namespace visibility_mode_mp
// Params 1
// Checksum 0x12bdfa8e, Offset: 0x432
// Size: 0xae
function visibilitymode_gettargetarray( client )
{
    friendlyplayers = [];
    enemyplayers = [];
    
    if ( isdefined( client.team ) )
    {
        friendlyplayers = teams::getfriendlyplayers( client.team );
        enemyplayers = teams::getenemyplayers( client.team );
    }
    
    var_1beb5c04c6ccb23e = getdvarint( @"hash_747b9c2796316a9a", 4096 );
    
    if ( isdefined( level.var_e9bce67d0022b869 ) )
    {
        var_1beb5c04c6ccb23e = level.var_e9bce67d0022b869;
    }
    
    aiarray = getaiarrayinradius( client.origin, var_1beb5c04c6ccb23e );
    return arraycombine( friendlyplayers, enemyplayers, aiarray );
}

// Namespace visibility_mode_mp
// Params 2
// Checksum 0x84c62009, Offset: 0x4e9
// Size: 0x1e
function visibilitymode_outlineoccluded( startpoint, endpoint )
{
    return outline::outlineoccluded( startpoint, endpoint );
}

// Namespace visibility_mode_mp
// Params 1
// Checksum 0x1c265c25, Offset: 0x510
// Size: 0x265
function function_c299f6aae35ccaca( unused )
{
    self notify( #"hash_50480948fb8af071" );
    self endon( #"hash_50480948fb8af071" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self.visibilitymode ) )
    {
        self.visibilitymode = spawnstruct();
    }
    
    host = self;
    
    foreach ( player in level.players )
    {
        if ( player ishost() )
        {
            host = player;
            break;
        }
    }
    
    while ( host isclientpaused() )
    {
        waitframe();
    }
    
    self.visibilitymode.enablevalue = self.pers[ "sharedGamerProfiles" ][ "highVisibilityModeEnabled" ];
    self.visibilitymode.outlinevalue = self.pers[ "sharedGamerProfiles" ][ "highVisibilityModeOutlineOnly" ];
    self.visibilitymode.allytypevalue = self.pers[ "sharedGamerProfiles" ][ "highVisibilityModeAllies" ];
    self.visibilitymode.enemytypevalue = self.pers[ "sharedGamerProfiles" ][ "highVisibilityModeEnemies" ];
    self.visibilitymode.neutraltypevalue = self.pers[ "sharedGamerProfiles" ][ "highVisibilityModeNeutrals" ];
    self.visibilitymode.contestedtypevalue = self.pers[ "sharedGamerProfiles" ][ "highVisibilityModeContested" ];
    self.visibilitymode.interactabletypevalue = self.pers[ "sharedGamerProfiles" ][ "highVisibilityModeInteractables" ];
    self.visibilitymode.darkbackgroundvalue = self.pers[ "sharedGamerProfiles" ][ "highVisibilityModeDarkBackground" ];
    self.visibilitymode.var_f267cef642aaada7 = self.pers[ "sharedGamerProfiles" ][ "highVisibilityModeSoundAssist" ];
    visibility_mode::visibilitymode_unpackvalue();
}

// Namespace visibility_mode_mp
// Params 1
// Checksum 0xdcb78a45, Offset: 0x77d
// Size: 0x78
function function_bb0de382d337ed2e( param )
{
    if ( self iscodcaster() )
    {
        return;
    }
    
    utility::function_e16c621f95fe3acf( &function_c299f6aae35ccaca, [ "highVisibilityModeEnabled", "highVisibilityModeOutlineOnly", "highVisibilityModeAllies", "highVisibilityModeEnemies", "highVisibilityModeNeutrals", "highVisibilityModeContested", "highVisibilityModeInteractables", "highVisibilityModeDarkBackground" ] );
    function_c299f6aae35ccaca();
    thread function_c9d0a2248a011804();
}

// Namespace visibility_mode_mp
// Params 0
// Checksum 0x87612036, Offset: 0x7fd
// Size: 0xaa
function function_4711e4a6b8fbdb41()
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.players ) )
    {
        foreach ( player in level.players )
        {
            player function_bb0de382d337ed2e();
        }
    }
    
    level callback::add( #"player_connect", &function_bb0de382d337ed2e );
}

// Namespace visibility_mode_mp
// Params 1
// Checksum 0xc162b0d, Offset: 0x8af
// Size: 0x89
function visibilitymode_toggledarkbackground( intoggle )
{
    if ( intoggle )
    {
        if ( isvisionsetloaded( "accessibility_nosaturation" ) )
        {
            self visionsetnakedforplayer( "accessibility_nosaturation", 1 );
        }
        
        pbgpostfxbundlestart( self, %"cer_vismode_nosaturation" );
        val::set( "accessibility_darkbackground", "reduce_damage_effects", 1 );
        val::set( "accessibility_darkbackground", "whizby", 0 );
        return;
    }
    
    self visionsetnakedforplayer( "", 1 );
    pbgpostfxbundlekill( self, %"cer_vismode_nosaturation" );
    val::reset_all( "accessibility_darkbackground" );
}

// Namespace visibility_mode_mp
// Params 0
// Checksum 0x6850e205, Offset: 0x940
// Size: 0x13, Type: bool
function function_ee2a94369ecfe4d2()
{
    if ( gettime() - 1000 <= 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace visibility_mode_mp
// Params 0, eflags: 0xc
// Checksum 0x615822c8, Offset: 0x95c
// Size: 0xb3
function private function_c9d0a2248a011804()
{
    self notify( #"hash_18e8c282317a3458" );
    self endon( #"hash_18e8c282317a3458" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( level.visibilitymode.funcs[ "toggleCheckData" ] ) )
    {
        while ( true )
        {
            if ( self [[ level.visibilitymode.funcs[ "toggleCheckData" ] ]]() )
            {
                if ( isdefined( level.visibilitymode.funcs[ "updateUnpackValue" ] ) )
                {
                    self [[ level.visibilitymode.funcs[ "updateUnpackValue" ] ]]();
                }
            }
            
            wait 1;
        }
    }
}

