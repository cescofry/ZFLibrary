
Pod::Spec.new do |s|

  s.name         = "ZFLibrary"
  s.version      = "0.0.1"
  s.summary      = "Common Library Components and Categories"

  s.homepage     = "www.ziofritz.com"

  s.license      = "MIT (example)"

  s.author             = { "Francesco" => "cescofry@gmail.com" }
  s.source       = { :git => "https://github.com/cescofry/ZFLibrary.git" }

  s.source_files  = "Categories", "Categories/*.{h,m}", "CoreData", "CoreData/*.{h,m}"

  s.framework  = "CoreData"

  s.requires_arc = true

	### Keep for reference

  # s.exclude_files = "Classes/Exclude"
  # s.frameworks = "CoreData", "AnotherFramework"
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
