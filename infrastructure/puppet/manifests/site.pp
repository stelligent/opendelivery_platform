import "hosts/*"

stage { [pre, post]: }
Stage[pre] -> Stage[main] -> Stage[post]

Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }