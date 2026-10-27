// script_54a9e44119886147  (hash_54a9e44119886147.gscc) (size: 2400 Bytes / 0x960 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb2bfbf89 (2998910857)
// size ...... 2400 (0x960)
// includes .. 4   (offset: 0x884)
// strings ... 11  (offset: 0x8a4)
// dev strs .. 2   (offset: 0x948)
// exports ... 5   (offset: 0x4a0)
// cseg ...... 0xe6 + 0x3ba (0x4a0)
// imports ... 27  (offset: 0x568)
// animtree1 . 0   (offset: 0x960)
// animtree2 . 0   (offset: 0x960)
#using script_d74ae0b4aa21186;
#using scripts\common\utility;
#using scripts\mp\bots\bots_gametype_super_shared;
#using scripts\mp\br\gametypes\br_circle;

#namespace combat_action;

// Namespace combat_action
// Params 1
// Checksum 0x49fdd7c3, Offset: 0x104
// Size: 0x5a
function createaction( target )
{
    assert( isent( target ) );
    targetname = namespace_ef4547f85724edd1::getentityname( target );
    return mind::createactionbase( "combat", target, "main", targetname + "/" + target getentitynumber(), &actionprocess, self, &function_c8f48c8481f42dcb );
}

// Namespace combat_action
// Params 1
// Checksum 0xb3b34a8a, Offset: 0x167
// Size: 0x256
function actionprocess( bot )
{
    assert( isplayer( self.argument ) || isagent( self.argument ) );
    target = self.argument;
    target endon( #"death_or_disconnect" );
    meleechargedist = bot botgetdifficultysetting( "meleeChargeDist" );
    meleechargedistsquared = meleechargedist * meleechargedist;
    var_d550a5989dce86b9 = 0;
    modifyinaccuracy( bot );
    
    while ( true )
    {
        if ( !bot namespace_ef4547f85724edd1::isvalidtarget( target ) )
        {
            return "Invalid target";
        }
        
        bot namespace_ef4547f85724edd1::setenemy( target );
        bot botclearscriptgoal();
        var_a254a5286685c14c = distancesquared( bot.origin, target.origin ) <= meleechargedistsquared;
        
        if ( var_d550a5989dce86b9 != var_a254a5286685c14c )
        {
            var_d550a5989dce86b9 = var_a254a5286685c14c;
            var_d85445174d978e98 = var_a254a5286685c14c && randomfloat( 1 ) < 0.5 && bot botcanseeentity( target );
            bot botsetflag( "prefer_melee", var_d85445174d978e98 );
        }
        
        msg = bot utility::waittill_any_in_array_or_timeout( [ "bad_path", "long_path" ], 1 );
        
        if ( !bot namespace_ef4547f85724edd1::isvalidtarget( target ) )
        {
            return "Invalid target";
        }
        
        if ( msg != "timeout" && !bot botcanseeentity( target ) )
        {
            if ( msg == "bad_path" )
            {
                bot namespace_ef4547f85724edd1::setenemy( undefined );
                
                /#
                    mind::function_fce0e7ad88c9e106( "<dev string:x24>" );
                #/
                
                point = br_circle::getrandompointincircle( bot.origin, 200, 0.5, 1, 1, 1 );
                reachable_point = bot getclosestreachablepointonnavmesh( point );
                bot namespace_ef4547f85724edd1::setscriptgoal( reachable_point, 32 );
                bot utility::waittill_any_in_array_or_timeout( [ "goal", "bad_path" ], 2 );
                
                if ( !bot namespace_ef4547f85724edd1::isvalidtarget( target ) )
                {
                    return "Invalid target";
                }
                
                /#
                    mind::function_fce0e7ad88c9e106( "<dev string:x33>" );
                #/
            }
            else if ( msg == "long_path" )
            {
                return msg;
            }
        }
        
        if ( self.decision.constants.extragrenadethrow )
        {
            bot namespace_ef4547f85724edd1::function_d38100c0f2e7a5de( target );
        }
    }
}

// Namespace combat_action
// Params 1
// Checksum 0x4d02f0b1, Offset: 0x3c5
// Size: 0x8d
function modifyinaccuracy( bot )
{
    inaccuracymultiplier = self.decision.constants.var_16662f71dca8c856;
    
    if ( isdefined( inaccuracymultiplier ) && inaccuracymultiplier != 0 && !isbot( self.argument ) )
    {
        self.var_dfe397a1342c2438 = bot botgetdifficultysetting( "hitInaccuracyScale" );
        var_616b564a03bf7dff = self.var_dfe397a1342c2438 * inaccuracymultiplier;
        bot botsetdifficultysetting( "hitInaccuracyScale", var_616b564a03bf7dff );
    }
}

// Namespace combat_action
// Params 1
// Checksum 0x8c00a6f6, Offset: 0x45a
// Size: 0x46
function function_c8f48c8481f42dcb( action )
{
    if ( mind::function_c47a284545576f7a() )
    {
        self botsetflag( "prefer_melee", 0 );
        
        if ( isdefined( action.var_dfe397a1342c2438 ) )
        {
            self botsetdifficultysetting( "hitInaccuracyScale", action.var_dfe397a1342c2438 );
        }
    }
}

