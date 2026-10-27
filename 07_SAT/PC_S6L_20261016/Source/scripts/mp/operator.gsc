// scripts\mp\operator.gsc  (hash_2dc447b1dd033a26.gscc) (size: 27249 Bytes / 0x6a71 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6cd8e85 (114134661)
// size ...... 27249 (0x6a71)
// includes .. 5   (offset: 0x62ed)
// strings ... 41  (offset: 0x6315)
// dev strs .. 86  (offset: 0x6629)
// exports ... 104 (offset: 0x3e09)
// cseg ...... 0x298 + 0x3b71 (0x3e09)
// imports ... 147 (offset: 0x4e49)
// animtree1 . 0   (offset: 0x6a71)
// animtree2 . 0   (offset: 0x6a71)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\loot;

#namespace operator;

// Namespace operator
// Params 0
// Checksum 0xacdbb363, Offset: 0x2b6
// Size: 0x62
function function_c79f6a12d91ad551()
{
    projectname = getprojectname();
    
    if ( projectname == "T10" || projectname == "WZ2" )
    {
        return getdvarint( @"hash_1fd86bdad9333d2", 0 );
    }
    else if ( level.projectbundle.var_786bc1b37b3f67fa )
    {
        return getdvarint( @"hash_1fd86bdad9333d2", 1 );
    }
    
    return 0;
}

