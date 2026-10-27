// script_7bf46d34c10761a4  (hash_7bf46d34c10761a4.gscc) (size: 1857 Bytes / 0x741 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x81bb6d0a (2176544010)
// size ...... 1857 (0x741)
// includes .. 4   (offset: 0x6c9)
// strings ... 6   (offset: 0x6e9)
// dev strs .. 1   (offset: 0x735)
// exports ... 5   (offset: 0x425)
// cseg ...... 0xa2 + 0x383 (0x425)
// imports ... 17  (offset: 0x4ed)
// animtree1 . 0   (offset: 0x741)
// animtree2 . 0   (offset: 0x741)
#using script_47366beb5ba9fa22;
#using script_d74ae0b4aa21186;
#using scripts\common\utility;
#using scripts\mp\bots\bots_gametype_super_shared;

#namespace capture_hardpoint;

// Namespace capture_hardpoint
// Params 0
// Checksum 0x4c392527, Offset: 0xc0
// Size: 0xd
function createdecision()
{
    return mind::function_6e220221dd563155( &evaluatescore );
}

// Namespace capture_hardpoint
// Params 1
// Checksum 0xf2bf0c41, Offset: 0xd6
// Size: 0x139
function evaluatescore( bot )
{
    currenthardpoint = bot namespace_c11142cfacfb2826::getevent()[ 0 ];
    var_76959898e36638ad = currenthardpoint.numtouching[ bot.team ];
    var_8f181844f4dfd50c = ( level.var_bb021b9622bb5bba - gettime() ) / 1000;
    finalscore = self.constants.basescore;
    finalscore += bots_gametype_super_shared::function_3649fa69baa2da26( var_8f181844f4dfd50c, self.constants.var_9b7deb85eca56732, self.constants.var_8b93445f3af471a7 );
    finalscore += self.constants.teammatemodifier[ var_76959898e36638ad ];
    finalhardpoint = currenthardpoint;
    
    if ( finalscore < self.constants.var_6c5a34a2a051ce06 )
    {
        finalscore = self.constants.var_6c5a34a2a051ce06;
        finalhardpoint = namespace_c11142cfacfb2826::function_e91d7f8f23d73054();
    }
    
    self.generatedaction = mind::createactionbase( "Capture Flag", finalhardpoint, "main", finalhardpoint.objectivekey, &actionprocess, self );
    return finalscore;
}

// Namespace capture_hardpoint
// Params 1
// Checksum 0xe0e61d70, Offset: 0x218
// Size: 0xb6
function actionprocess( bot )
{
    assert( isdefined( self.argument ) );
    targethardpoint = self.argument;
    const_wander_radius = 10;
    nodes = function_6c6fc385b1f592f5( targethardpoint );
    
    while ( true )
    {
        nodepoint = utility::array_random( nodes );
        bot bots_gametype_super_shared::setscriptgoal( nodepoint.origin, const_wander_radius );
        result = utility::waittill_any_ents_or_timeout_return( 15, bot, "bad_path", bot, "long_path", bot, "goal" );
        
        if ( result == "goal" )
        {
            wait 1;
        }
    }
}

// Namespace capture_hardpoint
// Params 2
// Checksum 0x2f067944, Offset: 0x2d6
// Size: 0x14e
function function_6c6fc385b1f592f5( targethardpoint, allowempty )
{
    nodes = [];
    
    if ( isdefined( targethardpoint.trigger ) )
    {
        if ( !isdefined( targethardpoint.nodes ) )
        {
            nodes = getnodesintrigger( targethardpoint.trigger );
        }
        
        if ( nodes.size <= 0 && isdefined( targethardpoint.trigger.target ) )
        {
            target = targethardpoint.trigger.target;
            possibleents = getentarray( "script_origin", #classname );
            
            if ( isdefined( possibleents ) )
            {
                foreach ( ent in possibleents )
                {
                    if ( ent.targetname == target )
                    {
                        nodes[ nodes.size ] = ent;
                    }
                }
            }
        }
    }
    
    if ( !allowempty )
    {
        assert( nodes.size > 0, "<dev string:x24>" );
    }
    
    return nodes;
}

