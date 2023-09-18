Pod::Spec.new do |s|
    s.name = 'IngeekDK' 
    s.version = '4.0.0'
    s.summary = 'Security bluetooth key for car' 
    s.description = 'New bluetooth digital key for car with security, convenient' 
    s.homepage = 'https://gitlab.ingeek.com/qz/mobile/ios/idk_mob_sdk_ios.git' 
    s.license = {   :type => 'MIT', 
                    :file => 'LICENSE', 
                }
    s.authors = {"SunXiaofei"=>"xiaofei.sun@ingeek.com"}
    s.ios.deployment_target = '10.0'
    s.source = {    :git => 'https://gitlab.ingeek.com/qz/mobile/ios/idk_mob_sdk_ios.git', 
                    :branch => s.version.to_s, 
                }

    s.requires_arc = true
    s.source = { :path => './' }
    
    s.ios.deployment_target    = '10.0'
    s.ios.vendored_framework   = '*.framework'
    s.resources = "*.{bundle}"
    
    s.user_target_xcconfig = {
      'ENABLE_BITCODE' => 'NO'
    }
    
    s.subspec 'IngeekDK' do |s|   
      s.platform = :ios
      s.vendored_frameworks =  'IngeekDK/*.{framework}'
      s.resources = "IngeekDK/*.{bundle}"
      s.preserve_paths = 'IngeekDK/*.framework'
      s.pod_target_xcconfig = { 
        'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/IngeekDK/*.framework/Headers',
        'LD_RUNPATH_SEARCH_PATHS' => '$(PODS_ROOT)/IngeekDK/' 
      }
    end

end