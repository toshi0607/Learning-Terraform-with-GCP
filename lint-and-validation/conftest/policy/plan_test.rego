package plan

# $ conftest verify
# empty and no_violations idea borrowed from https://github.com/instrumenta/conftest/blob/master/examples/kubernetes/policy/base_test.rego

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

test_google_project_service_with_disable_on_destroy_false_is_allowed {
  input := {
    "resource_changes": [
      {
        "type": "google_project_service",
        "change": {
          "after": {
            "disable_on_destroy": false
          }
        } 
      }
    ]
  }

  no_violations with input as input
}

test_google_project_service_with_disable_on_destroy_true_is_denied {
  input := {
    "resource_changes": [
      {
        "type": "google_project_service",
        "change": {
          "after": {
            "disable_on_destroy": true
          }
        } 
      }
    ]
  }

  violations with input as input
}

test_google_project_iam_member_with_roles_admin_in_non_prod_is_denied {
  input := {
    "resource_changes": [
      {
        "type": "google_project_iam_member",
        "change": {
          "after": {
            "member": "hoge@example.com",
            "project": "hoge-dev",
            "role": "roles/admin"
          }
        } 
      }
    ]
  }

  no_violations with input as input
}

test_google_project_iam_member_with_roles_admin_in_prod_is_denied {
  input := {
    "resource_changes": [
      {
        "type": "google_project_iam_member",
        "change": {
          "after": {
            "member": "hoge@example.com",
            "project": "hoge-prod",
            "role": "roles/admin"
          }
        } 
      }
    ]
  }

  no_violations with input as input
}
