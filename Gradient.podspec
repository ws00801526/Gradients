#
# Be sure to run `pod lib lint Gradient.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Gradient'
  s.version          = '0.1.0'
  s.summary          = 'easy to set gradient for view'
  s.description      = <<-DESC
                        easy to set gradient for view
                        supports instagram login background animation
                       DESC

  s.homepage         = 'https://github.com/ws00801526/Gradients'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ws00801526' => '3057600441@qq.com' }
  s.source           = { :git => 'https://github.com/ws00801526/Gradients.git', :tag => s.version.to_s }
  s.swift_version = '4.2'
  s.ios.deployment_target = '8.0'
  s.source_files = 'Gradient/Classes/**/*'
end
