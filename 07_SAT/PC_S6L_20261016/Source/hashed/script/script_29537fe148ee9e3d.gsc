// script_29537fe148ee9e3d  (hash_29537fe148ee9e3d.gscc) (size: 7843 Bytes / 0x1ea3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x791394c (126957900)
// size ...... 7843 (0x1ea3)
// includes .. 2   (offset: 0x1d23)
// strings ... 20  (offset: 0x1d33)
// dev strs .. 1   (offset: 0x1e97)
// exports ... 20  (offset: 0x131b)
// cseg ...... 0x2a8 + 0x1073 (0x131b)
// imports ... 56  (offset: 0x163b)
// animtree1 . 0   (offset: 0x1ea3)
// animtree2 . 0   (offset: 0x1ea3)
#using script_53651341190c5aab;
#using scripts\common\utility;

#namespace ai_lkp;

// Namespace ai_lkp
// Params 1
// Checksum 0x97e87ce3, Offset: 0x2c6
// Size: 0x134
function getfunction( funcid )
{
    switch ( funcid )
    {
        case #"hash_dab0d83df51da4d":
            return &onuserinit;
        case #"hash_722d767fd6d40f56":
            return &onuserterminate;
        case #"hash_8a6929c703898e78":
            return &setupmeetuppositions;
        case #"hash_3830c02ed29b9bd":
            return &reachedprimary;
        case #"hash_2a3b81fd59207935":
            return &setwatcherstoidle;
        case #"hash_1d9348daf6d1a5c7":
            return &callaceasefire;
        case #"hash_b3cada4cba95eb5d":
            return &setgoalposlkp;
        case #"hash_4f54865eea297354":
            return &reachedlkp;
        case #"hash_561e0f0540b7f727":
            return &setuppositionsnearlkp;
        case #"hash_dca2cd774e93c43b":
            return &reachedlkprandom;
        case #"hash_cb9a60b9c8cfca45":
            return &waitforlkpanimfinished;
        case #"hash_cc3a03d50cb74f10":
            return &function_43ddb2a71129b731;
        case #"hash_49987181712dbfd5":
            return &setstationary;
        case #"hash_303d74db152a39b9":
            return &interaction_common::function_ac09dd92b7250c46;
        case #"hash_2bb757aa70fc12dd":
            return &cleargoal;
    }
    
    assertmsg( "<dev string:x24>" + funcid );
}

