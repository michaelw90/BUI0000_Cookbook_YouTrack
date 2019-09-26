name             'cookbook_youtrack'
maintainer       'Fred Thompson'
maintainer_email 'fred.thompson@buildempire.co.uk'
license          'Apache 2.0'
description      'TeamCity and YouTrack on one server.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.20'

recipe 'cookbook_youtrack', 'YouTrack instance.'

%w{ ubuntu }.each do |os|
  supports os
end

%w{build-essential java}.each do |cb|
  depends cb
end
