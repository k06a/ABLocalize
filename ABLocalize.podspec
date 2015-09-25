Pod::Spec.new do |s|
  s.name         = "ABLocalize"
  s.version      = "0.0.1"
  s.summary      = "Some localization tricks to support multiple targets"

  s.description  = <<-DESC
                   You can develop several similar apps in one project by dividing them
                   by different targets. With this library you can vary texts by tagging them like this: `NSLocalizedString(@"LOGIN_INVITATION#APP1", @"")` and `NSLocalizedString(@"LOGIN_INVITATION#APP2", @"")`. Works even for localized storyboard strings.
                   DESC

  s.homepage     = "https://github.com/k06a/ABLocalize"
  s.license      = "MIT"
  s.author       = { "Anton Bukov" => "k06aaa@gmail.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/k06a/ABLocalize.git", :tag => "#{s.version}" }
  s.source_files = "Classes", "*.{h,m}"
  s.requires_arc = true
  s.dependency 'JRSwizzle'
end