// Namespace ai_lkp
// Params 1
// Checksum 0xd473c035, Offset: 0x402
// Size: 0x2a4
function onuserinit( interactionid )
{
    if ( !isdefined( level.bseqinstancedata ) )
    {
        level.bseqinstancedata = [];
    }
    
    if ( !isdefined( level.bseqinstancedata[ interactionid ] ) )
    {
        level.bseqinstancedata[ interactionid ] = spawnstruct();
        level.bseqinstancedata[ interactionid ].var_66d5e5b005680ad1 = 0;
        level.bseqinstancedata[ interactionid ].var_719f77a34e64d6f5 = [];
    }
    
    if ( !isdefined( self.bseqinstancedata ) )
    {
        self.bseqinstancedata = spawnstruct();
        self.bseqinstancedata.var_5c3ecab4e65b2277 = 0;
    }
    
    self.var_a3a61cb7891f3136 = 1;
    self.bdisablereacquire = 1;
    self reacquireclear();
    self setcanusecover( 0, "bseq" );
    self.bseqinstancedata.speed = self aigetdesiredspeed();
    self aisetdesiredspeed( 120 );
    self setbtgoalstationary( 1 );
    self setbtgoalradius( 1, 20 );
    level.bseqinstancedata[ interactionid ].var_719f77a34e64d6f5[ level.bseqinstancedata[ interactionid ].var_719f77a34e64d6f5.size ] = self.origin;
    self.bseqinstancedata.allowedstances = [];
    self.bseqinstancedata.numallowedstances = 0;
    
    if ( self function_2b441168b3089ca4( "stand" ) )
    {
        self.bseqinstancedata.allowedstances[ self.bseqinstancedata.numallowedstances ] = "stand";
        self.bseqinstancedata.numallowedstances += 1;
    }
    
    if ( self function_2b441168b3089ca4( "crouch" ) )
    {
        self.bseqinstancedata.allowedstances[ self.bseqinstancedata.numallowedstances ] = "crouch";
        self.bseqinstancedata.numallowedstances += 1;
    }
    
    if ( self function_2b441168b3089ca4( "prone" ) )
    {
        self.bseqinstancedata.allowedstances[ self.bseqinstancedata.numallowedstances ] = "prone";
        self.bseqinstancedata.numallowedstances += 1;
    }
    
    self allowedstances( "stand" );
    self notify( #"hash_49376c9c96485a34" );
}

// Namespace ai_lkp
// Params 1
// Checksum 0xfbe413e0, Offset: 0x6ae
// Size: 0x197
function onuserterminate( interactionid )
{
    self clearbtgoal( 1 );
    self aiclearscriptdesiredspeed();
    self setcanusecover( 1, "bseq" );
    function_dd518df9ee8d217c( interactionid, "lkpanimtype", "none" );
    self stoplookat();
    self.bdisablereacquire = 0;
    self.var_a3a61cb7891f3136 = 0;
    
    if ( self.bseqinstancedata.numallowedstances == 3 )
    {
        self allowedstances( self.bseqinstancedata.allowedstances[ 0 ], self.bseqinstancedata.allowedstances[ 1 ], self.bseqinstancedata.allowedstances[ 2 ] );
    }
    else if ( self.bseqinstancedata.numallowedstances == 2 )
    {
        self allowedstances( self.bseqinstancedata.allowedstances[ 0 ], self.bseqinstancedata.allowedstances[ 1 ] );
    }
    else if ( self.bseqinstancedata.numallowedstances == 1 )
    {
        self allowedstances( self.bseqinstancedata.allowedstances[ 0 ] );
    }
    
    if ( !isalive( self ) )
    {
        function_dd518df9ee8d217c( interactionid, "death", 1 );
    }
    
    self.bseqinstancedata = undefined;
    primaryinvestigator = function_dd66b33f5942bdfb( "primary_investigator", interactionid );
    
    if ( !isdefined( primaryinvestigator ) || primaryinvestigator == self )
    {
        level.bseqinstancedata[ interactionid ] = undefined;
    }
    
    self notify( #"hash_d5f3c1418fb4abb" );
}

// Namespace ai_lkp
// Params 2
// Checksum 0x65412b74, Offset: 0x84d
// Size: 0x87
function setupmeetuppositions( statename, params )
{
    primaryinvestigator = function_dd66b33f5942bdfb( "primary_investigator" );
    primaryinvestigator endon( #"death" );
    primaryinvestigator endon( #"hash_d5f3c1418fb4abb" );
    id = self getinteractionid();
    backupinvestigators = function_b8df72c609a7a6f7( "backup_investigator" );
    primaryinvestigatorpos = primaryinvestigator.origin;
    return function_ab171e929e5d17c7( primaryinvestigatorpos );
}

// Namespace ai_lkp
// Params 2
// Checksum 0xd0c0438d, Offset: 0x8dd
// Size: 0xc4
function reachedprimary( statename, params )
{
    primaryinvestigator = function_dd66b33f5942bdfb( "primary_investigator" );
    primaryinvestigator endon( #"death" );
    primaryinvestigator endon( #"hash_d5f3c1418fb4abb" );
    id = self getinteractionid();
    backupinvestigators = function_b8df72c609a7a6f7( "backup_investigator" );
    level.bseqinstancedata[ id ].var_66d5e5b005680ad1++;
    
    if ( level.bseqinstancedata[ id ].var_66d5e5b005680ad1 >= backupinvestigators.size )
    {
        function_dd518df9ee8d217c( id, "move_complete_initial", 1 );
        level.bseqinstancedata[ id ].var_66d5e5b005680ad1 = 0;
    }
}

// Namespace ai_lkp
// Params 2
// Checksum 0x52d3ddd7, Offset: 0x9a9
// Size: 0x99
function setwatcherstoidle( statename, params )
{
    primaryinvestigator = function_dd66b33f5942bdfb( "primary_investigator" );
    primaryinvestigator endon( #"death" );
    primaryinvestigator endon( #"hash_d5f3c1418fb4abb" );
    id = self getinteractionid();
    self setbtgoalstationary( 1 );
    lastknownposition = function_521b5a0a07a246a8( id, "last_known_position" );
    self setlookat( lastknownposition + ( 0, 0, 63 ) );
    function_dd518df9ee8d217c( id, "lkpanimtype", "idle" );
}

// Namespace ai_lkp
// Params 2
// Checksum 0xdf1038ea, Offset: 0xa4a
// Size: 0x18e
function callaceasefire( statename, params )
{
    self endon( #"hash_d5f3c1418fb4abb" );
    self endon( #"death" );
    wait 0.2;
    id = self getinteractionid();
    nummembers = function_521b5a0a07a246a8( id, "num_members" );
    
    if ( isdefined( level.bseqinstancedata[ id ] ) && isdefined( level.bseqinstancedata[ id ].var_719f77a34e64d6f5 ) )
    {
        level.bseqinstancedata[ id ].var_719f77a34e64d6f5[ level.bseqinstancedata[ id ].var_719f77a34e64d6f5.size ] = self.origin;
        lastknownposition = function_521b5a0a07a246a8( id, "last_known_position" );
        level.bseqinstancedata[ id ].var_719f77a34e64d6f5[ level.bseqinstancedata[ id ].var_719f77a34e64d6f5.size ] = lastknownposition;
        var_fc8799351f124a26 = function_b8df72c609a7a6f7( "backup_investigator" );
        numwatchers = function_b8df72c609a7a6f7( "RestOfThem" );
        function_dd518df9ee8d217c( id, "num_backup_members", var_fc8799351f124a26.size );
        nummembers = var_fc8799351f124a26.size + numwatchers.size;
        function_dd518df9ee8d217c( id, "num_members", nummembers );
        
        if ( nummembers > 1 )
        {
            function_dd518df9ee8d217c( id, "lkpanimtype", "cease_fire" );
            self.var_c441720c90bf9002 = 1;
            addbattlechatternotify( self, self.enemy, "last_known_position", "cease_fire", 0 );
        }
    }
}

// Namespace ai_lkp
// Params 0
// Checksum 0xf4e55ed, Offset: 0xbe0
// Size: 0x75
function function_530db05278f25c67()
{
    searchvolume = undefined;
    
    if ( isdefined( level.stealth ) && isdefined( self.stealth ) && isdefined( level.stealth.combat_volumes[ self.script_stealthgroup ] ) )
    {
        searchvolume = level.stealth.combat_volumes[ self.script_stealthgroup ];
    }
    else
    {
        searchvolume = self getgoalvolume();
    }
    
    return searchvolume;
}

// Namespace ai_lkp
// Params 2
// Checksum 0x463af8cd, Offset: 0xc5e
// Size: 0x16e
function setgoalposlkp( statename, params )
{
    id = self getinteractionid();
    lastknownposition = function_521b5a0a07a246a8( id, "last_known_position" );
    newgoalpos = undefined;
    cignoreradius = 64;
    self setlookat( lastknownposition + ( 0, 0, 63 ) );
    function_dd518df9ee8d217c( id, "lkpanimtype", "none" );
    searchvolume = function_530db05278f25c67();
    
    if ( isdefined( searchvolume ) )
    {
        newgoalpos = findclosestlospointwithinvolume( searchvolume, lastknownposition + ( 0, 0, 63 ), lastknownposition, level.bseqinstancedata[ id ].var_719f77a34e64d6f5, 0 );
        
        if ( !isdefined( newgoalpos ) )
        {
            newgoalpos = findclosestnonlospointwithinvolume( searchvolume, lastknownposition + ( 0, 0, 63 ), lastknownposition, level.bseqinstancedata[ id ].var_719f77a34e64d6f5, cignoreradius );
        }
    }
    
    if ( !isdefined( newgoalpos ) )
    {
        newgoalpos = lastknownposition;
    }
    
    goalpos = self getclosestreachablepointonnavmesh( newgoalpos );
    level.bseqinstancedata[ id ].var_719f77a34e64d6f5[ level.bseqinstancedata[ id ].var_719f77a34e64d6f5.size ] = goalpos;
    
    /#
        if ( getdvarint( @"ai_debuglkpsquad" ) != 0 )
        {
            sphere( goalpos, 6, ( 1, 0, 0 ), 0, 100 );
        }
    #/
    
    return goalpos;
}

// Namespace ai_lkp
// Params 2
// Checksum 0xeefbfb44, Offset: 0xdd5
// Size: 0x5b
function reachedlkp( statename, params )
{
    id = self getinteractionid();
    function_dd518df9ee8d217c( id, "lkpanimtype", "lost_target" );
    self.var_c441720c90bf9002 = 1;
    addbattlechatternotify( self, self.enemy, "last_known_position", "lost_target" );
}

// Namespace ai_lkp
// Params 2
// Checksum 0x29efc58a, Offset: 0xe38
// Size: 0x88
function setuppositionsnearlkp( statename, params )
{
    primaryinvestigator = function_dd66b33f5942bdfb( "primary_investigator" );
    primaryinvestigator endon( #"death" );
    primaryinvestigator endon( #"hash_d5f3c1418fb4abb" );
    id = self getinteractionid();
    lastknownposition = function_521b5a0a07a246a8( id, "last_known_position" );
    self setlookat( lastknownposition + ( 0, 0, 63 ) );
    return function_ab171e929e5d17c7( lastknownposition );
}

// Namespace ai_lkp
// Params 2
// Checksum 0x69276294, Offset: 0xec9
// Size: 0xc4
function reachedlkprandom( statename, params )
{
    primaryinvestigator = function_dd66b33f5942bdfb( "primary_investigator" );
    primaryinvestigator endon( #"death" );
    primaryinvestigator endon( #"hash_d5f3c1418fb4abb" );
    id = self getinteractionid();
    level.bseqinstancedata[ id ].var_66d5e5b005680ad1++;
    backupinvestigators = function_b8df72c609a7a6f7( "backup_investigator" );
    
    if ( level.bseqinstancedata[ id ].var_66d5e5b005680ad1 >= backupinvestigators.size )
    {
        function_dd518df9ee8d217c( id, "move_complete_lkp", 1 );
        level.bseqinstancedata[ id ].var_66d5e5b005680ad1 = 0;
    }
}

// Namespace ai_lkp
// Params 2
// Checksum 0xfeedcd95, Offset: 0xf95
// Size: 0x96
function waitforlkpanimfinished( statename, params )
{
    self endon( #"hash_d5f3c1418fb4abb" );
    self endon( #"death" );
    utility::waittill_any_timeout( 5, "exposed_lkp" );
    id = self getinteractionid();
    animtype = function_521b5a0a07a246a8( id, "lkpanimtype" );
    timeout = 10;
    
    if ( animtype == "idle" || animtype == "none" )
    {
        timeout = 2;
    }
    
    utility::waittill_any_timeout( timeout, "exposed_lkp_finished" );
}

// Namespace ai_lkp
// Params 2
// Checksum 0x42623409, Offset: 0x1033
// Size: 0x28
function setstationary( statename, params )
{
    self setbtgoalstationary( 1 );
    self setbtgoalradius( 1, params[ 0 ] );
}

// Namespace ai_lkp
// Params 1
// Checksum 0x57385646, Offset: 0x1063
// Size: 0x34, Type: bool
function function_43ddb2a71129b731( statename )
{
    goalradius = 16;
    pathlength = self pathdisttogoal();
    
    if ( pathlength <= goalradius )
    {
        return true;
    }
    
    return false;
}

// Namespace ai_lkp
// Params 1
// Checksum 0x660bb1db, Offset: 0x10a0
// Size: 0x14
function cleargoal( statename )
{
    self clearbtgoal( 1 );
}

// Namespace ai_lkp
// Params 2
// Checksum 0x7998aede, Offset: 0x10bc
// Size: 0x45
function function_dd66b33f5942bdfb( tag, interactionid )
{
    self endon( #"death" );
    self endon( #"hash_d5f3c1418fb4abb" );
    users = function_b8df72c609a7a6f7( tag, interactionid );
    return users[ 0 ];
}

// Namespace ai_lkp
// Params 2
// Checksum 0x3c79cbb5, Offset: 0x110a
// Size: 0x4e
function function_b8df72c609a7a6f7( tag, interactionid )
{
    self endon( #"death" );
    self endon( #"hash_d5f3c1418fb4abb" );
    
    if ( !isdefined( interactionid ) )
    {
        interactionid = self getinteractionid();
    }
    
    users = getbsequserswithtag( interactionid, tag );
    return users;
}

// Namespace ai_lkp
// Params 1
// Checksum 0x3fdf7b34, Offset: 0x1161
// Size: 0x1b9
function function_ab171e929e5d17c7( primarypos )
{
    self endon( #"death" );
    self endon( #"hash_d5f3c1418fb4abb" );
    id = self getinteractionid();
    cignoreradius = 100;
    searchvolume = function_530db05278f25c67();
    
    if ( isdefined( searchvolume ) )
    {
        newgoalpos = findclosestlospointwithinvolume( searchvolume, primarypos + ( 0, 0, 63 ), primarypos, level.bseqinstancedata[ id ].var_719f77a34e64d6f5, cignoreradius );
        
        if ( !isdefined( newgoalpos ) )
        {
            newgoalpos = findclosestnonlospointwithinvolume( searchvolume, primarypos + ( 0, 0, 63 ), primarypos, level.bseqinstancedata[ id ].var_719f77a34e64d6f5, cignoreradius );
        }
    }
    else
    {
        carearadius = 1000;
        newgoalpos = findclosestlospointwithinradius( self.origin, carearadius, primarypos + ( 0, 0, 63 ), primarypos, level.bseqinstancedata[ id ].var_719f77a34e64d6f5, cignoreradius );
    }
    
    if ( !isdefined( newgoalpos ) )
    {
        curpos = self.origin;
        variance = randomintrange( 100, 150 );
        newgoalpos = primarypos - variance * vectornormalize( primarypos - curpos );
    }
    
    goalpos = self getclosestreachablepointonnavmesh( newgoalpos );
    level.bseqinstancedata[ id ].var_719f77a34e64d6f5[ level.bseqinstancedata[ id ].var_719f77a34e64d6f5.size ] = goalpos;
    
    /#
        if ( getdvarint( @"ai_debuglkpsquad" ) != 0 )
        {
            sphere( goalpos, 6, ( 0, 0, 1 ), 0, 100 );
        }
    #/
    
    return goalpos;
}

