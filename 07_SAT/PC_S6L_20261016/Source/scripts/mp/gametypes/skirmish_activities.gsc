// scripts\mp\gametypes\skirmish_activities.gsc  (hash_488991890ba9d8b8.gscc) (size: 4852 Bytes / 0x12f4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x53ba4ccb (1404718283)
// size ...... 4852 (0x12f4)
// includes .. 9   (offset: 0x11e4)
// strings ... 15  (offset: 0x122c)
// dev strs .. 0   (offset: 0x12f4)
// exports ... 11  (offset: 0xa38)
// cseg ...... 0x138 + 0x900 (0xa38)
// imports ... 52  (offset: 0xbf0)
// animtree1 . 0   (offset: 0x12f4)
// animtree2 . 0   (offset: 0x12f4)
#using script_1ecac15e80f0648b;
#using script_2c8ce58377654932;
#using scripts\common\omnvar_utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\skirmish_activity_destroy;
#using scripts\mp\gametypes\skirmish_activity_manager;
#using scripts\mp\gametypes\skirmish_objective_director;
#using scripts\mp\gametypes\skirmish_util;
#using scripts\mp\objidpoolmanager;

#namespace skirmish_activities;

// Namespace skirmish_activities
// Params 0
// Checksum 0x68840f99, Offset: 0x156
// Size: 0xbf
function init()
{
    level.var_94b3331bc1ac839e = level.gametypebundle.var_d332fecedd2c38e7;
    level.var_d732a85aef475673 = level.gametypebundle.var_2e0cd9fbd0c94da8;
    level.var_e71a267be9a42310 = level.gametypebundle.var_b59a192d4d800971;
    level.var_fd5a14340d3320e9 = getmatchrulesdata( "skirmishData", "activityRadius" );
    level.var_21b2de6092398c0 = 1;
    skirmish_activity_manager::init();
    skirmish_objective_director::init();
    
    if ( level.var_94b3331bc1ac839e )
    {
        function_1bac7fe61a86d77d();
    }
    
    if ( level.var_d732a85aef475673 )
    {
        function_e256757d4feb3ee2();
    }
    
    if ( level.var_e71a267be9a42310 )
    {
        function_f629a725ffeea47f();
    }
}

