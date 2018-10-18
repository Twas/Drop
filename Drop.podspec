Pod::Spec.new do |s|

  s.name         = "Drop"
  s.version      = "1.0.0"
  s.summary      = "Lightweight library to display drop alerts."
  s.homepage     = "https://github.com/Twas/Drop"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Evgeniy Leychenko" => "leychenkoev@gmail.com" }
  s.social_media_url   = "https://twitter.com/EugeneLeychenko"

  s.platform     = :ios
  s.swift_version = "4.2"
  s.ios.deployment_target = '10.0'
  s.framework  = "UIKit"
  s.requires_arc = true

  s.source       = { :git => "https://github.com/Twas/Drop.git", :tag => "#{s.version}" }
  s.source_files  = "Drop/**/*.{swift}"

end
