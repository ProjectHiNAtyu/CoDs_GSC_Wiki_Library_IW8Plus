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
    var_3.origin = ( 41976.2, -9187.08, 227.342 );
    var_3.script_index = var_0;
    var_3.get_player_who_most_recently_threw_grenade = var_2;
    var_3.nodes[0] = var_3;
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 42287.4, -8793.72, 228.382 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 42619.8, -8420.85, 189.553 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 42980.7, -8076.36, 137.122 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 43346.2, -7734.55, 111.028 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 43713, -7392.48, 122.545 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 44083.8, -7056.38, 144.025 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 43897.4, -7223, 136.008 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 44080.5, -7052.13, 145.58 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 44443.5, -6707.73, 169.809 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 44800.2, -6356.78, 193.681 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 45140, -5988.77, 218.94 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 45467.2, -5612.46, 265.63 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 45675.1, -5157.13, 283.91 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 45750.9, -4663.09, 259.787 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 45788.7, -4165.92, 221.078 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 45765.3, -3668.48, 170.796 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 45706.9, -3174.13, 114.612 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 45646.9, -2681.35, 53.7975 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 45605.6, -2185.65, -8.55227 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 45594.8, -1687.17, -63.7518 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 45617.7, -1187.81, -86.0056 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 45720.5, -698.179, -71.73 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 45887.6, -225.887, -44.2849 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 46063.1, 243.057, -26.4562 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 46193, 726.702, -24.609 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 46281.1, 1220.36, -26.5023 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 46299.5, 1721.71, -26.7602 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 46309.6, 2222.4, -25.7603 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 46339.7, 2722.23, -26.0736 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 46437.6, 3212.63, -26.122 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 46581.6, 3693.05, -26.4843 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 46758, 4161.94, -26.0148 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 46963.5, 4618.44, -26.6589 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 47190.3, 5065.37, -25.7457 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 47460.6, 5486.43, -26.2472 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 47777.9, 5874.33, -26.2194 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 48095.7, 6261.18, -30.3983 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 48370.1, 6679.41, -29.9015 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 48592.6, 7128.63, -29.198 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 48743.9, 7605.83, -19.9537 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 48856.6, 8093.82, -5.60232 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 48958.4, 8584.45, 6.95525 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 49021, 9081.47, 17.1177 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 49072.8, 9580.08, 22.3556 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 49100.8, 10078.7, -7.96703 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 49094.4, 10577, -62.887 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 49072.4, 11072, -138.681 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 49046.2, 11565, -222.709 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 48991, 12057, -301.926 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 48932.1, 12553, -331.44 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 48855.3, 13048.4, -332.127 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 48766, 13540.6, -334.77 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 48672.9, 14033.5, -338.585 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 48575.4, 14524.7, -340.079 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 48474.8, 15014.9, -342.501 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 48376.1, 15505.1, -345.333 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 48279.2, 15996.2, -348.05 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 48186.3, 16488.8, -349.608 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 48077.6, 16978, -350.896 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 47928.4, 17455.4, -351.39 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 47815.7, 17700.7, -352.567 );
    scripts\mp\gametypes\br_gametype_payload.gsc::_id_123AD( var_0, var_2 );
    level.completesmokinggunquest.paths[level.completesmokinggunquest.paths.size] = var_3;
}
