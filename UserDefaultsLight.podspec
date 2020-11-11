
Pod::Spec.new do |spec|


  spec.name = "UserDefaultsLight"
  spec.version = "1.1.0"
  spec.summary = "Easy use of User Defaults."
 
  spec.homepage = "https://github.com/umbrellait-dmitry-sedov/UserDefaultsLights"

  spec.description  = "The framework allows you to use User Defaults elegantly and more effective"

  spec.homepage     = "https://github.com/umbrellait-dmitry-sedov/UserDefaultsLights"


  spec.license      = "MIT"


  spec.author             = { "umbrellait" => "dmitry.sedov@umbrellait.com" }


  spec.platform = :ios, "13.0"


  spec.source       = { :git => "https://github.com/umbrellait-dmitry-sedov/UserDefaultsLights.git", :tag => spec.version.to_s }


  spec.source_files = "UserDefaultsLight"


  spec.swift_version = "5.3" 

end
