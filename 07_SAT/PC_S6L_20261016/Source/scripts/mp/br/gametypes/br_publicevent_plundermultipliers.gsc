// scripts\mp\br\gametypes\br_publicevent_plundermultipliers.gsc  (hash_30258161139f67c2.gscc) (size: 5021 Bytes / 0x139d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2d2fe0bc (758112444)
// size ...... 5021 (0x139d)
// includes .. 2   (offset: 0x1229)
// strings ... 26  (offset: 0x1239)
// dev strs .. 0   (offset: 0x139d)
// exports ... 24  (offset: 0xb25)
// cseg ...... 0x27c + 0x8a9 (0xb25)
// imports ... 26  (offset: 0xee5)
// animtree1 . 0   (offset: 0x139d)
// animtree2 . 0   (offset: 0x139d)
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;

#namespace br_publicevent_plundermultipliers;

// Namespace br_publicevent_plundermultipliers
// Params 0, eflags: 0x1
// Checksum 0xebb2e026, Offset: 0x29a
// Size: 0x41
function autoexec main()
{
    br_publicevents::function_54d95495df246a2b( %"bloodmoney", &function_e073e5f8cd9e9e44 );
    br_publicevents::function_54d95495df246a2b( %"contractor", &initcontractor );
    br_publicevents::function_54d95495df246a2b( %"moneysiphon", &function_ded185ec733ef5f5 );
}

// Namespace br_publicevent_plundermultipliers
// Params 1
// Checksum 0xd74b0c3c, Offset: 0x2e3
// Size: 0xcc
function function_e073e5f8cd9e9e44( bloodmoney )
{
    if ( !isdefined( level.plundermultipliers ) )
    {
        level.plundermultipliers = spawnstruct();
    }
    
    bloodmoney.activatefunc = &bloodmoney_activatefunc;
    bloodmoney.waitfunc = &bloodmoney_waitfunc;
    bloodmoney.postinitfunc = &bloodmoney_postinitfunc;
    bloodmoney.timertype = 10;
    bloodmoney.var_cbb382bf8ba8d81 = getdvarint( @"hash_290bf19648dc8eb2", 2 );
    bloodmoney.var_c2a36c673b8054d5 = getdvarfloat( @"hash_8685285f3db98a1c", 2 );
    bloodmoney.duration = getdvarint( @"hash_4e87bb76afe4eb45", 120 );
    bloodmoney.type = %"bloodmoney";
}

// Namespace br_publicevent_plundermultipliers
// Params 1
// Checksum 0xda7335cc, Offset: 0x3b7
// Size: 0xd3
function initcontractor( contractor )
{
    if ( !isdefined( level.plundermultipliers ) )
    {
        level.plundermultipliers = spawnstruct();
    }
    
    contractor.activatefunc = &contractor_activatefunc;
    contractor.waitfunc = &contractor_waitfunc;
    contractor.postinitfunc = &contractor_postinitfunc;
    contractor.timertype = 11;
    contractor.var_2371647dff4b6751 = getdvarint( @"hash_f4f0d78ce0da6030", 2 );
    contractor.duration = getdvarint( @"hash_5b1205ec7121272c", 120 );
    contractor.type = %"contractor";
    contractor.onend = &contractorend;
    contractor.onstart = &contractorstart;
}

// Namespace br_publicevent_plundermultipliers
// Params 0
// Checksum 0xe865a72d, Offset: 0x492
// Size: 0x15d
function contractorstart()
{
    if ( isdefined( level.contractmanager ) )
    {
        if ( isdefined( level.contractmanager.currenttasks ) )
        {
            foreach ( task in level.contractmanager.currenttasks )
            {
                if ( !task.contractoractive )
                {
                    task.contractoractive = 1;
                }
            }
        }
    }
    
    if ( isdefined( level.contractmanager.var_47ca1f8bfd0c7ece ) )
    {
        foreach ( contractstartfunc in level.contractmanager.var_47ca1f8bfd0c7ece )
        {
            thread [[ contractstartfunc ]]();
        }
    }
    
    setomnvar( "contractor_active", 1 );
}

