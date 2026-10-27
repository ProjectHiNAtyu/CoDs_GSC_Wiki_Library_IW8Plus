// scripts\mp\common\utility\sound.gsc  (hash_4b675da9f6a1fd20.gscc) (size: 5044 Bytes / 0x13b4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9e8152bb (2659275451)
// size ...... 5044 (0x13b4)
// includes .. 1   (offset: 0x1274)
// strings ... 17  (offset: 0x127c)
// dev strs .. 5   (offset: 0x1374)
// exports ... 17  (offset: 0xab4)
// cseg ...... 0x14c + 0x968 (0xab4)
// imports ... 43  (offset: 0xd5c)
// animtree1 . 0   (offset: 0x13b4)
// animtree2 . 0   (offset: 0x13b4)
#using scripts\mp\operator;

#namespace sound;

// Namespace sound
// Params 0
// Checksum 0xf73b0f7d, Offset: 0x16a
// Size: 0x32
function exploder_sound()
{
    if ( isdefined( self.script_delay ) )
    {
        wait self.script_delay;
    }
    
    self playsound( level.scr_sound[ self.script_sound ] );
}

// Namespace sound
// Params 3
// Checksum 0x90a0fcb5, Offset: 0x1a4
// Size: 0x215
function playsoundonplayers( sound, team, excludelist )
{
    assert( isdefined( level.players ) );
    
    if ( level.splitscreen )
    {
        if ( isdefined( level.players[ 0 ] ) )
        {
            level.players[ 0 ] playlocalsound( sound );
        }
        
        return;
    }
    
    if ( isdefined( team ) )
    {
        if ( isdefined( excludelist ) )
        {
            for ( i = 0; i < level.players.size ; i++ )
            {
                player = level.players[ i ];
                
                if ( player issplitscreenplayer() && !player issplitscreenplayerprimary() )
                {
                    continue;
                }
                
                if ( player.pers[ "team" ] == team && !arraycontains( excludelist, player ) )
                {
                    player playlocalsound( sound );
                }
            }
        }
        else
        {
            for ( i = 0; i < level.players.size ; i++ )
            {
                player = level.players[ i ];
                
                if ( player issplitscreenplayer() && !player issplitscreenplayerprimary() )
                {
                    continue;
                }
                
                if ( player.pers[ "team" ] == team )
                {
                    player playlocalsound( sound );
                }
            }
        }
        
        return;
    }
    
    if ( isdefined( excludelist ) )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            if ( level.players[ i ] issplitscreenplayer() && !level.players[ i ] issplitscreenplayerprimary() )
            {
                continue;
            }
            
            if ( !arraycontains( excludelist, level.players[ i ] ) )
            {
                level.players[ i ] playlocalsound( sound );
            }
        }
        
        return;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( level.players[ i ] issplitscreenplayer() && !level.players[ i ] issplitscreenplayerprimary() )
        {
            continue;
        }
        
        level.players[ i ] playlocalsound( sound );
    }
}

// Namespace sound
// Params 2
// Checksum 0x6d8772a7, Offset: 0x3c1
// Size: 0x1e
function play_sound_on_entity( alias, op_notify_string )
{
    play_sound_on_tag( alias );
}

// Namespace sound
// Params 5
// Checksum 0x1f5b2932, Offset: 0x3e7
// Size: 0x3a
function play_sound_on_tag_fn( alias, tag, ends_on_death, op_notify_string, radio_dialog )
{
    play_sound_on_tag( alias, tag );
}

// Namespace sound
// Params 2
// Checksum 0x907b560f, Offset: 0x429
// Size: 0x3c
function play_sound_on_tag( alias, tag )
{
    if ( isdefined( tag ) )
    {
        playsoundatpos( self gettagorigin( tag ), alias );
        return;
    }
    
    playsoundatpos( self.origin, alias );
}

