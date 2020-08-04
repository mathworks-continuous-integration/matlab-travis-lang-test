# matlab-travis-lang-test [![Build Status](https://staging.travis-ci.org/mathworks-continuous-integration/matlab-travis-lang-test.svg?branch=master)](https://staging.travis-ci.org/mathworks-continuous-integration/matlab-travis-lang-test)

Repo for testing continuous integration support for MATLAB using Travis CI.

## How it works:
It all starts with a minimal `.travis.yml` that contains the following code:

```yaml
language: matlab
```

The minimal configuration runs MATLAB tests in the repo (including subfolders) to determine if they all pass.

You also can run custom commands by invoking MATLAB using the `-batch` startup option:
```yaml
language: matlab
script: |
    matlab -batch "disp("Hello, world!")"
```

## See also:
- [Continuous Integration (CI) - MATLAB & Simulink](https://www.mathworks.com/help/matlab/continuous-integration.html)
