
Pod::Spec.new do |spec|
spec.name         = 'KVAlert'
spec.version      = '0.1.0'
spec.license      = { :type => 'MIT', :file => 'LICENSE' }
spec.homepage     = 'https://github.com/KochIK/KVAlert'
spec.authors      = { 'Vlad Kochergin' => 'kargod@ya.ru' }
spec.summary      = 'Easy implementation of alerts - KVTimer'
spec.source       = { :git => 'https://github.com/KochIK/KVAlert.git', :tag => '0.1.0' }
spec.platform = :ios
spec.ios.deployment_target  = '7.0'

spec.source_files       = 'Classes/*.{h,m}'
spec.ios.framework  = 'UIKit'
end
