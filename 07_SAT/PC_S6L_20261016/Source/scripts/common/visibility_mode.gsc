// scripts\common\visibility_mode.gsc  (hash_6bfe39bd5c12f84a.gscc) (size: 26947 Bytes / 0x6943 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x315d8c0d (828214285)
// size ...... 26947 (0x6943)
// includes .. 4   (offset: 0x6367)
// strings ... 92  (offset: 0x6387)
// dev strs .. 3   (offset: 0x691f)
// exports ... 65  (offset: 0x4613)
// cseg ...... 0x782 + 0x3e91 (0x4613)
// imports ... 149 (offset: 0x503b)
// animtree1 . 0   (offset: 0x6943)
// animtree2 . 0   (offset: 0x6943)
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace visibility_mode;

// Namespace visibility_mode
// Params 1
// Checksum 0xcac23e0d, Offset: 0x7a0
// Size: 0x16
function main( funcsarray )
{
    level thread visibilitymode_start( funcsarray );
}

// Namespace visibility_mode
// Params 1, eflags: 0x4
// Checksum 0xd23bc339, Offset: 0x7be
// Size: 0x1fd
function private visibilitymode_start( funcsarray )
{
    default_dvar_value = getdvarint( @"hash_33a01af682caae50", 0 );
    setdvarifuninitialized( @"hash_33a01af682caae50", default_dvar_value );
    
    if ( getdvarint( @"hash_33a01af682caae50", -1 ) <= 0 )
    {
        return;
    }
    
    level.visibilitymode = spawnstruct();
    level.visibilitymode.activeclients = [];
    level.visibilitymode.funcs = [];
    
    if ( isfunction( funcsarray ) )
    {
        funcsarray = [[ funcsarray ]]();
    }
    
    foreach ( index, func in funcsarray )
    {
        level.visibilitymode.funcs[ index ] = func;
    }
    
    if ( !checkshouldrun() )
    {
        return;
    }
    
    var_1229b3b24002591b = level.gamemodebundle.cinematicconfig.var_1229b3b24002591b ?? "";
    level.visibilitymode.var_1229b3b24002591b = strtok( var_1229b3b24002591b, ",;: " );
    var_45e48dc13539d9d5 = level.gamemodebundle.cinematicconfig.var_45e48dc13539d9d5 ?? "";
    level.visibilitymode.var_45e48dc13539d9d5 = strtok( var_45e48dc13539d9d5, ",;: " );
    level thread function_fb09c5028e28b9d2();
    
    /#
        level thread function_cba4789ea1db2c01();
        setdevdvarifuninitialized( @"hash_b5ef409e5a4852e1", 0 );
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_command( "<dev string:x33>", "<dev string:x4c>" );
        devgui::function_77df7fe7dd273e10();
    #/
}

// Namespace visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x34d36e1, Offset: 0x9c3
// Size: 0x3d
function private checkshouldrun()
{
    if ( isdefined( level.visibilitymode.funcs[ "shouldRun" ] ) )
    {
        return level [[ level.visibilitymode.funcs[ "shouldRun" ] ]]();
    }
    
    return 0;
}

// Namespace visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x20e0e365, Offset: 0xa09
// Size: 0x65
function private function_fb09c5028e28b9d2()
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.visibilitymode.funcs[ "init" ] ) )
    {
        level [[ level.visibilitymode.funcs[ "init" ] ]]();
    }
    
    level childthread [[ level.visibilitymode.funcs[ "checkForDataUpdates" ] ]]();
}

// Namespace visibility_mode
// Params 1, eflags: 0x4
// Checksum 0xea70fb8f, Offset: 0xa76
// Size: 0x20, Type: bool
function private is_sub_team( subteamname )
{
    return subteamname == "contested" || subteamname == "interactable";
}

