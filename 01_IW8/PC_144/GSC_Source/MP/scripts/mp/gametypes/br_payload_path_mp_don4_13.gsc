// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

relic_amped_explosion_time( var_0, var_1, var_2 )
{
    if ( level.mapname != "mp_don4" )
        return;

    if ( level.completesmokinggunquest.vehicle_docollisiondamagetoplayer != var_1 && !isdefined( level.completesmokinggunquest.vehicle_collision_ignorefutureevent ) )
        return;

    if ( !isdefined( level.completesmokinggunquest.paths ) )
        level.completesmokinggunquest.paths = [];

    var_3 = spawnstruct();
    var_3.nodes = [];
    var_3.origin = ( 37506.2, -7518.02, -329.816 );
    var_3.script_index = var_0;
    var_3.get_player_who_most_recently_threw_grenade = var_2;
    var_3.nodes[0] = var_3;
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37356.5, -8000.56, -330.105 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37212.5, -8483.5, -330.183 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37134.7, -8979.25, -331.008 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37088.5, -9480.46, -346.27 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37085.1, -9981, -361.325 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37094.4, -10485, -361.339 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37095.4, -10986.3, -361.215 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37096.9, -11487.7, -361.196 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37098.3, -11991, -383.222 );
    var_3.nodes[var_4].obstacle = spawnstruct();
    var_3.nodes[var_4].obstacle.origin = ( 37121, -12488.2, -446.046 );
    var_3.nodes[var_4].obstacle.angles = ( 366.552, 272.617, 0 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37121, -12487.7, -447.429 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37143.4, -12984.5, -505.373 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37154.6, -13484.8, -551.241 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37158.6, -13984.8, -564.952 );
    var_3.nodes[var_4].checkpoint = 1;
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37148.7, -14488.8, -567.996 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37131.1, -14993.1, -566.684 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37113.5, -15495.1, -563.122 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37095.9, -15997.3, -561.119 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37078.2, -16501, -560.592 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37073.2, -17001.8, -560.96 );
    var_3.nodes[var_4].obstacle = spawnstruct();
    var_3.nodes[var_4].obstacle.origin = ( 37068.8, -17501.8, -559.111 );
    var_3.nodes[var_4].obstacle.angles = ( 360.053, 269.498, 0 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37068.8, -17504.1, -561.431 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37078.7, -18007.8, -561.915 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37101.2, -18508.4, -562.54 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37136.9, -19011.2, -563.084 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37210, -19509.9, -563.546 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37301.2, -20005.9, -560.739 );
    var_3.nodes[var_4].obstacle = spawnstruct();
    var_3.nodes[var_4].obstacle.origin = ( 37394.5, -20497.1, -561.925 );
    var_3.nodes[var_4].obstacle.angles = ( 360.024, 280.765, 0 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37394.8, -20498.2, -563.687 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37425.6, -20997.7, -564.284 );
    var_3.nodes[var_4].checkpoint = 1;
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37335.5, -21490.1, -567.724 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37194.2, -21973.6, -567.648 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37027.9, -22448.1, -567.452 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 36794.6, -22893.7, -567.43 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 36496.5, -23296.7, -567.874 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 36153.6, -23663.6, -568.259 );
    var_3.nodes[var_4].obstacle = spawnstruct();
    var_3.nodes[var_4].obstacle.origin = ( 35803.6, -24020.7, -566.002 );
    var_3.nodes[var_4].obstacle.angles = ( 360, 225.58, 0 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 35801.6, -24022.8, -568.301 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 35451.7, -24381.3, -568.303 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 35097.5, -24736, -568.282 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 34730.4, -25081.6, -568.338 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 34288.4, -25319.6, -568.484 );
    var_3.nodes[var_4].obstacle = spawnstruct();
    var_3.nodes[var_4].obstacle.origin = ( 33817.5, -25487.8, -566.006 );
    var_3.nodes[var_4].obstacle.angles = ( 360, 199.663, 0 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 33772.9, -25503.8, -565.868 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 33393.4, -25858.6, -525.873 );
    scripts\mp\gametypes\br_gametype_payload.gsc::_id_123AD( var_0, var_2 );
    level.completesmokinggunquest.paths[level.completesmokinggunquest.paths.size] = var_3;
}
