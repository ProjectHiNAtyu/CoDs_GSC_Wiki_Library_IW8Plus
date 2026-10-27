// scripts\mp\ob\skills\skill_dive_bomber.gsc  (hash_4f1484862cfdab11.gscc) (size: 4315 Bytes / 0x10db / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x25cc05c8 (634127816)
// size ...... 4315 (0x10db)
// includes .. 4   (offset: 0xf7f)
// strings ... 7   (offset: 0xf9f)
// dev strs .. 16  (offset: 0x101b)
// exports ... 13  (offset: 0x96f)
// cseg ...... 0xb8 + 0x8b7 (0x96f)
// imports ... 33  (offset: 0xb77)
// animtree1 . 0   (offset: 0x10db)
// animtree2 . 0   (offset: 0x10db)
#using script_2fe74ee229c972c3;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\ob\systems\ob_stun;

#namespace skill_dive_bomber;

// Namespace skill_dive_bomber
// Params 0, eflags: 0x1
// Checksum 0x4d2b7e27, Offset: 0xd6
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"dive_bomber", &init );
}

// Namespace skill_dive_bomber
// Params 0
// Checksum 0x3666300c, Offset: 0xf5
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"dive_bomber", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"dive_bomber", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_dive_bomber
// Params 1, eflags: 0x4
// Checksum 0xf8582242, Offset: 0x13b
// Size: 0x194, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_27099ed4560ba1b1, "<dev string:x24>" );
    assert( skill_bundle.var_20b4daef548ff57d, "<dev string:x65>" );
    assert( skill_bundle.var_f7f75f94feaba240, "<dev string:xa5>" );
    assert( skill_bundle.var_21ff8bde4c122a79, "<dev string:xe5>" );
    assert( skill_bundle.var_aea7911dbfca186b, "<dev string:x129>" );
    assert( skill_bundle.var_65b10b09875e38d6, "<dev string:x172>" );
    assert( skill_bundle.var_d3415d72554ff70c, "<dev string:x1b5>" );
    assert( skill_bundle.var_b27f0c4931c5a102, "<dev string:x1f7>" );
    assert( skill_bundle.var_44093edf44048868, "<dev string:x23a>" );
    assert( skill_bundle.var_9511c23aa2332c4f, "<dev string:x279>" );
    assert( skill_bundle.var_6bbb8a5adbde7d90, "<dev string:x2bb>" );
    assert( skill_bundle.var_5f85833f2f10f14a, "<dev string:x305>" );
    assert( skill_bundle.var_237dd0d062ac903b, "<dev string:x346>" );
    assert( skill_bundle.var_45ca4472681d9be5, "<dev string:x38d>" );
    assert( skill_bundle.var_2c1a90bda6a6ae0d, "<dev string:x3db>" );
    self.var_59d95ba89a817f5a = { #bundle:skill_bundle };
    thread monitor_wingsuit( skill_bundle );
    return true;
}

// Namespace skill_dive_bomber
// Params 1, eflags: 0x4
// Checksum 0x53676eb5, Offset: 0x2d8
// Size: 0x22
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"hash_c857c1615695b822" );
    self.var_59d95ba89a817f5a = undefined;
}

