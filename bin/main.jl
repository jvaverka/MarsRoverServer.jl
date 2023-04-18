using MarsRoverServer: find_photo, DEFAULT_SOL
using HTTP: get, Request
using Oxygen: @get, @staticfiles, serve, queryparams
using JuliaHubClient: new_job

@get "/" greet

@staticfiles("content", "static")

@get "/rover" function (req::Request)
    sol = DEFAULT_SOL
    photo = find_photo(sol)
    return Dict(:sol => sol, :img_num => 1, :src => photo.img_src)
end

@get "/rover/find" function (req::Request)
    params = queryparams(req)
    sol = get(params, "sol", DEFAULT_SOL)
    photo = find_photo(sol)
    return Dict(:sol => sol, :img_num => 1, :src => photo.img_src)
end

@get "/rover/{sol}/{i}" function (req::Request, sol::Int, i::Int)
    photo = find_photo(sol, i)
    return Dict(:sol => sol, :img_num => i, :src => photo.img_src)
end

@get "/rover/submit/{sol}/{i}" function (req::Request, sol::Int, i::Int)
    photo = find_photo(sol, i)
    img = get(photo.img_src)
    job = new_job(;
        code="code.jl",
        directory="..",
        type="cpu",
        apptype="batchjob",
        workers=0,
        cpu=1,
        gpu=0,
        memory=4,
        time_limit=1,
        process_per_node=true,
        create_bundle=true,
        args=Dict("sol" => DEFAULT_SOL, "i" => 1),
    )

    return job
end

serve(; host="0.0.0.0", port=get(ENV, "PORT", 8002))
