// scripts\mp\ob\systems\ob_hackable.gsc  (hash_46cd21b76c9d52b6.gscc) (size: 2999 Bytes / 0xbb7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf246de35 (4064730677)
// size ...... 2999 (0xbb7)
// includes .. 6   (offset: 0xb57)
// strings ... 4   (offset: 0xb87)
// dev strs .. 0   (offset: 0xbb7)
// exports ... 12  (offset: 0x543)
// cseg ...... 0x85 + 0x4be (0x543)
// imports ... 37  (offset: 0x723)
// animtree1 . 0   (offset: 0xbb7)
// animtree2 . 0   (offset: 0xbb7)
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\hud_util;
#using scripts\mp\interaction;

#namespace ob_hackable;

// Namespace ob_hackable
// Params 0, eflags: 0x5
// Checksum 0x3d6241bb, Offset: 0xa3
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ob_hackable", undefined, &function_614a8f9dc1fb62a8, undefined );
}

// Namespace ob_hackable
// Params 0
// Checksum 0xe15eb5d8, Offset: 0xc4
// Size: 0xb6
function function_614a8f9dc1fb62a8()
{
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    level.ob_hackable_target_array = [];
    utility::registersharedfunc( #"gametype", #"hash_d12983acf2f30a1b", &function_e952f5fba28ce153 );
    utility::registersharedfunc( #"gametype", #"hash_4874c6337bffafb0", &function_3a266864e2aaab38 );
    utility::registersharedfunc( #"gametype", #"hash_cbc683d4d23144e5", &function_d813059cf766595b );
    utility::registersharedfunc( #"gametype", #"hash_6e7ad51030328c8e", &function_dd405184451573dc );
    utility::registersharedfunc( #"gametype", #"hash_9c548c8168f54b66", &function_2aa85d3415433ef6 );
    function_3c78d6c0f31a686a();
}

// Namespace ob_hackable
// Params 0
// Checksum 0xb7c0a31, Offset: 0x182
// Size: 0xb
function function_e952f5fba28ce153()
{
    return level.ob_hackable_target_array;
}

// Namespace ob_hackable
// Params 0
// Checksum 0x4e5f53f4, Offset: 0x196
// Size: 0x1d
function function_3a266864e2aaab38()
{
    assert( isdefined( self.hackable_target_ref ) );
    return self.hackable_target_ref;
}

// Namespace ob_hackable
// Params 1
// Checksum 0x662c6ced, Offset: 0x1bc
// Size: 0x2d
function function_d813059cf766595b( ref )
{
    self.hackable_target_ref = ref;
    level.ob_hackable_target_array[ level.ob_hackable_target_array.size ] = self;
}

// Namespace ob_hackable
// Params 0
// Checksum 0x713a7474, Offset: 0x1f1
// Size: 0x2a
function function_dd405184451573dc()
{
    if ( arraycontains( level.ob_hackable_target_array, self ) )
    {
        level.ob_hackable_target_array = arrayremove( level.ob_hackable_target_array, self );
    }
}

// Namespace ob_hackable
// Params 1
// Checksum 0x86356982, Offset: 0x223
// Size: 0x1e
function function_2aa85d3415433ef6( var_bb518dbbcf4bc35d )
{
    if ( isstring( var_bb518dbbcf4bc35d ) )
    {
        return getxhash( var_bb518dbbcf4bc35d );
    }
    
    return var_bb518dbbcf4bc35d;
}

// Namespace ob_hackable
// Params 7
// Checksum 0xa0b7eeea, Offset: 0x24a
// Size: 0xee
function function_38eb8a14ffd48c84( object, radius = 64, start_use_callback, var_2417ec53195d7cf5, var_ec9eab1b0cf732fb, var_b2107da793be51f7, use_time )
{
    assert( !isdefined( var_2417ec53195d7cf5 ) || isfunction( var_2417ec53195d7cf5 ) );
    
    if ( isent( object ) )
    {
        interaction::register_interact( object, radius, &function_12764ebdb5f7f026, var_b2107da793be51f7 );
        object sethintonobstruction( "show" );
    }
    else
    {
        if ( isdefined( var_b2107da793be51f7 ) )
        {
            assert( isfunction( var_b2107da793be51f7 ) );
            object interaction::set_interact_hint_callback( var_b2107da793be51f7 );
        }
        
        object.var_fed1d7f321847873 = 1;
    }
    
    object.var_273fe2267bd28a97 = start_use_callback;
    object.var_1c547b46de148d6 = var_2417ec53195d7cf5;
    object.var_2031ad23a5f89690 = var_ec9eab1b0cf732fb;
    object.var_e518d23e9ec55b80 = use_time;
}

// Namespace ob_hackable
// Params 1
// Checksum 0x9ae95186, Offset: 0x340
// Size: 0x192
function function_12764ebdb5f7f026( player )
{
    oldweapon = player.currentweapon;
    newweapon = "black_hat_sat_mp";
    player giveweapon( newweapon );
    player switchtoweaponimmediate( newweapon );
    wait 1;
    player player::_freezecontrols( 1 );
    player player::_freezelookcontrols( 1 );
    var_aa778d21f7d75252 = 0;
    hackingprogressbar = player hud_util::createbar( ( 0.7, 0.1, 0.8 ), 200, 40 );
    hackingprogressbar hud_util::setpoint( "CENTER", "TOP", 0, 80 );
    hackingprogressbar.alpha = 0.65;
    hackingprogressbar.bar.alpha = 0.65;
    
    if ( isdefined( self.var_273fe2267bd28a97 ) )
    {
        self [[ self.var_273fe2267bd28a97 ]]( player );
    }
    
    while ( isalive( player ) && player usebuttonpressed() )
    {
        if ( var_aa778d21f7d75252 >= self.var_e518d23e9ec55b80 )
        {
            self [[ self.var_1c547b46de148d6 ]]( undefined, player );
            break;
        }
        
        var_aa778d21f7d75252 += getframeduration() / 1000;
        hackingprogressbar hud_util::updatebar( clamp( var_aa778d21f7d75252 / self.var_e518d23e9ec55b80, 0, 1 ) );
        waitframe();
    }
    
    if ( isdefined( self.var_2031ad23a5f89690 ) )
    {
        self [[ self.var_2031ad23a5f89690 ]]( player );
    }
    
    hackingprogressbar hud_util::destroyelem();
    player player::_freezecontrols( 0 );
    player player::_freezelookcontrols( 0 );
    player switchtoweaponimmediate( oldweapon );
    player takeweapon( newweapon );
}

// Namespace ob_hackable
// Params 0, eflags: 0x4
// Checksum 0x5a312108, Offset: 0x4da
// Size: 0xe
function private function_3c78d6c0f31a686a()
{
    scriptable::scriptable_addusedcallback( &function_89370f3f1dd40a28 );
}

// Namespace ob_hackable
// Params 6
// Checksum 0x435c3e46, Offset: 0x4f0
// Size: 0x53
function function_89370f3f1dd40a28( instance, part, state, player, bautouse, usestring )
{
    if ( !instance.var_fed1d7f321847873 )
    {
        return;
    }
    
    instance thread function_12764ebdb5f7f026( player );
}

