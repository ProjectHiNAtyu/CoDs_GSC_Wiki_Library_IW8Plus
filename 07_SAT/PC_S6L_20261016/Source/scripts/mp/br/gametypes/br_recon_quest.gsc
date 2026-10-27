// scripts\mp\br\gametypes\br_recon_quest.gsc  (hash_74530594ba110aa8.gscc) (size: 32839 Bytes / 0x8047 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xed2deb57 (3979209559)
// size ...... 32839 (0x8047)
// includes .. 20  (offset: 0x7a17)
// strings ... 80  (offset: 0x7ab7)
// dev strs .. 8   (offset: 0x7fdb)
// exports ... 55  (offset: 0x57e7)
// cseg ...... 0x652 + 0x5195 (0x57e7)
// imports ... 199 (offset: 0x607f)
// animtree1 . 0   (offset: 0x8047)
// animtree2 . 0   (offset: 0x8047)
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\gameobjects;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;
#using scripts\mp\poi;

#namespace br_recon_quest;

// Namespace br_recon_quest
// Params 0, eflags: 0x1
// Checksum 0xdffd0f6f, Offset: 0x670
// Size: 0x3e
function autoexec main()
{
    utility::registersharedfunc( #"recon", #"get_contract_data", &getcontractdata );
    utility::registersharedfunc( #"train_recon", #"get_contract_data", &getcontractdata );
}

// Namespace br_recon_quest
// Params 1
// Checksum 0x850bc644, Offset: 0x6b6
// Size: 0x8e1
function getcontractdata( data )
{
    questmodifier = undefined;
    
    if ( data.ref == "train_recon" )
    {
        if ( !br_public::function_9dc52a7da56f6544() )
        {
            data.enabled = 0;
            return;
        }
        
        questmodifier = "train";
    }
    
    if ( getdvarint( @"hash_6ceff8d43b403245", 0 ) )
    {
        data.enabled = 0;
        return;
    }
    
    if ( !isdefined( level.var_9afa651d49da1c92 ) && !isdefined( questmodifier ) )
    {
        level.var_9afa651d49da1c92 = spawnstruct();
        var_47b2c991ea1286f0 = getdvarint( @"hash_949aadc2a390119d", 0 );
        level.var_9afa651d49da1c92.questmaxtime = var_47b2c991ea1286f0 != 0 ? var_47b2c991ea1286f0 : br_contract_manager::function_4bc46e9c9bb0d265( "recon" );
        level.var_9afa651d49da1c92.var_622f369897cf579d = 0;
        function_d4705e17aa0f7845( data );
        level.var_9afa651d49da1c92.var_6634648543763933 = getquestpoints( 7, ( 0, 0, 0 ), 999999, 0, 1 );
        
        if ( getdvarint( @"hash_8a684d1617b2dac9", 1 ) )
        {
            var_3b4d11cdb547c1b6 = spawn( "noent_volume_trigger_box", ( 19232, -14872, 32 ), 0, ( 3736, 1496, 1064 ), ( 2952, 3392, 32 ) );
            var_3b4d11cdb547c1b6.angles = ( 0, 270, 0 );
            
            foreach ( domnode in level.var_9afa651d49da1c92.var_6634648543763933 )
            {
                if ( ispointinvolume( domnode.origin, var_3b4d11cdb547c1b6 ) )
                {
                    level.var_9afa651d49da1c92.var_6634648543763933 = arrayremove( level.var_9afa651d49da1c92.var_6634648543763933, domnode );
                }
            }
            
            var_3b4d11cdb547c1b6 delete();
        }
        
        level.var_9afa651d49da1c92.var_6634648543763933 = arrayrandomize( level.var_9afa651d49da1c92.var_6634648543763933 );
        level.var_9afa651d49da1c92.obj_icon = "ui_map_icon_obj_recon";
        
        /#
            if ( level.mapname == "<dev string:x24>" && getdvarint( @"hash_b5cac67352178a82", 0 ) )
            {
                var_1640e5063393ef6 = [];
                
                for ( i = 0; i < 3 ; i++ )
                {
                    tempnode = spawnstruct();
                    tempnode.angles = ( 0, 0, 0 );
                    tempnode.origin = ( 570 - i * 300, 705, -512 );
                    
                    switch ( i )
                    {
                        case 0:
                            tempnode.spawnflags = 2;
                            break;
                        case 1:
                            tempnode.spawnflags = 1;
                            break;
                        case 2:
                        default:
                            tempnode.spawnflags = 4;
                            break;
                    }
                    
                    var_1640e5063393ef6[ var_1640e5063393ef6.size ] = tempnode;
                }
                
                scriptable::scriptable_addusedcallbackbypart( level.var_9afa651d49da1c92.var_1dd64dad26e1aaa0, &function_71e0f906d0888a2d );
                scriptable::scriptable_addusedcallbackbypart( level.var_9afa651d49da1c92.var_688056a04690dbd4, &function_71e0f906d0888a2d );
                scriptable::scriptable_addusedcallbackbypart( level.var_9afa651d49da1c92.var_3bdb39f20a8345c, &function_71e0f906d0888a2d );
                thread function_17056c89d1532264( var_1640e5063393ef6 );
                return;
            }
        #/
        
        callback::add( "area_swap_begin", &function_d3f28f7cfcfbf9 );
        scriptable::scriptable_addusedcallbackbypart( level.var_9afa651d49da1c92.var_1dd64dad26e1aaa0, &function_4cf1fce206ba178d );
        scriptable::scriptable_addusedcallbackbypart( level.var_9afa651d49da1c92.var_688056a04690dbd4, &function_4cf1fce206ba178d );
        scriptable::scriptable_addusedcallbackbypart( level.var_9afa651d49da1c92.var_3bdb39f20a8345c, &function_4cf1fce206ba178d );
        assert( isdefined( game[ "<dev string:x35>" ] ) );
        game[ "dialog" ][ "mission_recon_success" ] = "rcsc_wzan_rscc";
        game[ "dialog" ][ "mission_recon_success_plunder" ] = "rcsc_wzan_rcsc";
        game[ "dialog" ][ "mission_recon_start" ] = "rcst_wzan_rscp";
        game[ "dialog" ][ "mission_recon_start_plunder" ] = "rcst_wzan_rcst";
        game[ "dialog" ][ "mission_recon_start_train" ] = "rcst_wzan_rstr";
        game[ "dialog" ][ "mission_recon_time_expired" ] = "rcte_wzan_rcte";
        game[ "dialog" ][ "mission_recon_start_capture" ] = "rccs_wzan_rccs";
        game[ "dialog" ][ "mission_recon_start_capture_first_person" ] = "rccs_wzan_rcsp";
        data.basetime = level.var_9afa651d49da1c92.questmaxtime;
        data.funcs[ "onInit" ] = &quest_oninit;
        data.funcs[ "onShowAgain" ] = &quest_onshowagain;
        data.funcs[ "onTeamAssigned" ] = &quest_onteamassigned;
        data.funcs[ "onEnterGulag" ] = &quest_onentergulag;
        data.funcs[ "onPlayerRespawn" ] = &quest_onrespawn;
        data.funcs[ "onPlayerKilled" ] = &quest_onplayerkilled;
        data.funcs[ "onMarkPlayerAsEliminated" ] = &function_22116566150b5d1;
        data.funcs[ "onPlayerDisconnect" ] = &quest_onplayerdisconnect;
        data.funcs[ "onCancel" ] = &quest_oncancel;
        data.funcs[ "onPlayerTearDown" ] = &quest_onplayerteardown;
        data.funcs[ "onPlayerAssimilated" ] = &quest_onplayerassimilated;
        data.funcs[ "circleTick" ] = &function_70034271e970d006;
        data.funcs[ "onTimerExpired" ] = &function_88679453542a90b3;
        data.funcs[ "onFinishContract" ] = &function_1be7c59a593161bc;
        data.funcs[ "onCircleRelocation" ] = &function_67b529e129462fe2;
        
        /#
            if ( getdvarint( @"hash_17275ec2e0515d12", 0 ) )
            {
                level thread function_70ef765b4625d0e8();
            }
        #/
    }
    
    if ( questmodifier == "train" )
    {
        level.var_e8ffdc2a1fa14c1f = spawnstruct();
        function_dd587f855eb4eb6a();
        var_47b2c991ea1286f0 = getdvarint( @"hash_7ae7825160287726", 0 );
        level.var_e8ffdc2a1fa14c1f.questmaxtime = var_47b2c991ea1286f0 != 0 ? var_47b2c991ea1286f0 : br_contract_manager::function_4bc46e9c9bb0d265( "train_recon" );
        level.var_e8ffdc2a1fa14c1f.var_622f369897cf579d = 0;
        function_8649f5e28e42cc8f( data );
        data.basetime = level.var_e8ffdc2a1fa14c1f.questmaxtime;
        scriptable::scriptable_addusedcallbackbypart( level.var_e8ffdc2a1fa14c1f.var_1dd64dad26e1aaa0, &function_cabb0eefef6c7fb7 );
        data.funcs[ "onInit" ] = &trainquest_oninit;
        data.funcs[ "onShowAgain" ] = &quest_onshowagain;
        data.funcs[ "onTeamAssigned" ] = &function_24376242565d6a97;
        data.funcs[ "onEnterGulag" ] = &quest_onentergulag;
        data.funcs[ "onPlayerRespawn" ] = &quest_onrespawn;
        data.funcs[ "onPlayerKilled" ] = &quest_onplayerkilled;
        data.funcs[ "onMarkPlayerAsEliminated" ] = &function_22116566150b5d1;
        data.funcs[ "onPlayerDisconnect" ] = &quest_onplayerdisconnect;
        data.funcs[ "onCancel" ] = &quest_oncancel;
        data.funcs[ "onPlayerTearDown" ] = &quest_onplayerteardown;
        data.funcs[ "onPlayerAssimilated" ] = &quest_onplayerassimilated;
        data.funcs[ "circleTick" ] = &function_70034271e970d006;
        data.funcs[ "onTimerExpired" ] = &function_88679453542a90b3;
        data.funcs[ "onFinishContract" ] = &function_1be7c59a593161bc;
        data.funcs[ "onCircleRelocation" ] = &function_67b529e129462fe2;
    }
    
    if ( utility::issharedfuncdefined( #"br_recon_quest", #"hash_933c51916ab834a1" ) )
    {
        return utility::callsharedfunc( #"br_recon_quest", #"hash_933c51916ab834a1", data );
    }
}

// Namespace br_recon_quest
// Params 1, eflags: 0x4
// Checksum 0x410712eb, Offset: 0xf9f
// Size: 0x8a6
function private function_d4705e17aa0f7845( data )
{
    if ( data.var_3e66e51a241b9989.variant_object.contracttype == "Recon" )
    {
        level.var_9afa651d49da1c92.domcapturetime = getdvarint( @"hash_b5bac9fc298cb78b", data.var_3e66e51a241b9989.variant_object.domcapturetime );
        level.var_9afa651d49da1c92.dommaxdist = getdvarint( @"hash_a0097e0d7d2389c0", data.var_3e66e51a241b9989.variant_object.dommaxdist );
        level.var_9afa651d49da1c92.var_37b666113634a0b1 = getdvarint( @"hash_b425705102660c08", data.var_3e66e51a241b9989.variant_object.var_37b666113634a0b1 );
        level.var_9afa651d49da1c92.var_319f12ba84882793 = getdvarint( @"hash_9df2cc108ff9486", data.var_3e66e51a241b9989.variant_object.var_319f12ba84882793 );
        level.var_9afa651d49da1c92.var_540b35ff024488bc = getdvarfloat( @"hash_29393294d675f498", data.var_3e66e51a241b9989.variant_object.var_540b35ff024488bc );
        level.var_9afa651d49da1c92.time_remaining_text = data.var_3e66e51a241b9989.variant_object.timeremainingtext;
        level.var_9afa651d49da1c92.var_db8fa5e4c99f3f44 = getdvar( @"hash_e3f4b8e75d7c970e", data.var_3e66e51a241b9989.variant_object.var_131e1fc1047155f4 );
        level.var_9afa651d49da1c92.var_f9734dc6201d0dcb = data.var_3e66e51a241b9989.variant_object.var_13b0ba523cf008e1;
        level.var_9afa651d49da1c92.var_1dd64dad26e1aaa0 = getdvar( @"hash_8d4da035a201ac9e", data.var_3e66e51a241b9989.variant_object.var_b22511e5f0071904 );
        level.var_9afa651d49da1c92.var_688056a04690dbd4 = getdvar( @"hash_fbfc89e5620bce52", data.var_3e66e51a241b9989.variant_object.var_3f006504f6c5c44b );
        level.var_9afa651d49da1c92.var_3bdb39f20a8345c = getdvar( @"hash_94f36a9020640e6e", data.var_3e66e51a241b9989.variant_object.var_7b40e42669344853 );
        level.var_9afa651d49da1c92.var_3107e2b46be1f0e2 = getdvarint( @"hash_d542620786c1c7e0", data.var_3e66e51a241b9989.variant_object.var_107d056da158ac5b );
        level.var_9afa651d49da1c92.var_79c4131c76a2b23e = data.var_3e66e51a241b9989.variant_object.var_c2d6cf6bc556647a;
        level.var_9afa651d49da1c92.var_51704ad3d151a5ed = getdvarfloat( @"hash_833dbca13eb09a5", data.var_3e66e51a241b9989.variant_object.var_51704ad3d151a5ed );
        level.var_9afa651d49da1c92.dompointtriggerheight = getdvarint( @"hash_a11f448e2de29dc3", data.var_3e66e51a241b9989.variant_object.var_1e35088397af1053 );
        level.var_9afa651d49da1c92.var_eeccb0f33daf68f2 = getdvarfloat( @"hash_833dbca13eb09a5", data.var_3e66e51a241b9989.variant_object.var_eeccb0f33daf68f2 );
        level.var_9afa651d49da1c92.questdroploot = getdvarint( @"hash_d8cc20c27118e09", data.var_3e66e51a241b9989.variant_object.questdroploot );
        level.var_9afa651d49da1c92.var_6e9874e04cc8925d = getdvarint( @"hash_259923859f203526", data.var_3e66e51a241b9989.variant_object.var_6e9874e04cc8925d );
        level.var_9afa651d49da1c92.usevfx = getdvarint( @"hash_e9f92666306b7484", data.var_3e66e51a241b9989.variant_object.var_67535682825ef252 );
        level.var_9afa651d49da1c92.delete_delay = getdvarfloat( @"hash_ee90500dfcf6654a", data.var_3e66e51a241b9989.variant_object.var_23a84a7cab980335 );
        level.var_9afa651d49da1c92.vfx_delay = getdvarfloat( @"hash_89e5fcf132d30d70", data.var_3e66e51a241b9989.variant_object.var_5e24bc775a2a8c7a );
        level.var_9afa651d49da1c92.var_52b1175552196a04 = getdvarint( @"hash_ed28593639a1ec3a", data.var_3e66e51a241b9989.variant_object.var_c49e2e658305b134 );
        return;
    }
    
    level.var_9afa651d49da1c92.domcapturetime = getdvarint( @"hash_b5bac9fc298cb78b", 30 );
    level.var_9afa651d49da1c92.dommaxdist = getdvarint( @"hash_a0097e0d7d2389c0", 12000 );
    level.var_9afa651d49da1c92.var_37b666113634a0b1 = getdvarint( @"hash_b425705102660c08", 6000 );
    level.var_9afa651d49da1c92.var_319f12ba84882793 = getdvarint( @"hash_9df2cc108ff9486", 8000 );
    level.var_9afa651d49da1c92.var_540b35ff024488bc = getdvarfloat( @"hash_29393294d675f498", 30 );
    level.var_9afa651d49da1c92.time_remaining_text = &"dmz/upload_station_progress";
    level.var_9afa651d49da1c92.var_db8fa5e4c99f3f44 = getdvar( @"hash_e3f4b8e75d7c970e", "br_quest_recon" );
    level.var_9afa651d49da1c92.var_f9734dc6201d0dcb = &"mp_br_ingame/contract_recon_secure";
    level.var_9afa651d49da1c92.var_1dd64dad26e1aaa0 = getdvar( @"hash_8d4da035a201ac9e", "br_dom_point" );
    level.var_9afa651d49da1c92.var_688056a04690dbd4 = getdvar( @"hash_fbfc89e5620bce52", "br_dom_point_small" );
    level.var_9afa651d49da1c92.var_3bdb39f20a8345c = getdvar( @"hash_94f36a9020640e6e", "br_dom_point_large" );
    level.var_9afa651d49da1c92.var_3107e2b46be1f0e2 = getdvarint( @"hash_d542620786c1c7e0", 0 );
    level.var_9afa651d49da1c92.var_79c4131c76a2b23e = getdvar( @"hash_81134234f04af164", "ks_gesture_walkie_wz" );
    level.var_9afa651d49da1c92.var_51704ad3d151a5ed = getdvarfloat( @"hash_833dbca13eb09a5", 1 );
    level.var_9afa651d49da1c92.dompointtriggerheight = getdvarint( @"hash_a11f448e2de29dc3", 80 );
    level.var_9afa651d49da1c92.var_eeccb0f33daf68f2 = getdvarfloat( @"hash_833dbca13eb09a5", 0.45 );
    level.var_9afa651d49da1c92.questdroploot = getdvarint( @"hash_d8cc20c27118e09", 1 );
    level.var_9afa651d49da1c92.var_6e9874e04cc8925d = getdvarint( @"hash_259923859f203526", 1 );
    level.var_9afa651d49da1c92.usevfx = getdvarint( @"hash_e9f92666306b7484", 1 );
    level.var_9afa651d49da1c92.delete_delay = getdvarfloat( @"hash_ee90500dfcf6654a", 1.5 );
    level.var_9afa651d49da1c92.vfx_delay = getdvarfloat( @"hash_89e5fcf132d30d70", 1.4 );
    level.var_9afa651d49da1c92.var_52b1175552196a04 = getdvarint( @"hash_ed28593639a1ec3a", 1 );
}

// Namespace br_recon_quest
// Params 1, eflags: 0x4
// Checksum 0x75d3808, Offset: 0x184d
// Size: 0x6ab
function private function_8649f5e28e42cc8f( data )
{
    if ( data.var_3e66e51a241b9989.variant_object.contracttype == "TrainRecon" )
    {
        level.var_e8ffdc2a1fa14c1f.domcapturetime = getdvarint( @"hash_3488b88e021476ec", data.var_3e66e51a241b9989.variant_object.domcapturetime );
        level.var_e8ffdc2a1fa14c1f.time_remaining_text = data.var_3e66e51a241b9989.variant_object.timeremainingtext;
        level.var_e8ffdc2a1fa14c1f.var_db8fa5e4c99f3f44 = getdvar( @"hash_7cbd614c9d7a8221", data.var_3e66e51a241b9989.variant_object.var_131e1fc1047155f4 );
        level.var_e8ffdc2a1fa14c1f.var_f9734dc6201d0dcb = data.var_3e66e51a241b9989.variant_object.var_13b0ba523cf008e1;
        level.var_e8ffdc2a1fa14c1f.var_1dd64dad26e1aaa0 = getdvar( @"hash_f4d395dc9bd12be9", data.var_3e66e51a241b9989.variant_object.var_b22511e5f0071904 );
        level.var_e8ffdc2a1fa14c1f.var_3107e2b46be1f0e2 = getdvarint( @"hash_380c11ae09fdd8a9", data.var_3e66e51a241b9989.variant_object.var_107d056da158ac5b );
        level.var_e8ffdc2a1fa14c1f.var_79c4131c76a2b23e = data.var_3e66e51a241b9989.variant_object.var_c2d6cf6bc556647a;
        level.var_e8ffdc2a1fa14c1f.var_51704ad3d151a5ed = getdvarfloat( @"hash_d499973a313907b2", data.var_3e66e51a241b9989.variant_object.var_51704ad3d151a5ed );
        level.var_e8ffdc2a1fa14c1f.dompointtriggerheight = getdvarint( @"hash_b76701fec63e5430", data.var_3e66e51a241b9989.variant_object.var_1e35088397af1053 );
        level.var_e8ffdc2a1fa14c1f.var_eeccb0f33daf68f2 = getdvarfloat( @"hash_d499973a313907b2", data.var_3e66e51a241b9989.variant_object.var_eeccb0f33daf68f2 );
        level.var_e8ffdc2a1fa14c1f.questdroploot = getdvarint( @"hash_2682b3dfbabb5204", data.var_3e66e51a241b9989.variant_object.questdroploot );
        level.var_e8ffdc2a1fa14c1f.var_6e9874e04cc8925d = getdvarint( @"hash_8efbfdedea914559", data.var_3e66e51a241b9989.variant_object.var_6e9874e04cc8925d );
        level.var_e8ffdc2a1fa14c1f.usevfx = getdvarint( @"hash_10b4b050c4ffee65", data.var_3e66e51a241b9989.variant_object.var_67535682825ef252 );
        level.var_e8ffdc2a1fa14c1f.delete_delay = getdvarfloat( @"hash_1626d12266c6464b", data.var_3e66e51a241b9989.variant_object.var_23a84a7cab980335 );
        level.var_e8ffdc2a1fa14c1f.vfx_delay = getdvarfloat( @"hash_44484fd714ed8d85", data.var_3e66e51a241b9989.variant_object.var_5e24bc775a2a8c7a );
        level.var_e8ffdc2a1fa14c1f.var_52b1175552196a04 = getdvarint( @"hash_3e1a95387dc9f665", data.var_3e66e51a241b9989.variant_object.var_c49e2e658305b134 );
        level.var_e8ffdc2a1fa14c1f.tablet_respawn_delay = getdvarint( @"hash_54c901ec9ce00a38", data.var_3e66e51a241b9989.variant_object.tablet_respawn_delay );
        return;
    }
    
    level.var_e8ffdc2a1fa14c1f.domcapturetime = getdvarint( @"hash_3488b88e021476ec", 30 );
    level.var_e8ffdc2a1fa14c1f.time_remaining_text = &"dmz/upload_station_progress";
    level.var_e8ffdc2a1fa14c1f.var_db8fa5e4c99f3f44 = getdvar( @"hash_7cbd614c9d7a8221", "br_quest_recon" );
    level.var_e8ffdc2a1fa14c1f.var_f9734dc6201d0dcb = &"mp_br_ingame/contract_recon_secure";
    level.var_e8ffdc2a1fa14c1f.var_1dd64dad26e1aaa0 = getdvar( @"hash_f4d395dc9bd12be9", "br_dom_point_train" );
    level.var_e8ffdc2a1fa14c1f.var_3107e2b46be1f0e2 = getdvarint( @"hash_380c11ae09fdd8a9", 0 );
    level.var_e8ffdc2a1fa14c1f.var_79c4131c76a2b23e = getdvar( @"hash_a20253e7fdaa8745", "ks_gesture_walkie_wz" );
    level.var_e8ffdc2a1fa14c1f.var_51704ad3d151a5ed = getdvarfloat( @"hash_d499973a313907b2", 1 );
    level.var_e8ffdc2a1fa14c1f.dompointtriggerheight = getdvarint( @"hash_b76701fec63e5430", 80 );
    level.var_e8ffdc2a1fa14c1f.var_eeccb0f33daf68f2 = getdvarfloat( @"hash_d499973a313907b2", 0.45 );
    level.var_e8ffdc2a1fa14c1f.questdroploot = getdvarint( @"hash_2682b3dfbabb5204", 1 );
    level.var_e8ffdc2a1fa14c1f.var_6e9874e04cc8925d = getdvarint( @"hash_8efbfdedea914559", 1 );
    level.var_e8ffdc2a1fa14c1f.usevfx = getdvarint( @"hash_10b4b050c4ffee65", 1 );
    level.var_e8ffdc2a1fa14c1f.delete_delay = getdvarfloat( @"hash_1626d12266c6464b", 1.5 );
    level.var_e8ffdc2a1fa14c1f.vfx_delay = getdvarfloat( @"hash_44484fd714ed8d85", 1.4 );
    level.var_e8ffdc2a1fa14c1f.var_52b1175552196a04 = getdvarint( @"hash_3e1a95387dc9f665", 1 );
    level.var_e8ffdc2a1fa14c1f.tablet_respawn_delay = getdvarint( @"hash_54c901ec9ce00a38", 60 );
}

// Namespace br_recon_quest
// Params 0
// Checksum 0x64d90234, Offset: 0x1f00
// Size: 0x240
function function_dd587f855eb4eb6a()
{
    if ( !isdefined( level.wztrain_info ) )
    {
        return;
    }
    
    if ( !isdefined( level.wztrain_info.dom_cars ) )
    {
        level.wztrain_info.dom_cars = [];
    }
    
    car_array = level.wztrain_info.trains[ "cargo_train" ];
    
    if ( !isdefined( car_array ) )
    {
        return;
    }
    
    if ( isdefined( car_array[ 1 ] ) )
    {
        domnode = spawnstruct();
        domnode.origin = ( -135, -50, 49 );
        domnode.angles = ( 0, 80, 0 );
        domnode.spawnflags = 2;
        car_array[ 1 ].var_b25418214626adee = domnode;
        level.wztrain_info.dom_cars[ level.wztrain_info.dom_cars.size ] = car_array[ 1 ];
    }
    
    if ( isdefined( car_array[ 5 ] ) )
    {
        domnode = spawnstruct();
        domnode.origin = ( 70, 40, 49 );
        domnode.angles = ( 0, -125, 0 );
        domnode.spawnflags = 2;
        car_array[ 5 ].var_b25418214626adee = domnode;
        level.wztrain_info.dom_cars[ level.wztrain_info.dom_cars.size ] = car_array[ 5 ];
    }
    
    if ( isdefined( car_array[ 7 ] ) )
    {
        domnode = spawnstruct();
        domnode.origin = ( -150, 45, 49 );
        domnode.angles = ( 0, 225, 0 );
        domnode.spawnflags = 2;
        car_array[ 7 ].var_b25418214626adee = domnode;
        level.wztrain_info.dom_cars[ level.wztrain_info.dom_cars.size ] = car_array[ 7 ];
    }
    
    level.wztrain_info.dom_cars = arrayrandomize( level.wztrain_info.dom_cars );
}

// Namespace br_recon_quest
// Params 0
// Checksum 0xe6bd322f, Offset: 0x2148
// Size: 0x9b
function quest_oninit()
{
    if ( utility::issharedfuncdefined( #"br_recon_quest", #"init" ) )
    {
        return utility::callsharedfunc( #"br_recon_quest", #"init" );
    }
    
    self.var_b25418214626adee = function_8aabe8488ceb5c2f( self.tablet.origin, level.var_9afa651d49da1c92, level.var_9afa651d49da1c92.var_6634648543763933 );
    
    if ( !isdefined( self.var_b25418214626adee ) )
    {
        return 0;
    }
    
    self.var_b25418214626adee.task = self;
    return 1;
}

// Namespace br_recon_quest
// Params 0
// Checksum 0x12e64da7, Offset: 0x21ec
// Size: 0x80, Type: bool
function trainquest_oninit()
{
    traincar = level.wztrain_info.dom_cars[ randomint( level.wztrain_info.dom_cars.size ) ];
    self.traincar = traincar;
    self.var_b25418214626adee = traincar.var_b25418214626adee;
    
    if ( !isdefined( self.var_b25418214626adee ) )
    {
        return false;
    }
    
    self.var_b25418214626adee.task = self;
    return true;
}

// Namespace br_recon_quest
// Params 0
// Checksum 0x9ce6568e, Offset: 0x2275
// Size: 0x3, Type: bool
function quest_onshowagain()
{
    return false;
}

// Namespace br_recon_quest
// Params 0
// Checksum 0x8e4456cb, Offset: 0x2281
// Size: 0xd9
function quest_onteamassigned()
{
    self.category = "recon";
    time = level.var_9afa651d49da1c92.questmaxtime;
    br_contract_manager::function_87e10a6e85d45d58( "recon" );
    time = br_contract_manager::function_2f14979bf83bc3db( time );
    br_contract_manager::function_3fbbc67df36be7bb( time );
    recon_start( self.var_fe0156f1cf4e5f41 );
    players = br_contract_manager::function_85e5094486ad4b57();
    
    if ( game_utility::getgametype() == "plunder" || getgametypenamekey() == "clash" || level.var_9afa651d49da1c92.var_989f528ce80dabb9 )
    {
        level thread br_public::brleaderdialog( "mission_recon_start_plunder", 1, players, undefined, 2, undefined, "dx_br_rcct_" );
        return;
    }
    
    level thread br_public::brleaderdialog( "mission_recon_start", 1, players, undefined, 2, undefined, "dx_br_rcct_" );
}

// Namespace br_recon_quest
// Params 0
// Checksum 0x1b233320, Offset: 0x2362
// Size: 0x88
function function_24376242565d6a97()
{
    self.category = "train_recon";
    time = level.var_9afa651d49da1c92.questmaxtime;
    br_contract_manager::function_87e10a6e85d45d58( "train_recon" );
    time = br_contract_manager::function_2f14979bf83bc3db( time );
    br_contract_manager::function_3fbbc67df36be7bb( time );
    recon_start( self.var_fe0156f1cf4e5f41 );
    players = br_contract_manager::function_85e5094486ad4b57();
    level thread br_public::brleaderdialog( "mission_recon_start_train", 1, players, undefined, 2, undefined, "dx_br_rcct_" );
}

// Namespace br_recon_quest
// Params 1
// Checksum 0xc7449fd0, Offset: 0x23f2
// Size: 0x52
function quest_onentergulag( player )
{
    if ( br_contract_manager::function_c0bc7ce931921c06( player ) )
    {
        if ( isdefined( self.objidnum ) && self.objidnum != -1 )
        {
            objidpoolmanager::objective_playermask_hidefrom( self.objidnum, player );
        }
        
        self notify( #"hash_872b6450f175451c" );
    }
}

// Namespace br_recon_quest
// Params 1
// Checksum 0xcd0a7054, Offset: 0x244c
// Size: 0x52
function quest_onrespawn( player )
{
    if ( br_contract_manager::function_c0bc7ce931921c06( player ) )
    {
        if ( isdefined( self.objidnum ) && self.objidnum != -1 )
        {
            objidpoolmanager::objective_playermask_addshowplayer( self.objidnum, player );
        }
        
        self notify( #"hash_872b6450f175451c" );
    }
}

// Namespace br_recon_quest
// Params 2
// Checksum 0x84240a47, Offset: 0x24a6
// Size: 0x1e
function quest_onplayerkilled( attacker, victim )
{
    recon_playerremoved( victim );
}

// Namespace br_recon_quest
// Params 1
// Checksum 0x223ba055, Offset: 0x24cc
// Size: 0x15
function function_22116566150b5d1( victim )
{
    recon_playerremoved( victim );
}

// Namespace br_recon_quest
// Params 1
// Checksum 0xe2195574, Offset: 0x24e9
// Size: 0x15
function quest_onplayerdisconnect( player )
{
    recon_playerremoved( player );
}

// Namespace br_recon_quest
// Params 1
// Checksum 0x28bf4f2b, Offset: 0x2506
// Size: 0x2f
function quest_oncancel( team )
{
    if ( self.team == team )
    {
        function_62d7554f9f5e5e6f( 0, undefined, undefined, "Cancel", "dx_br_rcct_" );
    }
}

// Namespace br_recon_quest
// Params 1
// Checksum 0xb23abac8, Offset: 0x253d
// Size: 0x6f
function recon_playerremoved( player )
{
    if ( br_contract_manager::function_e1073238262d21f0( player ) )
    {
        filter = br_contract_manager::function_42827c79f1968770( player, level.contractmanager.defaultfilter );
        players = br_contract_manager::function_85e5094486ad4b57();
        
        if ( !br_quest_util::function_aa740d271fc528f6( players, filter ) )
        {
            function_62d7554f9f5e5e6f( 0, undefined, undefined, "Killed", "dx_br_rcct_" );
        }
    }
}

// Namespace br_recon_quest
// Params 3
// Checksum 0xcf1fb41e, Offset: 0x25b4
// Size: 0x135
function quest_onplayerteardown( player, oldteam, newteam )
{
    if ( oldteam == self.team )
    {
        if ( isdefined( self.domflag ) )
        {
            self.domflag disablescriptableplayeruse( player );
        }
        
        if ( isdefined( self.objidnum ) && self.objidnum != -1 )
        {
            objective_removeclientfrommask( self.objidnum, player );
        }
        
        player br_contract_manager::uiobjectivehide();
        
        if ( !br_quest_util::isteamvalid( self.team, level.contractmanager.defaultfilter ) )
        {
            playersonteam = br_contract_manager::function_85e5094486ad4b57();
            
            foreach ( player in playersonteam )
            {
                self.domflag disablescriptableplayeruse( player );
            }
            
            thread quest_complete( 0, undefined, "Assimilation" );
        }
    }
}

// Namespace br_recon_quest
// Params 3
// Checksum 0x1dcceaf7, Offset: 0x26f1
// Size: 0x122
function quest_onplayerassimilated( player, oldteam, newteam )
{
    if ( newteam == self.team )
    {
        player br_contract_manager::uiobjectiveshow( self.category );
        
        if ( self.type.ref == "train_recon" )
        {
            if ( isdefined( self.domflag ) && self.securing && level.var_e8ffdc2a1fa14c1f.var_3107e2b46be1f0e2 )
            {
                self.domflag enablescriptableplayeruse( player );
            }
        }
        else if ( isdefined( self.domflag ) && self.securing && level.var_9afa651d49da1c92.var_3107e2b46be1f0e2 )
        {
            self.domflag enablescriptableplayeruse( player );
        }
        
        player setclientomnvar( "ui_br_objective_countdown_timer", self.missiontime );
        
        if ( isdefined( self.objidnum ) && self.objidnum != -1 )
        {
            objective_addclienttomask( self.objidnum, player );
        }
    }
}

// Namespace br_recon_quest
// Params 2
// Checksum 0x3fb715fc, Offset: 0x281b
// Size: 0x137
function function_70034271e970d006( dangercircleorigin, var_1bdc861911b3625e )
{
    if ( self.var_b6c5eeeebd9383f5 )
    {
        return;
    }
    
    if ( isdefined( self.traincar ) )
    {
        if ( !self.securing || self.var_b25418214626adee.domflag.playersintrigger.size < 1 )
        {
            var_4f62960c523cf736 = function_839a57500b3790b4( self.traincar );
            
            if ( !br_circle_util::ispointindangercircle( var_4f62960c523cf736 ) )
            {
                self.var_b6c5eeeebd9383f5 = 1;
                function_62d7554f9f5e5e6f( 1, "br_recon_quest_obj_circle", "mission_obj_circle_fail", "Circle", "dx_br_brdm_" );
            }
        }
        
        return;
    }
    
    if ( isdefined( self.var_b25418214626adee ) )
    {
        if ( !self.securing || self.var_b25418214626adee.domflag.playersintrigger.size < 1 )
        {
            if ( !br_circle_util::ispointindangercircle( self.var_b25418214626adee.origin ) )
            {
                self.var_b6c5eeeebd9383f5 = 1;
                function_62d7554f9f5e5e6f( 1, "br_recon_quest_obj_circle", "mission_obj_circle_fail", "Circle", "dx_br_brdm_" );
            }
        }
    }
}

// Namespace br_recon_quest
// Params 0
// Checksum 0xd3a5295, Offset: 0x295a
// Size: 0x12
function function_67b529e129462fe2()
{
    self.var_b25418214626adee = undefined;
    return quest_oninit();
}

// Namespace br_recon_quest
// Params 5
// Checksum 0x8d6ed92b, Offset: 0x2975
// Size: 0x8b
function function_62d7554f9f5e5e6f( var_267793167a94cafb, splashref, voiceref, endstate, prefixoverride )
{
    if ( var_267793167a94cafb )
    {
        params = spawnstruct();
        params.intvar = 0;
        br_contract_manager::function_5c7e547ccc13711b( splashref, params );
        players = br_contract_manager::function_85e5094486ad4b57();
        level thread br_public::brleaderdialog( voiceref, 1, players, undefined, 2, undefined, prefixoverride );
    }
    
    thread quest_complete( 0, undefined, endstate );
}

// Namespace br_recon_quest
// Params 0
// Checksum 0xfacaeab0, Offset: 0x2a08
// Size: 0x167
function function_dd72e973244442d1()
{
    if ( self.ended )
    {
        return;
    }
    
    self.ended = 1;
    missionid = br_contract_manager::getquestindex( self.category );
    br_contract_manager::function_ba80ad6a1d946b85( 8, missionid, self.capturingplayer );
    players = br_contract_manager::function_85e5094486ad4b57();
    
    if ( game_utility::getgametype() == "plunder" || getgametypenamekey() == "clash" || level.var_9afa651d49da1c92.var_989f528ce80dabb9 )
    {
        level thread br_public::brleaderdialog( "mission_recon_success_plunder", 1, players, undefined, 2, undefined, "dx_br_rcct_" );
    }
    else
    {
        level thread br_public::brleaderdialog( "mission_recon_success", 1, players, undefined, 2, undefined, "dx_br_rcct_" );
    }
    
    if ( !isdefined( self.traincar ) )
    {
        forwardvector = anglestoforward( self.var_b25418214626adee.angles );
        self.rewardorigin = self.var_b25418214626adee.origin + forwardvector * 20;
        self.rewardangles = self.var_b25418214626adee.angles + ( 0, -100, 0 );
    }
    
    self.result = "success";
    function_3992efb53108782( 0 );
    br_contract_manager::function_7864d8f2e3f3454b( self, undefined, self.team );
}

// Namespace br_recon_quest
// Params 3
// Checksum 0xa23f3a36, Offset: 0x2b77
// Size: 0xae
function function_1be7c59a593161bc( contract, instance, team )
{
    rewards = contract br_contract_manager::function_7d7e225a8f9c9222( self.category, self.var_b25418214626adee, team, contract, contract.capturingplayer.sessionsquadid );
    
    if ( isdefined( rewards[ "plunder" ] ) )
    {
        splashref = br_contract_manager::function_7c9586992cf68ed1( "br_recon_quest_complete" );
        contract br_contract_manager::function_1f816e3c3465df7e( splashref, br_contract_manager::function_e01c7810f3c75f0b( self.category ), rewards[ "plunder" ] );
    }
    
    contract thread quest_complete( 1, rewards, "Win" );
}

// Namespace br_recon_quest
// Params 3
// Checksum 0x7bca7e76, Offset: 0x2c2d
// Size: 0x20e
function quest_complete( success, rewards, endstate )
{
    self notify( #"task_ended" );
    self.ended = 1;
    playersonteam = br_contract_manager::function_85e5094486ad4b57();
    
    foreach ( player in playersonteam )
    {
        objidpoolmanager::objective_playermask_hidefrom( self.icon, player );
        objidpoolmanager::function_beebd729a49b6cc3( player );
        objidpoolmanager::function_6ac40386d1cd0d9a( self.icon, player );
    }
    
    objidpoolmanager::returnobjectiveid( self.icon );
    self.objectiveiconid = self.objidnum;
    self.var_b25418214626adee.domflag.trigger delete();
    
    if ( isdefined( self.domflag.entfollower ) )
    {
        self.domflag.entfollower delete();
    }
    
    br_contract_manager::deletequestobjicon();
    thread function_e94f52c3f87af1b( self.var_b25418214626adee.domflag, success );
    self.var_b25418214626adee.domflag = undefined;
    self.var_b25418214626adee.task = undefined;
    self.var_b25418214626adee.setup = undefined;
    self.var_b25418214626adee.showworldicon = undefined;
    self.var_b25418214626adee.offset3d = undefined;
    self.var_b25418214626adee.curorigin = undefined;
    self.var_b25418214626adee.objidnum = undefined;
    self.var_b6c5eeeebd9383f5 = undefined;
    br_contract_manager::endcontract( success, rewards, undefined, undefined, endstate );
}

// Namespace br_recon_quest
// Params 2
// Checksum 0xdfae2596, Offset: 0x2e43
// Size: 0x350
function function_e94f52c3f87af1b( domflag, success )
{
    domflag endon( #"death" );
    level endon( #"game_ended" );
    
    if ( domflag.task.type.ref == "train_recon" )
    {
        if ( level.var_e8ffdc2a1fa14c1f.usevfx )
        {
            domflag setscriptablepartstate( "vfx_circle", "circle_end" );
            wait level.var_e8ffdc2a1fa14c1f.vfx_delay;
            
            if ( isdefined( domflag ) )
            {
                domflag setscriptablepartstate( "vfx_circle", "no_circle" );
            }
        }
    }
    else if ( level.var_9afa651d49da1c92.usevfx )
    {
        domflag setscriptablepartstate( "vfx_circle", "circle_end" );
        wait level.var_9afa651d49da1c92.vfx_delay;
        
        if ( isdefined( domflag ) )
        {
            domflag setscriptablepartstate( "vfx_circle", "no_circle" );
        }
    }
    
    if ( success )
    {
        if ( self.type.ref == "train_recon" )
        {
            if ( level.var_e8ffdc2a1fa14c1f.questdroploot )
            {
                var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( level.var_e8ffdc2a1fa14c1f.var_db8fa5e4c99f3f44 );
                
                if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
                {
                    var_d8f5fc538f785ca7 = function_839a57500b3790b4( self.traincar );
                    var_e91281ae61320d69 = function_5d9d4913d5a2c4a7( self.traincar );
                    forwardvector = anglestoforward( var_e91281ae61320d69 );
                    self.rewardorigin = var_d8f5fc538f785ca7 + forwardvector * 40 + ( 0, 0, -60 );
                    self.rewardangles = var_e91281ae61320d69 + ( 0, -100, 0 );
                    var_75edf5d39ca3eb70 = var_f67995529827f79.spawnlistname;
                    spawncount = var_f67995529827f79.spawncount;
                    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.rewardorigin, self.rewardangles );
                    spawnoptions.dropradiusscale = 0.75;
                    common_item::function_38cde6a6acb68ea6( var_75edf5d39ca3eb70, spawncount, spawnoptions );
                }
            }
        }
        else if ( level.var_9afa651d49da1c92.questdroploot )
        {
            var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( level.var_9afa651d49da1c92.var_db8fa5e4c99f3f44 );
            
            if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
            {
                var_75edf5d39ca3eb70 = var_f67995529827f79.spawnlistname;
                spawncount = var_f67995529827f79.spawncount;
                spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.rewardorigin, self.rewardangles );
                common_item::function_38cde6a6acb68ea6( var_75edf5d39ca3eb70, spawncount, spawnoptions );
            }
        }
    }
    
    if ( isdefined( domflag ) && domflag.task.type.ref == "train_recon" )
    {
        wait level.var_e8ffdc2a1fa14c1f.delete_delay;
    }
    else
    {
        wait level.var_9afa651d49da1c92.delete_delay;
    }
    
    if ( isdefined( domflag ) )
    {
        domflag freescriptable();
    }
}

// Namespace br_recon_quest
// Params 0
// Checksum 0x25e9812f, Offset: 0x319b
// Size: 0x5a
function function_88679453542a90b3()
{
    if ( self.securing && self.var_b25418214626adee.domflag.playersintrigger.size > 0 )
    {
        wait 5;
        br_contract_manager::function_a21d0af31443edfc();
        return;
    }
    
    function_62d7554f9f5e5e6f( 1, "br_recon_quest_timer_expired", "mission_recon_time_expired", "Time", "dx_br_rcct_" );
}

// Namespace br_recon_quest
// Params 1
// Checksum 0x31ba86d, Offset: 0x31fd
// Size: 0x47b
function recon_start( var_ca369031b554da2f )
{
    if ( utility::issharedfuncdefined( #"br_recon_quest", #"start" ) )
    {
        utility::callsharedfunc( #"br_recon_quest", #"start" );
    }
    
    if ( isdefined( self.traincar ) )
    {
        self.var_b25418214626adee = function_a51220fef73d29bf( self.traincar, var_ca369031b554da2f );
    }
    else
    {
        self.var_b25418214626adee = function_fb73a57e1c865df9( self.var_b25418214626adee, var_ca369031b554da2f );
    }
    
    domstruct = self.var_b25418214626adee;
    teamname = self.team;
    
    if ( self.var_b25418214626adee )
    {
        self.curorigin = self.var_b25418214626adee.domflag.origin;
        self.offset3d = ( 0, 0, 50 );
        gameobjects::requestid( 1, 1, undefined, 1 );
        domstruct.curorigin = domstruct.domflag.origin;
        domstruct.offset3d = ( 0, 0, 50 );
        domstruct gameobjects::requestid( 1, 1, undefined, 1 );
        self.icon = domstruct.objidnum;
        iconposition = self.var_b25418214626adee.domflag.origin + ( 0, 0, 70 );
        function_62238d8e13a6af13( self.objidnum, iconposition, level.var_9afa651d49da1c92.obj_icon );
        function_62238d8e13a6af13( domstruct.objidnum, iconposition, level.var_9afa651d49da1c92.obj_icon );
        objective_removeallfrommask( self.objidnum );
        br_contract_manager::function_3f9bfc2528d612aa( self.objidnum );
        objidpoolmanager::function_eb808b97701a4793( self.icon );
        objidpoolmanager::objective_set_play_intro( self.icon, 0 );
        
        if ( isdefined( self.traincar ) )
        {
            objective_setlabel( self.objidnum, level.var_e8ffdc2a1fa14c1f.var_f9734dc6201d0dcb );
        }
        else
        {
            objective_setlabel( self.objidnum, level.var_9afa651d49da1c92.var_f9734dc6201d0dcb );
        }
        
        thread br_contract_manager::function_d2646c7b2b23ae4b( "secure_recon_assigned", teamname, self.squadindex );
        splashref = br_contract_manager::function_7c9586992cf68ed1( "br_recon_quest_start_team" );
        thread br_contract_manager::function_5c7e547ccc13711b( splashref );
        players = br_contract_manager::function_85e5094486ad4b57();
        
        if ( isdefined( self.traincar ) )
        {
            if ( level.var_e8ffdc2a1fa14c1f.var_3107e2b46be1f0e2 )
            {
                foreach ( player in players )
                {
                    domstruct.domflag enablescriptableplayeruse( player );
                }
            }
            else
            {
                domstruct.domflag thread recon_waitforplayers();
            }
        }
        else if ( level.var_9afa651d49da1c92.var_3107e2b46be1f0e2 )
        {
            foreach ( player in players )
            {
                domstruct.domflag enablescriptableplayeruse( player );
            }
        }
        else
        {
            domstruct.domflag thread recon_waitforplayers();
        }
        
        if ( isdefined( self.traincar ) )
        {
            objidpoolmanager::update_objective_onentity( self.objidnum, self.domflag.entfollower );
            objidpoolmanager::update_objective_onentity( self.icon, self.domflag.entfollower );
        }
        
        return;
    }
    
    /#
        logstring( "<dev string:x3c>" );
    #/
    
    br_contract_manager::endcontract( undefined, undefined, undefined, undefined, "NoTargetError" );
    return;
}

// Namespace br_recon_quest
// Params 0
// Checksum 0x5099663, Offset: 0x3680
// Size: 0xf8
function recon_waitforplayers()
{
    self.task endon( #"task_ended" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( self.task ) )
        {
            return;
        }
        
        players = self.task br_contract_manager::function_85e5094486ad4b57();
        
        foreach ( player in players )
        {
            if ( distance( player.origin, self.origin ) < self.radius )
            {
                function_bff21f4529905f83( self, player );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace br_recon_quest
// Params 3
// Checksum 0x8ef9722e, Offset: 0x3780
// Size: 0x70
function function_62238d8e13a6af13( id, pos, icon )
{
    if ( isdefined( id ) && id != -1 )
    {
        objective_icon( id, icon );
        objective_position( id, pos );
        br_contract_manager::function_3f9bfc2528d612aa( id );
        objective_showtoplayersinmask( id );
        function_59c2c5d8363fbea0( id, 1 );
        objective_setprogressteam( id, self.team );
        br_contract_manager::function_9b8e4487dc719615( id, self );
    }
}

// Namespace br_recon_quest
// Params 2
// Checksum 0x717968ea, Offset: 0x37f8
// Size: 0x16c
function function_1dc8f4a527cfbfbf( domflag, objidnum )
{
    self endon( #"task_ended" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        playersonteam = br_contract_manager::function_85e5094486ad4b57();
        
        foreach ( player in playersonteam )
        {
            if ( !player player::isreallyalive() )
            {
                continue;
            }
            
            if ( player br_public::isplayerinorgoingtogulag() )
            {
                continue;
            }
            
            if ( isdefined( objidnum ) && objidnum != -1 )
            {
                objidpoolmanager::objective_playermask_addshowplayer( objidnum, player );
            }
        }
        
        foreach ( player in domflag.playersintrigger )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( br_contract_manager::function_e1073238262d21f0( player ) )
            {
                objidpoolmanager::objective_playermask_hidefrom( objidnum, player );
            }
        }
        
        waitframe();
    }
}

// Namespace br_recon_quest
// Params 3
// Checksum 0xb4358109, Offset: 0x396c
// Size: 0x281
function function_8aabe8488ceb5c2f( origin, paramstruct, domnodes )
{
    if ( utility::issharedfuncdefined( #"br_recon_quest", #"hash_768a24530cd9ccca" ) )
    {
        return utility::callsharedfunc( #"br_recon_quest", #"hash_768a24530cd9ccca" );
    }
    
    bestnode = undefined;
    bestdist = paramstruct.dommaxdist;
    
    if ( !level.br_circle_disabled )
    {
        var_baa7342c2419df11 = br_circle_util::function_472c93858e491e0a( origin );
        var_b5eefdf655fda772 = br_circle_util::function_b880c0f9998fdd69( var_baa7342c2419df11 );
    }
    
    foreach ( node in domnodes )
    {
        dist = distance2d( node.origin, origin );
        
        if ( dist > paramstruct.dommaxdist )
        {
            continue;
        }
        
        if ( node.task )
        {
            continue;
        }
        
        if ( !level.br_circle_disabled )
        {
            var_e34b2a712c85d8c6 = 0;
            
            if ( !isdefined( node.circletimeline ) || !isdefined( node.var_b77210c587c94ed6 ) )
            {
                var_c8f52e077a73a45d = br_circle_util::function_472c93858e491e0a( node.origin );
                var_e34b2a712c85d8c6 = br_circle_util::function_b880c0f9998fdd69( var_c8f52e077a73a45d );
                node.circletimeline = var_c8f52e077a73a45d;
                node.var_b77210c587c94ed6 = var_e34b2a712c85d8c6;
            }
            else
            {
                var_c8f52e077a73a45d = node.circletimeline;
                var_e34b2a712c85d8c6 = node.var_b77210c587c94ed6;
            }
            
            if ( var_e34b2a712c85d8c6 < var_b5eefdf655fda772 )
            {
                continue;
            }
            
            traveltime = dist / 190;
            var_e34b2a712c85d8c6 -= traveltime;
            
            if ( var_e34b2a712c85d8c6 < paramstruct.var_540b35ff024488bc )
            {
                continue;
            }
        }
        
        var_ac99ac222f6bbc72 = 0;
        
        if ( dist < paramstruct.var_319f12ba84882793 )
        {
            if ( dist < paramstruct.var_37b666113634a0b1 )
            {
                var_ac99ac222f6bbc72 = paramstruct.var_37b666113634a0b1 - dist;
            }
        }
        else
        {
            var_ac99ac222f6bbc72 = dist - paramstruct.var_319f12ba84882793;
        }
        
        if ( var_ac99ac222f6bbc72 < bestdist )
        {
            bestdist = var_ac99ac222f6bbc72;
            bestnode = node;
            
            if ( var_ac99ac222f6bbc72 <= 0 )
            {
                break;
            }
        }
    }
    
    return bestnode;
}

// Namespace br_recon_quest
// Params 1
// Checksum 0x58c3283d, Offset: 0x3bf6
// Size: 0x74
function function_839a57500b3790b4( traincar )
{
    if ( isdefined( traincar.var_b25418214626adee.origin ) && isdefined( traincar.origin ) && isdefined( traincar.angles ) )
    {
        return ( traincar.origin + rotatevector( traincar.var_b25418214626adee.origin, traincar.angles ) );
    }
}

// Namespace br_recon_quest
// Params 1
// Checksum 0x3f60cf83, Offset: 0x3c72
// Size: 0x56
function function_5d9d4913d5a2c4a7( traincar )
{
    if ( isdefined( traincar.var_b25418214626adee.angles ) && isdefined( traincar.angles ) )
    {
        return ( traincar.angles + traincar.var_b25418214626adee.angles );
    }
}

// Namespace br_recon_quest
// Params 1
// Checksum 0x3196c29b, Offset: 0x3cd0
// Size: 0x112
function function_d3f28f7cfcfbf9( var_b7aa92c3b872e5e0 )
{
    var_5b2484ad2b78df1e = [];
    
    foreach ( domnode in level.var_9afa651d49da1c92.var_6634648543763933 )
    {
        if ( utility::is_origin_in_area_swap( domnode.origin, var_b7aa92c3b872e5e0.swapname, var_b7aa92c3b872e5e0.swapstate ) )
        {
            if ( isdefined( domnode.task.tablet ) )
            {
                domnode.task.tablet thread br_contract_manager::tablethide( 1 );
            }
            
            continue;
        }
        
        var_5b2484ad2b78df1e[ var_5b2484ad2b78df1e.size ] = domnode;
    }
    
    level.var_9afa651d49da1c92.var_6634648543763933 = var_5b2484ad2b78df1e;
}

// Namespace br_recon_quest
// Params 0
// Checksum 0xf47f1cd3, Offset: 0x3dea
// Size: 0x5b, Type: bool
function function_936aa46ccae237fa()
{
    domflag = self;
    
    if ( domflag.task && domflag.task.tablet )
    {
        domflag.task function_62d7554f9f5e5e6f( 0, undefined, "mission_gen_fail", "AreaSwap", "dx_br_rcct_" );
    }
    
    return true;
}

// Namespace br_recon_quest
// Params 2
// Checksum 0x7b4a2a0e, Offset: 0x3e4e
// Size: 0x259
function function_fb73a57e1c865df9( node, var_ca369031b554da2f )
{
    if ( !isdefined( node ) )
    {
        assertmsg( "<dev string:x7f>" );
        return;
    }
    
    if ( !( node.spawnflags & 7 ) )
    {
        assertmsg( "<dev string:xb7>" );
    }
    
    v_origin = getgroundposition( node.origin, 1 );
    var_2a21be5f74f73c3d = node.angles ?? ( 0, 0, 0 );
    node.angles = var_2a21be5f74f73c3d;
    spawndompoint( var_ca369031b554da2f, node, v_origin, var_2a21be5f74f73c3d );
    self.domflag.script_poi = poi::poi_findpoioriginisin( node.origin, 1 );
    domradius = br_contract_manager::questpointgetradius( node );
    self.domflag.trigger = spawn( "trigger_radius", node.origin, 0, int( domradius ), level.var_9afa651d49da1c92.dompointtriggerheight );
    self.domflag.radius = domradius;
    self.domflag.trigger utility::trigger_on();
    self.domflag.playersintrigger = [];
    self.domflag.task = self;
    node.setup = 1;
    node.domflag = self.domflag;
    self.domflag.node = node;
    
    foreach ( player in level.players )
    {
        self.domflag disablescriptableplayeruse( player );
    }
    
    self.domflag utility::function_8a74027bdea84771( &function_936aa46ccae237fa );
    self.domflag thread domflag_watchtrigger();
    return node;
}

// Namespace br_recon_quest
// Params 2
// Checksum 0xafa46a55, Offset: 0x40b0
// Size: 0x317
function function_a51220fef73d29bf( traincar, var_ca369031b554da2f )
{
    if ( !isdefined( traincar ) )
    {
        assertmsg( "<dev string:xf5>" );
        return;
    }
    
    if ( !isdefined( traincar.var_b25418214626adee ) )
    {
        assertmsg( "<dev string:x12e>" );
        return;
    }
    
    if ( !( traincar.var_b25418214626adee.spawnflags & 7 ) )
    {
        assertmsg( "<dev string:xb7>" );
    }
    
    var_2a21be5f74f73c3d = function_5d9d4913d5a2c4a7( traincar );
    var_92b32d702db115f1 = function_839a57500b3790b4( traincar );
    function_f79c948a2f9069df( var_ca369031b554da2f, traincar, var_92b32d702db115f1, var_2a21be5f74f73c3d );
    self.domflag.script_poi = poi::poi_findpoioriginisin( var_92b32d702db115f1, 1 );
    domradius = br_contract_manager::questpointgetradius( traincar.var_b25418214626adee );
    self.domflag.trigger = spawn( "trigger_radius", var_92b32d702db115f1, 0, int( domradius ), level.var_e8ffdc2a1fa14c1f.dompointtriggerheight );
    self.domflag.radius = domradius;
    self.domflag.trigger utility::trigger_on();
    self.domflag.playersintrigger = [];
    self.domflag.task = self;
    traincar.var_b25418214626adee.setup = 1;
    traincar.var_b25418214626adee.domflag = self.domflag;
    var_8e758561227fe312 = self.traincar.linked_model;
    linkorigin = self.traincar.var_b25418214626adee.origin ?? ( 0, 0, 0 );
    linkangles = self.traincar.var_b25418214626adee.angles ?? ( 0, 0, 0 );
    self.domflag scriptablesetparententity( var_8e758561227fe312, linkorigin, linkangles );
    self.domflag.trigger enablelinkto();
    self.domflag.trigger linkto( var_8e758561227fe312, "tag_origin", linkorigin, linkangles );
    
    foreach ( player in level.players )
    {
        self.domflag disablescriptableplayeruse( player );
    }
    
    self.domflag thread domflag_watchtrigger();
    return traincar.var_b25418214626adee;
}

// Namespace br_recon_quest
// Params 0
// Checksum 0x8aeda362, Offset: 0x43d0
// Size: 0x183
function domflag_watchtrigger()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.task endon( #"task_ended" );
    
    while ( true )
    {
        self.trigger waittill( #"trigger", ent );
        
        if ( !isplayer( ent ) && !ent vehicle::is_vehicle() || arraycontains( self.playersintrigger, ent ) )
        {
            continue;
        }
        
        if ( ent vehicle::is_vehicle() )
        {
            occupants = vehicle_occupancy::function_b6077e40739ebc4b( ent );
            
            foreach ( occupant in occupants )
            {
                if ( isplayer( occupant ) )
                {
                    if ( !arraycontains( self.playersintrigger, occupant ) )
                    {
                        self.playersintrigger[ self.playersintrigger.size ] = occupant;
                        thread function_fcdaddadd71126f8( occupant );
                    }
                }
            }
            
            continue;
        }
        
        if ( isplayer( ent ) )
        {
            if ( !arraycontains( self.playersintrigger, ent ) )
            {
                self.playersintrigger[ self.playersintrigger.size ] = ent;
                thread function_fcdaddadd71126f8( ent );
            }
        }
    }
}

// Namespace br_recon_quest
// Params 1
// Checksum 0xc89f9aeb, Offset: 0x455b
// Size: 0x128
function function_fcdaddadd71126f8( player )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.task endon( #"task_ended" );
    domradius = self.radius;
    domradiussq = domradius * domradius;
    objicon = self.task.icon;
    
    while ( isalive( player ) && isdefined( self.trigger ) && distancesquared( self.trigger.origin, player.origin ) < domradiussq )
    {
        waitframe();
    }
    
    if ( isdefined( player ) && isdefined( objicon ) && self.task br_contract_manager::function_e1073238262d21f0( player ) )
    {
        objidpoolmanager::objective_playermask_hidefrom( objicon, player );
        objidpoolmanager::function_beebd729a49b6cc3( player );
        objidpoolmanager::function_6ac40386d1cd0d9a( objicon, player );
    }
    
    self.playersintrigger = arrayremove( self.playersintrigger, player );
    self.playersintrigger = function_5713d46873b29625( self.playersintrigger );
}

// Namespace br_recon_quest
// Params 6
// Checksum 0x2e449060, Offset: 0x468b
// Size: 0x18b
function function_4cf1fce206ba178d( instance, part, state, useplayer, bautouse, usestring )
{
    if ( isstring( level.var_9afa651d49da1c92.var_79c4131c76a2b23e ) )
    {
        deployresult = useplayer br_contract_manager::function_14a772eecc5cf7d1( makeweapon( level.var_9afa651d49da1c92.var_79c4131c76a2b23e ), undefined, level.var_9afa651d49da1c92.var_eeccb0f33daf68f2 );
    }
    else
    {
        deployresult = useplayer br_contract_manager::function_14a772eecc5cf7d1( level.var_9afa651d49da1c92.var_79c4131c76a2b23e, undefined, level.var_9afa651d49da1c92.var_eeccb0f33daf68f2 );
    }
    
    if ( !deployresult )
    {
        return;
    }
    
    if ( instance.node.spawnflags & 4 )
    {
        instance setscriptablepartstate( level.var_9afa651d49da1c92.var_3bdb39f20a8345c, "unusable" );
    }
    else if ( instance.node.spawnflags & 2 )
    {
        instance setscriptablepartstate( level.var_9afa651d49da1c92.var_688056a04690dbd4, "unusable" );
    }
    else if ( instance.node.spawnflags & 1 )
    {
        instance setscriptablepartstate( level.var_9afa651d49da1c92.var_1dd64dad26e1aaa0, "unusable" );
    }
    
    function_bff21f4529905f83( instance, useplayer );
}

// Namespace br_recon_quest
// Params 6
// Checksum 0xc9259b89, Offset: 0x481e
// Size: 0xf6
function function_cabb0eefef6c7fb7( instance, part, state, useplayer, bautouse, usestring )
{
    if ( isstring( level.var_e8ffdc2a1fa14c1f.var_79c4131c76a2b23e ) )
    {
        deployresult = useplayer br_contract_manager::function_14a772eecc5cf7d1( makeweapon( level.var_e8ffdc2a1fa14c1f.var_79c4131c76a2b23e ), undefined, level.var_e8ffdc2a1fa14c1f.var_eeccb0f33daf68f2 );
    }
    else
    {
        deployresult = useplayer br_contract_manager::function_14a772eecc5cf7d1( level.var_e8ffdc2a1fa14c1f.var_79c4131c76a2b23e, undefined, level.var_e8ffdc2a1fa14c1f.var_eeccb0f33daf68f2 );
    }
    
    if ( !deployresult )
    {
        return;
    }
    
    instance setscriptablepartstate( level.var_e8ffdc2a1fa14c1f.var_1dd64dad26e1aaa0, "unusable" );
    function_bff21f4529905f83( instance, useplayer );
}

// Namespace br_recon_quest
// Params 2
// Checksum 0x3ea22e1, Offset: 0x491c
// Size: 0x223
function function_bff21f4529905f83( instance, player )
{
    level thread br_public::brleaderdialogplayer( "mission_recon_start_capture_first_person", player, 1, undefined, 2, undefined, "dx_br_rcct_" );
    players = instance.task br_contract_manager::function_85e5094486ad4b57();
    players = arrayremove( players, player );
    level thread br_public::brleaderdialog( "mission_recon_start_capture", 1, players, undefined, 2, undefined, "dx_br_rcct_" );
    
    if ( instance.task.type.ref == "train_recon" )
    {
        if ( level.var_e8ffdc2a1fa14c1f.var_6e9874e04cc8925d == 1 )
        {
            level thread br_contract_manager::utilflare_shootflare( instance.origin, "dom" );
        }
    }
    else if ( level.var_9afa651d49da1c92.var_6e9874e04cc8925d )
    {
        level thread br_contract_manager::utilflare_shootflare( instance.origin, "dom" );
    }
    
    objidpoolmanager::objective_set_play_intro( instance.task.objidnum, 0 );
    instance.task thread function_1dc8f4a527cfbfbf( instance, instance.task.objidnum );
    
    if ( instance.task.type.ref == "train_recon" )
    {
        if ( level.var_e8ffdc2a1fa14c1f.var_52b1175552196a04 )
        {
            objidpoolmanager::objective_set_show_progress( instance.task.objidnum, 1 );
        }
    }
    else if ( level.var_9afa651d49da1c92.var_52b1175552196a04 )
    {
        objidpoolmanager::objective_set_show_progress( instance.task.objidnum, 1 );
    }
    
    instance.task thread domflag_update( instance.task.domflag, instance.task.icon, instance.task.objidnum );
}

// Namespace br_recon_quest
// Params 3
// Checksum 0x40201a4b, Offset: 0x4b47
// Size: 0x29
function domflag_update( domflag, objidnum, var_4bebb75e86ab0cd4 )
{
    domflag_updateinternal( domflag, objidnum, var_4bebb75e86ab0cd4 );
}

// Namespace br_recon_quest
// Params 3, eflags: 0x4
// Checksum 0x300f4806, Offset: 0x4b78
// Size: 0x3a4
function private domflag_updateinternal( domflag, objidnum, var_4bebb75e86ab0cd4 )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    self.securing = 1;
    objective_setpinned( objidnum, 1 );
    objective_setlabel( objidnum, &"mp_br_ingame/contract_recon_secure" );
    domflag function_d51f9fbdc73f5704( self.var_b25418214626adee );
    playersonteam = br_contract_manager::function_85e5094486ad4b57();
    overlord::playevent( "secure_recon_uploading", playersonteam );
    timer = 0;
    
    if ( self.type.ref == "train_recon" )
    {
        duration = level.var_e8ffdc2a1fa14c1f.domcapturetime * 1000;
    }
    else
    {
        duration = level.var_9afa651d49da1c92.domcapturetime * 1000;
    }
    
    while ( true )
    {
        count = 0;
        
        foreach ( player in domflag.playersintrigger )
        {
            if ( br_contract_manager::function_e1073238262d21f0( player ) )
            {
                if ( self.type.ref == "train_recon" )
                {
                    objidpoolmanager::function_72efeaceb614613a( objidnum, player, 2, 2, level.var_e8ffdc2a1fa14c1f.time_remaining_text );
                    objective_setpinnedprogressbartext( level.var_e8ffdc2a1fa14c1f.time_remaining_text, player );
                }
                else
                {
                    objidpoolmanager::function_72efeaceb614613a( objidnum, player, 2, 2, level.var_9afa651d49da1c92.time_remaining_text );
                    objective_setpinnedprogressbartext( level.var_9afa651d49da1c92.time_remaining_text, player );
                }
                
                objidpoolmanager::objective_playermask_addshowplayer( objidnum, player );
                count++;
            }
        }
        
        function_3992efb53108782( count );
        
        if ( count > 0 )
        {
            if ( !self.var_6472f484147d1cab )
            {
                self.var_6472f484147d1cab = 1;
                br_contract_manager::function_9fe564137142e8ee( 1 );
                objective_disableping( objidnum, 1 );
                calloutmarkerping::function_73084f64fa34a5a8( var_4bebb75e86ab0cd4 );
            }
            
            if ( self.type.ref == "train_recon" )
            {
                var_5d1f53051ff9c230 = level.var_e8ffdc2a1fa14c1f.var_51704ad3d151a5ed;
            }
            else
            {
                var_5d1f53051ff9c230 = level.var_9afa651d49da1c92.var_51704ad3d151a5ed;
            }
            
            var_2c0804422a8e5842 = 0;
            
            if ( level.maxteamsize > 1 )
            {
                var_2c0804422a8e5842 = var_5d1f53051ff9c230 / ( level.maxteamsize - 1 );
            }
            
            capturerate = 1 + ( count - 1 ) * var_2c0804422a8e5842;
            timer += level.frameduration * capturerate;
            progress = timer / duration;
            progress = clamp( progress, 0, 1 );
            
            if ( timer < duration )
            {
                objective_setprogress( var_4bebb75e86ab0cd4, progress );
                objective_setprogress( objidnum, progress );
                thread play_spotrep_capture_sfx( progress, domflag.playersintrigger );
            }
            else
            {
                self.capturingplayer = domflag.playersintrigger[ 0 ];
                function_dd72e973244442d1();
                self.securing = 0;
                break;
            }
        }
        else if ( self.var_6472f484147d1cab )
        {
            self.var_6472f484147d1cab = 0;
            br_contract_manager::function_9fe564137142e8ee( 0 );
            objective_disableping( objidnum, 0 );
        }
        
        waitframe();
    }
}

// Namespace br_recon_quest
// Params 2
// Checksum 0x8742c7c7, Offset: 0x4f24
// Size: 0x102
function play_spotrep_capture_sfx( progress, players )
{
    if ( !isdefined( self.lastsfxplayedtime ) )
    {
        self.lastsfxplayedtime = gettime();
    }
    
    if ( self.lastsfxplayedtime + 995 < gettime() )
    {
        self.lastsfxplayedtime = gettime();
        progress = int( floor( progress * 10 ) );
        var_8eb35fb703d61a67 = "shared_obj_capturing_tick_0" + progress;
        
        foreach ( player in players )
        {
            if ( br_contract_manager::function_e1073238262d21f0( player ) )
            {
                player gameplay_sound_fx::function_1ef72f46669e3816( var_8eb35fb703d61a67, self.domflag.trigger );
            }
        }
    }
}

// Namespace br_recon_quest
// Params 4
// Checksum 0x28d55f9e, Offset: 0x502e
// Size: 0x1c6
function spawndompoint( var_ca369031b554da2f, point, v_origin, var_2a21be5f74f73c3d )
{
    /#
        if ( getdvar( @"hash_79bd989cf75e6e80", "<dev string:x170>" ) != "<dev string:x170>" )
        {
            size = getdvar( @"hash_79bd989cf75e6e80", "<dev string:x170>" );
            
            switch ( size )
            {
                case #"hash_5971965ed985a26c":
                    point.spawnflags = 2;
                    break;
                case #"hash_c71b112fe04823d6":
                    point.spawnflags = 1;
                    break;
                case #"hash_4bf33d595d8f4894":
                default:
                    point.spawnflags = 4;
                    break;
            }
        }
    #/
    
    payload = [ #"teamselect", var_ca369031b554da2f.team ];
    
    if ( point.spawnflags & 2 )
    {
        if ( !isdefined( self.domflag ) )
        {
            self.domflag = spawnscriptable( level.var_9afa651d49da1c92.var_688056a04690dbd4, v_origin, var_2a21be5f74f73c3d, undefined, payload );
        }
        
        return;
    }
    
    if ( point.spawnflags & 1 )
    {
        if ( !isdefined( self.domflag ) )
        {
            self.domflag = spawnscriptable( level.var_9afa651d49da1c92.var_1dd64dad26e1aaa0, v_origin, var_2a21be5f74f73c3d, undefined, payload );
        }
        
        return;
    }
    
    if ( point.spawnflags & 4 )
    {
        if ( !isdefined( self.domflag ) )
        {
            self.domflag = spawnscriptable( level.var_9afa651d49da1c92.var_3bdb39f20a8345c, v_origin, var_2a21be5f74f73c3d, undefined, payload );
        }
    }
}

// Namespace br_recon_quest
// Params 4
// Checksum 0x859da59b, Offset: 0x51fc
// Size: 0x116
function function_f79c948a2f9069df( var_ca369031b554da2f, traincar, v_origin, var_2a21be5f74f73c3d )
{
    payload = [ #"teamselect", var_ca369031b554da2f.team ];
    
    if ( !isdefined( self.domflag ) )
    {
        self.domflag = spawnscriptable( level.var_e8ffdc2a1fa14c1f.var_1dd64dad26e1aaa0, v_origin, var_2a21be5f74f73c3d, undefined, payload );
        self.domflag.entfollower = spawn( "script_model", v_origin );
        self.domflag.entfollower linkto( traincar.linked_model );
        self.domflag.entfollower.linkedparent = traincar.linked_model;
        self.domflag.entfollower.scriptable = self.domflag;
    }
}

// Namespace br_recon_quest
// Params 1
// Checksum 0xdb7d8f7f, Offset: 0x531a
// Size: 0x81
function function_d51f9fbdc73f5704( point )
{
    if ( self.task.type.ref == "train_recon" )
    {
        if ( level.var_e8ffdc2a1fa14c1f.usevfx )
        {
            self setscriptablepartstate( "vfx_circle", "circle" );
        }
        
        return;
    }
    
    if ( level.var_9afa651d49da1c92.usevfx )
    {
        self setscriptablepartstate( "vfx_circle", "circle" );
    }
}

// Namespace br_recon_quest
// Params 0
// Checksum 0xe45d9926, Offset: 0x53a3
// Size: 0xd7
function function_283f4988a229c380()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( self.task.type.ref == "train_recon" )
    {
        if ( level.var_e8ffdc2a1fa14c1f.usevfx )
        {
            self setscriptablepartstate( "vfx_circle", "circle_end" );
            wait level.var_e8ffdc2a1fa14c1f.vfx_delay;
            self setscriptablepartstate( "vfx_circle", "no_circle" );
        }
        
        return;
    }
    
    if ( level.var_9afa651d49da1c92.usevfx )
    {
        self setscriptablepartstate( "vfx_circle", "circle_end" );
        wait level.var_9afa651d49da1c92.vfx_delay;
        self setscriptablepartstate( "vfx_circle", "no_circle" );
    }
}

// Namespace br_recon_quest
// Params 1
// Checksum 0x466abae8, Offset: 0x5482
// Size: 0xc8
function function_3992efb53108782( playersintrigger )
{
    var_aeec95ea59e8a06e = self.domflag.playersintrigger;
    
    foreach ( player in br_contract_manager::function_85e5094486ad4b57() )
    {
        if ( playersintrigger == 0 || arraycontains( var_aeec95ea59e8a06e, player ) )
        {
            player setclientomnvar( "ui_br_objective_players_in_trigger", playersintrigger, 1 );
            continue;
        }
        
        player setclientomnvar( "ui_br_objective_players_in_trigger", 0 );
    }
}

/#

    // Namespace br_recon_quest
    // Params 0
    // Checksum 0x8424d519, Offset: 0x5552
    // Size: 0xbd, Type: dev
    function function_70ef765b4625d0e8()
    {
        waitframe();
        
        foreach ( domnode in level.var_9afa651d49da1c92.var_6634648543763933 )
        {
            thread debug_utility::drawline( domnode.origin, domnode.origin + ( 0, 0, 1200 ), 9999999, ( 1, 0, 1 ) );
        }
    }

    // Namespace br_recon_quest
    // Params 1
    // Checksum 0xf05f38c2, Offset: 0x5617
    // Size: 0xb1, Type: dev
    function function_17056c89d1532264( array )
    {
        level waittill( #"prematch_over" );
        
        foreach ( point in array )
        {
            point spawndompoint( level.players[ 0 ], point, point.origin, point.angles );
        }
    }

    // Namespace br_recon_quest
    // Params 6
    // Checksum 0x4604059d, Offset: 0x56d0
    // Size: 0x117, Type: dev
    function function_71e0f906d0888a2d( instance, part, state, useplayer, bautouse, usestring )
    {
        if ( isstring( level.var_9afa651d49da1c92.var_79c4131c76a2b23e ) )
        {
            deployresult = useplayer br_contract_manager::function_14a772eecc5cf7d1( makeweapon( level.var_9afa651d49da1c92.var_79c4131c76a2b23e ), undefined, level.var_9afa651d49da1c92.var_eeccb0f33daf68f2 );
        }
        else
        {
            deployresult = useplayer br_contract_manager::function_14a772eecc5cf7d1( level.var_9afa651d49da1c92.var_79c4131c76a2b23e, undefined, level.var_9afa651d49da1c92.var_eeccb0f33daf68f2 );
        }
        
        if ( !deployresult )
        {
            return;
        }
        
        if ( !isdefined( instance.vfxactive ) )
        {
            instance.vfxactive = 1;
            instance function_d51f9fbdc73f5704( self.var_b25418214626adee );
            return;
        }
        
        instance.vfxactive = undefined;
        instance thread function_283f4988a229c380();
    }

#/
