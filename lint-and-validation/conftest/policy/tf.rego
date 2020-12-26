package tf

deny[msg] {
  p := input.provider[_]
  p.version
  msg := "Provider version must be specified in required_providers block"
}
