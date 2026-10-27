// scripts\mp\gametypes\escort_horde_abilities.gsc  (hash_3ed005fe9b78b9da.gscc) (size: 10637 Bytes / 0x298d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x51044e21 (1359236641)
// size ...... 10637 (0x298d)
// includes .. 8   (offset: 0x28c1)
// strings ... 7   (offset: 0x2901)
// dev strs .. 2   (offset: 0x2975)
// exports ... 25  (offset: 0x1da9)
// cseg ...... 0x14a + 0x1c5f (0x1da9)
// imports ... 54  (offset: 0x2191)
// animtree1 . 0   (offset: 0x298d)
// animtree2 . 0   (offset: 0x298d)
#using script_22b5518d4dea99e0;
#using script_33b83540dd41c31e;
#using script_39ae84cf3eeebf70;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;

#namespace escort_horde_abilities;

// Namespace escort_horde_abilities
// Params 0
// Checksum 0x6c7600e, Offset: 0x168
// Size: 0x6ae
function initpostmain()
{
    level.mutationgametype = spawnstruct();
    level.mutationgametype.zombiehealth = getdvarint( @"scr_br_zxp_health", 350 );
    level.mutationgametype.zombiesdamagezombies = getdvarint( @"hash_7d04136e229c6d7a", 0 );
    level.mutationgametype.var_c0c9d513c11ece4e = getdvarint( @"hash_8584a72dd6afa977", 80 );
    level.mutationgametype.zombiesignorevehicleexplosions = getdvarint( @"hash_9e8f30b569e2abe5", 1 );
    level.mutationgametype.var_c9a66d128bbd5327 = getdvarint( @"hash_3ad2f81e6e6cf99c", 1 );
    level.mutationgametype.zombiepingrate = getdvarfloat( @"hash_4dab1aaf5c7733be", -1 );
    level.mutationgametype.zombiepingtime = getdvarfloat( @"hash_35b72e2558f0a7cd", 0.5 );
    level.mutationgametype.zombienumtoconsume = getdvarint( @"hash_1322659ceb016a98", 4 );
    level.mutationgametype.zombieregenratescaleingas = getdvarfloat( @"hash_732dbd6ba0b0f252", 2 );
    level.mutationgametype.zombieregenratescaleoutgas = getdvarfloat( @"hash_dd936bdb4cf1f2ef", 0.7 );
    level.mutationgametype.zombieregendelayscaleingas = getdvarfloat( @"hash_c186667e8cb3bc6b", 1 );
    level.mutationgametype.zombieregendelayscaleoutgas = getdvarfloat( @"hash_b0687a8f2794f3b8", 1.5 );
    level.mutationgametype.zombiepowersenabled = getdvarint( @"scr_br_zxp_powers", 1 );
    level.mutationgametype.powerscooldown = getdvarint( @"hash_2546d85e9d039f6b", 1 );
    level.mutationgametype.zombienumhitshuman = getdvarfloat( @"hash_a08fd1aad589d41b", 3 );
    level.mutationgametype.var_840cd85046f1f281 = getdvarint( @"hash_6931def073d51e8c", 1 );
    level.mutationgametype.zombienumhitsheli = getdvarfloat( @"hash_8d24cf268d991c83", 2 );
    level.mutationgametype.zombienumhitsatv = getdvarfloat( @"hash_afb1f56ac422f668", 2 );
    level.mutationgametype.zombienumhitscar = getdvarfloat( @"hash_9162a16aad712f5b", 3 );
    level.mutationgametype.zombienumhitstruck = getdvarfloat( @"hash_5552790671b23f3e", 4 );
    level.mutationgametype.zombiespawninair = getdvarint( @"scr_br_zxp_spawn_air", 1 );
    level.mutationgametype.zombievehiclelaststand = getdvarint( @"hash_46634a326aa6bc5e", 0 );
    level.mutationgametype.zombiespawnabovedeath = getdvarint( @"hash_b2ccefcd02e5660f", 0 );
    level.mutationgametype.humanspawninair = getdvarint( @"hash_9ec879d1dafa798b", 1 );
    level.mutationgametype.buybackhuman = getdvarint( @"hash_1ee25065b4a3191c", 1 );
    level.mutationgametype.hudserver = getdvarint( @"hash_b5ac32636b6ff882", 0 );
    level.mutationgametype.var_ce078b9803c2e17c = getdvarint( @"hash_21fbbc29b9fecac8", 20 );
    level.mutationgametype.var_ce078e9803c2e815 = getdvarint( @"hash_31d8c8e967f4f20f", 30 );
    level.mutationgametype.zombievision = getdvarint( @"scr_br_zxp_zombie_vision", 1 );
    level.mutationgametype.zombievisionset = getdvar( @"hash_23bfd5f2a84eb6d8", "mp_zmb_pm" );
    level.mutationgametype.zombievisionoverlay = getdvarint( @"hash_fdb01d1a58dcdcb1", 1 );
    level.mutationgametype.var_6cd8119780fb7c65 = getdvarint( @"hash_8c5546e4f573664", 0 );
    level.mutationgametype.var_71bf464180667462 = getdvarfloat( @"hash_340b7eb839056345", 0.65 );
    level.mutationgametype.var_cc8abdbc87e6a778 = getdvarint( @"hash_a34f4bb4586ca7a6", 1 );
    level.mutationgametype.var_d1ad09fbb1aaadc8 = getdvarint( @"hash_77b0c9b7f8217be6", 1 );
    level.mutationgametype.var_b2d649e9d8f9838a = getdvarint( @"hash_4903cbd81395da65", 0 );
    level.mutationgametype.var_c1e0f16ed0b8fdcf = getdvarint( @"hash_ef3cf14423ea0971", 1 );
    level.mutationgametype.var_1eaef6af3ddd0b92 = getdvarfloat( @"hash_6db0c7f59c294cb4", 1 );
    level.mutationgametype.var_16c64f75da8b736c = getdvarfloat( @"hash_6715c45dd1cda5bf", 10 );
    level.mutationgametype.var_452fc3612df13f07 = getdvarfloat( @"hash_89b508dfec9fb80a", 15 );
    level.mutationgametype.var_f25225a855293950 = getdvarfloat( @"hash_f2bce8bff1023a79", 1.2 );
    level.mutationgametype.var_947af16d87b33e88 = getdvarfloat( @"hash_3a436a2eb1bd593", 2 );
    level.mutationgametype.var_257c3c462f02c580 = getdvarfloat( @"hash_3382204607436afe", 0.75 );
    level.mutationgametype.var_839039ea40a1f0ab = getdvarfloat( @"hash_add73918ea9fcaf8", 0.2 );
    level.mutationgametype.var_36d899986585686f = getdvarfloat( @"hash_c63870e71431980a", 1.2 );
    level.mutationgametype.var_47e0aeae104c21b9 = getdvarint( @"hash_345c19750d32d4a7", 0 );
    level.mutationgametype.var_4348c0d6a6617afc = getdvarfloat( @"hash_3489d22533419d85", 1 );
    waittillframeend();
    thread setupzombiepowers();
}

