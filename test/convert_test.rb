# -*- encoding : utf-8 -*-
require 'test_helper'
require 'metro/ui/convert'

class ConvertTest < ActiveSupport::TestCase
  setup do
    @convert = Metro::Ui::Convert.new
  end

  test "#replace_image_url 应该换成image-url" do
    content = '@icons_black: url("../images/icons.png");'
    assert_equal '@icons_black: image-url("metro-ui-css/icons.png");', @convert.replace_image_url(content)

    content = "@icons_black: url('../images/icons.png');"
    assert_equal '@icons_black: image-url("metro-ui-css/icons.png");', @convert.replace_image_url(content)

    content = "@icons_black: url(../images/icons.png);"
    assert_equal '@icons_black: image-url("metro-ui-css/icons.png");', @convert.replace_image_url(content)
  end

  test "#replace_google_font_url 应该换成asset-url,并下载文件到本地" do
    content = "    src: local('PT Serif Caption'), local('PTSerif-Caption'), url(http://themes.googleusercontent.com/static/fonts/ptserifcaption/v4/7xkFOeTxxO1GMC1suOUYWWhBabBbEjGd1iRmpyoZukE.woff) format('woff'); "
    new_content = "    src: local('PT Serif Caption'), local('PTSerif-Caption'), asset-url(\"metro-ui-css/fonts/7xkFOeTxxO1GMC1suOUYWWhBabBbEjGd1iRmpyoZukE.woff\") format('woff'); "
    
    assert_equal new_content, @convert.replace_google_font_url(content)
    assert File.exist?( File.expand_path("../../vendor/assets/images/metro-ui-css/fonts/", __FILE__) )
  end

  test "#replace_local_font_url 应该替换成asset-url" do
    content = <<-EOS
  src: url('../fonts/iconFont.eot?#iefix') format('embedded-opentype'), url('../fonts/iconFont.svg#iconFont') format('svg'), url('../fonts/iconFont.woff') format('woff'), url('../fonts/iconFont.ttf') format('truetype');
    EOS
    new_content = <<-EOS
  src: asset-url(\"metro-ui-css/fonts/iconFont.eot?#iefix\") format('embedded-opentype'), asset-url(\"metro-ui-css/fonts/iconFont.svg#iconFont\") format('svg'), asset-url(\"metro-ui-css/fonts/iconFont.woff\") format('woff'), asset-url(\"metro-ui-css/fonts/iconFont.ttf\") format('truetype');
    EOS
    assert_equal new_content, @convert.replace_local_font_url(content)
  end
end
