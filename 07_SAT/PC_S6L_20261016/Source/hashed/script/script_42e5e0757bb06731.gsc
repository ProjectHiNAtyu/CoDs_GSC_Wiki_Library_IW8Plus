// script_42e5e0757bb06731  (hash_42e5e0757bb06731.gscc) (size: 2544 Bytes / 0x9f0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9102594c (2432850252)
// size ...... 2544 (0x9f0)
// includes .. 5   (offset: 0x970)
// strings ... 7   (offset: 0x998)
// dev strs .. 0   (offset: 0x9f0)
// exports ... 9   (offset: 0x60c)
// cseg ...... 0xf2 + 0x51a (0x60c)
// imports ... 17  (offset: 0x774)
// animtree1 . 0   (offset: 0x9f0)
// animtree2 . 0   (offset: 0x9f0)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\mp\ob\systems\region_difficulty_manager;

#namespace namespace_1eb976e9755c4bbe;

// Namespace namespace_1eb976e9755c4bbe
// Params 0, eflags: 0x5
// Checksum 0x51c249ab, Offset: 0x110
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_12adfde6071ff66", #"activity_common", &function_67af1599fcebacef, undefined );
}

// Namespace namespace_1eb976e9755c4bbe
// Params 0, eflags: 0x4
// Checksum 0x81146da, Offset: 0x139
// Size: 0x122
function private function_67af1599fcebacef()
{
    activity_common::function_2dd4f07fa5c3e911( "ActivitySuccess", &function_f33248c8028f2893 );
    level callback::add( #"on_ai_killed", &on_ai_killed );
    level.var_fd592aaf1a089f49 = [];
    var_261f8aa89b5f5b4a = level.activities.activitynexussettings.var_992ad6a29f3b9ff9;
    level.var_2d1127a9585d1bcd = getdvarint( @"hash_f3caea8d49cc1f1", var_261f8aa89b5f5b4a.var_2d1127a9585d1bcd );
    level.var_4f15e85148588359 = getdvarint( @"hash_fbaf77cddede38fa", var_261f8aa89b5f5b4a.var_4f15e85148588359 );
    level.var_d046415df6fc9a20 = getdvarint( @"hash_7f749d993b774998", var_261f8aa89b5f5b4a.var_d046415df6fc9a20 );
    level.var_1a9382ab699daa45 = getdvarfloat( @"hash_e9e0f9bb433dfbe3", var_261f8aa89b5f5b4a.var_1a9382ab699daa45 );
    level.var_f1ff75ff607969c6 = getdvarfloat( @"hash_36ef1e61db9b3b46", var_261f8aa89b5f5b4a.var_f1ff75ff607969c6 );
    level.var_34f2f5e7771394b7 = getdvarfloat( @"hash_4aa76fea996f9af9", var_261f8aa89b5f5b4a.var_34f2f5e7771394b7 );
}

// Namespace namespace_1eb976e9755c4bbe
// Params 1, eflags: 0x4
// Checksum 0x3889c43b, Offset: 0x263
// Size: 0xc1
function private on_ai_killed( params )
{
    if ( self.death_source == "despawn" )
    {
        return;
    }
    
    playerattacker = params.eattacker;
    
    if ( playerattacker && !isplayer( playerattacker ) && isplayer( playerattacker.owner ) )
    {
        playerattacker = playerattacker.owner;
    }
    
    regiondifficulty = params.victim.difficulty;
    waitframe();
    
    if ( isalive( playerattacker ) )
    {
        zonemultiplier = function_7fcdd0091bc0630d( regiondifficulty );
        var_9be53b074c5a7572 = zonemultiplier * level.var_2d1127a9585d1bcd;
        function_8dd0b0332a35c750( playerattacker, var_9be53b074c5a7572 );
    }
}

// Namespace namespace_1eb976e9755c4bbe
// Params 1, eflags: 0x4
// Checksum 0xf2b31bb, Offset: 0x32c
// Size: 0x18b
function private function_f33248c8028f2893( var_921a1b24ee2d6819 )
{
    var_f54b441f112df88b = self.category == "Contract" || self.category == "Activity" || self.category == "Startup";
    
    if ( !var_f54b441f112df88b )
    {
        return;
    }
    
    participatingplayers = var_921a1b24ee2d6819.playerlist;
    
    if ( participatingplayers && isarray( participatingplayers ) )
    {
        activitylocation = activity_instance_common::function_776ee11e7acc64a5( self );
        regiondifficulty = region_difficulty_manager::get_region_difficulty( activitylocation );
        zonemultiplier = function_7fcdd0091bc0630d( regiondifficulty );
        var_79e870f282a72d42 = self.category == "Contract" ? level.var_4f15e85148588359 : level.var_d046415df6fc9a20;
        var_f3232896b5932586 = var_79e870f282a72d42 * zonemultiplier;
        var_294f3fc09954ef19 = [];
        
        foreach ( player in participatingplayers )
        {
            squadid = get_squad_id( player );
            
            if ( var_294f3fc09954ef19[ squadid ] )
            {
                continue;
            }
            
            function_8dd0b0332a35c750( player, var_f3232896b5932586 );
            var_294f3fc09954ef19[ squadid ] = 1;
        }
    }
}

// Namespace namespace_1eb976e9755c4bbe
// Params 2, eflags: 0x4
// Checksum 0x4804f365, Offset: 0x4bf
// Size: 0x63
function private function_8dd0b0332a35c750( player, var_db33d76ee2d12930 )
{
    squadid = get_squad_id( player );
    
    if ( !level.var_fd592aaf1a089f49[ squadid ] )
    {
        level.var_fd592aaf1a089f49[ squadid ] = 0;
    }
    
    level.var_fd592aaf1a089f49[ squadid ] += var_db33d76ee2d12930;
}

// Namespace namespace_1eb976e9755c4bbe
// Params 1, eflags: 0x4
// Checksum 0x952282a6, Offset: 0x52a
// Size: 0x7e
function private function_7fcdd0091bc0630d( difficulty = "difficulty_easy" )
{
    switch ( difficulty )
    {
        case #"hash_af83e47edfa8900a":
            return level.var_1a9382ab699daa45;
        case #"hash_5343b465e56ec9a4":
            return level.var_f1ff75ff607969c6;
        case #"hash_651f76c0ad6741ec":
            return level.var_34f2f5e7771394b7;
        default:
            break;
    }
    
    return 1;
}

// Namespace namespace_1eb976e9755c4bbe
// Params 1
// Checksum 0xc71b4b00, Offset: 0x5b1
// Size: 0x28
function get_squad_points( squadid )
{
    if ( level.var_fd592aaf1a089f49[ squadid ] )
    {
        return level.var_fd592aaf1a089f49[ squadid ];
    }
}

// Namespace namespace_1eb976e9755c4bbe
// Params 1
// Checksum 0xfbc3da3d, Offset: 0x5e2
// Size: 0x29
function get_squad_id( player )
{
    return player.team + "_" + player.sessionsquadid;
}

