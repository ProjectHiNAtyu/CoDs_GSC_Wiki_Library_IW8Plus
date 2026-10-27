// scripts\mp\ob\systems\ob_nightmare_shard.gsc  (hash_731b5da57123a505.gscc) (size: 9806 Bytes / 0x264e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x16fc31a3 (385626531)
// size ...... 9806 (0x264e)
// includes .. 9   (offset: 0x23f6)
// strings ... 21  (offset: 0x243e)
// dev strs .. 16  (offset: 0x258a)
// exports ... 22  (offset: 0x16d6)
// cseg ...... 0x25b + 0x147b (0x16d6)
// imports ... 82  (offset: 0x1a46)
// animtree1 . 0   (offset: 0x264e)
// animtree2 . 0   (offset: 0x264e)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\spatial_grid;
#using scripts\common\string;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\interaction;

#namespace ob_nightmare_shard;

// Namespace ob_nightmare_shard
// Params 0, eflags: 0x5
// Checksum 0x80304379, Offset: 0x279
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ob_nightmare_shard", undefined, undefined, &init_nightmare_shards );
}

// Namespace ob_nightmare_shard
// Params 0
// Checksum 0x83bc6c62, Offset: 0x29a
// Size: 0x36c
function init_nightmare_shards()
{
    if ( !ob::nightmare_shard() )
    {
        return;
    }
    
    ob_settings = ob::get_ob_settings();
    
    if ( ob_settings.var_aab22481530ff9ff )
    {
        return;
    }
    
    spatial_grid::create_category( "nightmare_shard", 0, 1 );
    level.nightmare_shard_update_throttle = throttle::throttle_initialize( "nightmare_shard_update", 1, level.framedurationseconds, 32 );
    level.var_94bd1baad9e21bb6 = [];
    utility::add_fx( "vfx_sat_wc_gameplay_nightmare_shards_01", "vfx_sat_wc_gameplay_nightmare_shards_01" );
    utility::add_fx( "vfx_sat_wc_gameplay_nightmare_shards_01_spent", "vfx_sat_wc_gameplay_nightmare_shards_01_spent" );
    utility::add_fx( "vfx_sat_wc_gameplay_nightmare_shards_collect_01", "vfx_sat_wc_gameplay_nightmare_shards_collect_01" );
    level.nightmareshards = [];
    shardstructs = utility::getstructarray( "ob_nightmare_shard", "targetname" );
    
    foreach ( struct in shardstructs )
    {
        assert( utility::function_e4e418bde2160c35( struct.script_noteworthy ), "<dev string:x24>" );
        idnum = int( struct.script_noteworthy );
        id = string::to_string( idnum );
        activeid = "nightmare_shard_active_" + id;
        inactiveid = "nightmare_shard_inactive_" + id;
        assert( !level.nightmareshards[ activeid ] && !level.nightmareshards[ inactiveid ], "<dev string:x5e>" + idnum + "<dev string:x7e>" );
        var_9ddc6081582235fd = structcopy( struct, 1 );
        inactivestruct = structcopy( struct, 1 );
        updateradius = struct.var_a9c48f59c5f2389a;
        var_9ddc6081582235fd function_3d67696b8c74192a( activeid, idnum, utility::getfx( "vfx_sat_wc_gameplay_nightmare_shards_01" ), ( 0, 0, 10 ), ( 0, 0, 10 ), updateradius, undefined, 64, &function_dd48a22b4ed6bab, &"sat_ob/collect_nm_shard" );
        inactivestruct function_3d67696b8c74192a( inactiveid, idnum, utility::getfx( "vfx_sat_wc_gameplay_nightmare_shards_01_spent" ), ( 0, 0, 10 ), ( 0, 0, 10 ), updateradius );
        level.nightmareshards[ activeid ] = var_9ddc6081582235fd;
        level.nightmareshards[ inactiveid ] = inactivestruct;
        
        if ( isnumber( updateradius ) && updateradius > 2048 )
        {
            level.var_94bd1baad9e21bb6[ activeid ] = var_9ddc6081582235fd;
            level.var_94bd1baad9e21bb6[ inactiveid ] = inactivestruct;
        }
    }
    
    callback::add( #"player_connect", &nightmare_shard_onplayerconnect );
    utility::registersharedfunc( #"hash_561b73e89e879cb7", #"hash_bc299ecad4d99dcc", &function_a5131162cc4215cc );
    assert( level.nightmareshards.size == 100, "<dev string:x8f>" + 50 + "<dev string:xa6>" );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_71ee52fc1a696852", &function_f834288ed7f4c7bc );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_f7bbfd6c69c317", &function_aea8cac388f5ec79 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_92def64becb968f3", &function_60909aca3a3966b6 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_5ef53f48c8cfe1f", &function_4d6b1c7b06f87683 );
}

// Namespace ob_nightmare_shard
// Params 1, eflags: 0x4
// Checksum 0xf4958c95, Offset: 0x60e
// Size: 0x83
function private function_2893ff5ee508b10e( data )
{
    self endon( #"disconnect" );
    
    if ( isnumber( data ) )
    {
        logstring( "[OB_NIGHTMARE_SHARD] Saving collecting progression of [" + data + "] for player [" + self.name + "]" );
        self setplayerdata( level.var_6f9b00680ed002d8, "nmShards", data, 1 );
    }
    
    waitframe();
    
    if ( self )
    {
        self function_432458e83a394206( 3 );
        logstring( "[OB_NIGHTMARE_SHARD] Commit player data of [" + self.name + "]" );
    }
}

// Namespace ob_nightmare_shard
// Params 1, eflags: 0x4
// Checksum 0xa3c48588, Offset: 0x699
// Size: 0x13
function private nightmare_shard_onplayerconnect( params )
{
    thread function_bcee91f543c8f3be();
}

// Namespace ob_nightmare_shard
// Params 0, eflags: 0x4
// Checksum 0x4c797f0f, Offset: 0x6b4
// Size: 0x32f
function private function_bcee91f543c8f3be()
{
    level endon( #"game_ended" );
    guid = self.guid;
    structrecord = [];
    
    while ( self && self isconnected() )
    {
        var_92333da546b5840 = [];
        nearbystructs = spatial_grid::query( "nightmare_shard", self.origin, 2048 );
        
        foreach ( struct in level.var_94bd1baad9e21bb6 )
        {
            if ( struct.forceupdate || distance( self.origin, struct.origin ) < struct.updateradius )
            {
                nearbystructs[ nearbystructs.size ] = struct;
            }
        }
        
        /#
            function_3bcad145da12f0a7( nearbystructs );
        #/
        
        foreach ( struct in nearbystructs )
        {
            if ( !structrecord[ struct.id ] )
            {
                struct nightmare_shard_updatestatus( self, struct function_2b6107074e525785( self ) );
            }
            
            var_92333da546b5840[ struct.id ] = struct;
            structrecord[ struct.id ] = undefined;
        }
        
        foreach ( struct in structrecord )
        {
            struct nightmare_shard_updatestatus( self, 0 );
        }
        
        structrecord = var_92333da546b5840;
        throttle::throttle_wait_in_queue( level.nightmare_shard_update_throttle, self );
        waitframe();
    }
    
    foreach ( struct in structrecord )
    {
        struct.activeplayers[ guid ] = undefined;
        struct.activeplayers = function_f943bef551ff028c( struct.activeplayers );
        
        if ( struct.activeplayers.size == 0 )
        {
            if ( struct.fxent )
            {
                struct.fxent delete();
                struct.fxent = undefined;
            }
            
            if ( struct.interactent )
            {
                struct.interactent delete();
                struct.interactent = undefined;
            }
        }
    }
}

// Namespace ob_nightmare_shard
// Params 2, eflags: 0x4
// Checksum 0xffe185a5, Offset: 0x9eb
// Size: 0x8a
function private nightmare_shard_updatestatus( player, shouldactivate )
{
    if ( shouldactivate )
    {
        self.activeplayers[ player.guid ] = player;
        updatefxent( player, 1 );
        function_fc11551f81c68ef6( player, 1 );
        return;
    }
    
    self.activeplayers[ player.guid ] = undefined;
    self.activeplayers = function_f943bef551ff028c( self.activeplayers );
    updatefxent( player, 0 );
    function_fc11551f81c68ef6( player, 0 );
}

// Namespace ob_nightmare_shard
// Params 1, eflags: 0x4
// Checksum 0xfd4411f0, Offset: 0xa7d
// Size: 0x11b
function private function_dd48a22b4ed6bab( player )
{
    struct = isent( self ) ? self.struct : self;
    interactent = isent( self ) ? self : self.interactent;
    
    /#
        player thread function_e548035f9b31d373( player.name + "<dev string:xc4>" + struct.playerdataid );
    #/
    
    if ( interactent )
    {
        interactent disableplayeruse( player );
    }
    
    player thread function_2893ff5ee508b10e( struct.playerdataid );
    player thread function_872c7b07b80b8869( utility::getfx( "vfx_sat_wc_gameplay_nightmare_shards_collect_01" ), struct.origin, struct.angles, 3 );
    wait 0.2;
    level.nightmareshards[ "nightmare_shard_inactive_" + struct.playerdataid ] nightmare_shard_updatestatus( player, 1 );
    wait 0.1;
    struct nightmare_shard_updatestatus( player, 0 );
    level callback::callback( "ob_nightmare_shard_collected", { #player:player } );
}

// Namespace ob_nightmare_shard
// Params 12, eflags: 0x4
// Checksum 0x15daa30b, Offset: 0xba0
// Size: 0x160
function private function_3d67696b8c74192a( id, playerdataid, fxid, interactionoffset, vfxoffset, updateradius, model, radius, var_c4ae90cc4b070cb7, hintstring, var_6d47f89a1e72fd2f = undefined, forceupdate )
{
    self.id = id;
    self.playerdataid = playerdataid;
    self.fxid = fxid;
    self.interactionoffset = interactionoffset ?? ( 0, 0, 0 );
    self.vfxoffset = vfxoffset ?? ( 0, 0, 0 );
    self.updateradius = updateradius;
    self.interactmodel = model;
    self.interactradius = radius;
    self.var_c4ae90cc4b070cb7 = var_c4ae90cc4b070cb7;
    self.var_6d47f89a1e72fd2f = var_6d47f89a1e72fd2f;
    self.hintstring = hintstring;
    self.activeplayers = [];
    self.var_789b7a49ee864fec = undefined;
    self.forceupdate = forceupdate;
    
    if ( !self.forceupdate && !( isnumber( updateradius ) && updateradius > 2048 ) )
    {
        spatial_grid::add( "nightmare_shard", self );
    }
}

// Namespace ob_nightmare_shard
// Params 2, eflags: 0x4
// Checksum 0xc1a79303, Offset: 0xd08
// Size: 0x174
function private function_fc11551f81c68ef6( player, shouldactivate )
{
    if ( !self.var_c4ae90cc4b070cb7 )
    {
        return;
    }
    
    if ( shouldactivate )
    {
        if ( !self.interactent )
        {
            self.interactent = interaction::register_interact( self.origin + self.interactionoffset, self.interactradius, self.var_c4ae90cc4b070cb7, self.hintstring, undefined, undefined, undefined, "HINT_BUTTON" );
            self.interactent.angles = self.angles;
            self.interactent.struct = self;
            self.interactent setusableenabled( 1 );
            
            if ( self.interactmodel )
            {
                self.interactent setmodel( self.interactmodel );
            }
            
            self.interactent hide();
            self.interactent disableplayeruseforallplayers();
        }
        
        self.interactent showtoplayer( player );
        self.interactent enableplayeruse( player );
        return;
    }
    
    if ( self.interactent )
    {
        if ( self.activeplayers.size == 0 )
        {
            self.interactent delete();
            self.interactent = undefined;
            return;
        }
        
        self.interactent hidefromplayer( player );
        self.interactent disableplayeruse( player );
    }
}

// Namespace ob_nightmare_shard
// Params 2, eflags: 0x4
// Checksum 0x4d6e0023, Offset: 0xe84
// Size: 0xed
function private updatefxent( player, shouldactivate )
{
    if ( !self.fxid )
    {
        return;
    }
    
    if ( shouldactivate )
    {
        if ( !self.fxent )
        {
            self.fxent = spawnfx( self.fxid, self.origin + self.vfxoffset, anglestoforward( self.angles ), anglestoup( self.angles ) );
            triggerfx( self.fxent );
            self.fxent hide();
        }
        
        self.fxent showtoplayer( player );
        return;
    }
    
    if ( self.fxent )
    {
        if ( self.activeplayers.size == 0 )
        {
            self.fxent delete();
            self.fxent = undefined;
            return;
        }
        
        self.fxent hidefromplayer( player );
    }
}

// Namespace ob_nightmare_shard
// Params 1, eflags: 0x4
// Checksum 0x80c95090, Offset: 0xf79
// Size: 0x77
function private function_2b6107074e525785( player )
{
    if ( issubstr( self.id, "nightmare_shard_active_" ) )
    {
        return !player getplayerdata( level.var_6f9b00680ed002d8, "nmShards", self.playerdataid );
    }
    else if ( issubstr( self.id, "nightmare_shard_inactive_" ) )
    {
        return player getplayerdata( level.var_6f9b00680ed002d8, "nmShards", self.playerdataid );
    }
    
    return 0;
}

// Namespace ob_nightmare_shard
// Params 4, eflags: 0x4
// Checksum 0xd8d097e0, Offset: 0xff9
// Size: 0x76
function private function_872c7b07b80b8869( fxid, origin, angles, duration )
{
    level endon( #"game_ended" );
    fxent = spawnfx( fxid, origin, anglestoforward( angles ), anglestoup( angles ) );
    fxent hide();
    fxent showtoplayer( self );
    triggerfx( fxent );
    wait duration ?? 0;
    fxent delete();
}

// Namespace ob_nightmare_shard
// Params 0, eflags: 0x4
// Checksum 0xa9297863, Offset: 0x1077
// Size: 0x45
function private function_a5131162cc4215cc()
{
    collectedshards = 0;
    
    for ( i = 0; i < 50 ; i++ )
    {
        if ( self getplayerdata( level.var_6f9b00680ed002d8, "nmShards", i ) )
        {
            collectedshards++;
        }
    }
    
    return collectedshards;
}

// Namespace ob_nightmare_shard
// Params 1
// Checksum 0xac1c925a, Offset: 0x10c5
// Size: 0xaa
function function_f834288ed7f4c7bc( params )
{
    debugtext = "";
    
    for ( i = 0; i < 50 ; i++ )
    {
        hasshard = self getplayerdata( level.var_6f9b00680ed002d8, "nmShards", i );
        debugtext += i + ": " + hasshard + "  ";
        
        if ( ( i + 1 ) % 5 == 0 )
        {
            debugtext += "\n";
        }
    }
    
    /#
        thread function_e548035f9b31d373( debugtext );
    #/
    
    logstring( "[OB_NIGHTMARE_SHARD] " + self.name + "\n" + debugtext );
}

// Namespace ob_nightmare_shard
// Params 1
// Checksum 0xa0cc65b3, Offset: 0x1177
// Size: 0xab
function function_aea8cac388f5ec79( params )
{
    shardsnum = int( params[ 0 ] );
    collectedshards = 0;
    
    for ( i = 0; i < 50 ; i++ )
    {
        if ( !self getplayerdata( level.var_6f9b00680ed002d8, "nmShards", i ) )
        {
            level.nightmareshards[ "nightmare_shard_active_" + i ] function_dd48a22b4ed6bab( self );
            collectedshards++;
            
            if ( collectedshards == shardsnum )
            {
                break;
            }
        }
    }
    
    /#
        thread function_e548035f9b31d373( "<dev string:xe5>" + self.name + "<dev string:xed>" + collectedshards + "<dev string:xf9>" );
    #/
}

// Namespace ob_nightmare_shard
// Params 1
// Checksum 0x40dfda36, Offset: 0x122a
// Size: 0x4f
function function_60909aca3a3966b6( params )
{
    shardid = params[ 0 ];
    teleportshard = level.nightmareshards[ "nightmare_shard_active_" + shardid ];
    
    if ( teleportshard )
    {
        self setorigin( teleportshard.origin, 1 );
    }
}

// Namespace ob_nightmare_shard
// Params 1, eflags: 0x4
// Checksum 0x5125c585, Offset: 0x1281
// Size: 0x18
function private function_4d6b1c7b06f87683( params )
{
    /#
        thread function_5054f9993a3d2d8a( params );
    #/
}

/#

    // Namespace ob_nightmare_shard
    // Params 1
    // Checksum 0x77f64422, Offset: 0x12a1
    // Size: 0xe3, Type: dev
    function function_e548035f9b31d373( text )
    {
        self notify( #"hash_641aa18a3e150391" );
        self endon( #"hash_641aa18a3e150391" );
        level endon( #"game_ended" );
        self endon( #"disconnect" );
        
        if ( !self.var_240eaa56102c75d7 )
        {
            hud = newclienthudelem( self );
            hud.x = 400;
            hud.y = 100;
            hud.foreground = 1;
            hud.color = ( 0, 0, 1 );
            hud.fontscale = 1.5;
            self.var_240eaa56102c75d7 = hud;
        }
        
        self.var_240eaa56102c75d7 setdevtext( text );
        wait 5;
        self.var_240eaa56102c75d7 setdevtext( "<dev string:x10b>" );
    }

    // Namespace ob_nightmare_shard
    // Params 1, eflags: 0x4
    // Checksum 0xd666efe7, Offset: 0x138c
    // Size: 0xc2, Type: dev
    function private function_3bcad145da12f0a7( array )
    {
        newarray = [];
        
        foreach ( struct in array )
        {
            if ( newarray[ struct.id ] )
            {
                assertmsg( "<dev string:x10c>" + struct.id + "<dev string:x133>" );
            }
            
            newarray[ struct.id ] = struct;
        }
    }

    // Namespace ob_nightmare_shard
    // Params 1, eflags: 0xc
    // Checksum 0x1832b573, Offset: 0x1456
    // Size: 0x192, Type: dev
    function private function_5054f9993a3d2d8a( params )
    {
        self notify( #"hash_d96d21d07de93952" );
        self endon( #"hash_d96d21d07de93952" );
        me = isplayer( self ) ? self : level.players[ 0 ];
        
        if ( !me )
        {
            return;
        }
        
        if ( level.var_cc33894a2bc27161 )
        {
            level.var_cc33894a2bc27161 = 0;
            return;
        }
        
        level.var_cc33894a2bc27161 = 1;
        
        while ( true )
        {
            if ( !me )
            {
                break;
            }
            
            foreach ( shardstruct in level.nightmareshards )
            {
                ispicked = me getplayerdata( level.var_6f9b00680ed002d8, "<dev string:x14b>", shardstruct.playerdataid );
                isactivetarget = 0;
                
                if ( issubstr( shardstruct.id, "<dev string:x154>" ) )
                {
                    isactivetarget = 1;
                }
                
                if ( ispicked && isactivetarget || !ispicked && !isactivetarget )
                {
                    me function_bcbe45b27ab30c35( shardstruct, shardstruct.id, ispicked ? ( 0, 1, 0 ) : ( 1, 0, 0 ) );
                }
            }
            
            waitframe();
        }
    }

    // Namespace ob_nightmare_shard
    // Params 4, eflags: 0x4
    // Checksum 0x9dc0a28c, Offset: 0x15f0
    // Size: 0xe6, Type: dev
    function private function_bcbe45b27ab30c35( target, print_text, color, sphere_radius )
    {
        if ( !isdefined( print_text ) )
        {
            print_text = "<dev string:x10b>";
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 0, 0 );
        }
        
        if ( !isdefined( sphere_radius ) )
        {
            sphere_radius = 4;
        }
        
        if ( !target || !target.origin || !self )
        {
            return 0;
        }
        
        line( self.origin, target.origin, color );
        sphere( target.origin, sphere_radius, color );
        print3d( target.origin, print_text + "<dev string:x16c>" + length( target.origin - self.origin ) + "<dev string:x16f>", color, 1, 0.5, 1, 1 );
        return 1;
    }

#/
