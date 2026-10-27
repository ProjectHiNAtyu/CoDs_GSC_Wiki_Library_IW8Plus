// script_66e0763215f56f3d  (hash_66e0763215f56f3d.gscc) (size: 3169 Bytes / 0xc61 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1dc33626 (499332646)
// size ...... 3169 (0xc61)
// includes .. 7   (offset: 0xba5)
// strings ... 6   (offset: 0xbdd)
// dev strs .. 5   (offset: 0xc25)
// exports ... 8   (offset: 0x6dd)
// cseg ...... 0xc3 + 0x61a (0x6dd)
// imports ... 32  (offset: 0x81d)
// animtree1 . 0   (offset: 0xc61)
// animtree2 . 0   (offset: 0xc61)
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\zombie_loom\zombie_loom_ride;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\mp\loot\common_item;

#namespace namespace_d1560d23d8385041;

// Namespace namespace_d1560d23d8385041
// Params 0, eflags: 0x5
// Checksum 0x2496f053, Offset: 0xe1
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_408ac7c5b03780da", undefined, &init, undefined );
}

// Namespace namespace_d1560d23d8385041
// Params 0
// Checksum 0x27becd58, Offset: 0x102
// Size: 0x36
function init()
{
    if ( !getdvarint( @"hash_1339f37dad46cdfd", 0 ) )
    {
        return;
    }
    
    /#
        level thread function_d47998b46f74a407();
    #/
    
    level callback::add( #"on_ai_killed", &on_ai_killed );
}

// Namespace namespace_d1560d23d8385041
// Params 0, eflags: 0x4
// Checksum 0x51503888, Offset: 0x140
// Size: 0x2fb
function private function_516730b98cf396ba()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        if ( self.ridingloom && isalive( self.ridingent ) )
        {
            loom = self.ridingent;
            var_2dce13ad10744d53 = distance2d( level.scarab_pap_quest.var_9d15330b141fe52f.origin, self.ridingent.origin );
            
            if ( var_2dce13ad10744d53 <= 145 )
            {
                loom ai::magic_bullet_shield();
                loom thread zombie_loom_ride::unride_loom( self );
                start_origin = ( level.scarab_pap_quest.var_9d15330b141fe52f.origin[ 0 ], level.scarab_pap_quest.var_9d15330b141fe52f.origin[ 1 ], level.scarab_pap_quest.var_9d15330b141fe52f.origin[ 2 ] + 64 );
                final_origin = ( loom.origin[ 0 ], loom.origin[ 1 ], loom.origin[ 2 ] + 256 );
                loom_kill_origin = ( level.scarab_pap_quest.var_9d15330b141fe52f.origin[ 0 ], level.scarab_pap_quest.var_9d15330b141fe52f.origin[ 1 ], level.scarab_pap_quest.var_9d15330b141fe52f.origin[ 2 ] - 64 );
                loom function_786bb6aa1b76c7ee( "in_ride_mode", 1 );
                loom asm::function_7256f5ba459c840b( "stun_ride_in" );
                waitframe();
                move_loom = spawn( "script_model", loom.origin );
                move_loom setmodel( "tag_origin" );
                loom linkto( move_loom );
                waitframe();
                move_loom moveto( start_origin, 1, 0.25 );
                wait 1;
                move_loom moveto( loom_kill_origin, 1, 0.25 );
                wait 1;
                loom ai::stop_magic_bullet_shield();
                loom.forceannihilate = 1;
                loom kill();
                move_loom delete();
                wait 1;
                spawnoptions = common_item::function_f5dfaa3bbdf99a33( final_origin, start_origin );
                spawnoptions.var_9161cf0784b6951d = 0;
                spawnoptions.var_2321e933cbdf46d8 = 10;
                spawnoptions.var_34444f0dda11f0d5 = 10;
                spawnoptions.var_18608bd8660b3a19 = 2;
                spawnoptions.var_789c456dda9c8572 = start_origin;
                spawnoptions.var_fd47e835523b473f = 1;
                playsoundatpos( start_origin, #"hash_a19ca105e781181e" );
                common_item::function_61c2c0251e742ffd( %"hash_505813c990ca9a5b", 1, spawnoptions );
                return;
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_d1560d23d8385041
// Params 1, eflags: 0x4
// Checksum 0x42e4db38, Offset: 0x443
// Size: 0xd6
function private on_ai_killed( sparams )
{
    player = sparams.eattacker;
    
    if ( self.type == "zombie" )
    {
        if ( isplayer( player ) && player.ridingloom )
        {
            if ( !isdefined( player.var_2f39e4ffb43f6799 ) )
            {
                player.var_2f39e4ffb43f6799 = 0;
            }
            
            player.var_2f39e4ffb43f6799++;
            hat_spawned = level.scarab_ee_masks.spawned_masks[ "zmloot_scarab_loom_ride_ee_mask" ];
            
            if ( !hat_spawned && player.var_2f39e4ffb43f6799 >= 15 && !player.var_8b766bb43481c132 )
            {
                player thread function_516730b98cf396ba();
                player.var_8b766bb43481c132 = 1;
            }
        }
    }
}

/#

    // Namespace namespace_d1560d23d8385041
    // Params 0
    // Checksum 0x4d3f236b, Offset: 0x521
    // Size: 0x151, Type: dev
    function debug_spawn_hat()
    {
        start_origin = ( level.scarab_pap_quest.var_9d15330b141fe52f.origin[ 0 ], level.scarab_pap_quest.var_9d15330b141fe52f.origin[ 1 ], level.scarab_pap_quest.var_9d15330b141fe52f.origin[ 2 ] + 64 );
        final_origin = ( level.scarab_pap_quest.var_9d15330b141fe52f.origin[ 0 ] + 86, level.scarab_pap_quest.var_9d15330b141fe52f.origin[ 1 ], level.scarab_pap_quest.var_9d15330b141fe52f.origin[ 2 ] + 256 );
        spawnoptions = common_item::function_f5dfaa3bbdf99a33( final_origin, start_origin );
        spawnoptions.var_9161cf0784b6951d = 0;
        spawnoptions.var_2321e933cbdf46d8 = 10;
        spawnoptions.var_34444f0dda11f0d5 = 10;
        spawnoptions.var_18608bd8660b3a19 = 2;
        spawnoptions.var_789c456dda9c8572 = start_origin;
        common_item::function_61c2c0251e742ffd( %"hash_505813c990ca9a5b", 1, spawnoptions );
    }

    // Namespace namespace_d1560d23d8385041
    // Params 0
    // Checksum 0x12a337be, Offset: 0x67a
    // Size: 0x17, Type: dev
    function function_74ddcdcee55b335e()
    {
        level.players[ 0 ] thread function_516730b98cf396ba();
    }

    // Namespace namespace_d1560d23d8385041
    // Params 0
    // Checksum 0xc011c177, Offset: 0x699
    // Size: 0x44, Type: dev
    function function_d47998b46f74a407()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x39>", "<dev string:x50>", &function_74ddcdcee55b335e );
        devgui::add_devgui_func( "<dev string:x63>", "<dev string:x6d>", &debug_spawn_hat );
        devgui::function_77df7fe7dd273e10();
    }

#/
