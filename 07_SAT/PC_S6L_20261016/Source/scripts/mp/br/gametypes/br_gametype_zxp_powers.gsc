// scripts\mp\br\gametypes\br_gametype_zxp_powers.gsc  (hash_64f55876c2ad2bc4.gscc) (size: 16237 Bytes / 0x3f6d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xda2eb5b6 (3660494262)
// size ...... 16237 (0x3f6d)
// includes .. 5   (offset: 0x3da5)
// strings ... 20  (offset: 0x3dcd)
// dev strs .. 11  (offset: 0x3edd)
// exports ... 57  (offset: 0x2aa5)
// cseg ...... 0x214 + 0x2891 (0x2aa5)
// imports ... 81  (offset: 0x338d)
// animtree1 . 0   (offset: 0x3f6d)
// animtree2 . 0   (offset: 0x3f6d)
#using scripts\common\omnvar_utility;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;

#namespace br_gametype_zxp_powers;

// Namespace br_gametype_zxp_powers
// Params 0
// Checksum 0xd217fa6c, Offset: 0x232
// Size: 0x279
function init()
{
    level.brgametype.var_4869a1c539b97cf2 = level.brgametype.zxp_bundle.var_9f9eb57439258ce1 ?? 0;
    level.brgametype.zombiepowersenabled = level.brgametype.zxp_bundle.var_8d8eea2989dda3bc ?? 1;
    level.brgametype.powerscooldown = level.brgametype.zxp_bundle.var_f3b9f29febba27a1 ?? 1;
    level.brgametype.powersdebugenabled = getdvarfloat( @"hash_66fb033f29a22243", 0 );
    level.brgametype.var_6fdbb99bad73e291 = level.brgametype.var_4869a1c539b97cf2 ? getscriptbundle( level.brgametype.zxp_bundle.var_85f6e135fae0393c ) : undefined;
    level.brgametype.var_b04769547eab39d6 = level.brgametype.zombiepowersenabled ? getscriptbundle( level.brgametype.zxp_bundle.var_ed1eb78211f5e559 ) : undefined;
    utility::registersharedfunc( #"hash_148ba717e47d4f0", #"hash_63b3a8864fc0b9a8", &function_a4b719095026092f );
    utility::registersharedfunc( #"hash_148ba717e47d4f0", #"hash_bdb447cf5b04990b", &function_421ee0f1a24a1902 );
    
    foreach ( var_d0b71da56d3bffc3 in level.var_3eb5e2cf3af35010 )
    {
        level [[ var_d0b71da56d3bffc3 ]]();
    }
    
    /#
        helptext = "<dev string:x24>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"zxp" ][ #"hash_85a22f6b187c113d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( #"hash_1bd6bd6108e4c8d5", &function_1b45132f8a781e57, helptext, "<dev string:xa5>", [ "<dev string:xac>" ] );
        }
    #/
}

// Namespace br_gametype_zxp_powers
// Params 3
// Checksum 0xe36a4c53, Offset: 0x4b3
// Size: 0x9c
function function_d7e68b6b7c00ea96( powerref, initfunc, addfunc )
{
    if ( !isdefined( level.var_3eb5e2cf3af35010 ) )
    {
        level.var_3eb5e2cf3af35010 = [];
    }
    
    assert( !isdefined( level.var_3eb5e2cf3af35010[ powerref ] ), "<dev string:xb4>" );
    level.var_3eb5e2cf3af35010[ powerref ] = initfunc;
    
    if ( !isdefined( level.var_814a8b11a293c48d ) )
    {
        level.var_814a8b11a293c48d = [];
    }
    
    assert( !isdefined( level.var_ee5b328b2240c3f6[ powerref ] ), "<dev string:xda>" );
    level.var_814a8b11a293c48d[ powerref ] = addfunc;
}

// Namespace br_gametype_zxp_powers
// Params 2
// Checksum 0x64818c39, Offset: 0x557
// Size: 0xab
function function_610981ca306934fb( var_85c4030f931a1353, var_ea228590fcc63d04 )
{
    var_1f0c75751688daf9 = hashcat( @"hash_a726fd9fdb5568e5", var_ea228590fcc63d04.powerref );
    var_4b33d0b482776af3 = getdvarint( var_1f0c75751688daf9, -1 );
    
    if ( var_4b33d0b482776af3 != -1 )
    {
        var_ea228590fcc63d04.cooldownsec = var_4b33d0b482776af3;
    }
    
    powerdvar = hashcat( @"hash_b75ff36b09040395", var_ea228590fcc63d04.powerref );
    
    if ( getdvarint( powerdvar, 1 ) == 0 )
    {
        return;
    }
    
    var_85c4030f931a1353.powers[ var_ea228590fcc63d04.powerref ] = var_ea228590fcc63d04;
}

// Namespace br_gametype_zxp_powers
// Params 1
// Checksum 0x3e259a95, Offset: 0x60a
// Size: 0x15
function playerstartpowers( powerconfig )
{
    function_5bb364abc71a074e( powerconfig );
}

// Namespace br_gametype_zxp_powers
// Params 0
// Checksum 0xf11a67bf, Offset: 0x627
// Size: 0x34
function function_ebc015e029431d71()
{
    if ( !level.brgametype.zombiepowersenabled )
    {
        return;
    }
    
    function_5bb364abc71a074e( level.brgametype.var_b04769547eab39d6 );
}

// Namespace br_gametype_zxp_powers
// Params 0
// Checksum 0xbad15e48, Offset: 0x663
// Size: 0x34
function function_a724de7ea99b9ece()
{
    if ( !level.brgametype.var_4869a1c539b97cf2 )
    {
        return;
    }
    
    function_5bb364abc71a074e( level.brgametype.var_6fdbb99bad73e291 );
}

// Namespace br_gametype_zxp_powers
// Params 1, eflags: 0x4
// Checksum 0xbf52db8e, Offset: 0x69f
// Size: 0x19d
function private function_5bb364abc71a074e( powerconfig )
{
    function_c4ee1afc2d60e20c();
    function_c9ca7f19ecf93983( self );
    self.var_94280b89fe4fe539 = { #powers:[] };
    var_85c4030f931a1353 = self.var_94280b89fe4fe539;
    
    foreach ( var_317db1041fa9de4c in level.var_814a8b11a293c48d )
    {
        level [[ var_317db1041fa9de4c ]]( powerconfig, var_85c4030f931a1353 );
    }
    
    playerpowerssetupkeybindings( var_85c4030f931a1353 );
    function_4a48d560ded9a6da( var_85c4030f931a1353 );
    playerpowersmonitorinput( var_85c4030f931a1353 );
    
    if ( level.brgametype.hudserver )
    {
        thread playerpowersupdateongamepadchange( var_85c4030f931a1353 );
    }
    
    function_acbc2fa8dc9563a6( var_85c4030f931a1353 );
    thread function_2a4c1931fd7cc77e( var_85c4030f931a1353 );
    function_d1ad29aa24a9d742( self );
    
    foreach ( powerref, var_a6321458e70156a9 in var_85c4030f931a1353.powers )
    {
        function_af84acdf64be2cbc( var_85c4030f931a1353, powerref );
        function_38eaf182c268aad3( var_85c4030f931a1353, powerref );
        function_df7cc2f38887f4a( var_85c4030f931a1353, powerref );
    }
}

// Namespace br_gametype_zxp_powers
// Params 1
// Checksum 0x321943c4, Offset: 0x844
// Size: 0x43
function function_37287d7567e2a847( errormessage )
{
    zombie = self;
    
    if ( !isplayer( zombie ) || !zombie br_public::playeriszombie() )
    {
        return;
    }
    
    if ( !isdefined( errormessage ) )
    {
        return;
    }
    
    zombie hud_message::showerrormessage( errormessage );
}

// Namespace br_gametype_zxp_powers
// Params 3
// Checksum 0xeacdb403, Offset: 0x88f
// Size: 0x91
function function_4a4781cd9a2f6969( var_85c4030f931a1353, powerref, var_6608a5fb52056564 )
{
    if ( isdefined( self.powerstates[ powerref ] ) )
    {
        if ( level.brgametype.hudserver )
        {
            self.powerstates[ powerref ].barelem hud_util::updatebar( 1, 0 );
        }
        else
        {
            self.powerstates[ powerref ].frac = 1;
        }
    }
    
    thread playerpowerstartcooldown( var_85c4030f931a1353, powerref, var_6608a5fb52056564 );
}

// Namespace br_gametype_zxp_powers
// Params 1, eflags: 0xc
// Checksum 0x325d807a, Offset: 0x928
// Size: 0x65
function private function_2a4c1931fd7cc77e( var_85c4030f931a1353 )
{
    self notify( #"hash_e418f0d2f8914f44" );
    self endon( #"hash_e418f0d2f8914f44" );
    level endon( #"game_ended" );
    self endon( #"powers_reset" );
    self endon( #"disconnect" );
    utility::waittill_any( "death", "zombie_unset", "zombie_set" );
    thread function_c4ee1afc2d60e20c();
}

// Namespace br_gametype_zxp_powers
// Params 0
// Checksum 0xc1c5ea15, Offset: 0x995
// Size: 0x47
function function_c4ee1afc2d60e20c()
{
    self notify( #"powers_reset" );
    var_85c4030f931a1353 = self.var_94280b89fe4fe539;
    playerpowerresetpowers( var_85c4030f931a1353 );
    playerpowerscleanupkeybindings( var_85c4030f931a1353 );
    playerpowerscleanuppowers( var_85c4030f931a1353 );
    playerpowerscleanuphud( var_85c4030f931a1353 );
}

// Namespace br_gametype_zxp_powers
// Params 1
// Checksum 0x4961d2df, Offset: 0x9e4
// Size: 0x100
function playerpowerssetupkeybindings( var_85c4030f931a1353 )
{
    if ( isbot( self ) )
    {
        return;
    }
    
    foreach ( powerref, var_a6321458e70156a9 in var_85c4030f931a1353.powers )
    {
        foreach ( binding in var_a6321458e70156a9.bindings )
        {
            self notifyonplayercommand( powerref, binding );
        }
    }
}

// Namespace br_gametype_zxp_powers
// Params 1
// Checksum 0x243dc950, Offset: 0xaec
// Size: 0xe9
function playerpowerscleanuphud( var_85c4030f931a1353 )
{
    if ( !isdefined( self.powerstates ) )
    {
        return;
    }
    
    function_ab90cd3a03c808d6( self );
    function_d1ad29aa24a9d742( self );
    
    if ( level.brgametype.hudserver )
    {
        foreach ( hudelem in self.powerstates )
        {
            if ( isdefined( hudelem ) )
            {
                if ( isdefined( hudelem.barelem ) )
                {
                    hudelem.barelem hud_util::destroyelem();
                }
                
                hudelem destroy();
            }
        }
    }
    
    self.powerstates = undefined;
}

// Namespace br_gametype_zxp_powers
// Params 1
// Checksum 0xe3a6eb0e, Offset: 0xbdd
// Size: 0x1ed
function function_4a48d560ded9a6da( var_85c4030f931a1353 )
{
    assert( !isdefined( self.powerstates ) );
    self.powerstates = [];
    
    if ( !level.brgametype.hudserver )
    {
        foreach ( powerref, var_a6321458e70156a9 in var_85c4030f931a1353.powers )
        {
            if ( isdefined( var_a6321458e70156a9.label ) )
            {
                self.powerstates[ powerref ] = { #activated:0, #var_e5b9a5b75a6eecfe:[], #incooldown:0, #frac:0 };
            }
        }
        
        return;
    }
    
    assertmsg( "<dev string:xff>" );
    currenthudy = 200;
    
    foreach ( powerref, var_a6321458e70156a9 in var_85c4030f931a1353.powers )
    {
        if ( isdefined( var_a6321458e70156a9.label ) )
        {
            if ( level.brgametype.hudserver )
            {
                self.powerstates[ powerref ] = playerpowersaddhudelem( var_a6321458e70156a9.label, var_a6321458e70156a9.labelpc, currenthudy, var_a6321458e70156a9.var_f75f4f9ed4c8267a );
                currenthudy += 18;
            }
            
            self.powerstates[ powerref ].incooldown = 0;
        }
    }
}

// Namespace br_gametype_zxp_powers
// Params 4
// Checksum 0xa8a01c12, Offset: 0xdd2
// Size: 0x219
function playerpowersaddhudelem( label, labelpc, currenthudy, var_f75f4f9ed4c8267a )
{
    hudelem = hud_util::createfontstring( "default", 1.5 );
    hudelem.x = 15;
    hudelem.y = currenthudy;
    hudelem.alignx = "left";
    hudelem.aligny = "top";
    hudelem.horzalign = "left_adjustable";
    hudelem.vertalign = "top_adjustable";
    hudelem.alpha = var_f75f4f9ed4c8267a;
    hudelem.glowalpha = 0;
    hudelem.hidewheninmenu = 1;
    hudelem.archived = 0;
    
    if ( isdefined( labelpc ) && !utility::is_player_gamepad_enabled() )
    {
        hudelem.label = labelpc;
    }
    else if ( isdefined( label ) )
    {
        hudelem.label = label;
    }
    
    barelem = hud_util::createbar( ( 1, 1, 1 ), 160, 14 );
    barelem.x = 13;
    barelem.y = currenthudy;
    barelem.alignx = "left";
    barelem.aligny = "top";
    barelem.horzalign = "left_adjustable";
    barelem.vertalign = "top_adjustable";
    barelem.alpha = var_f75f4f9ed4c8267a;
    barelem shiftbar();
    barelem.archived = 0;
    barelem.hidewheninmenu = 1;
    barelem.bar.archived = 0;
    barelem.bar.hidewheninmenu = 1;
    barelem.bar.alpha = var_f75f4f9ed4c8267a;
    hudelem.barelem = barelem;
    return hudelem;
}

// Namespace br_gametype_zxp_powers
// Params 4
// Checksum 0xa9990346, Offset: 0xff4
// Size: 0xf1
function shiftbar( point, relativepoint, xoffset, yoffset )
{
    self.bar.horzalign = self.horzalign;
    self.bar.vertalign = self.vertalign;
    self.bar.alignx = "left";
    self.bar.aligny = self.aligny;
    self.bar.y = self.y + 2;
    self.bar.x = self.x + 2;
    hud_util::updatebar( self.bar.frac );
}

// Namespace br_gametype_zxp_powers
// Params 1
// Checksum 0x9c41852e, Offset: 0x10ed
// Size: 0x100
function playerpowerscleanupkeybindings( var_85c4030f931a1353 )
{
    if ( isbot( self ) )
    {
        return;
    }
    
    foreach ( powerref, var_a6321458e70156a9 in var_85c4030f931a1353.powers )
    {
        foreach ( binding in var_a6321458e70156a9.bindings )
        {
            self notifyonplayercommandremove( powerref, binding );
        }
    }
}

// Namespace br_gametype_zxp_powers
// Params 1
// Checksum 0xe84a6f5d, Offset: 0x11f5
// Size: 0x9f
function playerpowerscleanuppowers( var_85c4030f931a1353 )
{
    foreach ( powerref, var_a6321458e70156a9 in var_85c4030f931a1353.powers )
    {
        if ( isdefined( var_a6321458e70156a9.cleanupfunc ) )
        {
            self thread [[ var_a6321458e70156a9.cleanupfunc ]]( var_85c4030f931a1353, powerref );
        }
    }
}

// Namespace br_gametype_zxp_powers
// Params 1
// Checksum 0x5e211ea3, Offset: 0x129c
// Size: 0x144
function playerpowerresetpowers( var_85c4030f931a1353 )
{
    if ( !( isdefined( var_85c4030f931a1353 ) && isdefined( self.powerstates ) ) )
    {
        return;
    }
    
    self notify( #"disablecooldown" );
    
    foreach ( powerref, var_a6321458e70156a9 in var_85c4030f931a1353.powers )
    {
        if ( !isdefined( self.powerstates[ powerref ] ) )
        {
            continue;
        }
        
        self.powerstates[ powerref ].incooldown = 0;
        function_4bf96813b31a1547( var_85c4030f931a1353, powerref, undefined );
        
        if ( level.brgametype.hudserver )
        {
            self.powerstates[ powerref ].barelem hud_util::updatebar( 0, 0 );
        }
        else
        {
            self.powerstates[ powerref ].frac = 0;
        }
        
        thread playerpowerstartcooldown( var_85c4030f931a1353, powerref );
    }
    
    self.var_4b87dfb47bc432cc = undefined;
    self.var_4026b2b0e0c125b3 = undefined;
}

// Namespace br_gametype_zxp_powers
// Params 1
// Checksum 0xc23e6a63, Offset: 0x13e8
// Size: 0x9f
function function_acbc2fa8dc9563a6( var_85c4030f931a1353 )
{
    foreach ( powerref, var_a6321458e70156a9 in var_85c4030f931a1353.powers )
    {
        if ( isdefined( var_a6321458e70156a9.startupfunc ) )
        {
            self thread [[ var_a6321458e70156a9.startupfunc ]]( var_85c4030f931a1353, powerref );
        }
    }
}

// Namespace br_gametype_zxp_powers
// Params 1
// Checksum 0xd3d78a18, Offset: 0x148f
// Size: 0x91
function playerpowersmonitorinput( var_85c4030f931a1353 )
{
    if ( isbot( self ) )
    {
        return;
    }
    
    foreach ( powerref, var_a6321458e70156a9 in var_85c4030f931a1353.powers )
    {
        thread function_5b90c7a759e7e15a( var_85c4030f931a1353, powerref );
    }
}

// Namespace br_gametype_zxp_powers
// Params 2, eflags: 0x4
// Checksum 0x6ba0dd24, Offset: 0x1528
// Size: 0xd1
function private function_5b90c7a759e7e15a( var_85c4030f931a1353, powerref )
{
    self endon( #"death_or_disconnect" );
    self endon( #"zombie_unset" );
    self endon( #"zombie_set" );
    self endon( #"powers_reset" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( powerref );
        waittillframeend();
        
        if ( isdefined( self.powerstates[ powerref ] ) )
        {
            if ( self.powerstates[ powerref ].incooldown )
            {
                function_22b061104142a21e();
                continue;
            }
            
            if ( function_9a109808f2d01428( self.powerstates[ powerref ] ) )
            {
                function_22b061104142a21e();
                continue;
            }
        }
        
        self thread [[ var_85c4030f931a1353.powers[ powerref ].func ]]( var_85c4030f931a1353, powerref );
    }
}

// Namespace br_gametype_zxp_powers
// Params 0
// Checksum 0x51517970, Offset: 0x1601
// Size: 0x3e
function function_22b061104142a21e()
{
    if ( !isdefined( self.var_4b87dfb47bc432cc ) || gettime() > self.var_4b87dfb47bc432cc )
    {
        self playlocalsound( "zxp_power_deny" );
        self.var_4b87dfb47bc432cc = gettime() + 1000;
    }
}

// Namespace br_gametype_zxp_powers
// Params 1, eflags: 0xc
// Checksum 0xcf340ad6, Offset: 0x1647
// Size: 0x1da
function private playerpowersupdateongamepadchange( var_85c4030f931a1353 )
{
    self notify( #"hash_275391ea41df1ec1" );
    self endon( #"hash_275391ea41df1ec1" );
    level endon( #"game_ended" );
    self endon( #"zombie_unset" );
    self endon( #"zombie_set" );
    self endon( #"powers_reset" );
    self endon( #"death_or_disconnect" );
    
    if ( isbot( self ) )
    {
        return;
    }
    
    waittillframeend();
    lastgamepad = utility::is_player_gamepad_enabled();
    
    while ( true )
    {
        nowgamepad = utility::is_player_gamepad_enabled();
        
        if ( nowgamepad != lastgamepad )
        {
            lastgamepad = nowgamepad;
            
            if ( nowgamepad )
            {
                foreach ( powerref, var_a6321458e70156a9 in var_85c4030f931a1353.powers )
                {
                    if ( isdefined( var_a6321458e70156a9.labelpc ) )
                    {
                        self.powerstates[ powerref ].label = var_a6321458e70156a9.label;
                    }
                }
            }
            else
            {
                foreach ( powerref, var_a6321458e70156a9 in var_85c4030f931a1353.powers )
                {
                    if ( isdefined( var_a6321458e70156a9.labelpc ) )
                    {
                        self.powerstates[ powerref ].label = var_a6321458e70156a9.labelpc;
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Namespace br_gametype_zxp_powers
// Params 4
// Checksum 0x334d7f0, Offset: 0x1829
// Size: 0x355
function playerpowerstartcooldown( var_85c4030f931a1353, powerref, var_6608a5fb52056564, var_3a3468101a11e20c )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"zombie_unset" );
    self endon( #"zombie_set" );
    self endon( #"powers_reset" );
    self endon( #"disablecooldown" );
    self endon( "disableCooldown_" + powerref );
    
    if ( !isdefined( self.powerstates[ powerref ] ) || self.powerstates[ powerref ].incooldown )
    {
        return;
    }
    
    var_6a555b6584067b50 = self.powerstates[ powerref ];
    var_dfd7b191a30cb7d0 = var_3a3468101a11e20c ? var_6a555b6584067b50.frac == 1 : var_6a555b6584067b50.frac == 0;
    
    if ( level.brgametype.powerscooldown && !var_dfd7b191a30cb7d0 )
    {
        var_6a555b6584067b50.incooldown = 1;
        cooldownsec = var_6608a5fb52056564 ?? var_85c4030f931a1353.powers[ powerref ].cooldownsec;
        function_af84acdf64be2cbc( var_85c4030f931a1353, powerref );
        thread function_ac4030019ee70591( var_85c4030f931a1353, powerref, cooldownsec, int( var_6a555b6584067b50.frac * 100 ), var_3a3468101a11e20c );
        fraction = var_6a555b6584067b50.frac;
        
        if ( var_3a3468101a11e20c )
        {
            cooldownsec *= 1 - fraction;
        }
        else
        {
            cooldownsec *= fraction;
        }
        
        if ( level.brgametype.hudserver )
        {
            var_6a555b6584067b50.barelem.bar.color = ( 1, 0.6, 0 );
            var_6a555b6584067b50.barelem.bar scaleovertime( cooldownsec, 0, var_6a555b6584067b50.barelem.height );
        }
        
        wait cooldownsec;
        
        if ( var_85c4030f931a1353.powers[ powerref ].readysound )
        {
            self playlocalsound( var_85c4030f931a1353.powers[ powerref ].readysound );
        }
        else
        {
            readysound = "zxp_restock_" + powerref;
            self playlocalsound( readysound );
        }
        
        if ( var_6a555b6584067b50 )
        {
            var_6a555b6584067b50.incooldown = 0;
        }
        
        function_af84acdf64be2cbc( var_85c4030f931a1353, powerref );
    }
    else
    {
        if ( level.brgametype.hudserver )
        {
            var_6a555b6584067b50.barelem hud_util::updatebar( 0, 0 );
        }
        else
        {
            var_6a555b6584067b50.frac = 0;
        }
        
        function_af84acdf64be2cbc( var_85c4030f931a1353, powerref );
        thread function_ac4030019ee70591( var_85c4030f931a1353, powerref, 0, 0 );
    }
    
    if ( level.brgametype.hudserver )
    {
        var_6a555b6584067b50.barelem.bar.color = ( 1, 1, 1 );
    }
    
    if ( isdefined( var_85c4030f931a1353.powers[ powerref ].var_6212859c0ec125ab ) )
    {
        self [[ var_85c4030f931a1353.powers[ powerref ].var_6212859c0ec125ab ]]( var_85c4030f931a1353, powerref );
    }
}

// Namespace br_gametype_zxp_powers
// Params 5
// Checksum 0xc50571a2, Offset: 0x1b86
// Size: 0x190
function function_ac4030019ee70591( var_85c4030f931a1353, powerref, cooldownsec, startprogress, var_3a3468101a11e20c )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"zombie_unset" );
    self endon( #"zombie_set" );
    self endon( #"powers_reset" );
    self endon( #"disablecooldown" );
    self endon( "disableCooldown_" + powerref );
    powerdefinition = var_85c4030f931a1353.powers[ powerref ];
    
    if ( !( powerdefinition.statusupdate && powerdefinition.progressupdate ) )
    {
        return;
    }
    
    if ( var_3a3468101a11e20c )
    {
        durationms = cooldownsec * 1000 * ( 1 - startprogress / 100 );
    }
    else
    {
        durationms = cooldownsec * 1000 * startprogress / 100;
    }
    
    starttime = gettime();
    endtime = starttime + durationms;
    
    while ( gettime() < endtime )
    {
        fraction = ( endtime - gettime() ) / durationms;
        
        if ( var_3a3468101a11e20c )
        {
            progress = startprogress + ( 1 - fraction ) * ( 100 - startprogress );
        }
        else
        {
            progress = fraction * startprogress;
        }
        
        function_3ab073b524e4a1df( powerdefinition.slotindex, int( progress ) );
        waitframe();
    }
    
    finalprogress = var_3a3468101a11e20c ? 100 : 0;
    function_3ab073b524e4a1df( powerdefinition.slotindex, finalprogress );
}

// Namespace br_gametype_zxp_powers
// Params 1
// Checksum 0xa1f16db4, Offset: 0x1d1e
// Size: 0x93
function function_15f36548dabd03ea( powerref )
{
    self notify( "disableCooldown_" + powerref );
    var_6a555b6584067b50 = self.powerstates[ powerref ];
    var_6a555b6584067b50.frac = 1;
    var_6a555b6584067b50.incooldown = 0;
    var_85c4030f931a1353 = function_65dc1d2023eb2274();
    powerdefinition = var_85c4030f931a1353.powers[ powerref ];
    function_af84acdf64be2cbc( var_85c4030f931a1353, powerref );
    function_3ab073b524e4a1df( powerdefinition.slotindex, 100 );
}

// Namespace br_gametype_zxp_powers
// Params 1
// Checksum 0xdf2de514, Offset: 0x1db9
// Size: 0xa7
function function_b6f9e679d0f1df84( var_85c4030f931a1353 )
{
    if ( !isdefined( var_85c4030f931a1353 ) )
    {
        return;
    }
    
    self notify( #"disablecooldown" );
    
    foreach ( powerref, var_6a555b6584067b50 in self.powerstates )
    {
        var_6a555b6584067b50.incooldown = 0;
        function_4a4781cd9a2f6969( var_85c4030f931a1353, powerref );
    }
}

// Namespace br_gametype_zxp_powers
// Params 3
// Checksum 0x8bf7bfd2, Offset: 0x1e68
// Size: 0x43
function function_b34019a82c0e9d94( var_85c4030f931a1353, powerref, reason )
{
    self.powerstates[ powerref ].var_e5b9a5b75a6eecfe[ reason ] = 1;
    function_af84acdf64be2cbc( var_85c4030f931a1353, powerref );
}

// Namespace br_gametype_zxp_powers
// Params 2
// Checksum 0x3b666359, Offset: 0x1eb3
// Size: 0xb2
function function_8ec4b203b0296c79( var_85c4030f931a1353, var_bf9d1db37a399fce )
{
    foreach ( powerref, var_a6321458e70156a9 in var_85c4030f931a1353.powers )
    {
        if ( powerref == var_bf9d1db37a399fce )
        {
            continue;
        }
        
        if ( isdefined( var_a6321458e70156a9.cancelfunc ) )
        {
            self thread [[ var_a6321458e70156a9.cancelfunc ]]( var_85c4030f931a1353, powerref );
        }
    }
}

// Namespace br_gametype_zxp_powers
// Params 2
// Checksum 0xf92cfab3, Offset: 0x1f6d
// Size: 0x32
function function_a4b719095026092f( reason, var_dd0216d54db74c59 )
{
    var_85c4030f931a1353 = function_65dc1d2023eb2274();
    function_d3f171b57aea7986( var_85c4030f931a1353, reason, var_dd0216d54db74c59 );
}

// Namespace br_gametype_zxp_powers
// Params 3, eflags: 0x4
// Checksum 0x1ab564f9, Offset: 0x1fa7
// Size: 0xa3
function private function_d3f171b57aea7986( var_85c4030f931a1353, reason, var_dd0216d54db74c59 )
{
    foreach ( powerref, var_6a555b6584067b50 in self.powerstates )
    {
        if ( powerref == var_dd0216d54db74c59 )
        {
            continue;
        }
        
        function_b34019a82c0e9d94( var_85c4030f931a1353, powerref, reason );
    }
}

// Namespace br_gametype_zxp_powers
// Params 1
// Checksum 0x18bca745, Offset: 0x2052
// Size: 0x28
function function_421ee0f1a24a1902( reason )
{
    var_85c4030f931a1353 = function_65dc1d2023eb2274();
    function_8688b57b97503f8f( var_85c4030f931a1353, reason );
}

// Namespace br_gametype_zxp_powers
// Params 2
// Checksum 0xeb396864, Offset: 0x2082
// Size: 0x9a
function function_8688b57b97503f8f( var_85c4030f931a1353, reason )
{
    if ( !isdefined( var_85c4030f931a1353 ) )
    {
        return;
    }
    
    foreach ( powerref, var_a6321458e70156a9 in var_85c4030f931a1353.powers )
    {
        function_4bf96813b31a1547( var_85c4030f931a1353, powerref, reason );
    }
}

// Namespace br_gametype_zxp_powers
// Params 3
// Checksum 0xc5b4974d, Offset: 0x2124
// Size: 0x7d
function function_4bf96813b31a1547( var_85c4030f931a1353, powerref, reason )
{
    if ( isdefined( reason ) )
    {
        if ( isdefined( self.powerstates[ powerref ].var_e5b9a5b75a6eecfe[ reason ] ) )
        {
            self.powerstates[ powerref ].var_e5b9a5b75a6eecfe[ reason ] = undefined;
        }
    }
    else
    {
        self.powerstates[ powerref ].var_e5b9a5b75a6eecfe = [];
    }
    
    function_af84acdf64be2cbc( var_85c4030f931a1353, powerref );
}

// Namespace br_gametype_zxp_powers
// Params 1
// Checksum 0xfb26012a, Offset: 0x21a9
// Size: 0x21, Type: bool
function function_9a109808f2d01428( var_6a555b6584067b50 )
{
    if ( var_6a555b6584067b50.var_e5b9a5b75a6eecfe.size > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace br_gametype_zxp_powers
// Params 3
// Checksum 0xdc78b7b3, Offset: 0x21d3
// Size: 0x43
function function_d785b71af0397fc8( var_85c4030f931a1353, powerref, reason )
{
    self.powerstates[ powerref ].var_dc826a07992adaee[ reason ] = 1;
    function_af84acdf64be2cbc( var_85c4030f931a1353, powerref );
}

// Namespace br_gametype_zxp_powers
// Params 1
// Checksum 0x357e6cfb, Offset: 0x221e
// Size: 0x1b
function function_ab90cd3a03c808d6( player )
{
    player function_d4df5ef344368edd( "powersReady", 0 );
}

// Namespace br_gametype_zxp_powers
// Params 1
// Checksum 0x50609317, Offset: 0x2241
// Size: 0x1c
function function_c9ca7f19ecf93983( player )
{
    player function_d4df5ef344368edd( "powersReady", 1 );
}

// Namespace br_gametype_zxp_powers
// Params 2
// Checksum 0xb51aca86, Offset: 0x2265
// Size: 0x54
function function_df7cc2f38887f4a( var_85c4030f931a1353, powerref )
{
    powerdefinition = var_85c4030f931a1353.powers[ powerref ];
    
    if ( !isdefined( powerdefinition.slotindex ) )
    {
        return;
    }
    
    function_a3f3447dd7da5504( powerdefinition.slotindex, 1 );
}

// Namespace br_gametype_zxp_powers
// Params 1
// Checksum 0xca99a339, Offset: 0x22c1
// Size: 0x2f
function function_d1ad29aa24a9d742( player )
{
    player function_a3f3447dd7da5504( 0, 0 );
    player function_a3f3447dd7da5504( 1, 0 );
    player function_a3f3447dd7da5504( 2, 0 );
}

// Namespace br_gametype_zxp_powers
// Params 2
// Checksum 0xc620d8da, Offset: 0x22f8
// Size: 0xd6
function function_af84acdf64be2cbc( var_85c4030f931a1353, powerref )
{
    powerdefinition = var_85c4030f931a1353.powers[ powerref ];
    
    if ( !powerdefinition.statusupdate )
    {
        return;
    }
    
    currentstate = self.powerstates[ powerref ];
    var_75e8a2de6d255dc1 = 3;
    
    if ( currentstate.activated )
    {
        var_75e8a2de6d255dc1 = 0;
        currentstate.activated = 0;
    }
    else if ( currentstate.var_7e519ef80e3712e8 )
    {
        var_75e8a2de6d255dc1 = 3;
    }
    else if ( function_9a109808f2d01428( currentstate ) )
    {
        var_75e8a2de6d255dc1 = 3;
    }
    else if ( currentstate.incooldown )
    {
        var_75e8a2de6d255dc1 = 1;
    }
    else
    {
        var_75e8a2de6d255dc1 = 2;
    }
    
    function_60f0f6e8d7e1bdaa( powerdefinition.slotindex, var_75e8a2de6d255dc1 );
}

// Namespace br_gametype_zxp_powers
// Params 2
// Checksum 0xa87c5b09, Offset: 0x23d6
// Size: 0x5d
function function_38eaf182c268aad3( var_85c4030f931a1353, powerref )
{
    powerdefinition = var_85c4030f931a1353.powers[ powerref ];
    
    if ( !isdefined( powerdefinition.powerdef ) )
    {
        return;
    }
    
    function_cd658085967d2fd9( powerdefinition.slotindex, powerdefinition.powerdef );
}

// Namespace br_gametype_zxp_powers
// Params 2
// Checksum 0xe6a8d89b, Offset: 0x243b
// Size: 0xa6
function function_ac5c439657c767ce( var_85c4030f931a1353, powerref )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"zombie_unset" );
    self.powerstates[ powerref ].var_7e519ef80e3712e8 = 1;
    function_af84acdf64be2cbc( var_85c4030f931a1353, powerref );
    wait var_85c4030f931a1353.powers[ powerref ].errorsec ?? 1;
    self.powerstates[ powerref ].var_7e519ef80e3712e8 = 0;
    function_af84acdf64be2cbc( var_85c4030f931a1353, powerref );
}

// Namespace br_gametype_zxp_powers
// Params 2
// Checksum 0xc1454e2a, Offset: 0x24e9
// Size: 0x25
function function_a3f3447dd7da5504( slot, value )
{
    function_1fe81854fd176aa3( slot, "visibility", value );
}

// Namespace br_gametype_zxp_powers
// Params 2
// Checksum 0x21c34142, Offset: 0x2516
// Size: 0x25
function function_60f0f6e8d7e1bdaa( slot, value )
{
    function_1fe81854fd176aa3( slot, "status", value );
}

// Namespace br_gametype_zxp_powers
// Params 2
// Checksum 0xab1cd0e3, Offset: 0x2543
// Size: 0x25
function function_3ab073b524e4a1df( slot, value )
{
    function_1fe81854fd176aa3( slot, "progress", value );
}

// Namespace br_gametype_zxp_powers
// Params 2
// Checksum 0x8c43c14a, Offset: 0x2570
// Size: 0x25
function function_cd658085967d2fd9( slot, value )
{
    function_1fe81854fd176aa3( slot, "definition", value );
}

// Namespace br_gametype_zxp_powers
// Params 3, eflags: 0x4
// Checksum 0xc7f19609, Offset: 0x259d
// Size: 0x15d
function private function_1fe81854fd176aa3( slotindex, section, value )
{
    if ( !level.brgametype.zombiepowersenabled )
    {
        return;
    }
    
    slot = undefined;
    
    switch ( slotindex )
    {
        case 0:
            slot = "ui_br_zombie_power_1";
            break;
        case 1:
            slot = "ui_br_zombie_power_2";
            break;
        case 2:
            slot = "ui_br_zombie_power_3";
            break;
        default:
            assertmsg( "<dev string:x134>" + slot + "<dev string:x158>" );
            return;
    }
    
    bitoffset = 0;
    bitwidth = 0;
    
    switch ( section )
    {
        case #"hash_b13e097e126fe04f":
            bitoffset = 0;
            bitwidth = 3;
            break;
        case #"hash_51525754cd42cda6":
            bitoffset = 3;
            bitwidth = 7;
            break;
        case #"hash_92abaef4d9086000":
            bitoffset = 10;
            bitwidth = 4;
            break;
        case #"hash_6ece378fb0d19f45":
            bitoffset = 14;
            bitwidth = 1;
            break;
        default:
            assertmsg( "<dev string:x18b>" + section + "<dev string:x158>" );
            return;
    }
    
    omnvar_utility::function_85d5f88af471ac4b( slot, bitoffset, bitwidth, value );
}

// Namespace br_gametype_zxp_powers
// Params 2
// Checksum 0x357a13fc, Offset: 0x2702
// Size: 0x139
function function_d4df5ef344368edd( var_60b1f505356b5ab2, value )
{
    if ( !level.brgametype.zombiepowersenabled )
    {
        return;
    }
    
    bitoffset = 0;
    bitwidth = 0;
    
    switch ( var_60b1f505356b5ab2 )
    {
        case #"hash_454eab6dc3ba2285":
            bitoffset = 0;
            bitwidth = 2;
            break;
        case #"hash_7e76a94af62af94c":
            bitoffset = 2;
            bitwidth = 7;
            break;
        case #"hash_b18d42393437146":
            bitoffset = 9;
            bitwidth = 2;
            break;
        case #"hash_5c836c9829b3b717":
            bitoffset = 11;
            bitwidth = 7;
            break;
        case #"hash_7a6bb41efbe2232f":
            bitoffset = 18;
            bitwidth = 2;
            break;
        case #"hash_1edab4eb02ac8786":
            bitoffset = 20;
            bitwidth = 7;
            break;
        case #"hash_d4536c3cd58937a6":
            bitoffset = 27;
            bitwidth = 2;
            break;
        case #"hash_9f270a11fc7b757e":
            bitoffset = 29;
            bitwidth = 1;
            break;
        default:
            assertmsg( "<dev string:x18b>" + var_60b1f505356b5ab2 + "<dev string:x158>" );
            return;
    }
    
    omnvar_utility::function_85d5f88af471ac4b( "ui_br_zombie_powers", bitoffset, bitwidth, value );
}

// Namespace br_gametype_zxp_powers
// Params 2
// Checksum 0x7ffa2847, Offset: 0x2843
// Size: 0x21
function function_fc58af0f234f72ec( var_85c4030f931a1353, powerref )
{
    self notify( #"hash_7843353318e75213" );
}

// Namespace br_gametype_zxp_powers
// Params 2
// Checksum 0xd16f2090, Offset: 0x286c
// Size: 0xa5
function function_dc697270e5160670( var_85c4030f931a1353, powerref )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self notify( #"hash_7843353318e75213" );
    self endon( #"hash_7843353318e75213" );
    endtime = gettime() + getdvarint( @"hash_64480c2e87bc9a43", 500 );
    
    while ( endtime > gettime() )
    {
        if ( self secondaryoffhandbuttonpressed() )
        {
            self notify( #"gas" );
            break;
        }
        else if ( self fragbuttonpressed() )
        {
            self notify( #"shout" );
            break;
        }
        
        waitframe();
    }
}

// Namespace br_gametype_zxp_powers
// Params 1
// Checksum 0x4bf33186, Offset: 0x2919
// Size: 0x23, Type: bool
function function_c2d36f2299005e51( powerref )
{
    return isdefined( self.var_94280b89fe4fe539.powers[ powerref ] );
}

// Namespace br_gametype_zxp_powers
// Params 2
// Checksum 0x838a2ba8, Offset: 0x2945
// Size: 0x2d
function function_e31e15051710421e( definitions, powerref )
{
    return definitions.powers[ powerref ].powertuning;
}

// Namespace br_gametype_zxp_powers
// Params 0
// Checksum 0xfbbbdfb5, Offset: 0x297b
// Size: 0xb
function function_65dc1d2023eb2274()
{
    return self.var_94280b89fe4fe539;
}

/#

    // Namespace br_gametype_zxp_powers
    // Params 2, eflags: 0x4
    // Checksum 0xc437c4c6, Offset: 0x298f
    // Size: 0x116, Type: dev
    function private function_1b45132f8a781e57( host, args )
    {
        if ( !isdefined( host ) )
        {
            return;
        }
        
        switch ( args[ 1 ] )
        {
            case #"hash_f496eb6c03c5836c":
                host function_cd658085967d2fd9( int( args[ 2 ] ), int( args[ 3 ] ) );
                break;
            case #"hash_23b3bc8a2f9265f7":
                host function_60f0f6e8d7e1bdaa( int( args[ 2 ] ), int( args[ 3 ] ) );
                break;
            case #"hash_38e40184ee4a478d":
                host function_3ab073b524e4a1df( int( args[ 2 ] ), int( args[ 3 ] ) );
                break;
            case #"hash_7b0c5a6c4a7e4d49":
                host function_a3f3447dd7da5504( int( args[ 2 ] ), int( args[ 3 ] ) );
                break;
            case #"hash_a73f02e5ad40fb85":
                host function_d4df5ef344368edd( "<dev string:x1ca>", int( args[ 2 ] ) );
                break;
            case #"hash_e903a52e39e0d6bb":
                host function_d4df5ef344368edd( "<dev string:x1dd>", int( args[ 2 ] ) );
                break;
        }
    }

#/
