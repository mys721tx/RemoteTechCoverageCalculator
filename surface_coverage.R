antennas <- read.csv("antennas.csv", header = TRUE, row.names = 1)

bodies <- read.csv("bodies.csv", header = TRUE, row.names = 1)

alttitude <- 200

# Assume the antenna can reach the sureface of the central body, then the arc on
# the surface formed by the two tangents passing through the satellite should
# have unobstrcted line of sight to the satellite.
#
# The percentage of surface covered can be calduated.

surface_coverage <- function(alttitude, body) {
    # ratio of the surface covered
    ratio <- acos(body$radius / (alttitude + body$radius)) / pi
    # angle covered by the antenna crone
    angle <- ratio * 180 * 2
    # number of sattlites needed in a orbital plane
    number <- ceiling(1 / ratio)
    # radius of the orbit
    radius <- body$radius + alttitude
    # distance between to satellites in a orbital plane
    distance <- sin(pi / number) * radius * 2

    result <- cbind(ratio, angle, number, radius, distance)

    rownames(result) <- rownames(body)

    return(result)
}

surface_coverage(alttitude, bodies)
