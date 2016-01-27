module Paperclip
  class Cropper < Thumbnail
    def transformation_command
      command = crop_command
      if command
        command + super.join(' ').sub(/ -crop \S+/, '').split(' ') # super returns an array like this: ["-resize", "100x", "-crop", "100x100+0+0", "+repage"]
      else
        super
      end
    end

    def crop_command
      target = @attachment.instance
      if target.cropping?
        result = ["-crop", "#{target.crop_w}x#{target.crop_h}+#{target.crop_x}+#{target.crop_y}"]
        target.crop_w = nil
        target.crop_h = nil
        target.crop_x = nil
        target.crop_y = nil

        return result
      end
    end
  end
end

