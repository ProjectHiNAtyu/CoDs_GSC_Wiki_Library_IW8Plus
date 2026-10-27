// scripts\mp\gametypes\skirmish_bounty.gsc  (hash_55beca462718d1fa.gscc) (size: 3762 Bytes / 0xeb2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3b7450a6 (997478566)
// size ...... 3762 (0xeb2)
// includes .. 5   (offset: 0xe4e)
// strings ... 3   (offset: 0xe76)
// dev strs .. 2   (offset: 0xe9a)
// exports ... 13  (offset: 0x87e)
// cseg ...... 0xa4 + 0x7da (0x87e)
// imports ... 33  (offset: 0xa86)
// animtree1 . 0   (offset: 0xeb2)
// animtree2 . 0   (offset: 0xeb2)
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gamescore;
#using scripts\mp\hud_message;
#using scripts\mp\matchdata;

#namespace skirmish_bounty;

// Namespace skirmish_bounty
// Params 0
// Checksum 0x1a280f1a, Offset: 0xc2
// Size: 0x84
function init()
{
    level.var_c8b1130f599f081c = undefined;
    level.var_d2692067c70d3c43 = 1;
    level.var_b0c69644391ab478 = getdvarint( @"hash_b0b5ae3c620ff689", 10 );
    level.var_600075cc3aa1580c = getdvarint( @"hash_9e20d41bce4d739f", 15 );
    setdvar( @"hash_3fa3782b38013cd4", float( level.var_600075cc3aa1580c / 100 ) );
    thread function_45a33a651dcc4d4e();
    level.var_702441c61cdd5ec8 = &function_45ad351565cca4b6;
    
    /#
        thread function_574c8469c2640363();
    #/
}

// Namespace skirmish_bounty
// Params 0, eflags: 0x4
// Checksum 0x4f1a6567, Offset: 0x14e
// Size: 0x2b
function private function_45a33a651dcc4d4e()
{
    self endon( #"game_ended" );
    
    while ( !( matchdata::gettimefrommatchstart( gettime() ) > 0 ) )
    {
        waitframe();
    }
    
    function_937f205e682d1c8c( 60 );
}

// Namespace skirmish_bounty
// Params 1, eflags: 0x4
// Checksum 0xb6603413, Offset: 0x181
// Size: 0x77
function private function_937f205e682d1c8c( cooldown )
{
    level.var_d2692067c70d3c43 = 1;
    
    /#
        printtoscreen2d( 50, 700, "<dev string:x24>", ( 1, 0, 0 ), 1.5, 200 );
    #/
    
    wait level.var_b0c69644391ab478;
    
    /#
        printtoscreen2d( 50, 700, "<dev string:x3d>", ( 1, 0, 0 ), 1.5, 200 );
    #/
    
    level.var_d2692067c70d3c43 = 0;
}

// Namespace skirmish_bounty
// Params 1, eflags: 0x4
// Checksum 0xd0b5df2d, Offset: 0x200
// Size: 0x5c
function private function_d097408811567977( team )
{
    for ( squadindex = 0; squadindex < 5 ; squadindex++ )
    {
        squaddata = teams::getsquaddata( team, squadindex );
        squadscore = gamescore::function_c9e7a345331fe1c6( squaddata );
        level.var_f1f6e337503d4972[ team ][ squadindex ] = squadscore;
    }
}

// Namespace skirmish_bounty
// Params 1, eflags: 0x4
// Checksum 0x3ddc123a, Offset: 0x264
// Size: 0x66
function private function_72ed97ea9364bc57( team )
{
    var_3fe5d2bc2b2e20af = 0;
    var_39b9ffb7b4be72bd = 0;
    
    for ( squadindex = 0; squadindex < 5 ; squadindex++ )
    {
        var_3fe5d2bc2b2e20af = level.var_f1f6e337503d4972[ team ][ squadindex ];
        
        if ( var_3fe5d2bc2b2e20af >= var_39b9ffb7b4be72bd )
        {
            var_39b9ffb7b4be72bd = var_3fe5d2bc2b2e20af;
            level.var_249b4c00fa268387[ team ] = squadindex;
        }
    }
}

// Namespace skirmish_bounty
// Params 1
// Checksum 0x7c6d9818, Offset: 0x2d2
// Size: 0x9c
function function_acf6364ca566e061( isbounty )
{
    self function_e7777181bf5e901b( isbounty );
    
    foreach ( player in level.players )
    {
        player setplayercompassoriginstoclient( 3, self, isbounty );
    }
    
    if ( isbounty )
    {
        thread function_7f07b193ab3d631c();
    }
}

// Namespace skirmish_bounty
// Params 0, eflags: 0x4
// Checksum 0xfa6e5b0c, Offset: 0x376
// Size: 0x51
function private function_7f07b193ab3d631c()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    wait 5;
    
    if ( function_45ad351565cca4b6() )
    {
        self playsoundtoplayer( "uin_t10_skirmish_becoming_target", self );
        hud_message::function_78fedf6f526825f4( "skirmish_has_bounty", level.gametypebundle.var_e662dd7f27d462eb );
    }
}