// Namespace sound
// Params 1, eflags: 0x4
// Checksum 0x954cf147, Offset: 0x46d
// Size: 0x46
function private function_3a605426d501e989( meansofdeath )
{
    if ( meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_HEAD_SHOT" )
    {
        return;
    }
    
    if ( meansofdeath == "MOD_FALLING" || meansofdeath == "MOD_SUICIDE" )
    {
        return "plr_death_explosion";
    }
    
    return "plr_death_generic";
}

// Namespace sound
// Params 1, eflags: 0x4
// Checksum 0x9a0c7327, Offset: 0x4bc
// Size: 0x8d
function private function_d9907c79d50fbdf2( meansofdeath )
{
    if ( meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_HEAD_SHOT" )
    {
        return;
    }
    
    rand = randomintrange( 1, 8 );
    type = "generic";
    
    if ( operator::isfemale() )
    {
        type = "female";
    }
    
    alias = type + "_death_american_" + rand;
    
    if ( self.team == "axis" )
    {
        alias = type + "_death_russian_" + rand;
    }
    
    return alias;
}

// Namespace sound
// Params 3, eflags: 0x4
// Checksum 0x7f8c657c, Offset: 0x552
// Size: 0xb7
function private function_4e617c1427223227( objweapon, smeansofdeath, hitloc )
{
    sound = undefined;
    
    if ( smeansofdeath == "MOD_MELEE" )
    {
        if ( hitloc == "head" || hitloc == "helmet" || hitloc == "neck" )
        {
            sound = function_a277dd14fb64ca78( objweapon );
        }
        
        if ( !isdefined( sound ) || sound == #"" )
        {
            sound = function_4ed84667467c57e3( objweapon );
        }
    }
    else if ( smeansofdeath == "MOD_HEAD_SHOT" )
    {
        sound = function_e1898f4f5aa170a9( objweapon );
    }
    
    if ( !isdefined( sound ) || sound == #"" )
    {
        sound = function_eb84b89809f9463b( objweapon );
    }
    
    return sound;
}

// Namespace sound
// Params 3, eflags: 0x4
// Checksum 0x52c55f86, Offset: 0x612
// Size: 0xb7
function private function_b19d53fffa8d92e6( objweapon, smeansofdeath, hitloc )
{
    sound = undefined;
    
    if ( smeansofdeath == "MOD_MELEE" )
    {
        if ( hitloc == "head" || hitloc == "helmet" || hitloc == "neck" )
        {
            sound = function_12268831a318e36d( objweapon );
        }
        
        if ( !isdefined( sound ) || sound == #"" )
        {
            sound = function_e409293ba920e252( objweapon );
        }
    }
    else if ( smeansofdeath == "MOD_HEAD_SHOT" )
    {
        sound = function_8e9b5ce04c2eac34( objweapon );
    }
    
    if ( !isdefined( sound ) || sound == #"" )
    {
        sound = function_e98ff5328e142faa( objweapon );
    }
    
    return sound;
}

// Namespace sound
// Params 3, eflags: 0x4
// Checksum 0x19005f66, Offset: 0x6d2
// Size: 0x44
function private function_85e16cf0714ca0ae( objweapon, meansofdeath, hitloc )
{
    victimdeathsound = function_b19d53fffa8d92e6( objweapon, meansofdeath, hitloc );
    
    if ( victimdeathsound )
    {
        return victimdeathsound;
    }
    
    return function_3a605426d501e989( meansofdeath );
}

// Namespace sound
// Params 3, eflags: 0x4
// Checksum 0x90400d8a, Offset: 0x71f
// Size: 0x42
function private function_38619d53aaff6df1( objweapon, meansofdeath, hitloc )
{
    victimdeathsound = function_4e617c1427223227( objweapon, meansofdeath, hitloc );
    
    if ( victimdeathsound )
    {
        return victimdeathsound;
    }
    
    return function_d9907c79d50fbdf2();
}

// Namespace sound
// Params 3
// Checksum 0xebe5a4f2, Offset: 0x76a
// Size: 0xcb
function playdeathsound( objweapon, meansofdeath, hitloc )
{
    var_a4be028d6ac4d009 = function_38619d53aaff6df1( objweapon, meansofdeath, hitloc );
    body = self.body ?? self;
    
    if ( isplayer( self ) )
    {
        var_c25d428d80b4d182 = function_85e16cf0714ca0ae( objweapon, meansofdeath, hitloc );
        
        if ( isdefined( var_a4be028d6ac4d009 ) && var_a4be028d6ac4d009 != #"" && isdefined( var_c25d428d80b4d182 ) && var_c25d428d80b4d182 != #"" )
        {
            self playsoundtoplayer( var_c25d428d80b4d182, self, body );
            body playsound( var_a4be028d6ac4d009, self, body );
        }
        
        return;
    }
    
    if ( isdefined( var_a4be028d6ac4d009 ) && var_a4be028d6ac4d009 != #"" )
    {
        self playsoundatviewheight( var_a4be028d6ac4d009 );
    }
}

// Namespace sound
// Params 1
// Checksum 0x4e50023e, Offset: 0x83d
// Size: 0xce
function function_739ef269e7eed028( weapon )
{
    if ( !isdefined( self.var_e4545795c4039d26 ) )
    {
        self.var_e4545795c4039d26 = 0;
    }
    
    sounddelay = level.gamemodebundle.var_5f8b347141310b87 ?? 3000;
    time = gettime();
    
    if ( self.var_e4545795c4039d26 + sounddelay > time )
    {
        return;
    }
    
    var_5c55083bc793a11f = function_85694e289861240b( weapon );
    
    if ( var_5c55083bc793a11f != #"" )
    {
        self playlocalsound( var_5c55083bc793a11f );
        self.var_e4545795c4039d26 = time;
    }
    
    var_aca6e51a5fab9b56 = function_58fd304c602bd772( weapon );
    
    if ( var_aca6e51a5fab9b56 != #"" )
    {
        self playsound( var_aca6e51a5fab9b56, self, self );
        self.var_e4545795c4039d26 = time;
    }
}

// Namespace sound
// Params 0
// Checksum 0xe79c5b09, Offset: 0x913
// Size: 0x4d
function function_3e57b25413dd8d22()
{
    if ( !isarray( level._sound_transient_banks ) )
    {
        level._sound_transient_banks = [];
    }
    
    if ( !isent( level.var_26178b3a7073263c ) )
    {
        level.var_26178b3a7073263c = spawn( "sound_transient_soundbanks", ( 0, 0, 0 ) );
    }
}

// Namespace sound
// Params 1
// Checksum 0x97ee4ac3, Offset: 0x968
// Size: 0xa8
function function_3fba8bceddd6017e( name )
{
    function_3e57b25413dd8d22();
    assert( isent( level.var_26178b3a7073263c ) );
    assert( isarray( level._sound_transient_banks ) );
    assert( isstring( name ), "<dev string:x24>" );
    
    if ( isdefined( level._sound_transient_banks[ name ] ) )
    {
        /#
            iprintlnbold( "<dev string:x50>" + name + "<dev string:x74>" );
        #/
        
        return;
    }
    
    level.var_26178b3a7073263c settransientsoundbank( name + ".all", 1 );
    level._sound_transient_banks[ name ] = level._sound_transient_banks.size;
}

// Namespace sound
// Params 1
// Checksum 0x64aa9b45, Offset: 0xa18
// Size: 0x9c
function function_635fbcbc53894f85( name )
{
    function_3e57b25413dd8d22();
    assert( isent( level.var_26178b3a7073263c ) );
    assert( isarray( level._sound_transient_banks ) );
    assert( isstring( name ), "<dev string:x24>" );
    
    if ( isdefined( level._sound_transient_banks[ name ] ) )
    {
        level.var_26178b3a7073263c settransientsoundbank( name + ".all", 0 );
        level._sound_transient_banks[ name ] = undefined;
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x77>" + name + "<dev string:x8c>" );
    #/
}

