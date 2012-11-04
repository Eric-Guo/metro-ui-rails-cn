module Metro
  module Ui
    class Convert
      def run
        replace_files
      end

      def replace_files
        less_src_dir = File.expand_path("../../../../Metro-UI-CSS/less", __FILE__)
        less_dest_dir = File.expand_path("../../../../vendor/toolkit/metro-ui-css", __FILE__)
        rm_and_cp(less_src_dir, less_dest_dir)

        image_src_dir = File.expand_path("../../../../Metro-UI-CSS/public/images", __FILE__)
        image_dest_dir = File.expand_path("../../../../vendor/assets/images/metro-ui-css", __FILE__)
        rm_and_cp(image_src_dir, image_dest_dir)

        js_src_dir = File.expand_path("../../../../Metro-UI-CSS/javascript", __FILE__)
        js_dest_dir = File.expand_path("../../../../vendor/assets/javascripts/metro-ui-css", __FILE__)
        rm_and_cp(js_src_dir, js_dest_dir)

        Dir["#{less_dest_dir}/*.less"].each do |file|
          content = File.read(file)
          new_content = replace_image_url(content)
          new_content = replace_google_font_url(new_content)
          File.write(file, new_content)
        end
      end

      def replace_image_url(content)
        content.gsub(/url\((.+?images.+?)\)/mi) do |full_url|
          image_url = strip_quotes( $1.strip )
          image_url = "metro-ui-css/#{File.basename(image_url)}"
          "image-url(\"#{image_url}\")"
        end
      end

      def replace_google_font_url(content)
        content.gsub(/url\((.+?googleusercontent.+?)\)/mi) do |full_url|
          font_url = strip_quotes( $1.strip )
          font_path = File.expand_path("../../../../vendor/assets/images/metro-ui-css/fonts/#{File.basename(font_url)}", __FILE__)
          unless File.exist?(font_path)
            FileUtils.mkdir_p(File.expand_path("../../../../vendor/assets/images/metro-ui-css/fonts", __FILE__))
            system("wget #{font_url} -O #{font_path}")
          end
          font_url = "metro-ui-css/fonts/#{File.basename(font_url)}"
          "asset-url(\"#{font_url}\")"
        end
        
      end

      private
      def strip_quotes(url)
        url = url[1..-2] if url =~ /^\".*\"$/
        url = url[1..-2] if url =~ /^'.*'$/
        url
      end

      def rm_and_cp(src_dir, dest_dir)
        FileUtils.rm_rf(dest_dir + '/*')
        FileUtils.cp_r( Dir.glob("#{ src_dir}/**" ), dest_dir)
      end
    end
  end
end
