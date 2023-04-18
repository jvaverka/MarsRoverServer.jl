module MarsRoverServer

using StructTypes

export greet
export days_to_sols
export find_photo
export RoverPhotos

const SECRET_NASA_API_KEY = get(ENV, "SECRET_NASA_API_KEY", "DEMO_KEY")
const BASE_ROVER_URL = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?api_key=$(SECRET_NASA_API_KEY)"
const DEFAULT_SOL = 1_000

greet() = "Hello Mars!"

"Define the conversion method from days to sols"
days_to_sols(days::Day) = days / Millisecond(88_775_244)

"Find the ith photograph source on a given Martian Sol."
function find_photo(sol::Int, i=1)
    reel = json(HTTP.get(BASE_ROVER_URL * "&sol=$(sol)"), RoverPhotos)
    return reel.photos[i]
end

struct Camera
    id::Int
    name::String
    rover_id::Int
    full_name::String
end

struct Rover
    id::Int
    name::String
    landing_date::String
    launch_date::String
    status::String
end

struct Photo
    id::Int
    sol::Int
    camera::Camera
    img_src::String
    earth_date::String
    rover::Rover
end

mutable struct RoverPhotos
    photos::Vector{Photo}

    RoverPhotos() = new()
end

StructTypes.StructType(::Type{RoverPhotos}) = StructTypes.Mutable()

end # module MarsRoverServer
