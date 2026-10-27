// script_67bad8bd9685e057  (hash_67bad8bd9685e057.gscc) (size: 1971 Bytes / 0x7b3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x97dcaf19 (2547822361)
// size ...... 1971 (0x7b3)
// includes .. 6   (offset: 0x737)
// strings ... 6   (offset: 0x767)
// dev strs .. 0   (offset: 0x7b3)
// exports ... 6   (offset: 0x413)
// cseg ...... 0x95 + 0x37e (0x413)
// imports ... 20  (offset: 0x503)
// animtree1 . 0   (offset: 0x7b3)
// animtree2 . 0   (offset: 0x7b3)
#using script_47366beb5ba9fa22;
#using script_d74ae0b4aa21186;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\bots\bots_gametype_super_shared;
#using scripts\mp\gameobjects;

#namespace capture_flag;

// Namespace capture_flag
// Params 0
// Checksum 0x95ad84e9, Offset: 0xb3
// Size: 0xd
function createdecision()
{
    return mind::function_6e220221dd563155( &evaluatescore );
}

// Namespace capture_flag
// Params 1
// Checksum 0xa81df527, Offset: 0xc9
// Size: 0xbc
function evaluatescore( bot )
{
    domflag = undefined;
    
    if ( isdefined( self.var_fb665fadc7596915 ) && bot.team != self.var_fb665fadc7596915 gameobjects::getownerteam() )
    {
        domflag = self.var_fb665fadc7596915;
    }
    else
    {
        self.var_fb665fadc7596915 = undefined;
        domflags = bot namespace_c11142cfacfb2826::getevent();
        
        if ( domflags.size <= 0 )
        {
            return 0;
        }
        
        domflag = function_c50d6835a29303db( domflags );
    }
    
    self.generatedaction = mind::createactionbase( "Capture Flag", domflag, "main", "", &actionprocess, self );
    return self.constants.basescore;
}

// Namespace capture_flag
// Params 1
// Checksum 0x837e43fa, Offset: 0x18e
// Size: 0xb4
function function_c50d6835a29303db( domflags )
{
    weights = self.constants.var_e2a49e9ea25a80d0;
    weightssize = min( weights.size, domflags.size );
    weightstotal = 0;
    
    for ( i = 0; i < weightssize ; i++ )
    {
        weightstotal += weights[ i ];
    }
    
    index = 0;
    weightsadded = 0;
    weight = randomintrange( 0, weightstotal );
    
    while ( index < weightssize )
    {
        weightsadded += weights[ index ];
        
        if ( weight < weightsadded )
        {
            break;
        }
        
        index++;
    }
    
    return domflags[ index ];
}

// Namespace capture_flag
// Params 1
// Checksum 0x12ec7076, Offset: 0x24b
// Size: 0xf6
function actionprocess( bot )
{
    assert( isdefined( self.argument ) );
    domflag = self.argument;
    self.decision.var_fb665fadc7596915 = domflag;
    const_wander_radius = 16;
    
    while ( bot.team != domflag gameobjects::getownerteam() )
    {
        randompoint = function_f64bc9182083d5ce( domflag.curorigin, domflag.trigger.radius, domflag.trigger.height, const_wander_radius );
        bot bots_gametype_super_shared::setscriptgoal( randompoint, const_wander_radius );
        result = utility::waittill_any_ents_or_timeout_return( 15, bot, "bad_path", bot, "long_path", bot, "goal" );
        
        if ( result == "goal" )
        {
            wait 1;
        }
    }
}

// Namespace capture_flag
// Params 4
// Checksum 0x7a33c747, Offset: 0x349
// Size: 0xc9
function function_f64bc9182083d5ce( flagorigin, flagradius, flagheight, wanderradius )
{
    maxdistpercent = ( flagradius - wanderradius ) / flagradius;
    r = randomfloatrange( 0, flagradius * maxdistpercent );
    theta = randomfloat( 360 );
    offset = ( r * cos( theta ), r * sin( theta ), 0 );
    var_3f4643679b6da444 = ( flagheight + 30 ) * -1;
    contents = trace::create_contents( 0, 1, 1, 1, 0, 0, 1 );
    randompoint = utility::drop_to_ground( flagorigin + offset, flagheight, var_3f4643679b6da444, undefined, contents );
    return getclosestpointonnavmesh( randompoint );
}

