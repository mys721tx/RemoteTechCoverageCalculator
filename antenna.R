# Distance data from OhioBob
# https://forum.kerbalspaceprogram.com/index.php?/topic/100439-min-max-distances-betwen-planets/&do=findComment&comment=1739572
maxima <- read.csv("maxima.csv", header = TRUE, row.names = 1)
minima <- read.csv("minima.csv", header = TRUE, row.names = 1)

antennas <- read.csv("antennas.csv", header = TRUE, row.names = 1)


calculate_coverage <- function(distance_matrix, planet, antenna, orbit) {
    tan_values <- tan(antenna$angle * pi / 180 / 2)
    distances <- distance_matrix[, planet]

    crone_distance <- tan_values %o% distances
    crone_coverage <- crone_distance > orbit

    range_coverage <- outer(antenna$range, distances, FUN = ">")

    result <- crone_coverage & range_coverage

    colnames(result) <- colnames(distance_matrix)
    rownames(result) <- rownames(antenna)

    return(result)
}

orbit <- 3463.330

minima_result <- calculate_coverage(minima, "Kerbin", antennas, orbit)

maxima_result <- calculate_coverage(maxima, "Kerbin", antennas, orbit)