// Namespace skirmish_bounty
// Params 1, eflags: 0x4
// Checksum 0x66767d48, Offset: 0x3cf
// Size: 0x13e
function private function_f766231a589c47d8( bountyteam )
{
    if ( !isdefined( level.var_249b4c00fa268387 ) )
    {
        return;
    }
    
    if ( isdefined( level.var_c8b1130f599f081c ) )
    {
        foreach ( player in teams::getfriendlyplayers( level.var_c8b1130f599f081c ) )
        {
            player function_acf6364ca566e061( 0 );
        }
    }
    
    level.var_c8b1130f599f081c = bountyteam;
    
    foreach ( player in teams::getsquadmates( level.var_c8b1130f599f081c, level.var_249b4c00fa268387[ level.var_c8b1130f599f081c ], 0 ) )
    {
        player function_acf6364ca566e061( 1 );
    }
}

// Namespace skirmish_bounty
// Params 0, eflags: 0x4
// Checksum 0x8513d1e3, Offset: 0x515
// Size: 0xca
function private function_1f7380132610e846()
{
    bountyScore = 0;
    
    foreach ( currentteam, var_d63743b6dce17799 in level.teamdata )
    {
        if ( !team_utility::isgameplayteam( currentteam ) )
        {
            continue;
        }
        
        teamscore = gamescore::getteamscore( currentteam );
        
        if ( !isdefined( level.var_c8b1130f599f081c ) || bountyScore < teamscore )
        {
            function_72ed97ea9364bc57( currentteam );
            function_f766231a589c47d8( currentteam );
            bountyScore = teamscore;
        }
    }
}

// Namespace skirmish_bounty
// Params 0
// Checksum 0x394b161e, Offset: 0x5e7
// Size: 0x66, Type: bool
function function_45ad351565cca4b6()
{
    if ( !isdefined( level.var_c8b1130f599f081c ) )
    {
        return false;
    }
    
    if ( !isdefined( level.var_249b4c00fa268387[ level.var_c8b1130f599f081c ] ) )
    {
        return false;
    }
    
    if ( self.team == level.var_c8b1130f599f081c )
    {
        if ( self.sessionsquadid == level.var_249b4c00fa268387[ level.var_c8b1130f599f081c ] )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace skirmish_bounty
// Params 2
// Checksum 0x3c064f42, Offset: 0x656
// Size: 0x147
function function_98bac91f9c3ec633( potentialteam, squadindex )
{
    if ( level.var_d2692067c70d3c43 || !isdefined( potentialteam ) )
    {
        return;
    }
    
    if ( gamescore::getteamscore( potentialteam ) <= getomnvar( "ui_scorelimit" ) * level.var_600075cc3aa1580c / 100 )
    {
        return;
    }
    
    function_d097408811567977( potentialteam );
    var_f22b1488679147b5 = 0;
    var_4bc11a5811951b3c = 0;
    
    if ( level.var_c8b1130f599f081c )
    {
        var_f22b1488679147b5 = potentialteam != level.var_c8b1130f599f081c && gamescore::getteamscore( level.var_c8b1130f599f081c ) < gamescore::getteamscore( potentialteam );
        
        if ( potentialteam === level.var_c8b1130f599f081c && squadindex != level.var_249b4c00fa268387[ level.var_c8b1130f599f081c ] )
        {
            var_981b9d553b0bc003 = level.var_f1f6e337503d4972[ potentialteam ][ level.var_249b4c00fa268387[ level.var_c8b1130f599f081c ] ];
            var_60ea3a22e36ef124 = level.var_f1f6e337503d4972[ potentialteam ][ squadindex ];
            var_4bc11a5811951b3c = var_981b9d553b0bc003 < var_60ea3a22e36ef124;
        }
    }
    
    if ( !level.var_c8b1130f599f081c || var_f22b1488679147b5 || var_4bc11a5811951b3c )
    {
        function_72ed97ea9364bc57( potentialteam );
        function_f766231a589c47d8( potentialteam );
        thread function_937f205e682d1c8c();
    }
}

/#

    // Namespace skirmish_bounty
    // Params 0, eflags: 0x4
    // Checksum 0xcbfb9548, Offset: 0x7a5
    // Size: 0xd9, Type: dev
    function private function_574c8469c2640363()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            debugenabled = getdvarint( @"hash_b3d9c25ea57d795f", 0 );
            
            if ( debugenabled )
            {
                players = teams::getfriendlyplayers( level.var_c8b1130f599f081c );
                
                foreach ( player in players )
                {
                    sphere( player.origin + ( 0, 0, 250 ), 100 );
                }
            }
            
            waitframe();
        }
    }

#/
