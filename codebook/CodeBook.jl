#-------------------------------------------------------------------------------
# Set up server
#-------------------------------------------------------------------------------
using Pages

global shell
include("Shell.jl")

Pages.start()

function printout()
    output = readPipe(shell.out)
    println("julia> ", output)
end

Callback("out") do client, args
    VerivyJuliaRun()
    write(shell.in, string(args,"\n"))
    output = readPipe(shell.out)
    if output == nothing
        Timer( fn -> printout(), 1, 0)
    else
        println("julia> ", output)
    end
end


Endpoint("/CodeBook") do request::Request
    readstring(joinpath(dirname(@__FILE__),"CodeBook.html"))
end




#    SendButton()
