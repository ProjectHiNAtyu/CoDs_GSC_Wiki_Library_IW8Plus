// scripts\mp\maps\mp_sat_karma\mp_sat_karma.gsc  (hash_180f93ffe3ac9405.gscc) (size: 2868 Bytes / 0xb34 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x68953a5 (109663141)
// size ...... 2868 (0xb34)
// includes .. 9   (offset: 0x9fc)
// strings ... 20  (offset: 0xa44)
// dev strs .. 0   (offset: 0xb34)
// exports ... 6   (offset: 0x69c)
// cseg ...... 0x1c5 + 0x4d7 (0x69c)
// imports ... 21  (offset: 0x78c)
// animtree1 . 0   (offset: 0xb34)
// animtree2 . 0   (offset: 0xb34)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_karma\gen\mp_sat_karma_art;
#using scripts\mp\maps\mp_sat_karma\mp_sat_karma_audio;
#using scripts\mp\maps\mp_sat_karma\mp_sat_karma_fx;
#using scripts\mp\maps\mp_sat_karma\mp_sat_karma_lighting;

#namespace mp_sat_karma;

// Namespace mp_sat_karma
// Params 0
// Checksum 0x1dd9a1f1, Offset: 0x1e3
// Size: 0xed
function main()
{
    mp_sat_karma_art::main();
    mp_sat_karma_audio::main();
    mp_sat_karma_fx::main();
    mp_sat_karma_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_karma" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    callback::add( #"player_spawn_init", &on_spawn_init );
    function_5caead65df55abe8();
}

// Namespace mp_sat_karma
// Params 1
// Checksum 0x88e2a6ba, Offset: 0x2d8
// Size: 0xc
function on_spawn_init( params )
{
    
}

// Namespace mp_sat_karma
// Params 0, eflags: 0x4
// Checksum 0xbac3df6e, Offset: 0x2ec
// Size: 0x4a
function private function_5caead65df55abe8()
{
    var_72f297cb02772ad9 = getnoentvolumearray( "t_outline_players_inside", #script_noteworthy );
    var_16175b5a26f704d1 = getnoentvolumearray( "t_show_outline_to", #script_noteworthy );
    level thread xray_update( var_72f297cb02772ad9[ 0 ], var_16175b5a26f704d1[ 0 ] );
}

// Namespace mp_sat_karma
// Params 2, eflags: 0x4
// Checksum 0xdd43fdc, Offset: 0x33e
// Size: 0x2fa
function private xray_update( var_c3ca4c2fec64d53f, var_3e25ded6f2f7b24a )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        var_e78e6ba573b4f65e = [];
        var_8445a86a30b2b62c = [];
        var_946072d2cc00ad2f = [];
        
        foreach ( player in level.players )
        {
            if ( player istouching( var_c3ca4c2fec64d53f ) )
            {
                if ( !isdefined( player.vehicle ) )
                {
                    var_e78e6ba573b4f65e[ var_e78e6ba573b4f65e.size ] = player;
                    continue;
                }
            }
            
            player notify( #"not_in_xray_trigger" );
            e_viewer = player;
            
            if ( isdefined( player.vehicle ) )
            {
                e_viewer = player.vehicle;
            }
            
            if ( e_viewer istouching( var_3e25ded6f2f7b24a ) )
            {
                var_8445a86a30b2b62c[ var_8445a86a30b2b62c.size ] = player;
                continue;
            }
            
            var_946072d2cc00ad2f[ var_946072d2cc00ad2f.size ] = player;
        }
        
        foreach ( player in var_e78e6ba573b4f65e )
        {
            foreach ( var_5c63e39515ffc6b in var_8445a86a30b2b62c )
            {
                var_45e8f548f61c929c = var_5c63e39515ffc6b getentitynumber();
                
                if ( isalive( player ) && !isdefined( player.var_e58db4b0b958337b[ var_45e8f548f61c929c ] ) )
                {
                    var_2a96b0cd08888744 = outline::outlineenableforplayer( player, var_5c63e39515ffc6b, "sat_karma_security_hudoutline", "level_script" );
                    player.var_e58db4b0b958337b[ var_45e8f548f61c929c ] = var_2a96b0cd08888744;
                    player thread removeoutlineonnotify( var_2a96b0cd08888744, var_45e8f548f61c929c );
                }
            }
            
            var_98a41321bf519982 = arraycombine( var_e78e6ba573b4f65e, var_946072d2cc00ad2f );
            
            foreach ( var_197dd3e7d9389f4d in var_98a41321bf519982 )
            {
                if ( isdefined( player.var_e58db4b0b958337b[ var_197dd3e7d9389f4d getentitynumber() ] ) )
                {
                    player notify( #"viewer_no_longer_in_trigger" );
                }
            }
        }
        
        wait 0.25;
    }
}

// Namespace mp_sat_karma
// Params 2
// Checksum 0x1b8bfbd3, Offset: 0x640
// Size: 0x5c
function removeoutlineonnotify( var_2a96b0cd08888744, var_1141729c3e8af491 )
{
    wait_array = [ "not_in_xray_trigger", "death", "viewer_no_longer_in_trigger" ];
    utility::waittill_any_in_array_return_no_endon_death( wait_array );
    outline::outlinedisable( var_2a96b0cd08888744, self );
    self.var_e58db4b0b958337b[ var_1141729c3e8af491 ] = undefined;
}

