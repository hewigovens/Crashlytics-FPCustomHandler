Pod::Spec.new do |s|
  s.name         = "Crashlytics-FPCustomHandler"
  s.version      = "0.1.0"
  s.summary      = "FPCustomHandler is a category for Crashlytics to allow you run custom NSUncaughtExceptionHandler or signal handler when crash happened."

  s.description  = <<-DESC
  FPCustomHandler is a category for Crashlytics to allow you run custom NSUncaughtExceptionHandler or signal handler when crash happened.
                   DESC

  s.homepage     = "https://github.com/hewigovens/Crashlytics-FPCustomHandler"
  s.license      = "MIT"
  s.author             = { "hewigovens" => "hewigovens@gmail.com" }
  s.social_media_url   = "http://twitter.com/hewigovens"
  s.source       = { :git => "https://github.com/hewigovens/Crashlytics-FPCustomHandler.git", :tag => "#{s.version}" }

  s.source_files  = "src", "src/**/*.{h,m}"
  s.requires_arc = true

  s.dependency "Crashlytics"
end
