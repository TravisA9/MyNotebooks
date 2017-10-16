#-------------------------------------------------------------------------------
# Set up server
#-------------------------------------------------------------------------------
using Pages

global shell
include("Shell.jl")

Pages.start()

function printout()
    output = readPipe(shell.out)
    if output !== nothing
        println("julia> ", output)
        Pages.broadcast("script","""output($(output),"false");""")
    end
end

Callback("out") do client, args
    VerivyJuliaRun()
    write(shell.in, string(args,"\n"))
    output = readPipe(shell.out)
    if output == nothing
        Timer( fn -> printout(), 1, 0)
    else
        println("julia> ", output)
        Pages.broadcast("script","""output($(output),"false");""")
    end

end

Endpoint("/CodeBook") do request::Request
    readstring(joinpath(dirname(@__FILE__),"CodeBook.html"))
end
Endpoint("/test.js") do request::Request
    readstring(joinpath(dirname(@__FILE__),"test.js"))
end
Endpoint("/font-awesome/css/font-awesome.css") do request::Request
    readstring(joinpath(dirname(@__FILE__),"font-awesome/css/font-awesome.css"))
end


#    SendButton()
