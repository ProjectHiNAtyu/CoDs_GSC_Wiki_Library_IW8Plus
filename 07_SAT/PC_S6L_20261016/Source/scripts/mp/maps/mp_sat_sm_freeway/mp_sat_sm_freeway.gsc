// scripts\mp\maps\mp_sat_sm_freeway\mp_sat_sm_freeway.gsc  (hash_66449ca519f6cbad.gscc) (size: 2786 Bytes / 0xae2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x998a0424 (2575959076)
// size ...... 2786 (0xae2)
// includes .. 9   (offset: 0x9ea)
// strings ... 14  (offset: 0xa32)
// dev strs .. 0   (offset: 0xae2)
// exports ... 7   (offset: 0x5aa)
// cseg ...... 0x12f + 0x47b (0x5aa)
// imports ... 28  (offset: 0x6c2)
// animtree1 . 0   (offset: 0xae2)
// animtree2 . 0   (offset: 0xae2)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_sm_freeway\gen\mp_sat_sm_freeway_art;
#using scripts\mp\maps\mp_sat_sm_freeway\mp_sat_sm_freeway_fx;
#using scripts\mp\maps\mp_sat_sm_freeway\mp_sat_sm_freeway_lighting;
#using scripts\mp\spawnlogic;

#namespace mp_sat_sm_freeway;

// Namespace mp_sat_sm_freeway
// Params 0
// Checksum 0xb0694054, Offset: 0x14d
// Size: 0xf2
function main()
{
    mp_sat_sm_freeway_art::main();
    mp_sat_sm_freeway_fx::main();
    mp_sat_sm_freeway_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_sm_freeway" );
    level.var_86587f097a6ea895 = 1;
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    callback::add( #"player_spawn_init", &on_player_spawn_init );
    level thread function_77406dc263facd66();
}

// Namespace mp_sat_sm_freeway
// Params 1, eflags: 0x4
// Checksum 0x67cdadb4, Offset: 0x247
// Size: 0x13
function private on_player_spawn_init( params )
{
    function_c99b6984f2a38660();
}

// Namespace mp_sat_sm_freeway
// Params 0, eflags: 0x4
// Checksum 0x830fe70, Offset: 0x262
// Size: 0x16
function private function_c99b6984f2a38660()
{
    spawnlogic::function_e9b594d3d6d08748( ( -549.987, -2192.43, -96 ) );
}

// Namespace mp_sat_sm_freeway
// Params 0, eflags: 0x4
// Checksum 0xd749b317, Offset: 0x280
// Size: 0x96
function private function_77406dc263facd66()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_done" );
    wait 3;
    
    if ( getxhash( game_utility::getgametype() ) != #"dd" )
    {
        return;
    }
    
    s_bombzone_a = level.objectives[ "_a" ];
    
    if ( !isdefined( s_bombzone_a ) )
    {
        return;
    }
    
    s_bombzone_a thread function_a042b5914c4f8ab1();
    
    /#
        if ( getdvarint( @"hash_23b66b7b08f643eb", 0 ) )
        {
            level thread debug_draw_trigger( s_bombzone_a.trigger, ( 1, 0, 0 ) );
        }
    #/
}

// Namespace mp_sat_sm_freeway
// Params 0, eflags: 0x4
// Checksum 0xe2b49f33, Offset: 0x31e
// Size: 0x247
function private function_a042b5914c4f8ab1()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( e_player in level.players )
        {
            if ( !level.aplanted && e_player.team != game[ "attackers" ] || level.aplanted && e_player.team != game[ "defenders" ] )
            {
                continue;
            }
            
            var_a232a4fcba91b3d0 = e_player istouching( self.trigger );
            
            if ( !var_a232a4fcba91b3d0 )
            {
                continue;
            }
            
            var_e97587974da3c75b = self.trigger.origin - e_player.origin;
            var_667af1b98225ac63 = vectornormalize( var_e97587974da3c75b );
            var_d56440b3de40d025 = ( vectordot( var_667af1b98225ac63, anglestoright( self.trigger.angles ) ), vectordot( var_667af1b98225ac63, anglestoup( self.trigger.angles ) ), vectordot( var_667af1b98225ac63, anglestoforward( self.trigger.angles ) ) );
            var_318709386e937855 = var_d56440b3de40d025[ 0 ] > 0.5 || var_d56440b3de40d025[ 2 ] < -0.6;
            
            if ( var_318709386e937855 )
            {
                self.trigger disableplayeruse( e_player );
                
                /#
                    var_c9e35826ee79c05c = ( 1, 0, 0 );
                #/
            }
            else
            {
                self.trigger enableplayeruse( e_player );
                
                /#
                    var_c9e35826ee79c05c = ( 0, 1, 0 );
                #/
            }
            
            /#
                if ( getdvarint( @"hash_23b66b7b08f643eb", 0 ) )
                {
                    debug_utility::drawline( self.trigger.origin, e_player.origin, getframeduration() / 1000, var_c9e35826ee79c05c );
                }
            #/
        }
        
        waitframe();
    }
}

/#

    // Namespace mp_sat_sm_freeway
    // Params 2, eflags: 0x4
    // Checksum 0x5ab4bc6, Offset: 0x56d
    // Size: 0x3d, Type: dev
    function private debug_draw_trigger( trigger, var_c9e35826ee79c05c )
    {
        if ( !isdefined( var_c9e35826ee79c05c ) )
        {
            var_c9e35826ee79c05c = undefined;
        }
        
        level endon( #"game_ended" );
        
        while ( true )
        {
            drawtrigger( trigger, var_c9e35826ee79c05c );
            waitframe();
        }
    }

#/
