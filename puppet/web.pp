import "default.pp"

include rack, mongo::client, xml, freerange

rack::host {"test.hashblue.com":
  content => "hello",
  ensure => disabled
}