// Namespace br_publicevent_plundermultipliers
// Params 0
// Checksum 0x290baaff, Offset: 0x5f7
// Size: 0xa3
function contractorend()
{
    if ( isdefined( level.contractmanager.var_f47c95550183eda9 ) )
    {
        foreach ( var_b0a6cd45f0a68e7b in level.contractmanager.var_f47c95550183eda9 )
        {
            thread [[ var_b0a6cd45f0a68e7b ]]();
        }
    }
    
    setomnvar( "contractor_active", 0 );
}

// Namespace br_publicevent_plundermultipliers
// Params 1
// Checksum 0x1bafa8dc, Offset: 0x6a2
// Size: 0x58
function function_ded185ec733ef5f5( moneysiphon )
{
    if ( !isdefined( level.plundermultipliers ) )
    {
        level.plundermultipliers = spawnstruct();
    }
    
    moneysiphon.activatefunc = &moneysiphon_activatefunc;
    moneysiphon.waitfunc = &moneysiphon_waitfunc;
    moneysiphon.postinitfunc = &moneysiphon_postinitfunc;
}

// Namespace br_publicevent_plundermultipliers
// Params 2
// Checksum 0xbdc1b1b8, Offset: 0x702
// Size: 0x15e
function function_f1fd8a577fd104dd( eventstruct, eventname )
{
    level endon( #"game_ended" );
    br_publicevents::showsplashtoall( "br_plunder_pe_" + eventname + "_active", "splash_list_br_plunder_iw9_mp" );
    br_public::brleaderdialog( "public_events_" + eventname + "_start" );
    setomnvar( "ui_minimap_pulse", 1 );
    setomnvar( "ui_publicevent_timer_type", eventstruct.timertype );
    eventduration = eventstruct.duration;
    eventendtime = gettime() + eventduration * 1000;
    setomnvar( "ui_publicevent_timer", eventendtime );
    
    if ( isdefined( eventstruct.onstart ) )
    {
        [[ eventstruct.onstart ]]();
    }
    else
    {
        eventstruct.active = 1;
    }
    
    thread function_29a972fba9b582c7( eventname );
    wait eventduration;
    
    if ( isdefined( eventstruct.onend ) )
    {
        [[ eventstruct.onend ]]();
    }
    else
    {
        eventstruct.active = 0;
    }
    
    br_publicevents::function_a1af4e372c2ecc3( eventstruct.type );
    level notify( "public_event_" + eventname + "_end" );
    br_public::brleaderdialog( "public_events_" + eventname + "_end" );
    setomnvar( "ui_minimap_pulse", 0 );
    setomnvar( "ui_publicevent_timer_type", 0 );
}

// Namespace br_publicevent_plundermultipliers
// Params 1
// Checksum 0x1f1a122, Offset: 0x868
// Size: 0x24
function function_29a972fba9b582c7( eventname )
{
    wait 2;
    br_public::brleaderdialog( "public_events_" + eventname + "_active" );
}

// Namespace br_publicevent_plundermultipliers
// Params 0
// Checksum 0xae33ccfc, Offset: 0x894
// Size: 0x28
function bloodmoney_postinitfunc()
{
    game[ "dialog" ][ "public_events_blood_money_start" ] = "bldm_wzan_name";
    game[ "dialog" ][ "public_events_blood_money_active" ] = "bldm_wzan_boos";
}

// Namespace br_publicevent_plundermultipliers
// Params 0
// Checksum 0xf9e5367, Offset: 0x8c4
// Size: 0x2
function bloodmoney_waitfunc()
{
    
}

// Namespace br_publicevent_plundermultipliers
// Params 0
// Checksum 0xc226e792, Offset: 0x8ce
// Size: 0x2d
function bloodmoney_activatefunc()
{
    level endon( #"game_ended" );
    function_f1fd8a577fd104dd( level.br_pe_data[ %"bloodmoney" ], "blood_money" );
}

// Namespace br_publicevent_plundermultipliers
// Params 0
// Checksum 0x111d43e0, Offset: 0x903
// Size: 0x28
function contractor_postinitfunc()
{
    game[ "dialog" ][ "public_events_contractor_start" ] = "ctrc_wzan_name";
    game[ "dialog" ][ "public_events_contractor_active" ] = "ctrc_wzan_boos";
}

// Namespace br_publicevent_plundermultipliers
// Params 0
// Checksum 0x231715b8, Offset: 0x933
// Size: 0x2
function contractor_waitfunc()
{
    
}

// Namespace br_publicevent_plundermultipliers
// Params 0
// Checksum 0xda2450a, Offset: 0x93d
// Size: 0x2d
function contractor_activatefunc()
{
    level endon( #"game_ended" );
    function_f1fd8a577fd104dd( level.br_pe_data[ %"contractor" ], "contractor" );
}

// Namespace br_publicevent_plundermultipliers
// Params 0
// Checksum 0xa647cbba, Offset: 0x972
// Size: 0x2
function heat_postinitfunc()
{
    
}

// Namespace br_publicevent_plundermultipliers
// Params 0
// Checksum 0x8687faed, Offset: 0x97c
// Size: 0x2
function heat_waitfunc()
{
    
}

// Namespace br_publicevent_plundermultipliers
// Params 0
// Checksum 0xccded8fe, Offset: 0x986
// Size: 0x2
function heat_activatefunc()
{
    
}

// Namespace br_publicevent_plundermultipliers
// Params 0
// Checksum 0x18dec51b, Offset: 0x990
// Size: 0x10d
function moneysiphon_postinitfunc()
{
    game[ "dialog" ][ "public_events_money_siphon_active" ] = "csht_wzan_boos";
    moneysiphon = spawnstruct();
    moneysiphon.type = %"moneysiphon";
    moneysiphon.timertype = 13;
    moneysiphon.active = 0;
    moneysiphon.plunderrarity = getdvarint( @"hash_55d165f2f9e49694", 2 );
    moneysiphon.plunderamount = getdvarint( @"hash_1cc3febe5f5f8883", 100 );
    moneysiphon.depositinterval = getdvarfloat( @"hash_23750ae04694dc22", 3 );
    moneysiphon.duration = getdvarint( @"hash_1a720e1709ceabf0", 120 );
    moneysiphon.atmcooldown = getdvarint( @"hash_74f7c2602fc10dd8", 120 );
    moneysiphon.var_9bec47131080388d = getdvarint( @"hash_2ac717f48aef9bd0", 1 );
    level.plundermultipliers.moneysiphon = moneysiphon;
}

// Namespace br_publicevent_plundermultipliers
// Params 0
// Checksum 0x6b2b8ffe, Offset: 0xaa5
// Size: 0x2
function moneysiphon_waitfunc()
{
    
}

// Namespace br_publicevent_plundermultipliers
// Params 0
// Checksum 0xedf70ca3, Offset: 0xaaf
// Size: 0x2d
function moneysiphon_activatefunc()
{
    level endon( #"game_ended" );
    function_f1fd8a577fd104dd( level.plundermultipliers.moneysiphon, "money_siphon" );
}

// Namespace br_publicevent_plundermultipliers
// Params 0
// Checksum 0x3573a919, Offset: 0xae4
// Size: 0x2
function function_474eafdbb3b48e3a()
{
    
}

// Namespace br_publicevent_plundermultipliers
// Params 0
// Checksum 0x31454d6e, Offset: 0xaee
// Size: 0x2
function function_2bd7a6ea9744289f()
{
    
}

// Namespace br_publicevent_plundermultipliers
// Params 0
// Checksum 0x24492037, Offset: 0xaf8
// Size: 0x2d
function function_5a7ee6b7060ee97f()
{
    level endon( #"game_ended" );
    function_f1fd8a577fd104dd( level.br_pe_data[ %"cannonfodder" ], "cannon_fodder" );
}

