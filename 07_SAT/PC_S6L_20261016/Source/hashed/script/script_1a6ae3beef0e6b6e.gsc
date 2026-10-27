// script_1a6ae3beef0e6b6e  (hash_1a6ae3beef0e6b6e.gscc) (size: 6457 Bytes / 0x1939 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6d97120e (1838617102)
// size ...... 6457 (0x1939)
// includes .. 10  (offset: 0x1775)
// strings ... 24  (offset: 0x17c5)
// dev strs .. 5   (offset: 0x18fd)
// exports ... 19  (offset: 0xe91)
// cseg ...... 0x236 + 0xc5b (0xe91)
// imports ... 52  (offset: 0x1189)
// animtree1 . 0   (offset: 0x1939)
// animtree2 . 0   (offset: 0x1939)
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\interaction;

#namespace br_sierra_sidequest_floating_doors;

// Namespace br_sierra_sidequest_floating_doors
// Params 0, eflags: 0x5
// Checksum 0x2988c65d, Offset: 0x254
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hash_2f002762ad138cfa", #"br_map_quest", &pre_main, &post_main );
}

// Namespace br_sierra_sidequest_floating_doors
// Params 0, eflags: 0x4
// Checksum 0xd008ab0f, Offset: 0x281
// Size: 0x56
function private pre_main()
{
    if ( !getdvarint( @"hash_3a2e55021e165314", 1 ) )
    {
        return;
    }
    
    quest = { #on_infil:&on_infil, #on_init:&on_init, #name:"floating_doors" };
    br_map_quest::register( quest );
}

// Namespace br_sierra_sidequest_floating_doors
// Params 0, eflags: 0x4
// Checksum 0xe674eac9, Offset: 0x2df
// Size: 0x2
function private post_main()
{
    
}

// Namespace br_sierra_sidequest_floating_doors
// Params 0
// Checksum 0x1356415f, Offset: 0x2e9
// Size: 0x1c5
function on_init()
{
    var_5204e8c1bfc4b44d = [ [ 1, 2, 3, 7, 4 ], [ 3, 5, 7, 2, 6 ], [ 7, 2, 4, 6, 0 ], [ 7, 2, 1, 4, 3 ], [ 0, 1, 2, 4, 3 ] ];
    level.var_f20b7e2081e8cb06 = spawnstruct();
    level.var_f20b7e2081e8cb06.code = [];
    level.var_f20b7e2081e8cb06.doorhit = 0;
    level.var_f20b7e2081e8cb06.doors = [];
    airdrop_scriptbundle::registerairdrop( "airdrop_sierra_sidequest_floating_doors_reward", &function_2c1e7d4f12f2cdcb );
    possiblepositions = utility::getstructarray( "floating_door_image_loc", "targetname" );
    doorvariation = randomint( 5 );
    level.var_f20b7e2081e8cb06.code = var_5204e8c1bfc4b44d[ doorvariation ];
    level.var_f20b7e2081e8cb06.imageposition = utility::array_random( possiblepositions );
    level.var_f20b7e2081e8cb06.variation = doorvariation + 1;
    level.var_f20b7e2081e8cb06.doorpositions = utility::getstructarray( "floating_door_location", "targetname" );
    thread function_1ce55f684de604de();
    
    /#
        debug_init();
    #/
}

// Namespace br_sierra_sidequest_floating_doors
// Params 0
// Checksum 0x4bc9be8, Offset: 0x4b6
// Size: 0x9
function on_infil()
{
    thread spawninteract();
}

// Namespace br_sierra_sidequest_floating_doors
// Params 1
// Checksum 0x83760e39, Offset: 0x4c7
// Size: 0x99
function spawninteract( variation )
{
    scriptable = spawnscriptable( "mp_wz2_sierra_floating_door_picture", level.var_f20b7e2081e8cb06.imageposition.origin, level.var_f20b7e2081e8cb06.imageposition.angles );
    scriptable.interact = interaction::register_scriptable_interact( scriptable, &pictureused );
    scriptable setscriptablepartstate( "model", "variation" + level.var_f20b7e2081e8cb06.variation );
}

// Namespace br_sierra_sidequest_floating_doors
// Params 1
// Checksum 0xd4dfac01, Offset: 0x568
// Size: 0x61
function pictureused( player )
{
    level.var_f20b7e2081e8cb06.dlogs.plansviewed += 1;
    self setscriptablepartstate( "base", "disabled" );
    thread spawndoors();
}

// Namespace br_sierra_sidequest_floating_doors
// Params 0
// Checksum 0x8742a73f, Offset: 0x5d1
// Size: 0x1f6
function spawndoors()
{
    level endon( #"game_ended" );
    
    foreach ( doorposition in level.var_f20b7e2081e8cb06.doorpositions )
    {
        doorindex = int( doorposition.script_noteworthy );
        destination = doorposition.origin;
        spawnpos = destination - ( 0, 0, 2000 );
        door = spawn( "script_model", spawnpos );
        door setmodel( "door_wood_old_01_script" );
        door.var_bb41f064391971dd = doorindex;
        level.var_f20b7e2081e8cb06.doors[ level.var_f20b7e2081e8cb06.doors.size ] = door;
        door rotatevelocity( ( 0, 140, 0 ), 99999 );
        door moveto( destination, 5 );
        wait 1;
    }
    
    wait 5;
    
    foreach ( door in level.var_f20b7e2081e8cb06.doors )
    {
        door rotateto( ( 0, 21, 0 ), 0.4 );
        door setcandamage( 1 );
    }
    
    scriptable::scriptable_addnotifycallback( "floatingdoorhit", &floatingdoorhit );
}

// Namespace br_sierra_sidequest_floating_doors
// Params 4
// Checksum 0x47340f54, Offset: 0x7cf
// Size: 0x103
function floatingdoorhit( instance, note, param, var_64ffacba090c91be )
{
    instance.entity rotatevelocity( ( 0, 1000, 0 ), 2, 0, 2 );
    thread entercode( instance.entity, var_64ffacba090c91be );
    
    if ( !arraycontains( level.var_f20b7e2081e8cb06.dlogs.var_cc70c610c1970991, var_64ffacba090c91be ) )
    {
        level.var_f20b7e2081e8cb06.dlogs.var_cc70c610c1970991[ level.var_f20b7e2081e8cb06.dlogs.var_cc70c610c1970991.size ] = var_64ffacba090c91be;
    }
    
    level waittill( #"hash_fe39e900bdf2aa98" );
    instance setscriptablepartstate( "base", "off" );
    instance.entity rotateto( ( 0, 21, 0 ), 0.4 );
}

// Namespace br_sierra_sidequest_floating_doors
// Params 2
// Checksum 0xaa235ae4, Offset: 0x8da
// Size: 0x120
function entercode( door, player )
{
    level endon( #"game_ended" );
    
    if ( level.var_f20b7e2081e8cb06.code[ level.var_f20b7e2081e8cb06.doorhit ] != door.var_bb41f064391971dd )
    {
        level.var_f20b7e2081e8cb06.doorhit = 0;
        player playlocalsound( "evt_door_bad" );
        wait 1.6;
        level notify( #"hash_fe39e900bdf2aa98" );
        return;
    }
    
    level.var_f20b7e2081e8cb06.doorhit++;
    player playlocalsound( "evt_door_good" );
    
    if ( level.var_f20b7e2081e8cb06.doorhit == level.var_f20b7e2081e8cb06.code.size )
    {
        wait 1.6;
        door rotatevelocity( ( 0, 200, 0 ), 99999 );
        thread sidequestcompleted( player );
        return;
    }
    
    wait 1.6;
    door rotatevelocity( ( 0, 200, 0 ), 99999 );
}

// Namespace br_sierra_sidequest_floating_doors
// Params 0
// Checksum 0xe2ebff46, Offset: 0xa02
// Size: 0x100
function function_1ce55f684de604de()
{
    level.var_f20b7e2081e8cb06.dlogs = { #challengescompleted:0, #cratesopened:0, #plansviewed:0, #var_cc70c610c1970991:[] };
    level waittill( #"game_ended" );
    dlog_recordevent( "dlog_event_br_sierra_sidequest_27", [ "players_who_hit", level.var_f20b7e2081e8cb06.dlogs.var_cc70c610c1970991.size, "plans_viewed", level.var_f20b7e2081e8cb06.dlogs.plansviewed, "crates_opened", level.var_f20b7e2081e8cb06.dlogs.cratesopened, "challenges_completed", level.var_f20b7e2081e8cb06.dlogs.challengescompleted ] );
}

// Namespace br_sierra_sidequest_floating_doors
// Params 1
// Checksum 0x4a4e29e, Offset: 0xb0a
// Size: 0x247
function sidequestcompleted( player )
{
    level endon( #"game_ended" );
    level.var_f20b7e2081e8cb06.dlogs.challengescompleted += 1;
    scriptable::function_65c9f35ffd4310f8( "floatingdoorhit", &floatingdoorhit );
    points::function_40522c040a4e7b1( player.team, #"hash_827622689bb23fff" );
    challenges::function_37e945722d6497f3( player, "sierra_sidequest_27", 1, 1 );
    playerteam = player.team;
    quest = level.br_map_quest.quests[ "floating_doors" ];
    params = { #completed_by:teams::getteamdata( player.team, "players" ), #is_successful:1 };
    quest br_map_quest::on_completed( params );
    
    foreach ( door in level.var_f20b7e2081e8cb06.doors )
    {
        door setscriptablepartstate( "base", "completed" );
        door rotatevelocity( ( 0, 200, 0 ), 99999 );
    }
    
    wait 5;
    
    foreach ( door in level.var_f20b7e2081e8cb06.doors )
    {
        door moveto( ( 68773, -46584, 1071 ), 10 );
        wait 0.5;
    }
    
    callairdrop( playerteam );
}

// Namespace br_sierra_sidequest_floating_doors
// Params 1
// Checksum 0x7537c42c, Offset: 0xd59
// Size: 0x3f
function callairdrop( team )
{
    overridestruct = { #droporigin:( 60205, -39258, -554 ) };
    airdrop_scriptbundle::startairdrop( "airdrop_sierra_sidequest_floating_doors_reward", undefined, team, overridestruct );
}

// Namespace br_sierra_sidequest_floating_doors
// Params 1
// Checksum 0x8c06b36a, Offset: 0xda0
// Size: 0x4a
function function_2c1e7d4f12f2cdcb( crate )
{
    level.var_f20b7e2081e8cb06.dlogs.cratesopened += 1;
}

/#

    // Namespace br_sierra_sidequest_floating_doors
    // Params 0, eflags: 0x4
    // Checksum 0xa462c72e, Offset: 0xdf2
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace br_sierra_sidequest_floating_doors
    // Params 0, eflags: 0x4
    // Checksum 0xb217ffa8, Offset: 0xe06
    // Size: 0x44, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x42>", "<dev string:x4e>", &function_c5b229b782cc3c1d );
        devgui::function_cd4e263c1f3018ae( "<dev string:x63>", "<dev string:x72>", &debugcompletequest );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_sierra_sidequest_floating_doors
    // Params 1, eflags: 0x4
    // Checksum 0x9a9913da, Offset: 0xe52
    // Size: 0x16, Type: dev
    function private function_c5b229b782cc3c1d( params )
    {
        thread spawndoors();
    }

    // Namespace br_sierra_sidequest_floating_doors
    // Params 1, eflags: 0x4
    // Checksum 0xfc1638c9, Offset: 0xe70
    // Size: 0x21, Type: dev
    function private debugcompletequest( params )
    {
        thread sidequestcompleted( level.players[ 0 ] );
    }

#/
