class CatsController < ApplicationController
    include Java
    BI = java.awt.image.BufferedImage
    
    def index 
    end
    
    def mix
    end

    def mixer
        filename = "#{File.dirname(__FILE__)}/../assets/images/#{params[:id]}.jpg"
        imagefile = java.io.File.new(filename)
        bi = javax.imageio.ImageIO.read(imagefile)
        w = bi.getWidth()
        h = bi.getHeight()
        cellWidth = w/2;
        cellHeight = h/2;
        
        cells = (0..3).sort_by { rand }
        bi2 = BI.new(w, h, BI::TYPE_INT_RGB)
        big = bi2.getGraphics()
        (0..1).each do |x|
            sx = x*cellWidth;
            (0..1).each do |y|
                sy = y*cellHeight;
                cell = cells[x*2+y];
                dx = (cell / 2) * cellWidth;
                dy = (cell % 2) * cellHeight;
                big.drawImage(bi,
                    dx, dy, 
                    dx+cellWidth, dy+cellHeight,
                    sx, sy,
                    sx+cellWidth, sy+cellHeight,
                    nil);
            end
        end 
        os = java.io.ByteArrayOutputStream.new
        javax.imageio.ImageIO.write(bi2, "jpeg", os)
        string = String.from_java_bytes(os.toByteArray)
        send_data string, :type => "image/jpeg", :disposition => "inline", 
            :filename => "1.jpg"
    
    end
end