// Namespace skill_dive_bomber
// Params 1, eflags: 0x4
// Checksum 0xb1973a38, Offset: 0x302
// Size: 0x59
function private monitor_wingsuit( bundle )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_c857c1615695b822" );
    
    while ( true )
    {
        self waittill( #"skydive_deployparachute" );
        childthread function_8868fe82b217fb0f( bundle );
        self waittill( #"skydive_touch" );
        childthread apply_stun( bundle );
        waitframe();
    }
}

// Namespace skill_dive_bomber
// Params 1, eflags: 0x4
// Checksum 0x84d54b48, Offset: 0x363
// Size: 0xfd
function private function_8868fe82b217fb0f( bundle )
{
    self endon( #"skydive_touch" );
    playing_state = 0;
    
    while ( true )
    {
        if ( self iswingsuitdeployed() )
        {
            forward = anglestoforward( self getplayerangles() );
            forward_dot_down = vectordot( forward, ( 0, 0, -1 ) );
            var_71119cbddd3d9a03 = forward_dot_down > bundle.var_2c1a90bda6a6ae0d;
            
            if ( !playing_state && var_71119cbddd3d9a03 )
            {
                self setscriptablepartstate( bundle.var_6bbb8a5adbde7d90, bundle.var_237dd0d062ac903b );
                
                if ( bundle.var_45ca4472681d9be5 )
                {
                    pbgpostfxbundlestart( self, bundle.var_45ca4472681d9be5 );
                }
                
                playing_state = 1;
            }
            else if ( playing_state && !var_71119cbddd3d9a03 )
            {
                clean_up_effects( bundle );
                playing_state = 0;
            }
        }
        else if ( playing_state )
        {
            clean_up_effects( bundle );
            playing_state = 0;
        }
        
        wait 0.1;
    }
}

// Namespace skill_dive_bomber
// Params 1, eflags: 0x4
// Checksum 0xb9d8b041, Offset: 0x468
// Size: 0x11e
function private apply_stun( bundle )
{
    if ( function_ec3c90adf3f52bfc() > bundle.var_2c1a90bda6a6ae0d )
    {
        thread function_4d5b907516fd4178( bundle );
        stun_data = { #playersstunduration:bundle.var_aea7911dbfca186b, #aistunduration:bundle.var_21ff8bde4c122a79, #var_3a79d2bad66cb960:bundle.var_f7f75f94feaba240, #var_595de568155e6bbf:bundle.var_f7f75f94feaba240, #var_2574d45002fd6e91:bundle.var_20b4daef548ff57d, #var_151ed9464ec398ca:bundle.var_20b4daef548ff57d, #stunradius:bundle.var_20b4daef548ff57d, #stunenemies:bundle.var_27099ed4560ba1b1, #source:#"dive_bomber" };
        thread ob_stun::function_adaba416dfc16839( stun_data );
        
        if ( bundle.var_65b10b09875e38d6 )
        {
            childthread function_182a75ebef6556ec( bundle );
            childthread function_7a325eec7d7e2d17( bundle );
        }
        
        return;
    }
    
    clean_up_effects( bundle );
}

// Namespace skill_dive_bomber
// Params 0, eflags: 0x4
// Checksum 0x8a2f156c, Offset: 0x58e
// Size: 0x64
function private function_ec3c90adf3f52bfc()
{
    forward_vector = anglestoforward( self getplayerangles() );
    eye_pos = self geteye();
    var_416318f04da8f742 = eye_pos - ( 0, 0, 100 );
    raycast_hit = trace::ray_trace( eye_pos, var_416318f04da8f742, self );
    return vectordot( forward_vector, raycast_hit[ "normal" ] * -1 );
}

// Namespace skill_dive_bomber
// Params 1, eflags: 0x4
// Checksum 0x771afbe6, Offset: 0x5fb
// Size: 0x4d
function private function_4d5b907516fd4178( bundle )
{
    self endon( #"death_or_disconnect" );
    
    if ( bundle.var_6bbb8a5adbde7d90 )
    {
        self setscriptablepartstate( bundle.var_6bbb8a5adbde7d90, bundle.var_5f85833f2f10f14a, 0 );
        waitframe();
        clean_up_effects( bundle );
    }
}

// Namespace skill_dive_bomber
// Params 1, eflags: 0x4
// Checksum 0x4e093870, Offset: 0x650
// Size: 0x46
function private clean_up_effects( bundle )
{
    self setscriptablepartstate( bundle.var_6bbb8a5adbde7d90, #"off", 0 );
    
    if ( bundle.var_45ca4472681d9be5 )
    {
        pbgpostfxbundleend( self, bundle.var_45ca4472681d9be5 );
    }
}

// Namespace skill_dive_bomber
// Params 1, eflags: 0x4
// Checksum 0x15ebbd85, Offset: 0x69e
// Size: 0x1a5
function private function_182a75ebef6556ec( bundle )
{
    potential_targets = utility::function_f754506ecfae9afb( self.origin, bundle.var_20b4daef548ff57d, undefined, bundle.var_f7f75f94feaba240 );
    
    foreach ( ent in potential_targets )
    {
        if ( !isalive( ent ) || ent.team == self.team || ent._blackboard.invehicle )
        {
            continue;
        }
        
        if ( ent.type == "zombie" )
        {
            ent dodamage( bundle.var_d3415d72554ff70c, ent.origin, self, self, "MOD_IMPACT", "<explicitweaponnone>", "torso_upper" );
            continue;
        }
        
        if ( ent.type == "human" )
        {
            ent dodamage( bundle.var_b27f0c4931c5a102, ent.origin, self, self, "MOD_IMPACT", "<explicitweaponnone>", "torso_upper" );
            continue;
        }
        
        if ( isplayer( ent ) )
        {
            ent dodamage( bundle.var_9511c23aa2332c4f, ent.origin, self, self, "MOD_IMPACT", "<explicitweaponnone>", "torso_upper" );
        }
    }
}

// Namespace skill_dive_bomber
// Params 1, eflags: 0x4
// Checksum 0x33dbe6b0, Offset: 0x84b
// Size: 0x124
function private function_7a325eec7d7e2d17( bundle )
{
    targets_in_radius = utility::callsharedfunc( #"gamemode", #"hash_c263cfe56b50336d", self.origin, bundle.var_20b4daef548ff57d );
    assert( targets_in_radius, "<dev string:x427>" );
    
    foreach ( target in targets_in_radius )
    {
        if ( isent( target ) )
        {
            target dodamage( bundle.var_44093edf44048868, target.origin, self, self, "MOD_IMPACT", "<explicitweaponnone>", "torso_upper" );
            continue;
        }
        
        if ( target.classname == "scriptable" )
        {
            target scriptabledodamage( bundle.var_44093edf44048868, self, self, undefined, undefined, undefined, "<explicitweaponnone>" );
        }
    }
}