// Namespace operator
// Params 0
// Checksum 0xbbe949b2, Offset: 0x321
// Size: 0x47, Type: bool
function function_fce13d709d67dd26()
{
    projectname = getprojectname();
    
    if ( projectname == "SAT" || projectname == "SAW" )
    {
        return true;
    }
    
    if ( istrue( level.projectbundle.var_8c07d546ce3956d6 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace operator
// Params 0, eflags: 0x4
// Checksum 0xe4eb0dcf, Offset: 0x371
// Size: 0x33, Type: bool
function private isbuildingmap()
{
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515", 0 ) == 1 )
        {
            return true;
        }
        
        if ( getdvarint( @"hash_742caa13b3c2e685" ) == 1 )
        {
            return true;
        }
    #/
    
    return false;
}

/#

    // Namespace operator
    // Params 0, eflags: 0x4
    // Checksum 0x55093fdc, Offset: 0x3ad
    // Size: 0x3b6, Type: dev
    function private function_7412a0b60cad7aec()
    {
        if ( level.var_a2929374d108d239 )
        {
            return;
        }
        
        level.var_a2929374d108d239 = 1;
        profilestart();
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        
        foreach ( operator in level.var_b3fc180d242c4d12 )
        {
            operatorbundle = getoperatorbundle( operator );
            operatorgender = operatorbundle.gender ?? "<dev string:x34>";
            gender = undefined;
            
            switch ( operatorgender )
            {
                case #"hash_5e9616b9548f69b9":
                    gender = "<dev string:x40>";
                    break;
                case #"hash_b411a9fa1c94e739":
                    gender = "<dev string:x5e>";
                    break;
                default:
                    gender = "<dev string:x76>";
                    break;
            }
            
            faction = ( operatorbundle.superfaction ?? "<dev string:x88>" ) == "<dev string:x88>" ? "<dev string:x8d>" : "<dev string:x9f>";
            
            if ( isdefined( level.var_ff43edef64cd11ef[ operator ] ) )
            {
                foreach ( skin in level.var_ff43edef64cd11ef[ operator ] )
                {
                    if ( issubstr( getxhashsourcename( skin ), "<dev string:xb1>" ) )
                    {
                        devgui::add_devgui_command( "<dev string:xb6>" + "<dev string:xbb>" + getxhashsourcename( skin ), "<dev string:xbd>" + getxhashsourcename( skin ) );
                    }
                    
                    project = "<dev string:xd4>";
                    
                    if ( issubstr( tolower( getxhashsourcename( skin ) ), "<dev string:xda>" ) )
                    {
                        project = "<dev string:xdf>";
                    }
                    else if ( issubstr( tolower( getxhashsourcename( skin ) ), "<dev string:xe6>" ) )
                    {
                        project = "<dev string:xea>";
                    }
                    else if ( issubstr( tolower( getxhashsourcename( skin ) ), "<dev string:xf1>" ) )
                    {
                        project = "<dev string:xf5>";
                    }
                    else if ( issubstr( tolower( getxhashsourcename( skin ) ), "<dev string:xfc>" ) )
                    {
                        project = "<dev string:x101>";
                    }
                    else if ( issubstr( tolower( getxhashsourcename( skin ) ), "<dev string:x108>" ) )
                    {
                        project = "<dev string:x10d>";
                    }
                    
                    devgui::add_devgui_command( project + gender + getxhashsourcename( operator ) + "<dev string:xbb>" + getxhashsourcename( skin ), "<dev string:xbd>" + getxhashsourcename( skin ) );
                    devgui::add_devgui_command( project + faction + getxhashsourcename( operator ) + "<dev string:xbb>" + getxhashsourcename( skin ), "<dev string:xbd>" + getxhashsourcename( skin ) );
                }
            }
        }
        
        utility::callsharedfunc( #"bodysize", #"hash_77e79f676746c38d" );
        devgui::add_devgui_command( "<dev string:x114>", "<dev string:x12f>" );
        devgui::add_devgui_command( "<dev string:x14e>", "<dev string:x162>" );
        devgui::add_devgui_command( "<dev string:x181>", "<dev string:x196>" );
        devgui::add_devgui_command( "<dev string:x1b5>", "<dev string:x1d3>" );
        devgui::add_devgui_command( "<dev string:x1f2>", "<dev string:x20e>" );
        devgui::add_devgui_command( "<dev string:x22f>", "<dev string:x246>" );
        devgui::add_devgui_command( "<dev string:x2d4>", "<dev string:x2ec>" );
        devgui::add_devgui_command( "<dev string:x305>", "<dev string:x31d>" );
        devgui::function_77df7fe7dd273e10();
        profilestop();
    }

#/

// Namespace operator
// Params 0
// Checksum 0xbb7e2400, Offset: 0x76b
// Size: 0x52
function function_d846e5ddf3fe819()
{
    if ( level.var_53d46e3fba9849a5 )
    {
        function_b32394f15d245bec();
    }
    
    if ( !level.var_b4c751094ee885a7 )
    {
        if ( getdvarint( @"hash_2e21b938e2994ff5", 0 ) == 0 )
        {
            level.var_53d46e3fba9849a5 = 1;
            function_e5efd24ec4dbf5d9();
            waitframe();
            level.var_53d46e3fba9849a5 = undefined;
        }
    }
}

// Namespace operator
// Params 0, eflags: 0x4
// Checksum 0xdc5b1209, Offset: 0x7c5
// Size: 0x35
function private function_b32394f15d245bec()
{
    var_b0d06f51bf884f15 = 0;
    
    while ( level.var_53d46e3fba9849a5 )
    {
        var_b0d06f51bf884f15++;
        
        if ( var_b0d06f51bf884f15 > 10 )
        {
            level.var_53d46e3fba9849a5 = undefined;
            return;
        }
        
        waitframe();
    }
}

// Namespace operator
// Params 0
// Checksum 0x55bf7535, Offset: 0x802
// Size: 0x9
function function_2a088dd032a61c0a()
{
    function_c0a88ddbad609f58();
}

// Namespace operator
// Params 0, eflags: 0x4
// Checksum 0x199c265d, Offset: 0x813
// Size: 0x17
function private function_c0a88ddbad609f58()
{
    if ( isdefined( level.var_b3fc180d242c4d12 ) )
    {
        return;
    }
    
    function_91b15d3a8ac032c0();
}

// Namespace operator
// Params 0, eflags: 0x4
// Checksum 0x3e39106c, Offset: 0x832
// Size: 0x1cf
function private function_91b15d3a8ac032c0()
{
    level.var_b3fc180d242c4d12 = [];
    
    if ( isbuildingmap() )
    {
        return;
    }
    
    gamemodebundle = level.gamemodebundle;
    
    if ( !isdefined( gamemodebundle.operatorlist ) )
    {
        return;
    }
    
    operatorlistbundle = getoperatorlistscriptbundle( gamemodebundle.operatorlist );
    
    /#
        if ( !isdefined( operatorlistbundle ) )
        {
            println( "<dev string:x336>" + gamemodebundle.operatorlist );
            return;
        }
    #/
    
    operatorlist = operatorlistbundle.operatorlist;
    level.defaultoperator = [];
    level.defaultoperator[ "allies" ] = operatorlistbundle.var_c2b6e3c927c2a5e4;
    level.defaultoperator[ "axis" ] = operatorlistbundle.var_8597bc9b07f488ee;
    
    for ( i = 0; i < operatorlist.size ; i++ )
    {
        operatorref = operatorlist[ i ].operator;
        
        if ( !isdefined( operatorref ) )
        {
            continue;
        }
        
        /#
            operatorbundle = getoperatorscriptbundle( operatorref, #"defaultexecution" );
            
            if ( !isdefined( operatorbundle ) )
            {
                println( "<dev string:x361>" + gamemodebundle.operatorlist + "<dev string:x395>" + getxhashsourcename( operatorref ) );
                continue;
            }
            
            if ( getdvarint( @"hash_fe759d6fbaec1079", 0 ) == 1 )
            {
                assert( isdefined( operatorbundle.defaultexecution ), "<dev string:x398>" + getxhashsourcename( operatorref ) + "<dev string:x3a2>" );
            }
        #/
        
        level.var_b3fc180d242c4d12[ level.var_b3fc180d242c4d12.size ] = operatorref;
    }
    
    level.var_55b857e48f4f0dab[ 0 ] = operatorlistbundle.var_c2b6e3c927c2a5e4;
    level.var_55b857e48f4f0dab[ 1 ] = operatorlistbundle.var_8597bc9b07f488ee;
}

// Namespace operator
// Params 1
// Checksum 0x62b57021, Offset: 0xa09
// Size: 0x7c
function function_449035ab2454100( operatorref )
{
    if ( isbuildingmap() )
    {
        return;
    }
    
    operatorbundle = getoperatorscriptbundle( operatorref, [ #"Skins", #"defaultskin" ] );
    
    /#
        if ( !isdefined( operatorbundle ) )
        {
            println( "<dev string:x40d>" + operatorref );
            return;
        }
    #/
    
    level.var_b3fc180d242c4d12[ level.var_b3fc180d242c4d12.size ] = operatorref;
    function_6c240cb0de0e0db1( operatorref, operatorbundle );
}

// Namespace operator
// Params 0
// Checksum 0x8cc1f884, Offset: 0xa8d
// Size: 0x12
function getoperatorrefs()
{
    function_c0a88ddbad609f58();
    return level.var_b3fc180d242c4d12;
}

// Namespace operator
// Params 1
// Checksum 0xaa202fbd, Offset: 0xaa8
// Size: 0x20
function function_fb3ad5cd3a9ae76b( operatorref )
{
    if ( !operatorref )
    {
        return 0;
    }
    
    return arraycontains( getoperatorrefs(), operatorref );
}

// Namespace operator
// Params 2
// Checksum 0xb79107ae, Offset: 0xad1
// Size: 0x48
function getoperatorbundle( operatorref, var_5c6c42708a3dc0c )
{
    operatorbundle = getoperatorscriptbundle( operatorref, var_5c6c42708a3dc0c );
    
    /#
        if ( !isdefined( operatorbundle ) )
        {
            assertmsg( "<dev string:x433>" + getxhashsourcename( operatorref ) );
        }
    #/
    
    return operatorbundle;
}

// Namespace operator
// Params 1
// Checksum 0xe69ef068, Offset: 0xb22
// Size: 0x41, Type: bool
function getoperatorsuperfaction( operatorref )
{
    operatorbundle = getoperatorbundle( operatorref, #"superfaction" );
    
    if ( operatorbundle.superfaction == "EAST" )
    {
        return true;
    }
    
    return false;
}

// Namespace operator
// Params 2
// Checksum 0x595cb738, Offset: 0xb6c
// Size: 0x8f
function function_bc6d8ad64545fc57( operatorref, operatorSkinRef )
{
    value = undefined;
    skinbundle = getoperatorskinscriptbundle( operatorSkinRef );
    
    if ( skinbundle.var_6ff78a8c39146e65 )
    {
        value = skinbundle.var_83dee9f4a0c1845;
    }
    else
    {
        operatorbundle = getoperatorbundle( operatorref );
        value = operatorbundle.var_83dee9f4a0c1845 ?? #"";
    }
    
    if ( !isxhash( value ) )
    {
        value = getxhash( value );
    }
    
    return value;
}

// Namespace operator
// Params 1
// Checksum 0xcce459b7, Offset: 0xc04
// Size: 0x3f
function function_66a3fbacf1fcad50( operatorref )
{
    operatorbundle = getoperatorbundle( operatorref );
    
    if ( isdefined( operatorbundle.var_32f1671d700d69b6 ) )
    {
        return getscriptbundle( operatorbundle.var_32f1671d700d69b6 );
    }
}

// Namespace operator
// Params 1
// Checksum 0x734fc6cb, Offset: 0xc4c
// Size: 0x3f
function function_82d89269854f2e0f( operatorref )
{
    operatorbundle = getoperatorbundle( operatorref );
    
    if ( isdefined( operatorbundle.var_52e9517775f84ce5 ) )
    {
        return getscriptbundle( operatorbundle.var_52e9517775f84ce5 );
    }
}

// Namespace operator
// Params 1
// Checksum 0xb89a7dd6, Offset: 0xc94
// Size: 0x4e
function getoperatorvoice( operatorref )
{
    operatorbundle = getoperatorbundle( operatorref, [ #"voice" ] );
    
    if ( isdefined( operatorbundle.voice ) )
    {
        return operatorbundle.voice;
    }
    
    return "";
}

// Namespace operator
// Params 1
// Checksum 0xf6e003d0, Offset: 0xceb
// Size: 0x4d
function getoperatorgender( operatorref )
{
    operatorbundle = getoperatorbundle( operatorref, [ #"gender" ] );
    
    if ( operatorbundle.gender == "FEMALE" )
    {
        return "female";
    }
    
    return "male";
}

// Namespace operator
// Params 1
// Checksum 0x4a5f386f, Offset: 0xd41
// Size: 0x4e
function function_db4f41253b282a4f( operatorref )
{
    operatorbundle = getoperatorbundle( operatorref, [ #"defaultexecution" ] );
    
    if ( isdefined( operatorbundle.defaultexecution ) )
    {
        return operatorbundle.defaultexecution;
    }
    
    return "";
}

// Namespace operator
// Params 1
// Checksum 0x88fb199f, Offset: 0xd98
// Size: 0x4e
function function_d5a18e550f529e2c( operatorref )
{
    operatorbundle = getoperatorbundle( operatorref, [ #"defaultquip" ] );
    
    if ( isdefined( operatorbundle.defaultquip ) )
    {
        return operatorbundle.defaultquip;
    }
    
    return "";
}

// Namespace operator
// Params 1
// Checksum 0xf1054869, Offset: 0xdef
// Size: 0x2c, Type: bool
function isoperatorunlocked( operatorref )
{
    return getoperatorbundle( operatorref, #"hash_1aad59b5bb5eb9fe" ).var_ffaa6b376f7925ff ?? 1;
}

// Namespace operator
// Params 1
// Checksum 0xd49df290, Offset: 0xe24
// Size: 0x56
function function_2b34573c920ee585( operatorref )
{
    operatorbundle = getoperatorbundle( operatorref, #"botinvalid" );
    
    if ( isdefined( operatorbundle ) )
    {
        if ( isdefined( operatorbundle.botinvalid ) )
        {
            return !operatorbundle.botinvalid;
        }
        else
        {
            return 1;
        }
        
        return;
    }
    
    return 0;
}

// Namespace operator
// Params 1
// Checksum 0x2373b08, Offset: 0xe82
// Size: 0x4e
function function_d0589f3304fb58da( operatorref )
{
    operatorbundle = getoperatorbundle( operatorref, [ #"botgroup" ] );
    
    if ( isdefined( operatorbundle.botgroup ) )
    {
        return operatorbundle.botgroup;
    }
    
    return "";
}

// Namespace operator
// Params 1
// Checksum 0x84d15aa5, Offset: 0xed9
// Size: 0x55
function getoperatorteambyref( operatorref )
{
    operatorbundle = getoperatorbundle( operatorref );
    team = ( operatorbundle.superfaction ?? "WEST" ) == "WEST" ? "allies" : "axis";
    return team;
}

// Namespace operator
// Params 1
// Checksum 0x32c18ae2, Offset: 0xf37
// Size: 0x4a
function function_f3a3ee0b2758d139( operatorref )
{
    operatorbundle = getoperatorbundle( operatorref, [ #"lootid" ] );
    
    if ( isdefined( operatorbundle.lootid ) )
    {
        return operatorbundle.lootid;
    }
    
    return 0;
}

// Namespace operator
// Params 1
// Checksum 0x9bd3535a, Offset: 0xf8a
// Size: 0x3d, Type: bool
function function_ba9b1d7b8bbd957e( operatorref )
{
    operatorbundle = getoperatorbundle( operatorref, [ #"overridedefaultsuit" ] );
    return operatorbundle.overridedefaultsuit ?? 0;
}

// Namespace operator
// Params 1
// Checksum 0xecbf3120, Offset: 0xfd0
// Size: 0x41, Type: bool
function function_a47e3481b8d81aa7( operatorref )
{
    operatorbundle = getoperatorbundle( operatorref, [ #"suit" ] );
    return operatorbundle.suit ?? "";
}

// Namespace operator
// Params 0
// Checksum 0x830e0bea, Offset: 0x101a
// Size: 0xd
function function_1e97ddc0ff6d0c40()
{
    return level.var_55b857e48f4f0dab[ 0 ];
}

// Namespace operator
// Params 0
// Checksum 0xd3f40b0a, Offset: 0x1030
// Size: 0xe
function function_8d28c3fcfc8cc4a2()
{
    return level.var_55b857e48f4f0dab[ 1 ];
}

// Namespace operator
// Params 1
// Checksum 0x83f9febf, Offset: 0x1047
// Size: 0x25
function function_297589994c9a9eff( superfactionindex )
{
    if ( superfactionindex == 1 )
    {
        return function_8d28c3fcfc8cc4a2();
    }
    
    return function_1e97ddc0ff6d0c40();
}

// Namespace operator
// Params 0, eflags: 0x4
// Checksum 0xf2afb903, Offset: 0x1074
// Size: 0x17
function private function_e5efd24ec4dbf5d9()
{
    if ( isdefined( level.var_b4c751094ee885a7 ) )
    {
        return;
    }
    
    function_84302cb6ff5837f();
}

// Namespace operator
// Params 0, eflags: 0x4
// Checksum 0xba1a67a7, Offset: 0x1093
// Size: 0x31b
function private function_84302cb6ff5837f()
{
    function_c0a88ddbad609f58();
    level.var_aea805ad236a525f = [];
    level.var_b4c751094ee885a7 = [];
    level.var_ff43edef64cd11ef = [];
    level.var_7c09484f1926c102 = [];
    level.var_212650972ad1a958 = [];
    
    if ( isbuildingmap() )
    {
        return;
    }
    
    foreach ( operatorref in level.var_b3fc180d242c4d12 )
    {
        operatorbundle = getoperatorbundle( operatorref, [ #"Skins", #"defaultskin" ] );
        
        if ( !isdefined( operatorbundle ) )
        {
            continue;
        }
        
        foreach ( skinentry in operatorbundle.skins )
        {
            skinref = skinentry.skin;
            
            if ( !isdefined( skinref ) || skinref == %"" )
            {
                continue;
            }
            
            var_6739a9c997eec5c5 = getoperatorskinscriptbundle( skinref, #"hash_ac7fd2c9c6408186" ).var_6739a9c997eec5c5;
            level.var_aea805ad236a525f[ level.var_aea805ad236a525f.size ] = skinref;
            level.var_b4c751094ee885a7[ skinref ] = operatorref;
            
            if ( function_35303b94875f6d5b( var_6739a9c997eec5c5 ) )
            {
                level.var_212650972ad1a958[ getoperatorskinscriptbundle( skinref, #"lootid" ).lootid ] = var_6739a9c997eec5c5;
            }
            
            if ( !isdefined( level.var_ff43edef64cd11ef[ operatorref ] ) )
            {
                level.var_ff43edef64cd11ef[ operatorref ] = [];
            }
            
            level.var_ff43edef64cd11ef[ operatorref ][ level.var_ff43edef64cd11ef[ operatorref ].size ] = skinref;
        }
        
        assert( isdefined( level.var_ff43edef64cd11ef[ operatorref ] ), "<dev string:x450>" + getxhashsourcename( operatorref ) + "<dev string:x45b>" );
        
        if ( isdefined( operatorbundle.defaultskin ) )
        {
            skinref = operatorbundle.defaultskin;
            skinbundle = getoperatorskinscriptbundle( skinref, [ #"hash_ac7fd2c9c6408186", #"lootid" ] );
            
            if ( isdefined( skinbundle ) )
            {
                level.var_7c09484f1926c102[ operatorref ] = skinref;
                
                if ( function_35303b94875f6d5b( skinbundle.var_6739a9c997eec5c5 ) )
                {
                    level.var_212650972ad1a958[ skinbundle.lootid ] = skinbundle.var_6739a9c997eec5c5;
                }
                
                continue;
            }
            
            assertmsg( "<dev string:x398>" + getxhashsourcename( operatorref ) + "<dev string:x47b>" );
        }
    }
    
    /#
        function_7412a0b60cad7aec();
    #/
}

// Namespace operator
// Params 2, eflags: 0x4
// Checksum 0xba31f746, Offset: 0x13b6
// Size: 0x21d
function private function_6c240cb0de0e0db1( operatorref, operatorbundle )
{
    if ( isbuildingmap() )
    {
        return;
    }
    
    assert( isdefined( level.var_b4c751094ee885a7 ) );
    
    foreach ( skinentry in operatorbundle.skins )
    {
        skinref = skinentry.skin;
        
        if ( !isdefined( skinref ) || skinref == %"" )
        {
            continue;
        }
        
        var_6739a9c997eec5c5 = getoperatorskinscriptbundle( skinref, #"hash_ac7fd2c9c6408186" ).var_6739a9c997eec5c5;
        level.var_aea805ad236a525f[ level.var_aea805ad236a525f.size ] = skinref;
        level.var_b4c751094ee885a7[ skinref ] = operatorref;
        
        if ( function_35303b94875f6d5b( var_6739a9c997eec5c5 ) )
        {
            level.var_212650972ad1a958[ getoperatorskinscriptbundle( skinref, #"lootid" ).lootid ] = var_6739a9c997eec5c5;
        }
        
        if ( !isdefined( level.var_ff43edef64cd11ef[ operatorref ] ) )
        {
            level.var_ff43edef64cd11ef[ operatorref ] = [];
        }
        
        level.var_ff43edef64cd11ef[ operatorref ][ level.var_ff43edef64cd11ef[ operatorref ].size ] = skinref;
    }
    
    if ( isdefined( operatorbundle.defaultskin ) )
    {
        skinbundle = getoperatorskinscriptbundle( operatorbundle.defaultskin, [ #"hash_ac7fd2c9c6408186", #"lootid" ] );
        skinref = operatorbundle.defaultskin;
        
        if ( isdefined( skinbundle ) )
        {
            level.var_7c09484f1926c102[ operatorref ] = skinref;
            
            if ( function_35303b94875f6d5b( skinbundle.var_6739a9c997eec5c5 ) )
            {
                level.var_212650972ad1a958[ skinbundle.lootid ] = skinbundle.var_6739a9c997eec5c5;
            }
        }
    }
}

// Namespace operator
// Params 1
// Checksum 0xb27b8be2, Offset: 0x15db
// Size: 0x6a, Type: bool
function function_10ad0df66b5a20a7( skinlootid )
{
    if ( !skinlootid || loot::function_52cf8374c44a4ff5( skinlootid ) != "operator_skin" )
    {
        return false;
    }
    
    operatorSkinRef = loot::function_f54ecb89dfab8e8c( skinlootid );
    operatorref = function_30f20ce375c4ee40( operatorSkinRef );
    return arraycontains( getoperatorrefs(), operatorref ) && arraycontains( function_98bc5ea0c0c97599( operatorref ), operatorSkinRef );
}

// Namespace operator
// Params 1
// Checksum 0x80ff96c8, Offset: 0x164e
// Size: 0x39
function function_447fce2531e40d0e( operatorref )
{
    function_e5efd24ec4dbf5d9();
    
    if ( isdefined( level.var_7c09484f1926c102[ operatorref ] ) )
    {
        return level.var_7c09484f1926c102[ operatorref ];
    }
    
    return %"";
}

// Namespace operator
// Params 1
// Checksum 0xc064bb9f, Offset: 0x1690
// Size: 0x23, Type: bool
function function_98bc5ea0c0c97599( operatorref )
{
    function_e5efd24ec4dbf5d9();
    return level.var_ff43edef64cd11ef[ operatorref ] ?? [];
}

// Namespace operator
// Params 0
// Checksum 0xf5294c8, Offset: 0x16bc
// Size: 0x12
function function_27f5412663e0a09()
{
    function_e5efd24ec4dbf5d9();
    return level.var_aea805ad236a525f;
}

// Namespace operator
// Params 1
// Checksum 0x7c7b1131, Offset: 0x16d7
// Size: 0xaa
function function_de170b6ef0100e22( operatorname )
{
    if ( isstring( operatorname ) )
    {
        operatorname = getxhashasset( operatorname );
    }
    
    if ( isdefined( level.var_b4c751094ee885a7[ operatorname ] ) )
    {
        return operatorname;
    }
    
    foreach ( var_d2205cd4623841a3, operator in level.var_b4c751094ee885a7 )
    {
        if ( operator == operatorname )
        {
            return var_d2205cd4623841a3;
        }
    }
}

// Namespace operator
// Params 1
// Checksum 0x8421fa65, Offset: 0x178a
// Size: 0x58
function function_30f20ce375c4ee40( skinref )
{
    function_e5efd24ec4dbf5d9();
    
    if ( isstring( skinref ) )
    {
        skinref = getxhashasset( skinref );
    }
    
    /#
        if ( !isdefined( level.var_b4c751094ee885a7[ skinref ] ) )
        {
            assertmsg( "<dev string:x4d0>" + getxhashsourcename( skinref ) );
        }
    #/
    
    return level.var_b4c751094ee885a7[ skinref ];
}

// Namespace operator
// Params 2
// Checksum 0x465f1665, Offset: 0x17eb
// Size: 0x48
function function_d1e10cddb12fbe17( skinref, var_5c6c42708a3dc0c )
{
    skinbundle = getoperatorskinscriptbundle( skinref, var_5c6c42708a3dc0c );
    
    /#
        if ( !isdefined( skinbundle ) )
        {
            assertmsg( "<dev string:x4f4>" + getxhashsourcename( skinref ) );
        }
    #/
    
    return skinbundle;
}

// Namespace operator
// Params 1
// Checksum 0xd489edc2, Offset: 0x183c
// Size: 0x27
function function_115f78fb5f506daa( skinref )
{
    return function_d1e10cddb12fbe17( skinref, #"headmodel" ).headmodel;
}

// Namespace operator
// Params 1
// Checksum 0xe69995a8, Offset: 0x186c
// Size: 0x27
function function_4e6b11f7340acc24( skinref )
{
    return function_d1e10cddb12fbe17( skinref, #"bodymodel" ).bodymodel;
}

// Namespace operator
// Params 1
// Checksum 0x389eac04, Offset: 0x189c
// Size: 0x27
function function_50896d2b645d13c2( skinref )
{
    return function_d1e10cddb12fbe17( skinref, #"hash_c608451914de1770" ).var_872d17c7eb1da015;
}

// Namespace operator
// Params 1
// Checksum 0xa949a5f1, Offset: 0x18cc
// Size: 0x84
function function_fb2ad6ca3c6b708d( skinref )
{
    models = [];
    skinbundle = function_d1e10cddb12fbe17( skinref, [ #"bodymodel", #"headmodel", #"hash_c608451914de1770" ] );
    models[ 0 ] = skinbundle.bodymodel;
    models[ 1 ] = skinbundle.headmodel;
    models[ 2 ] = skinbundle.var_872d17c7eb1da015;
    return models;
}

// Namespace operator
// Params 1
// Checksum 0x5850fb0c, Offset: 0x1959
// Size: 0x33, Type: bool
function function_5c6e83213643805( skinref )
{
    return function_d1e10cddb12fbe17( skinref, #"nvgmodeldown" ).nvgmodeldown ?? %"";
}

// Namespace operator
// Params 1
// Checksum 0xb6d16892, Offset: 0x1995
// Size: 0x33, Type: bool
function function_4dcee1262a4ab410( skinref )
{
    return function_d1e10cddb12fbe17( skinref, #"nvgmodelup" ).nvgmodelup ?? %"";
}

// Namespace operator
// Params 1
// Checksum 0x4b553990, Offset: 0x19d1
// Size: 0x2c, Type: bool
function function_faa5d37f28e6d925( skinref )
{
    return function_d1e10cddb12fbe17( skinref, #"canequip" ).canequip ?? 1;
}

// Namespace operator
// Params 1
// Checksum 0x29722d20, Offset: 0x1a06
// Size: 0x56
function function_6261fa1bcd3ce668( skinref )
{
    skinbundle = function_d1e10cddb12fbe17( skinref, #"botinvalid" );
    
    if ( isdefined( skinbundle ) )
    {
        if ( isdefined( skinbundle.botinvalid ) )
        {
            return !skinbundle.botinvalid;
        }
        else
        {
            return 1;
        }
        
        return;
    }
    
    return 0;
}

// Namespace operator
// Params 1
// Checksum 0x19a418ce, Offset: 0x1a64
// Size: 0x2f, Type: bool
function function_82781d300aee973e( skinref )
{
    return function_d1e10cddb12fbe17( skinref, #"lootimage" ).lootimage ?? "";
}

// Namespace operator
// Params 1
// Checksum 0x6a54c13a, Offset: 0x1a9c
// Size: 0x2f, Type: bool
function function_b1788ccf1b3c0ae9( skinref )
{
    return function_d1e10cddb12fbe17( skinref, #"sfxclothtype" ).sfxclothtype ?? "";
}

// Namespace operator
// Params 1
// Checksum 0x3c2b9d92, Offset: 0x1ad4
// Size: 0x2f, Type: bool
function function_d633420b529828e8( skinref )
{
    return function_d1e10cddb12fbe17( skinref, #"sfxgeartype" ).sfxgeartype ?? "";
}

// Namespace operator
// Params 1
// Checksum 0x31c41d77, Offset: 0x1b0c
// Size: 0x2f, Type: bool
function function_5f1afd050db1579b( skinref )
{
    return function_d1e10cddb12fbe17( skinref, #"hash_e5cac6afd35e1f45" ).var_a61af6bf6ea49f06 ?? "";
}

// Namespace operator
// Params 1
// Checksum 0xf046bdbf, Offset: 0x1b44
// Size: 0x2b, Type: bool
function function_c203df33ce95f84c( skinref )
{
    return function_d1e10cddb12fbe17( skinref, #"lootid" ).lootid ?? 0;
}

// Namespace operator
// Params 1
// Checksum 0x5bb55a6e, Offset: 0x1b78
// Size: 0x2c
function getreactiveoperator( skinref )
{
    return function_d1e10cddb12fbe17( skinref, [ #"reactiveoperator" ] ).reactiveoperator;
}

// Namespace operator
// Params 1
// Checksum 0x11c30dba, Offset: 0x1bad
// Size: 0x2c
function function_bb4618718e086740( skinref )
{
    return function_d1e10cddb12fbe17( skinref, [ #"hash_b74126130fe1bde8" ] ).var_ba5ef8ce1f6a6aa3;
}

// Namespace operator
// Params 1
// Checksum 0xa19b3ee1, Offset: 0x1be2
// Size: 0x2c
function function_4c7f17b5ae87e7be( skinref )
{
    return function_d1e10cddb12fbe17( skinref, [ #"hash_a30796472eab0efe" ] ).var_1a6762affce6e181;
}

// Namespace operator
// Params 1
// Checksum 0xd30b6a00, Offset: 0x1c17
// Size: 0x2c
function function_4c23b4a4c457f40b( skinref )
{
    return function_d1e10cddb12fbe17( skinref, [ #"hash_babfddf124746871" ] ).var_ce1ec4a85f852e14;
}

// Namespace operator
// Params 1
// Checksum 0x8ac5fe6, Offset: 0x1c4c
// Size: 0x2c
function function_233474e80ffd30( skinref )
{
    return function_d1e10cddb12fbe17( skinref, [ #"hash_321fae418d44abbc" ] ).var_430f23d923c86ba3;
}

// Namespace operator
// Params 1
// Checksum 0x29e67464, Offset: 0x1c81
// Size: 0x2c
function function_5b6aad02fe43f871( skinref )
{
    return function_d1e10cddb12fbe17( skinref, [ #"hash_3f979bdff8dd6b0d" ] ).var_5f51bf7f6da09282;
}

// Namespace operator
// Params 1
// Checksum 0xdc6a66f2, Offset: 0x1cb6
// Size: 0xf9, Type: bool
function function_35303b94875f6d5b( var_e1488ff65b74a26c )
{
    if ( !isdefined( var_e1488ff65b74a26c ) || var_e1488ff65b74a26c == #"" )
    {
        return false;
    }
    
    assert( isxhash( var_e1488ff65b74a26c ) );
    
    if ( !isdefined( level.var_c769fc53a092c8b4 ) )
    {
        var_f2961c59221ccf42 = strtok( getdvar( @"hash_888c1a8e6ebb7178", "" ), "," );
        level.var_c769fc53a092c8b4 = [];
        
        foreach ( skinset in var_f2961c59221ccf42 )
        {
            level.var_c769fc53a092c8b4[ getxhash( skinset ) ] = 1;
        }
    }
    
    return isdefined( level.var_c769fc53a092c8b4[ var_e1488ff65b74a26c ] );
}

// Namespace operator
// Params 1
// Checksum 0x39f92b6a, Offset: 0x1db8
// Size: 0x30
function function_647772866281c051( lootid )
{
    function_e5efd24ec4dbf5d9();
    
    if ( isdefined( level.var_212650972ad1a958[ lootid ] ) )
    {
        return level.var_212650972ad1a958[ lootid ];
    }
}

// Namespace operator
// Params 0, eflags: 0x4
// Checksum 0xf285ae, Offset: 0x1df1
// Size: 0x1ad
function private function_e0f57a7fe250f216()
{
    if ( isdefined( level.var_ba16f6b55c830dd7 ) )
    {
        return;
    }
    
    level.var_ba16f6b55c830dd7 = [];
    level.var_e671d0cb401c31b4 = [];
    
    if ( isbuildingmap() )
    {
        return;
    }
    
    gamemodebundle = level.gamemodebundle;
    
    if ( !isdefined( gamemodebundle.execution_list ) )
    {
        return;
    }
    
    var_a16dfa195494bfb0 = getscriptbundle( gamemodebundle.execution_list );
    
    /#
        if ( !isdefined( var_a16dfa195494bfb0 ) )
        {
            println( "<dev string:x516>" + gamemodebundle.execution_list + "<dev string:x543>" + getgamemodescriptbundlename() );
            return;
        }
    #/
    
    executionlist = var_a16dfa195494bfb0.operatorexecutionlist;
    
    for ( i = 0; i < executionlist.size ; i++ )
    {
        if ( !isdefined( executionlist[ i ].operatorexecution ) )
        {
            continue;
        }
        
        executionbundle = getscriptbundlefieldvalues( hashcat( %"hash_3c0bcccfd8362f86", executionlist[ i ].operatorexecution ), [ #"lootid", #"execution", #"propweapon" ] );
        executionref = executionlist[ i ].operatorexecution;
        
        /#
            if ( !isdefined( executionbundle ) )
            {
                println( "<dev string:x558>" + gamemodebundle.execution_list + "<dev string:x395>" + executionlist[ i ].operatorexecution );
                continue;
            }
        #/
        
        level.var_ba16f6b55c830dd7[ executionref ] = executionbundle;
        level.var_e671d0cb401c31b4[ level.var_e671d0cb401c31b4.size ] = executionref;
    }
    
    /#
        thread function_29c210cb172c28cd();
    #/
}

/#

    // Namespace operator
    // Params 0
    // Checksum 0x9a96612b, Offset: 0x1fa6
    // Size: 0x152, Type: dev
    function function_29c210cb172c28cd()
    {
        executionlist = level.var_e671d0cb401c31b4;
        
        if ( !isdefined( executionlist ) )
        {
            return;
        }
        
        var_c79bbf2abcfeda81 = "<dev string:x58d>";
        executionindex = 0;
        
        while ( executionindex < executionlist.size )
        {
            var_bf47b09d265d6617 = executionlist[ executionindex ];
            
            if ( issubstr( tolower( getxhashsourcename( var_bf47b09d265d6617 ) ), "<dev string:x5aa>" ) )
            {
                devgui::function_9082edeb5db93280( var_c79bbf2abcfeda81 + "<dev string:x5ae>" );
            }
            else if ( issubstr( tolower( getxhashsourcename( var_bf47b09d265d6617 ) ), "<dev string:xe6>" ) )
            {
                devgui::function_9082edeb5db93280( var_c79bbf2abcfeda81 + "<dev string:x5b3>" );
            }
            else if ( issubstr( tolower( getxhashsourcename( var_bf47b09d265d6617 ) ), "<dev string:xf1>" ) )
            {
                devgui::function_9082edeb5db93280( var_c79bbf2abcfeda81 + "<dev string:x5b8>" );
            }
            else if ( issubstr( tolower( getxhashsourcename( var_bf47b09d265d6617 ) ), "<dev string:x5bd>" ) )
            {
                devgui::function_9082edeb5db93280( var_c79bbf2abcfeda81 + "<dev string:x5c1>" );
            }
            else if ( issubstr( tolower( getxhashsourcename( var_bf47b09d265d6617 ) ), "<dev string:x5c6>" ) )
            {
                devgui::function_9082edeb5db93280( var_c79bbf2abcfeda81 + "<dev string:x5ca>" );
            }
            else
            {
                devgui::function_9082edeb5db93280( var_c79bbf2abcfeda81 + "<dev string:x5cf>" );
            }
            
            devgui::add_devgui_command( var_bf47b09d265d6617, "<dev string:x5d5>" + var_bf47b09d265d6617 );
            devgui::function_77df7fe7dd273e10();
            executionindex++;
            
            if ( executionindex % 20 == 0 )
            {
                waitframe();
            }
        }
    }

#/

// Namespace operator
// Params 1, eflags: 0x4
// Checksum 0x9b891058, Offset: 0x2100
// Size: 0x3c
function private getexecutionbundle( executionref )
{
    function_e0f57a7fe250f216();
    assert( isdefined( level.var_ba16f6b55c830dd7[ executionref ] ), "<dev string:x5ec>" + executionref );
    return level.var_ba16f6b55c830dd7[ executionref ];
}

// Namespace operator
// Params 1, eflags: 0x4
// Checksum 0x2af494ba, Offset: 0x2145
// Size: 0x32, Type: bool
function private isexecutionvalid( executionref )
{
    if ( executionref )
    {
        return ( utility::callsharedfunc( #"execution", #"validate", executionref ) ?? 1 );
    }
    
    return false;
}

// Namespace operator
// Params 0, eflags: 0x4
// Checksum 0xc1fc9b1c, Offset: 0x2180
// Size: 0x9
function private function_10f49a11ea83fafe()
{
    return getexecutionref( 0 );
}

// Namespace operator
// Params 0
// Checksum 0x10a3a226, Offset: 0x2192
// Size: 0x12
function getexecutionrefs()
{
    function_e0f57a7fe250f216();
    return level.var_e671d0cb401c31b4;
}

// Namespace operator
// Params 1
// Checksum 0x593b528a, Offset: 0x21ad
// Size: 0x3c
function getexecutionref( executionid )
{
    function_e0f57a7fe250f216();
    assert( isdefined( level.var_e671d0cb401c31b4[ executionid ] ), "<dev string:x613>" + executionid );
    return level.var_e671d0cb401c31b4[ executionid ];
}

// Namespace operator
// Params 1
// Checksum 0xd212ebcf, Offset: 0x21f2
// Size: 0x43
function getexecutionid( executionref )
{
    function_e0f57a7fe250f216();
    executionid = function_f02c63b99c9614c9( level.var_e671d0cb401c31b4, executionref );
    assert( isdefined( executionid ), "<dev string:x63b>" + executionref );
    return executionid;
}

// Namespace operator
// Params 1
// Checksum 0x28d8c03, Offset: 0x223e
// Size: 0x34
function getexecutionlootid( executionref )
{
    var_7237854e3be197ca = getexecutionbundle( executionref ).lootid;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return 0;
}

// Namespace operator
// Params 1
// Checksum 0xf83f2a71, Offset: 0x227b
// Size: 0x38
function getexecutiondata( executionref )
{
    var_7237854e3be197ca = getexecutionbundle( executionref ).execution;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return "none";
}

// Namespace operator
// Params 1
// Checksum 0x4c004da4, Offset: 0x22bc
// Size: 0x38
function getexecutionweapon( executionref )
{
    var_7237854e3be197ca = getexecutionbundle( executionref ).propweapon;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return "none";
}

// Namespace operator
// Params 0
// Checksum 0x5a1d29bc, Offset: 0x22fd
// Size: 0x137
function getoperatorcustomization()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.operatorcustomization ) )
    {
        createoperatorcustomization();
    }
    
    operatorSkinRef = self.operatorcustomization.skinref;
    self.bodymodelname = self.operatorcustomization.body;
    self.backuphead = self.operatorcustomization.head;
    models = function_fb2ad6ca3c6b708d( operatorSkinRef );
    
    if ( models[ 0 ] == "" || models[ 1 ] == "" || models[ 2 ] == "" )
    {
        assertmsg( "<dev string:x664>" + getxhashsourcename( operatorSkinRef ) + "<dev string:x6b9>" + getxhashsourcename( models[ 1 ] ) + "<dev string:x6c4>" + getxhashsourcename( models[ 0 ] ) + "<dev string:x6cf>" + getxhashsourcename( models[ 2 ] ) );
        defaultskin = function_447fce2531e40d0e( self.operatorcustomization.operatorref );
        models = function_fb2ad6ca3c6b708d( defaultskin );
    }
    
    self.bodymodelname = models[ 0 ];
    self.backuphead = models[ 1 ];
    return models;
}

/#

    // Namespace operator
    // Params 0
    // Checksum 0x36a1fa08, Offset: 0x243d
    // Size: 0x11b, Type: dev
    function function_1b0168a1d34b37ab()
    {
        debugdata = [];
        debugdata[ "<dev string:x6e0>" ] = 0;
        var_19dac495352462f2 = getdvar( @"hash_17a1591e3fe7c036" );
        
        if ( var_19dac495352462f2 )
        {
            var_1d6c368bd4334 = strtok( var_19dac495352462f2, "<dev string:x6e9>" );
            operatorskin = getxhashasset( var_1d6c368bd4334[ randomint( var_1d6c368bd4334.size ) ] );
            debugdata[ "<dev string:x6eb>" ] = function_30f20ce375c4ee40( operatorskin );
            debugdata[ "<dev string:x6f7>" ] = operatorskin;
            debugdata[ "<dev string:x6e0>" ] = 1;
            return debugdata;
        }
        else if ( getdvarint( @"hash_18d61f3fa39645ac", 0 ) && isdefined( level.gamemodebundle.var_e8fe08e7fc3b1dd8 ) )
        {
            skinlist = level.gamemodebundle.var_e8fe08e7fc3b1dd8;
            
            if ( skinlist.size > 0 )
            {
                operatorskin = getxhashasset( skinlist[ randomint( skinlist.size ) ].skin );
                debugdata[ "<dev string:x6eb>" ] = function_30f20ce375c4ee40( operatorskin );
                debugdata[ "<dev string:x6f7>" ] = operatorskin;
                debugdata[ "<dev string:x6e0>" ] = 1;
            }
        }
        
        return debugdata;
    }

#/

// Namespace operator
// Params 2
// Checksum 0x4d92e20f, Offset: 0x2560
// Size: 0x41a
function createoperatorcustomization( operatorref, operatorskin )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isbuildingmap() )
    {
        return;
    }
    
    self function_16332a7775f10aa9();
    self.operatorcustomization = undefined;
    operatorcustomization = spawnstruct();
    superfactionindex = self.team == "allies" ? 0 : 1;
    
    /#
        debugdata = function_1b0168a1d34b37ab();
        
        if ( debugdata[ "<dev string:x6e0>" ] )
        {
            operatorref = debugdata[ "<dev string:x6eb>" ];
            operatorskin = debugdata[ "<dev string:x6f7>" ];
        }
    #/
    
    if ( !( isdefined( operatorref ) && isdefined( operatorskin ) ) )
    {
        operatorref = getoperatorref();
        operatorskin = function_cc5d60d5178c5007();
    }
    
    var_3349ff2ffef57c34 = istrue( getdvarint( @"scr_loadout_validate_banned_items", 0 ) );
    
    if ( var_3349ff2ffef57c34 && loot::isitembannedbyref( operatorskin ) )
    {
        operatorskin = function_447fce2531e40d0e( operatorref );
    }
    
    if ( var_3349ff2ffef57c34 && loot::isitembannedbyref( operatorref ) )
    {
        operatorref = function_297589994c9a9eff( superfactionindex );
        operatorskin = function_447fce2531e40d0e( operatorref );
    }
    
    operatorcustomization.operatorref = operatorref;
    operatorcustomization.skinref = operatorskin;
    operatorcustomization.reactiveoperator = getreactiveoperator( operatorskin );
    operatorcustomization.skinlootid = function_c203df33ce95f84c( operatorskin );
    operatorcustomization.gender = getoperatorgender( operatorref );
    operatorcustomization.voice = getoperatorvoice( operatorref );
    operatorcustomization.clothtype = function_b1788ccf1b3c0ae9( operatorskin );
    operatorcustomization.geartype = function_d633420b529828e8( operatorskin );
    operatorcustomization.superfaction = getoperatorsuperfaction( operatorref );
    operatorcustomization.execution = function_4308bc9472e8e835( operatorref );
    operatorcustomization.parachute = function_e6885d5990982272();
    operatorcustomization.contrail = function_4202dbfeb87e9ddb();
    operatorcustomization.dialogset = function_bc6d8ad64545fc57( operatorref, operatorskin );
    
    if ( utility::issharedfuncdefined( #"bodysize", #"hash_db91c8d9ee604746" ) )
    {
        operatorcustomization.suit = utility::callsharedfunc( #"bodysize", #"hash_db91c8d9ee604746", operatorref );
    }
    else
    {
        operatorcustomization.suit = utility::function_f825237e0eda5adf();
    }
    
    operatorcustomization.rebuild = 0;
    operatormodels = function_fb2ad6ca3c6b708d( operatorskin );
    body = operatormodels[ 0 ];
    head = operatormodels[ 1 ];
    viewmodelname = operatormodels[ 2 ];
    
    if ( !isagent( self ) )
    {
        function_44f7d464da13e4f6( operatorref, operatorskin );
        var_64f5ced297bdc4b2 = self getcustomizationbody();
        var_8c4f0085579e243c = self getcustomizationhead();
        var_c6037c5a4e7cc205 = self getcustomizationviewmodel();
    }
    
    if ( body == "" || head == "" )
    {
        assertmsg( "<dev string:x704>" + getxhashsourcename( operatorskin ) + "<dev string:x72f>" + getxhashsourcename( head ) + "<dev string:x739>" + getxhashsourcename( body ) );
        body = var_64f5ced297bdc4b2;
        head = var_8c4f0085579e243c;
        viewmodelname = var_c6037c5a4e7cc205;
    }
    
    operatorcustomization.body = body;
    operatorcustomization.defaultbody = var_64f5ced297bdc4b2;
    operatorcustomization.head = head;
    operatorcustomization.defaulthead = var_8c4f0085579e243c;
    operatorcustomization.vm = viewmodelname;
    operatorcustomization.defaultvm = var_c6037c5a4e7cc205;
    
    if ( !level.projectbundle.var_672cd1b066200001 )
    {
        operatorcustomization.chroma = function_54b61a935e8d6ed2();
        self setoperatorchroma( operatorcustomization.chroma );
    }
    
    self.operatorcustomization = operatorcustomization;
    
    if ( isplayer( self ) && !isbot( self ) && !isdefined( self.vehiclecustomization ) )
    {
        self.vehiclecustomization = vehicle::create_customization();
    }
    
    function_d94a89bd1eb20033( self.operatorcustomization );
    callback::callback( #"hash_1c82c96d0d334fcc" );
}

// Namespace operator
// Params 1, eflags: 0x4
// Checksum 0x73b395e1, Offset: 0x2982
// Size: 0xe3
function private function_d94a89bd1eb20033( operatorcustomization )
{
    var_d275275b9c49f288 = getdvarint( @"hash_838359d5ebdcc7e0", 0 );
    
    if ( var_d275275b9c49f288 == 0 )
    {
        return;
    }
    
    var_e0ab867b479dae36 = getdvarint( @"hash_b77bb859108e69cd", 0 );
    var_94e77c4dc77013b7 = getdvarint( @"hash_91b801ddfb57ae8a", 0 );
    
    if ( !level.rankedmatch || !level.matchmakingmatch || !level.onlinestatsenabled )
    {
        return;
    }
    
    var_8a9fe7aa2cde3afe = [];
    
    if ( var_e0ab867b479dae36 == 1 )
    {
        var_8a9fe7aa2cde3afe[ var_8a9fe7aa2cde3afe.size ] = self.operatorcustomization.skinlootid;
    }
    
    if ( var_94e77c4dc77013b7 == 1 )
    {
        var_8a9fe7aa2cde3afe[ var_8a9fe7aa2cde3afe.size ] = loot::getlootidfromref( self.operatorcustomization.execution );
    }
    
    self function_49bdd1291f4756ca( var_8a9fe7aa2cde3afe );
}

// Namespace operator
// Params 2
// Checksum 0x5648ab34, Offset: 0x2a6d
// Size: 0x44
function function_44f7d464da13e4f6( operator, skin )
{
    if ( !self function_41d9b8754a37a071( skin ) )
    {
        assertmsg( "<dev string:x743>" + getxhashsourcename( skin ) + "<dev string:x749>" );
        return;
    }
    
    self setoperatorcustomization( operator, skin );
}

// Namespace operator
// Params 0
// Checksum 0x79e0bfa7, Offset: 0x2ab9
// Size: 0x3a7
function function_99f3495eb915fb96()
{
    if ( isdefined( level.var_77fb663123a79288 ) )
    {
        return;
    }
    
    level.var_77fb663123a79288 = [];
    setdvar( @"hash_2b669ad6c3e1d864", 1 );
    
    if ( !isdefined( level.var_77fb663123a79288[ "allies" ] ) )
    {
        level.var_77fb663123a79288[ "allies" ] = [];
    }
    
    if ( !isdefined( level.var_77fb663123a79288[ "axis" ] ) )
    {
        level.var_77fb663123a79288[ "axis" ] = [];
    }
    
    operatorrefs = getoperatorrefs();
    var_c14f2aed1868e9bc = getdvarint( @"hash_88e9180e81267df2", 0 );
    
    foreach ( operatorref in operatorrefs )
    {
        if ( !isdefined( operatorref ) || operatorref == %"" )
        {
            continue;
        }
        
        unlocked = isoperatorunlocked( operatorref );
        
        if ( !unlocked && !var_c14f2aed1868e9bc )
        {
            continue;
        }
        
        if ( !function_2b34573c920ee585( operatorref ) && !var_c14f2aed1868e9bc )
        {
            continue;
        }
        
        superfaction = getoperatorsuperfaction( operatorref );
        team = superfaction == 0 ? "allies" : "axis";
        level.var_77fb663123a79288[ team ][ operatorref ] = [];
    }
    
    skinRefs = function_27f5412663e0a09();
    
    foreach ( skinref in skinRefs )
    {
        if ( !skinref )
        {
            continue;
        }
        
        if ( !function_faa5d37f28e6d925( skinref ) )
        {
            continue;
        }
        
        if ( !function_6261fa1bcd3ce668( skinref ) )
        {
            continue;
        }
        
        operatorref = function_30f20ce375c4ee40( skinref );
        superfaction = getoperatorsuperfaction( operatorref );
        team = superfaction == 0 ? "allies" : "axis";
        
        if ( !level.var_77fb663123a79288[ team ][ operatorref ] )
        {
            continue;
        }
        
        level.var_77fb663123a79288[ team ][ operatorref ][ level.var_77fb663123a79288[ team ][ operatorref ].size ] = skinref;
    }
    
    teams = [];
    teams = [ "allies", "axis" ];
    
    foreach ( team in teams )
    {
        newarray = [];
        
        foreach ( key, entry in level.var_77fb663123a79288[ team ] )
        {
            if ( entry.size > 0 )
            {
                newarray[ key ] = entry;
            }
        }
        
        level.var_77fb663123a79288[ team ] = newarray;
    }
}

// Namespace operator
// Params 0
// Checksum 0xee38fc17, Offset: 0x2e68
// Size: 0x5d, Type: bool
function function_4d6b18d1d4da29bd()
{
    if ( level.multiteambased || !level.teambased )
    {
        return true;
    }
    
    if ( isdefined( level.gametypebundle ) )
    {
        if ( level.gametypebundle.teambased == 1 )
        {
            return ( level.gametypebundle.var_4b6318add901104c == 1 );
        }
    }
    
    return false;
}

// Namespace operator
// Params 0
// Checksum 0x21513ee8, Offset: 0x2ece
// Size: 0x70
function getsuperfactionindex()
{
    assert( isplayer( self ) );
    superfactionindex = self.team == "allies" ? 0 : 1;
    
    if ( function_4d6b18d1d4da29bd() && !level.projectbundle.var_786bc1b37b3f67fa )
    {
        superfactionindex = self getplayerdata( level.loadoutsgroup, "customizations", "selectedFaction" );
    }
    
    return superfactionindex;
}

// Namespace operator
// Params 1
// Checksum 0x7712ba3f, Offset: 0x2f47
// Size: 0xec
function function_ce41b4b58036e41c( superfactionindex )
{
    assert( isdefined( self ) );
    assert( isplayer( self ) );
    assert( superfactionindex == 0 || superfactionindex == 1 );
    operatorlootid = 0;
    
    if ( function_fce13d709d67dd26() )
    {
        operatorref = self getplayerdata( level.loadoutsgroup, "customizations", "operators", superfactionindex, "operatorRef" );
        operatorlootid = loot::getlootidfromref( operatorref );
    }
    else if ( function_c79f6a12d91ad551() )
    {
        operatorlootid = self getplayerdata( level.loadoutsgroup, "customizationSetup", "selectedOperator", superfactionindex, "operatorLootId" );
    }
    else
    {
        operatorref = self getplayerdata( level.loadoutsgroup, "customizationSetup", "operators", superfactionindex );
        operatorlootid = loot::getlootidfromref( operatorref );
    }
    
    if ( loot::function_52cf8374c44a4ff5( operatorlootid ) == "operator" )
    {
        return operatorlootid;
    }
    
    return 0;
}

// Namespace operator
// Params 1
// Checksum 0xc7284f1e, Offset: 0x303c
// Size: 0xdb
function function_dc48b1d8163a5d60( superfactionindex )
{
    assert( isdefined( self ) );
    assert( isplayer( self ) );
    assert( superfactionindex == 0 || superfactionindex == 1 );
    defaultoperatorteam = function_1e32019139bf7206();
    
    if ( getdvarint( @"hash_9377281fd8d98b6e", 0 ) == 1 || self.pers[ "forceDefaultLoadouts" ] )
    {
        return level.defaultoperator[ defaultoperatorteam ];
    }
    
    operatorlootid = function_ce41b4b58036e41c( superfactionindex );
    
    if ( operatorlootid != 0 )
    {
        ref = loot::function_f54ecb89dfab8e8c( operatorlootid );
        
        if ( isdefined( ref ) )
        {
            operatorref = getxhashasset( ref );
        }
    }
    
    if ( !function_fb3ad5cd3a9ae76b( operatorref ) )
    {
        operatorref = level.defaultoperator[ defaultoperatorteam ];
    }
    
    return operatorref;
}

// Namespace operator
// Params 1
// Checksum 0x18e37b48, Offset: 0x3120
// Size: 0xdf
function function_c1fab062550f72fa( superfaction )
{
    assert( isai( self ) || self isplayerheadless() );
    team = self.team;
    
    if ( isdefined( superfaction ) )
    {
        team = superfaction == 0 ? "allies" : "axis";
    }
    else
    {
        assert( isdefined( team ) );
    }
    
    if ( !isdefined( level.var_77fb663123a79288[ team ] ) && !isdefined( self.pers[ "botCustomizationTeamChosen" ] ) )
    {
        var_1bfdfe698f07f365 = getarraykeys( level.var_77fb663123a79288 );
        self.pers[ "botCustomizationTeamChosen" ] = utility::array_random( var_1bfdfe698f07f365 );
    }
    
    if ( isdefined( self.pers[ "botCustomizationTeamChosen" ] ) )
    {
        return self.pers[ "botCustomizationTeamChosen" ];
    }
    
    return team;
}

// Namespace operator
// Params 1
// Checksum 0x342799e7, Offset: 0x3207
// Size: 0x27b
function function_88393e18041634ac( superfaction )
{
    assert( isai( self ) || self isplayerheadless() );
    function_99f3495eb915fb96();
    botoperatorteam = function_c1fab062550f72fa( superfaction );
    
    if ( !isdefined( self.botoperatorref[ botoperatorteam ] ) )
    {
        var_6e8217c1a6d26f54 = getdvar( @"hash_803cefdbe23f6bfe", "" );
        var_8e142dbf8e355048 = getdvar( @"hash_536fb96e928e1c53", "" );
        
        if ( var_6e8217c1a6d26f54 != "" )
        {
            var_1d6c368bd4334 = strtok( var_6e8217c1a6d26f54, "," );
            var_a011809dacf9838f = getxhashasset( var_1d6c368bd4334[ randomint( var_1d6c368bd4334.size ) ] );
            var_2006406403e406f8 = function_30f20ce375c4ee40( var_a011809dacf9838f );
            
            if ( function_fb3ad5cd3a9ae76b( var_2006406403e406f8 ) )
            {
                self.botoperatorref[ botoperatorteam ] = var_2006406403e406f8;
                self.var_75716214ae82e2ab[ botoperatorteam ] = var_a011809dacf9838f;
            }
        }
        else if ( var_8e142dbf8e355048 != "" )
        {
            assert( level.botloadouts );
            assert( level.botloadouts.overrideskins.size > 0 );
            skinoverride = utility::array_random( level.botloadouts.overrideskins );
            var_a011809dacf9838f = getxhashasset( skinoverride );
            var_2006406403e406f8 = function_30f20ce375c4ee40( var_a011809dacf9838f );
            
            if ( function_fb3ad5cd3a9ae76b( var_2006406403e406f8 ) )
            {
                self.botoperatorref[ botoperatorteam ] = var_2006406403e406f8;
                self.var_75716214ae82e2ab[ botoperatorteam ] = var_a011809dacf9838f;
            }
        }
    }
    
    if ( !isdefined( self.botoperatorref[ botoperatorteam ] ) )
    {
        var_b13b94bfa08527fc = randomint( level.var_77fb663123a79288[ botoperatorteam ].size );
        currentindex = 0;
        
        foreach ( operatorkey, skinarray in level.var_77fb663123a79288[ botoperatorteam ] )
        {
            if ( currentindex == var_b13b94bfa08527fc )
            {
                logstring( "[BOTS] Bot [" + self.name + "] picked operator: " + operatorkey );
                self.botoperatorref[ botoperatorteam ] = operatorkey;
                break;
            }
            
            currentindex++;
        }
    }
    
    return self.botoperatorref[ botoperatorteam ];
}

// Namespace operator
// Params 0
// Checksum 0x154bdcbe, Offset: 0x348b
// Size: 0x2a
function function_1e32019139bf7206()
{
    superfactionindex = getsuperfactionindex();
    
    if ( superfactionindex == 0 )
    {
        return "allies";
    }
    
    return "axis";
}

// Namespace operator
// Params 1
// Checksum 0x4133e6eb, Offset: 0x34bd
// Size: 0xb2
function getoperatorref( superfaction )
{
    if ( !isplayer( self ) && !isai( self ) )
    {
        assert( 0, "<dev string:x755>" );
        return "";
    }
    
    if ( isdefined( self.operatorcustomization ) && isdefined( self.operatorcustomization.operatorref ) )
    {
        return self.operatorcustomization.operatorref;
    }
    
    operatorref = undefined;
    
    if ( isai( self ) || self isplayerheadless() )
    {
        return function_88393e18041634ac( superfaction );
    }
    else
    {
        superfactionindex = getsuperfactionindex();
        operatorref = function_dc48b1d8163a5d60( superfactionindex );
    }
    
    return operatorref;
}

// Namespace operator
// Params 1, eflags: 0x4
// Checksum 0x3ce5d6d1, Offset: 0x3578
// Size: 0x123
function private function_4c56ad6bdf59f32d( superfaction )
{
    assert( isdefined( self ) );
    assert( isplayer( self ) );
    assert( superfaction == 0 || superfaction == 1 );
    
    if ( self.pers[ "forceDefaultLoadouts" ] )
    {
        return 0;
    }
    
    operatorskinlootid = 0;
    
    if ( function_fce13d709d67dd26() )
    {
        operatorSkinRef = self getplayerdata( level.loadoutsgroup, "customizations", "operators", superfaction, "skinRef" );
        operatorskinlootid = loot::getlootidfromref( operatorSkinRef );
    }
    else if ( function_c79f6a12d91ad551() )
    {
        operatorskinlootid = self getplayerdata( level.loadoutsgroup, "customizationSetup", "selectedOperator", superfaction, "skinLootId" );
    }
    else
    {
        operatorref = function_dc48b1d8163a5d60( superfaction );
        
        if ( operatorref && function_fb3ad5cd3a9ae76b( operatorref ) )
        {
            operatorSkinRef = self getplayerdata( level.loadoutsgroup, "customizationSetup", "operatorCustomization", operatorref, "skin" );
            operatorskinlootid = loot::getlootidfromref( operatorSkinRef );
        }
    }
    
    if ( !function_10ad0df66b5a20a7( operatorskinlootid ) )
    {
        return 0;
    }
    
    return operatorskinlootid;
}

// Namespace operator
// Params 1
// Checksum 0xb5281f08, Offset: 0x36a4
// Size: 0xb1
function function_33d682bc951e8992( superfaction )
{
    operatorref = function_88393e18041634ac( superfaction );
    botoperatorteam = function_c1fab062550f72fa( superfaction );
    
    if ( !isdefined( self.var_75716214ae82e2ab[ botoperatorteam ] ) )
    {
        randomindex = randomint( level.var_77fb663123a79288[ botoperatorteam ][ operatorref ].size );
        skinchosen = level.var_77fb663123a79288[ botoperatorteam ][ operatorref ][ randomindex ];
        logstring( "[BOTS] Bot [" + self.name + "] picked skin: " + skinchosen );
        self.var_75716214ae82e2ab[ botoperatorteam ] = skinchosen;
    }
    
    return self.var_75716214ae82e2ab[ botoperatorteam ];
}

// Namespace operator
// Params 1
// Checksum 0x922b408f, Offset: 0x375e
// Size: 0xe9
function function_cc5d60d5178c5007( superfaction )
{
    assert( isplayer( self ) );
    
    if ( !isplayer( self ) )
    {
        return "";
    }
    
    if ( isdefined( self.operatorcustomization.skinref ) )
    {
        return self.operatorcustomization.skinref;
    }
    
    skinref = "";
    
    if ( isbot( self ) || self isplayerheadless() )
    {
        return function_33d682bc951e8992( superfaction );
    }
    
    superfaction = getsuperfactionindex();
    operatorskinlootid = function_4c56ad6bdf59f32d( superfaction );
    lootref = loot::function_f54ecb89dfab8e8c( operatorskinlootid );
    
    if ( lootref )
    {
        skinref = getxhashasset( lootref );
    }
    
    if ( !isdefined( skinref ) || skinref == %"" )
    {
        operatorref = getoperatorref();
        return function_447fce2531e40d0e( operatorref );
    }
    
    return skinref;
}

// Namespace operator
// Params 0
// Checksum 0xfa6ce77a, Offset: 0x3850
// Size: 0x9
function function_d24f366ea9117af1()
{
    return function_cc5d60d5178c5007( 0 );
}

// Namespace operator
// Params 0
// Checksum 0x119799e5, Offset: 0x3862
// Size: 0xa
function function_ef2efa78a5ae293f()
{
    return function_cc5d60d5178c5007( 1 );
}

// Namespace operator
// Params 2, eflags: 0x4
// Checksum 0xd19f321a, Offset: 0x3875
// Size: 0x11b
function private function_11ab18dc0f9b6e54( superfactionindex, operatorref )
{
    assert( isdefined( self ) );
    assert( isplayer( self ) );
    
    if ( self.pers[ "forceDefaultLoadouts" ] )
    {
        return 0;
    }
    
    if ( !isdefined( superfactionindex ) )
    {
        superfactionindex = getsuperfactionindex();
    }
    
    if ( function_fce13d709d67dd26() )
    {
        executionref = self getplayerdata( level.loadoutsgroup, "customizations", "operators", superfactionindex, "executionRef" );
        executionlootid = loot::getlootidfromref( executionref );
    }
    else if ( function_c79f6a12d91ad551() )
    {
        executionlootid = self getplayerdata( level.loadoutsgroup, "customizationSetup", "selectedOperator", superfactionindex, "executionLootId" );
    }
    else
    {
        if ( !isdefined( operatorref ) )
        {
            operatorref = function_dc48b1d8163a5d60( superfactionindex );
        }
        
        if ( operatorref && function_fb3ad5cd3a9ae76b( operatorref ) )
        {
            executionlootid = self getplayerdata( level.loadoutsgroup, "customizationSetup", "operatorCustomization", operatorref, "execution" );
        }
    }
    
    if ( loot::function_52cf8374c44a4ff5( executionlootid ) != "executions" )
    {
        return 0;
    }
    
    return executionlootid;
}

// Namespace operator
// Params 1
// Checksum 0x68d26d7, Offset: 0x3999
// Size: 0x130
function function_4308bc9472e8e835( operatorref )
{
    assert( isplayer( self ) );
    
    if ( !isplayer( self ) )
    {
        return "";
    }
    
    if ( !isdefined( operatorref ) )
    {
        operatorref = getoperatorref();
    }
    
    executionlootid = 0;
    
    if ( !isagent( self ) )
    {
        executionlootid = utility::callsharedfunc( #"instanceInventory", #"getActiveOperatorExecutionLootID", self ) ?? 0;
        
        if ( executionlootid == 0 )
        {
            executionlootid = function_11ab18dc0f9b6e54( undefined, operatorref );
        }
    }
    
    if ( isdefined( executionlootid ) && executionlootid != 0 )
    {
        var_795640b75d113220 = loot::function_f54ecb89dfab8e8c( executionlootid );
        
        if ( isexecutionvalid( var_795640b75d113220 ) )
        {
            return var_795640b75d113220;
        }
        
        /#
            if ( var_795640b75d113220 )
            {
                assertmsg( "<dev string:x785>" + var_795640b75d113220 + "<dev string:x7ab>" );
            }
        #/
    }
    
    var_83d21bf52ce92f15 = getdvar( @"hash_57210a2c6c50497b" );
    
    if ( isexecutionvalid( var_83d21bf52ce92f15 ) )
    {
        return var_83d21bf52ce92f15;
    }
    
    var_b9390f534fcde91c = function_db4f41253b282a4f( operatorref );
    
    if ( isexecutionvalid( var_b9390f534fcde91c ) )
    {
        return var_b9390f534fcde91c;
    }
    
    var_3e9e7a054da76197 = function_10f49a11ea83fafe();
    
    if ( isexecutionvalid( var_3e9e7a054da76197 ) )
    {
        return var_3e9e7a054da76197;
    }
    
    return "";
}

// Namespace operator
// Params 0
// Checksum 0x825c6f7a, Offset: 0x3ad2
// Size: 0x71
function function_54b61a935e8d6ed2()
{
    if ( !isagent( self ) )
    {
        if ( function_c79f6a12d91ad551() )
        {
            return getxhashasset( "none" );
        }
        else
        {
            operatorref = getoperatorref();
            
            if ( !self hasplayerdata() )
            {
                return getxhashasset( "none" );
            }
            
            chromalootid = self getplayerdata( level.loadoutsgroup, "customizationSetup", "operatorCustomization", operatorref, "chroma" );
        }
    }
    
    return chromalootid;
}

// Namespace operator
// Params 0
// Checksum 0x29013696, Offset: 0x3b4c
// Size: 0x20
function function_f88d52fd5e48c60a()
{
    var_805ecfacf843aea7 = function_54b61a935e8d6ed2();
    return getxhashasset( loot::function_f54ecb89dfab8e8c( var_805ecfacf843aea7 ) );
}

// Namespace operator
// Params 0
// Checksum 0x60448007, Offset: 0x3b75
// Size: 0x41
function function_e6885d5990982272()
{
    parachutelootid = self getplayerdata( "common", "commonCustomization", "parachute" );
    parachuteref = loot::function_f54ecb89dfab8e8c( parachutelootid );
    
    if ( !parachuteref )
    {
        return;
    }
    
    return getxhashasset( parachuteref );
}

// Namespace operator
// Params 0
// Checksum 0xc07ab047, Offset: 0x3bbf
// Size: 0x41
function function_4202dbfeb87e9ddb()
{
    contraillootid = self getplayerdata( "common", "commonCustomization", "contrail" );
    contrailref = loot::function_f54ecb89dfab8e8c( contraillootid );
    
    if ( !contrailref )
    {
        return;
    }
    
    return getxhashasset( contrailref );
}

// Namespace operator
// Params 0
// Checksum 0x72128823, Offset: 0x3c09
// Size: 0xab
function function_b518cf4ab4b71ede()
{
    /#
        if ( getdvarint( @"hash_4753586a2ac8718f", 0 ) == 0 )
        {
            println( "<dev string:x7e4>" + "<dev string:x820>" );
            return;
        }
    #/
    
    headsize = 1;
    head = self.operatorcustomization.head;
    var_5b99f965fcb3c896 = head[ head.size - 1 ];
    
    switch ( var_5b99f965fcb3c896 )
    {
        case #"hash_31103fbc01bd840c":
            headsize = 1;
            break;
        case #"hash_311042bc01bd88c5":
            headsize = 2;
            break;
        case #"hash_311041bc01bd8732":
            headsize = 3;
            break;
    }
    
    return headsize;
}

// Namespace operator
// Params 0
// Checksum 0x1c9f328e, Offset: 0x3cbd
// Size: 0x29, Type: bool
function isfemale()
{
    return isdefined( self.operatorcustomization ) && self.operatorcustomization.gender == "female";
}

// Namespace operator
// Params 0, eflags: 0x4
// Checksum 0xeb8ef699, Offset: 0x3cef
// Size: 0xf6
function private function_17f449ac974622de()
{
    result = "";
    
    if ( isdefined( self.operatorcustomization.operatorref ) )
    {
        operatorbundle = getoperatorbundle( self.operatorcustomization.operatorref, [ #"gendersoundcontext" ] );
        result = operatorbundle.gendersoundcontext ?? result;
    }
    
    if ( isdefined( self.operatorcustomization.skinref ) )
    {
        skinbundle = function_d1e10cddb12fbe17( self.operatorcustomization.skinref, [ #"hash_b05b686f13e4736e", #"gendersoundcontext" ] );
        
        if ( skinbundle.var_866e482772f02fe1 )
        {
            result = skinbundle.gendersoundcontext ?? result;
        }
    }
    
    if ( result == "male" )
    {
        result = "";
    }
    
    return result;
}

// Namespace operator
// Params 0
// Checksum 0xcbd06106, Offset: 0x3dee
// Size: 0x9
function setgendersoundcontext()
{
    self setwearinggasmask( 0 );
}

// Namespace operator
// Params 0
// Checksum 0x59845767, Offset: 0x3dff
// Size: 0xa
function function_89e5e91ee0fb0836()
{
    self setwearinggasmask( 1 );
}

