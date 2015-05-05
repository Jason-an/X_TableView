Pod::Spec.new do |s|  
  s.name     = 'X_TableView'  
  s.version  = '0.0.1'  
  s.license  = 'MIT'  
  s.summary  = 'X_TableView'  
  s.homepage = 'https://github.com/fc01/X_TableView'  
  s.author   = { "fc01" => "910677221@qq.com"}  
  s.source   = {:git => 'https://github.com/fc01/X_TableView.git', :tag => '0.0.1' }  
  s.platform = :ios, '7.0'  
  s.source_files = 'X_TableView/*.{h,m}'  
  s.public_header_files = 'X_TableView/*.h'
  s.framework = 'UIKit'
  s.requires_arc = true    
end 