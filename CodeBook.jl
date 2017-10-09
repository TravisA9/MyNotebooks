using Pages

Pages.start()

Endpoint("/CodeBook") do request::Request
    readstring(joinpath(dirname(@__FILE__),"CodeBook.html"))
end

Callback("log") do args
    println(args)
end
#= Element(;
        id = "",
        tag = "div",
        name = "element",
        attr = Dict{String,String}(),
        style = Dict{String,String}(),
        html = "",
        text = "",
        parent = "body")
=#
function SendButton()
    id = "Button2" # name,args
    event = Dict( "onclick" => "Pages.log('args')", "type" => "button")
    #event = Dict( "onclick" => "Pages.callback('log', 'args')", "type" => "button")
    Pages.add(Pages.Element(id=id, tag="button", attr = event, text = "Button 2",))
    #Pages.broadcast("script","""Plotly.newPlot("$(id)",$(data),$(layout));""")
end




SendButton()
