using MarsWeatherServer
using HTTP
using Oxygen

@get "/" () -> greet()

function auth_middleware(handler, args...)
    req -> handler(req, args...)
end

function try_catch_middleware(handler, args...)
    req -> try
        handler(req, args...)
    catch
        HTTP.Response(500)
    end
end

serve(host="0.0.0.0", port=8080, middleware=[try_catch_middleware, auth_middleware])
