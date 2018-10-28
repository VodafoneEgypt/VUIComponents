Pod::Spec.new do |s|
  s.name             = 'VUIComponents'
  s.version          = '0.6.0'
  s.summary          = 'Pod contains UI components'
  s.description      = 'A pod contains all objective-c UI components you need to use'
  s.homepage         = 'https://github.com/VodafoneEgypt/VUIComponents'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'VodafoneEgypt' => 'egypt.apps@vodafone.com' }
  s.source           = { :git => 'https://github.com/VodafoneEgypt/VUIComponents.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '9.0'
  s.source_files = 'VUIComponents/Classes/**/*.{h,m}'
  s.resources = 'VUIComponents/Classes/**/*.{xib,storyboard,png,json,html,js,css,lproj,otf,ttf,xcassets}'

  #s.framework = "CommonCrypto"
  
  s.dependency 'Languagehandlerpod'
  
  s.dependency 'NSAttributedString+CCLFormat'
  s.dependency 'WYPopoverController', '~> 0.3.9'
  s.dependency 'UIColor+Hex'
  s.dependency 'GSKStretchyHeaderView', '1.0.0'
  s.dependency 'INTUAnimationEngine'
  s.dependency 'JWGCircleCounter'
  s.dependency 'RSKImageCropper'
  #s.dependency 'CommonCrypto'
end