// Namespace escort_horde_abilities
// Params 0
// Checksum 0xbe6c3f2f, Offset: 0x81e
// Size: 0x64
function setupzombiepowers()
{
    level.mutationgametype.var_839039ea40a1f0ab = 5;
    level.mutationgametype.zombie = spawnstruct();
    level.mutationgametype.zombie.powers = [];
    namespace_168457380d58ba54::function_df64aacc56a216e9();
    namespace_af34561ae58dc984::function_2c1cc592752509c9();
    namespace_e1bdb0f108987648::function_cd777845c2baaf18();
}

// Namespace escort_horde_abilities
// Params 13
// Checksum 0x8a1a6ef4, Offset: 0x88a
// Size: 0x1e4
function addpowerbutton( powerstruct, powerref, keybindings, powerfunc, var_f75f4f9ed4c8267a, startupfunc, cleanupfunc, var_6212859c0ec125ab, label, labelpc, cooldownsec, statusupdate, progressupdate )
{
    powerdvar = hashcat( @"hash_b75ff36b09040395", powerref );
    
    if ( getdvarint( powerdvar, 1 ) == 0 )
    {
        return;
    }
    
    if ( isstring( keybindings ) )
    {
        keybindings = [ keybindings ];
    }
    
    powerstruct.powers[ powerref ] = spawnstruct();
    powerstruct.powers[ powerref ].bindings = keybindings;
    powerstruct.powers[ powerref ].func = powerfunc;
    powerstruct.powers[ powerref ].startupfunc = startupfunc;
    powerstruct.powers[ powerref ].cleanupfunc = cleanupfunc;
    powerstruct.powers[ powerref ].var_6212859c0ec125ab = var_6212859c0ec125ab;
    powerstruct.powers[ powerref ].label = label;
    powerstruct.powers[ powerref ].labelpc = labelpc;
    powerstruct.powers[ powerref ].cooldownsec = cooldownsec;
    powerstruct.powers[ powerref ].statusupdate = statusupdate;
    powerstruct.powers[ powerref ].progressupdate = progressupdate;
    powerstruct.powers[ powerref ].var_f75f4f9ed4c8267a = var_f75f4f9ed4c8267a;
}

