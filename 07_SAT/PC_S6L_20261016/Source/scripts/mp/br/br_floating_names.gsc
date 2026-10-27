// scripts\mp\br\br_floating_names.gsc  (hash_5fd7c48965846e69.gscc) (size: 1742 Bytes / 0x6ce / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2fd8bb84 (802732932)
// size ...... 1742 (0x6ce)
// includes .. 0   (offset: 0x6aa)
// strings ... 3   (offset: 0x6aa)
// dev strs .. 0   (offset: 0x6ce)
// exports ... 6   (offset: 0x44a)
// cseg ...... 0x9d + 0x3ad (0x44a)
// imports ... 13  (offset: 0x53a)
// animtree1 . 0   (offset: 0x6ce)
// animtree2 . 0   (offset: 0x6ce)
#namespace br_floating_names;

// Namespace br_floating_names
// Params 1
// Checksum 0x65551978, Offset: 0xbb
// Size: 0x127
function function_51abc721712b72ce( floatingnames )
{
    if ( getdvarint( @"hash_6979a78a1820ac18", 0 ) != 0 )
    {
        return;
    }
    
    level waittill( #"prematch_started" );
    wait 3;
    
    while ( !isdefined( level.br_ac130 ) )
    {
        wait 0.1;
    }
    
    fwd_ang = level.br_ac130.angles;
    fwd_ang += ( 0, -90, 0 );
    level.name_fx = [];
    
    foreach ( floatingname in floatingnames )
    {
        function_c074953abc4ec497( floatingname.name, ( floatingname.x, floatingname.y, floatingname.z ), fwd_ang );
    }
    
    level thread function_93d284f8edaeccc();
}

// Namespace br_floating_names
// Params 3
// Checksum 0x851a1cc7, Offset: 0x1ea
// Size: 0x2f
function function_c074953abc4ec497( scriptablestate, loc, fwd_ang )
{
    level thread function_457eaf3c24f41679( scriptablestate, loc, fwd_ang, "name_fx" );
}

// Namespace br_floating_names
// Params 4
// Checksum 0x3016b407, Offset: 0x221
// Size: 0x93
function function_457eaf3c24f41679( scriptablestate, loc, fwd_ang, scriptablepart )
{
    loc += ( 0, 0, 500 );
    name_fx_scriptable = spawn( "script_model", loc );
    name_fx_scriptable setmodel( "t10_tag_origin_area99_floating_name_fx" );
    name_fx_scriptable.angles = fwd_ang;
    level.name_fx[ level.name_fx.size ] = name_fx_scriptable;
    name_fx_scriptable setscriptablepartstate( scriptablepart, scriptablestate );
    name_fx_scriptable forcenetfieldhighlod( 1 );
}

// Namespace br_floating_names
// Params 0
// Checksum 0x54acc55a, Offset: 0x2bc
// Size: 0xa6
function function_93d284f8edaeccc()
{
    level thread brhidenamefxfromplayers();
    
    while ( isdefined( level.br_ac130 ) )
    {
        wait 0.1;
    }
    
    wait 90;
    level notify( #"hash_1c918d0a4ce43118" );
    
    foreach ( element in level.name_fx )
    {
        element delete();
    }
}

// Namespace br_floating_names
// Params 0
// Checksum 0xd08bba90, Offset: 0x36a
// Size: 0xe0
function brhidenamefxfromplayers()
{
    level endon( #"game_ended" );
    level endon( #"hash_1c918d0a4ce43118" );
    throttle = 10;
    throttle_wait = 0.25;
    
    while ( level.name_fx.size > 0 )
    {
        player_list = level.players;
        
        for ( i = 0; i < player_list.size ; i++ )
        {
            test_player = player_list[ i ];
            
            if ( isalive( test_player ) )
            {
                if ( isdefined( test_player.vehicle ) )
                {
                    for ( j = 0; j < level.name_fx.size ; j++ )
                    {
                        level.name_fx[ j ] hidefromplayer( test_player );
                    }
                }
            }
            
            if ( i % throttle == 0 )
            {
                wait throttle_wait;
            }
        }
        
        wait 0.1;
    }
}

