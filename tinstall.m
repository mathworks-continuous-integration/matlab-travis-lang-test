classdef tinstall < matlab.unittest.TestCase
    properties (TestParameter)
        % This is not the complete list of allow products, it is just a
        % small sample to smoke test license checkout.
        allowed = {'matlab', 'simulink', 'signal_toolbox', 'statistics_toolbox', ...
            'optimization_toolbox', 'symbolic_toolbox', 'image_toolbox', 'control_toolbox', ...
            'signal_blocks', 'curve_fitting_toolbox'}
        restricted = {'rtw_embedded_coder', 'filter_design_hdl_coder', 'gpu_coder', ...
            'simulink_hdl_coder', 'matlab_coder', 'real-time_workshop', 'simulink_plc_coder'}
        example = {'matlab/intro', 'optim/SolveAConstrainedNonlinearProblemProblemBasedExample', ...
            'curvefit/FitPolynomialExample', 'simulink_general/sldemo_bounceExample'}
    end
    
    methods (Test)
        function testCheckoutAllowedLicense(testCase, allowed)
            [status, msg] = license('checkout', allowed);
            testCase.verifyThat(logical(status), IsTrue, msg);
        end
        
        function testFailToCheckoutRestrictedLicense(testCase, restricted)
            status = license('checkout', restricted);
            testCase.verifyThat(logical(status), IsFalse, [restricted ' should not checkout']);
        end
        
        function testRootPathMac(testCase)
            testCase.assumeThat(@ismac, ReturnsTrue, 'Runs only on mac');
            expected = ['/Applications/MATLAB_R'  version('-release') '.app'];
            testCase.verifyThat(matlabroot(), IsEqualTo(expected));
        end
        
        function testRootPathLinux(testCase)
            testCase.assumeThat(@() isunix && ~ismac, ReturnsTrue, 'Runs only on linux');
            expected = ['/usr/local/MATLAB/R' version('-release')];
            testCase.verifyThat(matlabroot(), IsEqualTo(expected));
        end
        function testRootPathWindows(testCase)
            testCase.assumeThat(@ispc, ReturnsTrue, 'Runs only on Windows');
            expected = ['C:\Program Files\MATLAB\R' version('-release')];
            testCase.verifyThat(matlabroot(), IsEqualTo(expected));
        end
        
        function testRunExample(testCase, example)
            meta = findExample(example);
            testCase.applyFixture(PathFixture(meta.componentDir));
            
            startingFigs = findall(groot, 'Type','figure');
            testCase.addTeardown(@() close(setdiff(findall(groot, 'Type','figure'), startingFigs)));
            
            run(fullfile(meta.componentDir, 'main', meta.main));
        end
    end
    
end

% imports
function c = IsEqualTo(varargin)
c = matlab.unittest.constraints.IsEqualTo(varargin{:});
end
function c = IsTrue(varargin)
c = matlab.unittest.constraints.IsTrue(varargin{:});
end
function c = IsFalse(varargin)
c = matlab.unittest.constraints.IsFalse(varargin{:});
end
function c = ReturnsTrue(varargin)
c = matlab.unittest.constraints.ReturnsTrue(varargin{:});
end
function c = PathFixture(varargin)
c = matlab.unittest.fixtures.PathFixture(varargin{:});
end