// Namespace escort_horde_abilities
// Params 0
// Checksum 0xaefd7422, Offset: 0xa76
// Size: 0x34
function playerzombiepowers()
{
    if ( !level.mutationgametype.zombiepowersenabled )
    {
        return;
    }
    
    thread playerstartpowers( level.mutationgametype.zombie );
}

// Namespace escort_horde_abilities
// Params 1
// Checksum 0xc795cece, Offset: 0xab2
// Size: 0x107
function playerstartpowers( powerstruct )
{
    thread playerpowerssetupkeybindings( powerstruct );
    thread playerpowershud( powerstruct );
    thread playerpowersmonitorinput( powerstruct );
    
    if ( level.mutationgametype.hudserver )
    {
        thread playerpowersupdateongamepadchange( powerstruct );
    }
    
    thread function_acbc2fa8dc9563a6( powerstruct );
    thread playerpowerscleanup( powerstruct );
    
    foreach ( powerref, var_a6321458e70156a9 in powerstruct.powers )
    {
        if ( isdefined( powerstruct.powers[ powerref ].statusupdate ) )
        {
            function_d4df5ef344368edd( powerstruct.powers[ powerref ].statusupdate, 2 );
        }
    }
}

// Namespace escort_horde_abilities
// Params 1
// Checksum 0x8374024b, Offset: 0xbc1
// Size: 0x100
function playerpowerssetupkeybindings( powerstruct )
{
    if ( isbot( self ) )
    {
        return;
    }
    
    foreach ( powerref, var_a6321458e70156a9 in powerstruct.powers )
    {
        foreach ( binding in var_a6321458e70156a9.bindings )
        {
            self notifyonplayercommand( powerref, binding );
        }
    }
}

// Namespace escort_horde_abilities
// Params 1
// Checksum 0xda46a226, Offset: 0xcc9
// Size: 0x12e
function playerpowershud( powerstruct )
{
    var_41d8d8706170d8bd = 200;
    var_e86d1e7032b1e62b = 18;
    assert( !isdefined( self.powershud ) );
    currenthudy = var_41d8d8706170d8bd;
    self.powershud = [];
    
    foreach ( powerref, var_a6321458e70156a9 in powerstruct.powers )
    {
        if ( isdefined( var_a6321458e70156a9.label ) )
        {
            if ( level.mutationgametype.hudserver )
            {
            }
            else
            {
                self.powershud[ powerref ] = spawnstruct();
                self.powershud[ powerref ].frac = 0;
            }
            
            self.powershud[ powerref ].incooldown = 0;
            currenthudy += var_e86d1e7032b1e62b;
        }
    }
}

// Namespace escort_horde_abilities
// Params 1
// Checksum 0x5583713, Offset: 0xdff
// Size: 0x91
function playerpowersmonitorinput( powerstruct )
{
    if ( isbot( self ) )
    {
        return;
    }
    
    foreach ( powerref, var_a6321458e70156a9 in powerstruct.powers )
    {
        thread function_5b90c7a759e7e15a( powerstruct, powerref );
    }
}

