// scripts\mp\ob\ob_skill_selection.gsc  (hash_0fe32a18529ed440.gscc) (size: 1922 Bytes / 0x782 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa727f14 (175275796)
// size ...... 1922 (0x782)
// includes .. 2   (offset: 0x65a)
// strings ... 20  (offset: 0x66a)
// dev strs .. 1   (offset: 0x776)
// exports ... 5   (offset: 0x43a)
// cseg ...... 0x1c5 + 0x275 (0x43a)
// imports ... 12  (offset: 0x502)
// animtree1 . 0   (offset: 0x782)
// animtree2 . 0   (offset: 0x782)
#using scripts\common\scripted_widgets;
#using scripts\common\utility;

#namespace ob_skill_selection;

// Namespace ob_skill_selection
// Params 0
// Checksum 0x491fddc8, Offset: 0x1e3
// Size: 0xd
function ob_skill_selection_is_active()
{
    return scripted_widgets::is_active( "ob_skill_selection" );
}

// Namespace ob_skill_selection
// Params 0
// Checksum 0x1526cf42, Offset: 0x1f9
// Size: 0x39
function open_ob_skill_selection()
{
    assert( !ob_skill_selection_is_active(), "<dev string:x24>" );
    
    if ( ob_skill_selection_is_active() )
    {
        return;
    }
    
    scripted_widgets::create( "ob_skill_selection", scripted_widgets::function_652736891a41e948( "scripted_widget_skill_selection" ) );
    return 1;
}

// Namespace ob_skill_selection
// Params 0
// Checksum 0xb9c5450e, Offset: 0x23b
// Size: 0x17
function close_ob_skill_selection()
{
    if ( ob_skill_selection_is_active() )
    {
        scripted_widgets::destroy( "ob_skill_selection" );
    }
}

// Namespace ob_skill_selection
// Params 3
// Checksum 0x351f98e6, Offset: 0x25a
// Size: 0x1df
function function_d9353542f9f53014( var_7b955ef638656ecb, var_cb18fbca207f8bda, var_f06bf262e0bdbfb1 )
{
    self endon( #"disconnect" );
    fields = [];
    fields[ "skill_count" ] = var_7b955ef638656ecb.size;
    fields[ "header_string" ] = var_cb18fbca207f8bda;
    fields[ "is_replace_mode" ] = var_f06bf262e0bdbfb1 ? 1 : 0;
    fields[ "skills" ] = [];
    
    for ( tileindex = 0; tileindex < var_7b955ef638656ecb.size ; tileindex++ )
    {
        tilefields = [ "description":var_7b955ef638656ecb[ tileindex ].description, "is_replaceable":var_7b955ef638656ecb[ tileindex ].is_replaceable, "is_upgrade":var_7b955ef638656ecb[ tileindex ].is_upgrade, "is_equipped":var_7b955ef638656ecb[ tileindex ].is_equipped, "skill_asset_index":var_7b955ef638656ecb[ tileindex ].asset ];
        
        if ( isdefined( var_7b955ef638656ecb[ tileindex ].skill_level ) )
        {
            tilefields[ "skill_level" ] = var_7b955ef638656ecb[ tileindex ].skill_level;
        }
        
        fields[ "skills" ][ tileindex ] = tilefields;
    }
    
    open_ob_skill_selection();
    scripted_widgets::function_dd7a63eea5bde0dc( "ob_skill_selection", fields );
    result = utility::waittill_any_return_params( "skill_select_chosen", "skill_replace_chosen", "skill_select_close", "allow_reward_select", "last_stand_enter", "death", "entitydeleted" );
    close_ob_skill_selection();
    
    if ( result[ "message" ] == "skill_replace_chosen" )
    {
        payloadarray = result[ 0 ];
        
        if ( isarray( payloadarray ) && payloadarray.size > 0 )
        {
            self.swappingskill = payloadarray[ 0 ];
        }
        
        return 0;
    }
    
    if ( result[ "message" ] == "skill_select_chosen" )
    {
        payloadarray = result[ 0 ];
        
        if ( isarray( payloadarray ) && payloadarray.size > 0 )
        {
            return payloadarray[ 0 ];
        }
        
        return 0;
    }
    
    return -1;
}

