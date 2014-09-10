Pod::Spec.new do |s|
  s.name             = "RCRTimers"
  s.version          = "1.0.0"
  s.summary          = "iOS timers that can be used to run code at regular intervals."
  s.homepage         = "https://github.com/robinsonrc/RCRTimers"
  s.license          = { :type => 'MIT', :file => 'LICENSE'  }
  s.author           = "Rich Robinson"
  s.source           = { :git => "https://github.com/robinsonrc/RCRTimers.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = ['RCRTimers/*.{h,m}']

  s.frameworks = 'Foundation'
end
