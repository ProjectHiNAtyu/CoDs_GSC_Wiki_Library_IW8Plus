// scripts\mp\zm\ztron\ztron_achievements.gsc  (hash_7351e559bd3fb92e.gscc) (size: 3190 Bytes / 0xc76 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x22a9c18a (581550474)
// size ...... 3190 (0xc76)
// includes .. 5   (offset: 0xbd6)
// strings ... 4   (offset: 0xbfe)
// dev strs .. 6   (offset: 0xc2e)
// exports ... 11  (offset: 0x6aa)
// cseg ...... 0xb1 + 0x5f9 (0x6aa)
// imports ... 29  (offset: 0x862)
// animtree1 . 0   (offset: 0xc76)
// animtree2 . 0   (offset: 0xc76)
#using scripts\common\achievements\sat_achievements;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\mp\challenges;

#namespace ztron_achievements;

// Namespace ztron_achievements
// Params 0
// Checksum 0x3ec8b957, Offset: 0xcf
// Size: 0x32
function init()
{
    if ( level.ztron.cabinetmode )
    {
        return;
    }
    
    level callback::add( "player_match_end", &function_ec69210ff289630e );
    thread initdelayed();
}

// Namespace ztron_achievements
// Params 0
// Checksum 0xdbdd6e1f, Offset: 0x109
// Size: 0x29
function initdelayed()
{
    waitframe();
    callback::add( #"hash_6c71d319dc089c27", &function_4097242dc269636e );
    sat_achievements::function_e3b9dbbabcedac0a();
    
    /#
        thread init_devgui();
    #/
}

// Namespace ztron_achievements
// Params 1
// Checksum 0x3bdbc15f, Offset: 0x13a
// Size: 0xe7
function function_4097242dc269636e( params )
{
    event = params.event;
    player = params.player;
    
    if ( !sat_achievements::function_d105e100bc8affcf( player ) )
    {
        return;
    }
    
    if ( player.ztron.var_8103a5c573d38485 )
    {
        return;
    }
    
    switch ( event )
    {
        case #"zm_on_gobblegum_consumed":
            player sat_achievements::function_89dedee6aef63ffd( params );
            break;
        case #"sat_doa_foreverfated":
            player function_1105733d932ce839( "sat_doa_foreverfated", 1 );
            break;
        case #"sat_doa_fowlfivepiece":
            player function_1105733d932ce839( "sat_doa_fowlfivepiece", 1 );
            break;
        case #"sat_doa_reunited":
            player function_1105733d932ce839( "sat_doa_reunited", 1 );
            break;
        default:
            break;
    }
}

// Namespace ztron_achievements
// Params 0, eflags: 0x4
// Checksum 0x5793705b, Offset: 0x229
// Size: 0xe, Type: bool
function private function_8643e6764ef43db9()
{
    if ( isbot( self ) )
    {
        return false;
    }
    
    return true;
}

// Namespace ztron_achievements
// Params 0
// Checksum 0x32968a26, Offset: 0x240
// Size: 0xf1
function function_c45fc48edd573928()
{
    var_6c94b82bb72ed159 = 0;
    
    if ( level.ztron.var_74a3707334cfe144 )
    {
        var_6c94b82bb72ed159 = challenges::function_a23641f33e985edb( var_6c94b82bb72ed159, ae_utility::function_2d1565a236387b2( #"hash_9524fbd57e7761b0", #"firstperson" ) );
    }
    
    if ( level.ztron.var_95d8c7a469393957 )
    {
        var_6c94b82bb72ed159 = challenges::function_a23641f33e985edb( var_6c94b82bb72ed159, ae_utility::function_2d1565a236387b2( #"hash_9524fbd57e7761b0", #"hardcore" ) );
    }
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        var_6c94b82bb72ed159 = challenges::function_a23641f33e985edb( var_6c94b82bb72ed159, ae_utility::function_2d1565a236387b2( #"hash_9524fbd57e7761b0", #"casual" ) );
    }
    
    if ( level.ztron.blitzmode )
    {
        var_6c94b82bb72ed159 = challenges::function_a23641f33e985edb( var_6c94b82bb72ed159, ae_utility::function_2d1565a236387b2( #"hash_9524fbd57e7761b0", #"casual" ) );
    }
    
    return var_6c94b82bb72ed159;
}

// Namespace ztron_achievements
// Params 0
// Checksum 0x8acab839, Offset: 0x33a
// Size: 0xd1
function function_db28e178f81942b2()
{
    if ( !function_8643e6764ef43db9() )
    {
        return;
    }
    
    callback::callback( #"hash_6c71d319dc089c27", { #player:self, #event:#"sat_doa_reunited" } );
    aeeventname = #"ztron_papaback_defeated";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    gamemode = challenges::getchallengegamemode();
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_9524fbd57e7761b0" ) ] = function_c45fc48edd573928();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    
    if ( isdefined( aeeventid ) )
    {
        self function_2e45314624fdfdb8( aeeventid, eventparams );
    }
}

// Namespace ztron_achievements
// Params 1
// Checksum 0x64ad58ee, Offset: 0x413
// Size: 0xae
function function_68a2f4f33a03688a( value )
{
    if ( !function_8643e6764ef43db9() )
    {
        return;
    }
    
    aeeventname = #"ztron_money_earned";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    gamemode = challenges::getchallengegamemode();
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = int( value );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    
    if ( isdefined( aeeventid ) )
    {
        self function_2e45314624fdfdb8( aeeventid, eventparams );
    }
}

// Namespace ztron_achievements
// Params 1, eflags: 0x4
// Checksum 0xad1043, Offset: 0x4c9
// Size: 0x59
function private function_ec69210ff289630e( data )
{
    player = data.player;
    cached_currency = player.ztron.var_b9361a06e37de074;
    
    if ( cached_currency && cached_currency > 0 )
    {
        player function_68a2f4f33a03688a( cached_currency );
    }
}

/#

    // Namespace ztron_achievements
    // Params 1, eflags: 0x4
    // Checksum 0x9824d3ab, Offset: 0x52a
    // Size: 0xab, Type: dev
    function private function_599cfddcbbd49d38( params )
    {
        foreach ( player in level.players )
        {
            callback::callback( #"hash_6c71d319dc089c27", { #player:player, #event:getxhash( params[ 0 ] ) } );
        }
    }

    // Namespace ztron_achievements
    // Params 1
    // Checksum 0x23ceee75, Offset: 0x5dd
    // Size: 0xcd, Type: dev
    function init_devgui( params )
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        var_89f6d95026005d05 = [ "<dev string:x3a>", "<dev string:x4f>", "<dev string:x65>" ];
        
        foreach ( name in var_89f6d95026005d05 )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x76>" + name, "<dev string:x8e>" + name, &function_599cfddcbbd49d38 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

#/
