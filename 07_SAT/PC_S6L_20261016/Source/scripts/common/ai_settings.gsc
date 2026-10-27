// scripts\common\ai_settings.gsc  (hash_6c32b2aeb4eff172.gscc) (size: 3552 Bytes / 0xde0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4200c7ff (1107347455)
// size ...... 3552 (0xde0)
// includes .. 3   (offset: 0xd18)
// strings ... 13  (offset: 0xd30)
// dev strs .. 0   (offset: 0xde0)
// exports ... 3   (offset: 0x9c0)
// cseg ...... 0x127 + 0x899 (0x9c0)
// imports ... 25  (offset: 0xa38)
// animtree1 . 0   (offset: 0xde0)
// animtree2 . 0   (offset: 0xde0)
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\common\values;

#namespace ai_settings;

// Namespace ai_settings
// Params 1
// Checksum 0xab55f1f9, Offset: 0x145
// Size: 0x82c
function init_ai_settings( settings_asset_name )
{
    assert( isdefined( settings_asset_name ) );
    
    if ( !isdefined( level.aisettings_cache[ settings_asset_name ] ) )
    {
        if ( !isdefined( level.aisettings_cache ) )
        {
            level.aisettings_cache = [];
        }
        
        level.aisettings_cache[ settings_asset_name ] = getscriptbundle( hashcat( %"aisettingsbundle:", settings_asset_name ) );
    }
    
    settings = level.aisettings_cache[ settings_asset_name ];
    
    if ( !isdefined( settings ) )
    {
        return;
    }
    
    self.aisettings = settings;
    
    if ( settings.var_91302a889cc8e0b2 != "" )
    {
        self.var_91302a889cc8e0b2 = settings.var_91302a889cc8e0b2;
    }
    
    metabones_list = [];
    
    if ( isdefined( settings.metabones ) )
    {
        metabones_list[ metabones_list.size ] = settings.metabones;
    }
    
    foreach ( entry in settings.metaboneslist )
    {
        if ( isdefined( entry.metabones ) )
        {
            metabones_list[ metabones_list.size ] = entry.metabones;
        }
    }
    
    if ( metabones_list.size )
    {
        metabone::init_metabones( metabones_list );
    }
    
    if ( settings.var_d1a3cff26e5fd54a )
    {
        self.var_b102d7d6e24e96d = settings.perplayerweight;
        self.var_a9921441cd6db952 = settings.var_63986e821c79c9b7;
    }
    
    if ( settings.var_e6a1cc03c16cabd0 )
    {
        self.var_2e57865ec4cd3da7 = settings.var_2e57865ec4cd3da7;
        self.var_348f333165b2482a = settings.var_348f333165b2482a;
        self.var_dfe55fb5c801fc9 = settings.var_dfe55fb5c801fc9;
        self.var_aee78bc2c79fdfe0 = settings.var_aee78bc2c79fdfe0;
        self.var_3348588bc463f01d = settings.var_3348588bc463f01d;
        utility::callsharedfunc( #"ai", #"hash_e8f19689cf2b203d" );
    }
    
    if ( settings.var_4b1ec614a09ec95c )
    {
        self.radius = settings.radius;
        self.height = settings.height;
        self.goalradius = settings.goalradius;
        self.goalheight = settings.goalheight;
        
        if ( isdefined( settings.var_86616f70575d1f55 ) )
        {
            self.var_86616f70575d1f55 = settings.var_86616f70575d1f55;
        }
        
        self setbtgoalradius( 0, self.goalradius );
        self setbtgoalheight( 0, self.goalheight );
        self function_85a1d86f5edfbb78( settings.var_ef1f37fa88990f00 ?? -1 );
    }
    else
    {
        self.radius = 15;
        self.height = 72;
    }
    
    if ( settings.var_924e6881f3624464 )
    {
        self navallowpathinginwater( 1 );
    }
    
    if ( settings.var_c91c4474d5d215b3 )
    {
        self function_92b65f4d4fed5356( 1 );
    }
    else
    {
        self function_92b65f4d4fed5356( 0 );
    }
    
    if ( settings.var_a56c5f7fa12725c4 )
    {
        self function_ec1153a90c91269a( 1 );
    }
    else
    {
        self function_ec1153a90c91269a( 0 );
    }
    
    self setavoidanceradius( self.radius );
    
    if ( isdefined( settings.navlayer ) )
    {
        self setnavlayer( settings.navlayer );
    }
    
    if ( settings.var_2a2f02fb13c80fbb )
    {
        self aisetbounds( settings.boundsradius, settings.boundsheight, settings.var_4699deae2577ed76, settings.var_e594a7f21e383231, settings.boundszoffset );
    }
    
    if ( isdefined( settings.var_aca07a6a341c314b ) )
    {
        self.var_aca07a6a341c314b = settings.var_aca07a6a341c314b;
    }
    
    self.var_60b717a7b3db53f4 = settings.var_60b717a7b3db53f4 ?? 1;
    
    if ( settings.var_e6d1cf40dddeb45d )
    {
        val::set( "ai_settings", "script_pushable_by_ai", 0 );
    }
    
    self.kiastring = settings.kiastring;
    self.firstkillbattlechatter = settings.firstkillbattlechatter;
    
    if ( settings.var_5c3bf3db501a65d )
    {
        self setsightconfigtemplateoverride( settings.sightconfigtemplateoverride );
    }
    
    if ( isdefined( settings.footstepdetectdist ) )
    {
        self.footstepdetectdist = settings.footstepdetectdist;
    }
    
    if ( isdefined( settings.footstepdetectdistwalk ) )
    {
        self.footstepdetectdistwalk = settings.footstepdetectdistwalk;
    }
    
    if ( isdefined( settings.footstepdetectdistsprint ) )
    {
        self.footstepdetectdistsprint = settings.footstepdetectdistsprint;
    }
    
    if ( isdefined( settings.var_bc4a128a02c1e0af ) )
    {
        self.var_fc4e40cf48d9f767 = squared( settings.var_bc4a128a02c1e0af );
    }
    
    if ( settings.disableexecutionvictim )
    {
        val::set( "aiSettings", "execution_victim", 0 );
    }
    
    self.var_237468102345e8f1 = istrue( settings.var_f360106a3a625406 );
    
    if ( true )
    {
        if ( settings.var_19ab1827a2642e10 )
        {
            self function_10006c8216ad87fd( "focus_behaviors", "", settings.var_19ab1827a2642e10 );
        }
        
        if ( settings.var_5bfe96252301eecc )
        {
            self function_10006c8216ad87fd( "focus_behaviors", "fsm", settings.var_5bfe96252301eecc );
        }
        
        if ( settings.var_596905515e289c7a )
        {
            self function_10006c8216ad87fd( "focus_behaviors", "look_state", settings.var_596905515e289c7a );
        }
        
        if ( settings.var_2d173ab4f5f3b320 )
        {
            self function_10006c8216ad87fd( "focus_behaviors", "aim_state", settings.var_2d173ab4f5f3b320 );
        }
        
        if ( settings.lookatspecname )
        {
            self.lookatspecname_default = settings.lookatspecname;
            self.lookatSpecName_current = settings.lookatspecname;
            self function_10006c8216ad87fd( "lookat_spec", "lookatSpecName_default", settings.lookatspecname );
            self function_10006c8216ad87fd( "lookat_spec", "lookatSpecName_current", settings.lookatspecname );
        }
    }
    
    if ( settings.var_baec2475fb9c5b8e )
    {
        dvaroverride = getdvarfloat( @"hash_82918fe00f512e83", -1 );
        lookaheadvalue = settings.lookaheadtime;
        
        if ( dvaroverride >= 0 )
        {
            lookaheadvalue = dvaroverride;
        }
        
        self setavoidancelookaheadtime( lookaheadvalue );
    }
    
    if ( isdefined( self.aisettings.var_c6121f079c3fa62 ) )
    {
        self.aisettings.specificaisettings = getscriptbundle( self.aisettings.var_c6121f079c3fa62 );
    }
    
    self.var_2e7cd1e5b6deabc7 = settings.var_304730efc038700;
    self.var_79f47773e864f120 = settings.var_79f47773e864f120;
    
    if ( settings.var_2726e44ca10e0a06 )
    {
        self.var_2726e44ca10e0a06 = 1;
        self.var_341e9d7ba3a43621 = settings.var_341e9d7ba3a43621;
        
        if ( settings.var_df03542cdd7c5f0b )
        {
            self.var_df03542cdd7c5f0b = 1;
            self.var_49ca5a5de0210e64 = istrue( settings.var_49ca5a5de0210e64 );
            self.var_2cb99c523a534db8 = settings.var_2cb99c523a534db8;
            self.var_6d6b37b571f9093d = settings.var_6d6b37b571f9093d;
            self.var_89c52e4956afcca7 = settings.var_89c52e4956afcca7;
            self.var_8e95bf32f4c1e104 = settings.var_b595172cc2493472;
            
            if ( settings.var_b595172cc2493472 )
            {
                self.var_19ccf83d4cbf7cb7 = settings.var_3c8b415f83dd6a0a;
                self.var_19ccf73d4cbf7a84 = settings.var_3c8b425f83dd6c3d;
                self.var_19ccfa3d4cbf811d = settings.var_3c8b3f5f83dd65a4;
                self.var_19ccf93d4cbf7eea = settings.var_3c8b405f83dd67d7;
            }
        }
    }
    
    thread first_init_ai();
}

// Namespace ai_settings
// Params 0, eflags: 0x4
// Checksum 0xb256106a, Offset: 0x979
// Size: 0x47
function private first_init_ai()
{
    self endon( #"death" );
    waitframe();
    archetype = self getbasearchetype();
    flag_name = archetype + "_init";
    
    if ( utility::flag( flag_name ) )
    {
        return;
    }
    
    utility::flag_set( flag_name );
}

