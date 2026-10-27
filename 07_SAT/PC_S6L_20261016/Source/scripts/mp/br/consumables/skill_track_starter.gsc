// scripts\mp\br\consumables\skill_track_starter.gsc  (hash_667d9902397e299f.gscc) (size: 1526 Bytes / 0x5f6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x74efcc55 (1961872469)
// size ...... 1526 (0x5f6)
// includes .. 2   (offset: 0x576)
// strings ... 2   (offset: 0x586)
// dev strs .. 6   (offset: 0x59e)
// exports ... 3   (offset: 0x3d2)
// cseg ...... 0x84 + 0x34e (0x3d2)
// imports ... 10  (offset: 0x44a)
// animtree1 . 0   (offset: 0x5f6)
// animtree2 . 0   (offset: 0x5f6)
#using scripts\common\utility;
#using scripts\mp\loot\common_item;

#namespace skill_track_starter;

// Namespace skill_track_starter
// Params 0, eflags: 0x1
// Checksum 0x47bcfaf6, Offset: 0xa2
// Size: 0x37
function autoexec main()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    utility::flag_wait( "common_items_init" );
    utility::registersharedfunc( #"skill_track_starter", #"skill_track_starter_used", &function_bdb3d8148f957d8e );
}

// Namespace skill_track_starter
// Params 1, eflags: 0x4
// Checksum 0xb3085e34, Offset: 0xe1
// Size: 0x2f1
function private function_bdb3d8148f957d8e( params )
{
    player = params.player;
    
    if ( !isplayer( player ) )
    {
        return 0;
    }
    
    player endon( #"disconnect" );
    
    if ( params.bundle.subtype != "skill_track_starter" )
    {
        return 0;
    }
    
    player utility::callsharedfunc( #"skills", #"hash_caf936d46b7e8c96" );
    skilltrack = getscriptbundle( params.bundle.skilltrack );
    
    if ( skilltrack && skilltrack.skills[ 0 ] )
    {
        player.skilllevel = 0;
        player.skilltrack = skilltrack;
        
        if ( params.bundle.var_ac96606b616dd7b9 )
        {
            foreach ( skill in skilltrack.skills )
            {
                skillbundle = getscriptbundle( skill.skillbundle );
                
                if ( skillbundle )
                {
                    player.skilllevel++;
                    player utility::callsharedfunc( #"skills", #"giveskill", skillbundle.skillref, skillbundle.skilllevel );
                    continue;
                }
                
                assertmsg( "<dev string:x24>" + skill.skillbundle + "<dev string:x41>" + skill.ref + "<dev string:x4d>" + skilltrack.ref + "<dev string:x5e>" );
            }
        }
        else if ( skilltrack.skills[ 0 ] && skilltrack.skills[ 0 ].var_361cdcaa190a34e3 )
        {
            firstskill = getscriptbundle( skilltrack.skills[ 0 ].skillbundle );
            
            if ( firstskill )
            {
                player.skilllevel++;
                player utility::callsharedfunc( #"skills", #"giveskill", firstskill.skillref, firstskill.skilllevel );
            }
            else
            {
                assertmsg( "<dev string:x24>" + skill.skillbundle + "<dev string:x41>" + skill.ref + "<dev string:x4d>" + skilltrack.ref + "<dev string:x5e>" );
            }
        }
        
        return;
    }
    
    assertmsg( "<dev string:x83>" + skilltrack.ref + "<dev string:x8f>" );
}