// Namespace skirmish_activities
// Params 3, eflags: 0x4
// Checksum 0x39ede4a9, Offset: 0x21d
// Size: 0xec
function private function_5733a2efa35ef4a4( target, zone, cooldowntime )
{
    activitytype = #"dom";
    activityname = hashcat( #"objective_", target );
    activity = spawnstruct();
    activity.activitytype = activitytype;
    activity.activityname = activityname;
    activity.activityzone = zone;
    activity.var_14de5c0af315cc23 = cooldowntime;
    skirmish_activity_manager::registeractivity( activity, &namespace_7ea6f131e1a9874d::function_460ac0da13315aaf, &namespace_7ea6f131e1a9874d::function_11f45fc99e57dd8d, &namespace_7ea6f131e1a9874d::function_eb532914fbf1526, &namespace_7ea6f131e1a9874d::function_142303de94f5115e, &namespace_7ea6f131e1a9874d::function_370bffd438e5e93f, &namespace_7ea6f131e1a9874d::function_e74f0a1cc4269070, { #location:namespace_7ea6f131e1a9874d::function_1f7103ac976709bd( target ), #name:activityname, #type:activitytype, #target:target } );
}

// Namespace skirmish_activities
// Params 0, eflags: 0x4
// Checksum 0x93cdd634, Offset: 0x311
// Size: 0xb3
function private function_1bac7fe61a86d77d()
{
    namespace_7ea6f131e1a9874d::init();
    domzones = strtok( level.var_85b177faa9935b2a.mapsettings.var_b245829613dc71b4, "," );
    
    foreach ( zone in domzones )
    {
        function_5733a2efa35ef4a4( tolower( zone ), zone, 50 );
    }
}

// Namespace skirmish_activities
// Params 3, eflags: 0x4
// Checksum 0xf511b6ef, Offset: 0x3cc
// Size: 0xec
function private function_c4644c35169fc31e( target, zone, cooldowntime )
{
    activitytype = #"destroy";
    activityname = hashcat( #"objective_", target );
    activity = spawnstruct();
    activity.activitytype = activitytype;
    activity.activityname = activityname;
    activity.activityzone = zone;
    activity.var_14de5c0af315cc23 = cooldowntime;
    skirmish_activity_manager::registeractivity( activity, &skirmish_activity_destroy::function_490dab97a41fe7cd, &skirmish_activity_destroy::function_8eda243066326f13, &skirmish_activity_destroy::function_543bbb68b440e8, &skirmish_activity_destroy::function_4d18e56e1d06000c, &skirmish_activity_destroy::function_791bf29d7b2a4b69, &skirmish_activity_destroy::function_822ba1d4f38047b2, { #location:skirmish_activity_destroy::function_fc926704edf1c433( target ), #name:activityname, #type:activitytype, #target:target } );
}

// Namespace skirmish_activities
// Params 0, eflags: 0x4
// Checksum 0x5cff9139, Offset: 0x4c0
// Size: 0xca
function private function_f629a725ffeea47f()
{
    skirmish_activity_destroy::init();
    mapsettings = level.var_85b177faa9935b2a.mapsettings;
    var_ac98151a05bac7a9 = mapsettings.var_699d6504877fc92e;
    destroyzones = strtok( var_ac98151a05bac7a9, "," );
    
    foreach ( zone in destroyzones )
    {
        function_c4644c35169fc31e( tolower( zone ), zone, 50 );
    }
}

// Namespace skirmish_activities
// Params 3, eflags: 0x4
// Checksum 0x6f5e8602, Offset: 0x592
// Size: 0xec
function private function_1f368cc3ddf10edd( target, zone, cooldowntime )
{
    activitytype = #"secure";
    activityname = hashcat( #"objective_", target );
    activity = spawnstruct();
    activity.activitytype = activitytype;
    activity.activityname = activityname;
    activity.activityzone = zone;
    activity.var_14de5c0af315cc23 = cooldowntime;
    skirmish_activity_manager::registeractivity( activity, &namespace_e965e5c30872dcae::function_4be998cd802fd4ec, &namespace_e965e5c30872dcae::function_dc45388a42fe7e, &namespace_e965e5c30872dcae::function_72fb79e8e2124f3, &namespace_e965e5c30872dcae::function_614baa9a0614b119, &namespace_e965e5c30872dcae::function_c9a15a0921a98c34, &namespace_e965e5c30872dcae::function_ab4e0b1bb14ffc51, { #location:namespace_e965e5c30872dcae::function_ab80adb41ddd9fc0( target ), #name:activityname, #type:activitytype, #target:target } );
}

// Namespace skirmish_activities
// Params 0, eflags: 0x4
// Checksum 0xa0aae626, Offset: 0x686
// Size: 0xd0
function private function_e256757d4feb3ee2()
{
    namespace_e965e5c30872dcae::init();
    mapsettings = level.var_85b177faa9935b2a.mapsettings;
    var_df58514de0b4da38 = mapsettings.var_2a3fbe801b0f7369;
    securezones = strtok( var_df58514de0b4da38, "," );
    
    foreach ( zone in securezones )
    {
        function_1f368cc3ddf10edd( "secure_" + tolower( zone ), zone, 50 );
    }
}

// Namespace skirmish_activities
// Params 4
// Checksum 0x5d7cb4ee, Offset: 0x75e
// Size: 0x21e
function function_ab382591cebc98b5( time, targetzone, var_f1ab8fa9b426e75b, playintro )
{
    level endon( #"game_ended" );
    
    if ( !( isdefined( self ) && isdefined( targetzone ) ) )
    {
        return;
    }
    
    activitystring = "_siege";
    
    if ( self.activitytype == #"destroy" )
    {
        activitystring = "_destroy";
    }
    else if ( self.activitytype == #"secure" )
    {
        activitystring = "_secure";
    }
    
    setomnvar( "ui_objective_" + targetzone, 0 );
    var_a39a0fc44190c2eb = 0;
    omnvar_utility::function_8b206c75cb7ad548( "ui_objective_" + targetzone, var_a39a0fc44190c2eb, 14, self.objidnum );
    var_a39a0fc44190c2eb += 14;
    omnvar_utility::function_8b206c75cb7ad548( "ui_objective_" + targetzone, var_a39a0fc44190c2eb, 1, var_f1ab8fa9b426e75b );
    var_a39a0fc44190c2eb += 1;
    omnvar_utility::function_8b206c75cb7ad548( "ui_objective_" + targetzone, var_a39a0fc44190c2eb, 2, function_54c6566e8feaaba8( activitystring ) );
    gameobjects::setobjectivestatusicons( "waypoint_locked" + activitystring );
    objective_setplayintro( self.objidnum, playintro );
    objidpoolmanager::update_objective_size( self.objidnum, level.var_1552790994371de7 );
    origin = self.trigger.origin ?? self.origin;
    var_5bd2fa07aad9409d = function_3dd719204d305955( self.activitytype );
    skirmish_util::function_f0219df3de59b8fc( var_5bd2fa07aad9409d, origin, 2000 );
    var_84cb828962fb6769 = skirmish_activity_manager::function_25bc283988806076() < level.var_85b177faa9935b2a.maxActivitiesStarting;
    
    if ( level.var_8f31e0730d6d5aec != 0 || var_84cb828962fb6769 )
    {
        gameobjects::allowuse( "none" );
        setomnvar( "ui_skrTimer", gettime() + int( level.var_8f31e0730d6d5aec * 1000 ) );
        objective_lock( self.objidnum, 1 );
        wait time;
    }
    else
    {
        waitframe();
    }
    
    objective_lock( self.objidnum, 0 );
    gameobjects::allowuse( "any" );
}

// Namespace skirmish_activities
// Params 1, eflags: 0x4
// Checksum 0x6b53944, Offset: 0x984
// Size: 0x51
function private function_54c6566e8feaaba8( activitystring )
{
    switch ( activitystring )
    {
        case #"hash_e0c8e7af9e0c7b71":
            return 0;
        case #"hash_966a26dd2a14ad50":
            return 1;
        case #"hash_e8d2b3e58df21bd3":
            return 2;
        default:
            break;
    }
}

// Namespace skirmish_activities
// Params 1, eflags: 0x4
// Checksum 0x9adb60ba, Offset: 0x9dd
// Size: 0x5b
function private function_3dd719204d305955( activitytype )
{
    switch ( activitytype )
    {
        case #"dom":
            return "obj_siege_available";
        case #"secure":
            return "obj_transmit_available";
        case #"destroy":
            return "obj_sabotage_available";
        default:
            break;
    }
}

