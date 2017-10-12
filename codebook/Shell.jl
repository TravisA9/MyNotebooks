#-------------------------------------------------------------------------------
# Read string from pipe
#-------------------------------------------------------------------------------
function readPipe(stream)
   if stream.buffer.size>0
       s = readavailable(stream)
       return chomp(string([Char(st) for st in s]...))
   end
end
#-------------------------------------------------------------------------------
# This function is borrowed from: gaston_aux.jl
#
#-------------------------------------------------------------------------------
function popen3(cmd::Cmd)
    pin = Base.Pipe()
    out = Base.Pipe()
    err = Base.Pipe()
    r = spawn(cmd, (pin, out, err))
    Base.close_pipe_sync(out.in)
    Base.close_pipe_sync(err.in)
    Base.close_pipe_sync(pin.out)
    Base.start_reading(out.out)
    Base.start_reading(err.out)
    return (pin.in, out.out, err.out, r)
end
#-------------------------------------------------------------------------------
# If julia not running: start up
#-------------------------------------------------------------------------------
struct Shell
   in
   out
   err
   process
   Shell(in, out, err, process) = new(in, out, err, process)
end
#-------------------------------------------------------------------------------
function VerivyJuliaRun()
    if !isdefined(:shell) || !process_running(shell.process)
        global shell = Shell(popen3(`julia`)...)
    end
end
#-------------------------------------------------------------------------------
# Send a button to client
#-------------------------------------------------------------------------------
function SendButton()
    #id = "Button2" # name,args  Pages.out("out", "hey man!")
    #Pages.add(Pages.Element(id="test", tag="p", attr = Dict( "contenteditable" => "true")))
    event = Dict( "onclick" => "runCode()", "type" => "button")
    Pages.add(Pages.Element(id="Button1", tag="button", attr = event, text = "Button 2"))
end
