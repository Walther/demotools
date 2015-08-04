#!/usr/bin/env ruby -w

# pnginator.rb: pack a .js file into a PNG image with an HTML payload;
# when saved with an .html extension and opened in a browser, the HTML extracts and executes
# the javascript.

# Usage: ruby pnginator.rb input.js output.png.html

# This version edited by Walther
# Original work by Gasman <http://matt.west.co.tt/> https://gist.github.com/gasman/2560551
# based on an original idea by Daeken: http://daeken.com/superpacking-js-demos



MAX_WIDTH = 4096
USE_PNGOUT = true

require 'zlib'
require 'tempfile'

input_filename, output_filename = ARGV

f = File.open(input_filename, 'rb')
js = f.read
f.close

js = "\x00" + js
width = MAX_WIDTH
# split js into scanlines of 'width' pixels; pad the last one with whitespace
scanlines = js.scan(/.{1,#{width}}/m).collect{|line| line.ljust(width, "\x00")}
height = scanlines.length

# p01's multiple-pixel-row bootstrap (requires a dummy first byte on the js string)
# (edit by Gasman: set explicit canvas width to support widths above 300; move drawImage out of getImageData params; change eval to (1,eval) to force global evaluation)
# (edit by Walther: use full viewport of the browser for the canvas, "fullscreen"
html = "<head><style type='text/css'>body{margin:0;padding:0;float:left;display:block;position:absolute;top:0;width:100%;height:100%;overflow:hidden;}canvas{margin:0;padding:0;float:left;display:block;position:absolute;top:0;}</style></head><body><canvas id='c' style='display:none;'><img onload=for(w=c.width=#{width},a=c.getContext('2d'),a.drawImage(this,p=0,0),e='',d=a.getImageData(0,0,w,#{height}).data;t=d[p+=4];)e+=String.fromCharCode(t);(1,eval)(e) src=#>"


# prepend each scanline with 0x00 to indicate 'no filtering', then concat into one string
image_data = scanlines.collect{|line| "\x00" + line}.join
idat_chunk = Zlib::Deflate.deflate(image_data, 9) # 9 = maximum compression

def png_chunk(signature, data)
    [data.length, signature, data, Zlib::crc32(signature + data)].pack("NA4A*N")
end


# Create a valid (no format hacks) .png file to pass to pngout
f = Tempfile.open(['pnginator', '.png'])

begin
    f.write("\x89PNG\x0d\x0a\x1a\x0a") # PNG file header
    f.write(png_chunk("IHDR", [width, height, 8, 0, 0, 0, 0].pack("NNccccc")))
    f.write(png_chunk("IDAT", idat_chunk))
    f.write(png_chunk("IEND", ''))
    f.close

    system("pngout", f.path, "-c0", "-y")

    # read file back and extract the IDAT chunk
    f.open
    f.read(8)
    while !f.eof?
        length, signature = f.read(8).unpack("NA4")
        data = f.read(length)
        crc = f.read(4)

        if signature == "IDAT"
            idat_chunk = data
            break
        end
    end
ensure
    f.close
    f.unlink
end


File.open(output_filename, 'wb') do |f|
    f.write("\x89PNG\x0d\x0a\x1a\x0a") # PNG file header

    f.write(png_chunk("IHDR", [width, height, 8, 0, 0, 0, 0].pack("NNccccc")))

    # a custom chunk containing the HTML payload; stated chunk length is 4 less than the actual length,
    # leaving the final 4 bytes to take the place of the checksum
    f.write([html.length - 4, "jawh", html].pack("NA4A*"))

    # can safely omit the checksum of the IDAT chunk  
    # f.write([idat_chunk.length, "IDAT", idat_chunk, Zlib::crc32("IDAT" + idat_chunk)].pack("NA4A*N"))
    f.write([idat_chunk.length, "IDAT", idat_chunk].pack("NA4A*"))

    # can safely omit the IEND chunk
    # f.write([0, "IEND", "", Zlib::crc32("IEND")].pack("NA4A*N"))
end
