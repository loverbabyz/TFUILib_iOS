#
# Be sure to run `pod lib lint TFUILib_iOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TFUILib_iOS'
  s.version          = '1.0.0'
  s.summary          = 'UI lib for Treasure framework.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
UI lib for Treasure framework.
                       DESC

  s.homepage         = 'https://github.com/loverbabyz/TFUILib_iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SunXiaofei' => 'daniel.xiaofei@gmail.com' }
  s.source           = { :git => 'https://github.com/loverbabyz/TFUILib_iOS.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.requires_arc = true
  
  # s.resource_bundles = {
  #   'TFUILib_iOS' => ['TFUILib_iOS/Assets/*.png']
  # }
  
  # s.framework  = "frameworkname"
  # s.library   = "libraryname"
  # s.vendored_libraries = "TFUILib_iOS/Classes/**/*.{a}"
  # s.ios.libraries = "stdc++", "sqlite3"
  # s.ios.vendored_frameworks = "TFUILib_iOS/Classes/3rd-framework/**/*.{framework}"
  
  s.resources = "TFUILib_iOS/Assets/**/*.{bundle}"
  s.frameworks = "Foundation", "UIKit", "CoreGraphics", "CoreData", "CoreText", "ImageIO", "QuartzCore", "WebKit", "AVFoundation", "Photos", "AudioToolbox", "MapKit", "CoreLocation", "SceneKit"
  
  s.public_header_files = 'TFUILib_iOS/Classes/TFUILib_iOS.h'
  s.source_files = 'TFUILib_iOS/Classes/TFUILib_iOS.h'
  
  s.subspec 'Core-3rd' do |ss|
  ss.platform = :ios
  ss.source_files = 'TFUILib_iOS/Classes/Core-3rd/*.{h,m}'
  ss.public_header_files = 'TFUILib_iOS/Classes/Core-3rd/*.h'
  
  ss.subspec 'TFProgressHudView' do |sss|
  sss.platform = :ios
  sss.source_files = 'TFUILib_iOS/Classes/Core-3rd/TFProgressHudView/*.{h,m}'
  sss.public_header_files = 'TFUILib_iOS/Classes/Core-3rd/TFProgressHudView/*.h'
  end
  end
  
  s.subspec 'Core-Category' do |ss|
  ss.platform = :ios
  ss.source_files = 'TFUILib_iOS/Classes/Core-Category/**/*.{h,m}'
  ss.public_header_files = 'TFUILib_iOS/Classes/Core-Category/**/*.h'
  ss.dependency 'BlocksKit', '~> 2.2.5'
  end
  
  s.subspec 'Core-CustomControl' do |ss|
  ss.platform = :ios
  ss.source_files = 'TFUILib_iOS/Classes/Core-CustomControl/**/*.{h,m}'
  ss.public_header_files = 'TFUILib_iOS/Classes/Core-CustomControl/**/*.h'
  end
  
  s.subspec 'Core-Macro' do |ss|
  ss.platform = :ios
  ss.source_files = 'TFUILib_iOS/Classes/Core-Macro/**/*.{h,m}'
  ss.public_header_files = 'TFUILib_iOS/Classes/Core-Macro/**/*.h'
  end
  
  s.subspec 'Core-Manager' do |ss|
  ss.platform = :ios
  ss.source_files = 'TFUILib_iOS/Classes/Core-Manager/*.{h,m}'
  ss.public_header_files = 'TFUILib_iOS/Classes/Core-Manager/*.h'
  end
  
  s.subspec 'Core-Model' do |ss|
  ss.platform = :ios
  ss.source_files = 'TFUILib_iOS/Classes/Core-Model/*.{h,m}'
  ss.public_header_files = 'TFUILib_iOS/Classes/Core-Model/*.h'
  end
  
  s.subspec 'Core-View' do |ss|
  ss.platform = :ios
  ss.source_files = 'TFUILib_iOS/Classes/Core-View/**/*.{h,m}'
  ss.public_header_files = 'TFUILib_iOS/Classes/Core-View/**/*.h'
  ss.resources = "TFUILib_iOS/Classes/Core-View/**/*.{bundle}"
  end
  
  s.subspec 'Core-Util' do |ss|
  ss.platform = :ios
  ss.source_files = 'TFUILib_iOS/Classes/Core-Util/**/*.{h,m}'
  ss.public_header_files = 'TFUILib_iOS/Classes/Core-Util/**/*.h'
  end
  
  s.subspec 'Core-ViewController' do |ss|
  ss.platform = :ios
  ss.source_files = 'TFUILib_iOS/Classes/Core-ViewController/**/*.{h,m}'
  ss.public_header_files = 'TFUILib_iOS/Classes/Core-ViewController/**/*.h'
  ss.resources = "TFUILib_iOS/Classes/Core-ViewController/**/*.{bundle}"
  end
  
  s.subspec 'Core-ViewModel' do |ss|
  ss.platform = :ios
  ss.source_files = 'TFUILib_iOS/Classes/Core-ViewModel/**/*.{h,m}'
  ss.public_header_files = 'TFUILib_iOS/Classes/Core-ViewModel/**/*.h'
  end
  
  s.dependency  'MJExtension', '3.2.1'
  s.dependency  'MJRefresh', '3.4.3'
  s.dependency  'Masonry', '1.1.0'
  s.dependency  'SDWebImage', '5.8.0'
  s.dependency  'IQKeyboardManager', '6.5.5'
  s.dependency  'pop', '1.0.12'
  s.dependency  'ReactiveObjC', '3.1.1'

end
