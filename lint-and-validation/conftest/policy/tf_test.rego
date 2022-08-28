package tf

empty(value) {
  count(value) == 0
}

non_empty(value) {
  count(value) > 0
}

violations {
  non_empty(deny)
}

no_violations {
  empty(deny)
}

test_provider_with_version_is_denied {
  input := {
    "provider": { { "version": ">= 4.32.0", "region": "somewhere" } }
  }
  violations with input as input
}

test_provider_without_version_is_allowed {
  input := {
    "provider": { { "region": "somewhere" } }
  }
  no_violations with input as input
}
