
Pod::Spec.new do |s|

  s.name         = "ZFLibrary"
  s.version      = "0.0.1"
  s.summary      = "Common Library Components and Categories"

  s.homepage     = "http://www.ziofritz.com"

  s.license      = "MIT (example)"

  s.author       = { "Francesco" => "cescofry@gmail.com" }
  s.source       = { :git => "https://github.com/cescofry/ZFLibrary.git", :tag => 0.1 }


  s.requires_arc = true
  
  s.subspec 'Categories' do |sub|
    sub.platform = 'ios'
    sub.source_files = 'Categories/*.{h,m}'
  end
  
  s.subspec 'CoreData' do |sub|
    sub.source_files = 'CoreData/*.{h,m}'
    sub.framework = 'CoreData'
  end

	### Keep for reference

  # s.exclude_files = "Classes/Exclude"
  # s.frameworks = "CoreData", "AnotherFramework"
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
