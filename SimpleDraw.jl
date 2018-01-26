using ImageView, Images, Gtk.ShortNames # some packages we need to make things work

# ==============================================================================
# This draws a rectrangle to a picture!
# ==============================================================================
function rect(image, left, top, width, height, color)
    imagewidth, imageheight = size(image) # Get the size of the image
    for y in 1:height, x in 1:width # loop through the rows and columns of the rectangle's area
        X,Y = left+x, top+y # create shorter names to make things nicer looking.
        # test to make sure that the pixel we want to draw is inside the image's limits
        if X>0 && X < imagewidth && Y>0 && Y < imageheight
            image[ X,Y ] = color # draw color to this pixel
        end
    end
end
# ==============================================================================
# A function to make a window and a canvas and then draw to it!
# ==============================================================================
function RandomRectangle()
    grid, frames, canvases = canvasgrid((1,1))  # 1 row, 1 column
    width, height = 600, 800 # create variables to define the image size
    image = rand(RGB{N0f8}, width, height) # create an image with random colored pixels
    win = Window(grid, "Title: my cool window!", height, width+50) # Create a window
    showall(win) # show the window

    color = rand(RGB{N0f8}) # create a random Red/Green/Blue color
   rect(image, 100, 100, 100, 100, color) # Draw a rectangle that is 100x100

    imshow(canvases[1,1], image)
end

# Now we actually call the function (tell it to get started)
RandomRectangle()
