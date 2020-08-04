# matlab-travis-lang-test [![Build Status](https://staging.travis-ci.org/mathworks-continuous-integration/matlab-travis-lang-test.svg?branch=master)](https://staging.travis-ci.org/mathworks-continuous-integration/matlab-travis-lang-test)

Repo for testing continuous integration support for MATLAB using Travis CI.

## MATLAB? Using Travis CI?
Indeed! It all starts with a minimal `.travis.yml` that looks like the following:

```yaml
language: matlab
```

The minimal configuration will run MATLAB tests in the repo (including subfolders) to determine if they all pass.

MATLAB can also be invoked directly if custom commands are desired:
```yaml
language: matlab
script: |
    matlab -batch "disp("Hello, world!")"
```
_Invoke MATLAB using the '-batch' startup flag when running CI jobs_

## See also:
- [Continuous Integration (CI) - MATLAB & Simulink](https://www.mathworks.com/help/matlab/continuous-integration.html)
