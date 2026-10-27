// script_294e8d1ebcb1de03  (hash_294e8d1ebcb1de03.gscc) (size: 6069 Bytes / 0x17b5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf55e8e61 (4116614753)
// size ...... 6069 (0x17b5)
// includes .. 5   (offset: 0x130d)
// strings ... 81  (offset: 0x1335)
// dev strs .. 2   (offset: 0x179d)
// exports ... 7   (offset: 0x1045)
// cseg ...... 0xab6 + 0x58f (0x1045)
// imports ... 15  (offset: 0x115d)
// animtree1 . 0   (offset: 0x17b5)
// animtree2 . 0   (offset: 0x17b5)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;

#namespace elite_ironclad_dialogs;

// Namespace elite_ironclad_dialogs
// Params 0
// Checksum 0x20f7dcb7, Offset: 0xad4
// Size: 0x3b
function init()
{
    if ( !utility::flag_exist( "elite_ironclad_dialogs_init" ) )
    {
        utility::flag_init( "elite_ironclad_dialogs_init" );
        level thread init_dialogs();
        level callback::add( #"player_connect", &on_player_connect );
    }
}

// Namespace elite_ironclad_dialogs
// Params 0
// Checksum 0x5493ede, Offset: 0xb17
// Size: 0x2e0
function init_dialogs()
{
    level endon( #"game_ended" );
    game[ "dialog" ][ "elite_ironclad_contract_start_team" ] = "dx_br_brcq_cque_wzan_cqit";
    game[ "dialog" ][ "elite_ironclad_contract_start_enemy" ] = "dx_br_brcq_cque_wzan_cqie";
    game[ "dialog" ][ "elite_ironclad_isotope_step_start" ] = "dx_br_brcq_cque_wzan_cp1t";
    game[ "dialog" ][ "elite_ironclad_isotope_stolen" ] = "dx_br_brcq_cque_wzan_cist";
    game[ "dialog" ][ "elite_ironclad_isotope_extract_start" ] = "dx_br_brcq_cque_wzan_cise";
    game[ "dialog" ][ "elite_ironclad_isotope_enemy_extract_start" ] = "dx_br_brcq_cque_wzan_ciea";
    game[ "dialog" ][ "elite_ironclad_isotope_extracted_cq_failed" ] = "dx_br_brcq_cque_wzan_ciet";
    game[ "dialog" ][ "elite_ironclad_isotope_extract_success" ] = "dx_br_brcq_cque_wzan_ciee";
    game[ "dialog" ][ "elite_ironclad_isotope_enemy_secured" ] = "dx_br_brcq_cque_wzan_cice";
    game[ "dialog" ][ "elite_ironclad_isotope_recovered" ] = "dx_br_brcq_cque_wzan_cirt";
    game[ "dialog" ][ "elite_ironclad_isotope_reacquired" ] = "dx_br_brcq_cque_wzan_cire";
    game[ "dialog" ][ "elite_ironclad_isotope_secured" ] = "dx_br_brcq_cque_wzan_p1et";
    game[ "dialog" ][ "elite_ironclad_chopper_step_start" ] = "dx_br_brcq_cque_wzan_p2st";
    game[ "dialog" ][ "elite_ironclad_chopper_enemy_step_start" ] = "dx_br_brcq_cque_wzan_p2se";
    game[ "dialog" ][ "elite_ironclad_drive_stolen" ] = "dx_br_brcq_cque_wzan_cdst";
    game[ "dialog" ][ "elite_ironclad_drive_extract_start" ] = "dx_br_brcq_cque_wzan_cdse";
    game[ "dialog" ][ "elite_ironclad_drive_enemy_extract_start" ] = "dx_br_brcq_cque_wzan_cdea";
    game[ "dialog" ][ "elite_ironclad_drive_extracted_cq_failed" ] = "dx_br_brcq_cque_wzan_cdet";
    game[ "dialog" ][ "elite_ironclad_drive_extract_success" ] = "dx_br_brcq_cque_wzan_cdee";
    game[ "dialog" ][ "elite_ironclad_drive_enemy_secured" ] = "dx_br_brcq_cque_wzan_cdce";
    game[ "dialog" ][ "elite_ironclad_drive_recovered" ] = "dx_br_brcq_cque_wzan_cdrt";
    game[ "dialog" ][ "elite_ironclad_drive_reacquired" ] = "dx_br_brcq_cque_wzan_cdre";
    game[ "dialog" ][ "elite_ironclad_drive_secured" ] = "dx_br_brcq_cque_wzan_p2et";
    game[ "dialog" ][ "elite_ironclad_bunker_step_start" ] = "dx_br_brcq_cque_wzan_p3st";
    game[ "dialog" ][ "elite_ironclad_bunker_enemy_step_start" ] = "dx_br_brcq_cque_wzan_p2ee";
    game[ "dialog" ][ "elite_ironclad_bunker_secured" ] = "dx_br_brcq_cque_wzan_cktp";
    game[ "dialog" ][ "elite_ironclad_bunker_enemy_secured" ] = "dx_br_brcq_cque_wzan_p3se";
    game[ "dialog" ][ "elite_ironclad_payload_step_start" ] = "dx_br_brcq_cque_wzan_cmct";
    game[ "dialog" ][ "elite_ironclad_payload_enemy_step_start" ] = "dx_br_brcq_cque_wzan_cmce";
    game[ "dialog" ][ "elite_ironclad_payload_isotope_delivered" ] = "dx_br_brcq_cque_wzan_cest";
    game[ "dialog" ][ "elite_ironclad_payload_enemy_isotope_delivered" ] = "dx_br_brcq_cque_wzan_cese";
    game[ "dialog" ][ "elite_ironclad_payload_secured" ] = "dx_br_brcq_cque_wzan_cflt";
    game[ "dialog" ][ "elite_ironclad_payload_enemy_secured" ] = "dx_br_brcq_cque_wzan_cfle";
    game[ "dialog" ][ "elite_ironclad_cq_team_failed" ] = "dx_br_brcq_cque_wzan_cmdt";
    game[ "dialog" ][ "elite_ironclad_missile_disabled_saviors" ] = "dx_br_brcq_cque_wzan_cmdi";
    game[ "dialog" ][ "elite_ironclad_missile_disabled" ] = "dx_br_brcq_cque_wzan_cmde";
    game[ "dialog" ][ "elite_ironclad_missile_launched" ] = "dx_br_brcq_cque_wzan_cmdf";
    game[ "dialog" ][ "elite_ironclad_enemy_missile_launched" ] = "dx_br_brcq_cque_wzan_mide";
}

// Namespace elite_ironclad_dialogs
// Params 1, eflags: 0x4
// Checksum 0x18872e05, Offset: 0xdff
// Size: 0x1c
function private on_player_connect( params )
{
    if ( !isbot( self ) )
    {
        thread function_17715133f6c0f7ba();
    }
}

// Namespace elite_ironclad_dialogs
// Params 1
// Checksum 0xd0ca19ce, Offset: 0xe23
// Size: 0xd8
function function_86e69830b4062c31( params )
{
    level endon( #"game_ended" );
    players = get_dialog_players( params );
    delay = params.delay ?? 0;
    
    foreach ( player in players )
    {
        if ( isbot( player ) )
        {
            continue;
        }
        
        player thread br_public::brleaderdialogplayer( params.var_22392512aa68e918, player, undefined, undefined, delay, undefined, "" );
    }
}

// Namespace elite_ironclad_dialogs
// Params 1, eflags: 0x4
// Checksum 0x3486509c, Offset: 0xf03
// Size: 0x107
function private get_dialog_players( params )
{
    assert( isdefined( params.scope ), "<dev string:x24>" );
    cq_team_players = [];
    
    if ( level.elite_ironclad.cq_team )
    {
        cq_team_players = teams::getteamdata( level.elite_ironclad.cq_team, "players" );
    }
    
    switch ( params.scope )
    {
        case 0:
            return level.players;
        case 1:
            return cq_team_players;
        case 2:
            var_2f0e7e6815a92743 = arraycopy( level.players );
            return arrayremove( var_2f0e7e6815a92743, cq_team_players );
        case 3:
            assert( isdefined( params.team ), "<dev string:x41>" );
            return teams::getteamdata( params.team, "players" );
    }
}

// Namespace elite_ironclad_dialogs
// Params 0, eflags: 0x4
// Checksum 0xee8d7156, Offset: 0x1012
// Size: 0x33
function private function_17715133f6c0f7ba()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    level flags::function_2f3408423ccc9b2e( "infil_animatic_complete" );
}

