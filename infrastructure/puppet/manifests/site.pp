import "hosts/*"
import "classes/*"

stage { [pre, post]: }
Stage[pre] -> Stage[main] -> Stage[post]