#!/bin/bash

tofu apply -concise -auto-approve -no-color > apply.out 2> apply.err
exitcode=$?

echo "::group::stdout"
cat apply.out
echo "::endgroup::"

echo "::group::stderr"
cat apply.err
echo "::endgroup::"

if grep -q 'Apply complete' apply.out; then
  message=$(grep 'Apply complete' apply.out)
  echo "::notice title=Apply complete::$message"
elif grep -q 'Error:' apply.err; then
  message=$(sed -n '/Error:/,$p' apply.err | sed -z 's/\n/%0A/g')
  echo "::error title=Apply failed::$message"
fi

exit "$exitcode"
