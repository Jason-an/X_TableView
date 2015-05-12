Pod::Spec.new do |s|
  s.name         = "X_TableView"
  s.version      = "0.11"
  s.summary      = "xib cell"
  s.homepage     = "https://github.com/fc01"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'fc01' => '910677221@qq.com' }
  s.source       = { :git => "https://github.com/fc01/X_TableView.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.source_files = 'X_TableView/**/*.{h,m}'
  s.framework    = "UIKit"
  s.requires_arc = true
end