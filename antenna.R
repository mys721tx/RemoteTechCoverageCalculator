# Distance data from OhioBob
# https://forum.kerbalspaceprogram.com/index.php?/topic/100439-min-max-distances-betwen-planets/&do=findComment&comment=1739572
maxima <- read.csv("maxima.csv", header = TRUE, row.names = 1)
minima <- read.csv("minima.csv", header = TRUE, row.names = 1)

antennas <- read.csv("antennas.csv", header = TRUE, row.names = 1)

orbit <- 3463.330

tan_values <- tan(antennas$angle * pi / 180 / 2)

crone_distance <- tan_values %o% minima$Kerbin
crone_coverage <- crone_distance > orbit

range_coverage <- outer(antennas$range, minima$Kerbin, FUN = ">")

minima_result <- crone_coverage & range_coverage

colnames(minima_result) <- colnames(minima)
rownames(minima_result) <- rownames(antennas)

crone_distance <- tan_values %o% maxima$Kerbin
crone_coverage <- crone_distance > orbit

range_coverage <- outer(antennas$range, maxima$Kerbin, FUN = ">")

maxima_result <- crone_coverage & range_coverage

colnames(maxima_result) <- colnames(maxima)
rownames(maxima_result) <- rownames(antennas)