// Namespace visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x390e3638, Offset: 0xa9f
// Size: 0xae, Type: bool
function private function_e02cacd8bca0c45c( model )
{
    if ( isarray( level.visibilitymode.var_1229b3b24002591b ) )
    {
        foreach ( substring in level.visibilitymode.var_1229b3b24002591b )
        {
            if ( issubstr( model, substring ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x3d01fcd6, Offset: 0xb56
// Size: 0xe4, Type: bool
function private function_871f14c9a14a562f( model )
{
    if ( level.visibilitymode.var_27c4c9fcc37919a3 && arraycontains( level.visibilitymode.var_27c4c9fcc37919a3, model ) )
    {
        return true;
    }
    
    if ( isarray( level.visibilitymode.var_45e48dc13539d9d5 ) )
    {
        foreach ( substring in level.visibilitymode.var_45e48dc13539d9d5 )
        {
            if ( issubstr( model, substring ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace visibility_mode
// Params 1
// Checksum 0x1c9f70aa, Offset: 0xc43
// Size: 0x62
function function_ceeb7b4ab2524022( model )
{
    if ( !isdefined( level.visibilitymode.var_27c4c9fcc37919a3 ) )
    {
        level.visibilitymode.var_27c4c9fcc37919a3 = [];
    }
    
    level.visibilitymode.var_27c4c9fcc37919a3[ level.visibilitymode.var_27c4c9fcc37919a3.size ] = model;
}

// Namespace visibility_mode
// Params 2, eflags: 0x4
// Checksum 0xb8896c0d, Offset: 0xcad
// Size: 0x145, Type: bool
function private function_50b0ba3d0e90b5fa( firstplayer, secondplayer )
{
    if ( utility::issp() )
    {
        return ( firstplayer.team == "axis" || firstplayer.team == "team3" );
    }
    
    if ( !( isdefined( firstplayer ) && isdefined( secondplayer ) ) )
    {
        return false;
    }
    
    if ( !( isdefined( firstplayer.team ) && isdefined( secondplayer.team ) ) )
    {
        return false;
    }
    
    if ( firstplayer.team == "neutral" || secondplayer.team == "neutral" || firstplayer.vismode_team == "neutral" || secondplayer.vismode_team == "neutral" )
    {
        return false;
    }
    
    if ( firstplayer.team == "civilian" || secondplayer.team == "civilian" )
    {
        return false;
    }
    
    if ( firstplayer.vismode_team === "interactable" || secondplayer.vismode_team === "interactable" )
    {
        return false;
    }
    
    if ( level.teambased )
    {
        return ( firstplayer.team != secondplayer.team );
    }
    
    return false;
}

// Namespace visibility_mode
// Params 1, eflags: 0x4
// Checksum 0xd94975ee, Offset: 0xdfb
// Size: 0x21, Type: bool
function private function_95e981dc10338880( ent )
{
    return isalive( ent ) || ent.visibilitymode_forced;
}

// Namespace visibility_mode
// Params 1, eflags: 0x4
// Checksum 0xd4eb51f9, Offset: 0xe25
// Size: 0x392
function private function_96ae31f5976b308d( client )
{
    client endon( #"disconnect" );
    client.visibilitymode_outlineenabled = 1;
    client.var_2edff02632a566d3 = 1;
    playernum = client getentitynumber();
    reloadtime = 0.5;
    
    if ( isdefined( level.visibilitymode.funcs[ "getReloadTime" ] ) )
    {
        reloadtime = [[ level.visibilitymode.funcs[ "getReloadTime" ] ]]();
    }
    
    client childthread function_9febf7d797fd5e4e();
    client childthread visibilityMode_darkBackground_toggle();
    client childthread visibilityMode_checkSniperADS();
    client childthread function_e1ae950fa17b8857();
    
    while ( client function_7037e2a45b50f307() )
    {
        wait reloadtime;
        
        if ( !client function_7037e2a45b50f307() )
        {
            break;
        }
        
        if ( !isalive( client ) )
        {
            continue;
        }
        
        active_targets = [[ level.visibilitymode.funcs[ "getTargetArray" ] ]]( client );
        active_targets = arraycombine( active_targets, level.visibilitymode.forced_ents );
        
        /#
            if ( getdvarint( @"hash_b5ef409e5a4852e1", 0 ) == 1 )
            {
                active_targets function_32f2391e797f980b();
            }
        #/
        
        var_b35a82f563c6bcec = getdvarint( @"hash_ba5b621f8249cbdf", 5 );
        
        for ( i = 0; i < active_targets.size ; i++ )
        {
            if ( i % var_b35a82f563c6bcec == 0 )
            {
                waitframe();
            }
            
            if ( !isdefined( active_targets[ i ] ) )
            {
                continue;
            }
            
            if ( active_targets[ i ] == client )
            {
                continue;
            }
            
            if ( !function_95e981dc10338880( active_targets[ i ] ) )
            {
                continue;
            }
            
            if ( active_targets[ i ] function_e9fe288eaadefc01( client ) )
            {
                continue;
            }
            
            can_outline = 1;
            
            if ( isagent( active_targets[ i ] ) && utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
            {
                can_outline = level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( client, active_targets[ i ] ) ?? 1;
            }
            
            if ( isdefined( active_targets[ i ].visibilitymode_outlineids ) && can_outline )
            {
                if ( isdefined( active_targets[ i ].visibilitymode_outlineids[ playernum ] ) )
                {
                    if ( client.var_3d090afcb6aae884 )
                    {
                        active_targets[ i ] function_bb8e1c03cf4f27c4( client );
                        continue;
                    }
                    
                    b_reload = client.var_2edff02632a566d3;
                    
                    if ( !b_reload && client function_c38ea625fdbc6e8() && isdefined( client.deathperceptionradius ) && function_50b0ba3d0e90b5fa( active_targets[ i ], client ) )
                    {
                        in_range = distance( active_targets[ i ].origin, client.origin ) <= client.deathperceptionradius;
                        
                        if ( !isdefined( active_targets[ i ].var_a639eb1f83c17399 ) )
                        {
                            active_targets[ i ].var_a639eb1f83c17399 = [];
                        }
                        
                        if ( in_range != active_targets[ i ].var_a639eb1f83c17399[ playernum ] )
                        {
                            active_targets[ i ].var_a639eb1f83c17399[ playernum ] = in_range;
                            b_reload = 1;
                        }
                    }
                    
                    if ( b_reload )
                    {
                        active_targets[ i ] function_829fd0368f95ebf2( client );
                    }
                    
                    continue;
                }
            }
            
            if ( isdefined( active_targets[ i ] ) )
            {
                if ( client.var_3d090afcb6aae884 || !can_outline )
                {
                    active_targets[ i ] thread function_bb8e1c03cf4f27c4( client );
                    continue;
                }
                
                active_targets[ i ] thread function_90efc4d493dbc11b( client );
            }
        }
        
        client.var_2edff02632a566d3 = undefined;
    }
    
    client.visibilitymode_outlineenabled = undefined;
    client notify( #"visibiltymode_disabled" );
}

// Namespace visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x5afca509, Offset: 0x11bf
// Size: 0x8e, Type: bool
function private function_c38ea625fdbc6e8()
{
    if ( isdefined( self.perks_active ) )
    {
        foreach ( perk in self.perks_active )
        {
            if ( perk == "specialty_death_perception" )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x1a5fbff3, Offset: 0x1256
// Size: 0x4a, Type: bool
function private function_79bf5726a591d44d()
{
    if ( function_c38ea625fdbc6e8() == 0 )
    {
        return false;
    }
    
    var_b02a4c84ace6829e = utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_death_perception", #"deathperception_further_insight" );
    
    if ( var_b02a4c84ace6829e )
    {
        return true;
    }
    
    return false;
}

// Namespace visibility_mode
// Params 2, eflags: 0x4
// Checksum 0x526999a1, Offset: 0x12a9
// Size: 0x4d, Type: bool
function private function_31e809138d51a8e3( target, client )
{
    if ( !isdefined( client.deathperceptionradius ) )
    {
        return false;
    }
    
    return distance( target.origin, client.origin ) <= client.deathperceptionradius;
}

// Namespace visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x246c8ffa, Offset: 0x12ff
// Size: 0x388
function private function_90efc4d493dbc11b( client )
{
    if ( self.var_2fc3a5fb762afb6e )
    {
        return;
    }
    
    playernum = client getentitynumber();
    
    if ( isdefined( self.visibilitymode_outlineids ) )
    {
        if ( isdefined( self.visibilitymode_outlineids[ playernum ] ) )
        {
            return;
        }
    }
    
    if ( !isdefined( self.team ) )
    {
        return;
    }
    
    if ( !self.var_d8f82e76c2931622 && function_871f14c9a14a562f( self.model ) )
    {
        return;
    }
    
    if ( function_50b0ba3d0e90b5fa( self, client ) )
    {
        if ( !function_e2231ad877b8d2fb( client.visibilitymode.enemytypevalue ) )
        {
            return;
        }
        
        if ( client.var_be044164245fc649 || self.var_521099eccef67894 )
        {
            self.visibilitymode_outline = client function_e18a453a206411af( "outline_highvis_far_enemy", "outlinefill_highvis_far_enemy" );
        }
        else if ( client function_79bf5726a591d44d() && function_31e809138d51a8e3( self, client ) )
        {
            self.visibilitymode_outline = client function_e18a453a206411af( "outline_highvis_nodepth_enemy_deathperception_extended", "outlinefill_highvis_nodepth_enemy_deathperception_extended" );
        }
        else if ( client function_c38ea625fdbc6e8() && function_31e809138d51a8e3( self, client ) )
        {
            self.visibilitymode_outline = client function_e18a453a206411af( "outline_highvis_nodepth_enemy_deathperception", "outlinefill_highvis_nodepth_enemy_deathperception" );
        }
        else if ( self.visibilitymode_nodepth_far )
        {
            self.visibilitymode_outline = client function_e18a453a206411af( "outline_highvis_nodepth_enemy_far", "outlinefill_highvis_nodepth_enemy_far" );
        }
        else if ( self.visibilitymode_nodepth )
        {
            self.visibilitymode_outline = client function_e18a453a206411af( "outline_highvis_nodepth_enemy", "outlinefill_highvis_nodepth_enemy" );
        }
        else
        {
            self.visibilitymode_outline = client function_e18a453a206411af( "outline_highvis_enemy", "outlinefill_highvis_enemy" );
        }
    }
    else if ( is_entity_interactable( self ) )
    {
        if ( !function_e2231ad877b8d2fb( client.visibilitymode.interactabletypevalue ) )
        {
            return;
        }
        
        self.visibilitymode_outline = client function_e18a453a206411af( "outline_highvis_interactable", "outlinefill_highvis_interactable" );
    }
    else if ( is_entity_contested( self ) )
    {
        if ( !function_e2231ad877b8d2fb( client.visibilitymode.contestedtypevalue ) )
        {
            return;
        }
        
        self.visibilitymode_outline = client function_e18a453a206411af( "outline_highvis_contested", "outlinefill_highvis_contested" );
    }
    else if ( function_82bdb1a268a20930( self ) )
    {
        if ( !function_e2231ad877b8d2fb( client.visibilitymode.neutraltypevalue ) )
        {
            return;
        }
        
        self.visibilitymode_outline = client function_e18a453a206411af( "outline_highvis_neutral", "outlinefill_highvis_neutral" );
    }
    else
    {
        if ( !function_e2231ad877b8d2fb( client.visibilitymode.allytypevalue ) )
        {
            return;
        }
        
        if ( self.var_521099eccef67894 )
        {
            self.visibilitymode_outline = client function_e18a453a206411af( "outline_highvis_far_ally", "outlinefill_highvis_far_ally" );
        }
        else
        {
            self.visibilitymode_outline = client function_e18a453a206411af( "outline_highvis_ally", "outlinefill_highvis_ally" );
        }
    }
    
    enablefunc = level.visibilitymode.funcs[ "enableForClient" ];
    
    if ( !isdefined( self.visibilitymode_outlineids ) )
    {
        self.visibilitymode_outlineids = [];
    }
    
    id = self [[ enablefunc ]]( client, self.visibilitymode_outline, "lowest" );
    clientnum = client getentitynumber();
    self.visibilitymode_outlineids[ clientnum ] = id;
    thread visibilitymode_disableoutlineoncallback( client );
    thread visibilityMode_disableOutlineOnDeath();
    thread visibilitymode_disableonsmokeocclude( client );
}

// Namespace visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x3d2b3d4e, Offset: 0x168f
// Size: 0xba
function private function_dca7ad6de26c754e()
{
    if ( !isdefined( self.visibilitymode_outlineids ) )
    {
        return;
    }
    
    foreach ( id in self.visibilitymode_outlineids )
    {
        if ( isdefined( id ) )
        {
            self [[ level.visibilitymode.funcs[ "disable" ] ]]( id );
        }
    }
    
    self.visibilitymode_outline = undefined;
    self.visibilitymode_outlineids = undefined;
}

// Namespace visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x218e2d9e, Offset: 0x1751
// Size: 0x3a
function private visibilityMode_disableOutlineOnDeath()
{
    level endon( #"game_ended" );
    self notify( #"visibilityMode_disableOutlineOnDeath" );
    self endon( #"visibilityMode_disableOutlineOnDeath" );
    self waittill( #"death_or_disconnect" );
    function_dca7ad6de26c754e();
}

// Namespace visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x732d66c1, Offset: 0x1793
// Size: 0x61
function private visibilitymode_disableoutlineoncallback( client )
{
    self endon( #"death" );
    client endon( #"disconnect" );
    
    if ( isplayer( self ) )
    {
        self endon( #"disconnect" );
    }
    
    clientnum = client getentitynumber();
    self notify( "visibilityMode_disableOutlineOnCallback_" + clientnum );
    self endon( "visibilityMode_disableOutlineOnCallback_" + clientnum );
}

// Namespace visibility_mode
// Params 1, eflags: 0x4
// Checksum 0xa728657c, Offset: 0x17fc
// Size: 0xd3
function private function_bb8e1c03cf4f27c4( client )
{
    if ( !isdefined( self.visibilitymode_outlineids ) )
    {
        return;
    }
    
    foreach ( playernum, id in self.visibilitymode_outlineids )
    {
        clientnum = client getentitynumber();
        
        if ( clientnum == playernum )
        {
            if ( isdefined( id ) )
            {
                self [[ level.visibilitymode.funcs[ "disable" ] ]]( id );
                self.visibilitymode_outlineids[ playernum ] = undefined;
            }
        }
    }
}

// Namespace visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x4115d0a3, Offset: 0x18d7
// Size: 0x1e
function private function_829fd0368f95ebf2( client )
{
    function_bb8e1c03cf4f27c4( client );
    thread function_90efc4d493dbc11b( client );
}

// Namespace visibility_mode
// Params 1, eflags: 0x4
// Checksum 0xbbe9e245, Offset: 0x18fd
// Size: 0xcd
function private visibilitymode_disableonsmokeocclude( client )
{
    if ( !isdefined( level.visibilitymode.funcs[ "outlineOccluded" ] ) )
    {
        return;
    }
    
    clientnum = client getentitynumber();
    self notify( "visibilityMode_disableOnsmokeOcclude_" + clientnum );
    self endon( "visibilityMode_disableOnsmokeOcclude_" + clientnum );
    self endon( #"death_or_disconnect" );
    client endon( #"disconnect" );
    client endon( #"visibiltymode_disabled" );
    
    while ( true )
    {
        wait 0.5;
        
        if ( !utility::within_fov( client.origin, client.angles, self.origin, 0.766 ) )
        {
            continue;
        }
        
        if ( function_e9fe288eaadefc01( client ) )
        {
            function_bb8e1c03cf4f27c4( client );
            return;
        }
    }
}

// Namespace visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x9487488c, Offset: 0x19d2
// Size: 0xff, Type: bool
function private function_e9fe288eaadefc01( client )
{
    if ( !isdefined( level.visibilitymode.funcs[ "outlineOccluded" ] ) )
    {
        return false;
    }
    
    if ( client function_c38ea625fdbc6e8() )
    {
        return false;
    }
    
    self_eye = undefined;
    
    if ( issentient( self ) )
    {
        self_eye = self geteye();
    }
    else if ( self.visibilitymode_forced )
    {
        if ( self tagexists( "TAG_EYE" ) )
        {
            self_eye = self gettagorigin( "TAG_EYE" );
        }
        else if ( self tagexists( "TAG_HEAD" ) )
        {
            self_eye = self gettagorigin( "TAG_HEAD" );
        }
        else
        {
            midpoint = function_decb653c5689e4ca( self.model );
            self_eye = self.origin + ( 0, 0, midpoint[ 2 ] * 2 );
        }
    }
    
    if ( !isdefined( self_eye ) )
    {
        return false;
    }
    
    if ( [[ level.visibilitymode.funcs[ "outlineOccluded" ] ]]( client geteye(), self_eye ) )
    {
        return true;
    }
    
    return false;
}

// Namespace visibility_mode
// Params 4, eflags: 0x4
// Checksum 0x524e1f38, Offset: 0x1ada
// Size: 0x117
function private function_27681dbae81ca66c( client, teamname, soldiersarray, var_a096955ad60758c3 )
{
    if ( is_sub_team( teamname ) )
    {
        self.vismode_team = teamname;
    }
    else
    {
        if ( teamname )
        {
            self.team = teamname;
        }
        else if ( !isdefined( self.team ) || self.team == "" )
        {
            self.team = "axis";
        }
        
        self.vismode_team = undefined;
    }
    
    if ( var_a096955ad60758c3 )
    {
        self.agentname = undefined;
        self.name = undefined;
    }
    
    if ( !isdefined( self.var_69950ffb5182cc5c ) )
    {
        self.var_69950ffb5182cc5c = [];
    }
    
    playernum = client getentitynumber();
    
    if ( teamname != self.var_69950ffb5182cc5c[ playernum ] )
    {
        function_829fd0368f95ebf2( client );
        self.var_69950ffb5182cc5c[ playernum ] = teamname;
        
        if ( isent( self.headmodel ) )
        {
            function_3afc3bc470c80e61( self.headmodel, teamname );
        }
    }
}

// Namespace visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x81574b43, Offset: 0x1bf9
// Size: 0x5e, Type: bool
function private function_82bdb1a268a20930( ent )
{
    if ( ent.vismode_team == "neutral" || ent.vismode_team == "civilian" )
    {
        return true;
    }
    
    return ent.team === "neutral" || ent.team == "civilian";
}

// Namespace visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x51bccd5f, Offset: 0x1c60
// Size: 0x2e, Type: bool
function private is_entity_interactable( ent )
{
    if ( isdefined( ent.vismode_team ) )
    {
        return ( ent.vismode_team === "interactable" );
    }
    
    return false;
}

// Namespace visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x7074ca95, Offset: 0x1c97
// Size: 0x2e, Type: bool
function private is_entity_contested( ent )
{
    if ( isdefined( ent.vismode_team ) )
    {
        return ( ent.vismode_team === "contested" );
    }
    
    return false;
}

// Namespace visibility_mode
// Params 2, eflags: 0x4
// Checksum 0xa5514611, Offset: 0x1cce
// Size: 0x65
function private function_e18a453a206411af( outlineshader, insideshader )
{
    shader_color = outlineshader;
    
    if ( isdefined( self.visibilitymode ) && isdefined( self.visibilitymode.outlinevalue ) )
    {
        if ( self.visibilitymode.outlinevalue == 0 )
        {
            shader_color = insideshader;
        }
    }
    
    return shader_color;
}

// Namespace visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x7682a767, Offset: 0x1d3c
// Size: 0x11, Type: bool
function private function_e2231ad877b8d2fb( typesetting )
{
    return typesetting == 1;
}

// Namespace visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x2bfa945e, Offset: 0x1d56
// Size: 0x8f
function private function_1260ba78b6caf0b2()
{
    active_targets = [[ level.visibilitymode.funcs[ "getTargetArray" ] ]]( self );
    returnguys = [];
    playernum = self getentitynumber();
    
    for ( i = 0; i < active_targets.size ; i++ )
    {
        if ( isdefined( active_targets[ i ].visibilitymode_outlineids ) )
        {
            if ( isdefined( active_targets[ i ].visibilitymode_outlineids[ playernum ] ) )
            {
                returnguys[ returnguys.size ] = active_targets[ i ];
            }
        }
    }
    
    return returnguys;
}

// Namespace visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x2e3331cc, Offset: 0x1dee
// Size: 0x8c
function private function_bc63e37cae86a444()
{
    if ( isdefined( level.players ) )
    {
        activeplayers = [];
        
        for ( i = 0; i < level.players.size ; i++ )
        {
            if ( level.players[ i ] function_7037e2a45b50f307() )
            {
                activeplayers[ activeplayers.size ] = level.players[ i ];
            }
        }
        
        return activeplayers;
    }
    
    if ( isdefined( level.player ) )
    {
        return level.player function_7037e2a45b50f307();
    }
    
    return [];
}

// Namespace visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x43ffb491, Offset: 0x1e82
// Size: 0xed
function private function_9febf7d797fd5e4e()
{
    level endon( #"game_ended" );
    self endon( #"visibiltymode_disabled" );
    
    while ( true )
    {
        level waittill( #"highvis_reload_outline", teamname, soldiersarray, var_a096955ad60758c3 );
        
        foreach ( soldier in soldiersarray )
        {
            if ( !function_95e981dc10338880( soldier ) )
            {
                continue;
            }
            
            if ( soldier.var_2fc3a5fb762afb6e )
            {
                soldier function_dca7ad6de26c754e();
                continue;
            }
            
            soldier function_27681dbae81ca66c( self, teamname, soldiersarray, var_a096955ad60758c3 );
        }
    }
}

// Namespace visibility_mode
// Params 1
// Checksum 0x1177c0ad, Offset: 0x1f77
// Size: 0x19a
function visibilitymode_unpackvalue( value )
{
    enable_value = self.visibilitymode.enablevalue;
    
    if ( isdefined( enable_value ) )
    {
        if ( enable_value == 0 )
        {
            active_targets = [[ level.visibilitymode.funcs[ "getTargetArray" ] ]]( self );
            active_targets = arraycombine( active_targets, level.visibilitymode.forced_ents );
            
            for ( index = 0; index < active_targets.size ; index++ )
            {
                if ( isdefined( active_targets[ index ] ) )
                {
                    active_targets[ index ] function_bb8e1c03cf4f27c4( self );
                }
            }
            
            function_bb8e1c03cf4f27c4( self );
            thread visibilityMode_darkBackground_toggle( 0 );
            return;
        }
        
        function_829fd0368f95ebf2( self );
        level.visibilitymode.activeclients = function_bc63e37cae86a444();
        
        if ( level.visibilitymode.activeclients.size > 0 )
        {
            for ( index = 0; index < level.visibilitymode.activeclients.size ; index++ )
            {
                if ( isdefined( level.visibilitymode.activeclients[ index ] ) )
                {
                    if ( !isdefined( level.visibilitymode.activeclients[ index ].visibilitymode_outlineenabled ) )
                    {
                        level thread function_96ae31f5976b308d( level.visibilitymode.activeclients[ index ] );
                        continue;
                    }
                    
                    level.visibilitymode.activeclients[ index ].var_2edff02632a566d3 = 1;
                }
            }
        }
    }
}

// Namespace visibility_mode
// Params 0, eflags: 0x4
// Checksum 0xe34e6a1a, Offset: 0x2119
// Size: 0x107
function private visibilityMode_checkSniperADS()
{
    self endon( #"disconnect" );
    self endon( #"visibiltymode_disabled" );
    self notify( #"visibilityMode_checkSniperADS" );
    self endon( #"visibilityMode_checkSniperADS" );
    
    for ( var_6ac32a50cf4eb977 = 0.25; true ; var_6ac32a50cf4eb977 = 0.25 )
    {
        wait var_6ac32a50cf4eb977;
        
        if ( !isalive( self ) )
        {
            continue;
        }
        
        weapondist = self [[ level.visibilitymode.funcs[ "getADSWeaponDist" ] ]]();
        playerads = self playerads();
        
        if ( self.var_22aa2a942de044fe || weapondist > 3000 && playerads > 0.95 )
        {
            if ( !isdefined( self.var_be044164245fc649 ) )
            {
                self.var_be044164245fc649 = 1;
                self.var_2edff02632a566d3 = 1;
            }
            
            var_6ac32a50cf4eb977 = 0.05;
            continue;
        }
        
        if ( self.var_be044164245fc649 )
        {
            self.var_be044164245fc649 = undefined;
            self.var_2edff02632a566d3 = 1;
        }
    }
}

// Namespace visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x1f51cc28, Offset: 0x2228
// Size: 0x161
function private visibilityMode_darkBackground_toggle( inputoverride = undefined )
{
    self endon( #"disconnect" );
    self notify( #"visibilityMode_darkBackground_toggle" );
    self endon( #"visibilityMode_darkBackground_toggle" );
    
    if ( !utility::issp() )
    {
        utility::ent_flag_wait( "player_active" );
        
        if ( utility::iszm() && function_a3857bdb9f2178a( level.gametype ) )
        {
            utility::flag_wait( "begin_round_logic" );
        }
    }
    
    if ( isdefined( inputoverride ) )
    {
        self [[ level.visibilitymode.funcs[ "toggleDarkBackground" ] ]]( inputoverride );
        self.visibilitymode.adsconfirm = inputoverride;
        return;
    }
    
    var_1cdfb4bb2321bb2d = 99;
    
    while ( true )
    {
        if ( isdefined( level.visibilitymode.funcs[ "toggleCheckData" ] ) )
        {
            if ( self [[ level.visibilitymode.funcs[ "toggleCheckData" ] ]]() )
            {
                wait 1;
                var_1cdfb4bb2321bb2d = 99;
            }
        }
        
        intoggle = function_63e3a5209106205b();
        
        if ( var_1cdfb4bb2321bb2d != intoggle )
        {
            self [[ level.visibilitymode.funcs[ "toggleDarkBackground" ] ]]( intoggle );
            self.visibilitymode.adsconfirm = intoggle;
            var_1cdfb4bb2321bb2d = intoggle;
        }
        
        wait 0.1;
    }
}

// Namespace visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x6c3eb311, Offset: 0x2391
// Size: 0x1d
function private function_e1ae950fa17b8857()
{
    if ( getdvarint( @"hash_45a5d82158a5cf64", 0 ) > 0 )
    {
        return;
    }
    
    childthread function_6956e5d6d213376();
}

// Namespace visibility_mode
// Params 0, eflags: 0x4
// Checksum 0xd63f52f2, Offset: 0x23b6
// Size: 0x22a
function private function_82b48b65aa862431()
{
    tracedata = function_172efe6a4531f856();
    entity = tracedata.entity;
    
    if ( isdefined( entity ) && isdefined( entity.team ) && isdefined( entity.visibilitymode_outline ) )
    {
        if ( function_50b0ba3d0e90b5fa( entity, self ) )
        {
            if ( !function_e2231ad877b8d2fb( level.player.visibilitymode.enemytypevalue ) )
            {
                return;
            }
            
            ispinged = 0;
            
            if ( tracedata.type == "middle" )
            {
                if ( ispinged )
                {
                    if ( soundexists( "ui_text_type" ) )
                    {
                        self playlocalsound( "ui_text_type" );
                    }
                }
                
                if ( soundexists( "2pop" ) )
                {
                    self playlocalsound( "2pop" );
                }
            }
            else if ( tracedata.type == "middle_near" )
            {
                if ( ispinged )
                {
                    if ( soundexists( "ui_menu_ability_hover" ) )
                    {
                        self playlocalsound( "ui_menu_ability_hover" );
                    }
                }
                
                if ( soundexists( "2pop_low" ) )
                {
                    self playlocalsound( "2pop_low" );
                }
            }
            else if ( tracedata.type == "left" )
            {
                if ( ispinged )
                {
                    if ( soundexists( "ui_menu_ability_hover" ) )
                    {
                        self playlocalsound( "ui_menu_ability_hover" );
                    }
                }
                
                if ( soundexists( "2pop_low" ) )
                {
                    self playlocalsound( "2pop_low" );
                }
            }
            else
            {
                if ( ispinged )
                {
                    if ( soundexists( "ui_menu_ability_hover" ) )
                    {
                        self playlocalsound( "ui_menu_ability_hover" );
                    }
                }
                
                if ( soundexists( "2pop_low" ) )
                {
                    self playlocalsound( "2pop_low" );
                }
            }
            
            return;
        }
        
        if ( isplayer( entity ) )
        {
            if ( !function_e2231ad877b8d2fb( level.player.visibilitymode.allytypevalue ) )
            {
                return;
            }
            
            if ( soundexists( "ui_chyron_firstline" ) )
            {
                self playlocalsound( "ui_chyron_firstline" );
            }
            
            return;
        }
        
        if ( !function_e2231ad877b8d2fb( level.player.visibilitymode.allytypevalue ) )
        {
            return;
        }
        
        if ( soundexists( "ui_chyron_plusminus" ) )
        {
            self playlocalsound( "ui_chyron_plusminus" );
        }
    }
}

// Namespace visibility_mode
// Params 0, eflags: 0x4
// Checksum 0xce217cfb, Offset: 0x25e8
// Size: 0x39b
function private function_172efe6a4531f856()
{
    tracedist = self [[ level.visibilitymode.funcs[ "getADSWeaponDist" ] ]]();
    playerangles = self getgunangles();
    traceend = self geteye() + anglestoforward( playerangles ) * tracedist;
    traceoffset = ( 0, 0, 0 );
    tracevecoffset = 32;
    returndata = spawnstruct();
    returndata.entity = undefined;
    returndata.type = "middle";
    
    for ( i = 0; i < 15 ; i++ )
    {
        if ( i == 1 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset * -1, 0 ), playerangles );
            returndata.type = "left";
        }
        else if ( i == 2 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset, 0 ), playerangles );
            returndata.type = "right";
        }
        else if ( i == 3 )
        {
            traceoffset = rotatevector( ( 0, 0, tracevecoffset ), playerangles );
            returndata.type = "middle_near";
        }
        else if ( i == 4 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset * -1, tracevecoffset ), playerangles );
            returndata.type = "left";
        }
        else if ( i == 5 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset, tracevecoffset ), playerangles );
            returndata.type = "right";
        }
        else if ( i == 6 )
        {
            traceoffset = rotatevector( ( 0, 0, tracevecoffset * -1 ), playerangles );
            returndata.type = "middle_near";
        }
        else if ( i == 7 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset * -1, tracevecoffset * -1 ), playerangles );
            returndata.type = "left";
        }
        else if ( i == 8 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset, tracevecoffset * -1 ), playerangles );
            returndata.type = "right";
        }
        else if ( i == 9 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset * -2, tracevecoffset ), playerangles );
            returndata.type = "left";
        }
        else if ( i == 10 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset * -2, 0 ), playerangles );
            returndata.type = "left";
        }
        else if ( i == 11 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset * -2, tracevecoffset * -1 ), playerangles );
            returndata.type = "left";
        }
        else if ( i == 12 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset * 2, tracevecoffset ), playerangles );
            returndata.type = "right";
        }
        else if ( i == 13 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset * 2, 0 ), playerangles );
            returndata.type = "right";
        }
        else if ( i == 14 )
        {
            traceoffset = rotatevector( ( 0, tracevecoffset * 2, tracevecoffset * -1 ), playerangles );
            returndata.type = "right";
        }
        
        trace = trace::ray_trace( self geteye(), traceend + traceoffset );
        
        if ( isdefined( trace[ "entity" ] ) && ( isplayer( trace[ "entity" ] ) || issentient( trace[ "entity" ] ) ) )
        {
            if ( returndata.type == "middle" )
            {
                returndata.type = function_74a7309da4cbb19c( trace, playerangles, tracedist );
            }
            
            returndata.entity = trace[ "entity" ];
            return returndata;
        }
    }
    
    return returndata;
}

// Namespace visibility_mode
// Params 3, eflags: 0x4
// Checksum 0xe464840a, Offset: 0x298c
// Size: 0x122
function private function_74a7309da4cbb19c( trace, playerangles, tracedist )
{
    targeteyespos = trace[ "entity" ] geteye();
    targetoriginpos = trace[ "entity" ] gettagorigin( "tag_origin", 1 );
    var_b4fe35cf7e8d789 = self geteye() + anglestoforward( playerangles ) * tracedist * 1.5;
    
    if ( isdefined( targeteyespos ) && isdefined( targetoriginpos ) )
    {
        data = utility::closestdistancebetweenlines( targetoriginpos, targeteyespos, self geteye(), var_b4fe35cf7e8d789 );
        
        if ( data[ 2 ] < 7 )
        {
            return "middle";
        }
        else if ( isdefined( data ) )
        {
            up = anglestoup( playerangles );
            var_4e98d1a6c805d862 = vectornormalize2( var_b4fe35cf7e8d789 - self.origin );
            metotarget = vectornormalize2( targetoriginpos - self.origin );
            angbetween = math::anglebetweenvectorssigned( var_4e98d1a6c805d862, metotarget, up );
            
            if ( angbetween > 0 )
            {
                return "right";
            }
            else
            {
                return "left";
            }
        }
    }
    
    return "middle";
}

// Namespace visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x42d254c4, Offset: 0x2ab7
// Size: 0x145
function private function_6956e5d6d213376()
{
    self.visibilitymodeads = 0;
    self.var_8c6ce1e6e3b09db5 = 0;
    btracking = 0;
    isrunning = 0;
    self notifyonplayercommand( "vis_focus_pressed", "+focus" );
    self notifyonplayercommand( "vis_focus_pressed", "togglescores" );
    self notifyonplayercommand( "vis_focus_pressed", "togglemap" );
    
    while ( function_7037e2a45b50f307() )
    {
        wait 0.1;
        
        if ( !isalive( self ) )
        {
            continue;
        }
        
        settingenabled = function_f27d58dee524f7a9();
        playerads = self playerads();
        
        if ( isdefined( level.visibilitymode.funcs[ "getPlayerADS" ] ) )
        {
            playerads = self [[ level.visibilitymode.funcs[ "getPlayerADS" ] ]]();
        }
        
        if ( !btracking && !settingenabled )
        {
            if ( settingenabled || playerads > 0.5 && self jumpbuttonpressed() && self usebuttonpressed() && self weaponswitchbuttonpressed() )
            {
                btracking = 1;
            }
            
            continue;
        }
        
        if ( !settingenabled && !btracking )
        {
            wait 1;
            continue;
        }
        
        if ( isrunning )
        {
            if ( !settingenabled )
            {
                isrunning = 0;
            }
            
            continue;
        }
        
        thread function_6f904f210491d609();
        isrunning = 1;
    }
}

// Namespace visibility_mode
// Params 1, eflags: 0xc
// Checksum 0xba4f9826, Offset: 0x2c04
// Size: 0x4c
function private function_6f904f210491d609( type )
{
    self notify( #"hash_a430baca35f0cc0" );
    self endon( #"hash_a430baca35f0cc0" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"vis_focus_pressed" );
        childthread function_b944244453eb18e3();
    }
}

// Namespace visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x598a89ac, Offset: 0x2c58
// Size: 0x58
function private function_b944244453eb18e3()
{
    function_26fe830c681419cd();
    function_533410d3e412bdf9();
    function_ecef4235a005ee0();
    function_884a746cd65e7eb0();
    
    if ( isdefined( level.visibilitymode.funcs[ "playUsablesSound" ] ) )
    {
        self [[ level.visibilitymode.funcs[ "playUsablesSound" ] ]]();
    }
}

// Namespace visibility_mode
// Params 0, eflags: 0xc
// Checksum 0x290219f9, Offset: 0x2cb8
// Size: 0x84
function private function_26fe830c681419cd()
{
    self notify( #"hash_a99efb3602b0e9ab" );
    self endon( #"hash_a99efb3602b0e9ab" );
    
    if ( getdvarint( @"hash_5330d65f1b02debf", 0 ) > 0 )
    {
        return;
    }
    
    if ( self getstance() != "prone" )
    {
        return;
    }
    
    myangles = self getplayerangles();
    
    if ( myangles[ 0 ] < 40 )
    {
        return;
    }
    
    angles = ( 0, self.angles[ 1 ], self.angles[ 2 ] );
    self setplayerangles( angles );
}

// Namespace visibility_mode
// Params 0, eflags: 0xc
// Checksum 0x70aa68e9, Offset: 0x2d44
// Size: 0x267
function private function_ecef4235a005ee0()
{
    self notify( #"hash_4ea210bd79d32d7a" );
    self endon( #"hash_4ea210bd79d32d7a" );
    self endon( #"death_or_disconnect" );
    self endon( #"vis_focus_pressed" );
    
    if ( level.visibilitymode.var_d60b4bc1a5e11789 )
    {
        return;
    }
    
    if ( getdvarint( @"hash_dfb0535275001743", 0 ) > 0 )
    {
        return;
    }
    
    enabledtype = function_f27d58dee524f7a9();
    delayend = 0.5;
    delaybetween = 0.2;
    
    if ( enabledtype && enabledtype == 2 )
    {
        delayend = 0.15;
        delaybetween = 0.05;
    }
    
    clientallies = function_956d237eca536d16();
    active_players = [];
    var_2eefa2d05661ed02 = [];
    
    foreach ( ally in clientallies )
    {
        if ( !isalive( ally ) )
        {
            continue;
        }
        
        if ( isplayer( ally ) )
        {
            if ( ally == self )
            {
                continue;
            }
            
            active_players[ active_players.size ] = ally;
            continue;
        }
        
        var_2eefa2d05661ed02[ var_2eefa2d05661ed02.size ] = ally;
    }
    
    active_players = sortbydistance( active_players, self.origin );
    
    for ( i = 0; i < active_players.size ; i++ )
    {
        if ( !active_players[ i ].inlaststand )
        {
            level thread function_565d45c985c4983( active_players[ i ].origin, self, "player" );
        }
        else
        {
            level thread function_565d45c985c4983( active_players[ i ].origin, self, "player_laststand" );
        }
        
        if ( active_players.size > 1 )
        {
            wait delaybetween;
        }
    }
    
    if ( active_players.size > 0 )
    {
        wait delayend;
    }
    
    var_2eefa2d05661ed02 = sortbydistancecullbyradius( var_2eefa2d05661ed02, self.origin, 768 );
    
    if ( var_2eefa2d05661ed02.size > 0 )
    {
        var_21d016893db2690 = min( 4, var_2eefa2d05661ed02.size );
        
        for ( i = 0; i < var_21d016893db2690 ; i++ )
        {
            level thread function_565d45c985c4983( var_2eefa2d05661ed02[ i ].origin, self, "ally" );
            
            if ( var_2eefa2d05661ed02.size > 1 )
            {
                wait delaybetween;
            }
        }
    }
    
    if ( var_2eefa2d05661ed02.size > 0 )
    {
        wait delayend;
    }
}

// Namespace visibility_mode
// Params 0, eflags: 0xc
// Checksum 0xb0bc406a, Offset: 0x2fb3
// Size: 0x1b4
function private function_533410d3e412bdf9()
{
    self notify( #"hash_eab7beb46c06d7f4" );
    self endon( #"hash_eab7beb46c06d7f4" );
    self endon( #"death_or_disconnect" );
    self endon( #"vis_focus_pressed" );
    
    if ( getdvarint( @"hash_31d122f238b658d8", 0 ) > 0 )
    {
        return;
    }
    
    maxdist = self [[ level.visibilitymode.funcs[ "getADSWeaponDist" ] ]]();
    maxdistsq = squared( maxdist );
    clientenemies = function_7ab1306fcb9b0a70();
    clientenemies = sortbydistance( clientenemies, self.origin );
    var_21d016893db2690 = min( 5, clientenemies.size );
    numhit = 0;
    enabledtype = function_f27d58dee524f7a9();
    delaymax = 0.6;
    enddelay = 0.5;
    
    if ( enabledtype && enabledtype == 2 )
    {
        delaymax = 0.25;
        enddelay = 0.15;
    }
    
    for ( i = 0; i < var_21d016893db2690 ; i++ )
    {
        if ( !function_d8599342b7a75d3b( self, clientenemies[ i ] ) )
        {
            continue;
        }
        
        if ( !isalive( clientenemies[ i ] ) )
        {
            continue;
        }
        
        disttome = distancesquared( clientenemies[ i ].origin, self.origin );
        
        if ( disttome < maxdistsq )
        {
            numhit++;
            level thread function_565d45c985c4983( clientenemies[ i ].origin, self, "enemy" );
            delay = math::remap( disttome, 0, maxdistsq, 0.15, delaymax );
            wait delay;
        }
    }
    
    if ( numhit > 0 )
    {
        wait enddelay;
    }
}

// Namespace visibility_mode
// Params 0, eflags: 0xc
// Checksum 0x45c4ebde, Offset: 0x316f
// Size: 0x7df
function private function_884a746cd65e7eb0()
{
    self notify( #"hash_51f25a3ed7d37ab4" );
    self endon( #"hash_51f25a3ed7d37ab4" );
    self endon( #"death_or_disconnect" );
    self endon( #"vis_focus_pressed" );
    
    if ( level.visibilitymode.var_98feaf41a6767fcf )
    {
        return;
    }
    
    enabledtype = function_f27d58dee524f7a9();
    delaybetween = 0.5;
    enddelay = 0.25;
    
    if ( enabledtype && enabledtype == 2 )
    {
        delaybetween = 0.25;
        enddelay = 0.15;
    }
    
    objposarray = [];
    
    if ( isdefined( level.objectiveidpool.active ) )
    {
        foreach ( objective in level.objectiveidpool.active )
        {
            if ( objective.identifier == "nonobj_marker" )
            {
                continue;
            }
            
            if ( !isdefined( objective.objid ) )
            {
                continue;
            }
            
            objstruct = spawnstruct();
            objstruct.objinfo = objective;
            objstruct.origin = objective_getlocation( objective.objid, 0 );
            
            if ( distance( objstruct.origin, ( 0, 0, 0 ) ) < 1 )
            {
                continue;
            }
            
            objposarray[ objposarray.size ] = objstruct;
        }
    }
    
    if ( isdefined( level.objective_array ) )
    {
        for ( i = 0; i < level.objective_array.size ; i++ )
        {
            if ( !isdefined( level.objective_array[ i ].objid ) )
            {
                continue;
            }
            
            objstruct = spawnstruct();
            objstruct.origin = objective_getlocation( level.objective_array[ i ].objid, 0 );
            
            if ( distance( objstruct.origin, ( 0, 0, 0 ) ) < 1 )
            {
                continue;
            }
            
            objposarray[ objposarray.size ] = objstruct;
        }
    }
    
    if ( isdefined( level.objectives ) && isdefined( level.var_76c619f8a80f8fa9 ) )
    {
        objstruct = spawnstruct();
        objstruct.origin = objective_getlocation( level.var_76c619f8a80f8fa9, 0 );
        
        if ( distance( objstruct.origin, ( 0, 0, 0 ) ) < 1 )
        {
        }
        else
        {
            objposarray[ objposarray.size ] = objstruct;
        }
    }
    
    if ( objposarray.size > 0 )
    {
        objposarray = sortbydistance( objposarray, self.origin );
        
        for ( i = 0; i < objposarray.size ; i++ )
        {
            pathstart = getclosestpointonnavmesh( self.origin );
            pathend = getclosestpointonnavmesh( objposarray[ i ].origin );
            didntrun = 0;
            
            if ( pathstart && pathend )
            {
                var_f5387742b3dc1fdc = 32;
                path = findpathcustom( pathstart, pathend, 1 );
                
                if ( path.size )
                {
                    didntrun = 1;
                    
                    for ( j = 0; j < path.size ; j++ )
                    {
                        disttonode = distance( path[ j ], self.origin );
                        
                        if ( disttonode < 48 || disttonode > 4096 )
                        {
                            continue;
                        }
                        
                        if ( didntrun )
                        {
                            var_278c7e94dabff693 = path[ j ];
                            
                            if ( disttonode > 192 )
                            {
                                var_278c7e94dabff693 = self.origin + vectornormalize( path[ j ] - self.origin ) * 192;
                                disttonode = 192;
                            }
                            
                            level thread function_565d45c985c4983( var_278c7e94dabff693, self );
                            didntrun = 0;
                        }
                        
                        if ( j > 0 && distance( path[ j ], path[ j - 1 ] ) > var_f5387742b3dc1fdc )
                        {
                            distbetween = distance( path[ j ], path[ j - 1 ] );
                            var_2e7d53d2943dc035 = int( distbetween / var_f5387742b3dc1fdc );
                            var_c7db1b64ea23b52e = 1 / ( var_2e7d53d2943dc035 + 1 );
                            
                            for ( k = 1; k <= var_2e7d53d2943dc035 ; k++ )
                            {
                                var_a6f1b00cf3618d35 = k * var_c7db1b64ea23b52e;
                                var_e54469ec97dbb3a1 = path[ j - 1 ] + vectornormalize( path[ j ] - path[ j - 1 ] ) * var_a6f1b00cf3618d35 * distbetween;
                                
                                if ( distance( var_e54469ec97dbb3a1, self.origin ) < 384 )
                                {
                                    level thread function_565d45c985c4983( var_e54469ec97dbb3a1, self, "breadcrumb" );
                                }
                            }
                        }
                    }
                }
                else
                {
                    didntrun = 1;
                }
            }
            else
            {
                didntrun = 1;
            }
            
            if ( didntrun )
            {
                level thread function_565d45c985c4983( objposarray[ i ].origin, self );
            }
            
            if ( objposarray.size > 1 )
            {
                wait delaybetween;
            }
        }
    }
    else
    {
        level thread function_565d45c985c4983( self.origin + ( 0, 0, 48 ), self, "deny" );
    }
    
    if ( getdvarint( @"hash_22d25aed32c091de", 0 ) > 0 )
    {
        return;
    }
    
    wait enddelay;
    perkmachines = [];
    
    if ( isdefined( level.interacts ) )
    {
        foreach ( interact in level.interacts )
        {
            if ( isdefined( interact.s_perk_machine ) )
            {
                perkmachines[ perkmachines.size ] = interact;
            }
        }
    }
    
    ascender_scriptables = getscriptablearray( "zm_forcefield_ziplines", #script_noteworthy );
    ascenders = [];
    
    foreach ( scriptable in ascender_scriptables )
    {
        if ( isdefined( scriptable.origin ) && scriptable isscriptable() )
        {
            ascenders[ ascenders.size ] = scriptable;
        }
    }
    
    radius = getdvarint( @"hash_919d1502053e2776", 512 );
    function_d1ea9113f418f5c9( level._ammo_cache_info.var_ea07e36d8fd28578, "ammo", self, radius );
    radius = getdvarint( @"hash_3f85ec9dcfef2dc", 450 );
    function_d1ea9113f418f5c9( level.var_caf65b937e9cbfaf, "item", self, radius );
    radius = getdvarint( @"hash_e4c5808d4390b4d9", 384 );
    function_d1ea9113f418f5c9( level.var_f301c0b95ea728e2, "cancel", self, radius );
    radius = getdvarint( @"hash_4b9c923551b1ce98", 384 );
    function_d1ea9113f418f5c9( level.a_s_doorbuys, "start", self, radius );
    radius = getdvarint( @"hash_a3a462b54c20ecec", 384 );
    function_d1ea9113f418f5c9( level.var_e584ab91aed38e8c, "extract", self, radius );
    radius = getdvarint( @"hash_fc90220c7c2dbeb1", 384 );
    function_d1ea9113f418f5c9( ascenders, "vehicle", self, radius );
    radius = getdvarint( @"hash_19b8cf6533d2dfb6", 256 );
    function_d1ea9113f418f5c9( perkmachines, "radar", self, radius );
    radius = getdvarint( @"hash_d58dfd64693adaa8", 256 );
    function_d1ea9113f418f5c9( level.var_1bbb5557537e2c0c, "vehicle_enemy", self, radius );
}

// Namespace visibility_mode
// Params 4, eflags: 0x4
// Checksum 0xc1e013a0, Offset: 0x3956
// Size: 0x11d
function private function_d1ea9113f418f5c9( array, type, player, radius )
{
    if ( !isdefined( level.contentmanager.spawnedinstances ) )
    {
        return;
    }
    
    if ( !isdefined( player.origin ) )
    {
        return;
    }
    
    if ( !isdefined( radius ) || radius <= 0 )
    {
        return;
    }
    
    if ( isarray( array ) && array.size > 0 )
    {
        array = function_5713d46873b29625( array );
        nearbystructs = sortbydistancecullbyradius( array, player.origin, radius );
        
        foreach ( struct in nearbystructs )
        {
            level thread function_565d45c985c4983( struct.origin, player, type );
            wait 0.5;
        }
    }
}

// Namespace visibility_mode
// Params 3
// Checksum 0x3a088e67, Offset: 0x3a7b
// Size: 0xe4
function function_565d45c985c4983( origin, player, type = "objective" )
{
    level endon( #"game_ended" );
    
    if ( !origin || !player )
    {
        return;
    }
    
    scriptableoffset = ( 0, 0, 6 );
    droppos = utility::drop_to_ground( origin, 50, -256 );
    scriptable = spawnscriptable( "highvis_sound_assist", droppos + scriptableoffset );
    debugmode = getdvarint( @"hash_c4378fe2a51fb6cf", 0 );
    
    if ( !debugmode )
    {
        scriptable setscriptablepartstate( "type", type, 0 );
    }
    else
    {
        scriptable setscriptablepartstate( "type", "debug", 0 );
    }
    
    player utility::waittill_any_timeout( 3, "vis_focus_pressed" );
    scriptable freescriptable();
}

// Namespace visibility_mode
// Params 2
// Checksum 0x10d3245, Offset: 0x3b67
// Size: 0x115, Type: bool
function function_d8599342b7a75d3b( player, target )
{
    if ( !utility::within_fov( player.origin, player.angles, target.origin, 0.766 ) )
    {
        return false;
    }
    
    playereye = player geteye();
    feetorigin = target.origin;
    
    if ( sighttracepassed( playereye, feetorigin, 1, player, target ) )
    {
        return true;
    }
    
    eyeorigin = undefined;
    
    if ( isagent( target ) )
    {
        eyeorigin = target getapproxeyepos();
    }
    else if ( target.code_classname != "script_model" )
    {
        eyeorigin = target geteye();
    }
    
    if ( !eyeorigin )
    {
        eyeorigin = target.origin + ( 0, 0, 48 );
    }
    
    if ( sighttracepassed( playereye, eyeorigin, 1, player, target ) )
    {
        return true;
    }
    
    midorigin = ( eyeorigin + feetorigin ) * 0.5;
    
    if ( sighttracepassed( playereye, midorigin, 1, player, target ) )
    {
        return true;
    }
    
    return false;
}

// Namespace visibility_mode
// Params 1
// Checksum 0x5c3bf1d7, Offset: 0x3c85
// Size: 0x4d
function function_32528d31de35fd5a( isenabled )
{
    if ( isdefined( self.visibilitymode ) && isdefined( self.visibilitymode.enablevalue ) )
    {
        self.visibilitymode.enablevalue = isenabled;
    }
    
    visibilitymode_unpackvalue();
}

// Namespace visibility_mode
// Params 0
// Checksum 0x5af61b03, Offset: 0x3cda
// Size: 0x3d, Type: bool
function function_7037e2a45b50f307()
{
    if ( isdefined( self.visibilitymode ) && isdefined( self.visibilitymode.enablevalue ) )
    {
        return ( self.visibilitymode.enablevalue > 0 );
    }
    
    return false;
}

// Namespace visibility_mode
// Params 0
// Checksum 0x3ca5a793, Offset: 0x3d20
// Size: 0x4a
function function_9cbed71c0031704d()
{
    adsconfirm = 0;
    
    if ( isdefined( self.visibilitymode ) && isdefined( self.visibilitymode.adsconfirm ) )
    {
        adsconfirm = self.visibilitymode.adsconfirm;
    }
    
    return adsconfirm;
}

// Namespace visibility_mode
// Params 0
// Checksum 0x835c2b15, Offset: 0x3d73
// Size: 0x4a
function function_63e3a5209106205b()
{
    darkbackground = 0;
    
    if ( isdefined( self.visibilitymode ) && isdefined( self.visibilitymode.darkbackgroundvalue ) )
    {
        darkbackground = self.visibilitymode.darkbackgroundvalue;
    }
    
    return darkbackground;
}

// Namespace visibility_mode
// Params 0
// Checksum 0x65cb69e4, Offset: 0x3dc6
// Size: 0x4a
function function_f27d58dee524f7a9()
{
    soundassist = 0;
    
    if ( isdefined( self.visibilitymode ) && isdefined( self.visibilitymode.var_f267cef642aaada7 ) )
    {
        soundassist = self.visibilitymode.var_f267cef642aaada7;
    }
    
    return soundassist;
}

// Namespace visibility_mode
// Params 0
// Checksum 0xfed964c6, Offset: 0x3e19
// Size: 0x52
function function_7ab1306fcb9b0a70()
{
    all_targets = function_1260ba78b6caf0b2();
    return_targets = [];
    
    for ( i = 0; i < all_targets.size ; i++ )
    {
        if ( function_50b0ba3d0e90b5fa( all_targets[ i ], self ) )
        {
            return_targets[ return_targets.size ] = all_targets[ i ];
        }
    }
    
    return return_targets;
}

// Namespace visibility_mode
// Params 0
// Checksum 0xc59a6459, Offset: 0x3e74
// Size: 0x53
function function_956d237eca536d16()
{
    all_targets = function_1260ba78b6caf0b2();
    return_targets = [];
    
    for ( i = 0; i < all_targets.size ; i++ )
    {
        if ( !function_50b0ba3d0e90b5fa( all_targets[ i ], self ) )
        {
            return_targets[ return_targets.size ] = all_targets[ i ];
        }
    }
    
    return return_targets;
}

// Namespace visibility_mode
// Params 2
// Checksum 0x4777d4ab, Offset: 0x3ed0
// Size: 0xf2
function function_3afc3bc470c80e61( entity, team )
{
    if ( isdefined( level.visibilitymode ) && !isdefined( level.visibilitymode.forced_ents ) )
    {
        level.visibilitymode.forced_ents = [];
    }
    
    entity.visibilitymode_forced = 1;
    ent_number = entity getentitynumber();
    is_sub_team = is_sub_team( team );
    
    if ( entity.team != team || is_sub_team && entity.vismode_team != team )
    {
        if ( is_sub_team )
        {
            entity.vismode_team = team;
        }
        else
        {
            entity.team = team;
        }
        
        level.visibilitymode.forced_ents[ ent_number ] = entity;
        level thread function_bb482f50b96e9f78( team, entity );
    }
}

// Namespace visibility_mode
// Params 2, eflags: 0xc
// Checksum 0xec29e189, Offset: 0x3fca
// Size: 0x142
function private function_bb482f50b96e9f78( team, entity )
{
    self notify( #"hash_7635a2e4df5b0525" );
    self endon( #"hash_7635a2e4df5b0525" );
    
    if ( !isdefined( level.visibilitymode.queued_forced_ents[ team ] ) )
    {
        level.visibilitymode.queued_forced_ents[ team ] = [];
    }
    
    level.visibilitymode.queued_forced_ents[ team ] = arraycombineunique( level.visibilitymode.queued_forced_ents[ team ], [ entity ] );
    waittillframeend();
    
    foreach ( team, entities in level.visibilitymode.queued_forced_ents )
    {
        level notify( #"highvis_reload_outline", team, entities );
        level.visibilitymode.queued_forced_ents[ team ] = undefined;
        waittillframeend();
    }
    
    level.visibilitymode.queued_forced_ents = undefined;
}

// Namespace visibility_mode
// Params 1
// Checksum 0x683aa4d9, Offset: 0x4114
// Size: 0x6c
function function_4e6c654251b854e0( entity )
{
    if ( isdefined( entity ) )
    {
        ent_number = entity getentitynumber();
        
        if ( isdefined( level.visibilitymode ) && isdefined( level.visibilitymode.forced_ents[ ent_number ] ) )
        {
            entity.visibilitymode_forced = undefined;
            level.visibilitymode.forced_ents[ ent_number ] = undefined;
        }
    }
}

// Namespace visibility_mode
// Params 0
// Checksum 0xfc649f87, Offset: 0x4188
// Size: 0x102
function function_db9ed9dc5c19305b()
{
    if ( !checkshouldrun() )
    {
        return;
    }
    
    entity = self;
    model = entity.model;
    
    if ( entity.visibilitymode_forced )
    {
        return;
    }
    
    if ( isplayer( entity ) || isai( entity ) || issentient( entity ) )
    {
        return;
    }
    
    if ( level.gamemodebundle.cinematicconfig.var_cc7043a7245747c5 )
    {
        return;
    }
    
    if ( ( self tagexists( "TAG_EYE" ) || self tagexists( "j_head" ) ) && !function_871f14c9a14a562f( model ) )
    {
        if ( function_c975651ff9306a02( entity ) )
        {
            if ( !isdefined( entity.team ) )
            {
                return;
            }
            
            function_3afc3bc470c80e61( entity, entity.team );
            return;
        }
        
        if ( function_e02cacd8bca0c45c( model ) )
        {
            function_3afc3bc470c80e61( entity, "axis" );
            return;
        }
        
        function_3afc3bc470c80e61( entity, "allies" );
    }
}

// Namespace visibility_mode
// Params 1
// Checksum 0x548ab3f5, Offset: 0x4292
// Size: 0x18, Type: bool
function function_c975651ff9306a02( entity )
{
    return isdefined( entity.cratetype );
}

// Namespace visibility_mode
// Params 1, eflags: 0x4
// Checksum 0xf369deae, Offset: 0x42b3
// Size: 0x47
function private function_a3857bdb9f2178a( gametype )
{
    var_ec500ff53d4782ca = 1;
    
    switch ( gametype )
    {
        case #"hash_3d2b77174f6607a5":
            var_ec500ff53d4782ca = 0;
            break;
        default:
            break;
    }
    
    return var_ec500ff53d4782ca;
}

// Namespace visibility_mode
// Params 0, eflags: 0x4
// Checksum 0x41cffb6f, Offset: 0x4303
// Size: 0x20a
function private function_cba4789ea1db2c01()
{
    level endon( #"game_ended" );
    dvar = @"hash_5ecd08979278a317";
    
    while ( true )
    {
        var_e1f70dc44f099ae5 = getdvar( dvar, "" );
        
        if ( var_e1f70dc44f099ae5 != "" )
        {
            if ( var_e1f70dc44f099ae5 == "1" )
            {
                level.players[ 0 ].visibilitymode.enablevalue = 1;
                level.players[ 0 ].visibilitymode.enemytypevalue = 1;
                level.players[ 0 ].visibilitymode.outlinevalue = 0;
                level.players[ 0 ].visibilitymode.visibilitymode_outlineenabled = 1;
                level.players[ 0 ].visibilitymode.adsconfirm = 1;
                level.players[ 0 ].visibilitymode.darkbackgroundvalue = 1;
            }
            else
            {
                level.players[ 0 ].visibilitymode.enablevalue = 0;
                level.players[ 0 ].visibilitymode.enemytypevalue = 1;
                level.players[ 0 ].visibilitymode.outlinevalue = 0;
                level.players[ 0 ].visibilitymode.visibilitymode_outlineenabled = 1;
                level.players[ 0 ].visibilitymode.adsconfirm = 1;
                level.players[ 0 ].visibilitymode.darkbackgroundvalue = 1;
            }
            
            level thread function_67b4115ae46df95f( var_e1f70dc44f099ae5 );
            setdvar( dvar, "" );
        }
        
        wait 0.1;
    }
}

// Namespace visibility_mode
// Params 1, eflags: 0x4
// Checksum 0x30fcbfe8, Offset: 0x4515
// Size: 0x28
function private function_67b4115ae46df95f( val )
{
    val = int( val );
    level.players[ 0 ] visibilitymode_unpackvalue( val );
}

/#

    // Namespace visibility_mode
    // Params 0, eflags: 0x4
    // Checksum 0xe342c052, Offset: 0x4545
    // Size: 0xce, Type: dev
    function private function_32f2391e797f980b()
    {
        self_player = level.players[ 0 ];
        
        foreach ( ent in self )
        {
            if ( self_player != ent )
            {
                print3d( ent.origin + ( 0, 0, 75 ), ent.model, undefined, 1, 0.3, 300, 1 );
            }
        }
        
        setdevdvar( @"hash_b5ef409e5a4852e1", 0 );
    }

#/
