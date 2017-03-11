Pod::Spec.new do |s|
  s.name         = "Crashlytics-FPCustomHandler"
  s.version      = "0.1.0"
  s.summary      = "A category for Crashlytics to make your life easier"

  s.description  = <<-DESC
  FPCustomHandler is a category for Crashlytics to allow you run custom NSUncaughtExceptionHandler or signal handler when crash happened.
                   DESC

  s.homepage     = "https://github.com/hewigovens/Crashlytics-FPCustomHandler"
  s.license      = { :type => 'MIT', :text => <<-LICENSE
    Copyright 2014 hewigovens
    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    LICENSE
  }
  s.author             = { "hewigovens" => "hewigovens@gmail.com" }
  s.social_media_url   = "https://twitter.com/hewigovens"
  s.source       = { :git => "https://github.com/hewigovens/Crashlytics-FPCustomHandler.git", :tag => "#{s.version}" }

  s.source_files  = "src", "src/**/*.{h,m}"
  s.requires_arc = true

  s.ios.deployment_target  = '6.0'
  s.osx.deployment_target  = '10.7'
  s.tvos.deployment_target = '9.0'

  s.dependency 'Crashlytics'
end
