Pod::Spec.new do |s|  
  s.name     = 'X_TableView'  
  s.version  = '0.0.1'  
  s.license  = 'MIT'  
  s.summary  = 'X_TableView'  
  s.homepage = 'https://github.com/fc01/X_TableView'  
  s.author   = { "fc01" => "910677221@qq.com"}  
  s.source   = {:git => 'https://github.com/fc01/X_TableView.git', :commit => '5c1531f57dab2783cfd0223c8a0136767b73b7de' }  
  s.platform = :ios    
  s.source_files = 'X_TableView/**/*'  
  s.public_header_files = 'X_TableView/**/*.h'
  s.framework = 'UIKit'
  s.requires_arc = true    
end 