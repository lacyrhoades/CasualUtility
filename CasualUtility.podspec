Pod::Spec.new do |s|
  s.name             = "CasualUtility"
  s.version          = "0.9"
  s.summary          = "Swift tools for common tasks"
  s.homepage         = "https://github.com/lacyrhoades/CasualUtility"
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.author           = { "Lacy Rhoades" => "lacy@colordeaf.net" }
  s.source           = { git: "https://github.com/lacyrhoades/CasualUtility.git" }
  s.ios.deployment_target = '10.0'
  s.requires_arc = true
  s.ios.source_files = 'Source/**/*.swift'
  s.exclude_files = 'Source/**/*Test.swift'
end
