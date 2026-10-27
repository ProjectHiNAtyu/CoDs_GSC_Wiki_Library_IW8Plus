// scripts\mp\br\personal_bests.gsc  (hash_717ce326bdc5f005.gscc) (size: 6514 Bytes / 0x1972 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x63b6b205 (1672917509)
// size ...... 6514 (0x1972)
// includes .. 5   (offset: 0x172a)
// strings ... 43  (offset: 0x1752)
// dev strs .. 0   (offset: 0x1972)
// exports ... 14  (offset: 0x10d2)
// cseg ...... 0x352 + 0xd80 (0x10d2)
// imports ... 31  (offset: 0x1302)
// animtree1 . 0   (offset: 0x1972)
// animtree2 . 0   (offset: 0x1972)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\playerstats_interface;

#namespace personal_bests;

// Namespace personal_bests
// Params 0, eflags: 0x5
// Checksum 0xe6d3e84, Offset: 0x370
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_ee455e8286cd4d42", undefined, &init, undefined );
}

// Namespace personal_bests
// Params 2, eflags: 0x4
// Checksum 0x948c61d4, Offset: 0x391
// Size: 0xb7
function private function_b3bbbcdc1984dae9( loglevel, var_99a4b0a80bc2ae2 )
{
    if ( loglevel <= getdvarint( @"hash_eda32f8657027c92" ) )
    {
        levelstr = "";
        
        switch ( loglevel )
        {
            case 0:
                levelstr = "ERROR";
                break;
            case 1:
                levelstr = "WARN";
                break;
            case 2:
                levelstr = "INFO";
                break;
            case 3:
                levelstr = "DEBUG";
                break;
        }
        
        logstring( "[WARZONE_PB]" + "::" + levelstr + " " + var_99a4b0a80bc2ae2 );
    }
}

