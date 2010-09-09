import "default.pp"

include mysql::server
include mongo::server

include rack, mongo::client, xml, freerange

rack::host {"test.hashblue.com":
  content => "hello",
  ensure => disabled
}
