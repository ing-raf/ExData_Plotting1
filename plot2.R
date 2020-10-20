# Load libraries
library(readr)

# Change locale to print weekdays in English
Sys.setlocale("LC_TIME", "en_US")

# Read input data
# 01/02/2007 begins at line 66638
#  1 obs/minute = number of obs = 60' * 24h *2d
colnames <-  as.character(read_delim("./data/household_power_consumption.txt", delim = ";", col_names = FALSE, n_max = 1, na = "?"))
dataset <- read_delim("./data/household_power_consumption.txt", delim = ";", col_names = FALSE, skip = 66637, n_max = 60 * 24 * 2, na = "?")
names(dataset) <- colnames
# From the UCI web site we know that the data is from a French city
dataset$Timestamp <- strptime(paste(dataset$Date, dataset$Time), "%d/%m/%Y %H:%M:%S", tz = "Europe/Paris")

# Produce the plot
png("plot2.png", width = 480, height = 480)
with(dataset,
	 plot(Timestamp, Global_active_power, type = "l", ylab = "Global active power (kilowatts)")
)
dev.off()