// Namespace personal_bests
// Params 0, eflags: 0x4
// Checksum 0xa421499e, Offset: 0x450
// Size: 0xbf
function private init()
{
    gametypebundlesupported = level.gametypebundle.var_81b432680626c32d ?? 0;
    
    if ( !gametypebundlesupported )
    {
        function_b3bbbcdc1984dae9( 2, "system init skipped. gametypeBundle not supported." );
        return;
    }
    
    if ( game_utility_mp::privatematch() )
    {
        function_b3bbbcdc1984dae9( 2, "system init skipped. Private match." );
        return;
    }
    
    utility::registersharedfunc( #"player", #"hash_20c82231856fcf19", &function_6e823c9b29e40b0a );
    callback::add( #"player_connect", &onconnect );
    context = level.gametypebundle.var_3edfdd0dc9fd611f ?? #"br";
    function_b3bbbcdc1984dae9( 2, "system init completed with context: " + context );
}

// Namespace personal_bests
// Params 0, eflags: 0x4
// Checksum 0x99edf824, Offset: 0x517
// Size: 0x114
function private function_6e823c9b29e40b0a()
{
    if ( game_utility_mp::onlinestatsenabled() && !isbot( self ) )
    {
        function_b3bbbcdc1984dae9( 3, "updatePersonalBests for:  " + self.name );
        context = level.gametypebundle.var_3edfdd0dc9fd611f;
        
        if ( !context )
        {
            function_b3bbbcdc1984dae9( 1, "updatePersonalBests skipped: no personalBestContext on gameTypeBundle" );
            return;
        }
        
        function_51c6c423a856e1cf( context );
        
        foreach ( statkey in [ #"damage", #"kills", #"edr" ] )
        {
            updatelifetime( statkey, context );
            function_273f3cb094a07764( statkey, context );
        }
        
        function_d88b6e3938f0c7d0( context );
    }
}

// Namespace personal_bests
// Params 2, eflags: 0x4
// Checksum 0x244b15cd, Offset: 0x633
// Size: 0x11c
function private updatelifetime( statkey, context )
{
    switch ( statkey )
    {
        case #"damage":
            var_20683d5fdd7f7566 = #"hash_f602ff0b6d4d45e9";
            break;
        case #"kills":
            var_20683d5fdd7f7566 = #"hash_e96b327054ce5d01";
            break;
        case #"edr":
            var_20683d5fdd7f7566 = #"hash_cdafb284575157a1";
            break;
        default:
            return;
    }
    
    var_75b2fafbaa142fb1 = function_70947a926f92940e( statkey );
    
    if ( playerstats_interface::getplayerstat( #"lifetimetracker", context, var_20683d5fdd7f7566 ) )
    {
        lifetimepb = function_4a2da2920ccacd2b( statkey, context );
        
        if ( var_75b2fafbaa142fb1 > lifetimepb )
        {
            playerstats_interface::setplayerstat( 1, #"lifetimetracker", context, var_20683d5fdd7f7566 );
            playerstats_interface::setplayerstat( var_75b2fafbaa142fb1, #"lifetimetracker", context, statkey );
        }
        
        return;
    }
    
    playerstats_interface::setplayerstat( 1, #"lifetimetracker", context, var_20683d5fdd7f7566 );
    playerstats_interface::setplayerstat( var_75b2fafbaa142fb1, #"lifetimetracker", context, statkey );
}

// Namespace personal_bests
// Params 2, eflags: 0x4
// Checksum 0xaa8c3e79, Offset: 0x757
// Size: 0x27
function private function_4a2da2920ccacd2b( statkey, context )
{
    return playerstats_interface::getplayerstat( #"lifetimetracker", context, statkey );
}

// Namespace personal_bests
// Params 1, eflags: 0x4
// Checksum 0xca9af1ce, Offset: 0x787
// Size: 0x6f
function private function_75101d4133fd457e( currenttimestamp )
{
    debugoffset = getdvarint( @"hash_17436925c11f3a85", 0 );
    var_7938f1d982080906 = 259200;
    adjustedtime = debugoffset + currenttimestamp + var_7938f1d982080906 - 32400;
    var_a483abaf8d61c440 = int( adjustedtime / 604800 );
    return var_a483abaf8d61c440 * 604800 - var_7938f1d982080906 + 32400;
}

// Namespace personal_bests
// Params 1, eflags: 0x4
// Checksum 0xfdfcdd71, Offset: 0x7ff
// Size: 0x172
function private function_51c6c423a856e1cf( context )
{
    var_3e64b7472522e743 = int( playerstats_interface::getplayerstat( #"weeklytracker", context, #"hash_444cad9f92543015" ) );
    var_6baba5eb2d591285 = function_75101d4133fd457e( getsystemtime() );
    
    if ( var_3e64b7472522e743 != var_6baba5eb2d591285 )
    {
        function_b3bbbcdc1984dae9( 3, "Resetting weekly tracking for: " + self.name );
        
        foreach ( statkey in [ #"damage", #"kills", #"edr" ] )
        {
            for ( i = 0; i < 7 ; i++ )
            {
                playerstats_interface::setplayerstat( 0, #"weeklytracker", context, statkey, i, #"valid" );
                playerstats_interface::setplayerstat( 0, #"weeklytracker", context, statkey, i, #"value" );
            }
            
            function_452cc7c942985f68( statkey, context );
        }
        
        playerstats_interface::setplayerstat( var_6baba5eb2d591285, #"weeklytracker", context, #"hash_444cad9f92543015" );
    }
}

// Namespace personal_bests
// Params 2, eflags: 0x4
// Checksum 0x3b29ee79, Offset: 0x979
// Size: 0x15c
function private function_273f3cb094a07764( statkey, context )
{
    currenttimestamp = getsystemtime();
    debugoffset = getdvarint( @"hash_17436925c11f3a85", 0 );
    adjustedtimestamp = currenttimestamp + debugoffset;
    var_6baba5eb2d591285 = function_75101d4133fd457e( currenttimestamp );
    slotindex = int( ( adjustedtimestamp - var_6baba5eb2d591285 ) / 86400 );
    var_75b2fafbaa142fb1 = function_70947a926f92940e( statkey );
    
    if ( playerstats_interface::getplayerstat( #"weeklytracker", context, statkey, slotindex, #"valid" ) )
    {
        var_f68efc99c015383b = playerstats_interface::getplayerstat( #"weeklytracker", context, statkey, slotindex, #"value" );
        
        if ( var_75b2fafbaa142fb1 > var_f68efc99c015383b )
        {
            playerstats_interface::setplayerstat( var_75b2fafbaa142fb1, #"weeklytracker", context, statkey, slotindex, #"value" );
            playerstats_interface::setplayerstat( 1, #"weeklytracker", context, statkey, slotindex, #"valid" );
        }
    }
    else
    {
        playerstats_interface::setplayerstat( var_75b2fafbaa142fb1, #"weeklytracker", context, statkey, slotindex, #"value" );
        playerstats_interface::setplayerstat( 1, #"weeklytracker", context, statkey, slotindex, #"valid" );
    }
    
    function_452cc7c942985f68( statkey, context );
}

// Namespace personal_bests
// Params 2, eflags: 0x4
// Checksum 0x829ad81a, Offset: 0xadd
// Size: 0xe3
function private function_452cc7c942985f68( statkey, context )
{
    switch ( statkey )
    {
        case #"damage":
            var_1ea69452447a74ca = #"hash_5c29980c6789d32d";
            break;
        case #"kills":
            var_1ea69452447a74ca = #"hash_72803a6f22db4a5d";
            break;
        case #"edr":
            var_1ea69452447a74ca = #"hash_8e3239f84d3f1b1d";
            break;
        default:
            return;
    }
    
    var_4b31de89fd96d96b = 0;
    
    for ( i = 0; i < 7 ; i++ )
    {
        var_4b31de89fd96d96b = playerstats_interface::getplayerstat( #"weeklytracker", context, statkey, i, #"valid" );
        
        if ( var_4b31de89fd96d96b )
        {
            break;
        }
    }
    
    playerstats_interface::setplayerstat( var_4b31de89fd96d96b, #"weeklytracker", context, var_1ea69452447a74ca );
}

// Namespace personal_bests
// Params 1, eflags: 0x4
// Checksum 0xd34c3f8d, Offset: 0xbc8
// Size: 0x105
function private function_70947a926f92940e( statkey )
{
    switch ( statkey )
    {
        case #"damage":
            return ( self.pers[ "damage" ] ?? 0 );
        case #"kills":
            return ( self.pers[ "kills" ] ?? 0 );
        case #"edr":
            numkills = self.pers[ "kills" ] ?? 0;
            numassists = self.pers[ "assists" ] ?? 0;
            numeliminations = numkills + numassists;
            numdeaths = ( self.pers[ "deaths" ] ?? 0 ) + ( !isalive( self ) ? 1 : 0 );
            numdeaths = numdeaths > 0 ? numdeaths : 1;
            return ( float( numeliminations ) / float( numdeaths ) );
        default:
            return 0;
    }
}

// Namespace personal_bests
// Params 2, eflags: 0x4
// Checksum 0xd07fcfbb, Offset: 0xcd5
// Size: 0x44
function private onconnect( params, secondparams )
{
    if ( isbot( self ) )
    {
        return;
    }
    
    function_d88b6e3938f0c7d0( level.gametypebundle.var_3edfdd0dc9fd611f ?? #"" );
}

// Namespace personal_bests
// Params 1, eflags: 0x4
// Checksum 0x7729f053, Offset: 0xd21
// Size: 0x3b1
function private function_d88b6e3938f0c7d0( context )
{
    function_b3bbbcdc1984dae9( 3, "Current stats held by " + self.name + " in: [" + context + "] context" );
    timescale = "lifetime";
    hasdamage = playerstats_interface::getplayerstat( #"lifetimetracker", context, #"hash_f602ff0b6d4d45e9" );
    damage = playerstats_interface::getplayerstat( #"lifetimetracker", context, #"damage" );
    haskills = playerstats_interface::getplayerstat( #"lifetimetracker", context, #"hash_e96b327054ce5d01" );
    kills = playerstats_interface::getplayerstat( #"lifetimetracker", context, #"kills" );
    var_a3f86c1762005a77 = playerstats_interface::getplayerstat( #"lifetimetracker", context, #"hash_cdafb284575157a1" );
    EDR = playerstats_interface::getplayerstat( #"lifetimetracker", context, #"edr" );
    function_b3bbbcdc1984dae9( 3, timescale + " {hasLifetimeDamage: " + hasdamage + " damage: " + damage + "}, {hasLifetimeKills: " + haskills + " kills: " + kills + "}, {hasLifetimeEDR: " + var_a3f86c1762005a77 + " edr: " + EDR + "}" );
    timescale = "weekly";
    var_d3724c2caf44af72 = playerstats_interface::getplayerstat( #"weeklytracker", context, #"hash_444cad9f92543015" );
    hasdamage = playerstats_interface::getplayerstat( #"weeklytracker", context, #"hash_5c29980c6789d32d" );
    haskills = playerstats_interface::getplayerstat( #"weeklytracker", context, #"hash_72803a6f22db4a5d" );
    var_a3f86c1762005a77 = playerstats_interface::getplayerstat( #"weeklytracker", context, #"hash_8e3239f84d3f1b1d" );
    function_b3bbbcdc1984dae9( 3, timescale + " {weekStartTimestamp: " + var_d3724c2caf44af72 + " hasWeeklyDamage: " + hasdamage + "}, {hasWeeklyKills: " + haskills + "}, {hasWeeklyEDR: " + var_a3f86c1762005a77 + "}" );
    day_names = [ "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" ];
    
    for ( i = 0; i < day_names.size ; i++ )
    {
        timescale = day_names[ i ];
        hasdamage = playerstats_interface::getplayerstat( #"weeklytracker", context, #"damage", i, #"valid" );
        damage = playerstats_interface::getplayerstat( #"weeklytracker", context, #"damage", i, #"value" );
        haskills = playerstats_interface::getplayerstat( #"weeklytracker", context, #"kills", i, #"valid" );
        kills = playerstats_interface::getplayerstat( #"weeklytracker", context, #"kills", i, #"value" );
        var_a3f86c1762005a77 = playerstats_interface::getplayerstat( #"weeklytracker", context, #"edr", i, #"valid" );
        EDR = playerstats_interface::getplayerstat( #"weeklytracker", context, #"edr", i, #"value" );
        function_b3bbbcdc1984dae9( 3, timescale + " {valid: " + hasdamage + " damage: " + damage + "}, {valid: " + haskills + " kills: " + kills + "}, {valid: " + var_a3f86c1762005a77 + " edr: " + EDR + "}" );
    }
}