// Namespace escort_horde_abilities
// Params 2
// Checksum 0xf2651603, Offset: 0xe98
// Size: 0xa7
function function_5b90c7a759e7e15a( powerstruct, powerref )
{
    self endon( #"death_or_disconnect" );
    self endon( #"zombie_unset" );
    self endon( #"zombie_set" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( powerref );
        waittillframeend();
        
        if ( isdefined( self.powershud[ powerref ] ) && self.powershud[ powerref ].incooldown )
        {
            function_22b061104142a21e();
            continue;
        }
        
        self thread [[ powerstruct.powers[ powerref ].func ]]( powerstruct, powerref );
    }
}

// Namespace escort_horde_abilities
// Params 1
// Checksum 0x1d079b43, Offset: 0xf47
// Size: 0x9f
function function_acbc2fa8dc9563a6( powerstruct )
{
    foreach ( powerref, var_a6321458e70156a9 in powerstruct.powers )
    {
        if ( isdefined( var_a6321458e70156a9.startupfunc ) )
        {
            self thread [[ var_a6321458e70156a9.startupfunc ]]( powerstruct, powerref );
        }
    }
}

// Namespace escort_horde_abilities
// Params 1
// Checksum 0xe655e165, Offset: 0xfee
// Size: 0x5e
function playerpowerscleanup( powerstruct )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    utility::waittill_any( "death", "zombie_unset", "zombie_set" );
    thread playerpowerresetpowers( powerstruct );
    thread playerpowerscleanupkeybindings( powerstruct );
    thread playerpowerscleanuppowers( powerstruct );
    thread playerpowerscleanuphud( powerstruct );
}

// Namespace escort_horde_abilities
// Params 1
// Checksum 0xcacea24c, Offset: 0x1054
// Size: 0x100
function playerpowerscleanupkeybindings( powerstruct )
{
    if ( isbot( self ) )
    {
        return;
    }
    
    foreach ( powerref, var_a6321458e70156a9 in powerstruct.powers )
    {
        foreach ( binding in var_a6321458e70156a9.bindings )
        {
            self notifyonplayercommandremove( powerref, binding );
        }
    }
}

// Namespace escort_horde_abilities
// Params 1
// Checksum 0x54729f60, Offset: 0x115c
// Size: 0x9f
function playerpowerscleanuppowers( powerstruct )
{
    foreach ( powerref, var_a6321458e70156a9 in powerstruct.powers )
    {
        if ( isdefined( var_a6321458e70156a9.cleanupfunc ) )
        {
            self thread [[ var_a6321458e70156a9.cleanupfunc ]]( powerstruct, powerref );
        }
    }
}

// Namespace escort_horde_abilities
// Params 1
// Checksum 0x31eee157, Offset: 0x1203
// Size: 0xd9
function playerpowerscleanuphud( powerstruct )
{
    if ( !isdefined( self.powershud ) )
    {
        return;
    }
    
    if ( level.mutationgametype.hudserver )
    {
        foreach ( hudelem in self.powershud )
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
    
    self.powershud = undefined;
}

// Namespace escort_horde_abilities
// Params 1
// Checksum 0x760b698d, Offset: 0x12e4
// Size: 0x41
function playerpowerresetpowers( powerstruct )
{
    if ( !( isdefined( powerstruct ) && isdefined( self.powershud ) ) )
    {
        return;
    }
    
    self notify( #"disablecooldown" );
    self.var_4b87dfb47bc432cc = undefined;
    self.var_4026b2b0e0c125b3 = undefined;
}

// Namespace escort_horde_abilities
// Params 1
// Checksum 0x4d632468, Offset: 0x132d
// Size: 0x1b6
function playerpowersupdateongamepadchange( powerstruct )
{
    level endon( #"game_ended" );
    self endon( #"zombie_unset" );
    self endon( #"zombie_set" );
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
                foreach ( powerref, var_a6321458e70156a9 in powerstruct.powers )
                {
                    if ( isdefined( var_a6321458e70156a9.labelpc ) )
                    {
                        self.powershud[ powerref ].label = var_a6321458e70156a9.label;
                    }
                }
            }
            else
            {
                foreach ( powerref, var_a6321458e70156a9 in powerstruct.powers )
                {
                    if ( isdefined( var_a6321458e70156a9.labelpc ) )
                    {
                        self.powershud[ powerref ].label = var_a6321458e70156a9.labelpc;
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Namespace escort_horde_abilities
// Params 0
// Checksum 0x5701abba, Offset: 0x14eb
// Size: 0x3e
function function_22b061104142a21e()
{
    if ( !isdefined( self.var_4b87dfb47bc432cc ) || gettime() > self.var_4b87dfb47bc432cc )
    {
        self playlocalsound( "fly_pickup_deny" );
        self.var_4b87dfb47bc432cc = gettime() + 1000;
    }
}

// Namespace escort_horde_abilities
// Params 2
// Checksum 0x10e69688, Offset: 0x1531
// Size: 0xce
function function_689938e798c377b5( powerstruct, powerref )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"zombie_unset" );
    
    if ( isdefined( powerstruct.powers[ powerref ].statusupdate ) )
    {
        function_d4df5ef344368edd( powerstruct.powers[ powerref ].statusupdate, 3 );
    }
    
    wait level.mutationgametype.var_839039ea40a1f0ab;
    
    if ( isdefined( powerstruct.powers[ powerref ].statusupdate ) )
    {
        function_d4df5ef344368edd( powerstruct.powers[ powerref ].statusupdate, 2 );
    }
}

// Namespace escort_horde_abilities
// Params 0
// Checksum 0x16f9b9cd, Offset: 0x1607
// Size: 0x96
function function_d0b3ca4f2beb76aa()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"zombie_unset" );
    self endon( #"hash_b05e9bc67fd87802" );
    
    if ( self isgestureplaying( "ges_zombie_superjumpcharge" ) )
    {
        return;
    }
    
    if ( weapon::grenadeinpullback() )
    {
        self canceloffhands();
    }
    
    while ( self ismantling() || self ismeleeing() )
    {
        waitframe();
    }
    
    self forceplaygestureviewmodel( "ges_zombie_superjumpcharge" );
    
    while ( self isgestureplaying( "ges_zombie_superjumpcharge" ) )
    {
        if ( self isonladder() )
        {
            self stopgestureviewmodel( "ges_zombie_superjumpcharge" );
            break;
        }
        
        waitframe();
    }
}

// Namespace escort_horde_abilities
// Params 2
// Checksum 0x6b136ff4, Offset: 0x16a5
// Size: 0x2b4
function playerpowerstartcooldown( powerstruct, powerref )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"zombie_unset" );
    self endon( #"zombie_set" );
    self endon( #"disablecooldown" );
    
    if ( !isdefined( self.powershud[ powerref ] ) || self.powershud[ powerref ].incooldown )
    {
        return;
    }
    
    powerhud = self.powershud[ powerref ];
    
    if ( level.mutationgametype.powerscooldown && powerhud.frac > 0 )
    {
        self.powershud[ powerref ].incooldown = 1;
        cooldownsec = powerstruct.powers[ powerref ].cooldownsec;
        cooldowndvar = hashcat( @"hash_a726fd9fdb5568e5", powerref );
        
        if ( getdvarint( cooldowndvar, 0 ) != 0 )
        {
            cooldownsec = getdvarint( cooldowndvar, 0 );
        }
        
        thread function_a81a416d6b884224( powerstruct, powerref, cooldownsec, int( powerhud.frac * 100 ) );
        fraction = powerhud.frac;
        cooldownsec *= fraction;
        
        if ( level.mutationgametype.hudserver )
        {
            powerhud.barelem.bar.color = ( 1, 0.6, 0 );
            powerhud.barelem.bar scaleovertime( cooldownsec, 0, powerhud.barelem.height );
        }
        
        wait cooldownsec;
        self.powershud[ powerref ].incooldown = 0;
    }
    else
    {
        if ( level.mutationgametype.hudserver )
        {
            powerhud.barelem hud_util::updatebar( 0, 0 );
        }
        else
        {
            powerhud.frac = 0;
        }
        
        thread function_a81a416d6b884224( powerstruct, powerref, 0, 0 );
    }
    
    if ( level.mutationgametype.hudserver )
    {
        powerhud.barelem.bar.color = ( 1, 1, 1 );
    }
    
    if ( isdefined( powerstruct.powers[ powerref ].var_6212859c0ec125ab ) )
    {
        self [[ powerstruct.powers[ powerref ].var_6212859c0ec125ab ]]( powerstruct, powerref );
    }
}

// Namespace escort_horde_abilities
// Params 4
// Checksum 0x6fee5c67, Offset: 0x1961
// Size: 0x196
function function_a81a416d6b884224( powerstruct, powerref, cooldownsec, startprogress )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"zombie_unset" );
    self endon( #"zombie_set" );
    self endon( #"disablecooldown" );
    
    if ( !( isdefined( powerstruct.powers[ powerref ].statusupdate ) && isdefined( powerstruct.powers[ powerref ].progressupdate ) ) )
    {
        return;
    }
    
    function_d4df5ef344368edd( powerstruct.powers[ powerref ].statusupdate, 1 );
    durationms = cooldownsec * 1000 * startprogress / 100;
    starttime = gettime();
    endtime = starttime + durationms;
    
    while ( gettime() < endtime )
    {
        tmptime = gettime();
        fraction = ( endtime - gettime() ) / durationms;
        progress = fraction * startprogress;
        function_d4df5ef344368edd( powerstruct.powers[ powerref ].progressupdate, int( progress ) );
        waitframe();
    }
    
    function_d4df5ef344368edd( powerstruct.powers[ powerref ].progressupdate, 0 );
    function_d4df5ef344368edd( powerstruct.powers[ powerref ].statusupdate, 2 );
}

// Namespace escort_horde_abilities
// Params 2
// Checksum 0x55622477, Offset: 0x1aff
// Size: 0x77
function function_307e8b021dbec2b9( powerstruct, powerref )
{
    if ( level.mutationgametype.hudserver )
    {
        self.powershud[ powerref ].barelem hud_util::updatebar( 1, 0 );
    }
    else
    {
        self.powershud[ powerref ].frac = 1;
    }
    
    thread playerpowerstartcooldown( powerstruct, powerref );
}

// Namespace escort_horde_abilities
// Params 1
// Checksum 0x524fab6f, Offset: 0x1b7e
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

// Namespace escort_horde_abilities
// Params 2
// Checksum 0x703f5bca, Offset: 0x1bc9
// Size: 0x1e0
function function_d4df5ef344368edd( dataref, value )
{
    if ( !level.mutationgametype.zombiepowersenabled )
    {
        return;
    }
    
    bitoffset = 0;
    bitwidth = 0;
    
    switch ( dataref )
    {
        case #"hash_6fdca435002399b7":
            bitoffset = 0;
            bitwidth = 2;
            break;
        case #"hash_903c3a93257a45fe":
            bitoffset = 2;
            bitwidth = 7;
            break;
        case #"hash_33f6e05f0765624c":
            bitoffset = 9;
            bitwidth = 3;
            break;
        case #"hash_11b1be2500f780fd":
            bitoffset = 12;
            bitwidth = 7;
            break;
        case #"hash_b2d5d8995a0d93ca":
            bitoffset = 19;
            bitwidth = 2;
            break;
        case #"hash_9af3d492597d7bbb":
            bitoffset = 21;
            bitwidth = 7;
            break;
        case #"hash_d4536c3cd58937a6":
            bitoffset = 28;
            bitwidth = 2;
            break;
        default:
            assertmsg( "<dev string:x24>" + dataref + "<dev string:x41>" );
            break;
    }
    
    if ( !isdefined( level.var_f18e2ee4e5f194aa ) )
    {
        level.var_f18e2ee4e5f194aa = [];
    }
    
    if ( !isdefined( level.var_f18e2ee4e5f194aa[ "ui_br_zombie_powers" ] ) )
    {
        level.var_f18e2ee4e5f194aa[ "ui_br_zombie_powers" ] = 0;
    }
    
    mask = ( 1 << bitwidth ) - 1;
    shiftedvalue = ( int( value ) & mask ) << bitoffset;
    invertedmask = ~( mask << bitoffset );
    prevvalue = self getclientomnvar( "ui_br_zombie_powers" );
    cleanedbase = prevvalue & invertedmask;
    repackedvalue = cleanedbase + shiftedvalue;
    level.var_f18e2ee4e5f194aa[ "ui_br_zombie_powers" ] = repackedvalue;
    self setclientomnvar( "ui_br_zombie_powers", level.var_f18e2ee4e5f194aa[ "ui_br_zombie_powers" ] );
}

