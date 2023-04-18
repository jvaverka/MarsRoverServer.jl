# # Batch Script
# Code to submit for batch job at scheduled intervals.

using Dates: Date, Year, Month, Day, today
using HTTP
using MarsRoverServer: days_to_sols, find_photo

const DEFAULT_IMG = 1
const CURIOSITY_LAUNCH_DATE = Date(Year(2012), Month(8), Day(5))

# Find the number of mission sols for the rover based on yesterday's date.

yesterday = today() - Day(1)
mission_days = yesterday - CURIOSITY_LAUNCH_DATE
mission_sols = floor(Int, days_to_sols(mission_days))

# Capture job inputs if provided. If not, use the fallback defaults.

sol = get(ENV, "sol", mission_sols)
i = get(ENV, "i", DEFAULT_IMG)

# Find the photo information and create a dictionary with the results.

photo = find_photo(sol, i)
results = Dict(:sol => sol, :img_num => i, :src => photo.img_src)

# Assign the `RESULTS` environment variable to the `results` dictionary.
# These results will be nicely displayed in tabular format under the job details section.

ENV["RESULTS"] = results
