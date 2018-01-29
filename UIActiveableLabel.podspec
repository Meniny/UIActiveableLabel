Pod::Spec.new do |s|
  s.name             = 'UIActiveableLabel'
  s.version          = '1.0.0'
  s.summary          = 'An active-able UILabel for iOS in Swift.'

  s.homepage         = 'https://github.com/Meniny/UIActiveableLabel'
  s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
  s.authors          = { 'Elias Abel' => 'admin@meniny.cn' }
  s.source           = { :git => 'https://github.com/Meniny/UIActiveableLabel.git', :tag => s.version.to_s }
  s.social_media_url = 'https://meniny.cn'
  # s.screenshot       = ''

  s.swift_version    = "4.0"
  s.ios.deployment_target = '8.0'

  s.source_files     = "UIActiveableLabel/**/*.{h,swift}"

  s.framework        = 'Foundation', 'UIKit'
  s.module_name      = 'UIActiveableLabel'
end
