// script_5adad3b6e57811aa  (hash_5adad3b6e57811aa.gscc) (size: 1183 Bytes / 0x49f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xafd2897f (2949810559)
// size ...... 1183 (0x49f)
// includes .. 4   (offset: 0x467)
// strings ... 0   (offset: 0x487)
// dev strs .. 2   (offset: 0x487)
// exports ... 3   (offset: 0x2b3)
// cseg ...... 0x58 + 0x25b (0x2b3)
// imports ... 11  (offset: 0x32b)
// animtree1 . 0   (offset: 0x49f)
// animtree2 . 0   (offset: 0x49f)
#using script_37d9a569491ff1e0;
#using script_54a9e44119886147;
#using script_d74ae0b4aa21186;
#using scripts\mp\bots\bots_gametype_super_shared;

#namespace namespace_95c62566abc47727;

// Namespace namespace_95c62566abc47727
// Params 0
// Checksum 0x7588da8b, Offset: 0x76
// Size: 0xd
function createdecision()
{
    return mind::function_6e220221dd563155( &evaluatescore );
}

// Namespace namespace_95c62566abc47727
// Params 1
// Checksum 0x5051e9bf, Offset: 0x8c
// Size: 0x226
function evaluatescore( bot )
{
    /#
        if ( getdvar( @"bot_notarget" ) == "<dev string:x24>" )
        {
            return 0;
        }
    #/
    
    finalscore = 0;
    target = undefined;
    nearbyevent = bot nearby_targets::getevent( self.constants.nearbyenemydistance, 2 );
    
    foreach ( player in nearbyevent.result )
    {
        /#
            if ( !isai( player ) && getdvar( @"bot_notarget" ) == "<dev string:x28>" )
            {
                continue;
            }
        #/
        
        distancetoplayer = distance( bot.origin, player.origin );
        
        if ( distancetoplayer <= 1 )
        {
            continue;
        }
        
        score = 0;
        basescore = bots_gametype_super_shared::function_3649fa69baa2da26( distancetoplayer, self.constants.var_6f25ddad2801df76, self.constants.var_280ab218c5864a36 );
        
        if ( bot bots_gametype_super_shared::function_4c51ebd039307c1a( player ) )
        {
            score = basescore + self.constants.attackermodifier;
        }
        else if ( bot botcanseeentity( player ) )
        {
            score = basescore;
        }
        else if ( distancetoplayer < self.constants.var_25466031dbd60293 )
        {
            var_418c57d56f5d60dc = bots_gametype_super_shared::function_3649fa69baa2da26( distancetoplayer, self.constants.var_642e1e5b43a46ef6, self.constants.var_7fae8b56893010b6 );
            score = basescore + var_418c57d56f5d60dc;
        }
        
        if ( score > finalscore )
        {
            finalscore = score;
            target = player;
        }
    }
    
    if ( isdefined( target ) )
    {
        self.generatedaction = combat_action::createaction( target );
    }
    
    return finalscore;
}

