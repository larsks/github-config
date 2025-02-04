This repository contains Terraform/[OpenTofu] plan to manage the [innabox] GitHub organization.


[innabox]: https://github.com/innabox
[opentofu]: https://opentofu.org/

## How does it work?

When a commit is pushed to the `main` branch (e.g., when a pull request merges), that triggers the `.github/workflows/apply.yaml` workflow. This workflow acquires necessary credentials from GithHub secrets and from the "Org Config Management" GitHub app, and then uses [OpenTofu] to apply the requested configuration.

## Suggested local pre-commit checks

You should ensure that you run `tofu fmt` before submitting a pull request. The following will configure an appropriate `pre-commit` hook:

```
cat > .git/hooks/pre-commit <<EOF
#!/bin/sh

if ! tofu fmt -check; then
  echo "ERROR: tofu fmt failed" >&2
  tofu fmt -diff
  exit 1
fi
EOF

chmod a+x .git/hooks/pre-commit
```

If there are formatting changes, this will abort the commit and apply the necessary changes to your files. You can then add the modified files and update the commit.

## Prerequisites for applying the configuration

In general, you won't need to do this: the configuration is applied when a pull request merges to the `main` branch. These instructions will be useful if is necessary to apply changes manually (this can happen, for example, if someone makes changes to the organization through the GitHub web UI rather than through this repository).

1. Ensure that you have either Terraform or OpenTofu installed. There are packages for both available on Fedora:

```
dnf install opentofu
```

1. Acquire S3 credentials.

    OpenTofu maintains state information about the target infrastructure; you need this state in order to plan and apply the configuration. We store this information in an S3 bucket provided by the [NERC]. You need appropriate AWS credentials in order for OpenTofu to access the cached state. These should be provided in the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables.

1. Acquire GitHub credentials.

    In order to apply the configuration, OpenTofu needs administrative access to our organization. You will need a token with at least `admin:org` and `repo` privileges for the `innabox` organization. This should be provided in the `GITHUB_TOKEN` environment variable.

[nerc]: https://nerc.mghpcc.org/

## Additional documentation

- OpenTofu [introductory documentation](https://opentofu.org/docs/intro/).

- The OpenTofu [github provider](https://search.opentofu.org/provider/opentofu/github/v6.3.0).

  This includes documentation for most of the resource types used in this repository.
