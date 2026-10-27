// scripts\vehicle\pluto\pluto_repair.gsc  (hash_43c259a9986a0a9e.gscc) (size: 5128 Bytes / 0x1408 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x55a26ed6 (1436708566)
// size ...... 5128 (0x1408)
// includes .. 8   (offset: 0x12c0)
// strings ... 18  (offset: 0x1300)
// dev strs .. 1   (offset: 0x13fc)
// exports ... 10  (offset: 0xbd4)
// cseg ...... 0x1a2 + 0xa32 (0xbd4)
// imports ... 46  (offset: 0xd64)
// animtree1 . 0   (offset: 0x1408)
// animtree2 . 0   (offset: 0x1408)
#using script_54d7585f0a1791e6;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\currency;
#using scripts\mp\interaction;

#namespace pluto_veh;

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x7b156034, Offset: 0x1c0
// Size: 0x2e
function private function_557ae5b6c6f6d6e5()
{
    level.var_44e9a10b5c6746fc = istrue( utility::callsharedfunc( #"game", #"getmatchrulesdata", "commonOption", "vehicleEngineHealEnabled" ) );
}

// Namespace pluto_veh
// Params 2, eflags: 0x4
// Checksum 0x202bb8ef, Offset: 0x1f6
// Size: 0x1db
function private function_85571d0c8e940a73( interact, player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( interact.b_in_use )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    veh = interact getlinkedparent();
    
    if ( isdefined( level.var_8672fa96c3fb69e0 ) )
    {
        cost = 0;
    }
    else
    {
        cost = function_7ad65cdd5ea7fd48( veh );
    }
    
    hintstring_obj = { #icon_text_value:cost, #var_776a268784e089af:&"SHARED_HINTSTRINGS/COST_SALVAGE", #icon:"ui_icon_crafting_wrench", #buttoncallout:&"zm_sat_firefly/pluto_r_btn_callout", #description:&"zm_sat_firefly/pluto_r_desc", #title:&"zm_sat_firefly/pluto_r_title", #type:"HINT_BUTTON" };
    
    if ( !player currency::can_afford( #"salvage", cost ) )
    {
        hintstring_obj.aux_text = &"shared_hintstrings/not_enough_salvage";
        hintstring_obj.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_SALVAGE_NOT_ENOUGH";
        hintstring_obj.interactable = 0;
    }
    
    if ( veh utility::ent_flag( "repair_recalibrating" ) )
    {
        hintstring_obj.aux_text = &"zm_sat_firefly/pluto_r_cooldown";
        hintstring_obj.var_776a268784e089af = &"shared_hintstrings/icon_text_cooldown_seconds";
        hintstring_obj.icon_text_value = veh.var_438dff673ff312b4;
        hintstring_obj.interactable = 0;
    }
    
    return hintstring_obj;
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x368c17b7, Offset: 0x3da
// Size: 0x310
function private function_340a88abd3667afa( player )
{
    level endon( #"game_ended" );
    
    foreach ( other_player in level.players )
    {
        if ( other_player == player )
        {
            continue;
        }
        
        self disableplayeruse( other_player );
    }
    
    if ( self.b_in_use )
    {
        return;
    }
    
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return;
    }
    
    vehicle = self getlinkedparent();
    
    if ( vehicle utility::ent_flag( "repair_recalibrating" ) )
    {
        return;
    }
    
    if ( isdefined( level.var_8672fa96c3fb69e0 ) )
    {
        cost = 0;
    }
    else
    {
        cost = function_7ad65cdd5ea7fd48( vehicle );
    }
    
    if ( !player currency::can_afford( #"salvage", cost ) )
    {
        return;
    }
    
    self.b_in_use = 1;
    level utility::flag_set( "salvage_repair_pluto" );
    
    if ( !isdefined( vehicle.var_16f0491f9a5695ff ) )
    {
        vehicle.var_24544fc71ca1e2d5 = gettime();
    }
    else if ( vehicle.var_e2c27eded7998a2c + 5000 < gettime() )
    {
        vehicle.var_24544fc71ca1e2d5 = gettime();
    }
    
    player function_828b6aa15ecfe6f4();
    
    if ( utility::issharedfuncdefined( #"veh_pluto", #"hash_854918a7b5761a6a" ) )
    {
        data = vehicle::get_data( %"hash_62a07b56f29782f5" );
        repair_time = getdvarint( @"firefly_pluto_repair_time" );
        
        if ( !repair_time )
        {
            repair_time = data.wondervehicle.salvage_repair_time;
        }
        
        if ( player zombie_perks::has_perk( "specialty_speedcola" ) )
        {
            repair_time = getdvarint( @"hash_29812b097ceae62" );
            
            if ( !repair_time )
            {
                repair_time = 4;
            }
        }
        
        result = level utility::callsharedfunc( #"veh_pluto", #"hash_854918a7b5761a6a", player, &"zm_sat_firefly/pluto_r_caption", undefined, self, repair_time );
    }
    else
    {
        assertmsg( "<dev string:x24>" );
    }
    
    level utility::flag_clear( "salvage_repair_pluto" );
    vehicle.var_e2c27eded7998a2c = gettime();
    
    if ( player )
    {
        player val::reset_all( "repairing_pluto" );
    }
    
    if ( result )
    {
        if ( player )
        {
            player currency::attempt_purchase( #"salvage", cost, 0 );
        }
        
        vehicle thread utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_b36e6bbfc02771b7" );
        level function_270cc051f221c8c2( vehicle );
        vehicle.var_7c4f9d84d82ba65a = vehicle.origin;
        vehicle.var_861deff9d09b7d98 = 1;
    }
    
    wait 0.25;
    self.b_in_use = 0;
    self enableplayeruseforallplayers();
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x98b654b2, Offset: 0x6f2
// Size: 0xdc
function private function_7ad65cdd5ea7fd48( vehicle )
{
    data = vehicle::get_data( %"hash_62a07b56f29782f5" );
    
    switch ( vehicle.var_7493baa2cd62443 )
    {
        case 2:
            cost = data.wondervehicle.var_ef1da589fb4012eb;
            break;
        case 3:
            cost = data.wondervehicle.var_ef1da489fb4010b8;
            break;
        case 4:
            cost = data.wondervehicle.var_ef1dab89fb40201d;
            break;
        default:
            cost = data.wondervehicle.var_ef1da689fb40151e;
            break;
    }
    
    return cost;
}

// Namespace pluto_veh
// Params 2
// Checksum 0x5b36a87c, Offset: 0x7d7
// Size: 0xbf
function function_270cc051f221c8c2( vehicle, b_play_fx = 1 )
{
    vehicle endon( #"death" );
    level endon( #"game_ended" );
    vehicle utility::ent_flag_wait( "pluto_repair_init" );
    vehicle vehicle_damage::set_health( vehicle.maxhealth );
    
    if ( b_play_fx )
    {
        vehicle utility::function_7c10ea82c1e305b8( "upgrades", "healthrestore" );
    }
    
    if ( vehicle.var_7493baa2cd62443 >= 1 )
    {
        set_vehicle_usable_state( vehicle, 1, 1 );
    }
    
    vehicle.repairinteract setusableenabled( 0 );
    setdvar( @"firefly_pluto_repair", 0 );
    vehicle.var_f9f14016a8fd3e1d = gettime();
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x6e9742c0, Offset: 0x89e
// Size: 0x14
function private function_828b6aa15ecfe6f4()
{
    val::set( "repairing_pluto", "killstreaks", 0 );
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xff456ecc, Offset: 0x8ba
// Size: 0x14d
function private function_c9702dbf624da16()
{
    vehicle = self;
    vehicle endon( #"death" );
    vehicle.var_8789c2b2203e37fb = getdvarint( @"hash_6a2220e497e2e651", 175 );
    vehicle.repairinteract = interaction::register_interact( vehicle.origin, vehicle.var_8789c2b2203e37fb, &function_340a88abd3667afa, &function_85571d0c8e940a73 );
    vehicle.repairinteract linkto( self );
    vehicle utility::ent_flag_set( "pluto_repair_init" );
    
    while ( true )
    {
        waitframe();
        
        if ( !vehicle function_d5ded137742206c3() )
        {
            self.var_40eed1312db06ecd = 0;
            
            if ( vehicle.repairinteract function_45c212dce7227aa7() )
            {
                vehicle.repairinteract setusableenabled( 0 );
                vehicle.var_a127b52bcd39f5cf = 0;
            }
            
            continue;
        }
        
        if ( !vehicle.repairinteract function_45c212dce7227aa7() )
        {
            vehicle.repairinteract setusableenabled( 1 );
            vehicle.repairinteract sethintonobstruction( "show" );
            vehicle.repairinteract enableplayeruseforallplayers();
            vehicle thread function_20c8cb5a4005ed64();
            continue;
        }
        
        if ( getdvarint( @"firefly_pluto_repair" ) == 1 )
        {
            level function_270cc051f221c8c2( vehicle );
        }
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x906509cc, Offset: 0xa0f
// Size: 0x16a
function private function_20c8cb5a4005ed64()
{
    if ( level utility::flag( "disable_pluto_repair_delay" ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !self.var_2222717d5be53acb )
    {
        self.var_2222717d5be53acb = 0;
    }
    
    prev_time = self.var_2222717d5be53acb;
    curr_time = gettime();
    
    if ( !self.var_6eda166c2a14951a )
    {
        self.var_6eda166c2a14951a = 0;
    }
    
    reset_time = getdvarint( @"hash_35ce93feb5b3e8d2" );
    
    if ( !reset_time )
    {
        reset_time = 60;
    }
    
    if ( level utility::flag( "disable_pluto_repair_delay" ) )
    {
        stack_time = 0;
    }
    else
    {
        stack_time = getdvarint( @"hash_297bc858a9f54d76" );
        
        if ( !stack_time )
        {
            stack_time = 3;
        }
    }
    
    if ( curr_time - prev_time < utility::function_4b74c15943231980( reset_time ) )
    {
        self.var_6eda166c2a14951a++;
        recalibration_time = self.var_6eda166c2a14951a * stack_time;
        recalibration_time = min( recalibration_time, 30 );
    }
    else
    {
        self.var_6eda166c2a14951a = 1;
        recalibration_time = stack_time;
    }
    
    self.var_2222717d5be53acb = curr_time;
    utility::ent_flag_set( "repair_recalibrating" );
    self setscriptablepartstate( "recalibration_vfx", "on" );
    function_8c8992d5068c36b5( recalibration_time );
    self setscriptablepartstate( "recalibration_vfx", "off" );
    utility::ent_flag_clear( "repair_recalibrating" );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xa16cc465, Offset: 0xb81
// Size: 0x53
function private function_8c8992d5068c36b5( recalibration_time )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    for ( time_left = recalibration_time; true ; time_left-- )
    {
        if ( time_left <= 0 )
        {
            return;
        }
        
        self.var_438dff673ff312b4 = time_left;
        wait 1;
    }
}

