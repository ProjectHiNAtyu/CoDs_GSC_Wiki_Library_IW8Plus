// scripts\mp\frontendwalkablespace.gsc  (hash_20e92417d970977d.gscc) (size: 21774 Bytes / 0x550e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd624fb1c (3592747804)
// size ...... 21774 (0x550e)
// includes .. 7   (offset: 0x507a)
// strings ... 57  (offset: 0x50b2)
// dev strs .. 11  (offset: 0x547a)
// exports ... 43  (offset: 0x350a)
// cseg ...... 0x443 + 0x30c7 (0x350a)
// imports ... 163 (offset: 0x3bc2)
// animtree1 . 1   (offset: 0x54fe)
// animtree2 . 0   (offset: 0x550e)
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\common\utility\backpack;
#using scripts\mp\common\utility\scriptable_door_utility;
#using scripts\mp\common\utility\streamhint;
#using scripts\mp\frontendplayerutils;
#using scripts\mp\frontendutils;

#namespace frontendwalkablespace;

// Namespace frontendwalkablespace
// Params 3
// Checksum 0xf0a00148, Offset: 0x461
// Size: 0x12d
function fadetoblackforplayer( player, fadetoblack, fadetime )
{
    player notify( #"start_fade_to_black" );
    player endon( #"start_fade_to_black" );
    player endon( #"disconnect" );
    assert( !isdefined( fadetime ) || fadetime >= 0, "<dev string:x24>" );
    fadealpha = 0;
    
    if ( fadetoblack )
    {
        fadealpha = 1;
    }
    
    if ( !isdefined( fadetime ) || fadetime == 0 )
    {
        setomnvar( "ui_fob_loading_progress", fadealpha );
        return;
    }
    
    finalalpha = fadealpha;
    fadealpha = 0;
    fadetimecounter = int( fadetime / level.framedurationseconds );
    fadechange = 1 / fadetimecounter;
    
    if ( !fadetoblack )
    {
        fadechange *= -1;
        fadealpha = 1;
    }
    
    while ( fadetimecounter > 0 )
    {
        fadealpha += fadechange;
        
        if ( !isdefined( player ) || !player isconnected() )
        {
            return;
        }
        
        setomnvar( "ui_fob_loading_progress", fadealpha );
        fadetimecounter--;
        waitframe();
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    setomnvar( "ui_fob_loading_progress", finalalpha );
    player notify( #"finish_fade_to_black" );
}

// Namespace frontendwalkablespace
// Params 2
// Checksum 0xae7cb75c, Offset: 0x596
// Size: 0x25
function function_2a0ac7d9080f76f( player, enable )
{
    player allowfire( enable );
    player allowads( enable );
}

// Namespace frontendwalkablespace
// Params 0
// Checksum 0xb583d699, Offset: 0x5c3
// Size: 0x93
function function_54ffe751a4300210()
{
    doors = scriptable_door_utility::scriptable_door_get_in_radius( self.origin, 512, 1000 );
    
    foreach ( door in doors )
    {
        door scriptabledoorfreeze( 1 );
    }
}

// Namespace frontendwalkablespace
// Params 0, eflags: 0x4
// Checksum 0x52badfe1, Offset: 0x65e
// Size: 0x5c
function private function_fd048ed205a845()
{
    if ( isdefined( self.primaryweaponobj ) )
    {
        if ( self hasweapon( self.primaryweaponobj ) )
        {
            self takeweapon( self.primaryweaponobj );
        }
    }
    
    if ( isdefined( self.secondaryweaponobj ) )
    {
        if ( self hasweapon( self.secondaryweaponobj ) )
        {
            self takeweapon( self.secondaryweaponobj );
        }
    }
}

// Namespace frontendwalkablespace
// Params 0, eflags: 0x4
// Checksum 0xbb061d97, Offset: 0x6c2
// Size: 0x6b
function private function_8c7a5b2867bde7()
{
    if ( !( isdefined( self.primaryweaponobj ) && isdefined( self.secondaryweaponobj ) ) )
    {
        namespace_285f2d8d2827221c::update_player_weapon();
    }
    
    if ( isdefined( self.primaryweaponobj ) )
    {
        self giveweapon( self.primaryweaponobj );
    }
    
    if ( isdefined( self.secondaryweaponobj ) )
    {
        self giveweapon( self.secondaryweaponobj );
    }
    
    self switchtoweaponimmediate( self.primaryweaponobj );
}

// Namespace frontendwalkablespace
// Params 2, eflags: 0x40 variadic
// Checksum 0x1cc9e924, Offset: 0x735
// Size: 0xa0
function function_3a7b44bf752c4ecd( ... )
{
    self function_cb8df376b3e57420();
    bodymodelname = self getcustomizationbody();
    headmodelname = self getcustomizationhead();
    viewmodelname = self getcustomizationviewmodel();
    self setmodel( bodymodelname );
    self setviewmodel( viewmodelname );
    
    if ( isdefined( headmodelname ) )
    {
        self attach( headmodelname, "", 1 );
        self.headmodel = headmodelname;
    }
    
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setnormalhealth( 1 );
}

// Namespace frontendwalkablespace
// Params 2, eflags: 0x40 variadic
// Checksum 0x2814c1f4, Offset: 0x7dd
// Size: 0xa4
function function_93b1960c20cec5f8( ... )
{
    level.var_517e48b44ae4d567 = 1;
    setomnvar( "ui_fob_loading_progress", 0.1 );
    spawn = findspawn();
    function_3a7b44bf752c4ecd();
    self.pers[ "streamSyncComplete" ] = 1;
    println( "<dev string:x58>" );
    streamhint::playerstreamhintlocation( spawn.origin, 50000 );
    fadetoblackforplayer( self, 1, 0 );
    streamhint::playerwaittillstreamhintcomplete();
    fadetoblackforplayer( self, 0, 0.5 );
    self setnormalhealth( 1 );
}

// Namespace frontendwalkablespace
// Params 0, eflags: 0x4
// Checksum 0x3d57555d, Offset: 0x889
// Size: 0x36c
function private findspawn()
{
    if ( level.playerspawnents.size )
    {
        players = getentarraybytype( createentitytypemask( [ "etype_player" ] ), 1 );
        
        foreach ( player in players )
        {
            if ( player.sessionstate != "playing" || distance( player.origin, ( 0, 0, 0 ) ) < 0.1 )
            {
                continue;
            }
            
            foreach ( spawnent in level.playerspawnents )
            {
                distance = distance( player.origin, spawnent.origin );
                
                if ( spawnent.closestdistance )
                {
                    spawnent.closestdistance = min( spawnent.closestdistance, distance );
                    continue;
                }
                
                spawnent.closestdistance = distance;
            }
        }
        
        var_6d1a54a5bfbb0314 = level.playerspawnents[ 0 ];
        
        foreach ( spawnent in level.playerspawnents )
        {
            if ( spawnent.closestdistance > var_6d1a54a5bfbb0314.closestdistance )
            {
                var_6d1a54a5bfbb0314 = spawnent;
            }
        }
        
        foreach ( spawnent in level.playerspawnents )
        {
            spawnent.closestdistance = undefined;
        }
        
        groundpos = utility::groundpos( var_6d1a54a5bfbb0314.origin );
        spawnangles = var_6d1a54a5bfbb0314.angles;
        return { #angles:spawnangles, #origin:groundpos };
    }
    
    if ( level.sectionarray[ "frontendwalkablescene" ] )
    {
        groundpos = utility::groundpos( level.sectionarray[ "frontendwalkablescene" ].basecam.origin );
        return { #angles:level.sectionarray[ "frontendwalkablescene" ].basecam.angles, #origin:groundpos };
    }
}

// Namespace frontendwalkablespace
// Params 0
// Checksum 0xcd3fa63c, Offset: 0xbfd
// Size: 0xda
function frontend_spawnplayer()
{
    println( "<dev string:x70>" );
    self.guid = 0;
    self.team = "allies";
    self.var_fa63a83936634b3 = 1;
    self function_cb8df376b3e57420();
    spawn = findspawn();
    
    if ( !level.var_517e48b44ae4d567 )
    {
        function_3a7b44bf752c4ecd();
    }
    
    self spawn( spawn.origin, spawn.angles );
    self setnormalhealth( 1 );
    waitframe();
    function_8c7a5b2867bde7();
    function_1b6fa013c0c2b251( 0 );
    setmusicstate( "" );
    self setcamerathirdperson( 1 );
    function_2a0ac7d9080f76f( self, 0 );
    function_54ffe751a4300210();
    self setmoveset( "rex_fob" );
    level.player = self;
    thread infiniteammo();
    
    /#
        thread watchufo();
    #/
}

// Namespace frontendwalkablespace
// Params 6, eflags: 0x4
// Checksum 0xeba40d3, Offset: 0xcdf
// Size: 0x6f
function private function_59c3f2207c0c8735( instance, part, state, player, bautouse, usestring )
{
    if ( isdefined( instance ) && state != "objectivedisable" )
    {
        setomnvar( "ui_walkable_scene_trigger_index", instance.triggerindex );
        wait 2;
        setomnvar( "ui_walkable_scene_trigger_index", -1 );
    }
}

// Namespace frontendwalkablespace
// Params 3, eflags: 0x40 variadic
// Checksum 0xb9f2f902, Offset: 0xd56
// Size: 0x9e
function function_42cec6872280e398( stateinfo, ... )
{
    var_f5eb361fd2d11f7e = strtok( stateinfo, "/" );
    var_f5eb361fd2d11f7e = strtok( stateinfo, "+" );
    
    if ( isdefined( var_f5eb361fd2d11f7e ) )
    {
        scriptablename = var_f5eb361fd2d11f7e[ 0 ];
        scriptablestate = var_f5eb361fd2d11f7e[ 1 ];
        
        if ( isdefined( scriptablename ) && isdefined( level.scriptables[ scriptablename ] ) )
        {
            scriptable = level.scriptables[ scriptablename ][ "scriptable" ];
            scriptable setscriptablepartstate( scriptablename, scriptablestate );
        }
    }
}

// Namespace frontendwalkablespace
// Params 2, eflags: 0x4
// Checksum 0x88c5d79a, Offset: 0xdfc
// Size: 0x9d
function private setstate( scriptablename, luastate )
{
    state = undefined;
    
    if ( luastate == "1" )
    {
        state = "objective";
    }
    else if ( luastate == "2" )
    {
        state = "objectivedisable";
    }
    else if ( luastate == "3" )
    {
        state = "objectivesplash";
    }
    else if ( luastate == "4" )
    {
        state = "objectivesplashnegative";
    }
    
    if ( state )
    {
        scriptable = level.scriptables[ scriptablename ][ "scriptable" ];
        scriptable setscriptablepartstate( scriptablename, state );
    }
}

// Namespace frontendwalkablespace
// Params 0, eflags: 0x4
// Checksum 0xa6951023, Offset: 0xea1
// Size: 0x4e
function private getunlocks()
{
    sceneinteractables = getgamemodescriptbundle().triggersetup;
    
    if ( sceneinteractables )
    {
        interactables = getscriptbundle( sceneinteractables );
        
        if ( interactables )
        {
            unlocks = interactables.stationnotifications;
            return unlocks;
        }
    }
}

// Namespace frontendwalkablespace
// Params 1
// Checksum 0xe8d4becc, Offset: 0xef8
// Size: 0xec
function function_b14158045d06087d( statestring )
{
    scriptablestates = strtok( statestring, "+" );
    
    if ( scriptablestates )
    {
        index = 0;
        unlocks = getunlocks();
        
        if ( unlocks )
        {
            foreach ( unlock in unlocks )
            {
                scriptablename = unlock.scriptable;
                
                if ( scriptablename )
                {
                    if ( scriptablestates[ index ] )
                    {
                        scriptablestate = scriptablestates[ index ];
                        level thread setstate( scriptablename, scriptablestate );
                    }
                    
                    index++;
                }
            }
        }
    }
}

// Namespace frontendwalkablespace
// Params 0, eflags: 0x4
// Checksum 0x99d4e1b, Offset: 0xfec
// Size: 0x88
function private freescriptables()
{
    foreach ( scriptable in level.scriptables )
    {
        scriptable[ "scriptable" ] freescriptable();
    }
    
    level.var_8210ecbe0122c3c1 = 0;
}

// Namespace frontendwalkablespace
// Params 0, eflags: 0x4
// Checksum 0x24f1a956, Offset: 0x107c
// Size: 0x92
function private function_a371140c854c137c()
{
    if ( isdefined( level.scriptables ) )
    {
        foreach ( scriptablename, scriptable in level.scriptables )
        {
            scriptable[ "scriptable" ] setscriptablepartstate( scriptablename, "visible" );
        }
    }
}

// Namespace frontendwalkablespace
// Params 2, eflags: 0x4
// Checksum 0x67175f3b, Offset: 0x1116
// Size: 0x156
function private function_577a224b91899036( index, scriptabledata )
{
    if ( !level.var_8210ecbe0122c3c1 )
    {
        level.var_8210ecbe0122c3c1 = 1;
    }
    
    if ( !isdefined( scriptabledata.origin ) )
    {
        println( "<dev string:x80>" );
    }
    
    origin = ( scriptabledata.origin.x, scriptabledata.origin.y, scriptabledata.origin.z );
    angles = ( scriptabledata.angles.x, scriptabledata.angles.y, scriptabledata.angles.z );
    scriptable = spawnscriptable( scriptabledata.scriptable, origin, angles );
    scriptable.triggerindex = index;
    level.scriptables[ scriptabledata.scriptable ] = [];
    level.scriptables[ scriptabledata.scriptable ][ "scriptable" ] = scriptable;
    scriptable::scriptable_addusedcallbackbypart( scriptabledata.scriptable, &function_59c3f2207c0c8735 );
}

// Namespace frontendwalkablespace
// Params 11, eflags: 0x4
// Checksum 0x7693aaac, Offset: 0x1274
// Size: 0xf1
function private function_ebb31d7d98dfb99d( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    einflictor.targetshit = einflictor.targetshit ? einflictor.targetshit : [];
    
    if ( !isdefined( instance ) || einflictor.targetshit[ instance.index ] || instance.type != "rex_dmz_fob_generic_target" )
    {
        return;
    }
    
    einflictor setclientomnvar( "ui_walkable_scene_unique_target_shot", gettime() );
    einflictor.targetshit[ instance.index ] = 1;
}

// Namespace frontendwalkablespace
// Params 2, eflags: 0x4
// Checksum 0xf475ba80, Offset: 0x136d
// Size: 0x147
function private function_33f865680e2b80aa( index, trigger )
{
    level.var_e15cbf88b9bdcd36[ trigger.triggerscriptnoteworthy ] = [];
    level.var_e15cbf88b9bdcd36[ trigger.triggerscriptnoteworthy ][ "index" ] = index;
    level.var_e15cbf88b9bdcd36[ trigger.triggerscriptnoteworthy ][ "hintString" ] = trigger.hintstring;
    var_48fd1ee9c66e1448 = trigger.var_48fd1ee9c66e1448;
    triggerent = frontendutils::frontend_camera_get_entity( var_48fd1ee9c66e1448 );
    
    if ( isdefined( triggerent ) )
    {
        triggerent.var_33f76c2d569e4abf = 0;
        triggerent.triggerindex = index;
        triggerhint = spawn( "script_origin", triggerent.origin );
        triggerhint makeusable();
        triggerhintstring = level.var_e15cbf88b9bdcd36[ triggerent.script_noteworthy ][ "hintString" ];
        
        if ( isdefined( triggerhintstring ) )
        {
            triggerhint sethintstring( triggerhintstring );
            triggerhint sethintdisplayrange( 55 );
            triggerhint setuserange( 55 );
            triggerhint setcursorhint( "hint_noicon" );
            triggerhint sethintonobstruction( "show" );
        }
        
        triggerent thread function_e18f0c39f1cd958d( self );
    }
}

// Namespace frontendwalkablespace
// Params 2, eflags: 0x4
// Checksum 0x381901b5, Offset: 0x14bc
// Size: 0x19b
function private function_6824b990b7a1ad67( index, modeldata )
{
    level.models[ modeldata.triggerscriptnoteworthy ] = [];
    level.models[ modeldata.triggerscriptnoteworthy ][ "index" ] = index;
    level.var_3a0027efc54b67b0[ modeldata.triggerscriptnoteworthy ][ "hintString" ] = modeldata.hintstring;
    origin = ( modeldata.origin.x, modeldata.origin.y, modeldata.origin.z );
    angles = ( modeldata.angles.x, modeldata.angles.y, modeldata.angles.z );
    model = spawn( "script_model", origin, angles );
    model setmodel( modeldata.model );
    model.triggerindex = index;
    model makeusable();
    triggerhintstring = modeldata.hintstring;
    
    if ( isdefined( triggerhintstring ) )
    {
        model sethintstring( triggerhintstring );
        model sethintdisplayrange( 55 );
        model setuserange( 55 );
        model setcursorhint( "hint_noicon" );
        model sethintonobstruction( "show" );
    }
    
    model thread function_e18f0c39f1cd958d( self );
}

// Namespace frontendwalkablespace
// Params 0, eflags: 0x4
// Checksum 0xe613940f, Offset: 0x165f
// Size: 0x157
function private function_9041fe4c904cfed5()
{
    sceneinteractables = getgamemodescriptbundle().triggersetup;
    
    if ( isdefined( sceneinteractables ) )
    {
        interactables = getscriptbundle( sceneinteractables );
        
        if ( isdefined( interactables ) )
        {
            if ( !isdefined( level.var_e15cbf88b9bdcd36 ) )
            {
                level.var_e15cbf88b9bdcd36 = [];
                level.scriptables = [];
                level.models = [];
            }
            
            index = 1;
            
            foreach ( interactable in interactables.triggerdata )
            {
                interactablesetup = 0;
                
                if ( interactable.scriptable )
                {
                    function_577a224b91899036( index, interactable );
                    interactablesetup = 1;
                }
                
                if ( interactable.model )
                {
                    function_6824b990b7a1ad67( index, interactable );
                    interactablesetup = 1;
                }
                
                if ( isdefined( interactable.var_48fd1ee9c66e1448 ) )
                {
                    function_33f865680e2b80aa( index, interactable );
                    interactablesetup = 1;
                }
                
                if ( interactablesetup == 0 )
                {
                    println( "<dev string:xb8>" );
                }
                
                index++;
            }
        }
    }
}

// Namespace frontendwalkablespace
// Params 1
// Checksum 0x6aa8213, Offset: 0x17be
// Size: 0x145
function function_867cd6025b5f3ea7( var_1d92d20a5f2943f7 )
{
    if ( !level.twinheli )
    {
        struct = utility::getstruct( "twin_heli_spawn", "script_noteworthy" );
        
        if ( struct )
        {
            level.twinheli = spawn( "script_model", struct.origin );
            level.twinheli setmodel( %"hash_1e78afca23f80a1c" );
            level.twinheli setscriptablepartstate( "engine", "off" );
            level.twinheli.angles = struct.angles;
        }
    }
    
    function_95437b3e5726ad89();
    level.var_84937cfb956d7c1d = ( var_1d92d20a5f2943f7 & 1 ) == 1;
    println( "<dev string:x119>" );
    suitname = utility::function_f825237e0eda5adf();
    self setsuit( suitname );
    println( "<dev string:x126>" );
    self.sessionstate = "playing";
    self.statusicon = "";
    waitframe();
    self.settospectate = 0;
    frontend_spawnplayer();
    function_9041fe4c904cfed5();
    function_a371140c854c137c();
    function_6962d43f0cfea5ad();
    scriptable::scriptable_adddamagedcallback( &function_ebb31d7d98dfb99d );
    
    /#
        level thread function_705b4195098d6c64();
    #/
}

// Namespace frontendwalkablespace
// Params 1
// Checksum 0x64d27ec1, Offset: 0x190b
// Size: 0x1d
function function_cc28f6ed811ee209( var_1d92d20a5f2943f7 )
{
    function_867cd6025b5f3ea7( var_1d92d20a5f2943f7 );
    function_d86b6171373c7132( 0 );
}

// Namespace frontendwalkablespace
// Params 1
// Checksum 0x901ec772, Offset: 0x1930
// Size: 0x4f
function function_d86b6171373c7132( settospectate )
{
    level.var_9a9e574f38255764 = 1;
    
    if ( settospectate )
    {
        function_975c17bde7e82d6();
        waitframe();
        self cameralinkto( level.camera_anchor, "tag_origin" );
        function_9f6834cdc0c1becc();
    }
    else
    {
        function_d93dc0e30142bc0a();
    }
    
    level.var_9a9e574f38255764 = 0;
}

// Namespace frontendwalkablespace
// Params 2, eflags: 0x40 variadic
// Checksum 0xdb98a52, Offset: 0x1987
// Size: 0xaf
function function_4ca96946a95337ad( ... )
{
    if ( level.var_234c2a7158e3582 )
    {
        return;
    }
    
    level.var_9a9e574f38255764 = 1;
    
    if ( self.settospectate )
    {
        function_95437b3e5726ad89();
    }
    else
    {
        function_fdd6e9ab83afde9();
    }
    
    namespace_285f2d8d2827221c::update_player_weapon();
    self cameraunlink();
    wait 0.1;
    
    if ( self.settospectate )
    {
        self.sessionstate = "playing";
        self.statusicon = "";
        self.settospectate = 0;
        suitname = utility::function_f825237e0eda5adf();
        self setsuit( suitname );
    }
    
    level.var_9a9e574f38255764 = 0;
}

// Namespace frontendwalkablespace
// Params 1
// Checksum 0xecb322c8, Offset: 0x1a3e
// Size: 0x82
function function_c15d418a735c721c( disconnect )
{
    if ( disconnect )
    {
        self allowspectateteam( "none", 1 );
        
        if ( self.var_fa63a83936634b3 && self.sessionstate == "playing" )
        {
            self.sessionstate = "spectator";
        }
        
        self cameralinkto( level.camera_anchor, "tag_origin" );
        return;
    }
    
    if ( self.var_fa63a83936634b3 )
    {
        self.sessionstate = "playing";
    }
    
    self cameraunlink();
}

// Namespace frontendwalkablespace
// Params 0
// Checksum 0x5f91a582, Offset: 0x1ac8
// Size: 0x8
function function_56408659ca302e()
{
    self function_cb8df376b3e57420();
}

// Namespace frontendwalkablespace
// Params 1
// Checksum 0xf86f3801, Offset: 0x1ad8
// Size: 0xc0
function function_e18f0c39f1cd958d( player )
{
    while ( true )
    {
        if ( !self.var_33f76c2d569e4abf )
        {
            self waittill( #"trigger" );
            self.var_33f76c2d569e4abf = 1;
            
            if ( self.script_noteworthy == "shootingrange" )
            {
                entered_firing_range = 1;
                function_9b59870a39f03b40( player );
            }
            
            setomnvar( "ui_walkable_scene_trigger_index", self.triggerindex );
            continue;
        }
        
        if ( self istouching( player ) )
        {
            waitframe();
            continue;
        }
        
        if ( self.script_noteworthy == "shootingrange" && entered_firing_range )
        {
            entered_firing_range = 0;
            function_6c0406dc8b2329ae( player );
        }
        
        self.var_33f76c2d569e4abf = 0;
        setomnvar( "ui_walkable_scene_trigger_index", -1 );
    }
}

// Namespace frontendwalkablespace
// Params 1
// Checksum 0xa24c97bb, Offset: 0x1ba0
// Size: 0x37
function function_9b59870a39f03b40( player )
{
    setomnvar( "ui_firing_range_has_started", 1 );
    player setcamerathirdperson( 0 );
    player setmoveset( "default" );
    function_2a0ac7d9080f76f( player, 1 );
}

// Namespace frontendwalkablespace
// Params 1
// Checksum 0xe01d46b6, Offset: 0x1bdf
// Size: 0x36
function function_6c0406dc8b2329ae( player )
{
    setomnvar( "ui_firing_range_has_started", 0 );
    player setcamerathirdperson( 1 );
    player setmoveset( "rex_fob" );
    function_2a0ac7d9080f76f( player, 0 );
}

// Namespace frontendwalkablespace
// Params 0
// Checksum 0xcef26c68, Offset: 0x1c1d
// Size: 0x45
function function_975c17bde7e82d6()
{
    self.settospectate = 1;
    self setcamerathirdperson( 0 );
    self clearclienttriggeraudiozone( 2 );
    function_fd048ed205a845();
    self suicide();
    waitframe();
    self allowspectateteam( "none", 1 );
    self.sessionstate = "spectator";
}

// Namespace frontendwalkablespace
// Params 3, eflags: 0x40 variadic
// Checksum 0x27f856f9, Offset: 0x1c6a
// Size: 0x8c
function function_1b6fa013c0c2b251( newlootid, ... )
{
    function_9dadf27bbe1eeff0();
    
    if ( newlootid == 0 )
    {
        newlootid = level.var_faaa844cfeb8273e;
    }
    
    if ( self.var_dbb03d2597689cae == newlootid )
    {
        return;
    }
    
    if ( !isdefined( newlootid ) )
    {
        backpack::detachbag();
        return;
    }
    
    self.var_dbb03d2597689cae = newlootid;
    xmodel = level.var_7d880106a79112ae[ newlootid ].var_ab2df660ca22b8c5;
    backpack::attachbag( xmodel );
}

// Namespace frontendwalkablespace
// Params 0, eflags: 0x4
// Checksum 0x7e97a19c, Offset: 0x1cfe
// Size: 0x1ec
function private function_9dadf27bbe1eeff0()
{
    if ( level.var_7d880106a79112ae )
    {
        return;
    }
    
    level.var_7d880106a79112ae = [];
    backpacklist = undefined;
    
    foreach ( entry in level.gametypebundle.itemspawnlistrefs )
    {
        if ( entry.ref == "BACKPACKS" )
        {
            backpacklist = getscriptbundle( entry.list );
            break;
        }
    }
    
    if ( !backpacklist )
    {
        assertmsg( "<dev string:x146>" );
        return;
    }
    
    foreach ( entry in backpacklist.itementries )
    {
        itembundle = getscriptbundlefieldvalues( getxhashasset( entry.itemspawnentry ), [ #"ref", #"hash_146dd41e6d0c890c", #"isbasebackpack" ] );
        lootinfo = getLootItemInfoFromRef( itembundle.ref );
        
        if ( !lootinfo.itemid )
        {
            continue;
        }
        
        if ( itembundle.isbasebackpack )
        {
            level.var_faaa844cfeb8273e = lootinfo.itemid;
        }
        
        level.var_7d880106a79112ae[ lootinfo.itemid ] = itembundle;
    }
}

// Namespace frontendwalkablespace
// Params 0
// Checksum 0x35eb9838, Offset: 0x1ef2
// Size: 0xf8
function function_b01ea89ac6576abd()
{
    function_975c17bde7e82d6();
    
    if ( isdefined( level.sectionarray[ "loadout_showcase" ].basecam.origin ) && isdefined( level.sectionarray[ "loadout_showcase" ].basecam.angles ) )
    {
        self setspectatedefaults( level.sectionarray[ "loadout_showcase" ].basecam.origin, level.sectionarray[ "loadout_showcase" ].basecam.angles );
    }
    
    if ( isdefined( self.camera_anchor ) )
    {
        self cameralinkto( level.camera_anchor, "tag_origin" );
    }
    
    setomnvar( "ui_firing_range_has_started", 0 );
    waitframe();
    freescriptables();
    level notify( #"exit_firing_range" );
    function_4d4b04ca7ed8bad5();
    
    while ( function_971c65f390475d64() )
    {
        waitframe();
    }
    
    function_9f6834cdc0c1becc();
}

// Namespace frontendwalkablespace
// Params 0, eflags: 0xc
// Checksum 0x9f40b2b3, Offset: 0x1ff2
// Size: 0xbd
function private infiniteammo()
{
    self notify( #"hash_1c65cf61800d050a" );
    self endon( #"hash_1c65cf61800d050a" );
    level endon( #"exit_firing_range" );
    
    while ( true )
    {
        weapons = self getweaponslistprimaries();
        
        foreach ( weapon in weapons )
        {
            self givemaxammo( weapon );
            self setweaponammostock( weapon, weaponmaxammo( weapon ) );
        }
        
        waitframe();
    }
}

/#

    // Namespace frontendwalkablespace
    // Params 0, eflags: 0xc
    // Checksum 0x6d25321, Offset: 0x20b7
    // Size: 0x4d, Type: dev
    function private watchufo()
    {
        self notify( #"hash_559366b025d6cfb" );
        self endon( #"hash_559366b025d6cfb" );
        
        while ( true )
        {
            while ( !self isufo() )
            {
                waitframe();
            }
            
            self allowfire( 1 );
            
            while ( self isufo() )
            {
                waitframe();
            }
            
            self allowfire( 0 );
        }
    }

#/

// Namespace frontendwalkablespace
// Params 2, eflags: 0x40 variadic
// Checksum 0x214dc92a, Offset: 0x210c
// Size: 0x55
function playinfil( ... )
{
    if ( getdvarint( @"hash_2f50040baa49c2d8", 1 ) == 1 )
    {
        setomnvar( "infil_animation_concluded", 1 );
        return;
    }
    
    setomnvar( "infil_animation_concluded", 0 );
    function_39ecee7329417dec();
    setomnvar( "infil_animation_concluded", 1 );
}

// Namespace frontendwalkablespace
// Params 0, eflags: 0x4
// Checksum 0x44da726c, Offset: 0x2169
// Size: 0x30
function private function_39ecee7329417dec()
{
    function_fc44ea4f176397bc( getscriptbundle( %"hash_671e303e1b631700" ), ( 281.414, 2149.86, 345.765 ), ( 0, 44.742, 0 ) );
}

// Namespace frontendwalkablespace
// Params 1
// Checksum 0x8ec1e0bd, Offset: 0x21a1
// Size: 0xa1
function playexfil( infiltype = 0 )
{
    level.var_234c2a7158e3582 = 1;
    
    switch ( infiltype )
    {
        case 2:
            bundle = getscriptbundle( %"hash_2c646e64024fa303" );
            break;
        case 3:
            bundle = getscriptbundle( %"hash_5c807a9df0375bf8" );
            break;
        default:
            bundle = getscriptbundle( %"hash_2a4b2c5c6f70bfa2" );
            break;
    }
    
    function_3e82a3e225c86a1e( bundle );
    fadetoblackforplayer( self, 1, 0 );
}

// Namespace frontendwalkablespace
// Params 1, eflags: 0x4
// Checksum 0x26387cf4, Offset: 0x224a
// Size: 0x3d
function private function_3e82a3e225c86a1e( bundle )
{
    function_fc44ea4f176397bc( bundle, ( 378, 2148, -52 ), ( 0, 90, 0 ), getdvarint( @"hash_6eae159fc2aadd76", 0 ) );
}

#using_animtree( "script_model" );

// Namespace frontendwalkablespace
// Params 4, eflags: 0x4
// Checksum 0x11f8583c, Offset: 0x228f
// Size: 0x1182
function private function_fc44ea4f176397bc( bundle, origin, angles, minplayercount = 0 )
{
    sceneroot = spawn( "script_model", origin );
    sceneroot.angles = angles;
    players = getentarraybytype( createentitytypemask( [ "etype_player" ] ), 1 );
    
    foreach ( player in players )
    {
        player freezecontrols( 1 );
        weapon = player getcurrentweapon();
        player.hasnogun = isnullweapon( weapon ) || weapon.ismelee || weaponclass( weapon ) == "pistol";
        
        if ( player function_3123e9f6cf97819() )
        {
            player function_ae3e68d3a09516c0( 1 );
        }
        
        player.player_rig = spawn( "script_arms", player.origin, 0, 0, player );
        player.player_rig.angles = player.angles;
        player.player_rig useanimtree( #animtree );
        var_cfaa30c5137a59a3 = player.player_rig gettagangles( "tag_camera_scripted" );
        player setplayerangles( var_cfaa30c5137a59a3 );
        player playerlinktodelta( player.player_rig, "tag_player", 1, 0, 0, 0, 0, 1 );
        player.player_rig hide();
    }
    
    foreach ( object in bundle.objects )
    {
        switch ( object.variant_type )
        {
            case #"hash_65a82c1636af18c":
                xcamanims = object.variant_object;
                break;
            case #"hash_640286b3dac9d77":
                if ( !isdefined( characters ) )
                {
                    characters = [];
                }
                
                character = object.variant_object;
                characters[ characters.size ] = character;
                assert( character.charactername == "<dev string:x1a9>" );
                character.entity = spawn( "script_model", origin );
                assert( isdefined( character.entity ) );
                character.entity setmodel( %"hash_154f0aa8bf119b4d" );
                character.entity setclothtype( #"vestlight" );
                character.entity setgeartype( #"millghtgr" );
                character.entity setbagtype( #"none" );
                character.entity.angles = angles;
                character.entity useanimtree( character.animtree.id );
                character.entity hide( 1 );
                break;
            case #"hash_84bed3edfa9e797e":
                if ( !isdefined( playeranims ) )
                {
                    playeranims = [];
                }
                
                playeranims[ playeranims.size ] = object.variant_object;
                break;
            case #"hash_6528434880269945":
                vehicleanims = object.variant_object;
                break;
            case #"hash_5b013af2c7016892":
                if ( !isdefined( characters ) )
                {
                    characters = [];
                }
                
                prop = object.variant_object;
                characters[ characters.size ] = prop;
                prop.entity = spawn( "script_model", origin );
                prop.entity setmodel( prop.xmodelname );
                prop.entity.angles = angles;
                prop.entity useanimtree( prop.animtree.id );
                prop.entity hide( 1 );
                break;
        }
    }
    
    if ( vehicleanims )
    {
        if ( level.twinheli )
        {
            level.twinheli delete();
        }
        else
        {
            assertmsg( "<dev string:x1bd>" );
        }
        
        struct = utility::getstruct( "twin_heli_spawn", "script_noteworthy" );
        level.twinheli = spawn( "script_model", struct.origin );
        level.twinheli setmodel( [ "veh_rex_air_cargoplane":%"veh_rex_air_cargoplane", "veh_rex_air_heli_little_mp":%"hash_7ba9c4c5dd56dacf", "veh_rex_air_heli_twin_mp":%"hash_31177bae5048c2e9" ][ vehicleanims.vehiclename ] );
        level.twinheli.angles = struct.angles;
        level.twinheli useanimtree( vehicleanims.animtree.id );
        level.twinheli utility::function_7c10ea82c1e305b8( "engine", "on" );
    }
    
    fakeplayers = [];
    allplayers = getentarraybytype( createentitytypemask( [ "etype_player" ] ), 1 );
    minplayercount = max( minplayercount, allplayers.size );
    
    if ( minplayercount > 1 && players.size < minplayercount )
    {
        for ( i = players.size; i < minplayercount ; i++ )
        {
            fakeplayer = spawn( "script_model", origin );
            fakeplayers[ i ] = fakeplayer;
            fakeplayer setmodel( %"hash_154f0aa8bf119b4d" );
            fakeplayer setclothtype( #"vestlight" );
            fakeplayer setgeartype( #"millghtgr" );
            fakeplayer setbagtype( #"none" );
            fakeplayer.angles = angles;
            fakeplayer useanimtree( #animtree );
            fakeplayer hide( 1 );
        }
    }
    
    foreach ( index, _ in bundle.shots )
    {
        xcam = xcamanims.shots[ index ].cameraanimation;
        vehicleanim = vehicleanims.shots[ index ].deltaanimations[ 0 ].deltaanimation.id;
        assert( xcam, "<dev string:x258>" + index );
        
        foreach ( playernum, player in players )
        {
            if ( player.hasnogun && playeranims[ playernum + 3 ].shots[ index ].deltaanimations[ 0 ].deltaanimation.id )
            {
                playeranim = playeranims[ playernum + 3 ].shots[ index ].deltaanimations[ 0 ].deltaanimation.id;
            }
            else
            {
                playeranim = playeranims[ playernum ].shots[ index ].deltaanimations[ 0 ].deltaanimation.id;
            }
            
            if ( playeranim )
            {
                player playershow();
                
                if ( animhasnotetrack( playeranim, "attach_tablet" ) )
                {
                    player.hastablet = 1;
                    player attach( "offh_2h_wm_rex_tablet_v0", "j_gun" );
                }
                
                neworg = getstartorigin( origin, angles, playeranim );
                newangles = getstartangles( origin, angles, playeranim );
                player.player_rig.origin = neworg;
                player.player_rig.angles = newangles;
                player.player_rig dontinterpolate();
                player.player_rig stopanimscripted();
                player.player_rig setanimknob( playeranim, 1, 0, 0 );
                player.player_rig scriptmodelplayanim( playeranim, undefined, 0, 0, "none" );
                player playanimscriptsceneevent( "scripted_scene", getanimname( playeranim ) );
                player.player_rig animscripted( "single anim", origin, angles, playeranim, undefined, undefined, 0 );
                player.player_rig scriptmodelplayanim( playeranim );
                continue;
            }
            
            player playerhide( 1 );
        }
        
        foreach ( playernum, fakeplayer in fakeplayers )
        {
            playeranim = playeranims[ playernum + ( getdvarint( @"hash_9229c866d63b74aa", 0 ) == 1 ? 3 : 0 ) ].shots[ index ].deltaanimations[ 0 ].deltaanimation.id;
            
            if ( !playeranim )
            {
                fakeplayer hide( 1 );
                continue;
            }
            
            if ( playeranim && animhasnotetrack( playeranim, "attach_tablet" ) )
            {
                fakeplayer.hastablet = 1;
                fakeplayer attach( "offh_2h_wm_rex_tablet_v0", "j_gun" );
            }
            
            fakeplayer show();
            neworg = getstartorigin( origin, angles, playeranim );
            newangles = getstartangles( origin, angles, playeranim );
            fakeplayer.origin = neworg;
            fakeplayer.angles = newangles;
            fakeplayer dontinterpolate();
            fakeplayer stopanimscripted();
            fakeplayer setanimknob( playeranim, 1, 0, 0 );
            fakeplayer scriptmodelplayanim( playeranim, undefined, 0, 0, "none" );
            fakeplayer animscripted( "single anim", origin, angles, playeranim, undefined, undefined, 0 );
            fakeplayer scriptmodelplayanim( playeranim );
        }
        
        foreach ( character in characters )
        {
            characteranim = character.shots[ index ].deltaanimations[ 0 ].deltaanimation.id;
            
            if ( !characteranim )
            {
                character.entity hide( 1 );
                continue;
            }
            
            character.entity show();
            neworg = getstartorigin( origin, angles, characteranim );
            newangles = getstartangles( origin, angles, characteranim );
            character.entity.origin = neworg;
            character.entity.angles = newangles;
            character.entity dontinterpolate();
            character.entity stopanimscripted();
            character.entity setanimknob( characteranim, 1, 0, 0 );
            character.entity scriptmodelplayanim( characteranim, undefined, 0, 0, "none" );
            character.entity animscripted( "single anim", origin, angles, characteranim, undefined, undefined, 0 );
            character.entity scriptmodelplayanim( characteranim );
        }
        
        if ( vehicleanim )
        {
            if ( animhasnotetrack( vehicleanim, "engine_on" ) )
            {
                level.twinheli setscriptablepartstate( "engine", "on" );
            }
            else if ( animhasnotetrack( vehicleanim, "engine_off" ) )
            {
                level.twinheli setscriptablepartstate( "engine", "off" );
            }
            
            neworg = getstartorigin( origin, angles, vehicleanim );
            newangles = getstartangles( origin, angles, vehicleanim );
            level.twinheli.origin = neworg;
            level.twinheli.angles = newangles;
            level.twinheli dontinterpolate();
            level.twinheli stopanimscripted();
            level.twinheli setanimknob( vehicleanim, 1, 0, 0 );
            
            if ( bundle == getscriptbundle( %"hash_2a4b2c5c6f70bfa2" ) )
            {
            }
            
            level.twinheli scriptmodelplayanim( vehicleanim, undefined, 0, 0, "none" );
            level.twinheli animscripted( "single anim", origin, angles, vehicleanim, undefined, undefined, 0 );
            level.twinheli scriptmodelplayanim( vehicleanim );
        }
        
        function_41797a7aad14e175( xcam, 0, 0, sceneroot );
        wait getxcamlength( xcam );
        
        if ( vehicleanim )
        {
            level.twinheli stopanimscripted();
        }
        
        foreach ( character in characters )
        {
            characteranim = character.shots[ index ].deltaanimations[ 0 ].deltaanimation.id;
            
            if ( characteranim )
            {
                character.entity stopanimscripted();
            }
        }
        
        foreach ( player in players )
        {
            player stopanimscriptsceneevent();
        }
    }
    
    function_88b02b89da25811d();
    
    foreach ( player in players )
    {
        player.player_rig delete();
        
        if ( player.hastablet )
        {
            player detach( "offh_2h_wm_rex_tablet_v0", "j_gun" );
        }
        
        player.hastablet = undefined;
        player playershow();
        player stopanimscriptsceneevent();
        player freezecontrols( 0 );
        
        if ( player function_3123e9f6cf97819() )
        {
            player function_ae3e68d3a09516c0( 0 );
        }
        
        var_6d1a54a5bfbb0314 = level.playerspawnents[ 0 ];
        groundpos = utility::groundpos( var_6d1a54a5bfbb0314.origin );
        spawnangles = var_6d1a54a5bfbb0314.angles;
        player setorigin( groundpos );
        player setplayerangles( spawnangles );
    }
    
    if ( vehicleanims )
    {
        level.twinheli delete();
        struct = utility::getstruct( "twin_heli_spawn", "script_noteworthy" );
        level.twinheli = spawn( "script_model", struct.origin );
        level.twinheli setmodel( %"hash_1e78afca23f80a1c" );
        level.twinheli setscriptablepartstate( "engine", "off" );
        level.twinheli.angles = struct.angles;
    }
    
    if ( characters.size )
    {
        foreach ( character in characters )
        {
            character.entity delete();
        }
    }
    
    foreach ( fakeplayer in fakeplayers )
    {
        fakeplayer delete();
    }
    
    sceneroot delete();
}

/#

    // Namespace frontendwalkablespace
    // Params 0, eflags: 0xc
    // Checksum 0xbcf4559, Offset: 0x3419
    // Size: 0xf1, Type: dev
    function private function_705b4195098d6c64()
    {
        self notify( #"hash_8b198cf6cc1e83c2" );
        self endon( #"hash_8b198cf6cc1e83c2" );
        
        while ( true )
        {
            waitframe();
            
            if ( getdvarint( @"hash_9592617fafafa51b", 0 ) != 0 )
            {
                setdvar( @"hash_9592617fafafa51b", 0 );
                function_3e82a3e225c86a1e( getscriptbundle( %"hash_2a4b2c5c6f70bfa2" ) );
            }
            
            if ( getdvarint( @"hash_55ebeaab40aaa5db", 0 ) != 0 )
            {
                setdvar( @"hash_55ebeaab40aaa5db", 0 );
                function_3e82a3e225c86a1e( getscriptbundle( %"hash_2c646e64024fa303" ) );
            }
            
            if ( getdvarint( @"hash_2527e7d1dd50440a", 0 ) != 0 )
            {
                setdvar( @"hash_2527e7d1dd50440a", 0 );
                function_3e82a3e225c86a1e( getscriptbundle( %"hash_5c807a9df0375bf8" ) );
            }
            
            if ( getdvarint( @"hash_f0add7c409aaf599", 0 ) != 0 )
            {
                setdvar( @"hash_f0add7c409aaf599", 0 );
                function_39ecee7329417dec();
            }
        }
    }

#/
